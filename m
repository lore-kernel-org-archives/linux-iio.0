Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750966AbeETLBt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 May 2018 07:01:49 -0400
Date: Sun, 20 May 2018 12:01:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Veenstra <davidjulianveenstra@gmail.com>
Cc: lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        Michael.Hennerich@analog.com, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 06/12] staging: iio: ad2s1200: Replace platform data
 with dt bindings
Message-ID: <20180520120143.075b5bbd@archlinux>
In-Reply-To: <6beef6b7514c53f4fac77d661dcae139b55935bf.1526667118.git.davidjulianveenstra@gmail.com>
References: <cover.1526667118.git.davidjulianveenstra@gmail.com>
        <6beef6b7514c53f4fac77d661dcae139b55935bf.1526667118.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 18 May 2018 20:22:32 +0200
David Veenstra <davidjulianveenstra@gmail.com> wrote:

> Remove usage of platform data, and replace it with device tree
> facilities.
> 
> Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
Great,

Applied to the togreg branch of iio.git and pushed out as testing.

I think the dt bindings that match this are uncontroversial in
what they actually are (comments to follow on that patch) so
should be no problem with this one.

Jonathan

> ---
> Changes in v4:
>  - Added vendor prefix to gpio function names.
> 
>  drivers/staging/iio/resolver/ad2s1200.c | 32 ++++++++++++-------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
> index b2c46a8c6b77..9a8aa2448897 100644
> --- a/drivers/staging/iio/resolver/ad2s1200.c
> +++ b/drivers/staging/iio/resolver/ad2s1200.c
> @@ -25,9 +25,6 @@
>  
>  #define DRV_NAME "ad2s1200"
>  
> -/* input pin sample and rdvel is controlled by driver */
> -#define AD2S1200_PN	2
> -
>  /* input clock on serial interface */
>  #define AD2S1200_HZ	8192000
>  /* clock period in nano second */
> @@ -111,20 +108,9 @@ static const struct iio_info ad2s1200_info = {
>  
>  static int ad2s1200_probe(struct spi_device *spi)
>  {
> -	unsigned short *pins = spi->dev.platform_data;
>  	struct ad2s1200_state *st;
>  	struct iio_dev *indio_dev;
> -	int pn, ret;
> -
> -	for (pn = 0; pn < AD2S1200_PN; pn++) {
> -		ret = devm_gpio_request_one(&spi->dev, pins[pn], GPIOF_DIR_OUT,
> -					    DRV_NAME);
> -		if (ret) {
> -			dev_err(&spi->dev, "request gpio pin %d failed\n",
> -				pins[pn]);
> -			return ret;
> -		}
> -	}
> +	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (!indio_dev)
> @@ -134,8 +120,20 @@ static int ad2s1200_probe(struct spi_device *spi)
>  	st = iio_priv(indio_dev);
>  	mutex_init(&st->lock);
>  	st->sdev = spi;
> -	st->sample = gpio_to_desc(pins[0]);
> -	st->rdvel = gpio_to_desc(pins[1]);
> +
> +	st->sample = devm_gpiod_get(&spi->dev, "adi,sample", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->sample)) {
> +		dev_err(&spi->dev, "Failed to claim SAMPLE gpio: err=%ld\n",
> +			PTR_ERR(st->sample));
> +		return PTR_ERR(st->sample);
> +	}
> +
> +	st->rdvel = devm_gpiod_get(&spi->dev, "adi,rdvel", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->rdvel)) {
> +		dev_err(&spi->dev, "Failed to claim RDVEL gpio: err=%ld\n",
> +			PTR_ERR(st->rdvel));
> +		return PTR_ERR(st->rdvel);
> +	}
>  
>  	indio_dev->dev.parent = &spi->dev;
>  	indio_dev->info = &ad2s1200_info;

