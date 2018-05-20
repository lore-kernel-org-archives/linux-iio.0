Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750895AbeETLEl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 May 2018 07:04:41 -0400
Date: Sun, 20 May 2018 12:04:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Veenstra <davidjulianveenstra@gmail.com>
Cc: lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        Michael.Hennerich@analog.com, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 05/12] staging: iio: ad2s1200: Replace legacy gpio
 API with modern API
Message-ID: <20180520120436.57abf51b@archlinux>
In-Reply-To: <78bc9c09403ac1fa08d610a86505416b85edb306.1526667118.git.davidjulianveenstra@gmail.com>
References: <cover.1526667118.git.davidjulianveenstra@gmail.com>
        <78bc9c09403ac1fa08d610a86505416b85edb306.1526667118.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 18 May 2018 20:21:56 +0200
David Veenstra <davidjulianveenstra@gmail.com> wrote:

> The legacy, integer based gpio API is replaced with the modern
> descriptor based API.
> 
> Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
Hmm This is more complex than it needed to be because it
has to do some massaging of the two different methods only
to clean them up in the next patch.

I would have been tempted to combine the two patches or at
the very least add some comments in here that the nastier
corners are about to go away.

Anyhow, not to worry I figured it out slightly before sending
you an email saying not to do it this way ;)

Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/resolver/ad2s1200.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
> index 430cc62591fe..b2c46a8c6b77 100644
> --- a/drivers/staging/iio/resolver/ad2s1200.c
> +++ b/drivers/staging/iio/resolver/ad2s1200.c
> @@ -13,6 +13,7 @@
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/spi/spi.h>
> @@ -43,8 +44,8 @@
>  struct ad2s1200_state {
>  	struct mutex lock;
>  	struct spi_device *sdev;
> -	int sample;
> -	int rdvel;
> +	struct gpio_desc *sample;
> +	struct gpio_desc *rdvel;
>  	__be16 rx ____cacheline_aligned;
>  };
>  
> @@ -58,12 +59,12 @@ static int ad2s1200_read_raw(struct iio_dev *indio_dev,
>  	int ret;
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
>  	ret = spi_read(st->sdev, &st->rx, 2);
>  	if (ret < 0) {
> @@ -133,8 +134,8 @@ static int ad2s1200_probe(struct spi_device *spi)
>  	st = iio_priv(indio_dev);
>  	mutex_init(&st->lock);
>  	st->sdev = spi;
> -	st->sample = pins[0];
> -	st->rdvel = pins[1];
> +	st->sample = gpio_to_desc(pins[0]);
> +	st->rdvel = gpio_to_desc(pins[1]);
>  
>  	indio_dev->dev.parent = &spi->dev;
>  	indio_dev->info = &ad2s1200_info;

