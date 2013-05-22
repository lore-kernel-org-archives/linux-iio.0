Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-mx-f.csi.cam.ac.uk ([131.111.8.149]:36566 "EHLO
	ppsw-42.csi.cam.ac.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751094Ab3EVJAY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 May 2013 05:00:24 -0400
Message-ID: <519C8923.7020902@jic23.retrosnub.co.uk>
Date: Wed, 22 May 2013 10:00:19 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Guillaume Ballet <gballetwork@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: Why is only one int returned in iio_read_channel_processed?
References: <CAGi_vrjcy=pB93FT8XrNHNZZb82RT=0YEbjds3PU4L4OstFgGQ@mail.gmail.com> <519C7C29.9040707@jic23.retrosnub.co.uk> <519C7F93.9010606@metafoo.de>
In-Reply-To: <519C7F93.9010606@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/05/13 09:19, Lars-Peter Clausen wrote:
> On 05/22/2013 10:04 AM, Jonathan Cameron wrote:
>> On 22/05/13 08:49, Guillaume Ballet wrote:
>>> Hello,
>>>
>>> The read_raw operation in iio_info has a signature that takes two
>>> integer as in/out parameters. This lets the driver return values with
>>> micro- or nano-unit precision.
>>>
>>> However, the high-level iio_read_channel_raw and
>>> iio_read_channel_processed
>> Do we even have an iio_read_channel_processed? I think you are referring
>> to the in kernel consumer interface.  In iio/consumer.h we have an
>> iio_read_channel_raw but unless I am going mad no iio_read_channel_processed
>> (as of yet).
>>
>> https://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/tree/include/linux/iio/consumer.h?h=togreg
>>
>> (is the latest development tree).
>>
>> Which tree are you looking at?
>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/linux/iio/consumer.h#n145
Weird. I'm clearly going to be doing some checking of why that isn't in
my togreg branch (at least on kernel.org).  I did have some strange 
problems pushing the other day. I wonder if that branch has gotten into
a weird state.

>
>>
>>> functions' signature only has one integer
>>> in/out parameter. That makes sense in the context of _raw because the
>>> value isn't yet processed.
>>>
>>> However, as the scale is a number encoded over two ints, the
>>> _processed value should also span two ints. Is there a reason why it's
>>> still only one int?
>> No it certainly should not be one int for exactly the reasons you have stated.
>>>
>
> I'm not to sure about that. I'd rather add a scale parameter to the
> iio_read_channel_processed, just in the same way the
> convert_raw_to_processed function takes a scale parameter.
That may be tricky to do given we often have nasty non linear functions
that are the reason we are using processed in the first place.  Hmm.
Not sure which way works better.
>
> - Lars
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

