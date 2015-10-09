Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:36005 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932268AbbJIM7g (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 9 Oct 2015 08:59:36 -0400
MIME-Version: 1.0
In-Reply-To: <1444301948-21721-2-git-send-email-haibo.chen@freescale.com>
References: <1444301948-21721-1-git-send-email-haibo.chen@freescale.com> <1444301948-21721-2-git-send-email-haibo.chen@freescale.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 9 Oct 2015 07:59:15 -0500
Message-ID: <CAL_JsqLpZ9+3L8=3QQt6VhYn=jAkO6kw4C4eHxjGmGwL4O3_vg@mail.gmail.com>
Subject: Re: [PATCH 2/5] Documentation: add the binding file for Freescale
 imx7d ADC driver
To: Haibo Chen <haibo.chen@freescale.com>
Cc: Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, shawnguo@kernel.org,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Jonathan Cameron <jic23@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, linux-clk@vger.kernel.org,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Oct 8, 2015 at 5:59 AM, Haibo Chen <haibo.chen@freescale.com> wrote:
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
> index 0000000..6b21fd27
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt
> @@ -0,0 +1,26 @@
> +Freescale imx7d ADC bindings
> +
> +The devicetree bingdings are for the nwe ADC driver written for
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
> +       compatible = "fsl,imx7d-adc";
> +       reg = <0x30610000 0x10000>;
> +       interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> +       clocks = <&clks IMX7D_ADC_ROOT_CLK>;
> +       clock-names = "adc";
> +       num-channels = <4>;
> +       vref-supply = <&reg_vcc_3v3_mcu>;
> +};
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
