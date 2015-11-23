Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36640 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbbKWPAd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 23 Nov 2015 10:00:33 -0500
Received: by wmww144 with SMTP id w144so99959528wmw.1
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2015 07:00:31 -0800 (PST)
Date: Mon, 23 Nov 2015 14:59:52 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Denis Carikli <denis@eukrea.com>,
	Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v8 1/8] ARM: dt: Binding documentation for imx25 ADC/TSC
Message-ID: <20151123145952.GC31376@x1>
References: <1447675269-8831-1-git-send-email-mpa@pengutronix.de>
 <1447675269-8831-2-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1447675269-8831-2-git-send-email-mpa@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 16 Nov 2015, Markus Pargmann wrote:

> This documentation describes the devicetree bindings for the
> ADC/Touchscreen unit of the i.MX25 SoC.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
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

Prefer "MX25" and "MultiFunction Device (MFD)"

> +This device combines two general purpose conversion queues one used for general
> +ADC and the other used for touchscreens.
> +
> +Required properties:
> + - compatible: Should be "fsl,imx25-tsadc".
> + - reg: Memory range of the device.

Not exactly.  More like start location and size.

> + - interrupts: Interrupt for this device as described in
> +   interrupts/interrupts.txt

No such file.  In any case, I'd prefer:

"(See: ../interrupt-controller/interrupts.txt)".

> + - clocks: An 'ipg' clock defined as described in clocks/clock.txt

Didn't you check any of what you've written?

"(See: ../clock/clock-bindings.txt)"

> + - interrupt-controller: This device is an interrupt controller. It controls
> +   the interrupts of both conversion queues.
> + - #interrupt-cells: Should be '<1>'.
> + - #address-cells: Should be '<1>'.
> + - #size-cells: Should be '<1>'.
> + - ranges

?

Also, don't think think that this looks better/easier to read?

> +Required properties:
> + - compatible:		Should be "fsl,imx25-tsadc".
> + - reg:			Memory range of the device.
> + - interrupts:		Interrupt for this device as described in
> +				interrupts/interrupts.txt
> + - clocks:			An 'ipg' clock defined as described in clocks/clock.txt
> + - interrupt-controller:	This device is an interrupt controller. It controls
> +   				the interrupts of both conversion queues.
> + - #interrupt-cells:		Should be '<1>'.
> + - #address-cells:		Should be '<1>'.
> + - #size-cells:		Should be '<1>'.

[...]

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

I don't think this is required, if you only have a single clock.

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

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
