Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57678 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbaJDL1B (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 4 Oct 2014 07:27:01 -0400
Message-ID: <542FD980.5050607@kernel.org>
Date: Sat, 04 Oct 2014 12:26:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Fabio Estevam <festevam@gmail.com>
CC: B38611@freescale.com, linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH 1/5] iio: adc: vf610: Propagate the real error when platform_get_irq()
 fails
References: <1412299526-1331-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1412299526-1331-1-git-send-email-festevam@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/10/14 02:25, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> There is no need to pass a 'fake' return value when platform_get_irq() fails.
> 
> Propagate the real error instead. 
> 
> While at it, only consider negative numbers returned by platform_get_irq()
> as error.
Returning an irq of 0 is still invalid isn't it?
(there was a lot of 'fun' making this true for Arm a few years back).
Doesn't it effectively mean no irq is present?

Naturally I may have missed a change where it is allowed again!
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/iio/adc/vf610_adc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> index 4a10ae9..c259901 100644
> --- a/drivers/iio/adc/vf610_adc.c
> +++ b/drivers/iio/adc/vf610_adc.c
> @@ -569,9 +569,9 @@ static int vf610_adc_probe(struct platform_device *pdev)
>  		return PTR_ERR(info->regs);
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq <= 0) {
> +	if (irq < 0) {
>  		dev_err(&pdev->dev, "no irq resource?\n");
> -		return -EINVAL;
> +		return irq;
>  	}
>  
>  	ret = devm_request_irq(info->dev, irq,
> 
