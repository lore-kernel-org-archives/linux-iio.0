Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59288 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753955Ab2BJVrM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 10 Feb 2012 16:47:12 -0500
Message-ID: <4F359094.4080605@kernel.org>
Date: Fri, 10 Feb 2012 21:48:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] staging:iio: Convert remaining drivers to module_spi_driver
References: <1328897859-24628-1-git-send-email-lars@metafoo.de> <1328897859-24628-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1328897859-24628-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/10/2012 06:17 PM, Lars-Peter Clausen wrote:
> Convert the IIO drivers which have not been converted yet to module_spi_driver.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/dac/ad5421.c |   13 +------------
>  drivers/staging/iio/dac/ad5764.c |   13 +------------
>  2 files changed, 2 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/staging/iio/dac/ad5421.c b/drivers/staging/iio/dac/ad5421.c
> index 71ee868..0b040b2 100644
> --- a/drivers/staging/iio/dac/ad5421.c
> +++ b/drivers/staging/iio/dac/ad5421.c
> @@ -536,18 +536,7 @@ static struct spi_driver ad5421_driver = {
>  	.probe = ad5421_probe,
>  	.remove = __devexit_p(ad5421_remove),
>  };
> -
> -static __init int ad5421_init(void)
> -{
> -	return spi_register_driver(&ad5421_driver);
> -}
> -module_init(ad5421_init);
> -
> -static __exit void ad5421_exit(void)
> -{
> -	spi_unregister_driver(&ad5421_driver);
> -}
> -module_exit(ad5421_exit);
> +module_spi_driver(ad5421_driver);
>  
>  MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
>  MODULE_DESCRIPTION("Analog Devices AD5421 DAC");
> diff --git a/drivers/staging/iio/dac/ad5764.c b/drivers/staging/iio/dac/ad5764.c
> index ff91480..f73a730 100644
> --- a/drivers/staging/iio/dac/ad5764.c
> +++ b/drivers/staging/iio/dac/ad5764.c
> @@ -375,18 +375,7 @@ static struct spi_driver ad5764_driver = {
>  	.remove = __devexit_p(ad5764_remove),
>  	.id_table = ad5764_ids,
>  };
> -
> -static int __init ad5764_spi_init(void)
> -{
> -	return spi_register_driver(&ad5764_driver);
> -}
> -module_init(ad5764_spi_init);
> -
> -static void __exit ad5764_spi_exit(void)
> -{
> -	spi_unregister_driver(&ad5764_driver);
> -}
> -module_exit(ad5764_spi_exit);
> +module_spi_driver(ad5764_driver);
>  
>  MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
>  MODULE_DESCRIPTION("Analog Devices AD5744/AD5744R/AD5764/AD5764R DAC");

