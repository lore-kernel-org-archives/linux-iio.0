Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932226AbdJUTxT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Oct 2017 15:53:19 -0400
Date: Sat, 21 Oct 2017 20:27:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mathias Duckeck <m.duckeck@kunbus.de>,
        Phil Elwell <phil@raspberrypi.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: dac: ti-dac082s085: Document
 new driver
Message-ID: <20171021202738.13eeb611@archlinux>
In-Reply-To: <9825941ccc986a7fc45fd49c8c982f5cb935b079.1508232186.git.lukas@wunner.de>
References: <cover.1508232186.git.lukas@wunner.de>
        <9825941ccc986a7fc45fd49c8c982f5cb935b079.1508232186.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 17 Oct 2017 12:42:00 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> Add device tree bindings for Texas Instruments 8/10/12-bit 2/4-channel
> DAC driver.
> 
> Cc: Mathias Duckeck <m.duckeck@kunbus.de>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan
> ---
>  .../devicetree/bindings/iio/dac/ti-dac082s085.txt  | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/ti-dac082s085.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/ti-dac082s085.txt b/Documentation/devicetree/bindings/iio/dac/ti-dac082s085.txt
> new file mode 100644
> index 000000000000..9cb0e10df704
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/ti-dac082s085.txt
> @@ -0,0 +1,34 @@
> +Texas Instruments 8/10/12-bit 2/4-channel DAC driver
> +
> +Required properties:
> + - compatible:		Must be one of:
> +			"ti,dac082s085"
> +			"ti,dac102s085"
> +			"ti,dac122s085"
> +			"ti,dac084s085"
> +			"ti,dac104s085"
> +			"ti,dac124s085"
> + - reg: 		Chip select number.
> + - spi-cpha, spi-cpol:	SPI mode (0,1) or (1,0) must be used, so specify
> +			either spi-cpha or spi-cpol (but not both).
> + - vref-supply: 	Phandle to the external reference voltage supply.
> +
> +For other required and optional properties of SPI slave nodes please refer to
> +../../spi/spi-bus.txt.
> +
> +Example:
> +	vref_2v5_reg: regulator-vref {
> +		compatible = "regulator-fixed";
> +		regulator-name = "2v5";
> +		regulator-min-microvolt = <2500000>;
> +		regulator-max-microvolt = <2500000>;
> +		regulator-always-on;
> +	};
> +
> +	dac@0 {
> +		compatible = "ti,dac082s085";
> +		reg = <0>;
> +		spi-max-frequency = <40000000>;
> +		spi-cpol;
> +		vref-supply = <&vref_2v5_reg>;
> +	};

