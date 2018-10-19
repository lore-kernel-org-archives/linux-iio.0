Return-Path: <SRS0=gI/Q=M7=poczta.fm=sst@kernel.org>
Date: Fri, 19 Oct 2018 20:00:01 +0200
From: Slawomir Stepien <sst@poczta.fm>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	knaack.h@gmx.de, pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/1] staging: iio: adc: ad7280a: use devm_* APIs
Message-ID: <20181019180001.GA20587@x220.localdomain>
References: <20181017192429.GB6085@x220.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20181017192429.GB6085@x220.localdomain>
List-ID: <linux-iio@vger.kernel.org>

On paź 17, 2018 21:24, Slawomir Stepien wrote:
> devm_* APIs are device managed and make code simpler.

In the code, there's also request_threaded_irq that can be replaced with
devm_request_threaded_irq. I'll add it in the v2.

> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
> ---
>  drivers/staging/iio/adc/ad7280a.c | 29 ++++++++++-------------------
>  1 file changed, 10 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index b736275c10f5..cbb67f1230c7 100644
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
>  
>  	return IRQ_HANDLED;
>  }
> @@ -909,11 +909,11 @@ static int ad7280_probe(struct spi_device *spi)
>  
>  	ret = ad7280_attr_init(st);
>  	if (ret < 0)
> -		goto error_free_channels;
> +		return ret;
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
> -		goto error_free_attr;
> +		return ret;
>  
>  	if (spi->irq > 0) {
>  		ret = ad7280_write(st, AD7280A_DEVADDR_MASTER,
> @@ -944,12 +944,6 @@ static int ad7280_probe(struct spi_device *spi)
>  error_unregister:
>  	iio_device_unregister(indio_dev);
>  
> -error_free_attr:
> -	kfree(st->iio_attr);
> -
> -error_free_channels:
> -	kfree(st->channels);
> -
>  	return ret;
>  }
>  
> @@ -965,9 +959,6 @@ static int ad7280_remove(struct spi_device *spi)
>  	ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CONTROL_HB, 1,
>  		     AD7280A_CTRL_HB_PWRDN_SW | st->ctrl_hb);
>  
> -	kfree(st->channels);
> -	kfree(st->iio_attr);
> -
>  	return 0;
>  }
>  

-- 
Slawomir Stepien
