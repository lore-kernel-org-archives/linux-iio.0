Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35305 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbeJAKeH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Oct 2018 06:34:07 -0400
Date: Mon, 1 Oct 2018 11:58:14 +0800
From: Song Qiang <songqiang1304521@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: proximity: vl53l0x: add interrupt support
Message-ID: <20181001035739.GA17143@Eros>
References: <20180918082422.13050-1-songqiang1304521@gmail.com>
 <20180918082422.13050-2-songqiang1304521@gmail.com>
 <20180922160523.16b399fc@archlinux>
 <20180926224618.GA32126@bogus>
 <20180928093618.GA24536@Eros>
 <CAL_JsqLpNiGdK9hWTGWZwgbgRr8DNF=XvKGUx=oS2jTJ61yhFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAL_JsqLpNiGdK9hWTGWZwgbgRr8DNF=XvKGUx=oS2jTJ61yhFg@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Sep 28, 2018 at 06:52:13PM -0500, Rob Herring wrote:
> On Fri, Sep 28, 2018 at 4:36 AM Song Qiang <songqiang1304521@gmail.com> wrote:
> >
> > On Wed, Sep 26, 2018 at 05:46:18PM -0500, Rob Herring wrote:
> > > On Sat, Sep 22, 2018 at 04:05:23PM +0100, Jonathan Cameron wrote:
> > > > On Tue, 18 Sep 2018 16:24:22 +0800
> > > > Song Qiang <songqiang1304521@gmail.com> wrote:
> > > >
> > > > > The first version of this driver issues a measuring request and polling
> > > > > for a status register in the device for measuring completes.
> > > > > vl53l0x support configuring GPIO1 on it to generate interrupt to
> > > > > indicate that new measurement is ready. This patch adds support for
> > > > > using this mechanisim to reduce cpu cost.
> > > > >
> > > > > Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
> > > > Hi Song.
> > > >
> > > > Looks correct in principal but a few things to tidy up before
> > > > this is ready to apply.
> > > >
> > > > Also we have an unrelated change in here to check the devices ID.
> > > > That should be in it's own patch.
> > > >
> > > > Thanks,
> > > >
> > > > Jonathan
> > > > > ---
> > > > >  .../bindings/iio/proximity/vl53l0x.txt        |  14 +-
> > >
> > > This should have been split with the complete binding in one patch
> > > rather than piecemeal driver feature by feature.
> > >
> >
> > Hi Rob,
> >
> > A few days ago when I was submitting this driver, I didn't do it very
> > well, the function of this driver is limited. I added interrupt support
> > the next day after you acked my first patch. I thought it's not polite
> > to add something after someone acked that patch, so I send the interrupt
> > support as a second patch. The first patch is merged to togreg now, but
> > this doesn't. I don't know when can I add new functions to the code that
> > just merged to togreg branch, could you offer some suggestions?
> 
> You just needed to state why you didn't add a ack. But really, just
> don't send things except as RFC until they are "done".
> 
> What to do next depends on Jonathan and whether he wants a follow-up
> patch or he will drop the first one.
> 
> > > > >  drivers/iio/proximity/vl53l0x-i2c.c           | 135 +++++++++++++++---
> > > > >  2 files changed, 129 insertions(+), 20 deletions(-)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt b/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> > > > > index ab9a9539fec4..40290f8dd70f 100644
> > > > > --- a/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> > > > > +++ b/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> > > > > @@ -4,9 +4,21 @@ Required properties:
> > > > >   - compatible: must be "st,vl53l0x-i2c"
> > >
> > > Is there more than one interface on this device, such as SPI? If not,
> > > then '-i2c' should be dropped.
> > >
> >
> > Yes, there is a CCI(Camera Control Interface) for communication.
> 
> Isn't CCI just a subset of I2C? I should clarify my question is
> whether there's more than 1 mutually exclusive control interface (as
> many devices have control and data interfaces) where you could have 2
> different drivers. A common example are devices with I2C and SPI
> interfaces.
> 
> Rob

Hi Rob, Jonathan,

I don't know things about CCI very well, and google also tells me little
about it. Actually, I found it difficult to find a standard definition
about it. Then I dug into vl53l0x's API source code, and what I can
tell is when we use these two interfaces, the whole programming
framework is different, even though the pysical bus of them are likely
to be the same. 
Source code of CCI uses a 'msm_camera_i2c_fn_t' struct and a
'v4l2_file_operations' as hardware interfaces for controlling device,
while the i2c one just uses generic i2c bus interfaces.

This explanation is for why the file name still contains '-i2c'.

yours,
Song Qiang
