Return-Path: <SRS0=Lipv=X3=gmail.com=robherring2@kernel.org>
Date: Mon, 12 Dec 2016 13:02:05 -0600
From: Rob Herring <robh@kernel.org>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: lee.jones@linaro.org, mark.rutland@arm.com, alexandre.torgue@st.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
	jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, fabrice.gasnier@st.com,
	gerald.baeza@st.com, arnaud.pouliquen@st.com,
	linus.walleij@linaro.org, linaro-kernel@lists.linaro.org,
	Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v6 3/8] PWM: add pwm-stm32 DT bindings
Message-ID: <20161212190205.b5t3x6i2o7igldlo@rob-hp-laptop>
References: <1481292919-26587-1-git-send-email-benjamin.gaignard@st.com>
 <1481292919-26587-4-git-send-email-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1481292919-26587-4-git-send-email-benjamin.gaignard@st.com>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Dec 09, 2016 at 03:15:14PM +0100, Benjamin Gaignard wrote:
> Define bindings for pwm-stm32
> 
> version 6:
> - change st,breakinput parameter format to make it usuable on stm32f7 too.
> 
> version 2:
> - use parameters instead of compatible of handle the hardware configuration
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../devicetree/bindings/pwm/pwm-stm32.txt          | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> new file mode 100644
> index 0000000..866f222
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> @@ -0,0 +1,33 @@
> +STMicroelectronics STM32 Timers PWM bindings
> +
> +Must be a sub-node of an STM32 Timers device tree node.
> +See ../mfd/stm32-timers.txt for details about the parent node.
> +
> +Required parameters:
> +- compatible:		Must be "st,stm32-pwm".
> +- pinctrl-names: 	Set to "default".
> +- pinctrl-0: 		List of phandles pointing to pin configuration nodes for PWM module.
> +			For Pinctrl properties see ../pinctrl/pinctrl-bindings.txt
> +
> +Optional parameters:
> +- st,breakinput:	Arrays of three u32 <index level filter> to describe break input configurations.
> +			"index" indicates on which break input the configuration should be applied.
> +			"level" gives the active level (0=low or 1=high) for this configuration.
> +			"filter" gives the filtering value to be applied.
> +
> +Example:
> +	timers@40010000 {

timer@...

With that,

Acked-by: Rob Herring <robh@kernel.org>


> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "st,stm32-timers";
> +		reg = <0x40010000 0x400>;
> +		clocks = <&rcc 0 160>;
> +		clock-names = "clk_int";
> +
> +		pwm {
> +			compatible = "st,stm32-pwm";
> +			pinctrl-0	= <&pwm1_pins>;
> +			pinctrl-names	= "default";
> +			st,breakinput = <0 1 5>;
> +		};
> +	};
> -- 
> 1.9.1
> 
