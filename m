Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37810 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935011AbdCWQqC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Mar 2017 12:46:02 -0400
Received: by mail-wm0-f53.google.com with SMTP id n11so1162846wma.0
        for <linux-iio@vger.kernel.org>; Thu, 23 Mar 2017 09:46:01 -0700 (PDT)
Date: Thu, 23 Mar 2017 16:45:57 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@free-electrons.com,
        wens@csie.org, linux@armlinux.org.uk, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        thomas.petazzoni@free-electrons.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-sunxi@googlegroups.com, icenowy@aosc.xyz
Subject: Re: [PATCH v3 04/11] Documentation: DT: bindings: mfd: add A33 GPADC
 binding
Message-ID: <20170323164557.a7h2eolmxeqfwg6b@dell>
References: <20170321153611.16228-1-quentin.schulz@free-electrons.com>
 <20170321153611.16228-5-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170321153611.16228-5-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 21 Mar 2017, Quentin Schulz wrote:

> This patch adds documentation for the A33 GPADC binding.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
> 
> v3:
>   - fixed missing allwinner in front of compatible,
>   - updated compatible to allwinner,sun8i-a33-ths to better reflect the
>   datasheet's name,
>   - updated example's DT node name and label to ths,
> 
> added in v2
> 
>  .../devicetree/bindings/mfd/sun4i-gpadc.txt        | 59 ++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt

This is going to need a DT Ack.

> diff --git a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> new file mode 100644
> index 0000000..badff36
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> @@ -0,0 +1,59 @@
> +Allwinner SoCs' GPADC Device Tree bindings
> +------------------------------------------
> +The Allwinner SoCs all have an ADC that can also act as a thermal sensor
> +and sometimes as a touchscreen controller.
> +
> +Required properties:
> +  - compatible: "allwinner,sun8i-a33-ths",
> +  - reg: mmio address range of the chip,
> +  - #thermal-sensor-cells: shall be 0,
> +  - #io-channel-cells: shall be 0,
> +
> +Example:
> +	ths: ths@01c25000 {
> +		compatible = "allwinner,sun8i-a33-ths";
> +		reg = <0x01c25000 0x100>;
> +		#thermal-sensor-cells = <0>;
> +		#io-channel-cells = <0>;
> +	};
> +
> +sun4i, sun5i and sun6i SoCs are also supported via the older binding:
> +
> +sun4i resistive touchscreen controller
> +--------------------------------------
> +
> +Required properties:
> + - compatible: "allwinner,sun4i-a10-ts", "allwinner,sun5i-a13-ts" or
> +   "allwinner,sun6i-a31-ts"
> + - reg: mmio address range of the chip
> + - interrupts: interrupt to which the chip is connected
> + - #thermal-sensor-cells: shall be 0
> +
> +Optional properties:
> + - allwinner,ts-attached	 : boolean indicating that an actual touchscreen
> +				   is attached to the controller
> + - allwinner,tp-sensitive-adjust : integer (4 bits)
> +				   adjust sensitivity of pen down detection
> +				   between 0 (least sensitive) and 15
> +				   (defaults to 15)
> + - allwinner,filter-type	 : integer (2 bits)
> +				   select median and averaging filter
> +				   samples used for median / averaging filter
> +				   0: 4/2
> +				   1: 5/3
> +				   2: 8/4
> +				   3: 16/8
> +				   (defaults to 1)
> +
> +Example:
> +
> +	rtp: rtp@01c25000 {
> +		compatible = "allwinner,sun4i-a10-ts";
> +		reg = <0x01c25000 0x100>;
> +		interrupts = <29>;
> +		allwinner,ts-attached;
> +		#thermal-sensor-cells = <0>;
> +		/* sensitive/noisy touch panel */
> +		allwinner,tp-sensitive-adjust = <0>;
> +		allwinner,filter-type = <3>;
> +	};

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
