Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35979 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933629AbcKWJun (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Nov 2016 04:50:43 -0500
Received: by mail-wm0-f47.google.com with SMTP id g23so69838023wme.1
        for <linux-iio@vger.kernel.org>; Wed, 23 Nov 2016 01:50:16 -0800 (PST)
Date: Wed, 23 Nov 2016 09:53:17 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, fabrice.gasnier@st.com,
        gerald.baeza@st.com, arnaud.pouliquen@st.com,
        linus.walleij@linaro.org, linaro-kernel@lists.linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH 7/7] add stm32 multi-functions timer driver in DT
Message-ID: <20161123095317.GP10134@dell.home>
References: <1479831207-32699-1-git-send-email-benjamin.gaignard@st.com>
 <1479831207-32699-8-git-send-email-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1479831207-32699-8-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 22 Nov 2016, Benjamin Gaignard wrote:

> Add timers MFD and childs into DT for stm32f4.
> Define and enable pwm1 and pwm3 for stm32f469 discovery board
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  arch/arm/boot/dts/stm32f429.dtsi      | 246 ++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/stm32f469-disco.dts |  29 ++++
>  2 files changed, 275 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
> index bca491d..28a0fe9 100644
> --- a/arch/arm/boot/dts/stm32f429.dtsi
> +++ b/arch/arm/boot/dts/stm32f429.dtsi
> @@ -355,6 +355,21 @@
>  					slew-rate = <2>;
>  				};
>  			};
> +
> +			pwm1_pins: pwm@1 {
> +				pins {
> +					pinmux = <STM32F429_PA8_FUNC_TIM1_CH1>,
> +						 <STM32F429_PB13_FUNC_TIM1_CH1N>,
> +						 <STM32F429_PB12_FUNC_TIM1_BKIN>;
> +				};
> +			};
> +
> +			pwm3_pins: pwm@3 {
> +				pins {
> +					pinmux = <STM32F429_PB4_FUNC_TIM3_CH1>,
> +						 <STM32F429_PB5_FUNC_TIM3_CH2>;
> +				};
> +			};
>  		};
>  
>  		rcc: rcc@40023810 {
> @@ -426,6 +441,237 @@
>  			interrupts = <80>;
>  			clocks = <&rcc 0 38>;
>  		};
> +
> +		mfd_timer1: mfdtimer1@40010000 {

Do you reference this node?

If not, it should read:

  advanced-control@40010000

> +			compatible = "st,stm32-mfd-timer1";

"st,stm32-advanced-control"

> +			reg = <0x40010000 0x400>;
> +			clocks = <&rcc 0 160>;
> +			clock-names = "mfd_timer_clk";

"clk_int"

> +			interrupts = <27>;

This is a timer property.

Also move the associated registration C code into the timer driver.

> +			status = "disabled";
> +
> +			pwm1: pwm1@40010000 {

  pwm@0 {

> +				compatible = "st,stm32-pwm1";

st,stm32-advanced-control-pwm

> +				status = "disabled";
> +			};
> +
> +			iiotimer1: iiotimer1@40010000 {

Same here:

  timer@0

> +				compatible = "st,stm32-iio-timer1";

st,stm32-advanced-control-timer

> +				status = "disabled";
> +			};
> +		};
> +
> +		mfd_timer2: mfdtimer2@40000000 {
> +			compatible = "st,stm32-mfd-timer2";
> +			reg = <0x40000000 0x400>;
> +			clocks = <&rcc 0 128>;
> +			clock-names = "mfd_timer_clk";
> +			interrupts = <28>;
> +			status = "disabled";
> +
> +			pwm2: pwm2@40000000 {
> +				compatible = "st,stm32-pwm2";
> +				status = "disabled";
> +			};
> +			iiotimer2: iiotimer2@40000000 {
> +				compatible = "st,stm32-iio-timer2";
> +				status = "disabled";
> +			};
> +		};
> +
> +		mfd_timer3: mfdtimer3@40000400 {
> +			compatible = "st,stm32-mfd-timer3";
> +			reg = <0x40000400 0x400>;
> +			clocks = <&rcc 0 129>;
> +			clock-names = "mfd_timer_clk";
> +			interrupts = <29>;
> +			status = "disabled";
> +
> +			pwm3: pwm3@40000400 {
> +				compatible = "st,stm32-pwm3";
> +				status = "disabled";
> +			};
> +			iiotimer3: iiotimer3@40000400 {
> +				compatible = "st,stm32-iio-timer3";
> +				status = "disabled";
> +			};
> +		};
> +
> +		mfd_timer4: mfdtimer4@40000800 {
> +			compatible = "st,stm32-mfd-timer4";
> +			reg = <0x40000800 0x400>;
> +			clocks = <&rcc 0 130>;
> +			clock-names = "mfd_timer_clk";
> +			interrupts = <30>;
> +			status = "disabled";
> +
> +			pwm4: pwm4@40000800 {
> +				compatible = "st,stm32-pwm4";
> +				status = "disabled";
> +			};
> +			iiotimer4: iiotimer4@40000800 {
> +				compatible = "st,stm32-iio-timer4";
> +				status = "disabled";
> +			};
> +		};
> +
> +		mfd_timer5: mfdtimer5@40000C00 {
> +			compatible = "st,stm32-mfd-timer5";
> +			reg = <0x40000C00 0x400>;
> +			clocks = <&rcc 0 131>;
> +			clock-names = "mfd_timer_clk";
> +			interrupts = <50>;
> +			status = "disabled";
> +
> +			pwm5: pwm5@40000C00 {
> +				compatible = "st,stm32-pwm5";
> +				status = "disabled";
> +			};
> +			iiotimer5: iiotimer5@40000800 {
> +				compatible = "st,stm32-iio-timer5";
> +				status = "disabled";
> +			};
> +		};
> +
> +		mfd_timer6: mfdtimer6@40001000 {
> +			compatible = "st,stm32-mfd-timer6";
> +			reg = <0x40001000 0x400>;
> +			clocks = <&rcc 0 132>;
> +			clock-names = "mfd_timer_clk";
> +			interrupts = <54>;
> +			status = "disabled";
> +
> +			iiotimer6: iiotimer6@40001000 {
> +				compatible = "st,stm32-iio-timer6";
> +				status = "disabled";
> +			};
> +		};
> +
> +		mfd_timer7: mfdtimer7@40001400 {
> +			compatible = "st,stm32-mfd-timer7";
> +			reg = <0x40001400 0x400>;
> +			clocks = <&rcc 0 133>;
> +			clock-names = "mfd_timer_clk";
> +			interrupts = <55>;
> +			status = "disabled";
> +
> +			iiotimer7: iiotimer7@40001400 {
> +				compatible = "st,stm32-iio-timer7";
> +				status = "disabled";
> +			};
> +		};
> +
> +		mfd_timer8: mfdtimer8@40010400 {
> +			compatible = "st,stm32-mfd-timer8";
> +			reg = <0x40010400 0x400>;
> +			clocks = <&rcc 0 161>;
> +			clock-names = "mfd_timer_clk";
> +			interrupts = <46>;
> +			status = "disabled";
> +
> +			pwm8: pwm8@40010400 {
> +				compatible = "st,stm32-pwm8";
> +				status = "disabled";
> +			};
> +
> +			iiotimer8: iiotimer7@40010400 {
> +				compatible = "st,stm32-iio-timer8";
> +				status = "disabled";
> +			};
> +		};
> +
> +		mfd_timer9: mfdtimer9@40014000 {
> +			compatible = "st,stm32-mfd-timer9";
> +			reg = <0x40014000 0x400>;
> +			clocks = <&rcc 0 176>;
> +			clock-names = "mfd_timer_clk";
> +			interrupts = <24>;
> +			status = "disabled";
> +
> +			pwm9: pwm9@40014000 {
> +				compatible = "st,stm32-pwm9";
> +				status = "disabled";
> +			};
> +
> +			iiotimer9: iiotimer9@40014000 {
> +				compatible = "st,stm32-iio-timer9";
> +				status = "disabled";
> +			};
> +		};
> +
> +		mfd_timer10: mfdtimer10@40014400 {
> +			compatible = "st,stm32-mfd-timer10";
> +			reg = <0x40014400 0x400>;
> +			clocks = <&rcc 0 177>;
> +			clock-names = "mfd_timer_clk";
> +			interrupts = <25>;
> +			status = "disabled";
> +
> +			pwm10: pwm10@40014400 {
> +				compatible = "st,stm32-pwm10";
> +				status = "disabled";
> +			};
> +		};
> +
> +		mfd_timer11: mfdtimer11@40014800 {
> +			compatible = "st,stm32-mfd-timer11";
> +			reg = <0x40014800 0x400>;
> +			clocks = <&rcc 0 178>;
> +			clock-names = "mfd_timer_clk";
> +			interrupts = <26>;
> +			status = "disabled";
> +
> +			pwm11: pwm11@40014800 {
> +				compatible = "st,stm32-pwm11";
> +				status = "disabled";
> +			};
> +		};
> +
> +		mfd_timer12: mfdtimer12@40001800 {
> +			compatible = "st,stm32-mfd-timer12";
> +			reg = <0x40001800 0x400>;
> +			clocks = <&rcc 0 134>;
> +			clock-names = "mfd_timer_clk";
> +			interrupts = <43>;
> +			status = "disabled";
> +
> +			pwm12: pwm12@40001800 {
> +				compatible = "st,stm32-pwm12";
> +				status = "disabled";
> +			};
> +			iiotimer12: iiotimer12@40001800 {
> +				compatible = "st,stm32-iio-timer12";
> +				status = "disabled";
> +			};
> +		};
> +
> +		mfd_timer13: mfdtimer13@40001C00 {
> +			compatible = "st,stm32-mfd-timer13";
> +			reg = <0x40001C00 0x400>;
> +			clocks = <&rcc 0 135>;
> +			clock-names = "mfd_timer_clk";
> +			interrupts = <44>;
> +			status = "disabled";
> +
> +			pwm13: pwm13@40001C00 {
> +				compatible = "st,stm32-pwm13";
> +				status = "disabled";
> +			};
> +		};
> +
> +		mfd_timer14: mfdtimer14@40002000 {
> +			compatible = "st,stm32-mfd-timer14";
> +			reg = <0x40002000 0x400>;
> +			clocks = <&rcc 0 136>;
> +			clock-names = "mfd_timer_clk";
> +			interrupts = <45>;
> +			status = "disabled";
> +
> +			pwm14: pwm14@40002000 {
> +				compatible = "st,stm32-pwm14";
> +				status = "disabled";
> +			};
> +		};
>  	};
>  };
>  
> diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
> index 8a163d7..a8f1788 100644
> --- a/arch/arm/boot/dts/stm32f469-disco.dts
> +++ b/arch/arm/boot/dts/stm32f469-disco.dts
> @@ -81,3 +81,32 @@
>  &usart3 {
>  	status = "okay";
>  };
> +
> +&mfd_timer1 {
> +	status = "okay";
> +};
> +
> +&pwm1 {
> +	pinctrl-0	= <&pwm1_pins>;
> +	pinctrl-names	= "default";
> +	st,breakinput-polarity = <0>;

Is this documented?

I'm sure we have generic polarity properties somewhere already?

> +	status = "okay";
> +};
> +
> +&iiotimer1 {
> +	status = "okay";
> +};
> +
> +&mfd_timer3 {
> +	status = "okay";
> +};
> +
> +&pwm3 {
> +	pinctrl-0	= <&pwm3_pins>;
> +	pinctrl-names	= "default";
> +	status = "okay";
> +};
> +
> +&iiotimer3 {
> +	status = "okay";
> +};

I've always disliked this way of referencing nodes!

Any chance we can represent them in a hierarchy, so we don't lose that
information and we can get rid of all those horrible labels?

I'm happy to do the work.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
