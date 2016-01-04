Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33273 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753661AbcADLiN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jan 2016 06:38:13 -0500
Subject: Re: [PATCH 2/2] iio: add HAS_IOMEM dependency to VF610_ADC
To: Vegard Nossum <vegard.nossum@oracle.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
References: <1451739880-14178-2-git-send-email-vegard.nossum@oracle.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <568A59A4.2010101@kernel.org>
Date: Mon, 4 Jan 2016 11:38:12 +0000
MIME-Version: 1.0
In-Reply-To: <1451739880-14178-2-git-send-email-vegard.nossum@oracle.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/01/16 13:04, Vegard Nossum wrote:
> Ran into this on UML:
> 
> drivers/built-in.o: In function `vf610_adc_probe':
> drivers/iio/adc/vf610_adc.c:744: undefined reference to `devm_ioremap_resource'
> 
> devm_ioremap_resource() is defined only when HAS_IOMEM is selected.
> 
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: linux-iio@vger.kernel.org

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 7868c74..1e7aded 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -372,6 +372,7 @@ config TWL6030_GPADC
>  config VF610_ADC
>  	tristate "Freescale vf610 ADC driver"
>  	depends on OF
> +	depends on HAS_IOMEM
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	help
> 

