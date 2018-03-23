Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga06-in.huawei.com ([45.249.212.32]:47023 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752192AbeCWNXX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 23 Mar 2018 09:23:23 -0400
Date: Fri, 23 Mar 2018 13:23:05 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: David Veenstra <davidjulianveenstra@gmail.com>
CC: <lars@metafoo.de>, <jic23@kernel.org>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>
Subject: Re: [PATCH 08/11] staging: iio: ad2s1200: Replace legacy gpio ABI
 with modern ABI
Message-ID: <20180323142305.0000785c@huawei.com>
In-Reply-To: <0591e04105efe97eed662059ac8771a70fca5b46.1521379685.git.davidjulianveenstra@gmail.com>
References: <cover.1521379685.git.davidjulianveenstra@gmail.com>
        <0591e04105efe97eed662059ac8771a70fca5b46.1521379685.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 18 Mar 2018 14:36:33 +0100
David Veenstra <davidjulianveenstra@gmail.com> wrote:

> The legacy, integer based gpio ABI is replaced with the descriptor
> based ABI.
> 
> For compatibility, it is first tried to use the platform data to
> request the gpio's. Otherwise, it looks for the "sample" and "rdvel"
> gpio function.
> 
> Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>

I'd like Michael's opinion on this.  Personally I think we are safe to just
drop the old platform data code and have just use the new method. It's not
exactly hard to convert any board files over!

Code looks fine to me other than that.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/resolver/ad2s1200.c | 51 ++++++++++++++++++++++++---------
>  1 file changed, 37 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
> index 6ce9ca13094a..7ee1d9f76dfb 100644
> --- a/drivers/staging/iio/resolver/ad2s1200.c
> +++ b/drivers/staging/iio/resolver/ad2s1200.c
> @@ -14,6 +14,7 @@
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/slab.h>
> @@ -45,8 +46,8 @@
>  struct ad2s1200_state {
>  	struct mutex lock;
>  	struct spi_device *sdev;
> -	int sample;
> -	int rdvel;
> +	struct gpio_desc *sample;
> +	struct gpio_desc *rdvel;
>  	u8 rx[2] ____cacheline_aligned;
>  };
>  
> @@ -61,12 +62,12 @@ static int ad2s1200_read_raw(struct iio_dev *indio_dev,
>  	u16 vel;
>  
>  	mutex_lock(&st->lock);
> -	gpio_set_value(st->sample, 0);
> +	gpiod_set_value(st->sample, 0);
>  
>  	/* delay (6 * AD2S1200_TSCLK + 20) nano seconds */
>  	udelay(1);
> -	gpio_set_value(st->sample, 1);
> -	gpio_set_value(st->rdvel, !!(chan->type == IIO_ANGL));
> +	gpiod_set_value(st->sample, 1);
> +	gpiod_set_value(st->rdvel, !!(chan->type == IIO_ANGL));
>  
>  	ret = spi_read(st->sdev, st->rx, 2);
>  	if (ret < 0) {
> @@ -124,13 +125,18 @@ static int ad2s1200_probe(struct spi_device *spi)
>  
>  	dev = &spi->dev;
>  
> -	for (pn = 0; pn < AD2S1200_PN; pn++) {
> -		ret = devm_gpio_request_one(dev, pins[pn], GPIOF_DIR_OUT,
> -					    DRV_NAME);
> -		if (ret) {
> -			dev_err(dev, "request gpio pin %d failed\n",
> -				pins[pn]);
> -			return ret;
> +	if (pins) {
> +		for (pn = 0; pn < AD2S1200_PN; pn++) {
> +			ret = devm_gpio_request_one(dev, pins[pn],
> +						    GPIOF_DIR_OUT,
> +						    DRV_NAME);
> +			if (ret) {
> +				dev_err(dev,
> +					"Failed to claim gpio %d\n: err=%d",
> +					pins[pn],
> +					ret);
> +				return ret;
> +			}
>  		}
>  	}
>  
> @@ -142,8 +148,25 @@ static int ad2s1200_probe(struct spi_device *spi)
>  	st = iio_priv(indio_dev);
>  	mutex_init(&st->lock);
>  	st->sdev = spi;
> -	st->sample = pins[0];
> -	st->rdvel = pins[1];
> +
> +	if (pins) {
> +		st->sample = gpio_to_desc(pins[0]);
> +		st->rdvel = gpio_to_desc(pins[1]);
> +	} else {
> +		st->sample = devm_gpiod_get(dev, "sample", GPIOD_OUT_LOW);
> +		if (IS_ERR(st->sample)) {
> +			dev_err(dev, "Failed to claim SAMPLE gpio: err=%ld\n",
> +				PTR_ERR(st->sample));
> +			return PTR_ERR(st->sample);
> +		}
> +
> +		st->rdvel = devm_gpiod_get(dev, "rdvel", GPIOD_OUT_LOW);
> +		if (IS_ERR(st->rdvel)) {
> +			dev_err(dev, "Failed to claim RDVEL gpio: err=%ld\n",
> +				PTR_ERR(st->rdvel));
> +			return PTR_ERR(st->rdvel);
> +		}
> +	}
>  
>  	indio_dev->dev.parent = dev;
>  	indio_dev->info = &ad2s1200_info;

