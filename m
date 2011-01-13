Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:54471 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756310Ab1AMLBp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 13 Jan 2011 06:01:45 -0500
Message-ID: <4D2EDD50.7060508@cam.ac.uk>
Date: Thu, 13 Jan 2011 11:09:04 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Roland Stigge <rst@work-microwave.de>
CC: linux-iio@vger.kernel.org, Greg KH <greg@kroah.com>,
	Roland Stigge <stigge@antcom.de>
Subject: Re: [PATCH] iio: Fixpoint formatted output bugfix
References: <1294908733-20354-1-git-send-email-rst@work-microwave.de>
In-Reply-To: <1294908733-20354-1-git-send-email-rst@work-microwave.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/13/11 08:52, Roland Stigge wrote:
> From: Roland Stigge <stigge@antcom.de>
> 
> Fix some ADC drivers' _scale interface to correct fixpoint formatted output
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> Acked-by: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Acked-by: "Jonathan Cameron <jic23@cam.ac.uk>"

Greg, this is a simple bug fix. The ad7476 and ad799x are in 2.6.37
so it would be good to push this to stable as well.
Do you want a broken out patch with just those two in it?

> 
> ---
>  drivers/staging/iio/adc/ad7476_core.c |    2 +-
>  drivers/staging/iio/adc/ad7887_core.c |    2 +-
>  drivers/staging/iio/adc/ad799x_core.c |    2 +-
>  drivers/staging/iio/dac/ad5446.c      |    2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
> index deb68c8..b8b54da 100644
> --- a/drivers/staging/iio/adc/ad7476_core.c
> +++ b/drivers/staging/iio/adc/ad7476_core.c
> @@ -68,7 +68,7 @@ static ssize_t ad7476_show_scale(struct device *dev,
>  	/* Corresponds to Vref / 2^(bits) */
>  	unsigned int scale_uv = (st->int_vref_mv * 1000) >> st->chip_info->bits;
>  
> -	return sprintf(buf, "%d.%d\n", scale_uv / 1000, scale_uv % 1000);
> +	return sprintf(buf, "%d.%03d\n", scale_uv / 1000, scale_uv % 1000);
>  }
>  static IIO_DEVICE_ATTR(in_scale, S_IRUGO, ad7476_show_scale, NULL, 0);
>  
> diff --git a/drivers/staging/iio/adc/ad7887_core.c b/drivers/staging/iio/adc/ad7887_core.c
> index 6859089..5d85efa 100644
> --- a/drivers/staging/iio/adc/ad7887_core.c
> +++ b/drivers/staging/iio/adc/ad7887_core.c
> @@ -68,7 +68,7 @@ static ssize_t ad7887_show_scale(struct device *dev,
>  	/* Corresponds to Vref / 2^(bits) */
>  	unsigned int scale_uv = (st->int_vref_mv * 1000) >> st->chip_info->bits;
>  
> -	return sprintf(buf, "%d.%d\n", scale_uv / 1000, scale_uv % 1000);
> +	return sprintf(buf, "%d.%03d\n", scale_uv / 1000, scale_uv % 1000);
>  }
>  static IIO_DEVICE_ATTR(in_scale, S_IRUGO, ad7887_show_scale, NULL, 0);
>  
> diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
> index 6309d52..89ccf37 100644
> --- a/drivers/staging/iio/adc/ad799x_core.c
> +++ b/drivers/staging/iio/adc/ad799x_core.c
> @@ -432,7 +432,7 @@ static ssize_t ad799x_show_scale(struct device *dev,
>  	/* Corresponds to Vref / 2^(bits) */
>  	unsigned int scale_uv = (st->int_vref_mv * 1000) >> st->chip_info->bits;
>  
> -	return sprintf(buf, "%d.%d\n", scale_uv / 1000, scale_uv % 1000);
> +	return sprintf(buf, "%d.%03d\n", scale_uv / 1000, scale_uv % 1000);
>  }
>  
>  static IIO_DEVICE_ATTR(in_scale, S_IRUGO, ad799x_show_scale, NULL, 0);
> diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
> index e3387cd..0f87eca 100644
> --- a/drivers/staging/iio/dac/ad5446.c
> +++ b/drivers/staging/iio/dac/ad5446.c
> @@ -87,7 +87,7 @@ static ssize_t ad5446_show_scale(struct device *dev,
>  	/* Corresponds to Vref / 2^(bits) */
>  	unsigned int scale_uv = (st->vref_mv * 1000) >> st->chip_info->bits;
>  
> -	return sprintf(buf, "%d.%d\n", scale_uv / 1000, scale_uv % 1000);
> +	return sprintf(buf, "%d.%03d\n", scale_uv / 1000, scale_uv % 1000);
>  }
>  static IIO_DEVICE_ATTR(out_scale, S_IRUGO, ad5446_show_scale, NULL, 0);
>  

