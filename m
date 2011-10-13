Return-Path: <linux+jic23=cam.ac.uk@arm.linux.org.uk>
Date: Thu, 13 Oct 2011 10:47:17 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Zoltan Devai <zdevai@gmail.com>, linux-iio@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Jonathan Cameron <jic23@cam.ac.uk>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/9] ARM: SPMP8000: Add ADC driver
Message-ID: <20111013094717.GL21648@n2100.arm.linux.org.uk>
References: <1318178172-7965-1-git-send-email-zoss@devai.org> <1318178172-7965-5-git-send-email-zoss@devai.org> <CAKnu2MrAEbS-36YaU+i6+zhwH4KW7ST7-mkKT49tv7jhhSo2UQ@mail.gmail.com> <4E92BE19.4060907@cam.ac.uk> <20111010100020.GA3607@opensource.wolfsonmicro.com> <CAGVye5Nc9vhaF=7Y+hvGo4g-GOFb9fHeni+g=+hTj-8WCSqY+Q@mail.gmail.com> <20111010114407.GD3607@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111010114407.GD3607@opensource.wolfsonmicro.com>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Oct 10, 2011 at 12:44:08PM +0100, Mark Brown wrote:
> On Mon, Oct 10, 2011 at 01:42:30PM +0200, Zoltan Devai wrote:
> 
> > Where should the adc driver go in this case ?
> 
> At the minute it seems to me that arch/arm is as good a place as any
> really - currently this code is getting dumped wherever the main device
> is.

No it isn't - we want drivers out of arch/arm (it's already been a topic
of flame for Linus, so it's something that we should try _really_ hard
to avoid.)

As this is clearly a device driver (it has a device driver struct, it
relies upon a struct device, etc) then it needs to live outside of
arch/arm/ - and I think Arnd's suggestion of drivers/adc is probably
the right place for it to move to (even though its probably the first
to create the directory.)  More stuff can come along in the future,
and then its all together to start creating a common API in there.

The other thing I'd say is that things like the callback definitions
and driver data should not be in some arch/arm/ include file - if
it's private to the ADC, it should go in drivers/adc too.  If not,
then somewhere in include/linux (maybe include/linux/adc) is a better
place.

What we *do* need to avoid is having the spmp8000 ADC callback function
data structure, the foo ADC callback function data structure, the bar
ADC callback function data structure and so forth.  We need to think
*NOW* about defining a common ADC callback structure so that we don't
spawn a new problem which'll take effort to solve.
