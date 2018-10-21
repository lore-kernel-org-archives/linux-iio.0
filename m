Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727266AbeJUVlA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Oct 2018 17:41:00 -0400
Date: Sun, 21 Oct 2018 14:26:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Slawomir Stepien <sst@poczta.fm>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 1/1] staging: iio: adc: ad7280a: use devm_* APIs
Message-ID: <20181021142632.2838a361@archlinux>
In-Reply-To: <20181019182013.GC20587@x220.localdomain>
References: <20181019182013.GC20587@x220.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 19 Oct 2018 20:20:13 +0200
Slawomir Stepien <sst@poczta.fm> wrote:

> devm_* APIs are device managed and make code simpler.
> 
> Signed-off-by: Slawomir Stepien <sst@poczta.fm>

Hi Slawomir,

There are some complexities in using the managed allocators, almost
always around possible race conditions.  See inline.

Jonathan

> ---
> Since v2:
> * iio_device_register -> devm_iio_device_register
> 
> Since v1:
> * request_threaded_irq -> devm_request_threaded_irq
> ---
>  drivers/staging/iio/adc/ad7280a.c | 61 +++++++++++--------------------
>  1 file changed, 22 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index b736275c10f5..770e016c325b 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -8,7 +8,6 @@
>  
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> -#include <linux/slab.h>
>  #include <linux/sysfs.h>
>  #include <linux/spi/spi.h>
>  #include <linux/err.h>
> @@ -492,8 +491,8 @@ static int ad7280_channel_init(struct ad7280_state *st)
>  {
>  	int dev, ch, cnt;
>  
> -	st->channels = kcalloc((st->slave_num + 1) * 12 + 2,
> -			       sizeof(*st->channels), GFP_KERNEL);
> +	st->channels = devm_kcalloc(&st->spi->dev, (st->slave_num + 1) * 12 + 2,
> +				    sizeof(*st->channels), GFP_KERNEL);
>  	if (!st->channels)
>  		return -ENOMEM;
>  
> @@ -553,9 +552,9 @@ static int ad7280_attr_init(struct ad7280_state *st)
>  {
>  	int dev, ch, cnt;
>  
> -	st->iio_attr = kcalloc(2, sizeof(*st->iio_attr) *
> -			       (st->slave_num + 1) * AD7280A_CELLS_PER_DEV,
> -			       GFP_KERNEL);
> +	st->iio_attr = devm_kcalloc(&st->spi->dev, 2, sizeof(*st->iio_attr) *
> +				    (st->slave_num + 1) * AD7280A_CELLS_PER_DEV,
> +				    GFP_KERNEL);
>  	if (!st->iio_attr)
>  		return -ENOMEM;
>  
> @@ -692,7 +691,8 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
>  	unsigned int *channels;
>  	int i, ret;
>  
> -	channels = kcalloc(st->scan_cnt, sizeof(*channels), GFP_KERNEL);
> +	channels = devm_kcalloc(&st->spi->dev, st->scan_cnt, sizeof(*channels),
> +				GFP_KERNEL);
>  	if (!channels)
>  		return IRQ_HANDLED;
>  
> @@ -744,7 +744,7 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
>  	}
>  
>  out:
> -	kfree(channels);
> +	devm_kfree(&st->spi->dev, channels);

Now this I really don't want to see.
Using the managed framework is far from free. Please don't do it when the
normal path is to free the buffer like this...

>  
>  	return IRQ_HANDLED;
>  }
> @@ -909,48 +909,38 @@ static int ad7280_probe(struct spi_device *spi)
>  
>  	ret = ad7280_attr_init(st);
>  	if (ret < 0)
> -		goto error_free_channels;
> +		return ret;
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(&spi->dev, indio_dev);
>  	if (ret)
> -		goto error_free_attr;
> +		return ret;
>  
>  	if (spi->irq > 0) {
>  		ret = ad7280_write(st, AD7280A_DEVADDR_MASTER,
>  				   AD7280A_ALERT, 1,
>  				   AD7280A_ALERT_RELAY_SIG_CHAIN_DOWN);
>  		if (ret)
> -			goto error_unregister;
> +			return ret;
>  
>  		ret = ad7280_write(st, ad7280a_devaddr(st->slave_num),
>  				   AD7280A_ALERT, 0,
>  				   AD7280A_ALERT_GEN_STATIC_HIGH |
>  				   (pdata->chain_last_alert_ignore & 0xF));
>  		if (ret)
> -			goto error_unregister;
> -
> -		ret = request_threaded_irq(spi->irq,
> -					   NULL,
> -					   ad7280_event_handler,
> -					   IRQF_TRIGGER_FALLING |
> -					   IRQF_ONESHOT,
> -					   indio_dev->name,
> -					   indio_dev);
> +			return ret;
> +
> +		ret = devm_request_threaded_irq(&spi->dev, spi->irq,
> +						NULL,
> +						ad7280_event_handler,
> +						IRQF_TRIGGER_FALLING |
> +						IRQF_ONESHOT,
> +						indio_dev->name,
> +						indio_dev);
>  		if (ret)
> -			goto error_unregister;
> +			return ret;
>  	}
>  
>  	return 0;
> -error_unregister:
> -	iio_device_unregister(indio_dev);
> -
> -error_free_attr:
> -	kfree(st->iio_attr);
> -
> -error_free_channels:
> -	kfree(st->channels);
> -
> -	return ret;
>  }
>  
>  static int ad7280_remove(struct spi_device *spi)
> @@ -958,16 +948,9 @@ static int ad7280_remove(struct spi_device *spi)
>  	struct iio_dev *indio_dev = spi_get_drvdata(spi);
>  	struct ad7280_state *st = iio_priv(indio_dev);
>  
> -	if (spi->irq > 0)
> -		free_irq(spi->irq, indio_dev);
> -	iio_device_unregister(indio_dev);
> -
>  	ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CONTROL_HB, 1,
>  		     AD7280A_CTRL_HB_PWRDN_SW | st->ctrl_hb);
So here, you need to think very carefully about what the various
steps are doing.  By moving to devm_iio_device_unregister
what difference has it made to the sequence of calls in remove?

The upshot is you just turned the device off before removing the
interfaces which would allow userspace / kernel consumers to
access the device.  A classic race condition that 'might' open
up opportunities for problems.

Often the reality is that these sorts of races have very minimal
impact, but they do break the cardinal rule that code should be
obviously right (if possible).  Hence you can't do this sort
of conversion so simply.  You can consider using the devm_add_action
approach to ensure the tear down is in the right order though...

>  
> -	kfree(st->channels);
> -	kfree(st->iio_attr);
These two are obviously fine as nothing happens after them anyway!

> -
>  	return 0;
>  }
>  
