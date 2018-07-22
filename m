Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727764AbeGVJHG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Jul 2018 05:07:06 -0400
Date: Sun, 22 Jul 2018 09:11:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Kent Gustavsson <kent@minoris.se>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: iio: adc: add bindings for mcp3911
Message-ID: <20180722091111.6c55602f@archlinux>
In-Reply-To: <20180721195923.7610-2-marcus.folkesson@gmail.com>
References: <20180721195923.7610-1-marcus.folkesson@gmail.com>
        <20180721195923.7610-2-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 21 Jul 2018 21:59:22 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> MCP3911 is a dual channel Analog Front End (AFE) containing two
> synchronous sampling delta-sigma Analog-to-Digital Converters (ADC).
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> Signed-off-by: Kent Gustavsson <kent@minoris.se>
> ---
>  .../devicetree/bindings/iio/adc/mcp3911.txt        | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/mcp3911.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/mcp3911.txt b/Documentation/devicetree/bindings/iio/adc/mcp3911.txt
> new file mode 100644
> index 000000000000..e233ee94ad96
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/mcp3911.txt
> @@ -0,0 +1,33 @@
> +* Microchip MCP3911 Dual channel analog front end (ADC)
> +
> +Required properties:
> + - compatible: Should be "microchip,mcp3911"
> + - reg: SPI chip select number for the device
> +
> +Recommended properties:
> + - spi-max-frequency: Definition as per
> +	 Documentation/devicetree/bindings/spi/spi-bus.txt.
> +	 Max frequency for this chip is 20MHz.
> +
> +Optional properties:
> + - device-addr: Device address when multiple MCP3911 chips are present on the
> +	same SPI bus. Valid values are 0-3. Defaults to 0.
> + - external-clock: Use external clock instead of crystal oscillator.
As mentioned, in the code, can we use the standard fixed clock bindings here.
We don't actually care what the value is, but it might be nice to be able to
power down the clock if we are suspending or something..

> + - external-vref: Use external voltage reference
> + - vref-supply:	Phandle to the external reference voltage supply. (only valid in combination with `external-vref`)

Just use the optional regulator stuff and get rid of the bool.

> + - ch0-width: width for channel0. Valid widths are 16 and 24bits.
> + - ch1-width: width for channel1. Valid widths are 16 and 24bits.

As I asked in the code, are these a function of the wiring etc or are
they something we should really be leaving up to userspace (with a sensible
default).

> +
> +
> +Example:
> +adc@0 {
> +	compatible = "microchip,mcp3911";
> +	reg = <0>;
> +	spi-max-frequency = <20000000>;
> +	device-addr = <0>;
> +	ch0-width = <16>;
> +	ch1-width = <24>;
> +	external-clock;
> +	external-vref;
> +	vref-supply = <&vref_reg>;
> +};

