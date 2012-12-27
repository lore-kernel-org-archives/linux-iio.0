Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39884 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046Ab2L0MJb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 27 Dec 2012 07:09:31 -0500
Message-ID: <50DC3A78.80100@kernel.org>
Date: Thu, 27 Dec 2012 12:09:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH 2/3] ARM: AT91: IIO: add sleep mode support
References: <20121219183236.GP23971@game.jcrosoft.org> <1355942232-26251-1-git-send-email-plagnioj@jcrosoft.com> <1355942232-26251-2-git-send-email-plagnioj@jcrosoft.com> <50D2EC76.5010508@free-electrons.com>
In-Reply-To: <50D2EC76.5010508@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/20/2012 10:46 AM, Maxime Ripard wrote:
> Hi,
> 
> Le 19/12/2012 19:37, Jean-Christophe PLAGNIOL-VILLARD a écrit :
>> The sleep mode will allow to put the add in sleep between conversion.
>>
>> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>> Cc: linux-iio@vger.kernel.org
>> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
>> ---
>>  Documentation/devicetree/bindings/arm/atmel-adc.txt |    1 +
>>  drivers/iio/adc/at91_adc.c                          |   19 ++++++++++---------
>>  2 files changed, 11 insertions(+), 9 deletions(-)
I have no particular problem with this, but would like a brief note on what
one looses when sleep mode is enabled?  How much slower is the conversion if
we first have to come out of sleep mode?   Basically I want a justification
of why we don't always enable this.  Is this hardware specific or
should it simply be controllable from userspace?

>>
>> diff --git a/Documentation/devicetree/bindings/arm/atmel-adc.txt b/Documentation/devicetree/bindings/arm/atmel-adc.txt
>> index fd2d69e..efb6f02 100644
>> --- a/Documentation/devicetree/bindings/arm/atmel-adc.txt
>> +++ b/Documentation/devicetree/bindings/arm/atmel-adc.txt
>> @@ -25,6 +25,7 @@ Optional properties:
>>    - atmel,adc-use-res: String corresponding to an identifier from
>>  		       atmel,adc-res-names property. If not specified, the highest
>>  		       resolution will be used.
>> +  - atmel,atmel,adc-sleep-mode: Boolean to enable of sleep mode when no conversion
>>   
>>  Optional trigger Nodes:
>>    - Required properties:
>> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
>> index f175a86..c563488 100644
>> --- a/drivers/iio/adc/at91_adc.c
>> +++ b/drivers/iio/adc/at91_adc.c
>> @@ -52,6 +52,7 @@ struct at91_adc_state {
>>  	void __iomem		*reg_base;
>>  	struct at91_adc_reg_desc *registers;
>>  	u8			startup_time;
>> +	bool			sleep_mode;
>>  	struct iio_trigger	**trig;
>>  	struct at91_adc_trigger	*trigger_list;
>>  	u32			trigger_number;
>> @@ -455,6 +456,8 @@ static int at91_adc_probe_dt(struct at91_adc_state *st,
>>  	}
>>  	st->num_channels = prop;
>>  
>> +	st->sleep_mode = of_property_read_bool(node, "atmel,adc-sleep-mode");
>> +
>>  	if (of_property_read_u32(node, "atmel,adc-startup-time", &prop)) {
>>  		dev_err(&idev->dev, "Missing adc-startup-time property in the DT.\n");
>>  		ret = -EINVAL;
>> @@ -580,6 +583,7 @@ static int __devinit at91_adc_probe(struct platform_device *pdev)
>>  	struct iio_dev *idev;
>>  	struct at91_adc_state *st;
>>  	struct resource *res;
>> +	u32 reg;
>>  
>>  	idev = iio_device_alloc(sizeof(struct at91_adc_state));
>>  	if (idev == NULL) {
>> @@ -687,16 +691,13 @@ static int __devinit at91_adc_probe(struct platform_device *pdev)
>>  	 */
>>  	ticks = round_up((st->startup_time * adc_clk /
>>  			  1000000) - 1, 8) / 8;
>> -
>> +	reg = AT91_ADC_PRESCAL_(prsc) & AT91_ADC_PRESCAL;
>> +	reg |= AT91_ADC_STARTUP_(ticks) & AT91_ADC_STARTUP;
>>  	if (st->low_res)
>> -		at91_adc_writel(st, AT91_ADC_MR,
>> -				AT91_ADC_LOWRES |
>> -				(AT91_ADC_PRESCAL_(prsc) & AT91_ADC_PRESCAL) |
>> -				(AT91_ADC_STARTUP_(ticks) & AT91_ADC_STARTUP));
>> -	else
>> -		at91_adc_writel(st, AT91_ADC_MR,
>> -				(AT91_ADC_PRESCAL_(prsc) & AT91_ADC_PRESCAL) |
>> -				(AT91_ADC_STARTUP_(ticks) & AT91_ADC_STARTUP));
>> +		reg |= AT91_ADC_LOWRES;
>> +	if (st->sleep_mode)
>> +		reg |= AT91_ADC_SLEEP;
>> +	at91_adc_writel(st, AT91_ADC_MR, reg);
> 
> I'm fine with the code in itself, but since this also refactors what has
> been added in the previous patch, maybe you can add it in the first patch.
> 
> Apart from that, you can add my Acked-by.
> 
> Maxime
> 
