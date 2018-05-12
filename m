Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750735AbeELLDI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 May 2018 07:03:08 -0400
Date: Sat, 12 May 2018 12:03:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Cc: pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads8688: add trigger and buffer support
Message-ID: <20180512120303.78dea238@archlinux>
In-Reply-To: <20180509181718.10451-1-sean.nyekjaer@prevas.dk>
References: <20180509181718.10451-1-sean.nyekjaer@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed,  9 May 2018 20:17:18 +0200
Sean Nyekjaer <sean.nyekjaer@prevas.dk> wrote:

> Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Looks good though a little more detail in the patch description would have
be nice ;)  (I'll always find something to moan about :)

Anyhow, applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Looking forward to the auto sequencer stuff.

Jonathan

> ---
> I'm looking at enabling the ADC's auto sequencing feature to enabled an
> even greater performance. But this is also useful as is :-)
> 
>  drivers/iio/adc/ti-ads8688.c | 48 +++++++++++++++++++++++++++++++++---
>  1 file changed, 45 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
> index 079f133144b0..184d686ebd99 100644
> --- a/drivers/iio/adc/ti-ads8688.c
> +++ b/drivers/iio/adc/ti-ads8688.c
> @@ -17,6 +17,9 @@
>  #include <linux/of.h>
>  
>  #include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  #include <linux/iio/sysfs.h>
>  
>  #define ADS8688_CMD_REG(x)		(x << 8)
> @@ -155,6 +158,13 @@ static const struct attribute_group ads8688_attribute_group = {
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)		\
>  			      | BIT(IIO_CHAN_INFO_SCALE)	\
>  			      | BIT(IIO_CHAN_INFO_OFFSET),	\
> +	.scan_index = index,					\
> +	.scan_type = {						\
> +		.sign = 'u',					\
> +		.realbits = 16,					\
> +		.storagebits = 16,				\
> +		.endianness = IIO_BE,				\
> +	},							\
>  }
>  
>  static const struct iio_chan_spec ads8684_channels[] = {
> @@ -371,6 +381,28 @@ static const struct iio_info ads8688_info = {
>  	.attrs = &ads8688_attribute_group,
>  };
>  
> +static irqreturn_t ads8688_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	u16 buffer[8];
> +	int i, j = 0;
> +
> +	for (i = 0; i < indio_dev->masklength; i++) {
> +		if (!test_bit(i, indio_dev->active_scan_mask))
> +			continue;
> +		buffer[j] = ads8688_read(indio_dev, i);
> +		j++;
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
> +			pf->timestamp);
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static const struct ads8688_chip_info ads8688_chip_info_tbl[] = {
>  	[ID_ADS8684] = {
>  		.channels = ads8684_channels,
> @@ -402,7 +434,7 @@ static int ads8688_probe(struct spi_device *spi)
>  
>  		ret = regulator_get_voltage(st->reg);
>  		if (ret < 0)
> -			goto error_out;
> +			goto err_regulator_disable;
>  
>  		st->vref_mv = ret / 1000;
>  	} else {
> @@ -430,13 +462,22 @@ static int ads8688_probe(struct spi_device *spi)
>  
>  	mutex_init(&st->lock);
>  
> +	ret = iio_triggered_buffer_setup(indio_dev, NULL, ads8688_trigger_handler, NULL);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "iio triggered buffer setup failed\n");
> +		goto err_regulator_disable;
> +	}
> +
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
> -		goto error_out;
> +		goto err_buffer_cleanup;
>  
>  	return 0;
>  
> -error_out:
> +err_buffer_cleanup:
> +	iio_triggered_buffer_cleanup(indio_dev);
> +
> +err_regulator_disable:
>  	if (!IS_ERR(st->reg))
>  		regulator_disable(st->reg);
>  
> @@ -449,6 +490,7 @@ static int ads8688_remove(struct spi_device *spi)
>  	struct ads8688_state *st = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> +	iio_triggered_buffer_cleanup(indio_dev);
>  
>  	if (!IS_ERR(st->reg))
>  		regulator_disable(st->reg);

