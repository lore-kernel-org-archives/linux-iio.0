Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59521 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbbCUMSG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2015 08:18:06 -0400
Message-ID: <550D617C.3070609@kernel.org>
Date: Sat, 21 Mar 2015 12:18:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Octavian Purdila <octavian.purdila@intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v5 2/3] iio: add support for hardware fifo
References: <1425491773-28499-1-git-send-email-octavian.purdila@intel.com>	<1425491773-28499-3-git-send-email-octavian.purdila@intel.com>	<550967B5.7000100@metafoo.de> <CAE1zotLLpRFNsQ1h1_set2MXTo2o0zeq1JrNif+vbSojjSR+aw@mail.gmail.com>
In-Reply-To: <CAE1zotLLpRFNsQ1h1_set2MXTo2o0zeq1JrNif+vbSojjSR+aw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/03/15 16:47, Octavian Purdila wrote:
> On Wed, Mar 18, 2015 at 1:55 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>>
>> On 03/04/2015 06:56 PM, Octavian Purdila wrote:
>>>
>>> [...]
>>>
>>>   Documentation/ABI/testing/sysfs-bus-iio | 25 ++++++++++++
>>>   drivers/iio/industrialio-buffer.c       | 69 +++++++++++++++++++++++++++------
>>>   include/linux/iio/iio.h                 | 26 +++++++++++++
>>>   3 files changed, 108 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
>>> index 1283ca7..143ddf2d 100644
>>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>>> @@ -1264,3 +1264,28 @@ Description:
>>>                 allows the application to block on poll with a timeout and read
>>>                 the available samples after the timeout expires and thus have a
>>>                 maximum delay guarantee.
>>> +
>>> +What:          /sys/bus/iio/devices/iio:deviceX/buffer/hwfifo_watermark
>>> +KernelVersion: 3.21
>>> +Contact:       linux-iio@vger.kernel.org
>>> +Description:
>>> +              Read-only entry that contains a single integer specifying the
>>> +              current level for the hardware fifo watermark level. If this
>>> +              value is negative it means that the device does not support a
>>> +              hardware fifo. If this value is 0 it means that the hardware fifo
>>> +              is currently disabled.
>>> +              If this value is strictly positive it signals that the hardware
>>> +              fifo of the device is active and that samples are stored in an
>>> +              internal hardware buffer. When the level of the hardware fifo
>>> +              reaches the watermark level the device will flush its internal
>>> +              buffer to the device buffer. Because of this a trigger is not
>>> +              needed to use the device in buffer mode.
>>> +              The hardware watermark level is set by the driver based on the
>>> +              value set by the user in buffer/watermark but taking into account
>>> +              the limitations of the hardware (e.g. most hardware buffers are
>>> +              limited to 32-64 samples).
>>> +              Because the sematics of triggers and hardware fifo may be
>>
>>
>> semantics
> 
> Ack.
> 
>>
>>> +              different (e.g. the hadware fifo may record samples according to
>>> +              the sample rate while an any-motion trigger generates samples
>>> +              based on the set rate of change) setting a trigger may disable
>>> +              the hardware fifo.
>>
>>
>> I still don't understand why the hardware fifo level is something the userspace application needs to set. And how would the application decide which level it wants?
> 
> This entry is read-only, it is not set by the user.  The user sets
> buffer/watermark then the driver sets the hardware fifo watermark and
> that is visible here.
> 
> Please also see my last proposals in the response I've sent to Jonathan:
> 
> * add a hwfifo_watermark_min to let the application know what
> watermark level it needs to set so that hardware fifo can be enabled
> 
> * add a hwfifo_watermark_max entry - required by Android batch mode
> (see sensor_t.fifoMaxEventCount at [1]); it should be useful to
> compute a watermark value that avoids overflowing the hardware fifo
> 
> * add a hwfifo_active entry - makes it easy to know if the hardware
> fifo is active or not
> 
> [1] https://source.android.com/devices/sensors/batching.html
> 
>>
>>
>> [...]
>>
>>>   int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>>> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
>>> index 80d8550..1b1cd7d 100644
>>> --- a/include/linux/iio/iio.h
>>> +++ b/include/linux/iio/iio.h
>>> @@ -338,6 +338,29 @@ struct iio_dev;
>>>    *                    provide a custom of_xlate function that reads the
>>>    *                    *args* and returns the appropriate index in registered
>>>    *                    IIO channels array.
>>> + * @hwfifo_set_watermark: function pointer to set the current hardware fifo
>>> + *                     watermark level. It receives the desired watermark as a
>>> + *                     hint and the device driver may adjust it to take into
>>> + *                     account hardware limitations. Setting the watermark to a
>>> + *                     strictly positive value should enable the hardware fifo
>>> + *                     if not already enabled. When the hardware fifo is
>>> + *                     enabled and its level reaches the watermark level the
>>> + *                     device must flush the samples stored in the hardware
>>> + *                     fifo to the device buffer. Setting the watermark to 0
>>> + *                     should disable the hardware fifo. The device driver must
>>> + *                     disable the hardware fifo when a trigger with different
>>> + *                     sampling semantic (then the hardware fifo) is set
>>> + *                     (e.g. when setting an any-motion trigger to a device
>>> + *                     that has its hardware fifo sample based on the set
>>> + *                     sample frequency).
>>> + * @hwfifo_get_watermark: function pointer to obtain the current hardware fifo
>>> + *                     watermark level
>>> + * @hwfifo_flush:      function pointer to flush the samples stored in the
>>
>>
>> This might just be me, but I associate flushing a FIFO with discarding the data. Our previous discussions make a lot more sense now :)
>>
>>
> 
> I see :) I've used the terminology from the processor cache where
> flush is used to "save" the cache line to memory and invalidate to
> discard it.
Howabout avoiding future confusion and renaming as
hwfifo_flush_to_swbuffer or something that that?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

