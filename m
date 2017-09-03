Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752206AbdICSY6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Sep 2017 14:24:58 -0400
Date: Sun, 3 Sep 2017 19:24:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        benjamin.gaignard@linaro.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: 104-quad-8: Add IIO generic counter interface
 support
Message-ID: <20170903192453.4bfff4c0@archlinux>
In-Reply-To: <20170903185001.64df919e@archlinux>
References: <cover.1501516678.git.vilhelm.gray@gmail.com>
        <d6aa01425b819fc8c29bf563e11de90e680e0885.1501516678.git.vilhelm.gray@gmail.com>
        <20170820131118.13f99bbd@archlinux>
        <20170828162334.GA17815@sophia>
        <20170903185001.64df919e@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 3 Sep 2017 18:50:01 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 28 Aug 2017 12:23:45 -0400
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> 
> > On Sun, Aug 20, 2017 at 01:11:18PM +0100, Jonathan Cameron wrote:  
> > >On Mon, 31 Jul 2017 12:03:46 -0400
> > >William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> > >    
> > >> This patch adds support for the IIO generic counter interface to the
> > >> 104-QUAD-8 driver. The existing 104-QUAD-8 device interface should not
> > >> be affected by this patch; all changes are intended as supplemental
> > >> additions as perceived by the user.
> > >> 
> > >> IIO Counter Signals are defined for all quadrature input pairs
> > >> (A and B), as well as index input lines. However, IIO Counter Triggers
> > >> are not created for the index input Signals. IIO Counter Values are
> > >> created for the eight quadrature channel counts, and their respective
> > >> Signals are associated via IIO Counter Triggers.
> > >> 
> > >> The new generic counter interface sysfs attributes expose the same
> > >> functionality and data available via the existing 104-QUAD-8 device
> > >> interface. Four IIO Counter Value function modes are available,
> > >> correlating to the four possible quadrature mode configurations:
> > >> "non-quadrature," "quadrature x1," "quadrature x2," and "quadrature x4."
> > >> 
> > >> A quad8_remove function is defined to call iio_counter_unregister. This
> > >> function can be eliminated once a devm_iio_counter_register function is
> > >> defined.
> > >> 
> > >> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>    
> > >
> > >A good example.
> > >
> > >I think it does make it clear that we need to be very careful on how much of
> > >the interface is defined by freeform strings.  Even if we export other means
> > >of establishing the associations to userspace, the moment there are strings
> > >available giving them names, software will start to use those.
> > >
> > >May be fine but we need to be very careful.    
> > 
> > I would like to limit the amount of strings as well; the availability of
> > freeform strings has an unfortunate tendency to create situations where
> > different drivers form separate conventions for duplicate functionality.  
> 
> Absolutely.
> 
> > 
> > The reason freeform strings are available for the generic counter
> > interface is to provide the flexibility to support more complex classes
> > of counters. More specific counter class interfaces such as the future
> > quadrature counter interface will likely expose predefined constants
> > rather than allow drivers to create their own strings. In general
> > though, I believe your warning is a good word of caution and I'll keep
> > an eye on reducing the amount of freeform strings we allow.  
> 
> OK. That could work fine - we enforce the usage by review rather than
> code.
> > 
> > In truth, while this is a good example of how a driver would utilize the
> > generic counter interface with real hardware, it's not a perfect case
> > for quadrature counters in general. As you noticed, the dynamic aspects
> > of the generic counter interface are not needed by the 104-QUAD-8. The
> > future quadrature counter interface would be more fitting for the
> > 104-QUAD-8.
> > 
> > In addition, I may provide a dummy software counter driver in version 2
> > of this patchset to showcase and exemplify the functionality of the
> > generic counter interface more directly and aptly.  
> 
> That could be very useful.  An alternative would be to look at a simple
> device (if we can find one) and implement a userspace fake for it
> (similar to what Guenter has done with lots of hwmon devices).
> 
> That way we can play with a real driver against fake hardware and get
> the best of all possible worlds.  I've been meaning to look at doing this
> for various IIO drivers for a while (most complete for i2c devices I think).
> 
> As you might imagine I don't actually have that many parts (and most of them
> aren't connected to boards at any given time) so any form of emulation can be
> very helpful.
> 
> I'll see if I can dig up any interesting devices beyond the ones we
> already know are integrated in various SoCs.

A quick search turned up a few parts that might do the job as additional
test parts.

lsi ls7366r - spi encoder to count chip. 
www.lsisci.com  - lots of parts made by them...

The broadcom (now - been various people) hctl-2032 - parallel output
but otherwise, does basic counting index etc.

https://www.tindie.com/products/Renbotics/tinyqed/
looks quite cute... Just does it using at little micro to do the hard work.
(long dead as a product by the look of it though..) Easy to emulate perhaps
but none of the links work..

Another thought would be to do a quick fpga version of whatever we
fancy playing with and use that.  I can think of a few people to
ask if this would be useful (could do it myself, but low on time
for the next few months at least).

Jonathan

> 
> I think we really need say 2+ devices to justify decisions in the
> core code. I did the original IIO version against 3ish devices but
> that was more varied (and that wasn't nearly enough with hindsight!)
> 
> Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

