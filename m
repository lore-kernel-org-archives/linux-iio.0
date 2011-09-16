Return-Path: <manuel.stahl9cd33xy531iis.fraunhofer.de@bounce.antispameurope.com>
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
To: Jonathan Cameron <jic23@cam.ac.uk>,
 Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: Does anyone read device.txt etc?
Date: Fri, 16 Sep 2011 11:29:08 +0200
Cc: Jonathan Kunkee <jonathan.kunkee@gmail.com>,
 linux-iio@vger.kernel.org,
 Jon Brenner <jbrenner@taosinc.com>
References: <4E71DD44.7030407@cam.ac.uk> <CAGRJchisN3z8kNpKy39LsoqXhMOh-Z4_dEyHJK-42+WeaW=bEw@mail.gmail.com> <4E730A62.1050203@cam.ac.uk>
In-Reply-To: <4E730A62.1050203@cam.ac.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201109161129.09304.manuel.stahl@iis.fraunhofer.de>
List-ID: <linux-iio@vger.kernel.org>

Hi all,

Am Freitag, 16. September 2011, 10:35:46 schrieb Jonathan Cameron:
> On 09/16/11 05:52, Jonathan Kunkee wrote:
> > Hi Jonathan,
> > 
> >> I'm just wondering if some corners of our documentation are useful or
> >> not.
> >> 
> >> So straw poll.  Has anyone ever read the stuff in
> >> 
> >> device.txt?
> >> trigger.txt?
> >> ring.txt?
> > 
> > Yes. When I was first looking at changing my HMC6343 driver over to the
> > IIO subsystem I read everything in drivers/staging/iio/Documentation. It
> > wasn't all that helpful--partly because I'm new to kernel development,
> > and partly because it wasn't specific enough. (This was a few months
> > ago.)

I take these docs as a reference to see "how it was thought to be", when 
drivers implementations disagree on some point. But sure a reference driver 
would be even better.

> Hehe, I think that counts as a negative on current docs but a positive that
> we should have something that actually does the job better!
> 
> >> I'm tempted to drop all 3 of these as pointless maintenance
> >> overhead...
> > 
> > I can certainly understand this!
> > 
> >> A well commented dummy driver would be better for explaining these
> >> things.
> > 
> > Agreed, especially with these three docs. The information presented is
> > fairly fundamental to writing a good IIO driver, but would be much more
> > useful inline with the reference implementation of each part.
> 
> Guess we need a 'stub' driver or perhaps two of them, one a basic sysfs
> only version (so really short) and the other with all the bells and
> whistles.
> 
> Manuel, you proposed something that would be a bit like the all bells and
> whistles a while ago. Is there any code to see yet?  Seems a shame to
> duplicate effort if you have had a chance to work on this!

Actually Michael and I agreed that he will start with such an implementation. 
If there's nothing to go with yet, I can do that too, of course.

> 
> > I also agree with Michael that the documentation should be a good
> > jumping-off point. In particular, I was looking to answer two questions:
> > 1) Why would I use this subsystem? (general feature descriptions,
> > 
> >   example applications, comparison to other subsystems)
> 
> Ah, would you be willing to look at the intro email I wrote to the proposal
> to start moving out of staging?  It is meant to be covering exactly those
> sort of issues, but I may well have missed stuff given I'm reasonably
> familiar with all the relevant subsystems! It was in the thread
> [RFC PATCH 0/4] IIO: Out of staging step 1. The core.
> or I can repost if that helps.
> 
> Would love to get some feedback on that from everyone.
> 
> > 2) How is this subsystem organized/used? (constants, masking,
> > relationship
> > 
> >   with other subsystems like i2c)
> 
> The relationship with bus subsystems is something that wouldn't have
> occurred to me for starters!  Thanks.
> 
> > Part of the difficulty I had was in attempting to grok a staging feature
> > as if it were mature and static (ring.txt in particular confused me), so
> > this is, of course, just my 2c.
> > 
> > Thanks for all the work you're putting in to IIO! I hope this helps.
> 
> I certainly does.  Thanks for taking the time!
> 
> Jonathan


-- 
Regards,
Manuel Stahl
