Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:51769 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594Ab3IPOPo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2013 10:15:44 -0400
From: Marek Vasut <marex@denx.de>
To: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: [PATCH 3/6] Staging/iio/adc/touchscreen/MXS: simplify register access
Date: Mon, 16 Sep 2013 16:15:40 +0200
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devel@driverdev.osuosl.org, fabio.estevam@freescale.com,
	jic23@cam.ac.uk
References: <1378887511-24530-1-git-send-email-jbe@pengutronix.de> <1378887511-24530-4-git-send-email-jbe@pengutronix.de>
In-Reply-To: <1378887511-24530-4-git-send-email-jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201309161615.40751.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Juergen Beisert,

> Replace the individual register access by a few shared access function to
> make the code easier to read and in order to add the i.MX23 SoC in the
> next step.
> 
> Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
> CC: linux-arm-kernel@lists.infradead.org
> CC: devel@driverdev.osuosl.org
> CC: Marek Vasut <marex@denx.de>
> CC: Fabio Estevam <fabio.estevam@freescale.com>
> CC: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/adc/mxs-lradc.c | 204
> +++++++++++++++++++++--------------- 1 file changed, 120 insertions(+), 84
> deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c
> b/drivers/staging/iio/adc/mxs-lradc.c index 5535fed..4317fee 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -235,6 +235,56 @@ struct mxs_lradc {
>  #define LRADC_RESOLUTION			12
>  #define LRADC_SINGLE_SAMPLE_MASK		((1 << LRADC_RESOLUTION) - 1)
> 
> +static void mxs_lradc_reg_set(struct mxs_lradc *lradc, u32 val, u32 reg)
> +{
> +	writel(val, lradc->base + reg + STMP_OFFSET_REG_SET);
> +}
> +
> +static void mxs_lradc_reg_clear(struct mxs_lradc *lradc, u32 val, u32 reg)
> +{
> +	writel(val, lradc->base + reg + STMP_OFFSET_REG_CLR);
> +}
> +
> +static void mxs_lradc_reg(struct mxs_lradc *lradc, u32 val, u32 reg)
> +{
> +	writel(val, lradc->base + reg);
> +}

Idea for later patch: Should we not move these functions to a MXS-specific 
header _later_ on so other drivers can leverage them too ?

[...]

Best regards,
Marek Vasut
