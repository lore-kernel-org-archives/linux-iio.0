Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42260 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751042AbcK0OZu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Nov 2016 09:25:50 -0500
Subject: Re: [PATCH v2 5/7] IIO: add bindings for stm32 IIO timer driver
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1480000463-9625-1-git-send-email-benjamin.gaignard@st.com>
 <1480000463-9625-6-git-send-email-benjamin.gaignard@st.com>
Cc: fabrice.gasnier@st.com, gerald.baeza@st.com,
        arnaud.pouliquen@st.com, linus.walleij@linaro.org,
        linaro-kernel@lists.linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <b2002a81-49fe-af2a-f13a-9f09831aa530@kernel.org>
Date: Sun, 27 Nov 2016 14:25:46 +0000
MIME-Version: 1.0
In-Reply-To: <1480000463-9625-6-git-send-email-benjamin.gaignard@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/11/16 15:14, Benjamin Gaignard wrote:
> Define bindings for stm32 IIO timer
> 
> version 2:
> - only keep one compatible
> - add DT parameters to set lists of the triggers:
>   one list describe the triggers created by the device
>   another one give the triggers accepted by the device
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../bindings/iio/timer/stm32-iio-timer.txt         | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt b/Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt
> new file mode 100644
> index 0000000..840b417
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt
> @@ -0,0 +1,41 @@
> +timer IIO trigger bindings for STM32
> +
> +Must be a sub-node of STM32 general purpose timer driver
Add a cross reference...
> +
> +Required parameters:
> +- compatible:		must be "st,stm32-iio-timer"
st,stm32-adc-timer or something like that.
> +- interrupts:		Interrupt for this device
> +			See ../interrupt-controller/st,stm32-exti.txt
> +
> +Optional parameters:
> +- st,input-triggers-names:	List of the possible input triggers for
> +				the device
> +- st,output-triggers-names:	List of the possible output triggers for
> +				the device
What are input / output triggers?
> +
> +Possible triggers are defined in include/dt-bindings/iio/timer/st,stm32-iio-timer.h
> +
> +Example:
> +	gptimer1: gptimer1@40010000 {
> +		compatible = "st,stm32-gptimer";
> +		reg = <0x40010000 0x400>;
> +		clocks = <&rcc 0 160>;
> +		clock-names = "clk_int";
> +
> +		pwm1@0 {
> +			compatible = "st,stm32-pwm";
> +			st,pwm-num-chan = <4>;
> +			st,breakinput;
> +			st,complementary;
> +		};
> +
> +		iiotimer1@0 {
> +			compatible = "st,stm32-iio-timer";
> +			interrupts = <27>;
> +			st,input-triggers-names = TIM5_TRGO,
> +						  TIM2_TRGO,
> +						  TIM4_TRGO,
> +						  TIM3_TRGO;
> +			st,output-triggers-names = TIM1_TRGO;
> +		};
> +	};
> 

