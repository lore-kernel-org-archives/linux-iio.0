Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57221 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbcCEStc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Mar 2016 13:49:32 -0500
Subject: Re: [PATCH] iio: adc: Fix build error of missing
 devm_ioremap_resource on UM
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <1457053526-28841-1-git-send-email-k.kozlowski@samsung.com>
Cc: Arnd Bergmann <arnd@arndb.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56DB2A37.8040708@kernel.org>
Date: Sat, 5 Mar 2016 18:49:27 +0000
MIME-Version: 1.0
In-Reply-To: <1457053526-28841-1-git-send-email-k.kozlowski@samsung.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/03/16 01:05, Krzysztof Kozlowski wrote:
> The devres.o gets linked if HAS_IOMEM is present so on ARCH=um
> allyesconfig (COMPILE_TEST) failed with:
> 
> drivers/built-in.o: In function `at91_adc_probe':
> at91-sama5d2_adc.c:(.text+0x48f548): undefined reference to `devm_ioremap_resource'
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Applied to the togreg branch of iio.git - initially pushed out as testing for
the autobuilders to play with it.  I may switch this over to a fixes branch
and send it on post merge window (if the merge window starts before my next
pull request).

Jonathan
> ---
>  drivers/iio/adc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index af4aea7b20f9..82c718c515a0 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -134,6 +134,7 @@ config AT91_ADC
>  config AT91_SAMA5D2_ADC
>  	tristate "Atmel AT91 SAMA5D2 ADC"
>  	depends on ARCH_AT91 || COMPILE_TEST
> +	depends on HAS_IOMEM
>  	help
>  	  Say yes here to build support for Atmel SAMA5D2 ADC which is
>  	  available on SAMA5D2 SoC family.
> 

