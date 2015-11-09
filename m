Return-Path: <robh@kernel.org>
Date: Mon, 9 Nov 2015 09:56:40 -0600
From: Rob Herring <robh@kernel.org>
To: Haibo Chen <haibo.chen@freescale.com>
Cc: pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, shawnguo@kernel.org, kernel@pengutronix.de,
	linux@arm.linux.org.uk, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/4] Documentation: add the binding file for Freescale
 imx7d ADC driver
Message-ID: <20151109155640.GA21805@rob-hp-laptop>
References: <1447075704-4605-1-git-send-email-haibo.chen@freescale.com>
 <1447075704-4605-3-git-send-email-haibo.chen@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1447075704-4605-3-git-send-email-haibo.chen@freescale.com>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Nov 09, 2015 at 09:28:22PM +0800, Haibo Chen wrote:
> The patch adds the binding file for Freescale imx7d ADC driver.
> 
> Signed-off-by: Haibo Chen <haibo.chen@freescale.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  .../devicetree/bindings/iio/adc/imx7d-adc.txt      | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt b/Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt
> new file mode 100644
> index 0000000..7f4ec1b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt
> @@ -0,0 +1,26 @@
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
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
