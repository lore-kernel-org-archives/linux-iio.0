Return-Path: <SRS0=GNR2=2T=aosc.xyz=icenowy@kernel.org>
From: Icenowy Zheng <icenowy@aosc.xyz>
To: Quentin Schulz <quentin.schulz@free-electrons.com>,
	"dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"maxime.ripard@free-electrons.com" <maxime.ripard@free-electrons.com>,
	"wens@csie.org" <wens@csie.org>,
	"lee.jones@linaro.org" <lee.jones@linaro.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"knaack.h@gmx.de" <knaack.h@gmx.de>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"stefan.mavrodiev@gmail.com" <stefan.mavrodiev@gmail.com>
Cc: "thomas.petazzoni@free-electrons.com" <thomas.petazzoni@free-electrons.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-sunxi@googlegroups.com" <linux-sunxi@googlegroups.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
In-Reply-To: <20170310103921.19469-6-quentin.schulz@free-electrons.com>
References: <20170310103921.19469-1-quentin.schulz@free-electrons.com> <20170310103921.19469-6-quentin.schulz@free-electrons.com>
Subject: Re: [PATCH v2 05/11] Documentation: DT: bindings: mfd: add A33 GPADC binding
MIME-Version: 1.0
Message-Id: <5798131489173902@web12o.yandex.ru>
Date: Sat, 11 Mar 2017 03:25:02 +0800
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>



10.03.2017, 18:56, "Quentin Schulz" <quentin.schulz@free-electrons.com>:
> This patch adds documentation for the A33 GPADC binding.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>
> added in v2
>
>  .../devicetree/bindings/mfd/sun4i-gpadc.txt | 59 ++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
>
> diff --git a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> new file mode 100644
> index 0000000..17242c8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> @@ -0,0 +1,59 @@
> +Allwinner SoCs' GPADC Device Tree bindings
> +------------------------------------------
> +The Allwinner SoCs all have an ADC that can also act as a thermal sensor
> +and sometimes as a touchscreen controller.
> +
> +Required properties:
> + - compatible: "sun8i-a33-gpadc-iio",
> + - reg: mmio address range of the chip,
> + - #thermal-sensor-cells: shall be 0,
> + - #io-channel-cells: shall be 0,
> +
> +Example:
> + rtp: rtp@01c25000 {

I think we'd better call it ths.

And can you make thermal-sensor-cells become 1?

Maxime Ripard wants to base H3/H5/A64 thermal driver on this patchset, and
for H5/A64 there's 2/3 thermal sensors.

Thus for A33/H3 we will have thermal-sensor-cells to 1, but only have
<&ths 0>.

> + compatible = "allwinner,sun8i-a33-gpadc-iio";
> + reg = <0x01c25000 0x100>;
> + #thermal-sensor-cells = <0>;
> + #io-channel-cells = <0>;
> + };
> +
> +sun4i, sun5i and sun6i SoCs are also supported via the older binding:
> +
> +sun4i resistive touchscreen controller
> +--------------------------------------
> +
> +Required properties:
> + - compatible: "allwinner,sun4i-a10-ts", "allwinner,sun5i-a13-ts" or
> + "allwinner,sun6i-a31-ts"
> + - reg: mmio address range of the chip
> + - interrupts: interrupt to which the chip is connected
> + - #thermal-sensor-cells: shall be 0
> +
> +Optional properties:
> + - allwinner,ts-attached : boolean indicating that an actual touchscreen
> + is attached to the controller
> + - allwinner,tp-sensitive-adjust : integer (4 bits)
> + adjust sensitivity of pen down detection
> + between 0 (least sensitive) and 15
> + (defaults to 15)
> + - allwinner,filter-type : integer (2 bits)
> + select median and averaging filter
> + samples used for median / averaging filter
> + 0: 4/2
> + 1: 5/3
> + 2: 8/4
> + 3: 16/8
> + (defaults to 1)
> +
> +Example:
> +
> + rtp: rtp@01c25000 {
> + compatible = "allwinner,sun4i-a10-ts";
> + reg = <0x01c25000 0x100>;
> + interrupts = <29>;
> + allwinner,ts-attached;
> + #thermal-sensor-cells = <0>;
> + /* sensitive/noisy touch panel */
> + allwinner,tp-sensitive-adjust = <0>;
> + allwinner,filter-type = <3>;
> + };
> --
> 2.9.3
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
