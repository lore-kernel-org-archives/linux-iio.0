Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbeKKXSI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Nov 2018 18:18:08 -0500
Date: Sun, 11 Nov 2018 13:29:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Parthiban Nallathambi <pn@denx.de>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        matthias.bgg@gmail.com
Subject: Re: [PATCH v7 2/2] iio: light: Add device tree binding for vishay
 vcnl4035
Message-ID: <20181111132928.218d0811@archlinux>
In-Reply-To: <20181107170821.1171886-2-pn@denx.de>
References: <20181107170821.1171886-1-pn@denx.de>
        <20181107170821.1171886-2-pn@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed,  7 Nov 2018 18:08:21 +0100
Parthiban Nallathambi <pn@denx.de> wrote:

> Adding device tree binding for vcnl4035 and vendor
> prefix for Vishay Intertechnology
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied. Thanks,

Jonathan

> ---
> 
> Notes:
>     Changelog in v4:
>     - commit message fix
>     - same indexing/space in binding
>     
>     Changelog in v3:
>     - removed interrupt-parent property reference in documentation
>     - renamed vcnl4035 to light-sensor
> 
>  .../devicetree/bindings/iio/light/vcnl4035.txt | 18 ++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt    |  1 +
>  2 files changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4035.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/vcnl4035.txt b/Documentation/devicetree/bindings/iio/light/vcnl4035.txt
> new file mode 100644
> index 000000000000..c07c7f052556
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
> +	-interrupts: interrupt mapping for GPIO IRQ (level active low)
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
> index 4b1a2a8fcc16..3c5e0c6f6cee 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -415,6 +415,7 @@ vamrs	Vamrs Ltd.
>  variscite	Variscite Ltd.
>  via	VIA Technologies, Inc.
>  virtio	Virtual I/O Device Specification, developed by the OASIS consortium
> +vishay	Vishay Intertechnology, Inc
>  vitesse	Vitesse Semiconductor Corporation
>  vivante	Vivante Corporation
>  vocore VoCore Studio
