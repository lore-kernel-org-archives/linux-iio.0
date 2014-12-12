Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47929 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967589AbaLLNEu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Dec 2014 08:04:50 -0500
Message-ID: <548AE7EF.7030108@kernel.org>
Date: Fri, 12 Dec 2014 13:04:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Octavian Purdila <octavian.purdila@intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Subject: Re: [RFC 0/8] iio: add support for hardware fifo
References: <1416246966-3083-1-git-send-email-octavian.purdila@intel.com>	<20141118132405.EF30A40277@saturn.retrosnub.co.uk>	<CAE1zotJny3-Zcd81HUYNpNZJHkt=t6e2TANzVQ=-FU239MLarw@mail.gmail.com>	<546B776F.1080800@metafoo.de>	<CAE1zotJik56OsM8-6Hg9rGqJT_VdRL0VvXv4kjEhBX6W0ijYLQ@mail.gmail.com>	<546B8084.6080400@metafoo.de>	<CAE1zotK9aR+Y7cEqZ+9rN_uiCH=kT06ZYvAdhWN_+x4b7JB4ag@mail.gmail.com> <CAE1zotKrXi0ML8X-S0GafwSTsLimCJjTB9=gF6-kuDGrRNR95A@mail.gmail.com>
In-Reply-To: <CAE1zotKrXi0ML8X-S0GafwSTsLimCJjTB9=gF6-kuDGrRNR95A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/11/14 13:32, Octavian Purdila wrote:
> On Tue, Nov 18, 2014 at 9:35 PM, Octavian Purdila
> <octavian.purdila@intel.com> wrote:
>> On Tue, Nov 18, 2014 at 7:23 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>>
>>>>>> As far as I understood, the proposed watermark implementation only
>>>>>> affects the device buffer and as I mentioned above that will not help
>>>>>> with reducing the interrupt rate.
>>>>>
>>>>>
>>>>>
>>>>> By setting the watershed level the userspace application tells you that
>>>>> it
>>>>> is OK with getting data with a higher latency than one sample. This
>>>>> allows
>>>>> the driver to configure the FIFO level and hence reduce the interrupt
>>>>> rate.
>>>>>
>>>>
>>>> Hi Lars,
>>>>
>>>> The implementation (as proposed in the patch by Josselin and Yannick)
>>>> does not inform the driver of changes to watermark, that is only
>>>> visible to core iio / buffer logic.
>>>
>>>
>>> That should be trivial to add though.
>>>
>>
>> True. I've actually started by implementing hardware fifo support as a
>> new type of iio buffer, but I got scared by the buffer demux stuff. I
>> can take another stab at it, if that sounds better?
>>
> 
> OK, I remembered why I bailed on that approach: it would break the
> callback buffer. It looks like the buffer cb infrastructure relies on
> a push model and for a hardware fifo implemented as a iio buffer we
> would need a pull model. While there is one driver that takes this
> approach (sca3000_ring.c) it is in staging and the hardware buffer
> part seems to be marked as RFC.
Yup.  The sca3000 indeed breaks the cb buffer stuff.  The approach
of bouncing through a software buffer is definitely now the preferred
option.  The SCA3000 driver is old, very old...  Needs a rewrite
(which is why it is still in staging).  
> 
> BTW, I didn't find any users for the buffer cb infrastructure, what is
> it used for?
Ah, this was meant to be used for things like the iio input bridge.
That is to pass 'push' data on to other kernel drivers.  I never finished
up the iio input bridge (was nearly there) due to other stuff getting
in the way and no one else has taken up my suggestions to take it on...
It was always something that was demanded by users, but never enough
that anyone actually took it over.

Ultimately the idea was also to be able to cleanly separate the IIO userspace
interface from the back end. This was just one step along the way.
The point where we can have an iio driver that is a consumer of an iio driver
and provides all the same functionality is the point where we can cleanly
separate these parts.   If we were starting again I think we'd aim for
this separation from the start.  Ah well.

Note that for the full set of in kernel user interfaces we also
need to do the events interface at some point.
