Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57718 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbaJDLbQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 4 Oct 2014 07:31:16 -0400
Message-ID: <542FDA83.90101@kernel.org>
Date: Sat, 04 Oct 2014 12:31:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Fabio Estevam <festevam@gmail.com>
CC: B38611@freescale.com, linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH 4/5] iio: adc: vf610: SIMPLE_DEV_PM_OPS can fit on a single
 line
References: <1412299526-1331-1-git-send-email-festevam@gmail.com> <1412299526-1331-4-git-send-email-festevam@gmail.com>
In-Reply-To: <1412299526-1331-4-git-send-email-festevam@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/10/14 02:25, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> No need to call the SIMPLE_DEV_PM_OPS() macro in several lines.
> 
> It can fit into the 80-column range.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Applied
> ---
>  drivers/iio/adc/vf610_adc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> index ae56753..6164558 100644
> --- a/drivers/iio/adc/vf610_adc.c
> +++ b/drivers/iio/adc/vf610_adc.c
> @@ -692,9 +692,7 @@ disable_reg:
>  }
>  #endif
>  
> -static SIMPLE_DEV_PM_OPS(vf610_adc_pm_ops,
> -			vf610_adc_suspend,
> -			vf610_adc_resume);
> +static SIMPLE_DEV_PM_OPS(vf610_adc_pm_ops, vf610_adc_suspend, vf610_adc_resume);
>  
>  static struct platform_driver vf610_adc_driver = {
>  	.probe          = vf610_adc_probe,
> 
