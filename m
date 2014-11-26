Return-Path: <octavian.purdila@intel.com>
MIME-Version: 1.0
In-Reply-To: <CAE1zotKrXi0ML8X-S0GafwSTsLimCJjTB9=gF6-kuDGrRNR95A@mail.gmail.com>
References: <1416246966-3083-1-git-send-email-octavian.purdila@intel.com>
	<20141118132405.EF30A40277@saturn.retrosnub.co.uk>
	<CAE1zotJny3-Zcd81HUYNpNZJHkt=t6e2TANzVQ=-FU239MLarw@mail.gmail.com>
	<546B776F.1080800@metafoo.de>
	<CAE1zotJik56OsM8-6Hg9rGqJT_VdRL0VvXv4kjEhBX6W0ijYLQ@mail.gmail.com>
	<546B8084.6080400@metafoo.de>
	<CAE1zotK9aR+Y7cEqZ+9rN_uiCH=kT06ZYvAdhWN_+x4b7JB4ag@mail.gmail.com>
	<CAE1zotKrXi0ML8X-S0GafwSTsLimCJjTB9=gF6-kuDGrRNR95A@mail.gmail.com>
Date: Wed, 26 Nov 2014 15:06:14 +0200
Message-ID: <CAE1zot+dMLcuhsP1SA9akZWaPpuDqXTJw3WrZRP+n_=fxuUOaQ@mail.gmail.com>
Subject: Re: [RFC 0/8] iio: add support for hardware fifo
From: Octavian Purdila <octavian.purdila@intel.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Nov 19, 2014 at 3:32 PM, Octavian Purdila
<octavian.purdila@intel.com> wrote:
> On Tue, Nov 18, 2014 at 9:35 PM, Octavian Purdila
> <octavian.purdila@intel.com> wrote:
>> On Tue, Nov 18, 2014 at 7:23 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>>
>>>>>> As far as I understood, the proposed watermark implementation only
>>>>>> affects the device buffer and as I mentioned above that will not help
>>>>>> with reducing the interrupt rate.
>>>>>
>>>>> By setting the watershed level the userspace application tells you that
>>>>> it
>>>>> is OK with getting data with a higher latency than one sample. This
>>>>> allows
>>>>> the driver to configure the FIFO level and hence reduce the interrupt
>>>>> rate.
>>>>
>>>> Hi Lars,
>>>>
>>>> The implementation (as proposed in the patch by Josselin and Yannick)
>>>> does not inform the driver of changes to watermark, that is only
>>>> visible to core iio / buffer logic.
>>>
>>> That should be trivial to add though.
>>
>> True. I've actually started by implementing hardware fifo support as a
>> new type of iio buffer, but I got scared by the buffer demux stuff. I
>> can take another stab at it, if that sounds better?
>>
> OK, I remembered why I bailed on that approach: it would break the
> callback buffer. It looks like the buffer cb infrastructure relies on
> a push model and for a hardware fifo implemented as a iio buffer we
> would need a pull model. While there is one driver that takes this
> approach (sca3000_ring.c) it is in staging and the hardware buffer
> part seems to be marked as RFC.
>

Hi again,

I want to revive this thread to help us start moving in the right
direction. Here is a summary of things discuss so far:

1. The watermark patch from Josselin and Yannick does not allow
reducing the interrupt rate because watermark is not propagated to the
driver level. It lacks setting the fifo mode (which is important for
Android use-cases). Also, we either need the timeout parameter or an
explicit flush trigger.

2. There are two approaches to implement hardware buffering:

a) The one exemplified in the current patch set, where we have
hardware buffers and based on interrupt or software trigger we push
data to device buffers. I'm going to call this the push model.

b) Implementing the hardware buffer as an iio buffer. That basically
means having the driver implement the read_first_n to read data
directly from the hardware buffer. I am going to call this the pull
model.

Although the pull model seems more natural it has some disadvantages:
it breaks the callback buffers (which do not seem to be used though),
it breaks in the case where we have a single hardware buffer but we
server multiple iio devices (sensor hub).

The push model has the disadvantage that we are using double buffering
and that we need to match the software and hardware fifo policies.

So, to move forward, I would like to build consensus on what is the
preferred model: push or pull?

Thanks,
Tavi
