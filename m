Return-Path: <Josh.wu@atmel.com>
Message-ID: <51E4FC70.3050207@atmel.com>
Date: Tue, 16 Jul 2013 15:55:28 +0800
From: Josh Wu <josh.wu@atmel.com>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: <jic23@cam.ac.uk>, <linux-arm-kernel@lists.infradead.org>,
	<linux-iio@vger.kernel.org>, <plagnioj@jcrosoft.com>,
	<nicolas.ferre@atmel.com>
Subject: Re: [PATCH 4/5] iio: at91: add an optional dt property for for adc
 clock hz.
References: <1373789069-11604-1-git-send-email-josh.wu@atmel.com> <1373789069-11604-5-git-send-email-josh.wu@atmel.com> <20130715130610.GD2962@lukather>
In-Reply-To: <20130715130610.GD2962@lukather>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi, Maxime

On 7/15/2013 9:06 PM, Maxime Ripard wrote:
> Hi Josh,
>
> On Sun, Jul 14, 2013 at 04:04:28PM +0800, Josh Wu wrote:
>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
>> ---
>>   Documentation/devicetree/bindings/arm/atmel-adc.txt |    2 ++
>>   drivers/iio/adc/at91_adc.c                          |    8 +++++++-
>>   2 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/atmel-adc.txt b/Documentation/devicetree/bindings/arm/atmel-adc.txt
>> index 16769d9..0db2945 100644
>> --- a/Documentation/devicetree/bindings/arm/atmel-adc.txt
>> +++ b/Documentation/devicetree/bindings/arm/atmel-adc.txt
>> @@ -27,6 +27,8 @@ Optional properties:
>>   		       resolution will be used.
>>     - atmel,adc-sleep-mode: Boolean to enable sleep mode when no conversion
>>     - atmel,adc-sample-hold-time: Sample and Hold Time in microseconds
>> +  - atmel,adc-clock-rate: ADC clock rate. If not specified, use the default
>> +			  adc_op_clk.
>>    
>>   Optional trigger Nodes:
>>     - Required properties:
>> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
>> index e93a075..8f1386f 100644
>> --- a/drivers/iio/adc/at91_adc.c
>> +++ b/drivers/iio/adc/at91_adc.c
>> @@ -47,6 +47,7 @@ struct at91_adc_caps {
>>   
>>   struct at91_adc_state {
>>   	struct clk		*adc_clk;
>> +	u32			adc_clk_rate;
>>   	u16			*buffer;
>>   	unsigned long		channels_mask;
>>   	struct clk		*clk;
>> @@ -448,6 +449,10 @@ static int at91_adc_probe_dt(struct at91_adc_state *st,
>>   	if (!node)
>>   		return -EINVAL;
>>   
>> +	prop = 0;
>> +	of_property_read_u32(node, "atmel,adc-clock-rate", &prop);
>> +	st->adc_clk_rate = prop;
>> +
>>   	st->use_external = of_property_read_bool(node, "atmel,adc-use-external-triggers");
>>   
>>   	if (of_property_read_u32(node, "atmel,adc-channels-used", &prop)) {
>> @@ -723,7 +728,8 @@ static int at91_adc_probe(struct platform_device *pdev)
>>   	 * specified by the electrical characteristics of the board.
>>   	 */
>>   	mstrclk = clk_get_rate(st->clk);
>> -	adc_clk = clk_get_rate(st->adc_clk);
>> +	adc_clk = st->adc_clk_rate ?
>> +		st->adc_clk_rate : clk_get_rate(st->adc_clk);
> Why is that needed? Isn't it completely redundant with the clocks
> property?

As st->adc_clk rate is specified in arch/arm/mach-at91/sama5d3.c (take 
sama5d3 for example), changing the clock rate should recompile the 
kernel binary.
Use dt parameter will let us easily specify the clock rate instead of 
recompile the code.

And yes, it is redundant that we can define the adc_op_clk rate in two 
places (clock property in .c and adc-clock-rate in dts). But this can be 
compatible with the non-dt platform.

After a further thinking of this, maybe remove the adc_op_clk is better 
since it is a fake clock, and only used to specify the clock rate.
To specify the clock rate use a dt property or platform data parameter 
is better.

>
> Maxime
>
>

Best Regards,
Josh Wu
