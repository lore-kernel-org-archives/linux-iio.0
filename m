Return-Path: <SRS0=ASIl=MI=gmail.com=robherring2@kernel.org>
Date: Wed, 26 Sep 2018 17:46:18 -0500
From: Rob Herring <robh@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Song Qiang <songqiang1304521@gmail.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, mark.rutland@arm.com,
	andriy.shevchenko@linux.intel.com, matt.ranostay@konsulko.com,
	tglx@linutronix.de, ak@it-klinger.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: proximity: vl53l0x: add interrupt support
Message-ID: <20180926224618.GA32126@bogus>
References: <20180918082422.13050-1-songqiang1304521@gmail.com>
 <20180918082422.13050-2-songqiang1304521@gmail.com>
 <20180922160523.16b399fc@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180922160523.16b399fc@archlinux>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Sep 22, 2018 at 04:05:23PM +0100, Jonathan Cameron wrote:
> On Tue, 18 Sep 2018 16:24:22 +0800
> Song Qiang <songqiang1304521@gmail.com> wrote:
> 
> > The first version of this driver issues a measuring request and polling
> > for a status register in the device for measuring completes.
> > vl53l0x support configuring GPIO1 on it to generate interrupt to
> > indicate that new measurement is ready. This patch adds support for
> > using this mechanisim to reduce cpu cost.
> > 
> > Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
> Hi Song.
> 
> Looks correct in principal but a few things to tidy up before
> this is ready to apply.
> 
> Also we have an unrelated change in here to check the devices ID.
> That should be in it's own patch.
> 
> Thanks,
> 
> Jonathan
> > ---
> >  .../bindings/iio/proximity/vl53l0x.txt        |  14 +-

This should have been split with the complete binding in one patch 
rather than piecemeal driver feature by feature.

> >  drivers/iio/proximity/vl53l0x-i2c.c           | 135 +++++++++++++++---
> >  2 files changed, 129 insertions(+), 20 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt b/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> > index ab9a9539fec4..40290f8dd70f 100644
> > --- a/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> > +++ b/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> > @@ -4,9 +4,21 @@ Required properties:
> >  	- compatible: must be "st,vl53l0x-i2c"

Is there more than one interface on this device, such as SPI? If not, 
then '-i2c' should be dropped.

> >  	- reg: i2c address where to find the device
> >  
> > +Optional properties:
> > +	- interrupts : Interrupt line receiving GPIO1's measuring complete
> > +	  output, supports IRQ_TYPE_EDGE_FALLING only.
> > +
> > +	Refer to interrupt-controller/interrupts.txt for generic
> > +	interrupt client node bindings.
> > +
> >  Example:
> >  
> >  vl53l0x@29 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&vl53l0x_pins>;
> > +
> Please drop this from the example.  This is board specific rather than
> being generally required.
> 
> >  	compatible = "st,vl53l0x-i2c";
> >  	reg = <0x29>;
> > -};
> > +	interrupt-parent = <&gpio3>;
> > +	interrupts = <17 IRQ_TYPE_EDGE_FALLING>;
> > +}
