Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:55144 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753838Ab1EJJtU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 May 2011 05:49:20 -0400
Message-ID: <4DC90AB4.1000608@cam.ac.uk>
Date: Tue, 10 May 2011 10:51:48 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
CC: "Ithamar R. Adema" <ithamar.adema@team-embedded.nl>,
	linux-arm-kernel@lists.infradead.org,
	Ilya Yanok <yanok@emcraft.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [RFC] What is the preferred way to share ADC unit between	hwmon
 and input(ts) drivers?
References: <4DC7EB55.1040109@cam.ac.uk> <20110509143939.GG3225@opensource.wolfsonmicro.com> <4DC817B5.5020706@cam.ac.uk> <20110509195451.GB6546@opensource.wolfsonmicro.com>
In-Reply-To: <20110509195451.GB6546@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/09/11 20:54, Mark Brown wrote:
> On Mon, May 09, 2011 at 05:35:01PM +0100, Jonathan Cameron wrote:
>> On 05/09/11 15:39, Mark Brown wrote:
> 
>>> Isn't that essentially what IIO is (well, there's the DAC side as well)?
>>> You're currently focusing on distributing data to userspace but that
>>> seems like a fixable limitation rather than anything else, I don't see a
>>> fundamental disconnect between users.
> 
>> Indeed, we could do it.  I suppose a lot of why I'm not just saying 'lets
>> try it and see how we go' is that there is a lot going
>> on in IIO right now with over 20,000 lines of patches under review...
>> (vast majority of that is core changes).
> 
> Right, as I've said before one of the reasons I've not looked at IIO in
> too much detail is that there's a lot of change and it's still in
> staging.
Fair enough. We'll definitely appreciate your feedback once it's stabilized!
> 
>> You've convinced me it may be sensible (and worth trying to see).  I'm not
>> sure everyone else will agree though! Mind you, despite some good responses
>> from those who have taken a look, I'm not sure Linus for one is going to like
>> IIO when we eventually send him a pull request..
> 
> One way to find out :)
Too true...  Need to hammer down the remaining ugly corners first ;)
> 
>>> It doesn't seem terribly invasive to be able to have a choice of things
>>> to notify, you already have to at least be able to work out which
>>> userspace thing to tell...
> 
>> Not really.  That is the main difference between input and iio.
>> There is one userspace route for data per device.  This is pretty bare
>> bones. There is buffering in between the device and userspace, sometime
>> it is in hardware, sometime software.
> 
> Yes, and my thought here was essentially that the bit that kicks
> userspace could with suitable use of callbacks be easily replaced by
> something that kicked an in-kernel user without too much hassle for the
> userspace users.
True for the slow path (one that feeds sysfs stuff).
The fast path deals with 'scans' of data channels. Breaking those up will be
'interesting' - it doesn't generalize well and right now it's basically up
to the individual drivers to describe what they did rather than the core
to insist on any particular form for the data.  All the information is there
to unwind this but it's going to be a little messy. All this gets to go
in the 'client' input / hwmon / other drivers anyway so not so bad as 
far as I'm concerned ;)

> 
>> We 'could' put a low latency path in place, and certainly intend to do
>> it (see the interchangable 'buffer' element of IIO, but it is not trivial.
>> It's on the todo list, but it's not there now. The other thing we have
>> is two data paths vs input's one. Input calls everything an event
>> and hence has to separately describe every bit of data coming out.
>> We still have events for threshold etc, but we also have 'data'
>> (e.g. channel reads) going through a path without needing to describe
>> the individual pieces of data (this is fixed if userspace doesn't try
>> to change it).  Note that this 'data' path is very much about ripping
>> the raw stuff off the channel (typically as a 'scan') and shoving it
>> onwards.
> 
> With the above approach I don't think IIO (or whatever) would need to
> worry about the difference - it just lets whatever is consuming the data
> deal with the blocks of data that get thrown out.
True to a certain extent, the trick is ensuring those consumers have enough
information to be able to tell what they got.
> 
>> It may make sense to do this in kernel but it is going to be rather big
>> and messy (hence the input guys suggested doing it using uinput in
>> the first place!).
> 
> Yeah, I don't know that the specific example of input makes much sense.
I thought this was one of the commonest cases for shared use ADCs?
> 
>> I'm still bothered that people will not like the weight of IIO under
>> the other subsystems.  It is only heavy if people enable the interesting
>> bits, but a lot of people might not realize that.
> 
> So long as there's suitable fast/light paths I think we'd be fine.  I
> guess another option would be to split out the userspace API from the
> driver API so that people could skip the userspace API.
That may well be worth doing - but not right now!  A lot of the stuff
Arnd suggested makes this easier.
> 
>>>> and input device (and IIO).  Thus it has multiple functions and so
>>>> to my mind belongs as an mfd core and separate hwmon and input drivers.
> 
>>> Like I say this isn't really the model the hardware is presenting here -
>>> it looks much more like a set of n ADC channels some of which have
>>> fixed purposes and some of which are generic than a single ADC.
>> I still disagree on this point.  Lets say we have an adc with 8 channels.
> 
>> 1-2 -> touch screen (input device)
>> 3-4 -> power monitoring (hwmon device)
>> 5-8 -> general purpose (IIO device - complete with 'scan' functions if
>> that makes sense the device).
> 
>> Looks exactly like an mfd to me.  There are clearly 3 functions there.
>> To a hardware engineer perhaps they look like a single one (ADC) but
>> that is clearly not how the board in question is wired up.
> 
> MFD would feel more comfortable if you had a watchdog and an RTC or
> whatever in there, and even then having three devices all of which are
> thin wrappers around a custom per-chip bit of code in the MFD core feels
> icky.
Not ideal.  If it were done in mfd I'd certainly suggest some extra core infrastructure
to support it. Ultimately wherever it is I think we'll end up with a bus 
(which IIO is anyway) with hwmon etc devices hanging off that.
> 
>>> You could do that, but like I say if we do that then what it's
>>> suggesting to me is that we should be pulling the chip drivers out of
>>> IIO and pushing them down into some new subsystem, leaving IIO as a
>>> wrapper around that subsystem for otherwise unclaimed channels (or
>>> possibly explicitly exposed channels).
> 
>> Indeed - I have been suggesting a very small layer underneath
>> (which I still think is going to look remarkably like mfd) may make more sense.  I'm basically
>> not sure either way.  We can do it in IIO, but is that the right option?
> 
> MFD is really only about register maps, registering subdevices and (for
> randomness) IRQ controllers - anything too substantial beyond those
> really feels a bit wrong there.  The ADC stuff definitely feels too
> heavyweight, especially when you start adding things like comparators on
> top of that.  There should be some subsystem we can slot this into.
Comparators should be fine if we do this with IIO,
but will need a few more hooks inserted. Translation of these into the
interfaces of hwmon in particular may be fiddly (hwmon has very limited
view of what a comparator can be telling you).

> 
>> V1 - no clever reading tricks or high throughput.
>>
>> 1) A nice generic way of specifying which channels are for which subsystem.
>> 2) Sufficient information on adc to provide the nice unit converted stuff hwmon
>> expects and the info on noise etc that input wants. The chan spec structures go
>> a way towards this - see 
>> https://git.kernel.org/?p=linux/kernel/git/jic23/iio-onwards.git;a=blob;f=drivers/staging/iio/iio.h
> 
> Looks sensible.
> 
>> 3) hwmon driver - actually this is easy given we match a lot of their interfaces
>> anyway and its SLOW..
> 
> Yes, and also /sys/class/power_supply usage.
> 
>> 4) input driver - polled only initially. Later add ability to 'steal' the trigger
>> from iio to do data ready interrupt based reading.  I can't see an easy way 
>> of making these play well together. Basically if you want to use the device for
>> anything else you have to fix the functionality of the IIO path way more than normal.
> 
> The stuff with stealing the trigger seems like a callback type problem
> to me.
The issue is that in IIO triggers are completely flexible (at least in theory
- a few corner cases in drivers trip us up). Any available trigger can driver
sampling on any device.  Obviously, much of the time if there is a dataready
signal, it is used to trigger the device providing it (defaults to this), but
that dataready can also be used to trigger other sensors - and there are 
fun use cases where even a device with a dataready is triggered by another
source.  If other 'clients' - e.g. input are registered, I think the trigger
will have to be locked to the data ready.  No one cares about datardy with
hwmon anyway so that can just read when it likes. Might put a glitch in the
IIO data stream, but those happen anyway for all sorts of other reasons! 
> 
>> V2 - buffer routing - this is nasty and may never make sense.
> 
>> 1) Allow for diversion of raw data into 'input' or the IIO buffer on triggering.
>> Note configurable triggers will still not be possible as far as I can see.
>> To configure them you have to disable all sampling - if someone else is using them
>> you can't do that.
> 
> For low volume devices I guess you can do a lot of this in software
> relatively painlessly; so long as it doesn't impact high volume devices
> ("I used DMA to fill that buffer, honest!") I guess that's fine.
Yup, ideally need to keep even the hooks out of high volume path.  Guess driver
writer can decide if their device is going to support alternate data paths
or not!


