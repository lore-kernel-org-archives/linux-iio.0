Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:48385 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab1LFRF2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 6 Dec 2011 12:05:28 -0500
References: <1323121036-21094-1-git-send-email-jic23@kernel.org> <4EDE3738.70704@free-electrons.com> <4EDE39F1.9090408@metafoo.de>
In-Reply-To: <4EDE39F1.9090408@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH V3 0/7] Add scan demux unit and use it in max1363
From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Tue, 06 Dec 2011 17:05:17 +0000
To: Lars-Peter Clausen <lars@metafoo.de>,
	Maxime Ripard <maxime.ripard@free-electrons.com>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Message-ID: <9d02e5f5-0297-4dc4-bb04-000b175aa992@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



Lars-Peter Clausen <lars@metafoo.de> wrote:

>On 12/06/2011 04:39 PM, Maxime Ripard wrote:
>> Hi Jonathan,
>> 
>> I can't seem to find a proper way to apply this patchset. On what
>> patchset is it based ?
>> 
>> I'm still here with what seems to be a rather old version of your
>tree
>> (3413ec), but it is still the head of your git tree on kernel.org.
>> 
>> Thanks,
>> Maxime
>
>It should apply to staging/staging-next
Sorry. This is all queued up locally. I just forgot to push last night! LarsPeter is also correct as my master branch is just staging-next plus stuff that has gone to Greg.
>
>> 
>> On 05/12/2011 22:37, Jonathan Cameron wrote:
>>> Hi Greg,
>>>
>>> The v3 here is just to indicate a tiny change suggested by
>>> Lars-Peter from the version that has been out for review on
>>> linux-iio. (Using ALIGN instead of hand rolling in one case
>>> in patch 4).  Anyhow, not worth putting out for another review
>>> as Lars-Peter has tested and acked without it anyway.
>>>
>>> Technically Lars-Peter only acked patches 4 and 5 but they
>>> are the important ones (the others being trivial or tied
>>> up with the max1363 driver which is one of mine..)
>>>
>>> This set introduces the an optional demultiplexer into the
>>> path of data form devices to buffers.  It is a necessary step
>>> on the path to in kernel push interfaces (trigger driven ones).
>>> Also rather useful on it's own as shown by the max1363 patches
>>> and some uses Lars-Peter has made of it in another series.
>>>
>>> Anyhow fair bit more to come so time to send these on to you!
>>>
>>> Thanks,
>>>
>>> Jonathan
>>>
>>> v2 text:
>>> Hi All,
>>>
>>> New version of this series.  Two changes as per Lars-Peter's
>>> suggestions.  ALIGN macro usage in patch 4 and one of the two
>>> for each bit set suggestions.  The second is subtly different
>>> as it is finding bits after a certain point rather than from
>>> the start.
>>>
>>> As explained in patch 5 discussion, I personally feel that
>>> the demux should occur prior to the buffer and avoiding the
>>> extra copy should be done by allowing buffers to provide
>>> callbacks for reserving (plus getting access to) space and
>>> notifying that they are done filling it.   Either way, now
>>> is not the time to do this change. Too much else going on!
>>>
>>> v1 text:
>>> The last patch technically is a simple bug fix, but included here as
>>> it came up during testing of this series.
>>>
>>> The 'interesting' bits are the rewrite of iio_sw_buffer_preenable.
>I'd like
>>> people with drivers currently using that function to test and see
>what
>>> I have broken.  We should also be able to drop a number of cases in
>specific
>>> drivers in favour of this version.
>>>
>>> The demux unit is designed to offer a straight path with little or
>no
>>> overhead if the client (here still the IIO buffer) needs all the
>data and to
>>> only get in the way when a subset of the active scan mask is
>requested.
>>>
>>> I may well have messed this up so please please test this set.
>>>
>>>
>>> Jonathan Cameron (7):
>>>   staging:iio:find iio channel from scan index util function
>>>   staging:iio:buffer add a cache of the timestamp scan index.
>>>   staging:iio: add hook to allow core to perform scan related
>config.
>>>   staging:iio: make iio_sw_buffer_preenable much more general.
>>>   staging:iio: add demux optionally to path from device to buffer
>>>   staging:iio:adc:max1363 use new demuxing support.
>>>   staging:iio:adc:max1363 correctly set channels as big endian.
>>>
>>>  drivers/staging/iio/adc/max1363.h         |   11 ++-
>>>  drivers/staging/iio/adc/max1363_core.c    |   18 ++-
>>>  drivers/staging/iio/adc/max1363_ring.c    |   51 ++-----
>>>  drivers/staging/iio/buffer.h              |   16 ++
>>>  drivers/staging/iio/iio.h                 |   13 ++-
>>>  drivers/staging/iio/industrialio-buffer.c |  212
>+++++++++++++++++++++++++----
>>>  drivers/staging/iio/industrialio-core.c   |   11 ++
>>>  7 files changed, 259 insertions(+), 73 deletions(-)
>>>
>> 
>> 
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android phone 
with K-9 Mail. Please excuse my brevity.
