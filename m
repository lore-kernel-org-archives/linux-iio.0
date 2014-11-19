Return-Path: <octavian.purdila@intel.com>
MIME-Version: 1.0
In-Reply-To: <CAE1zotK9aR+Y7cEqZ+9rN_uiCH=kT06ZYvAdhWN_+x4b7JB4ag@mail.gmail.com>
References: <1416246966-3083-1-git-send-email-octavian.purdila@intel.com>
	<20141118132405.EF30A40277@saturn.retrosnub.co.uk>
	<CAE1zotJny3-Zcd81HUYNpNZJHkt=t6e2TANzVQ=-FU239MLarw@mail.gmail.com>
	<546B776F.1080800@metafoo.de>
	<CAE1zotJik56OsM8-6Hg9rGqJT_VdRL0VvXv4kjEhBX6W0ijYLQ@mail.gmail.com>
	<546B8084.6080400@metafoo.de>
	<CAE1zotK9aR+Y7cEqZ+9rN_uiCH=kT06ZYvAdhWN_+x4b7JB4ag@mail.gmail.com>
Date: Wed, 19 Nov 2014 15:32:40 +0200
Message-ID: <CAE1zotKrXi0ML8X-S0GafwSTsLimCJjTB9=gF6-kuDGrRNR95A@mail.gmail.com>
Subject: Re: [RFC 0/8] iio: add support for hardware fifo
From: Octavian Purdila <octavian.purdila@intel.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Nov 18, 2014 at 9:35 PM, Octavian Purdila
<octavian.purdila@intel.com> wrote:
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

OK, I remembered why I bailed on that approach: it would break the
callback buffer. It looks like the buffer cb infrastructure relies on
a push model and for a hardware fifo implemented as a iio buffer we
would need a pull model. While there is one driver that takes this
approach (sca3000_ring.c) it is in staging and the hardware buffer
part seems to be marked as RFC.

BTW, I didn't find any users for the buffer cb infrastructure, what is
it used for?
