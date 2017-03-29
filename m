Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:35397 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754075AbdC2H6b (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Mar 2017 03:58:31 -0400
Received: by mail-wr0-f169.google.com with SMTP id u1so5060134wra.2
        for <linux-iio@vger.kernel.org>; Wed, 29 Mar 2017 00:58:29 -0700 (PDT)
Date: Wed, 29 Mar 2017 08:58:26 +0100
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
Subject: Re: [PATCH v3 05/11] Documentation: DT: bindings: input:
 touschcreen: remove sun4i documentation
Message-ID: <20170329075826.4curjodxgi34tgco@dell>
References: <20170321153611.16228-1-quentin.schulz@free-electrons.com>
 <20170321153611.16228-6-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170321153611.16228-6-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 21 Mar 2017, Quentin Schulz wrote:

> This patch removes the sun4i touchscreen controller binding
> documentation since it has been merged with the sun4i GPADC binding
> documentation.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> 
> added in v2
> 
>  .../bindings/input/touchscreen/sun4i.txt           | 38 ----------------------

Just an Input Ack missing here.

>  1 file changed, 38 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt b/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
> deleted file mode 100644
> index 89abecd..0000000
> --- a/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
> +++ /dev/null
> @@ -1,38 +0,0 @@
> -sun4i resistive touchscreen controller
> ---------------------------------------
> -
> -Required properties:
> - - compatible: "allwinner,sun4i-a10-ts", "allwinner,sun5i-a13-ts" or
> -   "allwinner,sun6i-a31-ts"
> - - reg: mmio address range of the chip
> - - interrupts: interrupt to which the chip is connected
> - - #thermal-sensor-cells: shall be 0
> -
> -Optional properties:
> - - allwinner,ts-attached	 : boolean indicating that an actual touchscreen
> -				   is attached to the controller
> - - allwinner,tp-sensitive-adjust : integer (4 bits)
> -				   adjust sensitivity of pen down detection
> -				   between 0 (least sensitive) and 15
> -				   (defaults to 15)
> - - allwinner,filter-type	 : integer (2 bits)
> -				   select median and averaging filter
> -				   samples used for median / averaging filter
> -				   0: 4/2
> -				   1: 5/3
> -				   2: 8/4
> -				   3: 16/8
> -				   (defaults to 1)
> -
> -Example:
> -
> -	rtp: rtp@01c25000 {
> -		compatible = "allwinner,sun4i-a10-ts";
> -		reg = <0x01c25000 0x100>;
> -		interrupts = <29>;
> -		allwinner,ts-attached;
> -		#thermal-sensor-cells = <0>;
> -		/* sensitive/noisy touch panel */
> -		allwinner,tp-sensitive-adjust = <0>;
> -		allwinner,filter-type = <3>;
> -	};

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
