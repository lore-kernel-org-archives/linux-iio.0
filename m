Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56356 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932151Ab3JQVM5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 17 Oct 2013 17:12:57 -0400
Message-ID: <52606106.7010904@kernel.org>
Date: Thu, 17 Oct 2013 23:13:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org, Roland Stigge <stigge@antcom.de>
Subject: Re: [PATCH 1/2] staging:iio:lpc32xx_adc: Fix IRQ check
References: <1381956352-13311-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1381956352-13311-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/16/13 21:45, Lars-Peter Clausen wrote:
> The test in the lpc32xx_adc driver which checks whether the IRQ number returned
> by platform_get_irq() has multiple problems. It accepts 0 even though this is an
> invalid IRQ. It also rejects IRQ numbers that are larger or equal than NR_IRQS.
> First of all drivers should never need to reference NR_IRQS and secondly with
> CONFIG_SPARSE_IRQ NR_IRQS is not the upper limit, so the check might reject
> valid IRQ numbers. This patch modifies the check to only test against less or
> equal to 0.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Cc: Roland Stigge <stigge@antcom.de>
Applied to the togreg branch of iio.git

Thanks,

Jonathan
> ---
>  drivers/staging/iio/adc/lpc32xx_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/lpc32xx_adc.c b/drivers/staging/iio/adc/lpc32xx_adc.c
> index ce7ff3e..ef0a21d 100644
> --- a/drivers/staging/iio/adc/lpc32xx_adc.c
> +++ b/drivers/staging/iio/adc/lpc32xx_adc.c
> @@ -160,7 +160,7 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
>  	}
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if ((irq < 0) || (irq >= NR_IRQS)) {
> +	if (irq <= 0) {
>  		dev_err(&pdev->dev, "failed getting interrupt resource\n");
>  		return -EINVAL;
>  	}
> 
