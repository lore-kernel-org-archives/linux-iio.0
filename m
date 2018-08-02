Return-Path: <SRS0=av6O=KR=huawei.com=jonathan.cameron@kernel.org>
Date: Thu, 2 Aug 2018 13:51:31 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Parthiban Nallathambi <pn@denx.de>
CC: <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
	<pmeerw@pmeerw.net>, <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
	<devicetree@vger.kernel.org>, <matthias.bgg@gmail.com>, <wd@denx.de>,
	<sbabic@denx.de>, <hs@denx.de>
Subject: Re: [PATCH v3 2/2] iio: light: Add device tree binding for vishay
 vcnl4035
Message-ID: <20180802135131.000037cb@huawei.com>
In-Reply-To: <20180802095230.2049554-2-pn@denx.de>
References: <20180629153802.1639514-1-pn@denx.de>
	<20180802095230.2049554-1-pn@denx.de>
	<20180802095230.2049554-2-pn@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-ID: <linux-iio@vger.kernel.org>

On Thu, 2 Aug 2018 11:52:30 +0200
Parthiban Nallathambi <pn@denx.de> wrote:

> Adding device tree binding for vcnl4035 and vendor
> prefix for Vishay Intertechnology
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> -------
Generally don't add your own cut line, just use the one that is already there below.

One minor comment inline.
> 
> Changelog in v3:
> - removed interrupt-parent property reference in documentation
> - renamed vcnl4035 to light-sensor
> ---
>  .../devicetree/bindings/iio/light/vcnl4035.txt         | 18 ++++++++++++++++++
>  Documentation/devicetree/bindings/vendor-prefixes.txt  |  1 +
>  2 files changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4035.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/vcnl4035.txt b/Documentation/devicetree/bindings/iio/light/vcnl4035.txt
> new file mode 100644
> index 000000000000..871f995f7b35
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/vcnl4035.txt
> @@ -0,0 +1,18 @@
> +VISHAY VCNL4035 -  Ambient Light and proximity sensor
> +
> +Link to datasheet: https://www.vishay.com/docs/84251/vcnl4035x01.pdf
> +
> +Required properties:
> +
> +	-compatible: should be "vishay,vcnl4035"
> +	-reg: I2C address of the sensor, should be 0x60

Bit random on the spacing after -.

> +	- interrupts: interrupt mapping for GPIO IRQ (level active low)
> +
> +Example:
> +
> +light-sensor@60 {
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
