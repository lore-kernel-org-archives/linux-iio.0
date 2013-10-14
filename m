Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54284 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756719Ab3JNVNv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 14 Oct 2013 17:13:51 -0400
Message-ID: <525C6CC2.7050109@kernel.org>
Date: Mon, 14 Oct 2013 23:14:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v2 1/3] staging:iio:spear_adc: Fix sparse warning
References: <1381586159-31120-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1381586159-31120-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/12/13 14:55, Lars-Peter Clausen wrote:
> The driver is casting from one __iomem pointer to another. Make sure to include
> __iomem in the cast, otherwise sparse will complain with the following warning:
> 
> 	drivers/staging/iio/adc/spear_adc.c:321:18: warning: cast removes address space of expression
> 	drivers/staging/iio/adc/spear_adc.c:320:33: warning: incorrect type in assignment (different address spaces)
> 	drivers/staging/iio/adc/spear_adc.c:320:33:    expected struct adc_regs_spear3xx [noderef] <asn:2>*adc_base_spear3xx
> 	drivers/staging/iio/adc/spear_adc.c:320:33:    got struct adc_regs_spear3xx *<noident>
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Stefan Roese <sr@denx.de>
Applied to the togreg branch of iio.git

Seems to have cleaned up that warning nicely.

Thanks Lars,


> ---
> New in v2
> ---
>  drivers/staging/iio/adc/spear_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/spear_adc.c b/drivers/staging/iio/adc/spear_adc.c
> index fc99598..e6555b6 100644
> --- a/drivers/staging/iio/adc/spear_adc.c
> +++ b/drivers/staging/iio/adc/spear_adc.c
> @@ -318,7 +318,7 @@ static int spear_adc_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
>  	info->adc_base_spear3xx =
> -		(struct adc_regs_spear3xx *)info->adc_base_spear6xx;
> +		(struct adc_regs_spear3xx __iomem *)info->adc_base_spear6xx;
>  
>  	info->clk = clk_get(dev, NULL);
>  	if (IS_ERR(info->clk)) {
> 
