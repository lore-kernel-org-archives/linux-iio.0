Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33066 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752776AbdDCN0d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Apr 2017 09:26:33 -0400
Date: Mon, 3 Apr 2017 08:26:31 -0500
From: Rob Herring <robh@kernel.org>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: geert@linux-m68k.org, wsa+renesas@sang-engineering.com,
        magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com, linux-iio@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/4] Documentation: dt-bindings: iio: Add max9611 ADC
Message-ID: <20170403132631.nkvkd3lt2aov6qnn@rob-hp-laptop>
References: <1490627578-15938-1-git-send-email-jacopo+renesas@jmondi.org>
 <1490627578-15938-2-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1490627578-15938-2-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Mar 27, 2017 at 05:12:55PM +0200, Jacopo Mondi wrote:
> Add device tree bindings documentation for Maxim max9611/max9612 current
> sense amplifier.

"dt-bindings: iio: adc: ..." for the subject.

> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  .../devicetree/bindings/iio/adc/max9611.txt        | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/max9611.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/max9611.txt b/Documentation/devicetree/bindings/iio/adc/max9611.txt
> new file mode 100644
> index 0000000..8430d3b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/max9611.txt
> @@ -0,0 +1,26 @@
> +* Maxim max9611/max9612 current sense amplifier with 12-bits ADC interface
> +
> +Maxim max9611/max9612 is an high-side current sense amplifier with integrated
> +12-bits ADC communicating over I2c bus.
> +The device node for this driver shall be a child of a I2c controller.
> +
> +Required properties
> +  - compatible: Should be "maxim,max9611" or "maxim,max9612"
> +  - reg: The 7-bits long I2c address of the device
> +  - shunt-resistor-uohm: Value, in uOhm, of the current sense shunt resistor

As Jonathan said.

> +
> +Example:
> +
> +&i2c4 {
> +	csa: adc@7c {
> +		compatible = "maxim,max9611";
> +		reg = <0x7c>;
> +
> +		shunt-resistor-uohm = <5000>;
> +	};
> +};
> +
> +This device node describes a current sense amplifier sitting on I2c4 bus
> +with address 0x7c (read address is 0xf9, write address is 0xf8).
> +A sense resistor of 0,005 Ohm is installed between RS+ and RS- current-sensing
> +inputs.
> -- 
> 2.7.4
> 
