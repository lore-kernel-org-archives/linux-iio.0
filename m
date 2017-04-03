Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35875 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752014AbdDCUKA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Apr 2017 16:10:00 -0400
Date: Mon, 3 Apr 2017 13:09:51 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, wens@csie.org,
        linux@armlinux.org.uk, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net,
        thomas.petazzoni@free-electrons.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-sunxi@googlegroups.com, icenowy@aosc.xyz
Subject: Re: [PATCH v3 05/11] Documentation: DT: bindings: input:
 touschcreen: remove sun4i documentation
Message-ID: <20170403200951.GA5613@dtor-ws>
References: <20170321153611.16228-1-quentin.schulz@free-electrons.com>
 <20170321153611.16228-6-quentin.schulz@free-electrons.com>
 <20170329075826.4curjodxgi34tgco@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170329075826.4curjodxgi34tgco@dell>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Mar 29, 2017 at 08:58:26AM +0100, Lee Jones wrote:
> On Tue, 21 Mar 2017, Quentin Schulz wrote:
> 
> > This patch removes the sun4i touchscreen controller binding
> > documentation since it has been merged with the sun4i GPADC binding
> > documentation.
> > 
> > Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> > 
> > added in v2
> > 
> >  .../bindings/input/touchscreen/sun4i.txt           | 38 ----------------------
> 
> Just an Input Ack missing here.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> 
> >  1 file changed, 38 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt b/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
> > deleted file mode 100644
> > index 89abecd..0000000
> > --- a/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
> > +++ /dev/null
> > @@ -1,38 +0,0 @@
> > -sun4i resistive touchscreen controller
> > ---------------------------------------
> > -
> > -Required properties:
> > - - compatible: "allwinner,sun4i-a10-ts", "allwinner,sun5i-a13-ts" or
> > -   "allwinner,sun6i-a31-ts"
> > - - reg: mmio address range of the chip
> > - - interrupts: interrupt to which the chip is connected
> > - - #thermal-sensor-cells: shall be 0
> > -
> > -Optional properties:
> > - - allwinner,ts-attached	 : boolean indicating that an actual touchscreen
> > -				   is attached to the controller
> > - - allwinner,tp-sensitive-adjust : integer (4 bits)
> > -				   adjust sensitivity of pen down detection
> > -				   between 0 (least sensitive) and 15
> > -				   (defaults to 15)
> > - - allwinner,filter-type	 : integer (2 bits)
> > -				   select median and averaging filter
> > -				   samples used for median / averaging filter
> > -				   0: 4/2
> > -				   1: 5/3
> > -				   2: 8/4
> > -				   3: 16/8
> > -				   (defaults to 1)
> > -
> > -Example:
> > -
> > -	rtp: rtp@01c25000 {
> > -		compatible = "allwinner,sun4i-a10-ts";
> > -		reg = <0x01c25000 0x100>;
> > -		interrupts = <29>;
> > -		allwinner,ts-attached;
> > -		#thermal-sensor-cells = <0>;
> > -		/* sensitive/noisy touch panel */
> > -		allwinner,tp-sensitive-adjust = <0>;
> > -		allwinner,filter-type = <3>;
> > -	};
> 
> -- 
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog

-- 
Dmitry
