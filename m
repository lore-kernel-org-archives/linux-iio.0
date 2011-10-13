Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:34301 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026Ab1JMLfK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 13 Oct 2011 07:35:10 -0400
Date: Thu, 13 Oct 2011 12:35:06 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-iio@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Zoltan Devai <zdevai@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 4/9] ARM: SPMP8000: Add ADC driver
Message-ID: <20111013113506.GJ1098@sirena.org.uk>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
 <1318178172-7965-5-git-send-email-zoss@devai.org>
 <CAKnu2MrAEbS-36YaU+i6+zhwH4KW7ST7-mkKT49tv7jhhSo2UQ@mail.gmail.com>
 <4E92BE19.4060907@cam.ac.uk>
 <20111010100020.GA3607@opensource.wolfsonmicro.com>
 <CAGVye5Nc9vhaF=7Y+hvGo4g-GOFb9fHeni+g=+hTj-8WCSqY+Q@mail.gmail.com>
 <20111010114407.GD3607@opensource.wolfsonmicro.com>
 <20111013094717.GL21648@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111013094717.GL21648@n2100.arm.linux.org.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Oct 13, 2011 at 10:47:17AM +0100, Russell King - ARM Linux wrote:
> On Mon, Oct 10, 2011 at 12:44:08PM +0100, Mark Brown wrote:

> > At the minute it seems to me that arch/arm is as good a place as any
> > really - currently this code is getting dumped wherever the main device
> > is.

> No it isn't - we want drivers out of arch/arm (it's already been a topic
> of flame for Linus, so it's something that we should try _really_ hard
> to avoid.)

I said it was as good a place as any, I didn't say it was a good place.
Currently we don't have a good place for this code but just dumping the
code somewhere else isn't really helping anything either unless there's
some meaningful subsytem (or at least effort towards a subsystem) to
look after it, it's bookkeeping.

> As this is clearly a device driver (it has a device driver struct, it
> relies upon a struct device, etc) then it needs to live outside of
> arch/arm/ - and I think Arnd's suggestion of drivers/adc is probably
> the right place for it to move to (even though its probably the first
> to create the directory.)  More stuff can come along in the future,
> and then its all together to start creating a common API in there.

Creating drivers/adc just seems like a sucky idea.  We've already got at
least one ongoing effort at creating a general purpose ADC/DAC interface
in the form of the IIO subsystem (which is currently mostly targeted at
higher volume devices and userspace only but the abstractions needed
aren't terribly different depending on the data volumes) and does have
the rather substantial advantage that there's people actually trying to
make a subsystem.  On the other hand it's in staging for now so it'd
create pain trying to merge the in-kernel clients that go along with
these devices which doesn't seem constructive.

There's also the fact that ADCs and DACs are pretty much the same thing
to software with the data line driven from the opposite end of the link
sO if we've got a subsystem for ADCs only it seems clear we're doing
something wrong.

> What we *do* need to avoid is having the spmp8000 ADC callback function
> data structure, the foo ADC callback function data structure, the bar
> ADC callback function data structure and so forth.  We need to think
> *NOW* about defining a common ADC callback structure so that we don't
> spawn a new problem which'll take effort to solve.

The cat's already well out of the bag on that one, we've got a bunch of
these things in tree already - the Cragganmore system I've got sitting
here on my desk has three auxiliary ADCs I'm aware of, all of which are
supported in mainline, and they're far from the only ones.

I think we should just carry on as we are while the IIO work proceeds,
either we'll decide that that's the way forward and we can then kick all
the ADCs into there or we'll get fed up, decide that's never going to
work then go and can do something else.
