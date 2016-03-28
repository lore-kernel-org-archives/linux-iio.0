Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44118 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754026AbcC1Iog (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Mar 2016 04:44:36 -0400
Subject: Re: [PATCH 6/8] iio: adc: Fix at91-sama5d2_adc dependencies
To: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org
References: <1458945655-5027-1-git-send-email-richard@nod.at>
 <1458945655-5027-6-git-send-email-richard@nod.at>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Ludovic Desroches <ludovic.desroches@atmel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56F8EEF1.7020706@kernel.org>
Date: Mon, 28 Mar 2016 09:44:33 +0100
MIME-Version: 1.0
In-Reply-To: <1458945655-5027-6-git-send-email-richard@nod.at>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/03/16 22:40, Richard Weinberger wrote:
> Not all archs have io memory.
> 
> Fixes the following build error:
> ERROR: "devm_ioremap_resource" [drivers/iio/adc/at91-sama5d2_adc.ko] undefined!
> 
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
> Fixes: b9cd7a25 ("MAINTAINERS: add entry for Atmel SAMA5D2 ADC driver")
> Signed-off-by: Richard Weinberger <richard@nod.at>
Hi Richard,

I already have a patch queued up covering this, it just hit at exactly the wrong
moment compared to the merge window so hasn't made it upstream yet.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index af4aea7..31fa2e7 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -133,6 +133,7 @@ config AT91_ADC
>  
>  config AT91_SAMA5D2_ADC
>  	tristate "Atmel AT91 SAMA5D2 ADC"
> +	depends on HAS_IOMEM
>  	depends on ARCH_AT91 || COMPILE_TEST
>  	help
>  	  Say yes here to build support for Atmel SAMA5D2 ADC which is
> 

