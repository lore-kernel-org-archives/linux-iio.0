Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57693 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973AbaJDL2V (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 4 Oct 2014 07:28:21 -0400
Message-ID: <542FD9D3.6040909@kernel.org>
Date: Sat, 04 Oct 2014 12:28:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Fabio Estevam <festevam@gmail.com>
CC: B38611@freescale.com, linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH 2/5] iio: adc: vf610: Return the error code directly
References: <1412299526-1331-1-git-send-email-festevam@gmail.com> <1412299526-1331-2-git-send-email-festevam@gmail.com>
In-Reply-To: <1412299526-1331-2-git-send-email-festevam@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/10/14 02:25, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> There is no need to pass the error clock code to the variable 'ret'.
> 
> Just return the error directly.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Applied to the togreg branch of iio.git.

Thanks,
> ---
>  drivers/iio/adc/vf610_adc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> index c259901..a9c41ec 100644
> --- a/drivers/iio/adc/vf610_adc.c
> +++ b/drivers/iio/adc/vf610_adc.c
> @@ -586,8 +586,7 @@ static int vf610_adc_probe(struct platform_device *pdev)
>  	if (IS_ERR(info->clk)) {
>  		dev_err(&pdev->dev, "failed getting clock, err = %ld\n",
>  						PTR_ERR(info->clk));
> -		ret = PTR_ERR(info->clk);
> -		return ret;
> +		return PTR_ERR(info->clk);
>  	}
>  
>  	info->vref = devm_regulator_get(&pdev->dev, "vref");
> 
