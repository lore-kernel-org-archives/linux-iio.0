Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47981 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967589AbaLLNKN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Dec 2014 08:10:13 -0500
Message-ID: <548AE932.8030306@kernel.org>
Date: Fri, 12 Dec 2014 13:10:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Octavian Purdila <octavian.purdila@intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Subject: Re: [RFC 0/8] iio: add support for hardware fifo
References: <1416246966-3083-1-git-send-email-octavian.purdila@intel.com>	<20141118132405.EF30A40277@saturn.retrosnub.co.uk>	<CAE1zotJny3-Zcd81HUYNpNZJHkt=t6e2TANzVQ=-FU239MLarw@mail.gmail.com>	<546B776F.1080800@metafoo.de>	<CAE1zotJik56OsM8-6Hg9rGqJT_VdRL0VvXv4kjEhBX6W0ijYLQ@mail.gmail.com>	<546B8084.6080400@metafoo.de>	<CAE1zotK9aR+Y7cEqZ+9rN_uiCH=kT06ZYvAdhWN_+x4b7JB4ag@mail.gmail.com>	<CAE1zotKrXi0ML8X-S0GafwSTsLimCJjTB9=gF6-kuDGrRNR95A@mail.gmail.com>	<CAE1zot+dMLcuhsP1SA9akZWaPpuDqXTJw3WrZRP+n_=fxuUOaQ@mail.gmail.com>	<547CDB74.7020300@metafoo.de> <CAE1zotJZ+5Jq3v7qU67FdTDBJnz4wx4+A7swkvpayE63bUv+MA@mail.gmail.com>
In-Reply-To: <CAE1zotJZ+5Jq3v7qU67FdTDBJnz4wx4+A7swkvpayE63bUv+MA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/12/14 09:13, Octavian Purdila wrote:
> On Mon, Dec 1, 2014 at 11:19 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> On 11/26/2014 02:06 PM, Octavian Purdila wrote:
>>>
>>> On Wed, Nov 19, 2014 at 3:32 PM, Octavian Purdila
>>> <octavian.purdila@intel.com> wrote:
>>>>
>>>> On Tue, Nov 18, 2014 at 9:35 PM, Octavian Purdila
>>>> <octavian.purdila@intel.com> wrote:
>>>>>
>>>>> On Tue, Nov 18, 2014 at 7:23 PM, Lars-Peter Clausen <lars@metafoo.de>
>>>>> wrote:
>>>>>
>>>>>>>>> As far as I understood, the proposed watermark implementation only
>>>>>>>>> affects the device buffer and as I mentioned above that will not
>>>>>>>>> help
>>>>>>>>> with reducing the interrupt rate.
>>>>>>>>
>>>>>>>>
>>>>>>>> By setting the watershed level the userspace application tells you
>>>>>>>> that
>>>>>>>> it
>>>>>>>> is OK with getting data with a higher latency than one sample. This
>>>>>>>> allows
>>>>>>>> the driver to configure the FIFO level and hence reduce the interrupt
>>>>>>>> rate.
>>>>>>>
>>>>>>>
>>>>>>> Hi Lars,
>>>>>>>
>>>>>>> The implementation (as proposed in the patch by Josselin and Yannick)
>>>>>>> does not inform the driver of changes to watermark, that is only
>>>>>>> visible to core iio / buffer logic.
>>>>>>
>>>>>>
>>>>>> That should be trivial to add though.
>>>>>
>>>>>
>>>>> True. I've actually started by implementing hardware fifo support as a
>>>>> new type of iio buffer, but I got scared by the buffer demux stuff. I
>>>>> can take another stab at it, if that sounds better?
>>>>>
>>>> OK, I remembered why I bailed on that approach: it would break the
>>>> callback buffer. It looks like the buffer cb infrastructure relies on
>>>> a push model and for a hardware fifo implemented as a iio buffer we
>>>> would need a pull model. While there is one driver that takes this
>>>> approach (sca3000_ring.c) it is in staging and the hardware buffer
>>>> part seems to be marked as RFC.
>>>>
>>>
>>> Hi again,
>>>
>>> I want to revive this thread to help us start moving in the right
>>> direction. Here is a summary of things discuss so far:
>>>
>>> 1. The watermark patch from Josselin and Yannick does not allow
>>> reducing the interrupt rate because watermark is not propagated to the
>>> driver level. It lacks setting the fifo mode (which is important for
>>> Android use-cases). Also, we either need the timeout parameter or an
>>> explicit flush trigger.
>>>
>>> 2. There are two approaches to implement hardware buffering:
>>>
>>> a) The one exemplified in the current patch set, where we have
>>> hardware buffers and based on interrupt or software trigger we push
>>> data to device buffers. I'm going to call this the push model.
>>>
>>> b) Implementing the hardware buffer as an iio buffer. That basically
>>> means having the driver implement the read_first_n to read data
>>> directly from the hardware buffer. I am going to call this the pull
>>> model.
>>>
>>> Although the pull model seems more natural it has some disadvantages:
>>> it breaks the callback buffers (which do not seem to be used though),
>>> it breaks in the case where we have a single hardware buffer but we
>>> server multiple iio devices (sensor hub).
>>>
>>> The push model has the disadvantage that we are using double buffering
>>> and that we need to match the software and hardware fifo policies.
>>>
>>> So, to move forward, I would like to build consensus on what is the
>>> preferred model: push or pull?
>>
>>
>> The two models have completely different semantics and which is the
>> preferred probably depends on the use case and not necessarily on the device
>> itself.
> 
> I agree.
> 
>> Right now for IIO the buffered access uses a push approach and the
>> sysfs access uses a pull approach. Although when using sysfs there is no
>> buffering and is supposed to always fetch the latest conversion (Which is
>> what the BCM150 seems to call bypass mode).
>>
>> There might be a need to add support for switching between the two different
>> modes depending on the userspace use-case. But to be honest I can't see how
>> a pure pull based approach would be that use full.
>>
> 
> Yes, a pull based approach will either force userspace to poll - which
> defeats the purpose of hardware buffering, or will increase the
> latency as userspace will have to wait for a fifo full/watermark event
> then read.
> 
>> Maybe hybrid is the way to go with the kernel driver moving samples from the
>> hardware buffer to the software buffer if the hardware buffer gets to full.
>> But at the same time allow userspace to read directly from the hardware
>> buffer if there are no more samples in the software buffer.
>>
> 
> I tried something similar in one of the earlier approaches: force a
> fifo flush in iio_buffer_read_first_n_outer(). This will allow us to
> get rid of the timeout parameter or the sysfs fifo flush entry as it
> allows userspace to generate a fifo flush just by reading. Userspace
> can wait for the fifo watermark/full and if that timeouts it can force
> a read. I think this approach also cuts down some overhead.
> 
> I can rework this patchset as above if it sounds reasonable to you.
I should have read the whole thread before replying earlier (was too big :)
Anyhow, this is pretty much what I was suggesting earlier as well.
Obviously only force the flush if there isn't already enough data in the
front end buffer.

This should work fine even if we have multiple buffers (e.g. buffer_cb)
as if any of them force a read, the others will just get data earlier
than otherwise.  Note with the watershed stuff, note that the the one
relevant to the hardware will be that of whichever buffer has requested
the shortest.  We after all have to meet the strictest demand on latency.

Anyhow this sounds like the right direction to take to me.

Sorry for the slow reply!

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

