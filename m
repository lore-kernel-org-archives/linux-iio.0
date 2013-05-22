Return-Path: <gballetwork@gmail.com>
MIME-Version: 1.0
In-Reply-To: <519C8923.7020902@jic23.retrosnub.co.uk>
References: <CAGi_vrjcy=pB93FT8XrNHNZZb82RT=0YEbjds3PU4L4OstFgGQ@mail.gmail.com>
	<519C7C29.9040707@jic23.retrosnub.co.uk>
	<519C7F93.9010606@metafoo.de>
	<519C8923.7020902@jic23.retrosnub.co.uk>
Date: Wed, 22 May 2013 11:37:01 +0200
Message-ID: <CAGi_vricp+o35GiycEeO=eXg4gwpiP3x1ZvU2JCP0-_vMwrwWw@mail.gmail.com>
Subject: Re: Why is only one int returned in iio_read_channel_processed?
From: Guillaume Ballet <gballetwork@gmail.com>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

>>
>>>
>>>> functions' signature only has one integer
>>>> in/out parameter. That makes sense in the context of _raw because the
>>>> value isn't yet processed.
>>>>
>>>> However, as the scale is a number encoded over two ints, the
>>>> _processed value should also span two ints. Is there a reason why it's
>>>> still only one int?
>>>
>>> No it certainly should not be one int for exactly the reasons you have
>>> stated.
>>>>
>>>>
>>
>> I'm not to sure about that. I'd rather add a scale parameter to the
>> iio_read_channel_processed, just in the same way the
>> convert_raw_to_processed function takes a scale parameter.
>
> That may be tricky to do given we often have nasty non linear functions
> that are the reason we are using processed in the first place.  Hmm.
> Not sure which way works better.

I agree, this is the whole point of using processed. Lars, is there a
specific reason why you want to keep reading the value and the scale
in different function calls?

Guillaume
