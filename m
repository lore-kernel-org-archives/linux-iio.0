Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-064.synserver.de ([212.40.185.64]:1047 "EHLO
	smtp-out-064.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753557AbaGUIrM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 Jul 2014 04:47:12 -0400
Message-ID: <53CCD34B.10807@metafoo.de>
Date: Mon, 21 Jul 2014 10:46:03 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, Denis CIOCCA <denis.ciocca@st.com>
Subject: Re: [PATCH 2/4] iio: buffer: Use roundup() instead of ALIGN()
References: <1405612789-27964-1-git-send-email-lars@metafoo.de> <1405612789-27964-2-git-send-email-lars@metafoo.de> <53CBDB85.10405@kernel.org>
In-Reply-To: <53CBDB85.10405@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/20/2014 05:08 PM, Jonathan Cameron wrote:
> On 17/07/14 16:59, Lars-Peter Clausen wrote:
>> ALIGN() only works correctly if the alignment is a power of two. Some drivers
>> use 3 bytes for the storage size of the word in which case ALIGN() will cause
>> incorrect results. Use the more generic roundup() instead.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Gah.  Which driver is using a non power of two storage size?  I thought I'd
> caught
> all of those at review.  As you've noted it's a very bad idea.
>
>  From a quick dubious grep I have:
> dac/ad5791.c (not effected as such given we aren't using this stuff for output)
> pressure/st_pressure_core.c

Yes, this were the two I was seeing as well. But its noteworthy that the 
ad5791 driver doesn't have any buffer support yet, so that's not really an 
issue.

>
> I'd be tempted to fix those up rather than change this and introduce the
> fun you've pointed out below.
>
> What do you think?

I'm all for fixing this up and also adding a big return -EINVAL in case 
somebody tries to register a channel with a non power of two storage size.

But I can also see potential issues here with hardware that has 24-bit 
samples and tightly packs them when transferring them over the bus. E.g. a 2 
channel sensor with two 24-bit that are transferred in a 48-bit word. 
Especially for high-speed converters having a extra step that adds a 8-bit 
gap after/before each 24-bit word will be a undesirable performance 
overhead. But maybe to properly support this we'll need an extension that 
allows a driver to explicitly define its data layout rather than implicitly 
inferring it from  the sample sizes.

Btw. looking at drivers/iio/common/st_sensors/st_sensors_buffer.c it seems 
as if the driver doesn't support having multiple channels with different 
storage sizes for the same chip.

>> ---
>> This at least makes the rules for alignment predictable and consistent. But
>> mixing 3 bytes words with other word sizes will still result in strange
>> layouts.
>> E.g. 4-byte word, 3-byte word will result in 4-byte word, 2-byte alignment
>> gap,
>> 3-byte word.
>
>> ---
>>   drivers/iio/industrialio-buffer.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/industrialio-buffer.c
>> b/drivers/iio/industrialio-buffer.c
>> index 0472ee2..6da5272 100644
>> --- a/drivers/iio/industrialio-buffer.c
>> +++ b/drivers/iio/industrialio-buffer.c
>> @@ -486,7 +486,7 @@ static int iio_compute_scan_bytes(struct iio_dev
>> *indio_dev,
>>                   ch->scan_type.repeat;
>>           else
>>               length = ch->scan_type.storagebits / 8;
>> -        bytes = ALIGN(bytes, length);
>> +        bytes = roundup(bytes, length);
>>           bytes += length;
>>       }
>>       if (timestamp) {
>> @@ -497,7 +497,7 @@ static int iio_compute_scan_bytes(struct iio_dev
>> *indio_dev,
>>                   ch->scan_type.repeat;
>>           else
>>               length = ch->scan_type.storagebits / 8;
>> -        bytes = ALIGN(bytes, length);
>> +        bytes = roundup(bytes, length);
>>           bytes += length;
>>       }
>>       return bytes;
>>
>

