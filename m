Return-Path: <SRS0=Dd8l=XR=linaro.org=lee.jones@kernel.org>
Date: Fri, 2 Dec 2016 14:23:02 +0000
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
Subject: Re: [PATCH v3 3/7] PWM: add pwm-stm32 DT bindings
Message-ID: <20161202142302.GO2683@dell>
References: <1480673842-20804-1-git-send-email-benjamin.gaignard@st.com>
 <1480673842-20804-4-git-send-email-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1480673842-20804-4-git-send-email-benjamin.gaignard@st.com>
List-ID: <linux-iio@vger.kernel.org>

On Fri, 02 Dec 2016, Benjamin Gaignard wrote:

> Define bindings for pwm-stm32
> 
> version 2:
> - use parameters instead of compatible of handle the hardware configuration
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../devicetree/bindings/pwm/pwm-stm32.txt          | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> new file mode 100644
> index 0000000..575b9fb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> @@ -0,0 +1,38 @@
> +STMicroelectronics PWM driver bindings for STM32
> +
> +Must be a sub-node of STM32 general purpose timer driver
> +Parent node properties are describe in ../mfd/stm32-general-purpose-timer.txt
> +
> +Required parameters:
> +- compatible:		Must be "st,stm32-pwm"
> +- pinctrl-names: 	Set to "default".
> +- pinctrl-0: 		List of phandles pointing to pin configuration nodes
> +			for PWM module.
> +			For Pinctrl properties, please refer to [1].
> +
> +Optional parameters:
> +- st,breakinput:	Set if the hardware have break input capabilities
> +- st,breakinput-polarity: Set break input polarity. Default is 0
> +			 The value define the active polarity:
> +			  - 0 (active LOW)
> +			  - 1 (active HIGH)

> +- st,breakinput-polarity-high

Then assume the default if the property is not present.

> +- st,pwm-num-chan:	Number of available PWM channels.  Default is 0.

What's the point in having a PWM device with  no channels?

Best to make this a compulsory property.

> +- st,32bits-counter:	Set if the hardware have a 32 bits counter
> +- st,complementary:	Set if the hardware have complementary output channels
> +
> +[1] Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt

Use relative path.

../pinctrl/pinctrl-bindings.txt

> +Example:
> +	gptimer1: gptimer1@40010000 {
> +		compatible = "st,stm32-gptimer";
> +		reg = <0x40010000 0x400>;
> +		clocks = <&rcc 0 160>;
> +		clock-names = "clk_int";
> +
> +		pwm1@0 {

Don't number the node name.

pwm@xx

> +			compatible = "st,stm32-pwm";
> +			st,pwm-num-chan = <4>;
> +			st,breakinput;
> +			st,complementary;
> +		};
> +	};

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
