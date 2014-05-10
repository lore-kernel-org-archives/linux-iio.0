Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45108 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754716AbaEJKsz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 10 May 2014 06:48:55 -0400
Message-ID: <536E0479.2080105@kernel.org>
Date: Sat, 10 May 2014 11:50:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: hardware buffer enabling
References: <53691420.8060503@linux.intel.com> <536A9183.4090304@kernel.org> <536BAE29.7090401@linux.intel.com>
In-Reply-To: <536BAE29.7090401@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/05/14 17:17, Srinivas Pandruvada wrote:
> On 05/07/2014 01:03 PM, Jonathan Cameron wrote:
>>
>>
>> On May 6, 2014 5:56:00 PM GMT+01:00, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
>>> Hi Jonathan,
>>>
>>> The Android user space has some capability to ask the supported
>>> hardware
>>> to enable buffering in hardware.
>>> I don't think that we can achieve this by current ABI.  Do you want me
>>> to propose new ABI?
>> This is closely related to watershed events on buffers, both software and hardware.  We
>> had these back in the early days but the interface was fiddly. It used a couple of iio
>> events to tell user space the watershed was passed.
>>
>> One suggestion from Arnd Bergmann was to use one of the less commonly used poll
>> types to indicate this to user space. It was in a long system wide review he did not long
>> after we entered staging.  Looked like a neat idea as could coexist nicely with existing
>> interfaces on the same buffer. Would definitely require a fair bit of documentation.
>> Thread in question is around about:
>> https://lkml.org/lkml/2011/3/16/190
>>
>>
>> Also note we already have hardware buffered devices pushing into software
>> buffers (without a trigger) which effectively handle the same use case using existing interfaces.
>> See the ti_am335x_adc driver.
>>
>> There is definitely room for something more controllable but it shouldn't be too focused
>> on hardware buffering as makes sense for software buffers too!
>>
>> So to take a stab in the air we need some means of setting the watershed level
>> (and a callback to pass this on to the hardware if that makes sense).
> I think so. We need a watermark level and an event. We can use poll flags to allow prioritized event.
Yes.  That is pretty much it.
>> The fiddly cases are going to be the corner cases such as when the length changes.
>>
>> what do you think?
>>>
>>> "
>>> Android batch mode:
>>> batch(int handle, int flags, int64_t period_ns, int64_t
>>> max_report_latency)
>>>
>>> Enabling batch mode for a given sensor sets the delay between events.
>>> max_report_latency sets the maximum time by which events can be delayed
>>>
>>> and batched together before being reported to the applications. A value
>>>
>>> of zero disables batch mode for the given sensor. The period_ns
>>> parameter is equivalent to calling setDelay() -- this function both
>>> enables or disables the batch mode AND sets the event's period in
>>> nanoseconds. See setDelay() for a detailed explanation of the period_ns
>>>
>>> parameter.
>>
>> Hmm. Max latency would just be a timeout on the poll. Period is a trigger characteristic
>>  or a hardware one if no explicit trigger is present.
>>
> Correct. But this value can be used to infer the watermark level.
True enough.  That can be done in userspace though rather than necessarily
in the kernel interface.
>> There is clearly ad
>>>
>>> In non-batch mode, all sensor events must be reported as soon as they
>>> are detected. For example, an accelerometer activated at 50Hz will
>>> trigger interrupts 50 times per second.
>>> While in batch mode, sensor events do not need to be reported as soon
>>> as
>>> they are detected. They can be temporarily stored and reported in
>>> batches, as long as no event is delayed by more than
>>> maxReportingLatency
>>> nanoseconds. That is, all events since the previous batch are recorded
>>> and returned at once. This reduces the amount of interrupts sent to the
>>>
>>> SoC and allows the SoC to switch to a lower power mode (idle) while the
>>>
>>> sensor is capturing and batching data.
>>>
>>> setDelay() is not affected and it behaves as usual.
>>>
>>> Each event has a timestamp associated with it. The timestamp must be
>>> accurate and correspond to the time at which the event physically
>>> happened.
>>>
>>> Batching does not modify the behavior of poll(): batches from different
>>>
>>> sensors can be interleaved and split. As usual, all events from the
>>> same
>>> sensor are time-ordered.
>>> "
> I will do some experiments with one device which I will get with a large Fifo.
>
Cool. There quite a few simple ADCs that support up to 16 element buffers but
we have never put any effort into supporting this.  Will be interesting to see
if there are advantages in that case as well.

Looking forward to seeing how you get on with this.  There was a small
surge in devices with reasonable sized buffers about 4 years ago, then they
disappeared, but seem to be making a come back.  Also odd cases such as the
vibration sensors that we could handle better.  These tend to use some
threshold type event to trigger very high rate sampling for a short period.

Anyhow, lots of things to consider!  Good luck.
  
> Thanks,
> Srinivas
>>>
>>>
>>> Thanks,
>>> Srinivas
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

