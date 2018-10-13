Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbeJMTw6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 13 Oct 2018 15:52:58 -0400
Date: Sat, 13 Oct 2018 13:15:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Coffey <cmc@babblebit.net>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michael Welling <mwelling@ieee.org>, linux-iio@vger.kernel.org,
        <michael.hennerich@analog.com>, stefan.popa@analog.com,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
        maxime.roussinbelanger@gmail.com, peda@axentia.se
Subject: Re: [PATCH] iio: dac: mcp4922: Add powerdown support
Message-ID: <20181013131558.1ffda128@archlinux>
In-Reply-To: <20181009115707.r5yeq67dhbfjit6f@deb-660>
References: <20181003090638.25111-1-cmc@babblebit.net>
        <20181008210829.41cc106f@archlinux>
        <20181009115707.r5yeq67dhbfjit6f@deb-660>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 9 Oct 2018 12:57:07 +0100
Chris Coffey <cmc@babblebit.net> wrote:

> Hi Jonathan, thank you for the review. I added a few comments below
> based on your feedback.
> 
> - Chris
> 
> On Mon, Oct 08, 2018 at 09:08:29PM +0100, Jonathan Cameron wrote:
> > That's interesting.  I'm not sure we have any consistency of interface
> > around whether a write to the value when powered down results in the device
> > powering up or not.  It certainly feels like we should be consistent on this
> > and document it.
> > 
> > I checked the first random driver I found the ad5360 and it appears to
> > have the powerdown on the front end in some sense in that there is a
> > specific bit to clear in order to power up again and it is not done
> > by changing the current value.
> > 
> > To my mind that is the more logical option, but I'd like others opinions
> > on this.
> >   
> I see what you mean. My intent was to mirror the behavior of userspace
> programs and APIs that I've written and seen for these chips. They take
> advantage of the fact a single command to the chip sets the voltage
> level and power state. That way there is no need to issue a separate
> power-up command, though it's available in sysfs if a user wants it
> (e.g., to toggle the channel's power state without specifying a new
> voltage level).
> 
> Like you, I'd be curious to hear what others have to say. My DAC
> experience is almost exclusively with Microchip devices, so I may be
> suffering from a bit of tunnel vision here.

Agreed. I've added a few additional CCs.  If we don't get any
replies we may want to raise a specific RFC email on this to catch
people's attention.

The cc list is fairly random, so if people wouldn't mind drawing
the attention of others to this question that would be very helpful!

Jonathan


> 
> > It's a little unusual to have an enum specified with just
> > one value.. I can see the advantage in terms of this looking
> > like every other powerdown mode control.
> > 
> > I don't suppose it hurts though.   Seems a little pointless
> > to have this set function actually do anything though...
> > 
> > Also no really point in having the get actually read the value.
> > 
> > So I would just provide a stub for this that returns the
> > same value ever time and nothing at all for the set.
> >   
> Makes sense. I was indeed trying to be consistent with the powerdown
> mode interface in other drivers, but as you note, there's no point in
> actually doing anything in these get/set functions, as the value will
> never change.
> 
