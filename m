Return-Path: <SRS0=NnCZ=JW=gmail.com=robherring2@kernel.org>
Date: Fri, 6 Jul 2018 14:34:39 -0600
From: Rob Herring <robh@kernel.org>
To: Parthiban Nallathambi <pn@denx.de>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	mark.rutland@arm.com, devicetree@vger.kernel.org,
	matthias.bgg@gmail.com, wd@denx.de, sbabic@denx.de, hs@denx.de
Subject: Re: [PATCH v2 2/2] iio: light: Add device tree binding for vishay
 vcnl4035
Message-ID: <20180706203439.GA30529@rob-hp-laptop>
References: <20180628123021.1628338-1-pn@denx.de>
 <20180629153802.1639514-1-pn@denx.de>
 <20180629153802.1639514-2-pn@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180629153802.1639514-2-pn@denx.de>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jun 29, 2018 at 05:38:02PM +0200, Parthiban Nallathambi wrote:
> Adding device tree binding for vcnl4035 and vendor
> prefix for Vishay Intertechnology
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> ---
>  .../devicetree/bindings/iio/light/vcnl4035.txt        | 19 +++++++++++++++++++
>  Documentation/devicetree/bindings/vendor-prefixes.txt |  1 +
>  2 files changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4035.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/vcnl4035.txt b/Documentation/devicetree/bindings/iio/light/vcnl4035.txt
> new file mode 100644
> index 000000000000..7ffdc0246300
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/vcnl4035.txt
> @@ -0,0 +1,19 @@
> +VISHAY VCNL4035 -  Ambient Light and proximity sensor
> +
> +Link to datasheet: https://www.vishay.com/docs/84251/vcnl4035x01.pdf
> +
> +Required properties:
> +
> +	-compatible: should be "vishay,vcnl4035"
> +	-reg: I2C address of the sensor, should be 0x60
> +	- interrupt-parent: should be the phandle for the interrupt controller

Don't need to document this as it could be in a parent node.

> +	- interrupts: interrupt mapping for GPIO IRQ (level active low)
> +
> +Example:
> +
> +vcnl4035@60 {

light-sensor@60

> +	compatible = "vishay,vcnl4035";
> +	reg = <0x60>;
> +	interrupt-parent = <&gpio4>;
> +	interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> +};
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 7cad066191ee..3cc46d5735a9 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -395,6 +395,7 @@ v3	V3 Semiconductor
>  variscite	Variscite Ltd.
>  via	VIA Technologies, Inc.
>  virtio	Virtual I/O Device Specification, developed by the OASIS consortium
> +vishay	Vishay Intertechnology, Inc
>  vivante	Vivante Corporation
>  vocore VoCore Studio
>  voipac	Voipac Technologies s.r.o.
> -- 
> 2.14.4
> 
