Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56684 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbbLLQ1m (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Dec 2015 11:27:42 -0500
Subject: Re: [PATCH v5 3/4] ARM: dts: imx7d.dtsi: add ADC support
To: Haibo Chen <haibo.chen@freescale.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, shawnguo@kernel.org,
	kernel@pengutronix.de
References: <1449570383-25716-1-git-send-email-haibo.chen@freescale.com>
 <1449570383-25716-4-git-send-email-haibo.chen@freescale.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <566C4AFC.9060500@kernel.org>
Date: Sat, 12 Dec 2015 16:27:40 +0000
MIME-Version: 1.0
In-Reply-To: <1449570383-25716-4-git-send-email-haibo.chen@freescale.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/12/15 10:26, Haibo Chen wrote:
> Add imx7d ADC support.
> 
> Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
The driver is now working its way in the direction of linux-next via
Greg KHs tree. I'm happy to take these changes as well, but would imagine
they are better routed through the relevant imx trees.

Jonathan
> ---
>  arch/arm/boot/dts/imx7d.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
> index ebc053a..aa0624d 100644
> --- a/arch/arm/boot/dts/imx7d.dtsi
> +++ b/arch/arm/boot/dts/imx7d.dtsi
> @@ -583,6 +583,24 @@
>  			reg = <0x30400000 0x400000>;
>  			ranges;
>  
> +			adc1: adc@30610000 {
> +				compatible = "fsl,imx7d-adc";
> +				reg = <0x30610000 0x10000>;
> +				interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX7D_ADC_ROOT_CLK>;
> +				clock-names = "adc";
> +				status = "disabled";
> +			};
> +
> +			adc2: adc@30620000 {
> +				compatible = "fsl,imx7d-adc";
> +				reg = <0x30620000 0x10000>;
> +				interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX7D_ADC_ROOT_CLK>;
> +				clock-names = "adc";
> +				status = "disabled";
> +			};
> +
>  			pwm1: pwm@30660000 {
>  				compatible = "fsl,imx7d-pwm", "fsl,imx27-pwm";
>  				reg = <0x30660000 0x10000>;
> 

