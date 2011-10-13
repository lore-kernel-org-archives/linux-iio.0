Return-Path: <broonie@opensource.wolfsonmicro.com>
Date: Thu, 13 Oct 2011 15:38:58 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-iio@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Zoltan Devai <zdevai@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 4/9] ARM: SPMP8000: Add ADC driver
Message-ID: <20111013143857.GH5193@opensource.wolfsonmicro.com>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
 <1318178172-7965-5-git-send-email-zoss@devai.org>
 <CAKnu2MrAEbS-36YaU+i6+zhwH4KW7ST7-mkKT49tv7jhhSo2UQ@mail.gmail.com>
 <4E92BE19.4060907@cam.ac.uk>
 <20111010100020.GA3607@opensource.wolfsonmicro.com>
 <CAGVye5Nc9vhaF=7Y+hvGo4g-GOFb9fHeni+g=+hTj-8WCSqY+Q@mail.gmail.com>
 <20111010114407.GD3607@opensource.wolfsonmicro.com>
 <20111013094717.GL21648@n2100.arm.linux.org.uk>
 <20111013113506.GJ1098@sirena.org.uk>
 <20111013121745.GU21648@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111013121745.GU21648@n2100.arm.linux.org.uk>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Oct 13, 2011 at 01:17:45PM +0100, Russell King - ARM Linux wrote:
> On Thu, Oct 13, 2011 at 12:35:06PM +0100, Mark Brown wrote:

> > I said it was as good a place as any, I didn't say it was a good place.

> I'm saying it is a *BAD* place.  I'm saying that we've been flamed over
> this several times before.  We need to change our behaviour RIGHT NOW,
> not continue on ignoring the problem, and demonstrating to Linus that
> we don't take his concerns seriously.

I think we're agreeing here...

> > I think we should just carry on as we are while the IIO work proceeds,
> > either we'll decide that that's the way forward and we can then kick all
> > the ADCs into there or we'll get fed up, decide that's never going to
> > work then go and can do something else.

> You mean like other stuff which is already in the kernel gets fixed?
> It doesn't get fixed.  We persist with per-driver private data structures
> which multiply all over the place.

> Look at what happened with MTD and the flash_platform_data structure.
> That got ignored and instead people just continued merrily creating their
> own private crap time and time again.

The situation here is a bit different; there's people working on
handling these devices already but we can't point people at it as
something they can use yet.  As soon as we've got something to point
people at we should absolutely be going and actively pushing them
towards it but right now we don't have that option.

> We can not continue like this.  We can not continue to be soo permissive.

> I'm now saying a big NO to this - I don't care that the "cat is already
> out of the bag" - that's a defeatest attitude.  I'm saying no *now* so
> that there _is_ some kind of movement towards fixing this problem.  I

Half the problem that's being pointed out is that there is already
movement towards a solution for these devices, it's just not quite at
the point where it can be used for this class of devices yet.  The point
with the existing drivers being there is that this isn't a new driver
setting a precedent, if we had chosen to merge the driver we'd simply be
taking a decision to avoid creating churn that disrupts the existing
work.

> don't care whether that means it shares an existing ADC drivers callback
> data structures or what - I just don't want to see yet another driver
> private data structure being created for NO REASON what so ever.

Well, what do we do then?  I guess so long as it's outside arch/arm you
don't mind too much.

> Or maybe you'd like to be on the receiving end of another Linus flame?

> Some people would like to avoid such things - maybe you feed off them,
> that's your decision.  I personally am on the side of the folk who'd
> like to avoid being on the receiving end of the next Linus flame.

On the other hand we also don't want to overreact and we don't want to
irritate people by just putting stuff into a different directory without
actually improving it.  The goal isn't to troll Linus, the goal is to be
pragmatic about what we're actually achieving.  It's similar to the
decision that was taken to allow platforms to proceed without the
generic clk API or device tree bindings for the clk API.

> So.  No new drivers in arch/arm.  And I'm going to be saying no to any
> new per-driver data structures in mach/*.h for stuff which should be
> generic which haven't been justified for why they need to be different
> from someone elses.

The driver specific data structures should probably just be moving to
include/linux/platform_data which is the approved location for that sort
of thing.
