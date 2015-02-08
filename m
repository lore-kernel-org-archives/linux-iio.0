Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38955 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595AbbBHL0h (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Feb 2015 06:26:37 -0500
Message-ID: <54D747E8.6060408@kernel.org>
Date: Sun, 08 Feb 2015 11:26:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Octavian Purdila <octavian.purdila@intel.com>,
	linux-iio@vger.kernel.org
CC: srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH v3 9/9] iio: bmc150: add support for hardware fifo
References: <1422662408-8149-1-git-send-email-octavian.purdila@intel.com> <1422662408-8149-10-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1422662408-8149-10-git-send-email-octavian.purdila@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/01/15 00:00, Octavian Purdila wrote:
> Add a new watermark trigger and hardware fifo operations. When the
> watermark trigger is activated the watermark level is set and the
> hardware FIFO is activated.
> 
> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
Clearly the trigger question is outstanding - hence I've just addressed
the code itself here rather than the approach.  Mostly fine, but a few
little suggestions inline (and moans about hardware designers ;)
> ---
>  drivers/iio/accel/bmc150-accel.c | 185 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 181 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
> index c05aa43..e4535ba 100644
> --- a/drivers/iio/accel/bmc150-accel.c
> +++ b/drivers/iio/accel/bmc150-accel.c
> @@ -70,7 +70,9 @@
>  #define BMC150_ACCEL_INT_MAP_0_BIT_SLOPE	BIT(2)
>  
>  #define BMC150_ACCEL_REG_INT_MAP_1		0x1A
> -#define BMC150_ACCEL_INT_MAP_1_BIT_DATA	BIT(0)
> +#define BMC150_ACCEL_INT_MAP_1_BIT_DATA		BIT(0)
> +#define BMC150_ACCEL_INT_MAP_1_BIT_FWM		BIT(1)
> +#define BMC150_ACCEL_INT_MAP_1_BIT_FFULL	BIT(2)
>  
>  #define BMC150_ACCEL_REG_INT_RST_LATCH		0x21
>  #define BMC150_ACCEL_INT_MODE_LATCH_RESET	0x80
> @@ -83,7 +85,9 @@
>  #define BMC150_ACCEL_INT_EN_BIT_SLP_Z		BIT(2)
>  
>  #define BMC150_ACCEL_REG_INT_EN_1		0x17
> -#define BMC150_ACCEL_INT_EN_BIT_DATA_EN	BIT(4)
> +#define BMC150_ACCEL_INT_EN_BIT_DATA_EN		BIT(4)
> +#define BMC150_ACCEL_INT_EN_BIT_FFULL_EN	BIT(5)
> +#define BMC150_ACCEL_INT_EN_BIT_FWM_EN		BIT(6)
>  
>  #define BMC150_ACCEL_REG_INT_OUT_CTRL		0x20
>  #define BMC150_ACCEL_INT_OUT_CTRL_INT1_LVL	BIT(0)
> @@ -122,6 +126,12 @@
>  #define BMC150_ACCEL_AXIS_TO_REG(axis)	(BMC150_ACCEL_REG_XOUT_L + (axis * 2))
>  #define BMC150_AUTO_SUSPEND_DELAY_MS		2000
>  
> +#define BMC150_ACCEL_REG_FIFO_STATUS		0x0E
> +#define BMC150_ACCEL_REG_FIFO_CONFIG0		0x30
> +#define BMC150_ACCEL_REG_FIFO_CONFIG1		0x3E
> +#define BMC150_ACCEL_REG_FIFO_DATA		0x3F
> +#define BMC150_ACCEL_FIFO_LENGTH		32
Is it just me who instinctively thinks that if you are going to bother
with a fifo when designing a chip, it ought to be longer than this?
I guess it consumes a lot of real estate on the chip.
> +
>  enum bmc150_accel_axis {
>  	AXIS_X,
>  	AXIS_Y,
> @@ -160,8 +170,8 @@ struct bmc150_accel_trigger {
>  	int (*setup)(struct bmc150_accel_trigger *t, bool state);
>  };
>  
> -#define BMC150_ACCEL_INTERRUPTS		2
> -#define BMC150_ACCEL_TRIGGERS		2
> +#define BMC150_ACCEL_INTERRUPTS		3
> +#define BMC150_ACCEL_TRIGGERS		3
Funilly enough, might be cleaner to not have these defined, but rather
use a variable sized array [] and then use ARRAY_SIZE() to always
get the number.  Cuts down on the churn when you add more interrupts / triggers.
(Note I haven't checked closely if there is any reason this won't work here!)
>  
>  struct bmc150_accel_data {
>  	struct i2c_client *client;
> @@ -169,6 +179,7 @@ struct bmc150_accel_data {
>  	atomic_t active_intr;
>  	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
>  	struct mutex mutex;
> +	u8 fifo_mode, watermark;
>  	s16 buffer[8];
>  	u8 bw_bits;
>  	u32 slope_dur;
> @@ -460,6 +471,12 @@ static const struct bmc150_accel_interrupt_info {
>  			BMC150_ACCEL_INT_EN_BIT_SLP_Y |
>  			BMC150_ACCEL_INT_EN_BIT_SLP_Z
>  	},
> +	{ /* fifo watermark interrupt */
> +		.map_reg = BMC150_ACCEL_REG_INT_MAP_1,
> +		.map_bitmask = BMC150_ACCEL_INT_MAP_1_BIT_FWM,
> +		.en_reg = BMC150_ACCEL_REG_INT_EN_1,
> +		.en_bitmask = BMC150_ACCEL_INT_EN_BIT_FWM_EN,
> +	},
>  };
>  
>  static void bmc150_accel_interrupts_setup(struct iio_dev *indio_dev,
> @@ -951,6 +968,8 @@ static const struct iio_info bmc150_accel_info = {
>  	.driver_module		= THIS_MODULE,
>  };
>  
> +static int bmc150_accel_fifo_flush(struct iio_dev *indio_dev, int samples);
> +
Why not just reorganise the code to avoid needing this forward definition?
>  static irqreturn_t bmc150_accel_trigger_handler(int irq, void *p)
>  {
>  	struct iio_poll_func *pf = p;
> @@ -958,6 +977,12 @@ static irqreturn_t bmc150_accel_trigger_handler(int irq, void *p)
>  	struct bmc150_accel_data *data = iio_priv(indio_dev);
>  	int bit, ret, i = 0;
>  
> +	if (data->fifo_mode) {
> +		bmc150_accel_fifo_flush(indio_dev, BMC150_ACCEL_FIFO_LENGTH);
> +		iio_trigger_notify_done(indio_dev->trig);
> +		return IRQ_HANDLED;
> +	}
> +
>  	mutex_lock(&data->mutex);
>  	for_each_set_bit(bit, indio_dev->buffer->scan_mask,
>  			 indio_dev->masklength) {
> @@ -1161,6 +1186,8 @@ static int bmc150_accel_gpio_probe(struct i2c_client *client,
>  	return ret;
>  }
>  
> +static int bmc150_accel_fifo_setup(struct bmc150_accel_trigger *t, bool state);
> +
>  static const struct {
>  	int intr;
>  	const char *name;
> @@ -1175,6 +1202,11 @@ static const struct {
>  		.name = "%s-any-motion-dev%d",
>  		.setup = bmc150_accel_any_motion_setup,
>  	},
> +	{
> +		.intr = 2,
> +		.name = "%s-watermark-dev%d",
> +		.setup = bmc150_accel_fifo_setup,
> +	},
>  };
>  
>  static void bmc150_accel_unregister_triggers(struct bmc150_accel_data *data,
> @@ -1226,6 +1258,145 @@ static int bmc150_accel_triggers_setup(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> +static int bmc150_accel_set_watermark(struct iio_dev *indio_dev, unsigned val)
> +
> +{
> +	struct bmc150_accel_data *data = iio_priv(indio_dev);
> +	u8 reg = BMC150_ACCEL_REG_FIFO_CONFIG0;
> +	int ret;
> +
> +	if (val > BMC150_ACCEL_FIFO_LENGTH)
> +		return -EINVAL;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, reg, val);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error writing reg_fifo_config0\n");
> +		return ret;
> +	}
> +
> +	data->watermark = val;
> +
> +	return 0;
> +}
> +
> +static int bmc150_accel_fifo_flush(struct iio_dev *indio_dev, int samples)
> +{
> +	struct bmc150_accel_data *data = iio_priv(indio_dev);
> +	int ret, i;
> +	u8 count;
> +	u16 buffer[BMC150_ACCEL_FIFO_LENGTH * 3];
> +	u8 reg_fifo_data = BMC150_ACCEL_REG_FIFO_DATA;
> +	struct i2c_msg msg[2];
> +	int64_t tstamp;
> +	int sample_freq = 0, sec, ms;
> +
> +	ret = bmc150_accel_get_bw(data, &sec, &ms);
> +	if (ret == IIO_VAL_INT_PLUS_MICRO)
> +		sample_freq = sec * 1000000000 + ms * 1000;
> +
> +	ret = i2c_smbus_read_byte_data(data->client,
> +				       BMC150_ACCEL_REG_FIFO_STATUS);
> +	if (ret < 0) {
> +		dev_err(&indio_dev->dev, "Error reading reg_fifo_status\n");
> +		return ret;
> +	}
> +
> +	count = ret & 0x7F;
> +
> +	if (!count)
> +		return 0;
> +
> +	if (count > samples)
> +		count = samples;
> +
> +	msg[0].addr = data->client->addr;
> +	msg[0].flags = 0;
> +	msg[0].buf = &reg_fifo_data;
> +	msg[0].len = sizeof(reg_fifo_data);
> +
> +	msg[1].addr = data->client->addr;
> +	msg[1].flags = I2C_M_RD;
> +	msg[1].buf = (u8 *)buffer;
> +	msg[1].len = count * 3 * 2;
Might be cleaner to do most of this using c99 structure initialization.
Something like.

struct i2c_msg msg[2] = {
       {
		.addr = data->client->addr,
		.buf = &reg_fifo_data,
		.len = sizeof(reg_fifo_data)
	}, {
		.addr = data->client->addr,
		.flags = I2C_M_RD,
		.buf = buffer,
	};
Then you just have to set the length here.  This makes the code slightly
easier to follow as it is obvious what is static information and what
is not.

> +
> +	ret = i2c_transfer(data->client->adapter, msg, 2);
> +	if (ret != 2) {
> +		dev_err(&indio_dev->dev, "Error reading reg_fifo_data\n");
> +		return ret;
> +	}
> +
> +	if (!data->timestamp)
> +		data->timestamp = iio_get_time_ns();
> +
> +	tstamp = data->timestamp - count * sample_freq;
> +
> +	for (i = 0; i < count; i++) {
> +		u16 sample[8];
> +		int j, bit;
> +
> +		j = 0;
> +		for_each_set_bit(bit, indio_dev->active_scan_mask,
> +				 indio_dev->masklength) {
> +			memcpy(&sample[j++], &buffer[i * 3 + bit], 2);
> +		}
Coding style would not put brackets around a single statement like this one...
Also this should be reworked to push everything onwards (given we've read
it) and let the core demux do it's work.  Obviously you'll need to set
available_scan_masks though.

Done like this, if we have multiple clients for the stream, we end up ripping
it up more than one time - definitely wasted effort - also that code
does amalgamated copies when possible.

At some point we should look at allowing a bulk buffer push as well.
Certainly the kfifo underlying the software buffer seems to be able to
take advantage of this.

For now one record at a time will do though!
> +
> +		iio_push_to_buffers_with_timestamp(indio_dev, sample, tstamp);
> +
> +		tstamp += sample_freq;
> +	}
> +
> +	data->timestamp = 0;
> +
> +	return 0;
> +}
> +
> +static int bmc150_accel_fifo_mode_set(struct bmc150_accel_data *data)
> +{
> +	u8 reg = BMC150_ACCEL_REG_FIFO_CONFIG1;
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, reg);
> +
> +	/* writing the fifo config discards FIFO data - avoid it if possible */
> +	if (ret == data->fifo_mode)
> +		return 0;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, reg, data->fifo_mode);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error writing reg_fifo_config1\n");
> +		return ret;
> +	}
> +
> +	if (!data->fifo_mode)
> +		return 0;
> +
> +	/* we can set the the watermark value only after FIFO is enabled */
That's wonderfully bonkers from a consistency point of view.  Oh well
hardware designers...  I'm guessing it defaults to some value such as buffer
full?  Otherwise this is nasty and racy.
> +	ret = i2c_smbus_write_byte_data(data->client,
> +					BMC150_ACCEL_REG_FIFO_CONFIG0,
> +					data->watermark);
> +
> +	if (ret < 0)
> +		dev_err(&data->client->dev, "Error writing reg_fifo_config0\n");
> +
> +	return ret;
> +}
> +
> +static int bmc150_accel_fifo_setup(struct bmc150_accel_trigger *t, bool state)
> +{
> +	if (state)
> +		t->data->fifo_mode = 0x40;
> +	else
> +		t->data->fifo_mode = 0;
> +
> +	return bmc150_accel_fifo_mode_set(t->data);
> +}
> +
> +static struct iio_hwfifo bmc150_accel_hwfifo = {
> +	.length = BMC150_ACCEL_FIFO_LENGTH,
> +	.set_watermark = bmc150_accel_set_watermark,
> +	.flush = bmc150_accel_fifo_flush,
> +};
> +
>  static int bmc150_accel_probe(struct i2c_client *client,
>  			      const struct i2c_device_id *id)
>  {
> @@ -1309,6 +1480,8 @@ static int bmc150_accel_probe(struct i2c_client *client,
>  				"Failed: iio triggered buffer setup\n");
>  			goto err_trigger_unregister;
>  		}
> +
> +		indio_dev->hwfifo = &bmc150_accel_hwfifo;
>  	}
>  
>  	ret = iio_device_register(indio_dev);
> @@ -1380,6 +1553,7 @@ static int bmc150_accel_resume(struct device *dev)
>  	mutex_lock(&data->mutex);
>  	if (atomic_read(&data->active_intr))
>  		bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_NORMAL, 0);
> +	bmc150_accel_fifo_mode_set(data);
>  	mutex_unlock(&data->mutex);
>  
>  	return 0;
> @@ -1413,6 +1587,9 @@ static int bmc150_accel_runtime_resume(struct device *dev)
>  	ret = bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_NORMAL, 0);
>  	if (ret < 0)
>  		return ret;
> +	ret = bmc150_accel_fifo_mode_set(data);
> +	if (ret < 0)
> +		return ret;
>  
>  	sleep_val = bmc150_accel_get_startup_times(data);
>  	if (sleep_val < 20)
> 

