Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58121 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbbCGRcD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 7 Mar 2015 12:32:03 -0500
Message-ID: <54FB3609.1020207@kernel.org>
Date: Sat, 07 Mar 2015 17:31:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Markus Pargmann <mpa@pengutronix.de>,
	Shawn Guo <shawn.guo@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>
CC: Denis Carikli <denis@eukrea.com>,
	=?windows-1252?Q?Eric_B=E9nard?= <eric@eukrea.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v7 1/8] ARM: dt: Binding documentation for imx25 ADC/TSC
References: <1425369498-25541-1-git-send-email-mpa@pengutronix.de> <1425369498-25541-2-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1425369498-25541-2-git-send-email-mpa@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/03/15 07:58, Markus Pargmann wrote:
> This documentation describes the devicetree bindings for the
> ADC/Touchscreen unit of the i.MX25 SoC.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Straight forward and sensible.

Acked-by: Jonathan Cameron <jic23@kernel.org>

> ---
> 
> Notes:
>     Changes in v6:
>      - Removed adc-ref property and replaced it with refp and refn for positive and
>        negative references. The properties are optional now as the default
>        behaviour is a positive internal reference voltage and ADC GND as negative
>        reference.
> 
>  .../devicetree/bindings/mfd/fsl-imx25-tsadc.txt    | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt b/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
> new file mode 100644
> index 000000000000..a857af0eb68c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
> @@ -0,0 +1,46 @@
> +Freescale mx25 ADC/TSC multifunction device
> +
> +This device combines two general purpose conversion queues one used for general
> +ADC and the other used for touchscreens.
> +
> +Required properties:
> + - compatible: Should be "fsl,imx25-tsadc".
> + - reg: Memory range of the device.
> + - interrupts: Interrupt for this device as described in
> +   interrupts/interrupts.txt
> + - clocks: An 'ipg' clock defined as described in clocks/clock.txt
> + - interrupt-controller: This device is an interrupt controller. It controls
> +   the interrupts of both conversion queues.
> + - #interrupt-cells: Should be '<1>'.
> + - #address-cells: Should be '<1>'.
> + - #size-cells: Should be '<1>'.
> + - ranges
> +
> +This device includes two conversion queues which can be added as subnodes.
> +The first queue is for the touchscreen, the second for general purpose ADC.
> +
> +Example:
> +	tscadc: tscadc@50030000 {
> +		compatible = "fsl,imx25-tsadc";
> +		reg = <0x50030000 0xc>;
> +		interrupts = <46>;
> +		clocks = <&clks 119>;
> +		clock-names = "ipg";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		tsc: tcq@50030400 {
> +			compatible = "fsl,imx25-tcq";
> +			reg = <0x50030400 0x60>;
> +			...
> +		};
> +
> +		adc: gcq@50030800 {
> +			compatible = "fsl,imx25-gcq";
> +			reg = <0x50030800 0x60>;
> +			...
> +		};
> +	};
> 

