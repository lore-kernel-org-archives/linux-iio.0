Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35926 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756086AbcKVQtg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Nov 2016 11:49:36 -0500
Received: by mail-wm0-f45.google.com with SMTP id g23so34833489wme.1
        for <linux-iio@vger.kernel.org>; Tue, 22 Nov 2016 08:49:28 -0800 (PST)
Date: Tue, 22 Nov 2016 16:52:28 +0000
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
Subject: Re: [PATCH 1/7] add binding for stm32 multifunctions timer driver
Message-ID: <20161122165228.GK10134@dell.home>
References: <1479831207-32699-1-git-send-email-benjamin.gaignard@st.com>
 <1479831207-32699-2-git-send-email-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1479831207-32699-2-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 22 Nov 2016, Benjamin Gaignard wrote:

> Add bindings information for stm32 timer MFD
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../devicetree/bindings/mfd/stm32-timer.txt        | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/stm32-timer.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/stm32-timer.txt b/Documentation/devicetree/bindings/mfd/stm32-timer.txt
> new file mode 100644
> index 0000000..3cefce1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/stm32-timer.txt
> @@ -0,0 +1,53 @@
> +STM32 multifunctions timer driver

"STM32 Multi-Function Timer/PWM device bindings"

Doesn't this shared device have a better name?

> +stm32 timer MFD allow to handle at the same time pwm and IIO timer devices

No need for this sentence.

> +Required parameters:
> +- compatible: must be one of the follow value:
> +	"st,stm32-mfd-timer1"
> +	"st,stm32-mfd-timer2"
> +	"st,stm32-mfd-timer3"
> +	"st,stm32-mfd-timer4"
> +	"st,stm32-mfd-timer5"
> +	"st,stm32-mfd-timer6"
> +	"st,stm32-mfd-timer7"
> +	"st,stm32-mfd-timer8"
> +	"st,stm32-mfd-timer9"
> +	"st,stm32-mfd-timer10"
> +	"st,stm32-mfd-timer11"
> +	"st,stm32-mfd-timer12"
> +	"st,stm32-mfd-timer13"
> +	"st,stm32-mfd-timer14"

We don't normally number devices.

What's stopping you from simply doing:

	pwm1: pwm1@40010000 {
		compatible = "st,stm32-pwm";
	};
	pwm2: pwm1@40020000 {
		compatible = "st,stm32-pwm";
	};
	pwm3: pwm1@40030000 {
		compatible = "st,stm32-pwm";
	};

> +- reg :			Physical base address and length of the controller's
> +			registers.
> +- clock-names: 		Set to "mfd_timer_clk".

How many clocks are there?

If only 1, you don't need this property.

"mfd_timer_clk" is not the correct name.

What is it called in the datasheet?

> +- clocks: 		Phandle of the clock used by the timer module.

"Phandle to the clock ..."

> +			For Clk properties, please refer to [1].
> +- interrupts :		Reference to the timer interrupt

Reference to?

See how other binding documents describe this property.

> +Optional parameters:
> +- resets :		Reference to a reset controller asserting the timer

As above.

> +Optional subnodes:

Either use ":" or " :" or "<tab>:", but keep it consistent.

> +- pwm:			See Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> +- iiotimer:		See Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt
> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt

Use the relative paths "../clock/", "../pwm/", "../iio/".

> +Example:
> +	mfd_timer1: mfdtimer1@40010000 {

This is not an "MFD timer".  MFD is a Linuxisum.

> +		compatible = "st,stm32-mfd-timer1";

Better description required.

> +		reg = <0x40010000 0x400>;
> +		clocks = <&rcc 0 160>;
> +		clock-names = "mfd_timer_clk";
> +		interrupts = <27>;
> +
> +		pwm1: pwm1@40010000 {
> +			compatible = "st,stm32-pwm1";
> +		};
> +
> +		iiotimer1: iiotimer1@40010000 {
> +			compatible = "st,stm32-iio-timer1";
> +		};
> +	};

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
