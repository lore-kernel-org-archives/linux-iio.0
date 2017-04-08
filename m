Return-Path: <SRS0=CTjH=3Q=jmondi.org=jacopo@kernel.org>
Date: Sat, 8 Apr 2017 18:45:03 +0200
From: jmondi <jacopo@jmondi.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Jacopo Mondi <jacopo+renesas@jmondi.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 1/4] Documentation: dt-bindings: iio: Add max9611 ADC
Message-ID: <20170408164503.GB9459@w540>
References: <1491488454-22468-1-git-send-email-jacopo+renesas@jmondi.org>
 <1491488454-22468-2-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdUNWJ2C9b9Xzod5HRU_ZG3mVamN6a-ZdOywODJqv6TxQw@mail.gmail.com>
 <e7a53314-2e57-ae3a-af53-0d22ab445f5a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <e7a53314-2e57-ae3a-af53-0d22ab445f5a@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

On Sat, Apr 08, 2017 at 04:59:39PM +0100, Jonathan Cameron wrote:
> On 06/04/17 15:43, Geert Uytterhoeven wrote:
>
> > On Thu, Apr 6, 2017 at 4:20 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/iio/adc/max9611.txt
> >> @@ -0,0 +1,27 @@
> >> +* Maxim max9611/max9612 current sense amplifier with 12-bits ADC interface
> >> +
> >> +Maxim max9611/max9612 is an high-side current sense amplifier with integrated
> >> +12-bits ADC communicating over I2c bus.
> >> +The device node for this driver shall be a child of a I2c controller.
> >> +
> >> +Required properties
> >> +  - compatible: Should be "maxim,max9611" or "maxim,max9612"
> >> +  - reg: The 7-bits long I2c address of the device
> >> +  - shunt-resistor-micro-homs: Value, in micro Ohms, of the current sense shunt
> >
> > s/homs/ohms/
> I'll fix the title as Rob requested and this.
>

Uh! I missed that title thing! Sorry about this, and thank you
Jonathan for doing that!

> Applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to play with it.
>
> Thanks for your hard work on this one!
>

Thank you all for your effort in reviewing this

Thanks
   j

> Jonathan
> >
> >> +                               resistor
> >
> > Gr{oetje,eeting}s,
> >
> >                         Geert
> >
> > --
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> >
> > In personal conversations with technical people, I call myself a hacker. But
> > when I'm talking to journalists I just say "programmer" or something like that.
> >                                 -- Linus Torvalds
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
>
