Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52060 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbcL3QjX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Dec 2016 11:39:23 -0500
Subject: Re: [PATCH] iio: adc: TI_AM335X_ADC should depend on HAS_DMA
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Mugunthan V N <mugunthanvnm@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1481718624-7238-1-git-send-email-geert@linux-m68k.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d8fc53e7-ee27-58f0-a117-190753079869@kernel.org>
Date: Fri, 30 Dec 2016 16:39:20 +0000
MIME-Version: 1.0
In-Reply-To: <1481718624-7238-1-git-send-email-geert@linux-m68k.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/12/16 12:30, Geert Uytterhoeven wrote:
> If NO_DMA=y:
> 
>     ERROR: "bad_dma_ops" [drivers/iio/adc/ti_am335x_adc.ko] undefined!
> 
> Add a dependency on HAS_DMA to fix this.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Applied to the fixes-togreg-post-rc1 branch of iio.git (will unwind
this fun branch shortly now we are post rc1) and marked for stable
with an appropriate fixes tag added.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 38bc319904c4c299..9c8b558ba19ecb03 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -561,7 +561,7 @@ config TI_ADS8688
>  
>  config TI_AM335X_ADC
>  	tristate "TI's AM335X ADC driver"
> -	depends on MFD_TI_AM335X_TSCADC
> +	depends on MFD_TI_AM335X_TSCADC && HAS_DMA
>  	select IIO_BUFFER
>  	select IIO_KFIFO_BUF
>  	help
> 

