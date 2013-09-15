Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50060 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754349Ab3IOJfR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2013 05:35:17 -0400
Message-ID: <52358D71.2040905@kernel.org>
Date: Sun, 15 Sep 2013 11:35:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Juergen Beisert <jbe@pengutronix.de>
CC: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devel@driverdev.osuosl.org, marex@denx.de,
	fabio.estevam@freescale.com, jic23@cam.ac.uk
Subject: Re: [PATCH 3/6] Staging/iio/adc/touchscreen/MXS: simplify register
 access
References: <1378887511-24530-1-git-send-email-jbe@pengutronix.de> <1378887511-24530-4-git-send-email-jbe@pengutronix.de>
In-Reply-To: <1378887511-24530-4-git-send-email-jbe@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/11/13 09:18, Juergen Beisert wrote:
> Replace the individual register access by a few shared access function to make the
> code easier to read and in order to add the i.MX23 SoC in the next step.
> 
> Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
> CC: linux-arm-kernel@lists.infradead.org
> CC: devel@driverdev.osuosl.org
> CC: Marek Vasut <marex@denx.de>
> CC: Fabio Estevam <fabio.estevam@freescale.com>
> CC: Jonathan Cameron <jic23@cam.ac.uk>
One little suggestion inline but I'm basically happy with this.
> ---
>  drivers/staging/iio/adc/mxs-lradc.c | 204 +++++++++++++++++++++---------------
>  1 file changed, 120 insertions(+), 84 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> index 5535fed..4317fee 100644
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
mxs_lradc_reg_write might be clearer?
> +static void mxs_lradc_reg(struct mxs_lradc *lradc, u32 val, u32 reg)
> +{
> +	writel(val, lradc->base + reg);
> +}
