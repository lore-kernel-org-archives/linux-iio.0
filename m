Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:8539 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751497AbdG0Ha7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Jul 2017 03:30:59 -0400
Subject: Re: [PATCH 4/4] ARM: dts: stm32: Add DAC support on stm32f429
To: Fabrice Gasnier <fabrice.gasnier@st.com>, <jic23@kernel.org>,
        <robh+dt@kernel.org>
CC: <linux@armlinux.org.uk>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1499693040-12994-1-git-send-email-fabrice.gasnier@st.com>
 <1499693040-12994-5-git-send-email-fabrice.gasnier@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <5b66624c-3a4c-a3af-72b2-d867cf880722@st.com>
Date: Thu, 27 Jul 2017 09:29:55 +0200
MIME-Version: 1.0
In-Reply-To: <1499693040-12994-5-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On 07/10/2017 03:24 PM, Fabrice Gasnier wrote:
> Add support for DAC (Digital to Analog Converter) to STM32F429.
> STM32F429 DAC has two output channels.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>   arch/arm/boot/dts/stm32f429.dtsi | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
> index b2a2b5c..f15f633 100644
> --- a/arch/arm/boot/dts/stm32f429.dtsi
> +++ b/arch/arm/boot/dts/stm32f429.dtsi
> @@ -354,6 +354,31 @@
>   			status = "disabled";
>   		};
>   
> +		dac: dac@40007400 {
> +			compatible = "st,stm32f4-dac-core";
> +			reg = <0x40007400 0x400>;
> +			resets = <&rcc STM32F4_APB1_RESET(DAC)>;
> +			clocks = <&rcc 0 STM32F4_APB1_CLOCK(DAC)>;
> +			clock-names = "pclk";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +
> +			dac1: dac@1 {
> +				compatible = "st,stm32-dac";
> +				#io-channels-cells = <1>;
> +				reg = <1>;
> +				status = "disabled";
> +			};
> +
> +			dac2: dac@2 {
> +				compatible = "st,stm32-dac";
> +				#io-channels-cells = <1>;
> +				reg = <2>;
> +				status = "disabled";
> +			};
> +		};
> +
>   		usart7: serial@40007800 {
>   			compatible = "st,stm32-usart", "st,stm32-uart";
>   			reg = <0x40007800 0x400>;
> 
Applied on stm32-dt-for-v4.14 branch.

Thanks
Alex
