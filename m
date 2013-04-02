Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36148 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759921Ab3DBSYg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 2 Apr 2013 14:24:36 -0400
Message-ID: <515B2260.1010900@kernel.org>
Date: Tue, 02 Apr 2013 19:24:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: ludovic.desroches@atmel.com
CC: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	plagnioj@jcrosoft.com, nicolas.ferre@atmel.com,
	maxime.ripard@free-electrons.com
Subject: Re: [PATCH 3/3] iio: at91_adc: fix missing Sample and Hold time
References: <1364568853-18561-1-git-send-email-ludovic.desroches@atmel.com> <1364568853-18561-4-git-send-email-ludovic.desroches@atmel.com>
In-Reply-To: <1364568853-18561-4-git-send-email-ludovic.desroches@atmel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/29/2013 02:54 PM, ludovic.desroches@atmel.com wrote:
> From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> 
> On the at91_adc a minimal Sample and Hold Time is necessary for the ADC to
> guarantee the best converted final value between two channels selection.
> This time has to be programmed through the bitfield SHTIM in the
> Mode Register ADC_MR.
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Again tidied this out of the patch description.  You handled it and
posted this revision so to my mind the sign off covers all we need
to know.

> [ludovic.desroches@atmel.com: add unit for sample and hold time]
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Applied to togreg branch of iio.git

> ---
>  Documentation/devicetree/bindings/arm/atmel-adc.txt |  1 +
>  drivers/iio/adc/at91_adc.c                          | 15 ++++++++++++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-adc.txt b/Documentation/devicetree/bindings/arm/atmel-adc.txt
> index 3a05492..16769d9 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-adc.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-adc.txt
> @@ -26,6 +26,7 @@ Optional properties:
>  		       atmel,adc-res-names property. If not specified, the highest
>  		       resolution will be used.
>    - atmel,adc-sleep-mode: Boolean to enable sleep mode when no conversion
> +  - atmel,adc-sample-hold-time: Sample and Hold Time in microseconds
>   
>  Optional trigger Nodes:
>    - Required properties:
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 8e38f1c..69fe8d4 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -52,6 +52,7 @@ struct at91_adc_state {
>  	void __iomem		*reg_base;
>  	struct at91_adc_reg_desc *registers;
>  	u8			startup_time;
> +	u8			sample_hold_time;
>  	bool			sleep_mode;
>  	struct iio_trigger	**trig;
>  	struct at91_adc_trigger	*trigger_list;
> @@ -465,6 +466,9 @@ static int at91_adc_probe_dt(struct at91_adc_state *st,
>  	}
>  	st->startup_time = prop;
>  
> +	prop = 0;
> +	of_property_read_u32(node, "atmel,adc-sample-hold-time", &prop);
> +	st->sample_hold_time = prop;
>  
>  	if (of_property_read_u32(node, "atmel,adc-vref", &prop)) {
>  		dev_err(&idev->dev, "Missing adc-vref property in the DT.\n");
> @@ -578,7 +582,7 @@ static const struct iio_info at91_adc_info = {
>  
>  static int at91_adc_probe(struct platform_device *pdev)
>  {
> -	unsigned int prsc, mstrclk, ticks, adc_clk;
> +	unsigned int prsc, mstrclk, ticks, adc_clk, shtim;
>  	int ret;
>  	struct iio_dev *idev;
>  	struct at91_adc_state *st;
> @@ -691,12 +695,21 @@ static int at91_adc_probe(struct platform_device *pdev)
>  	 */
>  	ticks = round_up((st->startup_time * adc_clk /
>  			  1000000) - 1, 8) / 8;
> +	/*
> +	 * a minimal Sample and Hold Time is necessary for the ADC to guarantee
> +	 * the best converted final value between two channels selection
> +	 * The formula thus is : Sample and Hold Time = (shtim + 1) / ADCClock
> +	 */
> +	shtim = round_up((st->sample_hold_time * adc_clk /
> +			  1000000) - 1, 1);
> +
>  	reg = AT91_ADC_PRESCAL_(prsc) & AT91_ADC_PRESCAL;
>  	reg |= AT91_ADC_STARTUP_(ticks) & AT91_ADC_STARTUP;
>  	if (st->low_res)
>  		reg |= AT91_ADC_LOWRES;
>  	if (st->sleep_mode)
>  		reg |= AT91_ADC_SLEEP;
> +	reg |= AT91_ADC_SHTIM_(shtim) & AT91_ADC_SHTIM;
>  	at91_adc_writel(st, AT91_ADC_MR, reg);
>  
>  	/* Setup the ADC channels available on the board */
> 
