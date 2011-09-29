Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:42442 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754908Ab1I2Ikh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 29 Sep 2011 04:40:37 -0400
Message-ID: <4E8430FC.3000800@cam.ac.uk>
Date: Thu, 29 Sep 2011 09:49:00 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: JohnLM <johnlm@apollo.lv>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: New board potentially using IIO
References: <20110928014131.2dc76061@isg005> <4E82DFD7.3000906@cam.ac.uk> <20110929003510.638ac489@isg005>
In-Reply-To: <20110929003510.638ac489@isg005>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/28/11 22:35, JohnLM wrote:
> On Wed, 28 Sep 2011 09:50:31 +0100
> Jonathan Cameron <jic23@cam.ac.uk> wrote:
> 
>> On 09/27/11 23:41, JohnLM wrote:
>>> Hello Jonathan!
>>>
>>> I wasn't exactly sure if this topic is worth discussing on linux-iio
>>> or it'd just cause more "noise". So I just wrote it to you.
>>> (Since you're -- from what I can understand -- maintainer of IIO)
>> Should be on linux-iio (people can ignore it if not interested!)
>> So I've cc'd the list.
>>>
>>> The thing is... I'm working in a project and we're developing a
>>> sort of DAQ (Data acquisition) device. It's still pretty much on
>>> initial brainstorming stage.
>>>
>>> Few things are laid down however - it shall be a PCI-Express device
>>> with potentially very fast (fuzzy definition here, but assume tens
>>> or hundreds of MSPS) data sources/sinks (or "channels" by Comedi
>>> terms). And I have simple and fairly generic protocol to exchange
>>> data over PCIe.
>>>
>>> Not to go into details too much I'll get to my questions.
>>> What's the current status with IIO and how it relates to Comedi?
>> Firstly my knowledge of Comedi is somewhat light (tediously NI won't
>> give me docs for the only card I actually want to use it for and
>> it isn't supported - but that is another story!)
>>
>> We've mostly kept clear of Comedi (other than for inspiration in
>> some areas).  Traditionally Comedi has covered high speed
>> daq cards in relatively high end machines.  We very much wanted to
>> have a clear progression from slow and simple drivers (basically hwmon
>> type interfaces where you read from human readable sysfs files)
>> through to the low overhead / high data rate end.  Right now though
>> we don't have any truely high speed devices.
> 
> Then it on first glance it appears my device would be better using
> Comedi. But I'll have to study the APIs/interfaces for both more
> thoroughly.
> I'm not particularly interested in providing sysfs files for other than
> testing the driver. I intend to use mostly chardevs to get data from and
> shove data unto.
> Then again, that was the initial idea, obviously I'll have to conform to
> one or the other subsystem's interface.
> 
>> There has also been some discussion about sharing interfaces with
>> comedi but for now that has stalled because no one has had the time
>> to look into it.  To my quick glance it looked like comedi was pretty
>> much always used through a standard userspace library so such sharing
>> would probably occur at the library interface level. Comedi is old
>> and big so carries a lot of legacy stuff very different to how it
>> would be developed today.
>>
>> I know there have been some suggestions that eventually some comedi
>> stuff might migrate to IIO, but right now no one has any time to even
>> see if that is feasible! (he says but who knows what others are
>> looking at!)
> 
> btw I did a quick search over Comedi archives, there is no topic
> concerning merging with IIO. In fact nothing came up with keyword IIO
> in topics. I reckon this idea didn't originate with them. :)
Indeed. The only suggestion I've seen was:
http://lists.kernelnewbies.org/pipermail/kernelnewbies/2011-April/001616.html
(note I don't want to encourage this right now anyway as we have
too much on our plate!)

The interface sharing stuff came from our side, specifically 
http://marc.info/?l=linux-iio&m=129271499509310
> 
>>
>>> I can
>>> see IIO in progress of being moved out of staging, which is nice.
>>> What's the support for outputting data to the device? 
>> Very basic.  Right now there are two types of output. Simple
>> dac controls via single sysfs files - write a value and that is
>> what you get and dds controls which only cover small classes of
>> standard waveforms (square, sine etc).  
>>
>> Analog Devices are interested in a more general framework but I
>> don't think any work has gone in on it as yet (cc'd Michael in
>> case there any updates on that front).  The plan was to do
>> a reverse version of the buffering we have for outputs.  So
>> you'd set up the channel format etc for an input buffer, then
>> push the waveform in you want.  That would then either sit in
>> a software buffer and be pushed to the device on a trigger
>> occuring, or the device would have a hardware buffer that would
>> eat it up.
> 
> That's pretty much what I was thinking. I'd want to add that the write
> itself could optionally be considered a trigger. This would start
> consuming the data right away and should be
> better for real-time (I use the term ligtly here) capable devices.
> On other fast devices might require a larger chunk of initial data to
> avoid buffer underrun.
True on both counts.  I suspect the queue up and then trigger when ready
approach might work better (allows for things like ramps up to a level),
but it comes down to whatever the user case requires!
> 
>>
>> The exact form of the interface hasn't been pinned down as
>> we don't have any code yet!
>>> Let's say an DAC
>>> as a voltage source or function generator.
>>> Does my upcoming device driver is a good candidate to use IIO, or
>>> should I look elsewhere?
>> I'd say that depends on how much work you want to give yourself.
>> It would probably be easier to do under Comedi as everything is
>> there already.  If you did want to do it under IIO, I would first
>> want to open up a full discussion with the Comedi list and more
>> generally about whether it makes sense to try doing this stuff
>> in IIO. Basically, I have no interest in starting a fight
>> with them, but would love to get their input if we do start
>> supporting the level of device you describe.
> 
> I'm not afraid some extra work, in fact I was up to make the whole
> driver/interface/library stack if necessary. But why do it when someone
> has done it for you? }:)
Getting buffered feeds to output channels working is a big job, so
I'd be delighted if you do decide to take it on.  I know there is a fair
bit of interest.
> 
> However the discussion with Comedi guys will have to done sooner or
> later anyway. My project is irrelevant here.
It's only relevant in that it's the second time we have had people wondering
which subsystem makes sense.  
> 
>>>
>>> One other thing, which as a newbie kernel hacker couldn't really
>>> find answer on.
>>> How should I go about putting a driver for prototype device in
>>> mainline kernel? Putting it in staging is obvious, but should I put
>>> it in mainline at all?
>> Usual question is whether two people might be interested / using it.
>> Their are whole architectures in there with only one physical device
>> in existence, so if you want to work with mainline then do so (and
>> I'd encourage you to indeed do that!).
>>
>> I wouldn't necessarily bother with staging unless it is dependent on
>> stuff in there (e.g. IIO :). It makes sense when you are looking for
>> more general public code exposure or it is useful to others, but in
>> your case mailing list posts etc may be a better work flow.
> 
> 
> Thank you for you input!
Looking forward to seeing your code, whether in IIO or comedi.

Jonathan

