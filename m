Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-036.synserver.de ([212.40.185.36]:1072 "EHLO
	smtp-out-036.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752733Ab3EVLng (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 May 2013 07:43:36 -0400
Message-ID: <519CAF57.5030301@metafoo.de>
Date: Wed, 22 May 2013 13:43:19 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Guillaume Ballet <gballetwork@gmail.com>
CC: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	linux-iio@vger.kernel.org
Subject: Re: Why is only one int returned in iio_read_channel_processed?
References: <CAGi_vrjcy=pB93FT8XrNHNZZb82RT=0YEbjds3PU4L4OstFgGQ@mail.gmail.com> <519C7C29.9040707@jic23.retrosnub.co.uk> <519C7F93.9010606@metafoo.de> <519C8923.7020902@jic23.retrosnub.co.uk> <CAGi_vricp+o35GiycEeO=eXg4gwpiP3x1ZvU2JCP0-_vMwrwWw@mail.gmail.com>
In-Reply-To: <CAGi_vricp+o35GiycEeO=eXg4gwpiP3x1ZvU2JCP0-_vMwrwWw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/22/2013 11:37 AM, Guillaume Ballet wrote:
>>>
>>>>
>>>>> functions' signature only has one integer
>>>>> in/out parameter. That makes sense in the context of _raw because the
>>>>> value isn't yet processed.
>>>>>
>>>>> However, as the scale is a number encoded over two ints, the
>>>>> _processed value should also span two ints. Is there a reason why it's
>>>>> still only one int?
>>>>
>>>> No it certainly should not be one int for exactly the reasons you have
>>>> stated.
>>>>>
>>>>>
>>>
>>> I'm not to sure about that. I'd rather add a scale parameter to the
>>> iio_read_channel_processed, just in the same way the
>>> convert_raw_to_processed function takes a scale parameter.
>>
>> That may be tricky to do given we often have nasty non linear functions
>> that are the reason we are using processed in the first place.  Hmm.
>> Not sure which way works better.
> 
> I agree, this is the whole point of using processed. Lars, is there a
> specific reason why you want to keep reading the value and the scale
> in different function calls?

I don't want to keep reading scale and value in different function calls.

What's you use case and how do you want to split the data between the two
integers?

- Lars
