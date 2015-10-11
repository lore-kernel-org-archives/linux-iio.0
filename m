Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41345 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180AbbJKNbj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 11 Oct 2015 09:31:39 -0400
Subject: Re: [PATCH 2/5] Documentation: add the binding file for Freescale
 imx7d ADC driver
To: Haibo Chen <haibo.chen@freescale.com>, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	shawnguo@kernel.org, kernel@pengutronix.de,
	mturquette@baylibre.com, sboyd@codeaurora.org
References: <1444301948-21721-1-git-send-email-haibo.chen@freescale.com>
 <1444301948-21721-2-git-send-email-haibo.chen@freescale.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <561A64B7.6000006@kernel.org>
Date: Sun, 11 Oct 2015 14:31:35 +0100
MIME-Version: 1.0
In-Reply-To: <1444301948-21721-2-git-send-email-haibo.chen@freescale.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/10/15 11:59, Haibo Chen wrote:
> The patch adds the binding file for Freescale imx7d ADC driver.
> 
> Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
Couple of trivial typos..  otherwise fine.
> ---
>  .../devicetree/bindings/iio/adc/imx7d-adc.txt      | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt b/Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt
> new file mode 100644
> index 0000000..6b21fd27
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt
> @@ -0,0 +1,26 @@
> +Freescale imx7d ADC bindings
> +
> +The devicetree bingdings are for the nwe ADC driver written for
> +imx7d SoC.
bindings and new
> +
> +Required properties:
> +- compatible: Should be "fsl,imx7d-adc"
> +- reg: Offset and length of the register set for the ADC device
> +- interrupts: The interrupt number for the ADC device
> +- clocks: The root clock of the ADC controller
> +- clock-names: Must contain "adc", matching entry in the clocks property
> +- vref-supply: The regulator supply ADC reference voltage
> +
> +Optional properties:
> +- num-channels: the number of channels used
> +
> +Example:
> +adc1: adc@30610000 {
> +	compatible = "fsl,imx7d-adc";
> +	reg = <0x30610000 0x10000>;
> +	interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> +	clocks = <&clks IMX7D_ADC_ROOT_CLK>;
> +	clock-names = "adc";
> +	num-channels = <4>;
> +	vref-supply = <&reg_vcc_3v3_mcu>;
> +};
> 

