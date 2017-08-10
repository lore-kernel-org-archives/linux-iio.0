Return-Path: <SRS0=EIVj=7M=gmail.com=harinath922@kernel.org>
Subject: Re: [PATCH] iio: accel: Bugfix to enbale and allow different events
 to work parallely.
To: Martin Kepplinger <martink@posteo.de>
Cc: Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de, lars@metafoo.de,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg KH <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alison Schofield <amsfield22@gmail.com>
References: <1501499858-4476-1-git-send-email-harinath922@gmail.com>
 <653B8888-D699-4B8B-93C2-6FF3308932AF@posteo.de>
 <CAAGUq_oD443x-Uq0FAZGQ8ietk9BO_Fjs7MYSNXrnR9Ogb+5tA@mail.gmail.com>
 <a5831c2d-58de-0ce8-67f3-95886063694b@gmail.com>
 <e33e6345-c269-0faf-b98e-dd23fd5b936d@posteo.de>
From: Harinath Nampally <harinath922@gmail.com>
Message-ID: <4df52628-9f20-ce4f-0a93-33c7f64f0ecd@gmail.com>
Date: Wed, 9 Aug 2017 23:51:52 -0400
MIME-Version: 1.0
In-Reply-To: <e33e6345-c269-0faf-b98e-dd23fd5b936d@posteo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

> My only suggestion for adding all these chips' orientation features, is
> to start the discussion independently from this driver. Are there other
> device series that provide such an orientation interrupt? Is it worth
> finding a representation in iio?
Given the number of accelerometers these days have built in orientation 
event support,

I think its worth to have a representation in IIO,

> Additionally to portait up/down, landscape left/right there is
> back/front facing, so you'd have 8 new channel modifiers.
Yes that's correct but I wonder if its good idea to add 8(too many!) new 
channel modifiers.
> If IIO_ROT is a current userspace "standard" to read for rotating the
> screen, it may be worth discussing how to fit this in without new
> modifiers. Would you have to make up fake angle values? Anything else
> userspace already uses for getting the orientation?
Yes I agree, I don't think I need to make up fake angle values, not sure
how userspace gets orientation currently. Need to do some research on that.
> But again, instead of replying here and going off topic, write up a
> proposal and post it independently.
Sure will do that. Thanks for your response.

On 08/01/2017 11:50 AM, Martin Kepplinger wrote:
> On 2017-08-01 05:08, Harinath Nampally wrote:
>>> Thanks for doing that work. I have had it on my list for a long time
>>> and you seem to fix it. Although I'd happily review and possibly test
>>> it, unfortunately I can't do so before the week of August 21st.
>>>
>>> If this might go in quick, nothing will stop me from reviewing either,
>>> so, whatever. Thanks again!
>>    Sure no problem, looking forward to your review comments.
>>    Actually I am planning to add Orientation events for FXLS8471Q, for
>> that is it good idea to overload existing
>>    IIO_ROT channel type? Also thinking of adding 4 channel modifiers i.e
>> portrait up/down, landscape left/right.
>>    Any suggestions are welcome. Thank you.
>>
> My only suggestion for adding all these chips' orientation features, is
> to start the discussion independently from this driver. Are there other
> device series that provide such an orientation interrupt? Is it worth
> finding a representation in iio?
>
> Additionally to portait up/down, landscape left/right there is
> back/front facing, so you'd have 8 new channel modifiers.
>
> If IIO_ROT is a current userspace "standard" to read for rotating the
> screen, it may be worth discussing how to fit this in without new
> modifiers. Would you have to make up fake angle values? Anything else
> userspace already uses for getting the orientation?
>
> But again, instead of replying here and going off topic, write up a
> proposal and post it independently.
