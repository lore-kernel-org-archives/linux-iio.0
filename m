Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54292 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756719Ab3JNVOE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 14 Oct 2013 17:14:04 -0400
Message-ID: <525C6CD0.1010509@kernel.org>
Date: Mon, 14 Oct 2013 23:14:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2 2/3] staging:iio:mxs-lradc: Select STMP_DEVICE
References: <1381586159-31120-1-git-send-email-lars@metafoo.de> <1381586159-31120-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1381586159-31120-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/12/13 14:55, Lars-Peter Clausen wrote:
> The MXS ADC driver uses the stmp_reset_block() which is only provided when the
> STMP_DEVICE Kconfig symbol is selected. Hence the driver should select this
> symbol. So far this has not been a problem since the driver depends on ARCH_MXS,
> which already selects STMP_DEVICE, but will become necessary once we allow the
> driver to be built when COMPILE_TEST is selected.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Marek Vasut <marex@denx.de>
Applied to the togreg branch of iio.git

Thanks,


> ---
> New in v2
> ---
>  drivers/staging/iio/adc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
> index cabc7a3..52d92a1 100644
> --- a/drivers/staging/iio/adc/Kconfig
> +++ b/drivers/staging/iio/adc/Kconfig
> @@ -114,6 +114,7 @@ config LPC32XX_ADC
>  config MXS_LRADC
>  	tristate "Freescale i.MX23/i.MX28 LRADC"
>  	depends on ARCH_MXS
> +	select STMP_DEVICE
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	help
> 
