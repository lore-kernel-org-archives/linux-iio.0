Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:34787 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758674AbcK3VfE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Nov 2016 16:35:04 -0500
Date: Wed, 30 Nov 2016 15:20:55 -0600
From: Rob Herring <robh@kernel.org>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: lee.jones@linaro.org, mark.rutland@arm.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        linux-pwm@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, fabrice.gasnier@st.com,
        gerald.baeza@st.com, arnaud.pouliquen@st.com,
        linus.walleij@linaro.org, linaro-kernel@lists.linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v2 3/7] PWM: add pwm-stm32 DT bindings
Message-ID: <20161130212055.b57qkqy66j5gg57q@rob-hp-laptop>
References: <1480000463-9625-1-git-send-email-benjamin.gaignard@st.com>
 <1480000463-9625-4-git-send-email-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1480000463-9625-4-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Nov 24, 2016 at 04:14:19PM +0100, Benjamin Gaignard wrote:
> Define bindings for pwm-stm32
> 
> version 2:
> - use parameters instead of compatible of handle the hardware configuration
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../devicetree/bindings/pwm/pwm-stm32.txt          | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> new file mode 100644
> index 0000000..36263f0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> @@ -0,0 +1,37 @@
> +STMicroelectronics PWM driver bindings for STM32
> +
> +Must be a sub-node of STM32 general purpose timer driver
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
> +- st,pwm-num-chan:	Number of available PWM channels.  Default is 0.
> +- st,32bits-counter:	Set if the hardware have a 32 bits counter
> +- st,complementary:	Set if the hardware have complementary output channels

What does complementary mean here?

> +
> +[1] Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> +
> +Example:
> +	gptimer1: gptimer1@40010000 {

timer@...

> +		compatible = "st,stm32-gptimer";
> +		reg = <0x40010000 0x400>;
> +		clocks = <&rcc 0 160>;
> +		clock-names = "clk_int";
> +
> +		pwm1@0 {

pwm {

Is there more than one?

> +			compatible = "st,stm32-pwm";
> +			st,pwm-num-chan = <4>;
> +			st,breakinput;
> +			st,complementary;
> +		};
> +	};
> -- 
> 1.9.1
> 
