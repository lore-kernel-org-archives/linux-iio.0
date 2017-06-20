Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:35096 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750993AbdFTQHY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Jun 2017 12:07:24 -0400
Subject: Re: [PATCH 1/8] dt-bindings: mfd: Add STM32 LPTimer binding
To: Lee Jones <lee.jones@linaro.org>
CC: <benjamin.gaignard@linaro.org>, <jic23@kernel.org>,
        <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <alexandre.torgue@st.com>,
        <mcoquelin.stm32@gmail.com>, <benjamin.gaignard@st.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
References: <1497628726-7563-1-git-send-email-fabrice.gasnier@st.com>
 <1497628726-7563-2-git-send-email-fabrice.gasnier@st.com>
 <20170620115040.xyaivbtcuufhxlv7@dell>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <b6e64096-db0a-afea-ca4e-b21e86e1aa29@st.com>
Date: Tue, 20 Jun 2017 18:06:46 +0200
MIME-Version: 1.0
In-Reply-To: <20170620115040.xyaivbtcuufhxlv7@dell>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/20/2017 01:50 PM, Lee Jones wrote:
> On Fri, 16 Jun 2017, Fabrice Gasnier wrote:
> 
>> Add documentation for STMicroelectronics STM32 Low Power Timer binding.
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> ---
>>  .../devicetree/bindings/mfd/stm32-lptimer.txt      | 51 ++++++++++++++++++++++
>>  1 file changed, 51 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt b/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
>> new file mode 100644
>> index 0000000..237b7d6
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
>> @@ -0,0 +1,51 @@
>> +STMicroelectronics STM32 Low Power Timer
>> +
>> +The STM32 Low Power Timer (LPTIM) is a 16-bit timer that provides several
>> +functionalities:
> 
> "functions".

Hi Lee,

I'll fix it in v2.
> 
>> +- PWM output (with programmable prescaler, configurable polarity)
>> +- Quadrature encoder, counter
>> +- Trigger source for STM32 ADC/DAC (LPTIM_OUT)
>> +
>> +Required properties:
>> +- compatible: Must be "st,stm32-lptimer".
>> +- reg: Offset and length of the device's register set.
>> +- clocks: Phandle to the clock used by the LP Timer module.
>> +- clock-names: Must be "int".
> 
> These look better when padded:
> 
> - compatible:		Must be "st,stm32-lptimer".
> - reg:			Offset and length of the device's register set.
> - clocks:		Phandle to the clock used by the LP Timer module.
> - clock-names:		Must be "int".
> 
>> +- #address-cells = <1>;
>> +- #size-cells = <0>;
> 
> Please use the same format as you did for the other properties.

I'll fix it in v2.

> 
>> +Optional properties:
>> +- resets: Must contain the phandle to the reset controller.
>> +
>> +Optional subnodes:
>> +- pwm: See ../pwm/pwm-stm32-lp.txt
>> +- counter: See ../iio/timer/stm32-lptimer-cnt.txt
>> +- trigger: See ../iio/timer/stm32-lptimer-trigger.txt
>> +
>> +Example:
>> +
>> +	lptimer1: lptimer@0x40002400 {
> 
> Remove '0x'
nice shot :-)

> 
>> +		compatible = "st,stm32-lptimer";
>> +		reg = <0x40002400 0x400>;
>> +		clocks = <&timer_clk>;
>> +		clock-names = "int";
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		pwm {
>> +			compatible = "st,stm32-pwm-lp";
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&lppwm1_pins>;
>> +		};
>> +
>> +		trigger@0 {
> 
> Why is this @0 and no reg properties are provided for the other 2
> nodes?

This is to select each LPTimer configuration (similar to stm32-timers).
All LPTimers that provide output as trigger for ADC and/or DAC are the
same, except for which hardware signals they're connected to, and send
to ADC and/or DAC.
"reg" is used as index for trigger table in trigger driver code (PATCH
6): it must be 0 for lptimer1 output, 1 for lptimer2 output or 2 for
lptimer3 output.
I should probably document it in stm32-lptimer-trigger dt-bindings ?

This is not needed for other two nodes.

Thanks for reviewing,
Best Regards,
Fabrice

> 
>> +			compatible = "st,stm32-lptimer-trigger";
>> +			reg = <0>;
>> +		};
>> +
>> +		counter {
>> +			compatible = "st,stm32-lptimer-counter";
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&lptim1_in_pins>;
>> +		};
>> +	};
> 
