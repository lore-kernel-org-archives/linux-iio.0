Return-Path: <SRS0=2l9b=5Z=linaro.org=lee.jones@kernel.org>
Date: Tue, 20 Jun 2017 12:50:40 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: benjamin.gaignard@linaro.org, jic23@kernel.org,
	thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
	alexandre.torgue@st.com, mcoquelin.stm32@gmail.com,
	benjamin.gaignard@st.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/8] dt-bindings: mfd: Add STM32 LPTimer binding
Message-ID: <20170620115040.xyaivbtcuufhxlv7@dell>
References: <1497628726-7563-1-git-send-email-fabrice.gasnier@st.com>
 <1497628726-7563-2-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1497628726-7563-2-git-send-email-fabrice.gasnier@st.com>
List-ID: <linux-iio@vger.kernel.org>

On Fri, 16 Jun 2017, Fabrice Gasnier wrote:

> Add documentation for STMicroelectronics STM32 Low Power Timer binding.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  .../devicetree/bindings/mfd/stm32-lptimer.txt      | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt b/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
> new file mode 100644
> index 0000000..237b7d6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
> @@ -0,0 +1,51 @@
> +STMicroelectronics STM32 Low Power Timer
> +
> +The STM32 Low Power Timer (LPTIM) is a 16-bit timer that provides several
> +functionalities:

"functions".

> +- PWM output (with programmable prescaler, configurable polarity)
> +- Quadrature encoder, counter
> +- Trigger source for STM32 ADC/DAC (LPTIM_OUT)
> +
> +Required properties:
> +- compatible: Must be "st,stm32-lptimer".
> +- reg: Offset and length of the device's register set.
> +- clocks: Phandle to the clock used by the LP Timer module.
> +- clock-names: Must be "int".

These look better when padded:

- compatible:		Must be "st,stm32-lptimer".
- reg:			Offset and length of the device's register set.
- clocks:		Phandle to the clock used by the LP Timer module.
- clock-names:		Must be "int".

> +- #address-cells = <1>;
> +- #size-cells = <0>;

Please use the same format as you did for the other properties.

> +Optional properties:
> +- resets: Must contain the phandle to the reset controller.
> +
> +Optional subnodes:
> +- pwm: See ../pwm/pwm-stm32-lp.txt
> +- counter: See ../iio/timer/stm32-lptimer-cnt.txt
> +- trigger: See ../iio/timer/stm32-lptimer-trigger.txt
> +
> +Example:
> +
> +	lptimer1: lptimer@0x40002400 {

Remove '0x'

> +		compatible = "st,stm32-lptimer";
> +		reg = <0x40002400 0x400>;
> +		clocks = <&timer_clk>;
> +		clock-names = "int";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pwm {
> +			compatible = "st,stm32-pwm-lp";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&lppwm1_pins>;
> +		};
> +
> +		trigger@0 {

Why is this @0 and no reg properties are provided for the other 2
nodes?

> +			compatible = "st,stm32-lptimer-trigger";
> +			reg = <0>;
> +		};
> +
> +		counter {
> +			compatible = "st,stm32-lptimer-counter";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&lptim1_in_pins>;
> +		};
> +	};

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
