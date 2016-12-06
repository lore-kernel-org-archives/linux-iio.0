Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35474 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752038AbcLFM5i (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Dec 2016 07:57:38 -0500
Received: by mail-wm0-f44.google.com with SMTP id a197so127422901wmd.0
        for <linux-iio@vger.kernel.org>; Tue, 06 Dec 2016 04:57:37 -0800 (PST)
Date: Tue, 6 Dec 2016 13:00:48 +0000
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
Subject: Re: [PATCH v4 1/7] MFD: add bindings for STM32 General Purpose Timer
 driver
Message-ID: <20161206130048.GH25385@dell.home>
References: <1481027929-13704-1-git-send-email-benjamin.gaignard@st.com>
 <1481027929-13704-2-git-send-email-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1481027929-13704-2-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 06 Dec 2016, Benjamin Gaignard wrote:

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
> index 0000000..e92c8be
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/stm32-general-purpose-timer.txt
> @@ -0,0 +1,39 @@
> +STM32 General Purpose Timer driver bindings
> +
> +Required parameters:
> +- compatible: must be "st,stm32-gptimer"
> +
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
> +	gptimer@40010000 {

I'm not going to push too hard, but I still thing "advanced-control"
would suit better, since this is not *just* a timer.  In fact, the
parent device (the MFD) doesn't have any timer functionality.  That's
what "timer@0" does.

The IP is called "Advanced Control" in the datasheet, no?

> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "st,stm32-gptimer";
> +		reg = <0x40010000 0x400>;
> +		clocks = <&rcc 0 160>;
> +		clock-names = "clk_int";
> +
> +		pwm@0 {
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
