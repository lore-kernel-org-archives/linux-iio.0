Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57157 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753129AbcLCOkh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Dec 2016 09:40:37 -0500
Subject: Re: [PATCH v3 7/7] ARM: dts: stm32: add stm32 general purpose timer
 driver in DT
To: Lee Jones <lee.jones@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
References: <1480673842-20804-1-git-send-email-benjamin.gaignard@st.com>
 <1480673842-20804-8-git-send-email-benjamin.gaignard@st.com>
 <20161202132251.GL2683@dell>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        fabrice.gasnier@st.com, gerald.baeza@st.com,
        arnaud.pouliquen@st.com, linus.walleij@linaro.org,
        linaro-kernel@lists.linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <14837e15-07bb-39e5-b5b6-39a7dfb9130f@kernel.org>
Date: Sat, 3 Dec 2016 09:42:50 +0000
MIME-Version: 1.0
In-Reply-To: <20161202132251.GL2683@dell>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/12/16 13:22, Lee Jones wrote:
> On Fri, 02 Dec 2016, Benjamin Gaignard wrote:
> 
>> Add general purpose timers and it sub-nodes into DT for stm32f4.
>> Define and enable pwm1 and pwm3 for stm32f469 discovery board
>>
>> version 3:
>> - use "st,stm32-timer-trigger" in DT
>>
>> version 2:
>> - use parameters to describe hardware capabilities
>> - do not use references for pwm and iio timer subnodes
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>> ---
>>  arch/arm/boot/dts/stm32f429.dtsi      | 333 +++++++++++++++++++++++++++++++++-
>>  arch/arm/boot/dts/stm32f469-disco.dts |  28 +++
>>  2 files changed, 360 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
>> index bca491d..8c50d03 100644
>> --- a/arch/arm/boot/dts/stm32f429.dtsi
>> +++ b/arch/arm/boot/dts/stm32f429.dtsi
>> @@ -48,7 +48,7 @@
>>  #include "skeleton.dtsi"
>>  #include "armv7-m.dtsi"
>>  #include <dt-bindings/pinctrl/stm32f429-pinfunc.h>
>> -
>> +#include <dt-bindings/iio/timer/st,stm32-timer-triggers.h>
>>  / {
>>  	clocks {
>>  		clk_hse: clk-hse {
>> @@ -355,6 +355,21 @@
>>  					slew-rate = <2>;
>>  				};
>>  			};
>> +
>> +			pwm1_pins: pwm@1 {
>> +				pins {
>> +					pinmux = <STM32F429_PA8_FUNC_TIM1_CH1>,
>> +						 <STM32F429_PB13_FUNC_TIM1_CH1N>,
>> +						 <STM32F429_PB12_FUNC_TIM1_BKIN>;
>> +				};
>> +			};
>> +
>> +			pwm3_pins: pwm@3 {
>> +				pins {
>> +					pinmux = <STM32F429_PB4_FUNC_TIM3_CH1>,
>> +						 <STM32F429_PB5_FUNC_TIM3_CH2>;
>> +				};
>> +			};
>>  		};
>>  
>>  		rcc: rcc@40023810 {
>> @@ -426,6 +441,322 @@
>>  			interrupts = <80>;
>>  			clocks = <&rcc 0 38>;
>>  		};
>> +
>> +		gptimer1: gptimer1@40010000 {
> 
> timer@xxxxxxx
> 
> Node names should be generic and not numbered.
> 
> I suggest that this isn't actually a timer either.  Is contains a
> timer (and a PWM), but in it's completeness it is not a timer per
> say.
That's just mean ;)  At least suggest an alternative?

stm32-gptimerish-magic?


> 
>> +			compatible = "st,stm32-gptimer";
>> +			reg = <0x40010000 0x400>;
>> +			clocks = <&rcc 0 160>;
>> +			clock-names = "clk_int";
>> +			status = "disabled";
>> +
>> +			pwm1@0 {
>> +				compatible = "st,stm32-pwm";
>> +				st,pwm-num-chan = <4>;
>> +				st,breakinput;
>> +				st,complementary;
>> +				status = "disabled";
>> +			};
>> +
>> +			timer1@0 {
>> +				compatible = "st,stm32-timer-trigger";
>> +				interrupts = <27>;
>> +				st,input-triggers-names = TIM5_TRGO,
>> +							  TIM2_TRGO,
>> +							  TIM4_TRGO,
>> +							  TIM3_TRGO;
> 
> I'm still dubious with matching by strings.
> 
> I'll take a look at the C code to see what the alternatives could be.
> 
>> +				st,output-triggers-names = TIM1_TRGO,
>> +							   TIM1_CH1,
>> +							   TIM1_CH2,
>> +							   TIM1_CH3,
>> +							   TIM1_CH4;
>> +				status = "disabled";
>> +			};
>> +		};
>> +
>> +		gptimer2: gptimer2@40000000 {
>> +			compatible = "st,stm32-gptimer";
>> +			reg = <0x40000000 0x400>;
>> +			clocks = <&rcc 0 128>;
>> +			clock-names = "clk_int";
>> +			status = "disabled";
>> +
>> +			pwm2@0 {
>> +				compatible = "st,stm32-pwm";
>> +				st,pwm-num-chan = <4>;
>> +				st,32bits-counter;
>> +				status = "disabled";
>> +			};
>> +
>> +			timer2@0 {
>> +				compatible = "st,stm32-timer-trigger";
>> +				interrupts = <28>;
>> +				st,input-triggers-names = TIM1_TRGO,
>> +							  TIM8_TRGO,
>> +							  TIM3_TRGO,
>> +							  TIM4_TRGO;
>> +				st,output-triggers-names = TIM2_TRGO,
>> +							   TIM2_CH1,
>> +							   TIM2_CH2,
>> +							   TIM2_CH3,
>> +							   TIM2_CH4;
>> +				status = "disabled";
>> +			};
>> +		};
>> +
>> +		gptimer3: gptimer3@40000400 {
>> +			compatible = "st,stm32-gptimer";
>> +			reg = <0x40000400 0x400>;
>> +			clocks = <&rcc 0 129>;
>> +			clock-names = "clk_int";
>> +			status = "disabled";
>> +
>> +			pwm3@0 {
>> +				compatible = "st,stm32-pwm";
>> +				st,pwm-num-chan = <4>;
>> +				status = "disabled";
>> +			};
>> +
>> +			timer3@0 {
>> +				compatible = "st,stm32-timer-trigger";
>> +				interrupts = <29>;
>> +				st,input-triggers-names = TIM1_TRGO,
>> +							  TIM8_TRGO,
>> +							  TIM5_TRGO,
>> +							  TIM4_TRGO;
>> +				st,output-triggers-names = TIM3_TRGO,
>> +							   TIM3_CH1,
>> +							   TIM3_CH2,
>> +							   TIM3_CH3,
>> +							   TIM3_CH4;
>> +				status = "disabled";
>> +			};
>> +		};
>> +
>> +		gptimer4: gptimer4@40000800 {
>> +			compatible = "st,stm32-gptimer";
>> +			reg = <0x40000800 0x400>;
>> +			clocks = <&rcc 0 130>;
>> +			clock-names = "clk_int";
>> +			status = "disabled";
>> +
>> +			pwm4@0 {
>> +				compatible = "st,stm32-pwm";
>> +				st,pwm-num-chan = <4>;
>> +				status = "disabled";
>> +			};
>> +
>> +			timer4@0 {
>> +				compatible = "st,stm32-timer-trigger";
>> +				interrupts = <30>;
>> +				st,input-triggers-names = TIM1_TRGO,
>> +							  TIM2_TRGO,
>> +							  TIM3_TRGO,
>> +							  TIM8_TRGO;
>> +				st,output-triggers-names = TIM4_TRGO,
>> +							   TIM4_CH1,
>> +							   TIM4_CH2,
>> +							   TIM4_CH3,
>> +							   TIM4_CH4;
>> +				status = "disabled";
>> +			};
>> +		};
>> +
>> +		gptimer5: gptimer5@40000C00 {
>> +			compatible = "st,stm32-gptimer";
>> +			reg = <0x40000C00 0x400>;
>> +			clocks = <&rcc 0 131>;
>> +			clock-names = "clk_int";
>> +			status = "disabled";
>> +
>> +			pwm5@0 {
>> +				compatible = "st,stm32-pwm";
>> +				st,pwm-num-chan = <4>;
>> +				st,32bits-counter;
>> +				status = "disabled";
>> +			};
>> +
>> +			timer5@0 {
>> +				compatible = "st,stm32-timer-trigger";
>> +				interrupts = <50>;
>> +				st,input-triggers-names = TIM2_TRGO,
>> +							  TIM3_TRGO,
>> +							  TIM4_TRGO,
>> +							  TIM8_TRGO;
>> +				st,output-triggers-names = TIM5_TRGO,
>> +							   TIM5_CH1,
>> +							   TIM5_CH2,
>> +							   TIM5_CH3,
>> +							   TIM5_CH4;
>> +				status = "disabled";
>> +			};
>> +		};
>> +
>> +		gptimer6: gptimer6@40001000 {
>> +			compatible = "st,stm32-gptimer";
>> +			reg = <0x40001000 0x400>;
>> +			clocks = <&rcc 0 132>;
>> +			clock-names = "clk_int";
>> +			status = "disabled";
>> +
>> +			timer6@0 {
>> +				compatible = "st,stm32-timer-trigger";
>> +				interrupts = <54>;
>> +				st,output-triggers-names = TIM6_TRGO;
>> +				status = "disabled";
>> +			};
>> +		};
>> +
>> +		gptimer7: gptimer7@40001400 {
>> +			compatible = "st,stm32-gptimer";
>> +			reg = <0x40001400 0x400>;
>> +			clocks = <&rcc 0 133>;
>> +			clock-names = "clk_int";
>> +			status = "disabled";
>> +
>> +			timer7@0 {
>> +				compatible = "st,stm32-timer-trigger";
>> +				interrupts = <55>;
>> +				st,output-triggers-names = TIM7_TRGO;
>> +				status = "disabled";
>> +			};
>> +		};
>> +
>> +		gptimer8: gptimer8@40010400 {
>> +			compatible = "st,stm32-gptimer";
>> +			reg = <0x40010400 0x400>;
>> +			clocks = <&rcc 0 161>;
>> +			clock-names = "clk_int";
>> +			status = "disabled";
>> +
>> +			pwm8@0 {
>> +				compatible = "st,stm32-pwm";
>> +				st,pwm-num-chan = <4>;
>> +				st,complementary;
>> +				st,breakinput;
>> +				status = "disabled";
>> +			};
>> +
>> +			timer8@0 {
>> +				compatible = "st,stm32-timer-trigger";
>> +				interrupts = <46>;
>> +				st,input-triggers-names = TIM1_TRGO,
>> +							  TIM2_TRGO,
>> +							  TIM4_TRGO,
>> +							  TIM5_TRGO;
>> +				st,output-triggers-names = TIM8_TRGO,
>> +							   TIM8_CH1,
>> +							   TIM8_CH2,
>> +							   TIM8_CH3,
>> +							   TIM8_CH4;
>> +				status = "disabled";
>> +			};
>> +		};
>> +
>> +		gptimer9: gptimer9@40014000 {
>> +			compatible = "st,stm32-gptimer";
>> +			reg = <0x40014000 0x400>;
>> +			clocks = <&rcc 0 176>;
>> +			clock-names = "clk_int";
>> +			status = "disabled";
>> +
>> +			pwm9@0 {
>> +				compatible = "st,stm32-pwm";
>> +				st,pwm-num-chan = <2>;
>> +				status = "disabled";
>> +			};
>> +
>> +			timer9@0 {
>> +				compatible = "st,stm32-timer-trigger";
>> +				interrupts = <24>;
>> +				st,input-triggers-names = TIM2_TRGO,
>> +							  TIM3_TRGO;
>> +				st,output-triggers-names = TIM9_TRGO,
>> +							   TIM9_CH1,
>> +							   TIM9_CH2;
>> +				status = "disabled";
>> +			};
>> +		};
>> +
>> +		gptimer10: gptimer10@40014400 {
>> +			compatible = "st,stm32-gptimer";
>> +			reg = <0x40014400 0x400>;
>> +			clocks = <&rcc 0 177>;
>> +			clock-names = "clk_int";
>> +			status = "disabled";
>> +
>> +			pwm10@0 {
>> +				compatible = "st,stm32-pwm";
>> +				st,pwm-num-chan = <1>;
>> +				status = "disabled";
>> +			};
>> +		};
>> +
>> +		gptimer11: gptimer11@40014800 {
>> +			compatible = "st,stm32-gptimer";
>> +			reg = <0x40014800 0x400>;
>> +			clocks = <&rcc 0 178>;
>> +			clock-names = "clk_int";
>> +			status = "disabled";
>> +
>> +			pwm11@0 {
>> +				compatible = "st,stm32-pwm";
>> +				st,pwm-num-chan = <1>;
>> +				status = "disabled";
>> +			};
>> +		};
>> +
>> +		gptimer12: gptimer12@40001800 {
>> +			compatible = "st,stm32-gptimer";
>> +			reg = <0x40001800 0x400>;
>> +			clocks = <&rcc 0 134>;
>> +			clock-names = "clk_int";
>> +			status = "disabled";
>> +
>> +			pwm12@0 {
>> +				compatible = "st,stm32-pwm";
>> +				st,pwm-num-chan = <2>;
>> +				status = "disabled";
>> +			};
>> +
>> +			timer12@0 {
>> +				compatible = "st,stm32-timer-trigger";
>> +				interrupts = <43>;
>> +				st,input-triggers-names = TIM4_TRGO,
>> +							  TIM5_TRGO;
>> +				st,output-triggers-names = TIM12_TRGO,
>> +							   TIM12_CH1,
>> +							   TIM12_CH2;
>> +				status = "disabled";
>> +			};
>> +		};
>> +
>> +		gptimer13: gptimer13@40001C00 {
>> +			compatible = "st,stm32-gptimer";
>> +			reg = <0x40001C00 0x400>;
>> +			clocks = <&rcc 0 135>;
>> +			clock-names = "clk_int";
>> +			status = "disabled";
>> +
>> +			pwm13@0 {
>> +				compatible = "st,stm32-pwm";
>> +				st,pwm-num-chan = <1>;
>> +				status = "disabled";
>> +			};
>> +		};
>> +
>> +		gptimer14: gptimer14@40002000 {
>> +			compatible = "st,stm32-gptimer";
>> +			reg = <0x40002000 0x400>;
>> +			clocks = <&rcc 0 136>;
>> +			clock-names = "clk_int";
>> +			status = "disabled";
>> +
>> +			pwm14@0 {
>> +				compatible = "st,stm32-pwm";
>> +				st,pwm-num-chan = <1>;
>> +				status = "disabled";
>> +			};
>> +		};
>>  	};
>>  };
>>  
>> diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
>> index 8a163d7..df4ca7e 100644
>> --- a/arch/arm/boot/dts/stm32f469-disco.dts
>> +++ b/arch/arm/boot/dts/stm32f469-disco.dts
>> @@ -81,3 +81,31 @@
>>  &usart3 {
>>  	status = "okay";
>>  };
>> +
>> +&gptimer1 {
>> +	status = "okay";
>> +
>> +	pwm1@0 {
>> +		pinctrl-0	= <&pwm1_pins>;
>> +		pinctrl-names	= "default";
>> +		status = "okay";
>> +	};
>> +
>> +	timer1@0 {
>> +		status = "okay";
>> +	};
>> +};
> 
> This is a much *better* format than before.
> 
> I still don't like the '&' syntax though.
> 
>> +&gptimer3 {
>> +	status = "okay";
>> +
>> +	pwm3@0 {
>> +		pinctrl-0	= <&pwm3_pins>;
>> +		pinctrl-names	= "default";
>> +		status = "okay";
>> +	};
>> +
>> +	timer3@0 {
>> +		status = "okay";
>> +	};
>> +};
> 

