Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:31828 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751693AbdATKET (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Jan 2017 05:04:19 -0500
Subject: Re: [PATCH v9 8/8] ARM: dts: stm32: Enable pwm1 and pwm3 for
 stm32f469-disco
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <thierry.reding@gmail.com>,
        <linux-pwm@vger.kernel.org>, <jic23@kernel.org>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <1484903709-11650-1-git-send-email-benjamin.gaignard@st.com>
 <1484903709-11650-9-git-send-email-benjamin.gaignard@st.com>
CC: <fabrice.gasnier@st.com>, <gerald.baeza@st.com>,
        <arnaud.pouliquen@st.com>, <linaro-kernel@lists.linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <77a0e229-1ab0-33f2-edf0-71efd76fdc4a@st.com>
Date: Fri, 20 Jan 2017 11:03:19 +0100
MIME-Version: 1.0
In-Reply-To: <1484903709-11650-9-git-send-email-benjamin.gaignard@st.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Benjamin,

On 01/20/2017 10:15 AM, Benjamin Gaignard wrote:
> Define and enable pwm1 and pwm3 for stm32f469 discovery board
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  arch/arm/boot/dts/stm32f469-disco.dts | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
> index 8a163d7..92552d3 100644
> --- a/arch/arm/boot/dts/stm32f469-disco.dts
> +++ b/arch/arm/boot/dts/stm32f469-disco.dts
> @@ -81,3 +81,31 @@
>  &usart3 {
>  	status = "okay";
>  };
> +
> +&timers1 {
> +	status = "okay";
> +
> +	pwm {
> +		pinctrl-0 = <&pwm1_pins>;
> +		pinctrl-names = "default";
> +		status = "okay";
> +	};
> +
> +	timer@0 {
> +		status = "okay";
> +	};
> +};
> +
> +&timers3 {
> +	status = "okay";
> +
> +	pwm {
> +		pinctrl-0 = <&pwm3_pins>;
> +		pinctrl-names = "default";
> +		status = "okay";
> +	};
> +
> +	timer@2 {
> +		status = "okay";
> +	};
> +};
>

Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>

Thanks
Alex
