Return-Path: <SRS0=abQ9=5U=linaro.org=lee.jones@kernel.org>
Date: Thu, 15 Jun 2017 07:56:12 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: benjamin.gaignard@linaro.org, jic23@kernel.org,
	thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
	alexandre.torgue@st.com, mcoquelin.stm32@gmail.com,
	benjamin.gaignard@st.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: mfd: update STM32 timers clock names
Message-ID: <20170615065612.qv4ce7tzvn2uhqds@dell>
References: <1497453196-31470-1-git-send-email-fabrice.gasnier@st.com>
 <1497453196-31470-2-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1497453196-31470-2-git-send-email-fabrice.gasnier@st.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed, 14 Jun 2017, Fabrice Gasnier wrote:

> Clock name has been updated during driver/DT binding review:
> https://lkml.org/lkml/2016/12/13/718
> Update DT binding doc to reflect this.
> 
> Fixes: 8f9359c6c6a0 (dt-bindings: mfd: Add bindings for STM32 Timers driver)
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Acked-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/stm32-timers.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

> diff --git a/Documentation/devicetree/bindings/mfd/stm32-timers.txt b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
> index bbd083f..1db6e00 100644
> --- a/Documentation/devicetree/bindings/mfd/stm32-timers.txt
> +++ b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
> @@ -31,7 +31,7 @@ Example:
>  		compatible = "st,stm32-timers";
>  		reg = <0x40010000 0x400>;
>  		clocks = <&rcc 0 160>;
> -		clock-names = "clk_int";
> +		clock-names = "int";
>  
>  		pwm {
>  			compatible = "st,stm32-pwm";

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
