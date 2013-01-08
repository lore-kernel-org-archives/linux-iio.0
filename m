Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:50412 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393Ab3AHG55 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jan 2013 01:57:57 -0500
From: Marek Vasut <marex@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] iio: mxs-lradc: indexes are unsigned
Date: Tue, 8 Jan 2013 07:57:56 +0100
Cc: jic23@cam.ac.uk, linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
References: <1357607117-5868-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1357607117-5868-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201301080757.56301.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Fabio Estevam,

> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Fix the following warning when building with W=1 option:
> 
> drivers/staging/iio/adc/mxs-lradc.c: In function
> 'mxs_lradc_trigger_handler': drivers/staging/iio/adc/mxs-lradc.c:244:2:
> warning: comparison between signed and unsigned integer expressions
> [-Wsign-compare]
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Maybe use "unsigned int" instead? Either way:

Acked-by: Marek Vasut <marex@denx.de>

> ---
>  drivers/staging/iio/adc/mxs-lradc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c
> b/drivers/staging/iio/adc/mxs-lradc.c index fb31b45..6cf3af8 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -239,7 +239,7 @@ static irqreturn_t mxs_lradc_trigger_handler(int irq,
> void *p) struct mxs_lradc *lradc = iio_priv(iio);
>  	const uint32_t chan_value = LRADC_CH_ACCUMULATE |
>  		((LRADC_DELAY_TIMER_LOOP - 1) << LRADC_CH_NUM_SAMPLES_OFFSET);
> -	int i, j = 0;
> +	u32 i, j = 0;
> 
>  	for_each_set_bit(i, iio->active_scan_mask, iio->masklength) {
>  		lradc->buffer[j] = readl(lradc->base + LRADC_CH(j));

Best regards,
Marek Vasut
