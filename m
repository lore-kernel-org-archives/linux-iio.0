Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wj0-f169.google.com ([209.85.210.169]:33431 "EHLO
        mail-wj0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932651AbcLIIuR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Dec 2016 03:50:17 -0500
Received: by mail-wj0-f169.google.com with SMTP id xy5so8912110wjc.0
        for <linux-iio@vger.kernel.org>; Fri, 09 Dec 2016 00:50:16 -0800 (PST)
Date: Fri, 9 Dec 2016 08:53:31 +0000
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
Subject: Re: [PATCH v5 1/7] MFD: add bindings for STM32 General Purpose Timer
 driver
Message-ID: <20161209085331.GB3625@dell.home>
References: <1481199650-22484-1-git-send-email-benjamin.gaignard@st.com>
 <1481199650-22484-2-git-send-email-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1481199650-22484-2-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Sorry to do this Ben.  Not much to do now though!

> Add bindings information for STM32 General Purpose Timer
> 
> version 2:
> - rename stm32-mfd-timer to stm32-gptimer
> - only keep one compatible string
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../bindings/mfd/stm32-general-purpose-timer.txt   | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/stm32-general-purpose-timer.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/stm32-general-purpose-timer.txt b/Documentation/devicetree/bindings/mfd/stm32-general-purpose-timer.txt
> new file mode 100644
> index 0000000..ce67755
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/stm32-general-purpose-timer.txt
> @@ -0,0 +1,39 @@
> +STM32 General Purpose Timer driver bindings

This is a great place to describe what we're *actually* trying to
achieve with this driver, and the worst place to use the term "general
purpose", since this IP is so much more than that.


"STM32 Timers

This IP provides 3 types of timer along with PWM functionality.

[...]"

... then go on to explain what the 3 types are and how they can be
used.

> +Required parameters:
> +- compatible: must be "st,stm32-gptimer"

I vehemently disagree that this entire IP is a GP Timer.  It contains
GP timers, sure, but it also contains Advanced and Basic timers.

IMHO this compatible should be "st,stm32-timers".

And the file name of both this and the *.c file should reflect that
too.

Remainder looks nice.

> +- reg:			Physical base address and length of the controller's
> +			registers.
> +- clock-names: 		Set to "clk_int".
> +- clocks: 		Phandle to the clock used by the timer module.
> +			For Clk properties, please refer to ../clock/clock-bindings.txt
> +
> +Optional parameters:
> +- resets:		Phandle to the parent reset controller.
> +			See ../reset/st,stm32-rcc.txt
> +
> +Optional subnodes:
> +- pwm:			See ../pwm/pwm-stm32.txt
> +- timer:		See ../iio/timer/stm32-timer-trigger.txt
> +
> +Example:
> +	timers@40010000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "st,stm32-gptimer";
> +		reg = <0x40010000 0x400>;
> +		clocks = <&rcc 0 160>;
> +		clock-names = "clk_int";
> +
> +		pwm@0 {

Out of interest, do you use the "@0", "@1" for anything now?

> +			compatible = "st,stm32-pwm";
> +			pinctrl-0	= <&pwm1_pins>;
> +			pinctrl-names	= "default";
> +		};
> +
> +		timer@0 {
> +			compatible = "st,stm32-timer-trigger";
> +			reg = <0>;
> +		};
> +	};

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
