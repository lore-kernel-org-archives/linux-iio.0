Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54161 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752343AbcJVSmM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Oct 2016 14:42:12 -0400
Subject: Re: [PATCH] iio: ti-adc0832: add triggered buffer support
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-iio@vger.kernel.org
References: <1476633582-21211-1-git-send-email-akinobu.mita@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8a1b7a0d-c13f-39a8-d6df-8a8a426f7f7f@kernel.org>
Date: Sat, 22 Oct 2016 19:42:09 +0100
MIME-Version: 1.0
In-Reply-To: <1476633582-21211-1-git-send-email-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/10/16 16:59, Akinobu Mita wrote:
> This adds triggered buffer support for it-adc0832 driver.  Tested with
> ADC0831 and ADC0832 by using SYSFS trigger.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Looks good to me other than the one typo above! (I'll fix that)

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/Kconfig      |   2 +
>  drivers/iio/adc/ti-adc0832.c | 106 +++++++++++++++++++++++++++++++++++--------
>  2 files changed, 89 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 3dc60c0..bd8d108 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -457,6 +457,8 @@ config TI_ADC081C
>  config TI_ADC0832
>  	tristate "Texas Instruments ADC0831/ADC0832/ADC0834/ADC0838"
>  	depends on SPI
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  If you say yes here you get support for Texas Instruments ADC0831,
>  	  ADC0832, ADC0834, ADC0838 ADC chips.
> diff --git a/drivers/iio/adc/ti-adc0832.c b/drivers/iio/adc/ti-adc0832.c
> index f4ba23e..e952e94 100644
> --- a/drivers/iio/adc/ti-adc0832.c
> +++ b/drivers/iio/adc/ti-adc0832.c
> @@ -14,6 +14,10 @@
>  #include <linux/spi/spi.h>
>  #include <linux/iio/iio.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
>  
>  enum {
>  	adc0831,
> @@ -38,10 +42,16 @@ struct adc0832 {
>  		.indexed = 1,						\
>  		.channel = chan,					\
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> -		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE)	\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +		.scan_index = chan,					\
> +		.scan_type = {						\
> +			.sign = 'u',					\
> +			.realbits = 8,					\
> +			.storagebits = 8,				\
> +		},							\
>  	}
>  
> -#define ADC0832_VOLTAGE_CHANNEL_DIFF(chan1, chan2)			\
> +#define ADC0832_VOLTAGE_CHANNEL_DIFF(chan1, chan2, si)			\
>  	{								\
>  		.type = IIO_VOLTAGE,					\
>  		.indexed = 1,						\
> @@ -49,18 +59,26 @@ struct adc0832 {
>  		.channel2 = (chan2),					\
>  		.differential = 1,					\
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> -		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE)	\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +		.scan_index = si,					\
> +		.scan_type = {						\
> +			.sign = 'u',					\
> +			.realbits = 8,					\
> +			.storagebits = 8,				\
> +		},							\
>  	}
>  
>  static const struct iio_chan_spec adc0831_channels[] = {
> -	ADC0832_VOLTAGE_CHANNEL_DIFF(0, 1),
> +	ADC0832_VOLTAGE_CHANNEL_DIFF(0, 1, 0),
> +	IIO_CHAN_SOFT_TIMESTAMP(1),
>  };
>  
>  static const struct iio_chan_spec adc0832_channels[] = {
>  	ADC0832_VOLTAGE_CHANNEL(0),
>  	ADC0832_VOLTAGE_CHANNEL(1),
> -	ADC0832_VOLTAGE_CHANNEL_DIFF(0, 1),
> -	ADC0832_VOLTAGE_CHANNEL_DIFF(1, 0),
> +	ADC0832_VOLTAGE_CHANNEL_DIFF(0, 1, 2),
> +	ADC0832_VOLTAGE_CHANNEL_DIFF(1, 0, 3),
> +	IIO_CHAN_SOFT_TIMESTAMP(4),
>  };
>  
>  static const struct iio_chan_spec adc0834_channels[] = {
> @@ -68,10 +86,11 @@ static const struct iio_chan_spec adc0834_channels[] = {
>  	ADC0832_VOLTAGE_CHANNEL(1),
>  	ADC0832_VOLTAGE_CHANNEL(2),
>  	ADC0832_VOLTAGE_CHANNEL(3),
> -	ADC0832_VOLTAGE_CHANNEL_DIFF(0, 1),
> -	ADC0832_VOLTAGE_CHANNEL_DIFF(1, 0),
> -	ADC0832_VOLTAGE_CHANNEL_DIFF(2, 3),
> -	ADC0832_VOLTAGE_CHANNEL_DIFF(3, 2),
> +	ADC0832_VOLTAGE_CHANNEL_DIFF(0, 1, 4),
> +	ADC0832_VOLTAGE_CHANNEL_DIFF(1, 0, 5),
> +	ADC0832_VOLTAGE_CHANNEL_DIFF(2, 3, 6),
> +	ADC0832_VOLTAGE_CHANNEL_DIFF(3, 2, 7),
> +	IIO_CHAN_SOFT_TIMESTAMP(8),
>  };
>  
>  static const struct iio_chan_spec adc0838_channels[] = {
> @@ -83,14 +102,15 @@ static const struct iio_chan_spec adc0838_channels[] = {
>  	ADC0832_VOLTAGE_CHANNEL(5),
>  	ADC0832_VOLTAGE_CHANNEL(6),
>  	ADC0832_VOLTAGE_CHANNEL(7),
> -	ADC0832_VOLTAGE_CHANNEL_DIFF(0, 1),
> -	ADC0832_VOLTAGE_CHANNEL_DIFF(1, 0),
> -	ADC0832_VOLTAGE_CHANNEL_DIFF(2, 3),
> -	ADC0832_VOLTAGE_CHANNEL_DIFF(3, 2),
> -	ADC0832_VOLTAGE_CHANNEL_DIFF(4, 5),
> -	ADC0832_VOLTAGE_CHANNEL_DIFF(5, 4),
> -	ADC0832_VOLTAGE_CHANNEL_DIFF(6, 7),
> -	ADC0832_VOLTAGE_CHANNEL_DIFF(7, 6),
> +	ADC0832_VOLTAGE_CHANNEL_DIFF(0, 1, 8),
> +	ADC0832_VOLTAGE_CHANNEL_DIFF(1, 0, 9),
> +	ADC0832_VOLTAGE_CHANNEL_DIFF(2, 3, 10),
> +	ADC0832_VOLTAGE_CHANNEL_DIFF(3, 2, 11),
> +	ADC0832_VOLTAGE_CHANNEL_DIFF(4, 5, 12),
> +	ADC0832_VOLTAGE_CHANNEL_DIFF(5, 4, 13),
> +	ADC0832_VOLTAGE_CHANNEL_DIFF(6, 7, 14),
> +	ADC0832_VOLTAGE_CHANNEL_DIFF(7, 6, 15),
> +	IIO_CHAN_SOFT_TIMESTAMP(16),
>  };
>  
>  static int adc0831_adc_conversion(struct adc0832 *adc)
> @@ -178,6 +198,42 @@ static const struct iio_info adc0832_info = {
>  	.driver_module = THIS_MODULE,
>  };
>  
> +static irqreturn_t adc0832_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct adc0832 *adc = iio_priv(indio_dev);
> +	u8 data[24] = { }; /* 16x 1 byte ADC data + 8 bytes timestamp */
> +	int scan_index;
> +	int i = 0;
> +
> +	mutex_lock(&adc->lock);
> +
> +	for_each_set_bit(scan_index, indio_dev->active_scan_mask,
> +			 indio_dev->masklength) {
> +		const struct iio_chan_spec *scan_chan =
> +				&indio_dev->channels[scan_index];
> +		int ret = adc0832_adc_conversion(adc, scan_chan->channel,
> +						 scan_chan->differential);
> +		if (ret < 0) {
> +			dev_warn(&adc->spi->dev,
> +				 "failed to get conversion data\n");
> +			goto out;
> +		}
> +
> +		data[i] = ret;
> +		i++;
> +	}
> +	iio_push_to_buffers_with_timestamp(indio_dev, data,
> +					   iio_get_time_ns(indio_dev));
> +out:
> +	mutex_unlock(&adc->lock);
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int adc0832_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
> @@ -233,9 +289,20 @@ static int adc0832_probe(struct spi_device *spi)
>  
>  	spi_set_drvdata(spi, indio_dev);
>  
> +	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> +					 adc0832_trigger_handler, NULL);
> +	if (ret)
> +		goto err_reg_disable;
> +
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
> -		regulator_disable(adc->reg);
> +		goto err_buffer_cleanup;
> +
> +	return 0;
> +err_buffer_cleanup:
> +	iio_triggered_buffer_cleanup(indio_dev);
> +err_reg_disable:
> +	regulator_disable(adc->reg);
>  
>  	return ret;
>  }
> @@ -246,6 +313,7 @@ static int adc0832_remove(struct spi_device *spi)
>  	struct adc0832 *adc = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> +	iio_triggered_buffer_cleanup(indio_dev);
>  	regulator_disable(adc->reg);
>  
>  	return 0;
> 

