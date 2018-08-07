Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:41869 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbeHGTHt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Aug 2018 15:07:49 -0400
Date: Tue, 7 Aug 2018 10:52:36 -0600
From: Rob Herring <robh@kernel.org>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: adc: add bindings for mcp3911
Message-ID: <20180807165236.GA4765@rob-hp-laptop>
References: <20180802191554.20176-1-marcus.folkesson@gmail.com>
 <20180802191554.20176-2-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180802191554.20176-2-marcus.folkesson@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Aug 02, 2018 at 09:15:53PM +0200, Marcus Folkesson wrote:
> MCP3911 is a dual channel Analog Front End (AFE) containing two
> synchronous sampling delta-sigma Analog-to-Digital Converters (ADC).
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> Signed-off-by: Kent Gustavsson <kent@minoris.se>
> ---
> 
> Notes:
>     v3:
>     	- add bindings for interrupt
>     	- prefix device-addr with `microchip`
>     	- drop `clock-names`
>     v2:
>     	- drop channel width
>     	- drop `external_vref`
>     	- replace `external-clock` with proper clock bindings
> 
>  .../devicetree/bindings/iio/adc/mcp3911.txt        | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/mcp3911.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/mcp3911.txt b/Documentation/devicetree/bindings/iio/adc/mcp3911.txt
> new file mode 100644
> index 000000000000..432da7a28783
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/mcp3911.txt
> @@ -0,0 +1,32 @@
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
> + - clocks: Phandle and clock identifier for sampling clock
> + - interrupt-parent: Phandle to the parent interrupt controller
> +	see: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt

Drop this. It is implied.

With that, 

Reviewed-by: Rob Herring <robh@kernel.org>

> + - interrupts: IRQ line for the ADC
> +	see: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> + - microchip,device-addr: Device address when multiple MCP3911 chips are present on the
> +	same SPI bus. Valid values are 0-3. Defaults to 0.
> + - vref-supply: Phandle to the external reference voltage supply.
> +
> +Example:
> +adc@0 {
> +	compatible = "microchip,mcp3911";
> +	reg = <0>;
> +	interrupt-parent = <&gpio5>;
> +	interrupts = <15 IRQ_TYPE_EDGE_RISING>;
> +	spi-max-frequency = <20000000>;
> +	microchip,device-addr = <0>;
> +	vref-supply = <&vref_reg>;
> +	clocks = <&xtal>;
> +};
> -- 
> 2.11.0.rc2
> 
