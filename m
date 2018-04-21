Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752868AbeDUQ6P (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Apr 2018 12:58:15 -0400
Date: Sat, 21 Apr 2018 17:58:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Veenstra <davidjulianveenstra@gmail.com>
Cc: lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        Michael.Hennerich@analog.com, knaack.h@gmx.de,
        daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 08/13] staging: iio: ad2s1200: Replace legacy gpio
 API with modern API
Message-ID: <20180421175809.01e56a52@archlinux>
In-Reply-To: <4253be22c7081a5032b59097bc166f559e7b1cea.1524247563.git.davidjulianveenstra@gmail.com>
References: <cover.1524247563.git.davidjulianveenstra@gmail.com>
        <4253be22c7081a5032b59097bc166f559e7b1cea.1524247563.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 20 Apr 2018 21:30:44 +0200
David Veenstra <davidjulianveenstra@gmail.com> wrote:

> The legacy, integer based gpio API is replaced with the descriptor
> based API.
> 
> For compatibility, it is first tried to use the platform data to
> request the gpio's. Otherwise, it looks for the "sample" and "rdvel"
> gpio function.
> 
> Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
I would suggest that we simply force any out of tree users of the
platform data to update the platform data.  Drop the the old
versions entirely..

We can be mean to out of tree board files so let us make our own
lives easy.

Jonathan

> ---
>  drivers/staging/iio/resolver/ad2s1200.c | 51 ++++++++++++++++++++++++---------
>  1 file changed, 37 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
> index 11ed9c7332e6..29a9bb666e7b 100644
> --- a/drivers/staging/iio/resolver/ad2s1200.c
> +++ b/drivers/staging/iio/resolver/ad2s1200.c
> @@ -14,6 +14,7 @@
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/spi/spi.h>
> @@ -44,8 +45,8 @@
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
> @@ -60,12 +61,12 @@ static int ad2s1200_read_raw(struct iio_dev *indio_dev,
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
> @@ -121,13 +122,18 @@ static int ad2s1200_probe(struct spi_device *spi)
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
> @@ -139,8 +145,25 @@ static int ad2s1200_probe(struct spi_device *spi)
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

