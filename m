Return-Path: <jic23@cam.ac.uk>
Message-ID: <4CC55D85.7040509@cam.ac.uk>
Date: Mon, 25 Oct 2010 11:35:49 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 Mike Frysinger <vapier@gentoo.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [Device-drivers-devel] [PATCH 00/36] staging: iio: ADI drivers
 for staging-next
References: <1287955358-3153-1-git-send-email-vapier@gentoo.org> <4CC4C2B8.2@cam.ac.uk> <AANLkTi=p3ArLzC_qz85emJeXytpnR2F9pzeG647Qj2Ek@mail.gmail.com> <544AC56F16B56944AEC3BD4E3D59177130945B1B3C@LIMKCMBX1.ad.analog.com> <4CC55650.5030304@cam.ac.uk>
In-Reply-To: <4CC55650.5030304@cam.ac.uk>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On 10/25/10 11:05, Jonathan Cameron wrote:
> On 10/25/10 09:39, Hennerich, Michael wrote:
>> Mike Frysinger wrote on 2010-10-25:
>>> On Sun, Oct 24, 2010 at 19:35, Jonathan Cameron wrote:
>>>> On 10/24/10 22:22, Mike Frysinger wrote:
>>>>> I've rebased all the drivers onto staging-next.  I've only fixed the
>>>>> API breakage due to the changes made after 2.6.36 (and fixed a few
>>>>> warnings). I've also run checkpatch across these.
>>>>>
>>>>> I have not however addressed any real feedback Jonathan has provided
>>>>> with regards to driver correctness or direction.  That stuff I'm
>>>>> leaving up to Michael Hennerich since it's his job and he actually
>>>>> understands this.
>>>>>
>>>>> Where possible, I'd like to have drivers merged so as to avoid another
>>>>> round of "new API just broke all your drivers".  We will still look
>>>>> into feedback given, but we'd like to focus on that rather than random
>>>>> `sed` changes as API names change.
>>>>>
>>>>> This patchset supersedes all other "new driver" patches I've posted
>>>>> in the last 48 hours.
>>>>
>>>> As we are still in staging, I'm happy to see these merge into IIO with
>>>> some provisos (this wouldn't be acceptable anywhere else in the kernel
>>>> tree).
>>>>
>>>> * We will be breaking abi's and probably even config symbol names
>>>> cleaning these up.  So if your customers start complaining you get to
>>>> explain why to them :)
>>>
>>> it wont be an issue.  we make it clear to people who use the IIO stuff
>>> that this is in heavy development and people have been OK with that.
>>>
>>>> * We sought out some test coverage for these. I want someone I can poke
>>>> if we  get a bug report, happy to use a generic address as long as
>>>> someone is able  to respond in reasonable time! (no complaints so far
>>>> with Analog, but this is  a lot of new devices for someone to have
>>>> wired up somewhere)
>>>
>>> i can add a MAINTAINERS entry for all ADI IIO drivers if that's
>>> sufficient.  any question about using Linux and an ADI part we are
>>> happy to answer.
>>
>> We will actively support these drivers. I'm currently in progress building up
>> a team, which will ensure that these drivers are tested and maintained over time.
> Excellent news.  There is a pretty strong feeling (from Greg KH) that 
> MAINTAINERS entries don't exist for stuff in staging.
> 
> However, adding something like
> 
> Contact: Drivers@analog.com for ADI drivers
> 
> to the main TODO file would probably be a good idea. Not necessary if Analog people
> monitor linux-iio though as every driver problem should also be copied to there.
>>
>>>> * If Randy or any one else reports build issues with weird
>>>> combinations, someone
>>>>  other than me quickly fixes them.
>>>
>>> i think the MAINTAINERS would cover this too
>>>
>>>> * I want some proper proposals of abi's for the new classes of device.
>>>> Lets debate  these on list. I would probably get round to doing this
>>>> myself eventually, but  if someone who knows the device class does it,
>>>> things will proceed much faster.  I've never used a resolver and had to
>>>> google what they were ;)  Having poorly defined abi's has bitten us a
>>>> few times in the past and tends to  put others off using the subsystem.
>>>>  So lets at least bash out what they should  be even if it takes a
>>>> little while to bring the drivers up to date.
>>>
>>> that'd be for Michael Hennerich
>>
>> We can start debating and refining on the exact API, to use.
>> However I like to do so once these drivers have merged.
> Agreed. Now you have confirmed the follow up support will be there,
> I'm happy to see them merged now and fixed later.
>> The ones likely subject to change we can mark as EXPERIMENTAL.
>> Or even print a warning using dev_warn() on probe.
> Either works for me.
>>
>>>> * As per standard staging rules, I will ask Greg to drop any driver
>>>> that no one is
>>>>  willing to support.  I will give plenty of warning of course!
>>>
>>> np
>>>
>>>> * Some of the temp chips might want to be in hwmon. I would like to
>>>> see an open
>>>>  discussion across both lists of whether then should be in IIO or
>>> there (or both).
>>>
>>> there has been discussion in the past in this regard.  but i dont
>>> recall where it occurred.
> Sure. Now Hwmon is again under active maintenance it's probably time to reopen
> the discussion.
>>>
>>>> The negatives of merging this set as is are that people might copy code
>>>> with issues we haven't fixed yet.  Such is life I guess. We could put a
>>>> big note in the TODO file, but then, who reads that?
>>> we have a tracker where we log all device driver feedback and assign to
>>> developers:
>>>   https://blackfin.uclinux.org/gf/project/device-drivers/tracker/
> Cool. That works fine.  Perhaps we can put that in the headers of the drivers
> or mention it in TODO in the top level directory.
> 
> There's also a rather under advertised equivalent at:
> http://sourceforge.net/apps/trac/iioutils/
> that I've been most using to remind myself of changes that need doing rather
> than as a formal system. Note this tracker covers userspace tools as well
> (those few that exist) I'll talk to you guys first before adding any specific
> ADI driver related ones to there.  The current ADI related ones are event support
> for the adis16350 and merging adis16300 and adis16400 drivers into that one.
> There is a bug somewhere in my changes to the burst mode (reported by Manuel).
> Unfortunately I can't test as my part for that one is an adis16350 which doesn't
> do burst reads.  The other is addition of adis16250 and similar support into the
> adis16260 driver which is dependent on testing from the author of the existing
> adis16250 driver that is in staging but outside IIO.
> 
> I'm looking forward to seeing the nice large section you guys will have in LWN's
> kernel section under new drivers. Not often people merge 36 in one go.
> 
Looks like my quick cc'ing of Guenter has already started the question of boundaries
between us and hwmon. If you want the controversial drivers in IIO rather than hwmon
you'll need to justify it and soon.
