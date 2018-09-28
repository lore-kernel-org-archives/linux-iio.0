Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39485 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbeI1P7l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Sep 2018 11:59:41 -0400
Date: Fri, 28 Sep 2018 17:36:18 +0800
From: Song Qiang <songqiang1304521@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mark.rutland@arm.com,
        andriy.shevchenko@linux.intel.com, matt.ranostay@konsulko.com,
        tglx@linutronix.de, ak@it-klinger.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: proximity: vl53l0x: add interrupt support
Message-ID: <20180928093618.GA24536@Eros>
References: <20180918082422.13050-1-songqiang1304521@gmail.com>
 <20180918082422.13050-2-songqiang1304521@gmail.com>
 <20180922160523.16b399fc@archlinux>
 <20180926224618.GA32126@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180926224618.GA32126@bogus>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Sep 26, 2018 at 05:46:18PM -0500, Rob Herring wrote:
> On Sat, Sep 22, 2018 at 04:05:23PM +0100, Jonathan Cameron wrote:
> > On Tue, 18 Sep 2018 16:24:22 +0800
> > Song Qiang <songqiang1304521@gmail.com> wrote:
> > 
> > > The first version of this driver issues a measuring request and polling
> > > for a status register in the device for measuring completes.
> > > vl53l0x support configuring GPIO1 on it to generate interrupt to
> > > indicate that new measurement is ready. This patch adds support for
> > > using this mechanisim to reduce cpu cost.
> > > 
> > > Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
> > Hi Song.
> > 
> > Looks correct in principal but a few things to tidy up before
> > this is ready to apply.
> > 
> > Also we have an unrelated change in here to check the devices ID.
> > That should be in it's own patch.
> > 
> > Thanks,
> > 
> > Jonathan
> > > ---
> > >  .../bindings/iio/proximity/vl53l0x.txt        |  14 +-
> 
> This should have been split with the complete binding in one patch 
> rather than piecemeal driver feature by feature.
> 

Hi Rob,

A few days ago when I was submitting this driver, I didn't do it very
well, the function of this driver is limited. I added interrupt support 
the next day after you acked my first patch. I thought it's not polite 
to add something after someone acked that patch, so I send the interrupt
support as a second patch. The first patch is merged to togreg now, but
this doesn't. I don't know when can I add new functions to the code that
just merged to togreg branch, could you offer some suggestions?

> > >  drivers/iio/proximity/vl53l0x-i2c.c           | 135 +++++++++++++++---
> > >  2 files changed, 129 insertions(+), 20 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt b/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> > > index ab9a9539fec4..40290f8dd70f 100644
> > > --- a/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> > > +++ b/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> > > @@ -4,9 +4,21 @@ Required properties:
> > >  	- compatible: must be "st,vl53l0x-i2c"
> 
> Is there more than one interface on this device, such as SPI? If not, 
> then '-i2c' should be dropped.
> 

Yes, there is a CCI(Camera Control Interface) for communication.

> > >  	- reg: i2c address where to find the device
> > >  
> > > +Optional properties:
> > > +	- interrupts : Interrupt line receiving GPIO1's measuring complete
> > > +	  output, supports IRQ_TYPE_EDGE_FALLING only.
> > > +
> > > +	Refer to interrupt-controller/interrupts.txt for generic
> > > +	interrupt client node bindings.
> > > +
> > >  Example:
> > >  
> > >  vl53l0x@29 {
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&vl53l0x_pins>;
> > > +
> > Please drop this from the example.  This is board specific rather than
> > being generally required.
> > 

Sure.

yours,
Song Qiang
> > >  	compatible = "st,vl53l0x-i2c";
> > >  	reg = <0x29>;
> > > -};
> > > +	interrupt-parent = <&gpio3>;
> > > +	interrupts = <17 IRQ_TYPE_EDGE_FALLING>;
> > > +}
