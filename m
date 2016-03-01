Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59483 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607AbcCAR1d (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Mar 2016 12:27:33 -0500
In-Reply-To: <CAEnQRZDXd7ZU4L=95Qw-oVfK23XQ2EfNj-A=ehbRpvJRHKv5gQ@mail.gmail.com>
References: <1456574754-23387-1-git-send-email-jic23@kernel.org> <CAEnQRZDXd7ZU4L=95Qw-oVfK23XQ2EfNj-A=ehbRpvJRHKv5gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [RFC PATCH] Proposal for a kthread tight loop based trigger.
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Tue, 01 Mar 2016 17:27:27 +0000
To: Daniel Baluta <daniel.baluta@intel.com>,
	Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	gregor.boirie@parrot.com, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Message-ID: <D7521C2F-4717-4C2F-B4FA-8852D44C01A0@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 1 March 2016 11:51:12 GMT+00:00, Daniel Baluta <daniel.baluta@intel.com> wrote:
>On Sat, Feb 27, 2016 at 2:05 PM, Jonathan Cameron <jic23@kernel.org>
>wrote:
>> Hi Gregor and all,
>>
>> This patch was motivated by a proposal from Gregor to put a kthread
>in the
>> ms5611 driver to basically spin and grap data as fast as possible.
>> I can see the application is realistic but was unhappy with the per
>driver
>> code change approach.  Hence I decided to test out another approach
>over
>> a couple of hours this morning.
>
>This is a good idea.
>
>>
>> Hence in brief the use case is:
>> 1) Read from a 'capture on demand' device as quickly as possible. 
>For tests
>> I used a max1363 on an ancient stargate2 because I have a few lying
>around and
>> it is the right sort of device.
>> 2) Do it in a fashion that allows higher priority code to slow it
>down if
>>   needed
>> 3) Allow lots of devices to run in the same fashion but without each
>one
>> having to wait for them all to finish.
>>
>> As a quick aside, configfs (or at least iio-trig-hrtimer) isn't
>working
>> on my platform right now so I'll need to follow that up when I get a
>bit more
>> time. Hence I based this off the sysfs trigger (which is an old
>friend :)
>>
>
>Which part of configfs support didn't work :).
mkdir in the hrtimer directory. Gave a useless looking stack trace. I haven't
 looked at it properly yet.
>
>> So first some background on our 'non hardware' triggers.
>>
>> 1) First there were hardware triggers or things that looked very much
>like
>>   hardware triggers (e.g. the periodic rtc driver that is on it's way
>out -
>>   finally).  These call 'real' interrupt handlers - they predated the
>>   threaded interrupts stuff so everything used to have to have a top
>half
>>   anyway to schedule the bottom half (which later became a thread)
>> 2) It made sense in some devices - dataready triggered ones typically
>- to
>>    grab timestamps and sometimes some other state in the top half.
>> 3) Threaded interrupts came along getting rid of most of the top half
>code but
>>   typically leaving some timestamping etc in there.
>> 4) Somewhere in this process we had the sysfs trigger come along as a
>really
>>    handy test tool (initially).  This first of all simply didn't run
>top halfs
>>    but later jumped through some hoops to get into interrupt context
>to call
>>    them so it looked like a hardware interrupt.  This is now nicely
>wrapped up
>>    in IRQ_WORK etc.  One major advantage of this is that we have
>multiple
>>    devices triggering off one interrupt they will run in their own
>threads.
>>
>> Anyhow so what we have here goes back to the bottom half (now thread)
>element
>> only as we can do that quick and dirty (as an aside iio_poll_chained
>is
>> really badly named - I suspect I either messed this up or the naming
>used
>> in the irq subsystem was clarified sometime later)
>>
>> So here we launch a kthread on the spin up of a buffer attached to
>this
>> trigger.  That then calls all devices poll func (thread part) in the
>thread
>> one after another.
>>
>> So what are the issues with this:
>> 1) Multiple devices connected to this trigger will not have their
>thread
>>    handlers potentially run in parallel. (do we care? - the usecase
>wouldn't
>>    put more than on on given trigger anyway)
>> 2) We have no current way of identifying if a device needs a top half
>called
>>    (say to get a timestamp).  This should be easy enough to add as a
>flag in
>>    struct iio_dev and enforce with the validate callbacks.
>> 3) For those devices that do something that doesn't need to be in the
>top half
>>    (from a not hanging point of view - if not from a get the best
>answer point
>>     of view) we have no way of knowing this or calling the top half
>if we did.
>>
>> I think the last two can be worked around (3 might be 'tricky!)
>>
>> Anyhow what do people think?
>>
>> For some numbers I ran this on a pxa270 with a max1363 hanging of the
>i2c
>> bus.  generic_buffer into a ramdisk, watershed at 64 buffer length
>128. Ran
>> happily at upwards of a kHz though with some 5msec pauses (presumably
>something
>> higher priority came along).
>>
>> Jonathan
>>
>> Jonathan Cameron (1):
>>   iio:trigger: Experimental kthread tight loop trigger (thread only)
>>
>>  drivers/iio/trigger/Kconfig         |   5 +
>>  drivers/iio/trigger/Makefile        |   1 +
>>  drivers/iio/trigger/iio-trig-loop.c | 245
>++++++++++++++++++++++++++++++++++++
>>  3 files changed, 251 insertions(+)
>>  create mode 100644 drivers/iio/trigger/iio-trig-loop.c
>>
>> --
>> 2.7.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio"
>in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
