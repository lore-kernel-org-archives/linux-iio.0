Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752786AbeDUQu5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Apr 2018 12:50:57 -0400
Date: Sat, 21 Apr 2018 17:50:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Veenstra <davidjulianveenstra@gmail.com>
Cc: lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        Michael.Hennerich@analog.com, knaack.h@gmx.de,
        daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 06/13] staging: iio: ad2s1200: Introduce variable for
 repeated value
Message-ID: <20180421175051.05f7e1b1@archlinux>
In-Reply-To: <6ec9752ef32af09d0f0f419030be09d1dec68c6d.1524247563.git.davidjulianveenstra@gmail.com>
References: <cover.1524247563.git.davidjulianveenstra@gmail.com>
        <6ec9752ef32af09d0f0f419030be09d1dec68c6d.1524247563.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 20 Apr 2018 21:30:19 +0200
David Veenstra <davidjulianveenstra@gmail.com> wrote:

> Add variable to hold &spi->dev in ad2s1200_probe. This value is repeatedly
> used in ad2s1200_probe.
> 
> Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
No significant gain in readability.   Perhaps even a slight lost I'm
going to say no to this one.

Jonathan

> ---
>  drivers/staging/iio/resolver/ad2s1200.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
> index f07aab7e7a35..0a5fc9917e32 100644
> --- a/drivers/staging/iio/resolver/ad2s1200.c
> +++ b/drivers/staging/iio/resolver/ad2s1200.c
> @@ -117,19 +117,22 @@ static int ad2s1200_probe(struct spi_device *spi)
>  	unsigned short *pins = spi->dev.platform_data;
>  	struct ad2s1200_state *st;
>  	struct iio_dev *indio_dev;
> +	struct device *dev;
>  	int pn, ret = 0;
>  
> +	dev = &spi->dev;
> +
>  	for (pn = 0; pn < AD2S1200_PN; pn++) {
> -		ret = devm_gpio_request_one(&spi->dev, pins[pn], GPIOF_DIR_OUT,
> +		ret = devm_gpio_request_one(dev, pins[pn], GPIOF_DIR_OUT,
>  					    DRV_NAME);
>  		if (ret) {
> -			dev_err(&spi->dev, "request gpio pin %d failed\n",
> +			dev_err(dev, "request gpio pin %d failed\n",
>  				pins[pn]);
>  			return ret;
>  		}
>  	}
>  
> -	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> @@ -140,14 +143,14 @@ static int ad2s1200_probe(struct spi_device *spi)
>  	st->sample = pins[0];
>  	st->rdvel = pins[1];
>  
> -	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->dev.parent = dev;
>  	indio_dev->info = &ad2s1200_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = ad2s1200_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(ad2s1200_channels);
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  
> -	ret = devm_iio_device_register(&spi->dev, indio_dev);
> +	ret = devm_iio_device_register(dev, indio_dev);
>  	if (ret)
>  		return ret;
>  

