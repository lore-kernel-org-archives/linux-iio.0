Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751597AbdJHKoH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Oct 2017 06:44:07 -0400
Date: Sun, 8 Oct 2017 11:44:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-iio@vger.kernel.org,
        Jack Andersen <jackoalan@gmail.com>,
        kbuild test robot <fengguang.wu@intel.com>
Subject: Re: [PATCH] iio: adc: dln2-adc: fix build error
Message-ID: <20171008114403.68002f32@archlinux>
In-Reply-To: <af332f59-daae-1140-cb89-ebc179b0d2f4@infradead.org>
References: <af332f59-daae-1140-cb89-ebc179b0d2f4@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 7 Oct 2017 16:53:20 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> The dln2-adc driver uses interface(s) that are controlled by the
> IIO_TRIGGERED_BUFFER Kconfig symbol, so the driver needs to select
> that symbol to prevent the build error.
> 
> drivers/iio/adc/dln2-adc.o: In function `dln2_adc_probe':
> dln2-adc.c:(.text+0x528): undefined reference to `devm_iio_triggered_buffer_setup'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: linux-iio@vger.kernel.org
> Cc: Jack Andersen <jackoalan@gmail.com>

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/Kconfig |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- lnx-414-rc3.orig/drivers/iio/adc/Kconfig
> +++ lnx-414-rc3/drivers/iio/adc/Kconfig
> @@ -243,6 +243,8 @@ config DA9150_GPADC
>  config DLN2_ADC
>  	tristate "Diolan DLN-2 ADC driver support"
>  	depends on MFD_DLN2
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to build support for Diolan DLN-2 ADC.
>  
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

