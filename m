Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751736AbdLBNRj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 Dec 2017 08:17:39 -0500
Date: Sat, 2 Dec 2017 13:17:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        singhalsimran0@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: hx711: add triggered buffer support
Message-ID: <20171202131735.1eafd344@archlinux>
In-Reply-To: <20171130214342.GA27320@arbeit>
References: <20171130214342.GA27320@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 30 Nov 2017 22:43:42 +0100
Andreas Klinger <ak@it-klinger.de> wrote:

> Add buffer to device data struct and add trigger function
> 
> Data format is quite simple:
>       voltage - channel 0   32 Bit
>       voltage - channel 1   32 Bit
>       timestamp             64 Bit
> 
> Using both channels at the same time is working quite slow because of
> changing the channel which needs a dummy read.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>

Locking issues and a data positioning issue.

See inline.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/Kconfig |   2 +
>  drivers/iio/adc/hx711.c | 106 ++++++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 90 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index af4fc1279409..a83642e517d5 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -316,6 +316,8 @@ config HI8435
>  config HX711
>  	tristate "AVIA HX711 ADC for weight cells"
>  	depends on GPIOLIB
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  If you say yes here you get support for AVIA HX711 ADC which is used
>  	  for weigh cells
> diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
> index d10b9f13d557..d773fd69a76d 100644
> --- a/drivers/iio/adc/hx711.c
> +++ b/drivers/iio/adc/hx711.c
> @@ -24,6 +24,9 @@
>  #include <linux/delay.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/regulator/consumer.h>
>  
> @@ -89,6 +92,11 @@ struct hx711_data {
>  	int			gain_set;	/* gain set on device */
>  	int			gain_chan_a;	/* gain for channel A */
>  	struct mutex		lock;
> +	/*
> +	 * triggered buffer
> +	 * 2x32-bit channel + 2x32-bit timestamp
> +	 */
> +	u32			buffer[4];
>  };
>  
>  static int hx711_cycle(struct hx711_data *hx711_data)
> @@ -236,34 +244,43 @@ static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
>  	return 0;
>  }
>  
> +static int hx711_reset_read(struct hx711_data *hx711_data, int chan)
> +{
> +	int ret;
> +	int val;
> +
> +	/*
> +	 * hx711_reset() must be called from here
> +	 * because it could be calling hx711_read() by itself
> +	 */
> +	if (hx711_reset(hx711_data)) {

Mutex unlocks but no lock in a function is an issue...
Also I think you'll just be unlocking twice.

> +		mutex_unlock(&hx711_data->lock);
> +		dev_err(hx711_data->dev, "reset failed!");
> +		return -EIO;
> +	}
> +
> +	ret = hx711_set_gain_for_channel(hx711_data, chan);
> +	if (ret < 0) {
> +		mutex_unlock(&hx711_data->lock);
> +		return ret;
> +	}
> +
> +	val = hx711_read(hx711_data);
> +
> +	return val;
> +}
> +
>  static int hx711_read_raw(struct iio_dev *indio_dev,
>  				const struct iio_chan_spec *chan,
>  				int *val, int *val2, long mask)
>  {
>  	struct hx711_data *hx711_data = iio_priv(indio_dev);
> -	int ret;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  		mutex_lock(&hx711_data->lock);
>  
> -		/*
> -		 * hx711_reset() must be called from here
> -		 * because it could be calling hx711_read() by itself
> -		 */
> -		if (hx711_reset(hx711_data)) {
> -			mutex_unlock(&hx711_data->lock);
> -			dev_err(hx711_data->dev, "reset failed!");
> -			return -EIO;
> -		}
> -
> -		ret = hx711_set_gain_for_channel(hx711_data, chan->channel);
> -		if (ret < 0) {
> -			mutex_unlock(&hx711_data->lock);
> -			return ret;
> -		}
> -
> -		*val = hx711_read(hx711_data);
> +		*val = hx711_reset_read(hx711_data, chan->channel);
>  
>  		mutex_unlock(&hx711_data->lock);
>  
> @@ -339,6 +356,35 @@ static int hx711_write_raw_get_fmt(struct iio_dev *indio_dev,
>  	return IIO_VAL_INT_PLUS_NANO;
>  }
>  
> +static irqreturn_t hx711_trigger(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct hx711_data *hx711_data = iio_priv(indio_dev);
> +	int i;
> +
> +	mutex_lock(&hx711_data->lock);
> +
> +	memset(hx711_data->buffer, 0, sizeof(hx711_data->buffer));
> +
> +	for (i = 0; i < indio_dev->masklength; i++) {
> +		if (!test_bit(i, indio_dev->active_scan_mask))
> +			continue;

Expectation of IIO is that if you had only the second channel on it's
data would be found at the 0 position in the buffer.

> +
> +		hx711_data->buffer[i] = hx711_reset_read(hx711_data,
> +					indio_dev->channels[i].channel);
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, hx711_data->buffer,
> +							pf->timestamp);
> +
> +	mutex_unlock(&hx711_data->lock);
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static ssize_t hx711_scale_available_show(struct device *dev,
>  				struct device_attribute *attr,
>  				char *buf)
> @@ -387,6 +433,14 @@ static const struct iio_chan_spec hx711_chan_spec[] = {
>  		.indexed = 1,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 24,
> +			.storagebits = 32,
> +			.shift = 0,
> +			.endianness = IIO_CPU,
> +		},
>  	},
>  	{
>  		.type = IIO_VOLTAGE,
> @@ -394,7 +448,16 @@ static const struct iio_chan_spec hx711_chan_spec[] = {
>  		.indexed = 1,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = 1,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 24,
> +			.storagebits = 32,
> +			.shift = 0,
> +			.endianness = IIO_CPU,
> +		},
>  	},
> +	IIO_CHAN_SOFT_TIMESTAMP(2),
>  };
>  
>  static int hx711_probe(struct platform_device *pdev)
> @@ -482,6 +545,13 @@ static int hx711_probe(struct platform_device *pdev)
>  	indio_dev->channels = hx711_chan_spec;
>  	indio_dev->num_channels = ARRAY_SIZE(hx711_chan_spec);
>  
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +				iio_pollfunc_store_time, hx711_trigger, NULL);
> +	if (ret < 0) {
> +		dev_err(dev, "setup of iio triggered buffer failed\n");
> +		return ret;
> +	}
> +
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0) {
>  		dev_err(dev, "Couldn't register the device\n");

