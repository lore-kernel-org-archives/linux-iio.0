Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42849 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751106AbdCYP2X (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Mar 2017 11:28:23 -0400
Subject: Re: [PATCH v3 1/4] Documentation: dt-bindings: iio: Add max9611 ADC
To: Jacopo Mondi <jacopo+renesas@jmondi.org>, geert@linux-m68k.org,
        wsa+renesas@sang-engineering.com, magnus.damm@gmail.com,
        laurent.pinchart@ideasonboard.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com
References: <1490369323-13866-1-git-send-email-jacopo+renesas@jmondi.org>
 <1490369323-13866-2-git-send-email-jacopo+renesas@jmondi.org>
Cc: linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <12426276-4388-c323-7d08-6bc8ee9eebca@kernel.org>
Date: Sat, 25 Mar 2017 15:27:44 +0000
MIME-Version: 1.0
In-Reply-To: <1490369323-13866-2-git-send-email-jacopo+renesas@jmondi.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/03/17 15:28, Jacopo Mondi wrote:
> Add device tree bindings documentation for Maxim max9611/max9612 current
> sense amplifier.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Fine with me, waiting for Mark or Rob to take a look though....
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
I'm fine with this being generic, but it makes this just non trivial enough that
I'll wait for Rob or Mark to have a chance to take a look at the binding.
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
> 

