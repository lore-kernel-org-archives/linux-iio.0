Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33889 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752605AbcKSLr4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 19 Nov 2016 06:47:56 -0500
Date: Sat, 19 Nov 2016 19:47:52 +0800
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] staging: iio: ad9832:
Message-ID: <20161119114751.GA443@Socrates-DK>
References: <20161119110834.25025-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161119110834.25025-1-christophe.jaillet@wanadoo.fr>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Nov 19, 2016 at 12:08:34PM +0100, Christophe JAILLET wrote:
> Commit a98461d79ba5 ("staging: iio: ad9832: add DVDD regulator") and
> commit 43a07e48af44 ("staging: iio: ad9832: clean-up regulator 'reg'") add
> some dereference of 'st' which is an un-initialized pointer at this point.
> 
> Re-order code and tweak error handling in order to allocate memory and have
> 'st' be a valid pointer before using it.

Hello,

Thanks for the patch but this fix was already submitted and applied:
https://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=6826fdbd2e207f8107e65c5a372ac616e7af11b4

Eva

> 
> Fixes: a98461d79ba5 ("staging: iio: ad9832: add DVDD regulator")
> Fixes: 43a07e48af44 ("staging: iio: ad9832: clean-up regulator 'reg'")
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
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
> -- 
> 2.9.3
> 
