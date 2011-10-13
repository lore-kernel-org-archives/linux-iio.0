Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20111013094717.GL21648@n2100.arm.linux.org.uk>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<1318178172-7965-5-git-send-email-zoss@devai.org>
	<CAKnu2MrAEbS-36YaU+i6+zhwH4KW7ST7-mkKT49tv7jhhSo2UQ@mail.gmail.com>
	<4E92BE19.4060907@cam.ac.uk>
	<20111010100020.GA3607@opensource.wolfsonmicro.com>
	<CAGVye5Nc9vhaF=7Y+hvGo4g-GOFb9fHeni+g=+hTj-8WCSqY+Q@mail.gmail.com>
	<20111010114407.GD3607@opensource.wolfsonmicro.com>
	<20111013094717.GL21648@n2100.arm.linux.org.uk>
Date: Thu, 13 Oct 2011 13:09:50 +0200
Message-ID: <CACRpkdZMXjoHdEaPhTFS9Q7=5tWfFHDiwt-gdKd2CGiW+Evdmw@mail.gmail.com>
Subject: Re: [PATCH 4/9] ARM: SPMP8000: Add ADC driver
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Jonathan Cameron <jic23@cam.ac.uk>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Zoltan Devai <zdevai@gmail.com>,
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On Thu, Oct 13, 2011 at 11:47 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Oct 10, 2011 at 12:44:08PM +0100, Mark Brown wrote:
>> On Mon, Oct 10, 2011 at 01:42:30PM +0200, Zoltan Devai wrote:
>>
>> > Where should the adc driver go in this case ?
>>
>> At the minute it seems to me that arch/arm is as good a place as any
>> really - currently this code is getting dumped wherever the main device
>> is.
>
> No it isn't - we want drivers out of arch/arm (it's already been a topic
> of flame for Linus, so it's something that we should try _really_ hard
> to avoid.)

Amen to that.

> As this is clearly a device driver (it has a device driver struct, it
> relies upon a struct device, etc) then it needs to live outside of
> arch/arm/ - and I think Arnd's suggestion of drivers/adc is probably
> the right place for it to move to (even though its probably the first
> to create the directory.) =A0More stuff can come along in the future,
> and then its all together to start creating a common API in there.

That sort of suggest that the drivers/staging/iio/adc is in
trouble now. It will have an in-kernel competitor for similar
stuff.

Having drivers/adc and drivers/iio/adc compete about
taking drivers on preference as to whether they were intended
for userspace or kernelspace does not seem like a good
thing.

>>From a quick review of the IIO ADC subsystem I cannot really
find a big problem with it other than it brings the entire IIO
subsystem along, including the userspace interfaces I guess.

The circumstances seem to suggest that drivers/iio/adc should
be moved down to drivers/adc without the rest of the iio
stuff, with a in-kernel API only and then have iio use that
(this is probably true for some more drivers in IIO like
dac, accel, addac, gyro...).

So the concept of IIO stuff would change from the
userspace-first centric view to the kernelspace-first
centric, with optional userspace interfaces in the form
of IIO.

I'm not sure about what Jonathan thinks about that
though.

Yours,
Linus Walleij
