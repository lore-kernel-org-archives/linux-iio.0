Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54303 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756719Ab3JNVOn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 14 Oct 2013 17:14:43 -0400
Message-ID: <525C6CF7.3070407@kernel.org>
Date: Mon, 14 Oct 2013 23:15:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org, Stefan Roese <sr@denx.de>,
	Roland Stigge <stigge@antcom.de>
Subject: Re: [PATCH v2 3/3] staging:iio: Allow to build SoC specific drivers
 when COMPILE_TEST is set
References: <1381586159-31120-1-git-send-email-lars@metafoo.de> <1381586159-31120-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1381586159-31120-3-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/12/13 14:55, Lars-Peter Clausen wrote:
> None of the SPEAr, LPC32XX or MXS ADC drivers have a compile time dependency on
> their respective platform. So make it possible to build the drivers when
> CONFIG_COMPILE_TEST is set. This makes it easier to compile test changes.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Reviewed-by: Marek Vasut <marex@denx.de>
> Cc: Stefan Roese <sr@denx.de>
> Cc: Roland Stigge <stigge@antcom.de>
Applied to the togreg branch of iio.git

Thanks.  Definitely nice to be able to build test these without rumaging around
for suitable config :)

Jonathan
> ---
> No changes in v2, but fixed up a linker error and a sparse warning in patch 1
> and 2 in this series.
> ---
>  drivers/staging/iio/adc/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
> index 52d92a1..1cf4764 100644
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
>  	select STMP_DEVICE
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
> @@ -126,7 +126,7 @@ config MXS_LRADC
>  
>  config SPEAR_ADC
>  	tristate "ST SPEAr ADC"
> -	depends on PLAT_SPEAR
> +	depends on PLAT_SPEAR || COMPILE_TEST
>  	help
>  	  Say yes here to build support for the integrated ADC inside the
>  	  ST SPEAr SoC. Provides direct access via sysfs.
> 
