Return-Path: <knaack.h@gmx.de>
Message-ID: <53C05DD8.9050500@gmx.de>
Date: Fri, 11 Jul 2014 23:57:44 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>,
 Jonathan Cameron <jic23@kernel.org>
CC: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>,
 Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>, =?UTF-8?B?ImVkZGllKOiUoeaeqyki?=
 <cf@rock-chips.com>, huangtao@rock-chips.com
Subject: Re: [PATCH 2/2] dt-bindings: document Rockchip saradc
References: <2959154.xc8BQActsn@diego> <3591595.sBj6Zqo42A@diego>
In-Reply-To: <3591595.sBj6Zqo42A@diego>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Heiko Stübner schrieb:
> This add the necessary binding documentation for the saradc found in all recent
> processors from Rockchip.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
Spotted some typos, see inline.
>  .../bindings/iio/adc/rockchip-saradc.txt           | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
> new file mode 100644
> index 0000000..603ac9c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
> @@ -0,0 +1,28 @@
> +Rockhip Successive Approximation Register (SAR) A/D Converter bindings
Should be "Rockchip".
> +
> +Required properties:
> +- compatible: Should be "rockchip,saradc"
> +- reg: physical base address of the controller and length of memory mapped
> +       region.
> +- interrupts: The interrupt number to the cpu. The interrupt specifier format
> +              depends on the interrupt controller.
> +- clocks: Must contain an entry for each entry in clock-names.
> +- clock-names: Shall be "saradc" for the converter-clock, and "apb_pclk" for
> +               the peripheral clock.
> +- vref-supply: The regulator supply ADC refrence voltage.
... reference voltage.
> +- #io-channel-cells: Should be 1, see ../iio-bindings.txt
> +
> +Optional properties :
> +- clock-frequency : converter frequency in Hz. If omitted, 1MHz is used.
> +
> +Example:
> +	saradc: saradc@2006c000 {
> +		compatible = "rockchip,saradc";
> +		reg = <0x2006c000 0x100>;
> +		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
> +		clock-names = "saradc", "apb_pclk";
> +		#io-channel-cells = <1>;
> +		vref-supply = <&vcc18>;
> +		clock-frequency = <1000000>;
> +	};
