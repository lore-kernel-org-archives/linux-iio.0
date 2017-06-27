Return-Path: <SRS0=sBPx=6A=st.com=fabrice.gasnier@kernel.org>
Subject: Re: [PATCH v2 1/8] dt-bindings: mfd: Add STM32 LPTimer binding
To: Rob Herring <robh@kernel.org>
CC: <lee.jones@linaro.org>, <benjamin.gaignard@linaro.org>, <jic23@kernel.org>,
        <thierry.reding@gmail.com>, <mark.rutland@arm.com>,
        <alexandre.torgue@st.com>, <mcoquelin.stm32@gmail.com>,
        <benjamin.gaignard@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
References: <1498055415-31513-1-git-send-email-fabrice.gasnier@st.com>
 <1498055415-31513-2-git-send-email-fabrice.gasnier@st.com>
 <20170626180744.fyyzjsu4pmurohap@rob-hp-laptop>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <a69a61c3-95a8-d0cc-10a6-4a7cf65ff2c5@st.com>
Date: Tue, 27 Jun 2017 10:57:32 +0200
MIME-Version: 1.0
In-Reply-To: <20170626180744.fyyzjsu4pmurohap@rob-hp-laptop>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

On 06/26/2017 08:07 PM, Rob Herring wrote:
> On Wed, Jun 21, 2017 at 04:30:08PM +0200, Fabrice Gasnier wrote:
>> Add documentation for STMicroelectronics STM32 Low-Power Timer binding.
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> ---
>> Changes in v2:
>> - Lee's comments: s/Low Power/Low-Power/, remove 0x in example, improve
>>   properties descriptions
>> ---
>>  .../devicetree/bindings/mfd/stm32-lptimer.txt      | 48 ++++++++++++++++++++++
>>  1 file changed, 48 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt b/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
>> new file mode 100644
>> index 0000000..af859c8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
>> @@ -0,0 +1,48 @@
>> +STMicroelectronics STM32 Low-Power Timer
>> +
>> +The STM32 Low-Power Timer (LPTIM) is a 16-bit timer that provides several
>> +functions:
>> +- PWM output (with programmable prescaler, configurable polarity)
>> +- Quadrature encoder, counter
>> +- Trigger source for STM32 ADC/DAC (LPTIM_OUT)
>> +
>> +Required properties:
>> +- compatible:		Must be "st,stm32-lptimer".
>> +- reg:			Offset and length of the device's register set.
>> +- clocks:		Phandle to the clock used by the LP Timer module.
>> +- clock-names:		Must be "mux".
>> +- #address-cells:	Should be '<1>'.
>> +- #size-cells:		Should be '<0>'.
>> +
>> +Optional subnodes:
>> +- pwm:			See ../pwm/pwm-stm32-lp.txt
>> +- counter:		See ../iio/timer/stm32-lptimer-cnt.txt
>> +- trigger:		See ../iio/timer/stm32-lptimer-trigger.txt
>> +
>> +Example:
>> +
>> +	lptimer1: lptimer@40002400 {
> 
> timer@...

Hi Rob,

I initially put "lptimer" here to distinguish Low-Power Timer hardware
from other "timers" hardware that can be found also on stm32 devices.
I'd prefer to keep it, is it sensible from your point of view ?
Please advise.

> 
>> +		compatible = "st,stm32-lptimer";
>> +		reg = <0x40002400 0x400>;
>> +		clocks = <&timer_clk>;
>> +		clock-names = "mux";
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
>> +			compatible = "st,stm32-lptimer-trigger";
>> +			reg = <0>;
> 
> Is there more than 1? 

reg identifies trigger hardware block.

Best Regards,
Thanks,
Fabrice

> 
>> +		};
>> +
>> +		counter {
>> +			compatible = "st,stm32-lptimer-counter";
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&lptim1_in_pins>;
>> +		};
>> +	};
>> -- 
>> 1.9.1
>>
