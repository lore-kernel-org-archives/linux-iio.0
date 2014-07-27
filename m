Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:54887 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752350AbaG0Qmx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 27 Jul 2014 12:42:53 -0400
Message-ID: <53D52C9C.9030201@kernel.org>
Date: Sun, 27 Jul 2014 17:45:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org, Denis CIOCCA <denis.ciocca@st.com>
Subject: Re: [PATCH 2/4] iio: buffer: Use roundup() instead of ALIGN()
References: <1405612789-27964-1-git-send-email-lars@metafoo.de> <1405612789-27964-2-git-send-email-lars@metafoo.de> <53CBDB85.10405@kernel.org> <53CCD34B.10807@metafoo.de>
In-Reply-To: <53CCD34B.10807@metafoo.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/07/14 09:46, Lars-Peter Clausen wrote:
> On 07/20/2014 05:08 PM, Jonathan Cameron wrote:
>> On 17/07/14 16:59, Lars-Peter Clausen wrote:
>>> ALIGN() only works correctly if the alignment is a power of two. Some drivers
>>> use 3 bytes for the storage size of the word in which case ALIGN() will cause
>>> incorrect results. Use the more generic roundup() instead.
>>>
>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> Gah.  Which driver is using a non power of two storage size?  I thought I'd
>> caught
>> all of those at review.  As you've noted it's a very bad idea.
>>
>>  From a quick dubious grep I have:
>> dac/ad5791.c (not effected as such given we aren't using this stuff for output)
>> pressure/st_pressure_core.c
>

> Yes, this were the two I was seeing as well. But its noteworthy that
> the ad5791 driver doesn't have any buffer support yet, so that's not
> really an issue.
>>
>> I'd be tempted to fix those up rather than change this and introduce the
>> fun you've pointed out below.
>>

>> What do you think?
>
> I'm all for fixing this up and also adding a big return -EINVAL in
> case somebody tries to register a channel with a non power of two
> storage size.
Sounds good to me.  That way we don't rely on our clearly less than
perfect ability to pick it up in review.
>
> But I can also see potential issues here with hardware that has
> 24-bit samples and tightly packs them when transferring them over the
> bus. E.g. a 2 channel sensor with two 24-bit that are transferred in
> a 48-bit word. Especially for high-speed converters having a extra
> step that adds a 8-bit gap after/before each 24-bit word will be a
> undesirable performance overhead.
If it's going through the demux then things aren't going to be all that
fast anyway.
> But maybe to properly support this
> we'll need an extension that allows a driver to explicitly define its
> data layout rather than implicitly inferring it from the sample
> sizes.
Possibly though then do we just prevent demux on these because it
could be very costly....
>
> Btw. looking at drivers/iio/common/st_sensors/st_sensors_buffer.c it
> seems as if the driver doesn't support having multiple channels with
> different storage sizes for the same chip.
That sounds bad.  Denis?
>
>>> ---
>>> This at least makes the rules for alignment predictable and consistent. But
>>> mixing 3 bytes words with other word sizes will still result in strange
>>> layouts.
>>> E.g. 4-byte word, 3-byte word will result in 4-byte word, 2-byte alignment
>>> gap,
>>> 3-byte word.
>>
>>> ---
>>>   drivers/iio/industrialio-buffer.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iio/industrialio-buffer.c
>>> b/drivers/iio/industrialio-buffer.c
>>> index 0472ee2..6da5272 100644
>>> --- a/drivers/iio/industrialio-buffer.c
>>> +++ b/drivers/iio/industrialio-buffer.c
>>> @@ -486,7 +486,7 @@ static int iio_compute_scan_bytes(struct iio_dev
>>> *indio_dev,
>>>                   ch->scan_type.repeat;
>>>           else
>>>               length = ch->scan_type.storagebits / 8;
>>> -        bytes = ALIGN(bytes, length);
>>> +        bytes = roundup(bytes, length);
>>>           bytes += length;
>>>       }
>>>       if (timestamp) {
>>> @@ -497,7 +497,7 @@ static int iio_compute_scan_bytes(struct iio_dev
>>> *indio_dev,
>>>                   ch->scan_type.repeat;
>>>           else
>>>               length = ch->scan_type.storagebits / 8;
>>> -        bytes = ALIGN(bytes, length);
>>> +        bytes = roundup(bytes, length);
>>>           bytes += length;
>>>       }
>>>       return bytes;
>>>
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

