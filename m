Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:60942 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965132AbaFRIye (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Jun 2014 04:54:34 -0400
Message-id: <53A153C6.1030703@samsung.com>
Date: Wed, 18 Jun 2014 17:54:30 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
MIME-version: 1.0
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: jic23@kernel.org, ch.naveen@samsung.com, t.figa@samsung.com,
	kgene.kim@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, rdunlap@infradead.org,
	sachin.kamat@linaro.org, linux-iio@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCHv4 3/4] iio: devicetree: Add DT binding documentation for
 Exynos3250 ADC
References: <1403058061-24271-1-git-send-email-cw00.choi@samsung.com>
 <1403058061-24271-4-git-send-email-cw00.choi@samsung.com>
 <53A14F4D.7080204@gmail.com>
In-reply-to: <53A14F4D.7080204@gmail.com>
Content-type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Tomasz,

On 06/18/2014 05:35 PM, Tomasz Figa wrote:
> Hi Chanwoo,
> 
> On 18.06.2014 04:21, Chanwoo Choi wrote:
>> This patch add DT binding documentation for Exynos3250 ADC IP. Exynos3250 has
>> special clock ('sclk_tsadc') for ADC which provide clock to internal ADC.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  .../devicetree/bindings/arm/samsung/exynos-adc.txt   | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt b/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
>> index 5d49f2b..3a5af82 100644
>> --- a/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
>> +++ b/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
>> @@ -14,6 +14,8 @@ Required properties:
>>  				for exynos4412/5250 controllers.
>>  			Must be "samsung,exynos-adc-v2" for
>>  				future controllers.
>> +			Must be "samsung,exynos3250-adc-v2" for
>> +				for exynos3250 controllers.
> 
> You might change the last line for:
> 
> for controllers compatible with ADC of Exynos3250.
> 
> This is to make it also account for possible future SoCs which need
> exactly the same handling.

OK, I'll modify it as folloiwng according to your comment:

>> +			Must be "samsung,exynos3250-adc-v2" for
>> +				for controllers compatible with ADC of Exynos3250.

> 
> 
>>  - reg:			Contains ADC register address range (base address and
>>  			length) and the address of the phy enable register.
>>  - interrupts: 		Contains the interrupt information for the timer. The
>> @@ -21,7 +23,11 @@ Required properties:
>>  			the Samsung device uses.
>>  - #io-channel-cells = <1>; As ADC has multiple outputs
>>  - clocks		From common clock binding: handle to adc clock.
>> +			From common clock binding: handle to sclk_tsadc clock
>> +			if using Exynos3250.
> 
> This is not clear. It might sound like the "sclk_tsadc" clock is used on
> Exynos3250 and "adc" on remaining SoCs. I'd write this simply as:
> 
>>>From common clock bindings: handles to clocks specified in "clock-names"
> property, in the same order.

I'll modify it.

> 
>>  - clock-names		From common clock binding: Shall be "adc".
>> +			From common clock binding: Shall be "sclk_tsadc"
>> +			if using Exynos3250.
> 
> This is also not clear. I'd recommend something like:
> 
>>>From common clock bindings: list of clock input names used by ADC block:
>     - "adc" : ADC bus clock,
>     - "sclk_tsadc" : ADC special clock (only for Exynos3250 and
> compatible ADC blocks).

I'll modify it.

Best Regards,
Chanwoo Choi
