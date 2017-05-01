Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37508 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2992760AbdEAAmf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Apr 2017 20:42:35 -0400
Subject: Re: [PATCH v2 4/4] iio: accel: adxl345: Add support for triggered
 buffer
To: Eva Rachel Retuya <eraretuya@gmail.com>, linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        dmitry.torokhov@gmail.com, michael.hennerich@analog.com,
        daniel.baluta@gmail.com, amsfield22@gmail.com,
        florian.vaussard@heig-vd.ch, linux-kernel@vger.kernel.org
References: <cover.1493450577.git.eraretuya@gmail.com>
 <6b7ca7916924965c30e9e5abb4133663e5c7916d.1493450577.git.eraretuya@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5802a264-d991-7e61-cc9e-b08079c0a9eb@kernel.org>
Date: Mon, 1 May 2017 01:42:29 +0100
MIME-Version: 1.0
In-Reply-To: <6b7ca7916924965c30e9e5abb4133663e5c7916d.1493450577.git.eraretuya@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/04/17 08:49, Eva Rachel Retuya wrote:
> Previously, the only way to capture data is to read the exposed sysfs
> files in_accel_[x/y/z]_raw and applying the scale from in_accel_scale.
> Provide a way for continuous data capture that allows multiple data
> channels to be read at once by setting up buffer support.
> 
> Initialize scan_type fields that describe the buffer and make sure to
> claim and release direct mode in read_raw. The latter is done to ensure
> no raw reads are attempted when utilizing the buffer and vice versa.
> 
> Lastly, add triggered buffer support that allows utilization of any
> given trigger such as DATA_READY, hrtimer, etc. to initiate capturing of
> data and placing said data in the buffer. The trigger handler performs
> an all-axes read with timestamp.
> 
> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
Few minor bits inline...  I'm a little bit in two minds about the 
holding up waiting for new data when using another trigger...

Jonathan
> ---
> Changes in v2:
> * Provide a more detailed commit message
> * adxl345_trigger_handler()
>   * if using external trigger, place a adxl345_data_ready() call before
>     performing a bulk read
>   * Since get_triple() is scrapped, place a direct bulk read here
>   * Move mutex unlocking below goto label
> * Switch to devm_iio_triggered_buffer_setup()
> * Remove i2c_check_functionality() that could introduce regression
> 
>  drivers/iio/accel/Kconfig        |   2 +
>  drivers/iio/accel/adxl345_core.c | 101 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 102 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 15de262..45092da 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -7,6 +7,8 @@ menu "Accelerometers"
>  
>  config ADXL345
>  	tristate
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  
>  config ADXL345_I2C
>  	tristate "Analog Devices ADXL345 3-Axis Digital Accelerometer I2C Driver"
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index b8be0d7..40dbdce 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -14,8 +14,11 @@
>  #include <linux/of_irq.h>
>  #include <linux/regmap.h>
>  
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
>  
>  #include "adxl345.h"
>  
> @@ -55,12 +58,20 @@
>   */
>  static const int adxl345_uscale = 38300;
>  
> +enum adxl345_scan_index {
> +	ADXL345_IDX_X,
> +	ADXL345_IDX_Y,
> +	ADXL345_IDX_Z,
> +	ADXL345_IDX_TSTAMP,
> +};
> +
>  struct adxl345_data {
>  	struct iio_trigger *data_ready_trig;
>  	bool data_ready_trig_on;
>  	struct regmap *regmap;
>  	struct mutex lock; /* protect this data structure */
>  	u8 data_range;
> +	s16 buffer[8]; /* 3 x 16-bit channels + padding + 64-bit timestamp */
>  };
>  
>  static int adxl345_set_mode(struct adxl345_data *data, u8 mode)
> @@ -109,12 +120,25 @@ static int adxl345_data_ready(struct adxl345_data *data)
>  	.address = reg,							\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
> +	.scan_index = ADXL345_IDX_##axis,				\
> +	.scan_type = {							\
> +		.sign = 's',						\
> +		.realbits = 13,						\
> +		.storagebits = 16,					\
> +		.endianness = IIO_LE,					\
> +	},								\
>  }
>  
>  static const struct iio_chan_spec adxl345_channels[] = {
>  	ADXL345_CHANNEL(ADXL345_REG_DATAX0, X),
>  	ADXL345_CHANNEL(ADXL345_REG_DATAY0, Y),
>  	ADXL345_CHANNEL(ADXL345_REG_DATAZ0, Z),
> +	IIO_CHAN_SOFT_TIMESTAMP(ADXL345_IDX_TSTAMP),
> +};
> +
> +static const unsigned long adxl345_scan_masks[] = {
> +	BIT(ADXL345_IDX_X) | BIT(ADXL345_IDX_Y) | BIT(ADXL345_IDX_Z),
> +	0
>  };
>  
>  static int adxl345_read_raw(struct iio_dev *indio_dev,
> @@ -127,6 +151,10 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +
>  		mutex_lock(&data->lock);
>  		ret = adxl345_set_mode(data, ADXL345_POWER_CTL_MEASURE);
>  		if (ret < 0) {
> @@ -148,12 +176,14 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
>  		ret = regmap_bulk_read(data->regmap, chan->address, &regval,
>  				       sizeof(regval));
>  		mutex_unlock(&data->lock);
> +		iio_device_release_direct_mode(indio_dev);
>  		if (ret < 0) {
>  			adxl345_set_mode(data, ADXL345_POWER_CTL_STANDBY);
>  			return ret;
>  		}
>  
> -		*val = sign_extend32(le16_to_cpu(regval), 12);
> +		*val = sign_extend32(le16_to_cpu(regval),
> +				     chan->scan_type.realbits - 1)
This change isn't really needed, but I suppose it does little harm...

>  		adxl345_set_mode(data, ADXL345_POWER_CTL_STANDBY);
>  
>  		return IIO_VAL_INT;
> @@ -186,6 +216,64 @@ static irqreturn_t adxl345_irq(int irq, void *p)
>  	return IRQ_NONE;
>  }
>  
> +static irqreturn_t adxl345_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct adxl345_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +	/* Make sure data is ready when using external trigger */
I 'think' this is only really relevant for the very first one.
After that general rule of thumb is that if an external trigger
is too quick - bad luck you'll get repeated data.

One of the reasons we would want to use another trigger is to
support capture in parallel from several sensors - if we 'hold'
like this we'll get out of sync.

As such I wonder if a better strategy would be to 'hold' for the
first reading in the buffer enable - thus guaranteeing valid
data before we start.  After that we wouldn't need to check this
here.

What do others think?

> +	if (!data->data_ready_trig_on) {
> +		ret = adxl345_data_ready(data);
> +		if (ret < 0)
> +			goto error;
> +	}
> +
> +	ret = regmap_bulk_read(data->regmap, ADXL345_REG_DATAX0, data->buffer,
> +			       sizeof(__le16) * 3);
> +	if (ret < 0)
> +		goto error;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> +					   pf->timestamp);
> +error:
> +	mutex_unlock(&data->lock);
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int adxl345_triggered_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct adxl345_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = iio_triggered_buffer_postenable(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	return adxl345_set_mode(data, ADXL345_POWER_CTL_MEASURE);
> +}
> +
> +static int adxl345_triggered_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct adxl345_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = adxl345_set_mode(data, ADXL345_POWER_CTL_STANDBY);
> +	if (ret)
> +		return ret;
> +
> +	return iio_triggered_buffer_predisable(indio_dev);
> +}
> +
> +static const struct iio_buffer_setup_ops adxl345_buffer_setup_ops = {
> +	.postenable = adxl345_triggered_buffer_postenable,
> +	.predisable = adxl345_triggered_buffer_predisable,
> +};
> +
>  static int adxl345_drdy_trigger_set_state(struct iio_trigger *trig, bool state)
>  {
>  	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> @@ -278,6 +366,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap, int irq,
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = adxl345_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
> +	indio_dev->available_scan_masks = adxl345_scan_masks;
>  
>  	if (irq > 0) {
>  		ret = devm_request_threaded_irq(dev,
> @@ -311,6 +400,16 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap, int irq,
>  		}
>  	}
>  
> +	ret = devm_iio_triggered_buffer_setup(dev,
> +					      indio_dev,
> +					      iio_pollfunc_store_time,
> +					      adxl345_trigger_handler,
> +					      &adxl345_buffer_setup_ops);
> +	if (ret < 0) {
> +		dev_err(dev, "iio_triggered_buffer_setup failed: %d\n", ret);
> +		return ret;
> +	}
> +
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0)
>  		dev_err(dev, "iio_device_register failed: %d\n", ret);
> 

