Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48848 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753499Ab3FBQAq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jun 2013 12:00:46 -0400
Message-ID: <51AB6C2C.2060803@kernel.org>
Date: Sun, 02 Jun 2013 17:00:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Guillaume Ballet <gballetwork@gmail.com>,
	Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	linux-iio@vger.kernel.org
Subject: Re: Why is only one int returned in iio_read_channel_processed?
References: <CAGi_vrjcy=pB93FT8XrNHNZZb82RT=0YEbjds3PU4L4OstFgGQ@mail.gmail.com> <519C7C29.9040707@jic23.retrosnub.co.uk> <519C7F93.9010606@metafoo.de> <519C8923.7020902@jic23.retrosnub.co.uk> <CAGi_vricp+o35GiycEeO=eXg4gwpiP3x1ZvU2JCP0-_vMwrwWw@mail.gmail.com> <519CAF57.5030301@metafoo.de> <CAGi_vrir0uQd4u9WgixQ5an+jE8WFTyVmBiFnmxa-y=DfeW61g@mail.gmail.com> <519CCAA2.2070408@metafoo.de> <CAGi_vrjk7FLvYhHSLbV9D4GGHY1X1k1fkuEXMkh9Mn7z_5qj1w@mail.gmail.com> <519CD307.8020404@metafoo.de> <CAGi_vri2=wV8+m=y7ODKwh=F7opd_ZWckfP6NF_OftFh4=A=4Q@mail.gmail.com> <519CFCEB.1010606@metafoo.de> <CAGi_vrgk=x0JmVhqWPFRbdEBiHiURrUBoezKapJd5wj4zUXr7w@mail.gmail.com> <519DF1C7.9010604@metafoo.de> <CAGi_vri0x77BmteL=+A3-P7Ai3x9NAdBa-HqctaKN9jMt0EN1w@mail.gmail.com> <519E1979.8070400@metafoo.de>
In-Reply-To: <519E1979.8070400@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/23/2013 02:28 PM, Lars-Peter Clausen wrote:
> On 05/23/2013 03:18 PM, Guillaume Ballet wrote:
>>>>
>>>> - if IIO_INT_VAL_PLUS_NANO is returned (common when dealing with
>>>> current sources), 32 bits is a bit tight - which is why the read_raw
>>>> function pointer in iio_info has (val, val2) in the first place.
>>>> - People like me who do not use the iio_convert_raw_to_processed
>>>> path() but need to support IIO_CHAN_INFO_PROCESSED directly in their
>>>> driver have an issue: we would need to be passed the scale in the
>>>> read_raw function of iio_info. That would impact _all_ IIO drivers.
>>>
>>> IIO_CHAN_INFO_PROCESSED is by definition supposed to return the value in the
>>> proper unit. If that doesn't work for you use IIO_CHAN_INFO_RAW +
>>> IIO_CHAN_INFO_SCALE. Think of IIO_CHAN_INFO_PROCESSED as IIO_CHAN_INFO_RAW
>>> with the scale set to 1.0
>>
>> This isn't a unit problem, this is a precision problem: if I want to
>> return a current in Ampères, for instance 5.000000001, I can't get
>> that by calling iio_read_channel_processed() (or
>> iio_read_channel_raw() for that matter) as the precision is too big to
>> fit in only one integer. The issue is that the callback that handles
>> IIO_CHAN_INFO_PROCESSED and IIO_CHAN_INFO_RAW does allow to return
>> such a value. There's an inconsistency in the interface.
> 
> I doubt anybody actually cares about the 0.000000001 in that case.
> 
>>
>>>
>>>> - The scale parameter to iio_convert_raw_to_processed() itself is an
>>>> int, and IIO_CHAN_INFO_SCALE can return a scale in the
>>>> IIO_VAL_INT_PLUS_NANO scheme. It means somewhere along the road,
>>>> precision is lost.
>>>
>>> The scale would be passed in by the consumer, so the consumer is able to
>>> specify the amount of precision it wants.
>>
>> Not if they want a precision as high as the IIO driver is able to
>> deliver: the scale returned by a IIO_CHAN_INFO_SCALE is a 64-bits
>> fixed point integer. The scaled passed to
>> iio_convert_raw_to_processed() is a 32 bit integer. If one needs great
>> precision on big numbers, it won't fit.
> 
> The problem is that there is no in kernel user who can actually make use of
> anything but a 32bit integer. If we need a larger range we should change the
> return type to a 64bit integer rather than adopting the val1, val2 scheme
> for the in-kernel API.

Just to make things clear....

If an in kernel user were proposed that actually did make good use
of this it might be a different matter. It's just that no one has suggested
one as yet. I can contrive of complex cases where it might make sense, but
until we have a real world usecase, let us leave this.
> 
> - Lars
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
