Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36126 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760867Ab3DBSWI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 2 Apr 2013 14:22:08 -0400
Message-ID: <515B21CE.50501@kernel.org>
Date: Tue, 02 Apr 2013 19:22:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: ludovic.desroches@atmel.com
CC: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	plagnioj@jcrosoft.com, nicolas.ferre@atmel.com,
	maxime.ripard@free-electrons.com
Subject: Re: [PATCH 2/3] iio: at91_adc: add sleep mode support
References: <1364568853-18561-1-git-send-email-ludovic.desroches@atmel.com> <1364568853-18561-3-git-send-email-ludovic.desroches@atmel.com>
In-Reply-To: <1364568853-18561-3-git-send-email-ludovic.desroches@atmel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/29/2013 02:54 PM, ludovic.desroches@atmel.com wrote:
> From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> 
> The sleep mode will allow to put the adc in sleep between conversion.
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
I tied this next comment out.  Nice as is it is to make it clear
what contributions are, this looks pretty non standard in a block
that has a very specific purpose.

> [ludovic.desroches@atmel.com: correct typo]
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Applied to togreg branch of iio.git
> ---
>  Documentation/devicetree/bindings/arm/atmel-adc.txt |  1 +
>  drivers/iio/adc/at91_adc.c                          | 19 ++++++++++---------
>  2 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-adc.txt b/Documentation/devicetree/bindings/arm/atmel-adc.txt
> index fd2d69e..3a05492 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-adc.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-adc.txt
> @@ -25,6 +25,7 @@ Optional properties:
>    - atmel,adc-use-res: String corresponding to an identifier from
>  		       atmel,adc-res-names property. If not specified, the highest
>  		       resolution will be used.
> +  - atmel,adc-sleep-mode: Boolean to enable sleep mode when no conversion
>   
>  Optional trigger Nodes:
>    - Required properties:
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index a7ad3e7..8e38f1c 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -52,6 +52,7 @@ struct at91_adc_state {
>  	void __iomem		*reg_base;
>  	struct at91_adc_reg_desc *registers;
>  	u8			startup_time;
> +	bool			sleep_mode;
>  	struct iio_trigger	**trig;
>  	struct at91_adc_trigger	*trigger_list;
>  	u32			trigger_number;
> @@ -455,6 +456,8 @@ static int at91_adc_probe_dt(struct at91_adc_state *st,
>  	}
>  	st->num_channels = prop;
>  
> +	st->sleep_mode = of_property_read_bool(node, "atmel,adc-sleep-mode");
> +
>  	if (of_property_read_u32(node, "atmel,adc-startup-time", &prop)) {
>  		dev_err(&idev->dev, "Missing adc-startup-time property in the DT.\n");
>  		ret = -EINVAL;
> @@ -580,6 +583,7 @@ static int at91_adc_probe(struct platform_device *pdev)
>  	struct iio_dev *idev;
>  	struct at91_adc_state *st;
>  	struct resource *res;
> +	u32 reg;
>  
>  	idev = iio_device_alloc(sizeof(struct at91_adc_state));
>  	if (idev == NULL) {
> @@ -687,16 +691,13 @@ static int at91_adc_probe(struct platform_device *pdev)
>  	 */
>  	ticks = round_up((st->startup_time * adc_clk /
>  			  1000000) - 1, 8) / 8;
> -
> +	reg = AT91_ADC_PRESCAL_(prsc) & AT91_ADC_PRESCAL;
> +	reg |= AT91_ADC_STARTUP_(ticks) & AT91_ADC_STARTUP;
>  	if (st->low_res)
> -		at91_adc_writel(st, AT91_ADC_MR,
> -				AT91_ADC_LOWRES |
> -				(AT91_ADC_PRESCAL_(prsc) & AT91_ADC_PRESCAL) |
> -				(AT91_ADC_STARTUP_(ticks) & AT91_ADC_STARTUP));
> -	else
> -		at91_adc_writel(st, AT91_ADC_MR,
> -				(AT91_ADC_PRESCAL_(prsc) & AT91_ADC_PRESCAL) |
> -				(AT91_ADC_STARTUP_(ticks) & AT91_ADC_STARTUP));
> +		reg |= AT91_ADC_LOWRES;
> +	if (st->sleep_mode)
> +		reg |= AT91_ADC_SLEEP;
> +	at91_adc_writel(st, AT91_ADC_MR, reg);
>  
>  	/* Setup the ADC channels available on the board */
>  	ret = at91_adc_channel_init(idev);
> 
