Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:60570 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050Ab1EIQcd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 May 2011 12:32:33 -0400
Message-ID: <4DC817B5.5020706@cam.ac.uk>
Date: Mon, 09 May 2011 17:35:01 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
CC: "Ithamar R. Adema" <ithamar.adema@team-embedded.nl>,
	linux-arm-kernel@lists.infradead.org,
	Ilya Yanok <yanok@emcraft.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [RFC] What is the preferred way to share ADC unit between	hwmon
 and input(ts) drivers?
References: <4DC7EB55.1040109@cam.ac.uk> <20110509143939.GG3225@opensource.wolfsonmicro.com>
In-Reply-To: <20110509143939.GG3225@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/09/11 15:39, Mark Brown wrote:
> On Mon, May 09, 2011 at 02:25:41PM +0100, Jonathan Cameron wrote:
>> On 05/06/11 18:20, Mark Brown wrote:
> 
>>> I'm not clear what an abstraction below IIO for a plain ADC would be.
> 
>> In summary what bothers me is not that IIO can't handle this - it can
>> with a few minor tweaks but rather that using IIO is massive overkill.
>> I can certainly see the benefit in adding what you suggest, but I'm a
>> little worried the main response would be 'why are you putting
>> all this stuff in place given you are just acting as distribution
>> layer for adc reading?'.
> 
> Isn't that essentially what IIO is (well, there's the DAC side as well)?
> You're currently focusing on distributing data to userspace but that
> seems like a fixable limitation rather than anything else, I don't see a
> fundamental disconnect between users.
Indeed, we could do it.  I suppose a lot of why I'm not just saying 'lets
try it and see how we go' is that there is a lot going
on in IIO right now with over 20,000 lines of patches under review...
(vast majority of that is core changes).

You've convinced me it may be sensible (and worth trying to see).  I'm not
sure everyone else will agree though! Mind you, despite some good responses
from those who have taken a look, I'm not sure Linus for one is going to like
IIO when we eventually send him a pull request..
> 
>>> I'm not personally interested in that case, but if the input device is
>>> really reading from the ADC using the same ADC interface as the rest of
>>> the world then presumably the abstraction mismatch would be handled
>>> above IIO?
> 
>> This is my point. IIO is high performance - if there is 'above' IIO, then
>> you've just wrecked one of our main reasons for existence.  IIO goes to userspace
>> via the shortest possible path.
> 
> It doesn't seem terribly invasive to be able to have a choice of things
> to notify, you already have to at least be able to work out which
> userspace thing to tell...
Not really.  That is the main difference between input and iio.
There is one userspace route for data per device.  This is pretty bare
bones. There is buffering in between the device and userspace, sometime
it is in hardware, sometime software.

>  It certainly doesn't seem like we'd want
> another subsystem to offer a different userspace interface, or even a
> reimplementation of the same userspace interface, for the generic
> channels.  It also doesn't seem like kernel space is going to be
> explicitly looking for low performance, in the touchscreen example you
> mentioned the focus is typically very much on reducing latency.
Exactly.  Why bounce through another subsystem when you can share at a
much lower level? Also as you say, input is about latency, we are often
about through put right now.
We 'could' put a low latency path in place, and certainly intend to do
it (see the interchangable 'buffer' element of IIO, but it is not trivial.
It's on the todo list, but it's not there now. The other thing we have
is two data paths vs input's one. Input calls everything an event
and hence has to separately describe every bit of data coming out.
We still have events for threshold etc, but we also have 'data'
(e.g. channel reads) going through a path without needing to describe
the individual pieces of data (this is fixed if userspace doesn't try
to change it).  Note that this 'data' path is very much about ripping
the raw stuff off the channel (typically as a 'scan') and shoving it
onwards.

To get it into input for example, we would need to provide a translation
layer which reads our channel descriptions > figures out input event types
> passes on to input.  Right now this is done in userspace (obviously
not appropriate for touch screens).

It may make sense to do this in kernel but it is going to be rather big
and messy (hence the input guys suggested doing it using uinput in
the first place!).
> 
>>> I can't think what would be unusual about this from the
>>> point of view of the ADC.
> 
>> I really think you have misunderstood what IIO is targeting.  It is not
>> currently about providing a small layer to allow other kernel subsystems
>> to access an adc - it's about two main things.  Unified consistent userspace
>> interfaces and the option of a fast data path to userspace.  We can put in
>> what you want and have sufficient information to do it (unlike hwmon and input
>> I guess), but as yet I'm unconvinced that we should.
> 
> Well, if we don't do that I guess we have to invent another subsystem
> for generic ADCs and DACs which doesn't seem ideal either, and I'd guess
> a bunch of drivers (at a guess many of them) would get pushed down from
> IIO into that and use some generic IIO to convertor adaption layer?
You are beginning to persuade me...
(it wouldn't be that many of our current drivers, but it might well cover
a good set of possible future ones ).

I'm still bothered that people will not like the weight of IIO under
the other subsystems.  It is only heavy if people enable the interesting
bits, but a lot of people might not realize that.
> 
>>> It's not really ADC sharing as such - there's one physical ADC but to
>>> software these things look like a multi-channel ADC that happens to have
>>> a single register to push data out of.  It happens to be lower volume
>>> than most of the IIO ADCs but that doesn't seem like it should make too
>>> much of a difference?
> 
>> We would have no problem handing the ADC's what we would need to add
>> is the description layer that provides the right information to input
>> and hwmon drivers sat on top + a few bits of infrastructure to connect
>> it all up.  Basically anything beyond the trivial adc channels with no
>> side information, would be rapidly become complex.
> 
> Can't the higher level subsystems deal with this?  It doesn't seem like
> a problem the ADC layer should be worrying about.
> 
>>> I'm not clear why MFD would be useful here?  These things are single
>>> function ADCs and don't always appear as part of a larger Linux device.
>>> Some CPUs have these, for example, so they just appear as a memory
>>> mapped platform device.  They often end up with the custom API in the
>>> core MFD driver where there is one of those but that's not because the
>>> MFD API is relevant.
> 
>> You may view an adc as a single device - but if you want the option in
>> kernel to have it sometimes act as input and sometimes act as hwmon -
>> to do it coherently you probably need to viewing it as a combined hwmon
>> and input device (and IIO).  Thus it has multiple functions and so
>> to my mind belongs as an mfd core and separate hwmon and input drivers.
> 
> Like I say this isn't really the model the hardware is presenting here -
> it looks much more like a set of n ADC channels some of which have
> fixed purposes and some of which are generic than a single ADC.
I still disagree on this point.  Lets say we have an adc with 8 channels.

1-2 -> touch screen (input device)
3-4 -> power monitoring (hwmon device)
5-8 -> general purpose (IIO device - complete with 'scan' functions if
that makes sense the device).

Looks exactly like an mfd to me.  There are clearly 3 functions there.
To a hardware engineer perhaps they look like a single one (ADC) but
that is clearly not how the board in question is wired up.

I'm not suggesting mfd is ideal for this, but rather that it is a valid
option to consider.

> 
>> I am thoroughly in favour of unifying code at this sort of low level for
>> the various subsystems that need to read from the ADC. All I'm arguing is
>> that IIO is not the right place.  What you need here is a clean abstraction
>> for what is effectively reading from a device register.
> 
>> Then you need to have a 'bus' to which your hwmon / input / iio drivers
>> appear to be connected.  The irq stuff can be handled using irq chips.
> 
> You could do that, but like I say if we do that then what it's
> suggesting to me is that we should be pulling the chip drivers out of
> IIO and pushing them down into some new subsystem, leaving IIO as a
> wrapper around that subsystem for otherwise unclaimed channels (or
> possibly explicitly exposed channels).
Indeed - I have been suggesting a very small layer underneath
(which I still think is going to look remarkably like mfd) may make more sense.  I'm basically
not sure either way.  We can do it in IIO, but is that the right option?

As I've said, I'm happy to give it a go and see (or let someone else
try it out).  We do have iio_chan_spec structures and the relevant
callbacks to figure out everything needed to do what you suggest.
> 
> What I'm looking for here is a standard way of writing drivers for
> generic ADCs and DACs.  It doesn't have to be IIO but if it isn't then
> it's really suggesting to me that we need to start pushing things down
> out of IIO so we have a consistent way to implement support for random
> generic ADCs and DACs.

Lets sumarize what we would need. I've cc'd linux-iio (probably should have
done that long ago!) as they may give more feedback on practicalities.

Assume only dealing with hwmon, input and IIO as output routes for now.
Note if you enable input, certain things will not work in IIO.

V1 - no clever reading tricks or high throughput.

1) A nice generic way of specifying which channels are for which subsystem.
2) Sufficient information on adc to provide the nice unit converted stuff hwmon
expects and the info on noise etc that input wants. The chan spec structures go
a way towards this - see 
https://git.kernel.org/?p=linux/kernel/git/jic23/iio-onwards.git;a=blob;f=drivers/staging/iio/iio.h

3) hwmon driver - actually this is easy given we match a lot of their interfaces
anyway and its SLOW..
4) input driver - polled only initially. Later add ability to 'steal' the trigger
from iio to do data ready interrupt based reading.  I can't see an easy way 
of making these play well together. Basically if you want to use the device for
anything else you have to fix the functionality of the IIO path way more than normal.

V2 - buffer routing - this is nasty and may never make sense.

1) Allow for diversion of raw data into 'input' or the IIO buffer on triggering.
Note configurable triggers will still not be possible as far as I can see.
To configure them you have to disable all sampling - if someone else is using them
you can't do that.

So all in all - hwmon and polled input would be reasonably straight forward.
I suspect they may well disagree about whether this is a good idea.

Mark - do note that the stuff in staging-next right now is no where near the
same as the tree we are mostly working with...
https://git.kernel.org/?p=linux/kernel/git/jic23/iio-onwards.git;a=summary

Pushing this out is waiting one last driver conversion/fixup (and responding to any
reviews that turn up in the meantime!)

Jonathan


