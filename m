Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727462AbeKQEnh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 16 Nov 2018 23:43:37 -0500
Date: Fri, 16 Nov 2018 18:30:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Philippe Schenker <dev@pschenker.ch>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        Max Krummenacher <max.krummenacher@toradex.com>
Subject: Re: [PATCH 2/3] iio: adc: add STMPE ADC devicetree bindings
Message-ID: <20181116183002.33ca0261@archlinux>
In-Reply-To: <6883fa441bfa224f1d56d00a834d14bc9eee1894.camel@pschenker.ch>
References: <20181106164116.6299-1-dev@pschenker.ch>
        <20181106164116.6299-2-dev@pschenker.ch>
        <20181111154207.5ee5bf64@archlinux>
        <6883fa441bfa224f1d56d00a834d14bc9eee1894.camel@pschenker.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 15 Nov 2018 10:38:03 +0100
Philippe Schenker <dev@pschenker.ch> wrote:

> On Sun, 2018-11-11 at 15:42 +0000, Jonathan Cameron wrote:
> > On Tue,  6 Nov 2018 17:41:15 +0100
> > Philippe Schenker <dev@pschenker.ch> wrote:
> >   
> > > From: Stefan Agner <stefan@agner.ch>
> > > 
> > > This adds the devicetree bindings for the STMPE ADC.
> > > 
> > > Signed-off-by: Stefan Agner <stefan@agner.ch>
> > > Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> > > Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> > > ---
> > >  .../devicetree/bindings/iio/adc/stmpe-adc.txt | 34 +++++++++++++++++++
> > >  1 file changed, 34 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt
> > > b/Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt
> > > new file mode 100644
> > > index 000000000000..752ef35a794d
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt
> > > @@ -0,0 +1,34 @@
> > > +STMPE ADC driver
> > > +----------------
> > > +
> > > +Required properties:
> > > + - compatible: "st,stmpe-adc"
> > > +
> > > +Optional properties:
> > > +Note that the ADC is shared with the STMPE touchscreen, so if using both
> > > the
> > > +settings should be the same.  
> > Ah, guessing there is already a binding in place for that which we need to
> > closely
> > match.  Should there be one overarching device with both as children though if
> > it is the same hardware?  
> 
> I moved ADC settings to the mfd...
> 
> >   
> > > +If the settings are not the same, the settings of the driver initialized
> > > last
> > > +will be active.
> > > +- st,sample-time: ADC conversion time in number of clock. (0 -> 36 clocks,
> > > +  1 -> 44 clocks, 2 -> 56 clocks, 3 -> 64 clocks, 4 -> 80 clocks,
> > > +  5 -> 96 clocks, 6 -> 144 clocks), recommended is 4.  
> > Could of questions here.  Is this a hardware dictated limit or is it dependent
> > on
> > application?  Basically I'm asking if it should be in userspace rather than
> > here.
> > 
> > Ideally I'd love to see it in a unit of time, but failing that can we have it
> > in clock cycles please rather than an enum?  Always nice if a binding is
> > human readable.  st,sample-clock-cycles would be a better name.
> >   
> 
> This is none of our design-decision. We did it the same way as it was already in
> drivers/input/touchscreen/stmpe-ts.c.
> 
> >   
> > > +- st,mod-12b: ADC Bit mode (0 -> 10bit ADC, 1 -> 12bit ADC)
> > > +- st,ref-sel: ADC reference source (0 -> internal reference, 1 -> external
> > > +  reference)  
> > 
> > If there is an external reference, I'd expect to see a regulator providing it.
> > Usually the mere presence of such an optional regulator does the job of saying
> > if
> > it should be used.  
> 
> Same here, we did it the same way as it was in stmpe-ts.c
> 
> > 
> >   
> > > +- st,adc-freq: ADC Clock speed (0 -> 1.625 MHz, 1 -> 3.25 MHz, 2 || 3 ->
> > > 6.5 MHz)  
> > So this is some internal clock?  What dictates the right setting?  I.e. how
> > should anyone know which one to pick?  
> 
> I think as a user of this driver at this point you need to read the datasheet
> anyway, to be able to decide which parameters you need for the application.
> 
> >   
> > > +- st,norequest-mask: bitmask specifying which ADC channels should _not_ be
> > > +  requestable due to different usage (e.g. touch)  
> > That's a little bit ugly.  Would prefer to see an explicit set of channels
> > brought out as children in DT.  There are some patches around standardising
> > some properties for doing that under review at the moment.
> > 
> > [PATCH v4 2/4] dt-bindings: iio: adc: Add common ADCs properties to a separate
> > file  
> 
> This is also implemented with the "norequest-mask" in stmpe-ts.c. That's why we
> did it the same way and I don't like to break others devicetree by changing
> stmpe-ts.c
> 
> >   
> > > +
> > > +Node name must be stmpe_adc and should be child node of stmpe node to
> > > +which it belongs.
> > > +
> > > +Example:
> > > +
> > > +	stmpe_adc {  
> > 
> > adc {
> > is the moderately standard naming for ADCS.  
> 
> This is none of our naming decisions please see line 1311 in drivers/mfd/stmpe.c
Fair enough on all these - we are stuck with less than ideal legacy :(

Jonathan

> 
> >   
> > > +		compatible = "st,stmpe-adc";
> > > +		st,sample-time = <4>;
> > > +		st,mod-12b = <1>;
> > > +		st,ref-sel = <0>;
> > > +		st,adc-freq = <1>;
> > > +		st,norequest-mask = <0x0F>; /* dont use ADC CH3-0 */
> > > +	};  
> 
