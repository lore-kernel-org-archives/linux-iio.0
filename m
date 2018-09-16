Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728363AbeIPSYT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Sep 2018 14:24:19 -0400
Date: Sun, 16 Sep 2018 14:01:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Afonso Bordado <afonsobordado@az8.co>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/5] dt-bindings: fxas21002c: Document the fxas21002c
 I2C bindings
Message-ID: <20180916140121.0c88cf03@archlinux>
In-Reply-To: <20180911150011.31964-3-afonsobordado@az8.co>
References: <20180911150011.31964-1-afonsobordado@az8.co>
        <20180911150011.31964-3-afonsobordado@az8.co>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 11 Sep 2018 16:00:09 +0100
Afonso Bordado <afonsobordado@az8.co> wrote:

> Add documentation for the fxas21002c I2C bindings.
> 
> Signed-off-by: Afonso Bordado <afonsobordado@az8.co>
Device tree bindings should go to the devicetree maintainers
and the devicetree binding list. Make sure v5 goes
that way.

This one is just about complex enough I'll want a review from
Rob as he is more likely to catch a problem than I am.

Thanks,

Jonathan
> ---
>  .../bindings/iio/gyroscope/fsl,fxas21002c.txt | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt b/Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt
> new file mode 100644
> index 000000000000..9e5cdf0c0b69
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt
> @@ -0,0 +1,33 @@
> +* Freescale FXAS21002C Digital Angular Rate Gyroscope
> +
> +Required properties:
> +
> +  - compatible: must be "fsl,fxas21002c"
> +  - reg : the I2C address of the sensor
> +
> +Optional properties:
> +
> +  - interrupts		: The first interrupt listed must be the one
> +			  connected to the INT1 pin, the second interrupt
> +			  listed must be the one connected to the INT2 pin.
> +			  The interrupts can be triggered on rising or falling
> +			  edges alike.
> +			  see interrupt-controller/interrupts.txt
> +  - vdd-supply		: The main voltage regulator
> +  - iovdd-supply	: The IO voltage regulator
> +			  see regulator/regulator.txt
> +  - reset-gpios		: GPIO used to reset the device.
> +			  see gpio/gpio.txt.
> +  - mount-matrix	: see iio/mount-matrix.txt
> +
> +Example:
> +gyroscope@20 {
> +	compatible = "fsl,fxas21002c";
> +	reg = <0x20>;
> +	reset-gpios = <&gpio0 2 0>;
> +	vdd-supply = <&vref>;
> +	iovdd-supply = <&vref2>;
> +	interrupt-parent = <&foo>;
> +	interrupts = <0 IRQ_TYPE_EDGE_RISING>,
> +		     <1 (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING)>;
> +};
