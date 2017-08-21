Return-Path: <SRS0=RL2J=7X=linaro.org=lee.jones@kernel.org>
Date: Mon, 21 Aug 2017 08:24:33 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: benjamin.gaignard@linaro.org, jic23@kernel.org,
	thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
	alexandre.torgue@st.com, mcoquelin.stm32@gmail.com,
	benjamin.gaignard@st.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 0/9] Add STM32 LPTimer: PWM, trigger and counter
Message-ID: <20170821072433.fvtezmsnrkuhnx6w@dell>
References: <1499445068-7037-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1499445068-7037-1-git-send-email-fabrice.gasnier@st.com>
List-ID: <linux-iio@vger.kernel.org>

On Fri, 07 Jul 2017, Fabrice Gasnier wrote:

> This series adds support for Low-Power Timer that can be found on
> some STM32 devices.
> 
> STM32 LPTimer (LPTIM) is a 16-bit timer that provides several
> functionalities. This series adds support for following features:
> - PWM output (with programmable prescaler, configurable polarity)
> - Trigger source for STM32 ADC or DAC (LPTIM_OUT)
> - Quadrature encoder and counter
> 
> The MFD core is used to manage common resources (clock, register map)
> and to detect encoder feature. "stm32_lptimer" structure is provided
> to its sub-nodes to share those information:
> - PWM driver is used to implement single PWM channel
> - IIO trigger
> - IIO quadrature encoder and counter
> 
> ---
> Changes in v3:
> - I sent this v3 with various changes, but still need to discuss ABI
>   for counter driver (no change on this in v3).
> - Remarks for Rob on dt-bindings
> - Add validate_device in Trigger driver
> - Update PWM driver after Thierry's comments
> - Additional patch for STM32 ADC trigger

Looks like you have everything you need.

Please apply all the Acks you've collected and [RESEND].

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
