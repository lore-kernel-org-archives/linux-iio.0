Return-Path: <SRS0=tTUC=5E=gmail.com=robherring2@kernel.org>
Date: Tue, 30 May 2017 16:32:59 -0500
From: Rob Herring <robh@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2] iio: proximity: as3935: noise detection + threshold
 changes
Message-ID: <20170530213259.qbcikyy446g726pk@rob-hp-laptop>
References: <20170525055229.11659-1-matt.ranostay@konsulko.com>
 <20170528165830.3878c05c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170528165830.3878c05c@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sun, May 28, 2017 at 04:58:30PM +0100, Jonathan Cameron wrote:
> On Wed, 24 May 2017 22:52:29 -0700
> Matt Ranostay <matt.ranostay@konsulko.com> wrote:
> 
> > Most applications are too noisy to allow the default noise and
> > watchdog settings, and thus need to be configurable via DT
> > properties.
> > 
> > Also default settings to POR defaults on a reset, and register
> > distuber interrupts as noise since it prevents proper usage.
> > 
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> I wonder if there are many other devices where this sort of
> feature is relevant.  Anyone else come across any?
> 
> I suppose if we need to modify the ABI for any that show up
> in future, it shouldn't be too hard to maintain this one
> for backwards compatibility.
> 
> Anyhow, new devicetree bindings so I'll give Rob / Mark time
> to have a chance to look at it.

I acked v1.

> My immediate thought is that you might be able to do something
> a little more user (i.e. devicetree writer) friendly than
> just using the register value...

We certainly don't want that to be the norm, but sometimes it makes 
sense when it's very specific to a certain device.

> I see there are values, but it depends on whether the device
> is in 'indoor mode' or 'outdoor mode' (which are just gain
> settings?).  You could just use them though.
> 
> Given the gain is userspace controlled, and seems to effect
> the meaning of this setting, is it valid to just put it
> in the devicetree?
