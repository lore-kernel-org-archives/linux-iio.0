Return-Path: <lars@metafoo.de>
Message-ID: <5252B6BB.8020902@metafoo.de>
Date: Mon, 07 Oct 2013 15:27:23 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 Stefan Roese <sr@denx.de>,
 Roland Stigge <stigge@antcom.de>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 2/2] staging:iio: Allow to build SoC specific drivers
 when COMPILE_TEST is set
References: <1381152374-16567-1-git-send-email-lars@metafoo.de> <1381152374-16567-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1381152374-16567-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 10/07/2013 03:26 PM, Lars-Peter Clausen wrote:
> None of the SPEAr, LPC32XX or MXS ADC drivers have a compile time dependency on
> their respective platform. So make it possible to build the drivers when
> CONFIG_COMPILE_TEST is set. This makes it easier to compile test changes.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Stefan Roese <sr@denx.de>
> Cc: Marek Vasut <marex@denx.de

Missing > here, added Marek to Cc manually

> Cc: Roland Stigge <stigge@antcom.de>
> ---
>  drivers/staging/iio/adc/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
> index cabc7a3..58af3ae 100644
> --- a/drivers/staging/iio/adc/Kconfig
> +++ b/drivers/staging/iio/adc/Kconfig
> @@ -102,7 +102,7 @@ config AD7280
>  
>  config LPC32XX_ADC
>  	tristate "NXP LPC32XX ADC"
> -	depends on ARCH_LPC32XX
> +	depends on ARCH_LPC32XX || COMPILE_TEST
>  	help
>  	  Say yes here to build support for the integrated ADC inside the
>  	  LPC32XX SoC. Note that this feature uses the same hardware as the
> @@ -113,7 +113,7 @@ config LPC32XX_ADC
>  
>  config MXS_LRADC
>  	tristate "Freescale i.MX23/i.MX28 LRADC"
> -	depends on ARCH_MXS
> +	depends on ARCH_MXS || COMPILE_TEST
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	help
> @@ -125,7 +125,7 @@ config MXS_LRADC
>  
>  config SPEAR_ADC
>  	tristate "ST SPEAr ADC"
> -	depends on PLAT_SPEAR
> +	depends on PLAT_SPEAR || COMPILE_TEST
>  	help
>  	  Say yes here to build support for the integrated ADC inside the
>  	  ST SPEAr SoC. Provides direct access via sysfs.
> 
