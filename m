Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58002 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754157AbdIYSuo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Sep 2017 14:50:44 -0400
Date: Mon, 25 Sep 2017 19:50:39 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Rob Herring <robh@kernel.org>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2] iio: proximity: as3935: noise detection + threshold
 changes
Message-ID: <20170925195039.4d9258e2@archlinux>
In-Reply-To: <20170603100049.02fa3c76@kernel.org>
References: <20170525055229.11659-1-matt.ranostay@konsulko.com>
        <20170528165830.3878c05c@kernel.org>
        <20170530213259.qbcikyy446g726pk@rob-hp-laptop>
        <20170603100049.02fa3c76@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 3 Jun 2017 10:00:49 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 30 May 2017 16:32:59 -0500
> Rob Herring <robh@kernel.org> wrote:
> 
> > On Sun, May 28, 2017 at 04:58:30PM +0100, Jonathan Cameron wrote:  
> > > On Wed, 24 May 2017 22:52:29 -0700
> > > Matt Ranostay <matt.ranostay@konsulko.com> wrote:
> > >     
> > > > Most applications are too noisy to allow the default noise and
> > > > watchdog settings, and thus need to be configurable via DT
> > > > properties.
> > > > 
> > > > Also default settings to POR defaults on a reset, and register
> > > > distuber interrupts as noise since it prevents proper usage.
> > > > 
> > > > Cc: devicetree@vger.kernel.org
> > > > Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>    
> > > I wonder if there are many other devices where this sort of
> > > feature is relevant.  Anyone else come across any?
> > > 
> > > I suppose if we need to modify the ABI for any that show up
> > > in future, it shouldn't be too hard to maintain this one
> > > for backwards compatibility.
> > > 
> > > Anyhow, new devicetree bindings so I'll give Rob / Mark time
> > > to have a chance to look at it.    
> > 
> > I acked v1.  
> Given there are a couple of precursors working their way towards
> mainline and stable, I'll need to wait for those to filter through.
> 
> Matt give me a bump if it looks like I've forgotten this once
> it will apply!

And indeed I forgot it.  A mess up with my local email labelling means
I'm going through the last few months patches making sure I haven't
missed anything.  So far just this one.

Applied to the togreg branch of iio.git with usual push out as testing etc.

Thanks,

Jonathan
> 
> Thanks,
> 
> Jonathan
> >   
> > > My immediate thought is that you might be able to do something
> > > a little more user (i.e. devicetree writer) friendly than
> > > just using the register value...    
> > 
> > We certainly don't want that to be the norm, but sometimes it makes 
> > sense when it's very specific to a certain device.
> >   
> > > I see there are values, but it depends on whether the device
> > > is in 'indoor mode' or 'outdoor mode' (which are just gain
> > > settings?).  You could just use them though.
> > > 
> > > Given the gain is userspace controlled, and seems to effect
> > > the meaning of this setting, is it valid to just put it
> > > in the devicetree?    
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

