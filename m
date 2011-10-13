Return-Path: <linux+jic23=cam.ac.uk@arm.linux.org.uk>
Date: Thu, 13 Oct 2011 13:17:45 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-iio@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Zoltan Devai <zdevai@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 4/9] ARM: SPMP8000: Add ADC driver
Message-ID: <20111013121745.GU21648@n2100.arm.linux.org.uk>
References: <1318178172-7965-1-git-send-email-zoss@devai.org> <1318178172-7965-5-git-send-email-zoss@devai.org> <CAKnu2MrAEbS-36YaU+i6+zhwH4KW7ST7-mkKT49tv7jhhSo2UQ@mail.gmail.com> <4E92BE19.4060907@cam.ac.uk> <20111010100020.GA3607@opensource.wolfsonmicro.com> <CAGVye5Nc9vhaF=7Y+hvGo4g-GOFb9fHeni+g=+hTj-8WCSqY+Q@mail.gmail.com> <20111010114407.GD3607@opensource.wolfsonmicro.com> <20111013094717.GL21648@n2100.arm.linux.org.uk> <20111013113506.GJ1098@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111013113506.GJ1098@sirena.org.uk>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Oct 13, 2011 at 12:35:06PM +0100, Mark Brown wrote:
> On Thu, Oct 13, 2011 at 10:47:17AM +0100, Russell King - ARM Linux wrote:
> > On Mon, Oct 10, 2011 at 12:44:08PM +0100, Mark Brown wrote:
> 
> > > At the minute it seems to me that arch/arm is as good a place as any
> > > really - currently this code is getting dumped wherever the main device
> > > is.
> 
> > No it isn't - we want drivers out of arch/arm (it's already been a topic
> > of flame for Linus, so it's something that we should try _really_ hard
> > to avoid.)
> 
> I said it was as good a place as any, I didn't say it was a good place.

I'm saying it is a *BAD* place.  I'm saying that we've been flamed over
this several times before.  We need to change our behaviour RIGHT NOW,
not continue on ignoring the problem, and demonstrating to Linus that
we don't take his concerns seriously.

If we can't find a place for it that's outside of arch/arm, then it
doesn't go in.

> I think we should just carry on as we are while the IIO work proceeds,
> either we'll decide that that's the way forward and we can then kick all
> the ADCs into there or we'll get fed up, decide that's never going to
> work then go and can do something else.

You mean like other stuff which is already in the kernel gets fixed?
It doesn't get fixed.  We persist with per-driver private data structures
which multiply all over the place.

Look at what happened with MTD and the flash_platform_data structure.
That got ignored and instead people just continued merrily creating their
own private crap time and time again.

We can not continue like this.  We can not continue to be soo permissive.

I'm now saying a big NO to this - I don't care that the "cat is already
out of the bag" - that's a defeatest attitude.  I'm saying no *now* so
that there _is_ some kind of movement towards fixing this problem.  I
don't care whether that means it shares an existing ADC drivers callback
data structures or what - I just don't want to see yet another driver
private data structure being created for NO REASON what so ever.

Or maybe you'd like to be on the receiving end of another Linus flame?

Some people would like to avoid such things - maybe you feed off them,
that's your decision.  I personally am on the side of the folk who'd
like to avoid being on the receiving end of the next Linus flame.

So.  No new drivers in arch/arm.  And I'm going to be saying no to any
new per-driver data structures in mach/*.h for stuff which should be
generic which haven't been justified for why they need to be different
from someone elses.
