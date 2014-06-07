Return-Path: <pmeerw@pmeerw.net>
Date: Sat, 7 Jun 2014 17:53:59 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
cc: linux-iio@vger.kernel.org, lars@metafoo.de, knaack.h@gmx.de
Subject: Re: [PATCH 00/15] ad799x cleanup
In-Reply-To: <5390CFFE.4080600@kernel.org>
Message-ID: <alpine.DEB.2.01.1406071527001.15204@pmeerw.net>
References: <1401835335-29969-1-git-send-email-pmeerw@pmeerw.net> <5390CFFE.4080600@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

Hello,

> > I ran into some issues with IIO events using the ad799x ADC driver with an
> > ad7997 chip; the following series has cleanups and fixes

> A useful looking set.  Will take a look once Lars is happy with them all
> (I'm lazy).

patches are mostly ack'd; I resend a v2

> Putting my maintainer hat on, I'm trying to work out what if anything in
> here would want to go to stable.
> 
> We are rather two interlinked between clean ups and fixes though I can
> see why you did it like this.  If possible to reorder to have any fixes at
> the top that would be great.
> > 
> > patches 1-6, 8 are cleanup
> > 
> > patch 7 exposes the IIO event interface of the driver only if an IRQ has
> > been configured
> > for the device; no IRQ -> no events
> While unexpected behaviour (and good to fix) I don't think this one is stable
> material.
> > 
> > patch 9 shifts out the last two bits when reading the event value on ad7993
> > and ad7997
> > (which have 10-bit ADCs); same as read_raw()
> This looks like stable material.

the ad799x was recently moved from staging (for 3.16)
we'd need separate patches to fix staging in stable -- not sure if it's 
worth it: those who are using the staging driver in a stable kernel 
probably prefer to keep things as-is (otherwise they'd have sent a patch)
 
> > patch 10 checks the range of the event value on write and shifts the value
> > into place;
> > similar to the previous patch
> this one as well (as Lars suggested, combining these makes sense...)
> > 
> > patch 11 adds helper function to read/write the chip's config register
> > (16-bit on
> > ad7997/ad7998, 8-bit everywhere else)
> You've already stated this is a cleanup rather than a bug fix.
> > 
> > patch 12 actually writes the default config to the chip and keeps a copy of
> > the config register in the driver's state
> Another unexpected behaviour case, I think...
> > 
> > patch 13 changes update_scan_mode() to store the enabled channels in the
> > config
> > register, on ad7992/ad7993/ad7994/ad7997/ad7998, hence the rename
> Ouch - this would be stable material, but is rather more involved with earlier
> patches than ideal...
> > 
> > patch 14 reports only those events as enabled which actually are
> Unexpected behaviour again, though I'd hope any userspace code would cope with
> this.
> In theory any event can result in any other even being enabled, but then
> userspace
> should be able to see what is enabled by reading back the relevant attributes.
> It's clearly a bug fix, but stable material?
> > 
> > patch 15 allows to write the event config, previously events could only be
> > set implicitly via the buffer scan mode
> Clearly still under discussion but sounds like more a case of unusual
> behaviour
> (in need of fixing) than a bug that wants patching in stable?
> 
> Sorry for being a pain on this.  Until fairly recently I'd just have been
> cynical and applied this lot to the togreg branch and ignored the fact
> it would be left broken in earlier versions!  I'm trying to do this better
> hence this email.

I think the rules for -stable are to have a patch in -current and then 
backport; I've put the reading/writing event values (shifting) patch in 
front

patches for 3.14, 3.12, 3.10, 3.4, 3.2 would be extra work (due to moving 
and renaming)

regards, p.

> > Peter Meerwald (15):
> >    staging:iio: Update iio_event_monitor program
> >    staging:iio: Fix iio_utils.h function prototypes
> >    iio:adc:ad799x: Fix ad799x_chip_info kerneldoc
> >    iio:adc:ad799x: Drop I2C access helper functions
> >    iio:adc:ad799x: Save some lines in ad7997_8_update_scan_mode() exit
> >      handling
> >    iio:adc:ad799x: Use BIT() and GENMASK()
> >    iio:adc:ad799x: Only expose event interface when IRQ is available
> >    iio:adc:ad799x: Make chan_spec const in ad799x_chip_config struct
> >    iio:adc:ad799x: Fix reported event values, apply shift
> >    iio:adc:ad799x: Check event value range on write
> >    iio:adc:ad799x: Add helper function to read/write config register
> >    iio:adc:ad799x: Write default config on probe and reset alert status
> >      on probe
> >    iio:adc:ad799x: Rename ad7997_8_update_scan_mode() to
> >      ad799x_update_scan_mode()
> >    iio:adc:ad799x: Return more meaningful event enabled state
> >    iio:adc:ad799x: Allow to write event config
> > 
> >   drivers/iio/adc/ad799x.c                           | 507
> > ++++++++++++---------
> >   .../staging/iio/Documentation/iio_event_monitor.c  |  10 +
> >   drivers/staging/iio/Documentation/iio_utils.h      |   6 +-
> >   3 files changed, 317 insertions(+), 206 deletions(-)
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
