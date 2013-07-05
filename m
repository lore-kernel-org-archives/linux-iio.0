Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:37335 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755591Ab3GELlh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 5 Jul 2013 07:41:37 -0400
From: Marek Vasut <marex@denx.de>
To: Hector Palacios <hector.palacios@digi.com>
Subject: Re: [PATCH 2/4] iio: mxs-lradc: add scale attribute to channels
Date: Fri, 5 Jul 2013 13:41:35 +0200
Cc: linux-iio@vger.kernel.org, alexandre.belloni@free-electrons.com,
	lars@metafoo.de, jic23@kernel.org, fabio.estevam@freescale.com
References: <1373013039-19461-1-git-send-email-hector.palacios@digi.com> <1373013039-19461-3-git-send-email-hector.palacios@digi.com>
In-Reply-To: <1373013039-19461-3-git-send-email-hector.palacios@digi.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201307051341.35612.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Hector Palacios,

> Some LRADC channels have a fixed pre-divider, and all can have enabled
> an optional divisor by two which allows a maximum input voltage of
> VDDIO - 50mV.
> 
> This patch
>  - adds the scaling info flag to all channels
>  - adds a lookup table with max reference voltage per channel
>    (where the fixed pre-dividers apply)
>  - allows to read the scaling attribute (computed from the Vref)
> 
> Signed-off-by: Hector Palacios <hector.palacios@digi.com>
> ---
>  drivers/staging/iio/adc/mxs-lradc.c | 122
> +++++++++++++++++++++++++++--------- 1 file changed, 93 insertions(+), 29
> deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c
> b/drivers/staging/iio/adc/mxs-lradc.c index d65a594..012c42e 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -107,19 +107,63 @@ static const char * const mx28_lradc_irq_names[] = {
>  	"mxs-lradc-button1",
>  };
> 
> +/*
> + * Max reference voltage (mV) for each channel
> + */
> +static const int mx23_vref_mv[LRADC_MAX_TOTAL_CHANS] = {
> +	1850,		/* CH0 */
> +	1850,		/* CH1 */
> +	1850,		/* CH2 */
> +	1850,		/* CH3 */
> +	1850,		/* CH4 */
> +	1850,		/* CH5 */
> +	1850 * 2,	/* CH6 VDDIO */
> +	1850 * 4,	/* CH7 VBATT */
> +	1850,		/* CH8 Temp sense 0 */
> +	1850,		/* CH9 Temp sense 1 */
> +	1850,		/* CH10 */
> +	1850,		/* CH11 */
> +	1850,		/* CH12 USB_DP */
> +	1850,		/* CH13 USB_DN */
> +	1850,		/* CH14 VBG */
> +	1850 * 4,	/* CH15 VDD5V */
> +};
> +
> +static const int mx28_vref_mv[LRADC_MAX_TOTAL_CHANS] = {
> +	1850,		/* CH0 */
> +	1850,		/* CH1 */
> +	1850,		/* CH2 */
> +	1850,		/* CH3 */
> +	1850,		/* CH4 */
> +	1850,		/* CH5 */
> +	1850,		/* CH6 */
> +	1850 * 4,	/* CH7 VBATT */
> +	1850,		/* CH8 Temp sense 0 */
> +	1850,		/* CH9 Temp sense 1 */
> +	1850 * 2,	/* CH10 VDDIO */
> +	1850,		/* CH11 VTH */
> +	1850 * 2,	/* CH12 VDDA */
> +	1850,		/* CH13 VDDD */
> +	1850,		/* CH14 VBG */
> +	1850 * 4,	/* CH15 VDD5V */
> +};

Should the above not be in DT ?

>  struct mxs_lradc_of_config {
>  	const int		irq_count;
>  	const char * const	*irq_name;
> +	const int 		*vref_mv;
>  };
> 
>  static const struct mxs_lradc_of_config mxs_lradc_of_config[] = {
>  	[IMX23_LRADC] = {
>  		.irq_count	= ARRAY_SIZE(mx23_lradc_irq_names),
>  		.irq_name	= mx23_lradc_irq_names,

Idea for future patch, maybe we should remove these "irq names" here and just 
call the IRQs "lradc-irq-n"...

[...]

Best regards,
Marek Vasut
