Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750946AbdFTQu0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 20 Jun 2017 12:50:26 -0400
Date: Tue, 20 Jun 2017 17:50:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-iio@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH] iio: adc: Kconfig: Append vendor name for IMX7D_ADC
Message-ID: <20170620175022.18ee0f7d@kernel.org>
In-Reply-To: <1497733216-14848-1-git-send-email-festevam@gmail.com>
References: <1497733216-14848-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 17 Jun 2017 18:00:16 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> To keep IMX7D_ADC text consistent with other iio/adc entries, add
> the vendor name to the driver menu text.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Applied to the togreg branch of iio.git and pushed out as testing
whilst the autobuilders play with the other patches.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 614fa41..b56c4a1 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -322,7 +322,7 @@ config INA2XX_ADC
>  	  This driver is mutually exclusive with the HWMON version.
>  
>  config IMX7D_ADC
> -	tristate "IMX7D ADC driver"
> +	tristate "Freescale IMX7D ADC driver"
>  	depends on ARCH_MXC || COMPILE_TEST
>  	depends on HAS_IOMEM
>  	help

