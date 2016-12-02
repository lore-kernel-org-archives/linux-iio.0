Return-Path: <SRS0=Dd8l=XR=linaro.org=lee.jones@kernel.org>
Date: Fri, 2 Dec 2016 13:59:04 +0000
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
Subject: Re: [PATCH v3 5/7] IIO: add bindings for stm32 timer trigger driver
Message-ID: <20161202135904.GN2683@dell>
References: <1480673842-20804-1-git-send-email-benjamin.gaignard@st.com>
 <1480673842-20804-6-git-send-email-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1480673842-20804-6-git-send-email-benjamin.gaignard@st.com>
List-ID: <linux-iio@vger.kernel.org>

On Fri, 02 Dec 2016, Benjamin Gaignard wrote:

> Define bindings for stm32 timer trigger
> 
> version 3:
> - change file name
> - add cross reference with mfd bindings
> 
> version 2:
> - only keep one compatible
> - add DT parameters to set lists of the triggers:
>   one list describe the triggers created by the device
>   another one give the triggers accepted by the device
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../bindings/iio/timer/stm32-timer-trigger.txt     | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt b/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
> new file mode 100644
> index 0000000..858816d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
> @@ -0,0 +1,39 @@
> +timer trigger bindings for STM32
> +
> +Must be a sub-node of STM32 general purpose timer driver
> +Parent node properties are describe in ../mfd/stm32-general-purpose-timer.txt
> +
> +Required parameters:
> +- compatible:		must be "st,stm32-iio-timer"
> +- interrupts:		Interrupt for this device
> +			See ../interrupt-controller/st,stm32-exti.txt
> +
> +Optional parameters:
> +- st,input-triggers-names:	List of the possible input triggers for
> +				the device
> +- st,output-triggers-names:	List of the possible output triggers for
> +				the device
> +
> +Possible triggers are defined in include/dt-bindings/iio/timer/st,stm32-timer-trigger.h
> +
> +Example:
> +	gptimer1: gptimer1@40010000 {
> +		compatible = "st,stm32-gptimer";
> +		reg = <0x40010000 0x400>;
> +		clocks = <&rcc 0 160>;
> +		clock-names = "clk_int";
> +
> +		timer1@0 {
> +			compatible = "st,stm32-timer-trigger";
> +			interrupts = <27>;
> +			st,input-triggers-names = TIM5_TRGO,
> +						  TIM2_TRGO,
> +						  TIM4_TRGO,
> +						  TIM3_TRGO;
> +			st,output-triggers-names = TIM1_TRGO,
> +						   TIM1_CH1,
> +						   TIM1_CH2,
> +						   TIM1_CH3,
> +						   TIM1_CH4;

I see why you've done it like this now ... because it makes things
easier for you in the driver, since the IIO subsystem matches on names
such as these.

BUT, this is a Linux-implementation-ism.  Just use pairs of integers
and create the Linux-ism strings in the driver.

> +		};
> +	};

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
