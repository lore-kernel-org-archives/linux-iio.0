Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53627 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376Ab3G0Ksn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 27 Jul 2013 06:48:43 -0400
Message-ID: <51F3B39D.4060108@kernel.org>
Date: Sat, 27 Jul 2013 12:48:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, rachna@ti.com
Subject: Re: [PATCH 2/2] iio: adc: Update ti_am335x_adc Kconfig entry
References: <1374569212-26143-1-git-send-email-sachin.kamat@linaro.org> <1374569212-26143-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1374569212-26143-2-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/23/13 09:46, Sachin Kamat wrote:
> Make the string more readable to distinguish it from other TI ADCs.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Very sensible.

Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/adc/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index dd6bd1b..f725b45 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -165,7 +165,7 @@ config TI_ADC081C
>  	  called ti-adc081c.
>  
>  config TI_AM335X_ADC
> -	tristate "TI's ADC driver"
> +	tristate "TI's AM335X ADC driver"
>  	depends on MFD_TI_AM335X_TSCADC
>  	help
>  	  Say yes here to build support for Texas Instruments ADC
> 
