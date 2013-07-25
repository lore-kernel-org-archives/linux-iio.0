Return-Path: <b.brezillon@overkiz.com>
Message-ID: <51F11395.9040406@overkiz.com>
Date: Thu, 25 Jul 2013 14:01:25 +0200
From: boris brezillon <b.brezillon@overkiz.com>
MIME-Version: 1.0
To: Josh Wu <josh.wu@atmel.com>
CC: jic23@cam.ac.uk, linux-iio@vger.kernel.org, nicolas.ferre@atmel.com,
 maxime.ripard@free-electrons.com, plagnioj@jcrosoft.com,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/5] iio: at91: add an optional dt property for for adc
 clock hz.
References: <1373789069-11604-1-git-send-email-josh.wu@atmel.com> <1373789069-11604-5-git-send-email-josh.wu@atmel.com>
In-Reply-To: <1373789069-11604-5-git-send-email-josh.wu@atmel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi Josh,

On 14/07/2013 10:04, Josh Wu wrote:
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> ---
>   Documentation/devicetree/bindings/arm/atmel-adc.txt |    2 ++
>   drivers/iio/adc/at91_adc.c                          |    8 +++++++-
>   2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/atmel-adc.txt b/Documentation/devicetree/bindings/arm/atmel-adc.txt
> index 16769d9..0db2945 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-adc.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-adc.txt
> @@ -27,6 +27,8 @@ Optional properties:
>   		       resolution will be used.
>     - atmel,adc-sleep-mode: Boolean to enable sleep mode when no conversion
>     - atmel,adc-sample-hold-time: Sample and Hold Time in microseconds
> +  - atmel,adc-clock-rate: ADC clock rate. If not specified, use the default
> +			  adc_op_clk.
>
>   Optional trigger Nodes:
>     - Required properties:
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index e93a075..8f1386f 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -47,6 +47,7 @@ struct at91_adc_caps {
>
>   struct at91_adc_state {
>   	struct clk		*adc_clk;
> +	u32			adc_clk_rate;
>   	u16			*buffer;
>   	unsigned long		channels_mask;
>   	struct clk		*clk;
> @@ -448,6 +449,10 @@ static int at91_adc_probe_dt(struct at91_adc_state *st,
>   	if (!node)
>   		return -EINVAL;
>
> +	prop = 0;
> +	of_property_read_u32(node, "atmel,adc-clock-rate", &prop);
> +	st->adc_clk_rate = prop;
> +
>   	st->use_external = of_property_read_bool(node, "atmel,adc-use-external-triggers");
>
>   	if (of_property_read_u32(node, "atmel,adc-channels-used", &prop)) {
> @@ -723,7 +728,8 @@ static int at91_adc_probe(struct platform_device *pdev)
>   	 * specified by the electrical characteristics of the board.
>   	 */
>   	mstrclk = clk_get_rate(st->clk);
> -	adc_clk = clk_get_rate(st->adc_clk);
> +	adc_clk = st->adc_clk_rate ?
> +		st->adc_clk_rate : clk_get_rate(st->adc_clk);
>   	adc_clk_khz = adc_clk / 1000;
>   	prsc = (mstrclk / (2 * adc_clk)) - 1;
>
>

As said by Maxime and Lars-Peter, I think this should be handled by a 
proper clock implementation (adc_clock ?) using common clock framework.

IMO the fake adc_op_clk should not exist. Instead the adc clock binding 
should define properties describing the adc clock characteristics (see 
pll implementation in at91 common clk series).
These characteristics can be found in 'ADC characteristics' chapter in 
atmel's datasheets.

The adc clock binding would look like this (based on sama5 datasheet):

adc_clk {
	compatible = "sama5d3-adc-clk";
	output = <1000000 20000000>; /* output clock frequency range */
};

It is up to the clk user (adc driver) to choose the appropriate 
frequency to use (maximum rate ?) and configure it with clk_set_rate 
function.
The adc clk implem will take care of PRESCAL field config in ADC_MR 
according to parent rate (mck rate) and requested rate. It will also 
check if the requested rate is in the output clk range.

These are just thought, feel free to comment it.

Best Regards,

Boris
