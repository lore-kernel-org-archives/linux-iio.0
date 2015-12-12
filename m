Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56679 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbbLLQ0L (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Dec 2015 11:26:11 -0500
Subject: Re: [PATCH v5 2/4] Documentation: add the binding file for Freescale
 imx7d ADC driver
To: Haibo Chen <haibo.chen@freescale.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, shawnguo@kernel.org,
	kernel@pengutronix.de
References: <1449570383-25716-1-git-send-email-haibo.chen@freescale.com>
 <1449570383-25716-3-git-send-email-haibo.chen@freescale.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <566C4A9C.3060903@kernel.org>
Date: Sat, 12 Dec 2015 16:26:04 +0000
MIME-Version: 1.0
In-Reply-To: <1449570383-25716-3-git-send-email-haibo.chen@freescale.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/12/15 10:26, Haibo Chen wrote:
> The patch adds the binding file for Freescale imx7d ADC driver.
> 
> Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
> Acked-by: Rob Herring <robh@kernel.org>
Applied 
> ---
>  .../devicetree/bindings/iio/adc/imx7d-adc.txt      | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt b/Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt
> new file mode 100644
> index 0000000..5c184b9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt
> @@ -0,0 +1,22 @@
> +Freescale imx7d ADC bindings
> +
> +The devicetree bindings are for the ADC driver written for
> +imx7d SoC.
> +
> +Required properties:
> +- compatible: Should be "fsl,imx7d-adc"
> +- reg: Offset and length of the register set for the ADC device
> +- interrupts: The interrupt number for the ADC device
> +- clocks: The root clock of the ADC controller
> +- clock-names: Must contain "adc", matching entry in the clocks property
> +- vref-supply: The regulator supply ADC reference voltage
> +
> +Example:
> +adc1: adc@30610000 {
> +	compatible = "fsl,imx7d-adc";
> +	reg = <0x30610000 0x10000>;
> +	interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> +	clocks = <&clks IMX7D_ADC_ROOT_CLK>;
> +	clock-names = "adc";
> +	vref-supply = <&reg_vcc_3v3_mcu>;
> +};
> 

