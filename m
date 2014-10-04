Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57710 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbaJDLao (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 4 Oct 2014 07:30:44 -0400
Message-ID: <542FDA62.1040306@kernel.org>
Date: Sat, 04 Oct 2014 12:30:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Fabio Estevam <festevam@gmail.com>
CC: B38611@freescale.com, linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH 3/5] iio: adc: vf610: Disable the regulator on error
References: <1412299526-1331-1-git-send-email-festevam@gmail.com> <1412299526-1331-3-git-send-email-festevam@gmail.com>
In-Reply-To: <1412299526-1331-3-git-send-email-festevam@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/10/14 02:25, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> If clk_prepare_enable() fails we should disable the regulator that was 
> previously enabled.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/adc/vf610_adc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> index a9c41ec..ae56753 100644
> --- a/drivers/iio/adc/vf610_adc.c
> +++ b/drivers/iio/adc/vf610_adc.c
> @@ -680,11 +680,15 @@ static int vf610_adc_resume(struct device *dev)
>  
>  	ret = clk_prepare_enable(info->clk);
>  	if (ret)
> -		return ret;
> +		goto disable_reg;
>  
>  	vf610_adc_hw_init(info);
>  
>  	return 0;
> +
> +disable_reg:
> +	regulator_disable(info->vref);
> +	return ret;
>  }
>  #endif
>  
> 
