Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:54849 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026Ab1JMLfv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 13 Oct 2011 07:35:51 -0400
Message-ID: <4E96CD16.5060104@cam.ac.uk>
Date: Thu, 13 Oct 2011 12:35:50 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Linus Walleij <linus.walleij@linaro.org>
CC: linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Zoltan Devai <zdevai@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/9] ARM: SPMP8000: Add ADC driver
References: <1318178172-7965-1-git-send-email-zoss@devai.org> <1318178172-7965-5-git-send-email-zoss@devai.org> <CAKnu2MrAEbS-36YaU+i6+zhwH4KW7ST7-mkKT49tv7jhhSo2UQ@mail.gmail.com> <4E92BE19.4060907@cam.ac.uk> <20111010100020.GA3607@opensource.wolfsonmicro.com> <CAGVye5Nc9vhaF=7Y+hvGo4g-GOFb9fHeni+g=+hTj-8WCSqY+Q@mail.gmail.com> <20111010114407.GD3607@opensource.wolfsonmicro.com> <20111013094717.GL21648@n2100.arm.linux.org.uk> <CACRpkdZMXjoHdEaPhTFS9Q7=5tWfFHDiwt-gdKd2CGiW+Evdmw@mail.gmail.com>
In-Reply-To: <CACRpkdZMXjoHdEaPhTFS9Q7=5tWfFHDiwt-gdKd2CGiW+Evdmw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/13/11 12:09, Linus Walleij wrote:
> On Thu, Oct 13, 2011 at 11:47 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Mon, Oct 10, 2011 at 12:44:08PM +0100, Mark Brown wrote:
>>> On Mon, Oct 10, 2011 at 01:42:30PM +0200, Zoltan Devai wrote:
>>>
>>>> Where should the adc driver go in this case ?
>>>
>>> At the minute it seems to me that arch/arm is as good a place as any
>>> really - currently this code is getting dumped wherever the main device
>>> is.
>>
>> No it isn't - we want drivers out of arch/arm (it's already been a topic
>> of flame for Linus, so it's something that we should try _really_ hard
>> to avoid.)
> 
> Amen to that.
> 
>> As this is clearly a device driver (it has a device driver struct, it
>> relies upon a struct device, etc) then it needs to live outside of
>> arch/arm/ - and I think Arnd's suggestion of drivers/adc is probably
>> the right place for it to move to (even though its probably the first
>> to create the directory.)  More stuff can come along in the future,
>> and then its all together to start creating a common API in there.
> 
> That sort of suggest that the drivers/staging/iio/adc is in
> trouble now. It will have an in-kernel competitor for similar
> stuff.
> 
> Having drivers/adc and drivers/iio/adc compete about
> taking drivers on preference as to whether they were intended
> for userspace or kernelspace does not seem like a good
> thing.
The problem with a straight adc directory is the fact that many of
these devices are combined input and output.  The also tend to
have numerous things that to a casual don't look like ADC's
(light sensors etc).  We only did the grouping in IIO for the
sake of not having a huge flat directory.  Many of the drivers
overlap between the different categories.
> 
>>>From a quick review of the IIO ADC subsystem I cannot really
> find a big problem with it other than it brings the entire IIO
> subsystem along, including the userspace interfaces I guess.
> 
> The circumstances seem to suggest that drivers/iio/adc should
> be moved down to drivers/adc without the rest of the iio
> stuff, with a in-kernel API only and then have iio use that
> (this is probably true for some more drivers in IIO like
> dac, accel, addac, gyro...).
> 
> So the concept of IIO stuff would change from the
> userspace-first centric view to the kernelspace-first
> centric, with optional userspace interfaces in the form
> of IIO.
> 
> I'm not sure about what Jonathan thinks about that
> though.
That wouldn't be too hard to do. It's just a case of breaking
iio_register_device function in two.  Right now (with the in kernel
RFC) on top.  The only thing needed for in kernel access is that the
configured struct iio_dev gets added to the list of available devices.

I think we need to maintain the form of struct iio_chan_spec 
(or whatever does the same job) with the intent of it directly mapping
to userspace interfaces (keeps things clean and makes sure there is enough
information to actually use the channel for anything).

The key thing is the unified specification of channel capabilities
and the ability to read them.  We have one way of doing that which
has developed against a 'lot' of drivers.

The nasty corner is optimized reading of channel scans.  They tend to
be irrelevant for memory mapped device but are vital for many devices
on low bandwidth buses.  Right now we leave that entirely to the
individual drivers (they push this data out rather than it being
pulled from the core like everything else).  It may be possible to
flip this around with out too much pain, but I'm not sure.
The other nasty bits are:
* hardware buffering
* triggered capture control - we really care about this for IIO
and I don't think anyone else does.  Could maybe get away with using
device tree or similar to specify defaults for this and not provide
any means of changing it for devices other than those with full IIO
userspace in place.

As you can imagine I'm a little wary of sending IIO through another
refactoring right now (proposal to move the core out of staging is
scheduled for my next free afternoon!).  So in principal in favour
of this approach but in practice not sure I'll be in a position
to do it (need to eat and my funding source is about to run out -
awaiting decision on more).

So my personal preference would be to add the relevant access functions
etc to IIO as is.  Two models:

1) Pull from drivers - (give me reading now).
Done - we need to nick the clkdev mapping approach to join everything
up and play a few tricks to get a unique consistent name.

2) Push from triggered capture  - (here is a reading).
Easiest option from our point of view is to provide this as a 'buffer'
implementation.  Normally we'd notify userspace of new data, here we
notify in kernel users (or just push it into their callbacks).

Post that we start to make IIO userspace interfaces optional.

It gives a progression towards what you are suggesting and doesn't
hold us up in staging for another long cycle.

There are exceptions. I'd argue any element that is really built for
say hwmon or input ought to register directly with those subsytems.
That includes the touchscreen element of the adc that started this
conversation.  No point in adding overhead and generality to a non
general element.

Sorry for quick reply, mad day.

Jonathan
