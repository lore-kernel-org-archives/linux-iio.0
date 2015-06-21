Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44459 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195AbbFUPRM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2015 11:17:12 -0400
Message-ID: <5586D576.1050508@kernel.org>
Date: Sun, 21 Jun 2015 16:17:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	Naidu Tellapati <naidu.tellapati@imgtec.com>,
	Phani Movva <Phani.Movva@imgtec.com>
Subject: Re: [PATCH 2/2] iio:adc:cc10001_adc: resort entry in Kconfig and
 Makefile
References: <cover.1434844874.git.knaack.h@gmx.de> <8b5a272b03bdf2c039edf722b8179690be8909de.1434844874.git.knaack.h@gmx.de>
In-Reply-To: <8b5a272b03bdf2c039edf722b8179690be8909de.1434844874.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/06/15 11:15, Hartmut Knaack wrote:
> Move the entry for the CC 10001 ADC driver in Kconfig and Makefile up to
> maintain alphabetic order.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
As you might have guessed, will have to hold this one for now to let
the fix get through to my togreg tree.
Same for the other patch you sent.

Give me a poke if I look to have forgotten either of them!

Jonathan
> ---
>  drivers/iio/adc/Kconfig  | 18 +++++++++---------
>  drivers/iio/adc/Makefile |  2 +-
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index eb0cd89..4790071 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -142,15 +142,6 @@ config BERLIN2_ADC
>  	  Marvell Berlin2 ADC driver. This ADC has 8 channels, with one used for
>  	  temperature measurement.
>  
> -config DA9150_GPADC
> -	tristate "Dialog DA9150 GPADC driver support"
> -	depends on MFD_DA9150
> -	help
> -	  Say yes here to build support for Dialog DA9150 GPADC.
> -
> -	  This driver can also be built as a module. If chosen, the module name
> -	  will be da9150-gpadc.
> -
>  config CC10001_ADC
>  	tristate "Cosmic Circuits 10001 ADC driver"
>  	depends on HAS_IOMEM && HAVE_CLK && REGULATOR
> @@ -162,6 +153,15 @@ config CC10001_ADC
>  	  This driver can also be built as a module. If so, the module will be
>  	  called cc10001_adc.
>  
> +config DA9150_GPADC
> +	tristate "Dialog DA9150 GPADC driver support"
> +	depends on MFD_DA9150
> +	help
> +	  Say yes here to build support for Dialog DA9150 GPADC.
> +
> +	  This driver can also be built as a module. If chosen, the module name
> +	  will be da9150-gpadc.
> +
>  config EXYNOS_ADC
>  	tristate "Exynos ADC driver support"
>  	depends on ARCH_EXYNOS || ARCH_S3C24XX || ARCH_S3C64XX || (OF && COMPILE_TEST)
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index a096210..fa5723a 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -16,8 +16,8 @@ obj-$(CONFIG_AD799X) += ad799x.o
>  obj-$(CONFIG_AT91_ADC) += at91_adc.o
>  obj-$(CONFIG_AXP288_ADC) += axp288_adc.o
>  obj-$(CONFIG_BERLIN2_ADC) += berlin2-adc.o
> -obj-$(CONFIG_DA9150_GPADC) += da9150-gpadc.o
>  obj-$(CONFIG_CC10001_ADC) += cc10001_adc.o
> +obj-$(CONFIG_DA9150_GPADC) += da9150-gpadc.o
>  obj-$(CONFIG_EXYNOS_ADC) += exynos_adc.o
>  obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
>  obj-$(CONFIG_MAX1027) += max1027.o
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
