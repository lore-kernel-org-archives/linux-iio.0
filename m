Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46384 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752559AbcKSLYn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 19 Nov 2016 06:24:43 -0500
Subject: Re: [PATCH] staging: iio: ad9832:
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org, eraretuya@gmail.com
References: <20161119110834.25025-1-christophe.jaillet@wanadoo.fr>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <57c94e39-fbc5-d354-41a7-c1d1a747fc52@kernel.org>
Date: Sat, 19 Nov 2016 11:24:40 +0000
MIME-Version: 1.0
In-Reply-To: <20161119110834.25025-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/11/16 11:08, Christophe JAILLET wrote:
> Commit a98461d79ba5 ("staging: iio: ad9832: add DVDD regulator") and
> commit 43a07e48af44 ("staging: iio: ad9832: clean-up regulator 'reg'") add
> some dereference of 'st' which is an un-initialized pointer at this point.
> 
> Re-order code and tweak error handling in order to allocate memory and have
> 'st' be a valid pointer before using it.
> 
> Fixes: a98461d79ba5 ("staging: iio: ad9832: add DVDD regulator")
> Fixes: 43a07e48af44 ("staging: iio: ad9832: clean-up regulator 'reg'")
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Thanks but fixed already.
6826fdbd2 "staging: iio: ad9832: allocate data before using
Arnd Bergmann

Jonathan  
> ---
> Compile tested only
> ---
>  drivers/staging/iio/frequency/ad9832.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 639047fade30..16894836f982 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -211,6 +211,15 @@ static int ad9832_probe(struct spi_device *spi)
>  		return -ENODEV;
>  	}
>  
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	spi_set_drvdata(spi, indio_dev);
> +	st = iio_priv(indio_dev);
> +	st->mclk = pdata->mclk;
> +	st->spi = spi;
> +
>  	st->avdd = devm_regulator_get(&spi->dev, "avdd");
>  	if (IS_ERR(st->avdd))
>  		return PTR_ERR(st->avdd);
> @@ -233,16 +242,6 @@ static int ad9832_probe(struct spi_device *spi)
>  		goto error_disable_avdd;
>  	}
>  
> -	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> -	if (!indio_dev) {
> -		ret = -ENOMEM;
> -		goto error_disable_dvdd;
> -	}
> -	spi_set_drvdata(spi, indio_dev);
> -	st = iio_priv(indio_dev);
> -	st->mclk = pdata->mclk;
> -	st->spi = spi;
> -
>  	indio_dev->dev.parent = &spi->dev;
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  	indio_dev->info = &ad9832_info;
> 

