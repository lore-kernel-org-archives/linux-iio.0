Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36626 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754177AbcJRTnR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Oct 2016 15:43:17 -0400
Received: by mail-qk0-f196.google.com with SMTP id z190so291913qkc.3
        for <linux-iio@vger.kernel.org>; Tue, 18 Oct 2016 12:43:17 -0700 (PDT)
Date: Tue, 18 Oct 2016 17:43:12 -0200
From: Juliana Rodrigues <juliana.orod@gmail.com>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: outreachy-kernel@googlegroups.com, lars@metafoo.de,
        jic23@kernel.org, knaack.h@gmx.de, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_mpu6050: implemented
 IIO_CHAN_INFO_SAMP_FREQ
Message-ID: <20161018194312.GB11725@spock>
References: <20161014022043.GA8114@spock>
 <alpine.DEB.2.02.1610172316480.31400@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1610172316480.31400@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Oct 17, 2016 at 11:27:11PM +0200, Peter Meerwald-Stadler wrote:
> 
> > Moved functionality from IIO_DEV_ATTR_SAMP_FREQ macro into
> > IIO_CHAN_INFO_SAMP_FREQ in order to create a generic attribute.
> > Modified inv_mpu6050_read_raw and inv_mpu6050_write_raw to allow
> > reading and writing the element.
> 
> comments below

Hi Peter,

Lots of typos! I'll send a patchset to fix these also. Thank you for
taking your time to comment on this. 

Juliana

>  
> > Signed-off-by: Juliana Rodrigues <juliana.orod@gmail.com>
> > ---
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 187 ++++++++++++++---------------
> >  1 file changed, 92 insertions(+), 95 deletions(-)
> > 
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > index b9fcbf1..20722c8 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > @@ -263,6 +263,88 @@ static int inv_mpu6050_sensor_set(struct inv_mpu6050_state  *st, int reg,
> >  	return 0;
> >  }
> >  
> > +/**
> > + *  inv_mpu6050_set_lpf() - set low pass filer based on fifo rate.
> 
> filter
> 
> > + *
> > + *                  Based on the Nyquist principle, the sampling rate must
> > + *                  exceed twice of the bandwidth of the signal, or there
> > + *                  would be alising. This function basically search for the
> 
> will be
> searches
> 
> > + *                  correct low pass parameters based on the fifo rate, e.g,
> 
> e.g.
> but maybe it should be rather i.e.
> 
> > + *                  sampling frequency.
> > + */
> > +static int inv_mpu6050_set_lpf(struct inv_mpu6050_state *st, int rate)
> > +{
> > +	const int hz[] = {188, 98, 42, 20, 10, 5};
> > +	const int d[] = {INV_MPU6050_FILTER_188HZ, INV_MPU6050_FILTER_98HZ,
> > +			INV_MPU6050_FILTER_42HZ, INV_MPU6050_FILTER_20HZ,
> > +			INV_MPU6050_FILTER_10HZ, INV_MPU6050_FILTER_5HZ};
> 
> it is not/only somewhat obvious that hz and d must have the same number of 
> entries, could use a #define to make that clear (and could be used 
> instead of ARRAY_SIZE)
> 
> > +	int i, h, result;
> > +	u8 data;
> > +
> > +	h = (rate >> 1);
> > +	i = 0;
> 
> i, h could be unsigned
> can't we use initialization instead of assignment to save some lines?
> 
> > +	while ((h < hz[i]) && (i < ARRAY_SIZE(d) - 1))
> > +		i++;
> > +	data = d[i];
> > +	result = regmap_write(st->map, st->reg->lpf, data);
> > +	if (result)
> > +		return result;
> > +	st->chip_config.lpf = data;
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * inv_mpu6050_write_raw_samp_freq() - Set current raw sampling rate.
> 
> frequency is not the same as rate
> 
> > + */
> > +static int inv_mpu6050_write_raw_samp_freq(struct iio_dev *indio_dev,
> > +					   struct inv_mpu6050_state *st,
> > +					   int val) {
> > +
> > +	u8 d;
> > +	int result;
> > +
> > +	if (val < INV_MPU6050_MIN_FIFO_RATE || val > INV_MPU6050_MAX_FIFO_RATE)
> > +		return -EINVAL;
> > +	if (val == st->chip_config.fifo_rate)
> > +		return 0;
> > +
> > +	mutex_lock(&indio_dev->mlock);
> > +	if (st->chip_config.enable) {
> > +		result = -EBUSY;
> > +		goto fifo_rate_fail;
> > +	}
> > +
> > +	result = inv_mpu6050_set_power_itg(st, true);
> > +	if (result)
> > +		goto fifo_rate_fail;
> > +
> > +	d = INV_MPU6050_ONE_K_HZ / val - 1;
> > +
> > +	result = regmap_write(st->map, st->reg->sample_rate_div, d);
> > +
> 
> drop newline
> 
> > +	if (result)
> > +		goto fifo_rate_fail;
> > +
> > +	st->chip_config.fifo_rate = val;
> > +
> > +	result = inv_mpu6050_set_lpf(st, val);
> > +
> 
> drop newline
> 
> > +	if (result)
> > +		goto fifo_rate_fail;
> > +
> > +fifo_rate_fail:
> > +	result |= inv_mpu6050_set_power_itg(st, false);
> > +	mutex_unlock(&indio_dev->mlock);
> > +
> 
> just
> return result;
> 
> > +	if (result)
> > +		return result;
> > +
> > +	return 0;
> > +
> > +}
> > +
> > +
> >  static int inv_mpu6050_sensor_show(struct inv_mpu6050_state  *st, int reg,
> >  				   int axis, int *val)
> >  {
> > @@ -399,6 +481,10 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
> >  		default:
> >  			return -EINVAL;
> >  		}
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		*val = st->chip_config.fifo_rate;
> > +
> > +		return IIO_VAL_INT;
> >  	default:
> >  		return -EINVAL;
> >  	}
> > @@ -511,6 +597,10 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
> >  		default:
> >  			result = -EINVAL;
> >  		}
> > +		break;
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		result = inv_mpu6050_write_raw_samp_freq(indio_dev, st, val);
> > +		break;
> >  	default:
> >  		result = -EINVAL;
> >  		break;
> > @@ -524,98 +614,6 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
> >  }
> >  
> >  /**
> > - *  inv_mpu6050_set_lpf() - set low pass filer based on fifo rate.
> > - *
> > - *                  Based on the Nyquist principle, the sampling rate must
> > - *                  exceed twice of the bandwidth of the signal, or there
> > - *                  would be alising. This function basically search for the
> > - *                  correct low pass parameters based on the fifo rate, e.g,
> > - *                  sampling frequency.
> > - */
> > -static int inv_mpu6050_set_lpf(struct inv_mpu6050_state *st, int rate)
> > -{
> > -	const int hz[] = {188, 98, 42, 20, 10, 5};
> > -	const int d[] = {INV_MPU6050_FILTER_188HZ, INV_MPU6050_FILTER_98HZ,
> > -			INV_MPU6050_FILTER_42HZ, INV_MPU6050_FILTER_20HZ,
> > -			INV_MPU6050_FILTER_10HZ, INV_MPU6050_FILTER_5HZ};
> > -	int i, h, result;
> > -	u8 data;
> > -
> > -	h = (rate >> 1);
> > -	i = 0;
> > -	while ((h < hz[i]) && (i < ARRAY_SIZE(d) - 1))
> > -		i++;
> > -	data = d[i];
> > -	result = regmap_write(st->map, st->reg->lpf, data);
> > -	if (result)
> > -		return result;
> > -	st->chip_config.lpf = data;
> > -
> > -	return 0;
> > -}
> > -
> > -/**
> > - * inv_mpu6050_fifo_rate_store() - Set fifo rate.
> > - */
> > -static ssize_t
> > -inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
> > -			    const char *buf, size_t count)
> > -{
> > -	s32 fifo_rate;
> > -	u8 d;
> > -	int result;
> > -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > -	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> > -
> > -	if (kstrtoint(buf, 10, &fifo_rate))
> > -		return -EINVAL;
> > -	if (fifo_rate < INV_MPU6050_MIN_FIFO_RATE ||
> > -	    fifo_rate > INV_MPU6050_MAX_FIFO_RATE)
> > -		return -EINVAL;
> > -	if (fifo_rate == st->chip_config.fifo_rate)
> > -		return count;
> > -
> > -	mutex_lock(&indio_dev->mlock);
> > -	if (st->chip_config.enable) {
> > -		result = -EBUSY;
> > -		goto fifo_rate_fail;
> > -	}
> > -	result = inv_mpu6050_set_power_itg(st, true);
> > -	if (result)
> > -		goto fifo_rate_fail;
> > -
> > -	d = INV_MPU6050_ONE_K_HZ / fifo_rate - 1;
> > -	result = regmap_write(st->map, st->reg->sample_rate_div, d);
> > -	if (result)
> > -		goto fifo_rate_fail;
> > -	st->chip_config.fifo_rate = fifo_rate;
> > -
> > -	result = inv_mpu6050_set_lpf(st, fifo_rate);
> > -	if (result)
> > -		goto fifo_rate_fail;
> > -
> > -fifo_rate_fail:
> > -	result |= inv_mpu6050_set_power_itg(st, false);
> > -	mutex_unlock(&indio_dev->mlock);
> > -	if (result)
> > -		return result;
> > -
> > -	return count;
> > -}
> > -
> > -/**
> > - * inv_fifo_rate_show() - Get the current sampling rate.
> > - */
> > -static ssize_t
> > -inv_fifo_rate_show(struct device *dev, struct device_attribute *attr,
> > -		   char *buf)
> > -{
> > -	struct inv_mpu6050_state *st = iio_priv(dev_to_iio_dev(dev));
> > -
> > -	return sprintf(buf, "%d\n", st->chip_config.fifo_rate);
> > -}
> > -
> > -/**
> >   * inv_attr_show() - calling this function will show current
> >   *                    parameters.
> >   *
> > @@ -686,6 +684,7 @@ static const struct iio_chan_spec_ext_info inv_ext_info[] = {
> >  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
> >  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	      \
> >  				      BIT(IIO_CHAN_INFO_CALIBBIAS),   \
> > +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> >  		.scan_index = _index,                                 \
> >  		.scan_type = {                                        \
> >  				.sign = 's',                          \
> > @@ -708,6 +707,7 @@ static const struct iio_chan_spec inv_mpu_channels[] = {
> >  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
> >  				| BIT(IIO_CHAN_INFO_OFFSET)
> >  				| BIT(IIO_CHAN_INFO_SCALE),
> > +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> >  		.scan_index = -1,
> >  	},
> >  	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_MPU6050_SCAN_GYRO_X),
> > @@ -725,8 +725,6 @@ static IIO_CONST_ATTR(in_anglvel_scale_available,
> >  					  "0.000133090 0.000266181 0.000532362 0.001064724");
> >  static IIO_CONST_ATTR(in_accel_scale_available,
> >  					  "0.000598 0.001196 0.002392 0.004785");
> > -static IIO_DEV_ATTR_SAMP_FREQ(S_IRUGO | S_IWUSR, inv_fifo_rate_show,
> > -	inv_mpu6050_fifo_rate_store);
> >  
> >  /* Deprecated: kept for userspace backward compatibility. */
> >  static IIO_DEVICE_ATTR(in_gyro_matrix, S_IRUGO, inv_attr_show, NULL,
> > @@ -737,7 +735,6 @@ static IIO_DEVICE_ATTR(in_accel_matrix, S_IRUGO, inv_attr_show, NULL,
> >  static struct attribute *inv_attributes[] = {
> >  	&iio_dev_attr_in_gyro_matrix.dev_attr.attr,  /* deprecated */
> >  	&iio_dev_attr_in_accel_matrix.dev_attr.attr, /* deprecated */
> > -	&iio_dev_attr_sampling_frequency.dev_attr.attr,
> >  	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> >  	&iio_const_attr_in_accel_scale_available.dev_attr.attr,
> >  	&iio_const_attr_in_anglvel_scale_available.dev_attr.attr,
> > 
> 
> -- 
> 
> Peter Meerwald-Stadler
> +43-664-2444418 (mobile)
