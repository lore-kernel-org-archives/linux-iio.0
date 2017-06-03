Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751077AbdFCIJ1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Jun 2017 04:09:27 -0400
Date: Sat, 3 Jun 2017 09:09:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: imu: inv_mpu6050: fix lock and error path
 multiple  issues
Message-ID: <20170603090916.729537bc@jic23.retrosnub.co.uk>
In-Reply-To: <CY1PR12MB06661CC158DECAFDE14B1597C4F70@CY1PR12MB0666.namprd12.prod.outlook.com>
References: <CY1PR12MB06661CC158DECAFDE14B1597C4F70@CY1PR12MB0666.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 2 Jun 2017 16:21:31 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> There are several locks issues when using buffer and direct polling
> data at the same time. Use our own mutex for managing locking and
> block simultaneous use of buffer and direct polling by using
> iio_device_{claim/release}_direct_mode. This makes chip_config
> enable bit obsolete, so delete it.
> Replace sprint by more correct scnprintf.
> Fix error code paths, this solves the bug that chaning the sampling
> frequency while buffer is on is returning -EBUSY but power off the
> chip and block all incoming data.
Hi Jean-Baptiste,

A few bits and pieces inline.  Most are centred around breaking the
patch down further.  In particular I'd like the actual fix and that
alone in the first patch in the series. It's potentially something we
want to send for stable inclusion.  For that it needs to be fairly
minimal.  Having white space cleanups etc in there is not going
to encourage the stable maintainers to pick it up.

It's still going to be a fairly large change, so we may need to
wait for a merge cycle and then ask for it to be applied after
inclusion in mainline.

Anyhow, certainly a lot easier to follow after your changes!

I did highlight a few other weird corners I noticed whilst
reviewing these.  If you'd like to do additional patches to
clean those up (in particularly the weird exit labels case)
that would be great.

Jonathan
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 152 ++++++++++++++------------
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     |   8 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |   5 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |   6 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  34 ++++--
>  5 files changed, 118 insertions(+), 87 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 96dabbd..5a0db5a 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -187,7 +187,6 @@ int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on)
>  	int result = 0;
>  
>  	if (power_on) {
> -		/* Already under indio-dev->mlock mutex */
>  		if (!st->powerup_count)
>  			result = regmap_write(st->map, st->reg->pwr_mgmt_1, 0);
>  		if (!result)
> @@ -289,7 +288,7 @@ static int inv_mpu6050_sensor_show(struct inv_mpu6050_state  *st, int reg,
This had me briefly confused as this code was clearly part of the read_raw function.
The reason is the presumably the odd formatting of that function definition.
Would you mind cleaning that up as well whilst you are here (as a separate patch or
maybe lumped in with the whitespace fixes).
>  		     struct iio_chan_spec const *chan,
>  		     int *val, int *val2, long mask)
>  {
> -	struct inv_mpu6050_state  *st = iio_priv(indio_dev);
> +	struct inv_mpu6050_state *st = iio_priv(indio_dev);
Good to tidy this up, but not in a fix patch.
>  	int ret = 0;
>  
>  	switch (mask) {
> @@ -298,50 +297,37 @@ static int inv_mpu6050_sensor_show(struct inv_mpu6050_state  *st, int reg,
>  		int result;
>  
>  		ret = IIO_VAL_INT;
> -		result = 0;
> -		mutex_lock(&indio_dev->mlock);
> -		if (!st->chip_config.enable) {
> -			result = inv_mpu6050_set_power_itg(st, true);
> -			if (result)
> -				goto error_read_raw;
> -		}
> -		/* when enable is on, power is already on */
> +		mutex_lock(&st->lock);
> +		result = iio_device_claim_direct_mode(indio_dev);
> +		if (result)
> +			goto error_read_raw_unlock;
> +		result = inv_mpu6050_set_power_itg(st, true);
> +		if (result)
> +			goto error_read_raw_release;
>  		switch (chan->type) {
>  		case IIO_ANGL_VEL:
> -			if (!st->chip_config.gyro_fifo_enable ||
> -			    !st->chip_config.enable) {
> -				result = inv_mpu6050_switch_engine(st, true,
> +			result = inv_mpu6050_switch_engine(st, true,
>  						INV_MPU6050_BIT_PWR_GYRO_STBY);
> -				if (result)
> -					goto error_read_raw;
> -			}
> +			if (result)
> +				goto error_read_raw_power_off;
>  			ret = inv_mpu6050_sensor_show(st, st->reg->raw_gyro,
>  						      chan->channel2, val);
> -			if (!st->chip_config.gyro_fifo_enable ||
> -			    !st->chip_config.enable) {
> -				result = inv_mpu6050_switch_engine(st, false,
> +			result = inv_mpu6050_switch_engine(st, false,
>  						INV_MPU6050_BIT_PWR_GYRO_STBY);
> -				if (result)
> -					goto error_read_raw;
> -			}
> +			if (result)
> +				goto error_read_raw_power_off;
>  			break;
>  		case IIO_ACCEL:
> -			if (!st->chip_config.accl_fifo_enable ||
> -			    !st->chip_config.enable) {
> -				result = inv_mpu6050_switch_engine(st, true,
> +			result = inv_mpu6050_switch_engine(st, true,
>  						INV_MPU6050_BIT_PWR_ACCL_STBY);
> -				if (result)
> -					goto error_read_raw;
> -			}
> +			if (result)
> +				goto error_read_raw_power_off;
>  			ret = inv_mpu6050_sensor_show(st, st->reg->raw_accl,
>  						      chan->channel2, val);
> -			if (!st->chip_config.accl_fifo_enable ||
> -			    !st->chip_config.enable) {
> -				result = inv_mpu6050_switch_engine(st, false,
> +			result = inv_mpu6050_switch_engine(st, false,
>  						INV_MPU6050_BIT_PWR_ACCL_STBY);
> -				if (result)
> -					goto error_read_raw;
> -			}
> +			if (result)
> +				goto error_read_raw_power_off;
>  			break;
>  		case IIO_TEMP:
>  			/* wait for stablization */
> @@ -353,10 +339,12 @@ static int inv_mpu6050_sensor_show(struct inv_mpu6050_state  *st, int reg,
>  			ret = -EINVAL;
>  			break;
>  		}
I wonder a little if the code flow in this function could be improved
by pulling the contents of the various case statements where there
is lots going on, out into additional functions.  It all feels a bit
deeply nested and the additional locking serves to emphasise that.

> -error_read_raw:
> -		if (!st->chip_config.enable)
> -			result |= inv_mpu6050_set_power_itg(st, false);
> -		mutex_unlock(&indio_dev->mlock);
> +error_read_raw_power_off:
> +		result |= inv_mpu6050_set_power_itg(st, false);
> +error_read_raw_release:
> +		iio_device_release_direct_mode(indio_dev);
> +error_read_raw_unlock:
> +		mutex_unlock(&st->lock);
>  		if (result)
>  			return result;
>  
> @@ -367,17 +355,14 @@ static int inv_mpu6050_sensor_show(struct inv_mpu6050_state  *st, int reg,
>  		case IIO_ANGL_VEL:
>  			*val  = 0;
>  			*val2 = gyro_scale_6050[st->chip_config.fsr];
> -
These changes aren't particularly beneficial, they are just adding noise to the patch.
Also, if it does make sense to change this whitespace, it should occur in a separate
patch.
>  			return IIO_VAL_INT_PLUS_NANO;
>  		case IIO_ACCEL:
>  			*val = 0;
>  			*val2 = accel_scale[st->chip_config.accl_fs];
> -
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_TEMP:
>  			*val = 0;
>  			*val2 = INV_MPU6050_TEMP_SCALE;
> -
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		default:
>  			return -EINVAL;
> @@ -386,7 +371,6 @@ static int inv_mpu6050_sensor_show(struct inv_mpu6050_state  *st, int reg,
>  		switch (chan->type) {
>  		case IIO_TEMP:
>  			*val = INV_MPU6050_TEMP_OFFSET;
> -
>  			return IIO_VAL_INT;
>  		default:
>  			return -EINVAL;
> @@ -394,14 +378,17 @@ static int inv_mpu6050_sensor_show(struct inv_mpu6050_state  *st, int reg,
>  	case IIO_CHAN_INFO_CALIBBIAS:
>  		switch (chan->type) {
>  		case IIO_ANGL_VEL:
> +			mutex_lock(&st->lock);
>  			ret = inv_mpu6050_sensor_show(st, st->reg->gyro_offset,
>  						chan->channel2, val);
> +			mutex_unlock(&st->lock);
>  			return IIO_VAL_INT;
>  		case IIO_ACCEL:
> +			mutex_lock(&st->lock);
>  			ret = inv_mpu6050_sensor_show(st, st->reg->accl_offset,
>  						chan->channel2, val);
> +			mutex_unlock(&st->lock);
>  			return IIO_VAL_INT;
> -
>  		default:
>  			return -EINVAL;
>  		}
> @@ -475,18 +462,18 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
>  	struct inv_mpu6050_state  *st = iio_priv(indio_dev);
>  	int result;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	/*
>  	 * we should only update scale when the chip is disabled, i.e.
>  	 * not running
>  	 */
> -	if (st->chip_config.enable) {
> -		result = -EBUSY;
> -		goto error_write_raw;
> -	}
> +	result = iio_device_claim_direct_mode(indio_dev);
> +	if (result)
> +		goto error_write_raw_unlock;
> +
>  	result = inv_mpu6050_set_power_itg(st, true);
>  	if (result)
> -		goto error_write_raw;
> +		goto error_write_raw_release;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
> @@ -522,9 +509,11 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
>  		break;
>  	}
>  
> -error_write_raw:
>  	result |= inv_mpu6050_set_power_itg(st, false);
> -	mutex_unlock(&indio_dev->mlock);
> +error_write_raw_release:
> +	iio_device_release_direct_mode(indio_dev);
> +error_write_raw_unlock:
> +	mutex_unlock(&st->lock);
>  
>  	return result;
>  }
> @@ -578,31 +567,37 @@ static int inv_mpu6050_set_lpf(struct inv_mpu6050_state *st, int rate)
>  	if (fifo_rate < INV_MPU6050_MIN_FIFO_RATE ||
>  	    fifo_rate > INV_MPU6050_MAX_FIFO_RATE)
>  		return -EINVAL;
> -	if (fifo_rate == st->chip_config.fifo_rate)
> -		return count;
>  
> -	mutex_lock(&indio_dev->mlock);
> -	if (st->chip_config.enable) {
> -		result = -EBUSY;
> -		goto fifo_rate_fail;
> +	mutex_lock(&st->lock);
> +
> +	if (fifo_rate == st->chip_config.fifo_rate) {
> +		result = 0;
> +		goto fifo_rate_unlock;
>  	}
> +	result = iio_device_claim_direct_mode(indio_dev);
> +	if (result)
> +		goto fifo_rate_unlock;
> +
>  	result = inv_mpu6050_set_power_itg(st, true);
>  	if (result)
> -		goto fifo_rate_fail;
> +		goto fifo_rate_release;
>  
>  	d = INV_MPU6050_ONE_K_HZ / fifo_rate - 1;
>  	result = regmap_write(st->map, st->reg->sample_rate_div, d);
>  	if (result)
> -		goto fifo_rate_fail;
> +		goto fifo_rate_power_off;
>  	st->chip_config.fifo_rate = fifo_rate;
>  
>  	result = inv_mpu6050_set_lpf(st, fifo_rate);
>  	if (result)
> -		goto fifo_rate_fail;
> +		goto fifo_rate_power_off;
>  
> -fifo_rate_fail:
> +fifo_rate_power_off:
>  	result |= inv_mpu6050_set_power_itg(st, false);
> -	mutex_unlock(&indio_dev->mlock);
> +fifo_rate_release:
> +	iio_device_release_direct_mode(indio_dev);
> +fifo_rate_unlock:
> +	mutex_unlock(&st->lock);
>  	if (result)
>  		return result;
>  
> @@ -617,8 +612,13 @@ static int inv_mpu6050_set_lpf(struct inv_mpu6050_state *st, int rate)
>  		   char *buf)
>  {
>  	struct inv_mpu6050_state *st = iio_priv(dev_to_iio_dev(dev));
> +	unsigned fifo_rate;
>  
> -	return sprintf(buf, "%d\n", st->chip_config.fifo_rate);
> +	mutex_lock(&st->lock);
> +	fifo_rate = st->chip_config.fifo_rate;
> +	mutex_unlock(&st->lock);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%u\n", fifo_rate);
>  }
>  
>  /**
> @@ -644,8 +644,8 @@ static ssize_t inv_attr_show(struct device *dev, struct device_attribute *attr,
>  	case ATTR_GYRO_MATRIX:
>  	case ATTR_ACCL_MATRIX:
>  		m = st->plat_data.orientation;
> -
> -		return sprintf(buf, "%d, %d, %d; %d, %d, %d; %d, %d, %d\n",
> +		return scnprintf(buf, PAGE_SIZE,
> +			"%d, %d, %d; %d, %d, %d; %d, %d, %d\n",
A reasonable change, but not part of the main purpose of this patch so
should be on it's own.
>  			m[0], m[1], m[2], m[3], m[4], m[5], m[6], m[7], m[8]);
>  	default:
>  		return -EINVAL;
> @@ -836,6 +836,7 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  		return -ENODEV;
>  	}
>  	st = iio_priv(indio_dev);
> +	mutex_init(&st->lock);
>  	st->chip_type = chip_type;
>  	st->powerup_count = 0;
>  	st->irq = irq;
> @@ -926,15 +927,30 @@ int inv_mpu_core_remove(struct device  *dev)
>  EXPORT_SYMBOL_GPL(inv_mpu_core_remove);
>  
>  #ifdef CONFIG_PM_SLEEP
> -
Please have any whitespace cleanups in a separate patch.
>  static int inv_mpu_resume(struct device *dev)
>  {
> -	return inv_mpu6050_set_power_itg(iio_priv(dev_get_drvdata(dev)), true);
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> +	int result;
> +
> +	mutex_lock(&st->lock);
> +	result = inv_mpu6050_set_power_itg(st, true);
> +	mutex_unlock(&st->lock);
> +
> +	return result;
>  }
>  
>  static int inv_mpu_suspend(struct device *dev)
>  {
> -	return inv_mpu6050_set_power_itg(iio_priv(dev_get_drvdata(dev)), false);
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct inv_mpu6050_state *st = iio_priv(indio_dev);
It's not a huge thing, but you could save a line via
struct inv_mpu6050_state *st = iio_priv(dev_get_drvdata(dev));
without losing much in the way of readability.
> +	int result;
> +
> +	mutex_lock(&st->lock);
> +	result = inv_mpu6050_set_power_itg(st, false);
> +	mutex_unlock(&st->lock);
> +
> +	return result;
>  }
>  #endif /* CONFIG_PM_SLEEP */
>  
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> index 64b5f5b..fcd7a92 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> @@ -32,7 +32,7 @@ static int inv_mpu6050_select_bypass(struct i2c_mux_core *muxc, u32 chan_id)
>  	int ret = 0;
>  
>  	/* Use the same mutex which was used everywhere to protect power-op */
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	if (!st->powerup_count) {
>  		ret = regmap_write(st->map, st->reg->pwr_mgmt_1, 0);
>  		if (ret)
> @@ -48,7 +48,7 @@ static int inv_mpu6050_select_bypass(struct i2c_mux_core *muxc, u32 chan_id)
>  				   INV_MPU6050_BIT_BYPASS_EN);
>  	}
>  write_error:
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return ret;
>  }
> @@ -58,14 +58,14 @@ static int inv_mpu6050_deselect_bypass(struct i2c_mux_core *muxc, u32 chan_id)
>  	struct iio_dev *indio_dev = i2c_mux_priv(muxc);
>  	struct inv_mpu6050_state *st = iio_priv(indio_dev);
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	/* It doesn't really mattter, if any of the calls fails */
>  	regmap_write(st->map, st->reg->int_pin_cfg, INV_MPU6050_INT_PIN_CFG);
>  	st->powerup_count--;
>  	if (!st->powerup_count)
>  		regmap_write(st->map, st->reg->pwr_mgmt_1,
>  			     INV_MPU6050_BIT_SLEEP);
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return 0;
>  }
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index ef13de7..713fa7b 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -14,6 +14,7 @@
>  #include <linux/i2c-mux.h>
>  #include <linux/kfifo.h>
>  #include <linux/spinlock.h>
> +#include <linux/mutex.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/regmap.h>
> @@ -80,7 +81,6 @@ enum inv_devices {
>   *  @fsr:		Full scale range.
>   *  @lpf:		Digital low pass filter frequency.
>   *  @accl_fs:		accel full scale range.
> - *  @enable:		master enable state.
>   *  @accl_fifo_enable:	enable accel data output
>   *  @gyro_fifo_enable:	enable gyro data output
>   *  @fifo_rate:		FIFO update rate.
> @@ -89,7 +89,6 @@ struct inv_mpu6050_chip_config {
>  	unsigned int fsr:2;
>  	unsigned int lpf:3;
>  	unsigned int accl_fs:2;
> -	unsigned int enable:1;
>  	unsigned int accl_fifo_enable:1;
>  	unsigned int gyro_fifo_enable:1;
>  	u16 fifo_rate;
> @@ -112,6 +111,7 @@ struct inv_mpu6050_hw {
>  /*
>   *  struct inv_mpu6050_state - Driver state variables.
>   *  @TIMESTAMP_FIFO_SIZE: fifo size for timestamp.
> + *  @lock:              Chip access lock.
>   *  @trig:              IIO trigger.
>   *  @chip_config:	Cached attribute information.
>   *  @reg:		Map of important registers.
> @@ -126,6 +126,7 @@ struct inv_mpu6050_hw {
>   */
>  struct inv_mpu6050_state {
>  #define TIMESTAMP_FIFO_SIZE 16
> +	struct mutex lock;
>  	struct iio_trigger  *trig;
>  	struct inv_mpu6050_chip_config chip_config;
>  	const struct inv_mpu6050_reg_map *reg;
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> index 3a9f3ea..ff81c6a 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -128,7 +128,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  	u16 fifo_count;
>  	s64 timestamp;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	if (!(st->chip_config.accl_fifo_enable |
>  		st->chip_config.gyro_fifo_enable))
>  		goto end_session;
> @@ -178,7 +178,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  	}
This double error path unlocking made me wonder what was going on.
Anyhow, taking a look at the code, the flow is rather odd.

end_session:
	mutex_unlock(&indio_dev->mlock);
	iio_trigger_notify_done(indio_dev->trig);

	return IRQ_HANDLED;

flush_fifo:
	/* Flush HW and SW FIFOs. */
	inv_reset_fifo(indio_dev);
	mutex_unlock(&indio_dev->mlock);
	iio_trigger_notify_done(indio_dev->trig);

	return IRQ_HANDLED;

How about an additional patch to just put the end_session label after
the inv_reset_fifo and do the error handling in a more conventional way?
I'm guessing there was something else going on there originally that
is no longer present.
>  
>  end_session:
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  	iio_trigger_notify_done(indio_dev->trig);
>  
>  	return IRQ_HANDLED;
> @@ -186,7 +186,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  flush_fifo:
>  	/* Flush HW and SW FIFOs. */
>  	inv_reset_fifo(indio_dev);
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  	iio_trigger_notify_done(indio_dev->trig);
>  
>  	return IRQ_HANDLED;
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> index e8818d4..85c2732 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -53,46 +53,52 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
>  			result = inv_mpu6050_switch_engine(st, true,
>  					INV_MPU6050_BIT_PWR_GYRO_STBY);
>  			if (result)
> -				return result;
> +				goto error_power_off;
This appears to be a separate issue from the locking fix.
Please break it out into a separate patch.

(code looks right to me, just a process issue!)
>  		}
>  		if (st->chip_config.accl_fifo_enable) {
>  			result = inv_mpu6050_switch_engine(st, true,
>  					INV_MPU6050_BIT_PWR_ACCL_STBY);
>  			if (result)
> -				return result;
> +				goto error_power_off;
>  		}
>  		result = inv_reset_fifo(indio_dev);
>  		if (result)
> -			return result;
> +			goto error_power_off;
>  	} else {
>  		result = regmap_write(st->map, st->reg->fifo_en, 0);
>  		if (result)
> -			return result;
> +			goto error_power_off;
>  
>  		result = regmap_write(st->map, st->reg->int_enable, 0);
>  		if (result)
> -			return result;
> +			goto error_power_off;
>  
>  		result = regmap_write(st->map, st->reg->user_ctrl, 0);
>  		if (result)
> -			return result;
> +			goto error_power_off;
>  
>  		result = inv_mpu6050_switch_engine(st, false,
>  					INV_MPU6050_BIT_PWR_GYRO_STBY);
>  		if (result)
> -			return result;
> +			goto error_power_off;
> +		st->chip_config.gyro_fifo_enable = false;
>  
>  		result = inv_mpu6050_switch_engine(st, false,
>  					INV_MPU6050_BIT_PWR_ACCL_STBY);
>  		if (result)
> -			return result;
> +			goto error_power_off;
> +		st->chip_config.accl_fifo_enable = false;
> +
>  		result = inv_mpu6050_set_power_itg(st, false);
>  		if (result)
>  			return result;
>  	}
> -	st->chip_config.enable = enable;
>  
>  	return 0;
> +
> +error_power_off:
> +	inv_mpu6050_set_power_itg(st, false);
> +	return result;
>  }
>  
>  /**
> @@ -103,7 +109,15 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
>  static int inv_mpu_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  					      bool state)
>  {
> -	return inv_mpu6050_set_enable(iio_trigger_get_drvdata(trig), state);
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> +	int result;
> +
> +	mutex_lock(&st->lock);
> +	result = inv_mpu6050_set_enable(indio_dev, state);
> +	mutex_unlock(&st->lock);
> +
> +	return result;
>  }
>  
>  static const struct iio_trigger_ops inv_mpu_trigger_ops = {

