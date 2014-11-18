Return-Path: <octavian.purdila@intel.com>
MIME-Version: 1.0
In-Reply-To: <546B8084.6080400@metafoo.de>
References: <1416246966-3083-1-git-send-email-octavian.purdila@intel.com>
	<20141118132405.EF30A40277@saturn.retrosnub.co.uk>
	<CAE1zotJny3-Zcd81HUYNpNZJHkt=t6e2TANzVQ=-FU239MLarw@mail.gmail.com>
	<546B776F.1080800@metafoo.de>
	<CAE1zotJik56OsM8-6Hg9rGqJT_VdRL0VvXv4kjEhBX6W0ijYLQ@mail.gmail.com>
	<546B8084.6080400@metafoo.de>
Date: Tue, 18 Nov 2014 21:35:42 +0200
Message-ID: <CAE1zotK9aR+Y7cEqZ+9rN_uiCH=kT06ZYvAdhWN_+x4b7JB4ag@mail.gmail.com>
Subject: Re: [RFC 0/8] iio: add support for hardware fifo
From: Octavian Purdila <octavian.purdila@intel.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Nov 18, 2014 at 7:23 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:

>>>> As far as I understood, the proposed watermark implementation only
>>>> affects the device buffer and as I mentioned above that will not help
>>>> with reducing the interrupt rate.
>>>
>>>
>>>
>>> By setting the watershed level the userspace application tells you that
>>> it
>>> is OK with getting data with a higher latency than one sample. This
>>> allows
>>> the driver to configure the FIFO level and hence reduce the interrupt
>>> rate.
>>>
>>
>> Hi Lars,
>>
>> The implementation (as proposed in the patch by Josselin and Yannick)
>> does not inform the driver of changes to watermark, that is only
>> visible to core iio / buffer logic.
>
>
> That should be trivial to add though.
>

True. I've actually started by implementing hardware fifo support as a
new type of iio buffer, but I got scared by the buffer demux stuff. I
can take another stab at it, if that sounds better?

>>
>> Also, the watermark alone is not enough to properly support hardware
>> fifos: the fifo can operate in multiple modes, we need to read data
>> from the hardware fifo even when the watermark interrupt is not issued
>> (the flush operation in the current patch set).
>
>
> What kind of modes are there?
>

Stream - new values overwrrite old values, Fifo - drop new values.
