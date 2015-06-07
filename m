Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47793 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511AbbFGQ2l (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 7 Jun 2015 12:28:41 -0400
Message-ID: <55747137.8060102@kernel.org>
Date: Sun, 07 Jun 2015 17:28:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Fabio Estevam <festevam@gmail.com>
CC: linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH] iio: twl4030-madc: Pass the IRQF_ONESHOT flag
References: <1432499944-10395-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1432499944-10395-1-git-send-email-festevam@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/05/15 21:39, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Since commit 1c6c69525b40 ("genirq: Reject bogus threaded irq requests")
> threaded IRQs without a primary handler need to be requested with
> IRQF_ONESHOT, otherwise the request will fail.
> 
> So pass the IRQF_ONESHOT flag in this case.
> 
> The semantic patch that makes this change is available
> in scripts/coccinelle/misc/irqf_oneshot.cocci.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.
> ---
>  drivers/iio/adc/twl4030-madc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
> index 94c5f05..4caecbe 100644
> --- a/drivers/iio/adc/twl4030-madc.c
> +++ b/drivers/iio/adc/twl4030-madc.c
> @@ -835,7 +835,8 @@ static int twl4030_madc_probe(struct platform_device *pdev)
>  	irq = platform_get_irq(pdev, 0);
>  	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
>  				   twl4030_madc_threaded_irq_handler,
> -				   IRQF_TRIGGER_RISING, "twl4030_madc", madc);
> +				   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +				   "twl4030_madc", madc);
>  	if (ret) {
>  		dev_err(&pdev->dev, "could not request irq\n");
>  		goto err_i2c;
> 

