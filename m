Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752878AbdICNh4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Sep 2017 09:37:56 -0400
Date: Sun, 3 Sep 2017 14:37:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Adriana Reus <adi.reus@gmail.com>
Cc: Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mathias Duckeck <m.duckeck@kunbus.de>,
        Phil Elwell <phil@raspberrypi.org>,
        Oskar Andero <oskar.andero@gmail.com>,
        Andrea Galbusera <gizero@gmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Manfred Schlaegl <manfred.schlaegl@gmx.at>,
        Michael Welling <mwelling@ieee.org>,
        Soeren Andersen <san@rosetechnology.dk>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Abhisit Sangjan <s.abhisit@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH 5/6] dt-bindings: iio: adc: mcp320x: Update for
 mcp3550/1/3
Message-ID: <20170903143429.749be480@archlinux>
In-Reply-To: <CABjU8GvCB61envBiR0ei3gHEPadd5VDZ7FGysDjhCrJcQrEXDg@mail.gmail.com>
References: <cover.1503407738.git.lukas@wunner.de>
        <87644503b0397248c06fbe0058f292955dd10f79.1503407738.git.lukas@wunner.de>
        <20170825195941.iylf4w5hitjwniio@rob-hp-laptop>
        <20170827153405.GA13399@wunner.de>
        <CABjU8GvCB61envBiR0ei3gHEPadd5VDZ7FGysDjhCrJcQrEXDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 29 Aug 2017 10:21:13 +0300
Adriana Reus <adi.reus@gmail.com> wrote:

+cc Mark Brown and linux-spi to address question about how to represent
a hardwired chip select.  See below for why I think that is what we should
be representing rather than the fact it puts it in 'continuous mode'.

> Hi,
> 
> On Sun, Aug 27, 2017 at 6:34 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > On Fri, Aug 25, 2017 at 02:59:41PM -0500, Rob Herring wrote:  
> >> On Tue, Aug 22, 2017 at 03:33:00PM +0200, Lukas Wunner wrote:  
> >> > --- a/Documentation/devicetree/bindings/iio/adc/mcp320x.txt
> >> > +++ b/Documentation/devicetree/bindings/iio/adc/mcp320x.txt
> >> > +Optional properties:
> >> > +   - microchip,continuous-conversion (boolean):
> >> > +                   Only applicable to MCP3550/1/3:  These ADCs have long
> >> > +                   conversion times and therefore support "continuous
> >> > +                   conversion mode" to allow retrieval of conversions
> >> > +                   at any time without observing a delay.  The mode is
> >> > +                   enabled by permanently driving CS low, e.g. by wiring
> >> > +                   it to ground.  

hmm.  This is odd.  We probably need to make the SPI subsystem aware of this.
It is possible to ask for exclusive use of an SPI bus and I think we should
be doing this here.  It may be wired low on your board, but it may be wired to
a controllable chip select on other boards and we can still force it low
to trigger this mode if it makes sense for the current application.
Datasheet says that this mode kicks in whenever we don't raise the cs rather
than it being a one time thing.

So I'd argue what we actually need to represent here is that the CS line
is not controllable.  What this means to the driver should be handled
in the driver - ideally also dealing with the case where it is controllable
appropriately (via exclusive bus usage).  Spi devices have the SPI_NO_CS
bit in the mode member of the spi device but I'm not sure about bindings.

Mark or other SPI people (cc'd) any thoughts on how to handle this cleanly?

> >>
> >> Second binding I have seen today with a continuous property. Make this
> >> common (or maybe we already have one).  
> >
> > The other one was the TI LMP92001 ADC driver posted by Abhisit Sangjan
> > (cc), however looking at the datasheet of that chip reveals that
> > continuous versus one-shot mode is selected by flipping a bit in the
> > chip's register map.
> >
> > So it is configurable at run-time.  It's not something that's hardwired.
> > (Which is the case with the MCP3550 in my patch.)

For the runtime configurable ones, the vast majority of the time this should
not be exposed to userspace at all.  It's a fairly esoteric option and
exactly what it means varies hugely between different boards.  Most of the
time userspace has not idea what to do with it - if 'explicitly'
provided as a control.  It might make sense for a particular application
with tightly coupled userspace and kernelspace, but that's not what we
are targeting in IIO.

So it is up to the driver to make sensible decisions based on what is
going on.  Kind of like auto suspend for runtime pm.  

The one case where we normally want to flip to continuous modes is when
we have a chardev access going on to the device.  In IIO that reflects
the fact we are in a push mode rather than userspace polling for new data.

A lot of hardware supports continuous and one shot capture in this fashion!
Pretty much anything with an internal sequencing clock.

> >
> > My understanding was that run-time configurable options should not be
> > listed in the device-tree at all, only hardware features.  If that is
> > correct then that device-tree property should be dropped from Abhisit
> > Sangjan's patch.  Configuring the feature via sysfs is fine I guess.
> >
> > However we do have another driver supporting continuous versus one-shot
> > mode and that is drivers/iio/light/us5182d.c by Adriana Reus (cc).
> > The feature was added with commit c3304c212326.  I'm not sure if it's
> > hardwired or runtime-configurable, the datasheet is gone from the
> > manufacturer's website.  
> For the us5182 continuous versus one-shot is also a configuration in the
> chip's registers. I think it would be fine also as a sysfs property instead.
> >
> > I agree that a common "continuous" property makes sense.  We haven't
> > defined any common IIO properties so far and that has already led to
> > inconsistencies.  E.g. most ADC/DAC drivers name the reference regulator
> > "vref-supply", but e.g. drivers/iio/dac/ad7303.c calls it "REF-supply".
> >
> > What do you think of this:

Personally I don't think we are in a position yet to make this a generic
property - this is the first device where it is actually to do with the
physical circuit (and arguably it isn't really - see above).

It might become common, but I actually think it unlikely. It's odd
to have a device that sits in the sweet spot between being dumb enough to
not make it software configurable and clever enough to implement this
stuff at all.

Reference voltages are an oddity as the supply naming typically should match
that on the datasheet. It's 'fairly' consistent but some devices
have a set of relatively obscure references to different parts of the
input circuitry.  We can document it as a 'default' assuming nothing
strange is going on though.  This is why we have the vagueness below
on VDD and VCC.


> >  
> > -- >8 --  
> > Subject: [PATCH] dt-bindings: iio: Document common properties
> >
> > It's about time we standardize on common names for frequently used IIO
> > properties.  For starters, document "vref-supply" and "continuous".
> >
> > Suggested-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > ---
> >  Documentation/devicetree/bindings/iio/iio-bindings.txt | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/iio-bindings.txt b/Documentation/devicetree/bindings/iio/iio-bindings.txt
> > index 68d6f8c..c3e87e15 100644
> > --- a/Documentation/devicetree/bindings/iio/iio-bindings.txt
> > +++ b/Documentation/devicetree/bindings/iio/iio-bindings.txt
> > @@ -95,3 +95,18 @@ vdd channel is connected to output 0 of the &ref device.
> >                 io-channels = <&adc 10>, <&adc 11>;
> >                 io-channel-names = "adc1", "adc2";
> >         };
> > +
> > +==Common IIO properties==
> > +
> > +Reference voltage:
> > +ADCs, DACs and several other IIO devices require a reference voltage.
> > +By convention the property specifying this regulator is named "vref-supply".
> > +If the chip lacks a dedicated Vref pin and instead uses its own power supply
> > +as reference, the property specifying the regulator is commonly named
> > +"vdd-supply" or "vcc-supply".
> > +
> > +Continuous mode:
> > +Some sensors can be configured to perform continuous (versus one-shot)
> > +measurements.  Continuous mode may require more energy in return for faster
> > +or more reliable measurements.  A boolean property named "continuous"
> > +signifies that the device is configured for this mode.
> > --
> > 2.11.0  

