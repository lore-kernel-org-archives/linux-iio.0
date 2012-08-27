Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57523 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754318Ab2H0UQt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Aug 2012 16:16:49 -0400
Message-ID: <503BD5AE.8050304@kernel.org>
Date: Mon, 27 Aug 2012 21:16:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Julia Lawall <Julia.Lawall@lip6.fr>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
	kernel-janitors@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] drivers/iio/adc/at91_adc.c: adjust inconsistent IS_ERR
 and PTR_ERR
References: <1345924629-16584-1-git-send-email-Julia.Lawall@lip6.fr> <1345924629-16584-7-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1345924629-16584-7-git-send-email-Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/25/2012 08:57 PM, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Change the call to PTR_ERR to access the value just tested by IS_ERR.
> 
> The semantic match that finds this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression e,e1;
> @@
> 
> (
> if (IS_ERR(e)) { ... PTR_ERR(e) ... }
> |
> if (IS_ERR(e=e1)) { ... PTR_ERR(e) ... }
> |
> *if (IS_ERR(e))
>  { ...
> *  PTR_ERR(e1)
>    ... }
> )
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Thanks Julia and keep up the good work!

I've merge this one with a bit of fuzz to
git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git

fixes-togreg
> 
> ---
>  drivers/iio/adc/at91_adc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 98c96f9..8650281 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -604,7 +604,7 @@ static int __devinit at91_adc_probe(struct platform_device *pdev)
>  	st->adc_clk = devm_clk_get(&pdev->dev, "adc_op_clk");
>  	if (IS_ERR(st->adc_clk)) {
>  		dev_err(&pdev->dev, "Failed to get the ADC clock.\n");
> -		ret = PTR_ERR(st->clk);
> +		ret = PTR_ERR(st->adc_clk);
>  		goto error_disable_clk;
>  	}
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
