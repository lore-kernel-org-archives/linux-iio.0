Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:48664 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754005AbaKRRE7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 18 Nov 2014 12:04:59 -0500
Received: by mail-wi0-f173.google.com with SMTP id r20so2578055wiv.12
        for <linux-iio@vger.kernel.org>; Tue, 18 Nov 2014 09:04:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <546B776F.1080800@metafoo.de>
References: <1416246966-3083-1-git-send-email-octavian.purdila@intel.com>
	<20141118132405.EF30A40277@saturn.retrosnub.co.uk>
	<CAE1zotJny3-Zcd81HUYNpNZJHkt=t6e2TANzVQ=-FU239MLarw@mail.gmail.com>
	<546B776F.1080800@metafoo.de>
Date: Tue, 18 Nov 2014 19:04:57 +0200
Message-ID: <CAE1zotJik56OsM8-6Hg9rGqJT_VdRL0VvXv4kjEhBX6W0ijYLQ@mail.gmail.com>
Subject: Re: [RFC 0/8] iio: add support for hardware fifo
From: Octavian Purdila <octavian.purdila@intel.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Nov 18, 2014 at 6:44 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 11/18/2014 04:03 PM, Octavian Purdila wrote:
>>
>> On Tue, Nov 18, 2014 at 3:24 PM, <jic23@kernel.org> wrote:
>
> [...]
>>>
>>> Hence we started with something that at least superficially (I haven't
>>> had a chance to go through the implementation in detail yet)
>>> looks similar to what you have but ended up changing the method of
>>> signalling to and from userspace.
>>> Hardware buffer -> Software buffer -> user space.
>>> Userspace watershed control -> Software buffer watershed control
>>> -> Hardware buffer watershed control.
>>> If userspace sets the watershed to say 16 then, as well as setting
>>> that level in the software buffer it should be passed on to the
>>> device driver allowing the watershed there to be set appropriately.
>>> Now things get interesting if userspace sets the watershed to a value
>>> that makes no sense for the hardware (say 17 on a device that does
>>> power of 2 values only) as then it will have to fall back to
>>> grabbing every one (Watershed of 1).  Perhaps we can provide 'hints'
>>> for this?
>>
>>
>> As far as I understood, the proposed watermark implementation only
>> affects the device buffer and as I mentioned above that will not help
>> with reducing the interrupt rate.
>
>
> By setting the watershed level the userspace application tells you that it
> is OK with getting data with a higher latency than one sample. This allows
> the driver to configure the FIFO level and hence reduce the interrupt rate.
>

Hi Lars,

The implementation (as proposed in the patch by Josselin and Yannick)
does not inform the driver of changes to watermark, that is only
visible to core iio / buffer logic.

Also, the watermark alone is not enough to properly support hardware
fifos: the fifo can operate in multiple modes, we need to read data
from the hardware fifo even when the watermark interrupt is not issued
(the flush operation in the current patch set).
