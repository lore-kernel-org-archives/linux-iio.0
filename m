Return-Path: <lars@metafoo.de>
Message-ID: <546C8375.9040705@metafoo.de>
Date: Wed, 19 Nov 2014 12:48:05 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Octavian Purdila <octavian.purdila@intel.com>
CC: jic23@kernel.org, linux-iio@vger.kernel.org,
 Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Subject: Re: [RFC 0/8] iio: add support for hardware fifo
References: <1416246966-3083-1-git-send-email-octavian.purdila@intel.com>	<20141118132405.EF30A40277@saturn.retrosnub.co.uk>	<CAE1zotJny3-Zcd81HUYNpNZJHkt=t6e2TANzVQ=-FU239MLarw@mail.gmail.com>	<546B776F.1080800@metafoo.de>	<CAE1zotJik56OsM8-6Hg9rGqJT_VdRL0VvXv4kjEhBX6W0ijYLQ@mail.gmail.com>	<546B8084.6080400@metafoo.de> <CAE1zotK9aR+Y7cEqZ+9rN_uiCH=kT06ZYvAdhWN_+x4b7JB4ag@mail.gmail.com>
In-Reply-To: <CAE1zotK9aR+Y7cEqZ+9rN_uiCH=kT06ZYvAdhWN_+x4b7JB4ag@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 11/18/2014 08:35 PM, Octavian Purdila wrote:
> On Tue, Nov 18, 2014 at 7:23 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>
>>>>> As far as I understood, the proposed watermark implementation only
>>>>> affects the device buffer and as I mentioned above that will not help
>>>>> with reducing the interrupt rate.
>>>>
>>>>
>>>>
>>>> By setting the watershed level the userspace application tells you that
>>>> it
>>>> is OK with getting data with a higher latency than one sample. This
>>>> allows
>>>> the driver to configure the FIFO level and hence reduce the interrupt
>>>> rate.
>>>>
>>>
>>> Hi Lars,
>>>
>>> The implementation (as proposed in the patch by Josselin and Yannick)
>>> does not inform the driver of changes to watermark, that is only
>>> visible to core iio / buffer logic.
>>
>>
>> That should be trivial to add though.
>>
>
> True. I've actually started by implementing hardware fifo support as a
> new type of iio buffer, but I got scared by the buffer demux stuff. I
> can take another stab at it, if that sounds better?
>
>>>
>>> Also, the watermark alone is not enough to properly support hardware
>>> fifos: the fifo can operate in multiple modes, we need to read data
>>> from the hardware fifo even when the watermark interrupt is not issued
>>> (the flush operation in the current patch set).
>>
>>
>> What kind of modes are there?
>>
>
> Stream - new values overwrrite old values, Fifo - drop new values.

So basically ring buffer) style (old samples are dropped and FIFO style (new 
samples are dropped). This mode should probably be aligned with the mode 
that the sw buffer is working. E.g. you wouldn't want the software buffer to 
work in FIFO mode and the hardware buffer in ring buffer mode. That would 
lead to weird effects.

We talked about adding support for ring buffer mode to the software buffer a 
while ago, but so far nobody really needed it so it hasn't been implemented yet.

- Lars
