Return-Path: <SRS0=+NQe=5O=linaro.org=benjamin.gaignard@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1496993874-9870-2-git-send-email-fabrice.gasnier@st.com>
References: <1496993874-9870-1-git-send-email-fabrice.gasnier@st.com> <1496993874-9870-2-git-send-email-fabrice.gasnier@st.com>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Fri, 9 Jun 2017 09:43:21 +0200
Message-ID: <CA+M3ks7sQ_1kF_ZgQ1+mLwDVo2=CVmACFBvSuY+FyZ9WXY=5tw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mfd: update STM32 timers clock names
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Lee Jones <lee.jones@linaro.org>, Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexandre Torgue <alexandre.torgue@st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Benjamin GAIGNARD <benjamin.gaignard@st.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

2017-06-09 9:37 GMT+02:00 Fabrice Gasnier <fabrice.gasnier@st.com>:
> Clock name has been updated during driver/DT binding review:
> https://lkml.org/lkml/2016/12/13/718
> Update DT binding doc to reflect this.
>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  Documentation/devicetree/bindings/mfd/stm32-timers.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mfd/stm32-timers.txt b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
> index bbd083f..1db6e00 100644
> --- a/Documentation/devicetree/bindings/mfd/stm32-timers.txt
> +++ b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
> @@ -31,7 +31,7 @@ Example:
>                 compatible = "st,stm32-timers";
>                 reg = <0x40010000 0x400>;
>                 clocks = <&rcc 0 160>;
> -               clock-names = "clk_int";
> +               clock-names = "int";
>
>                 pwm {
>                         compatible = "st,stm32-pwm";
> --
> 1.9.1
>

Acked-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
