Return-Path: <SRS0=Ss5A=H7=onstation.org=masneyb@kernel.org>
Date: Sat, 12 May 2018 08:36:30 -0400
From: Brian Masney <masneyb@onstation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org, lars@metafoo.de,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	pmeerw@pmeerw.net, knaack.h@gmx.de, drew.paterson@ams.com
Subject: Re: [PATCH v3 9/9] staging: iio: tsl2x7x/tsl2772: move out of staging
Message-ID: <20180512123630.f2b7opaob3cb3fom@a2245dbc7726>
References: <20180511001223.12378-1-masneyb@onstation.org>
 <20180511001223.12378-10-masneyb@onstation.org>
 <20180511003206.pgh244sd5t6v4njx@a2245dbc7726>
 <20180512124437.6526c6a0@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180512124437.6526c6a0@archlinux>
List-ID: <linux-iio@vger.kernel.org>

On Sat, May 12, 2018 at 12:44:37PM +0100, Jonathan Cameron wrote:
> On Thu, 10 May 2018 20:32:06 -0400
> Brian Masney <masneyb@onstation.org> wrote:
> 
> > On Thu, May 10, 2018 at 08:12:23PM -0400, Brian Masney wrote:
> > > Move the tsl2772 driver out of staging and into mainline.  
> > 
> > Hey Jonathan,
> > 
> > Here is the .c and .h file to make your review easier. Thanks for all
> > your feedback on all of these changes to this driver plus the other 3
> > that I've already moved out of staging. I've learned a lot going through
> > this process.
> 
> I have the great pleasure to say APPLIED! 
> Congratulations Brian.  This has been the longest and most complex driver
> cleanup I think we have ever had.
> 
> 64? patches 
> 
> 930 (+ 366) insertions, 710(+ 368) deletions (brackets for the driver rename
> which only sort of counts.
> 
> + this is the 4th driver as you say.
> 
> Particularly pleasing is that we no longer have any light sensors in iio staging.
> 
> So what's next?

Great! Thank you!

I have two things that I'm planning to do next:

1) See if the tsl2583 driver can be cleanly folded into tsl2772.

2) I have a Google Nexus 5 phone and I'm going to work towards being
   able to run an upstream kernel on the device. There has already been
   some work on this so looking to join forces:
   https://github.com/flto/linux/wiki/hammerhead-upstream

Brian
