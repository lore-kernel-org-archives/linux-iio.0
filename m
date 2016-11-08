Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41861 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752640AbcKHUYZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Nov 2016 15:24:25 -0500
Subject: Re: [PATCH] staging: iio: ad9832: allocate data before using
To: Arnd Bergmann <arnd@arndb.de>
References: <20161108140115.2250646-1-arnd@arndb.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eva Rachel Retuya <eraretuya@gmail.com>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <da8491e9-9730-2f5b-ada7-01588b63a545@kernel.org>
Date: Tue, 8 Nov 2016 20:24:18 +0000
MIME-Version: 1.0
In-Reply-To: <20161108140115.2250646-1-arnd@arndb.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/11/16 14:00, Arnd Bergmann wrote:
> The regulator changes assigned data to an uninitialized pointer:
> 
> drivers/staging/iio/frequency/ad9832.c: In function 'ad9832_probe':
> drivers/staging/iio/frequency/ad9832.c:214:11: error: 'st' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> This moves the allocation of the 'st' structure before its first
> use, as it should have been.
> 
> Fixes: 43a07e48af44 ("staging: iio: ad9832: clean-up regulator 'reg'")
> Fixes: a98461d79ba5 ("staging: iio: ad9832: add DVDD regulator")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Thanks Arnd.

I think I've gotten too reliant on zero day and clearly am not checking my local
build warnings closely enough.  Time to go back to doing pre push out checks more
thoroughly.

Anyhow, applied to the togreg branch of iio.git.  Will probably be the weekend
at least before I send another pull request.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/frequency/ad9832.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 639047fade30..a5b2f068168d 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -211,6 +211,13 @@ static int ad9832_probe(struct spi_device *spi)
>  		return -ENODEV;
>  	}
>  
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	spi_set_drvdata(spi, indio_dev);
> +	st = iio_priv(indio_dev);
> +
>  	st->avdd = devm_regulator_get(&spi->dev, "avdd");
>  	if (IS_ERR(st->avdd))
>  		return PTR_ERR(st->avdd);
> @@ -233,13 +240,6 @@ static int ad9832_probe(struct spi_device *spi)
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
>  	st->mclk = pdata->mclk;
>  	st->spi = spi;
>  
> 

