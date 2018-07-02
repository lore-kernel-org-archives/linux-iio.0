Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from vern.gendns.com ([206.190.152.46]:37800 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752184AbeGBPd4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 2 Jul 2018 11:33:56 -0400
Subject: Re: [PATCH] iio: add channel type for frequency
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
References: <20180701025953.3561-1-david@lechnology.com>
 <308015e8-d203-c4d1-ba80-3c2adf4b377a@metafoo.de>
 <74c98fdc-b498-c593-e0b1-6aeb7057398a@lechnology.com>
 <20180702140352.00002c6c@huawei.com>
From: David Lechner <david@lechnology.com>
Message-ID: <51fa1708-a19e-aa05-6145-b2479a89805b@lechnology.com>
Date: Mon, 2 Jul 2018 10:33:52 -0500
MIME-Version: 1.0
In-Reply-To: <20180702140352.00002c6c@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/02/2018 08:03 AM, Jonathan Cameron wrote:
> On Sun, 1 Jul 2018 17:24:34 -0500
> David Lechner <david@lechnology.com> wrote:
> 
>> On 07/01/2018 02:18 AM, Lars-Peter Clausen wrote:
>>> On 07/01/2018 04:59 AM, David Lechner wrote:
>>>> This adds a new type for frequency to the IIO channel type enumeration.
>>>>
>>>> Units are in Hz.
>>>>   
>>>
>>> Documentation?
>>
>> I take it that you mean Documentation/ABI/testing/sysfs-bus-iio? Or
>> somewhere else too?
> 
> Yes.
> 
>>
>>>
>>> We already have the altvoltage channel type with the frequency attribute.
>>> Difficult to say if there are any overlaps without documentation on how this
>>> new attribute is supposed to be used.
>>
>> I'm basically trying to implement a quadrature encoder in iio. I want to be
>> able to use it in-kernel to get a rotational speed value for a motor.
> 
> Have you seen the counters subsystem work that is pretty much ready to merge?

I hadn't seen that. Thanks. It sounds like the way to go since I am dealing with
a quadrature encoder.

> 
> https://lkml.org/lkml/2018/6/21/659
> 
>>
>> The motors (and encoder wheels) are hot-swapable, so we don't know how many
>> counts from the quadrature encoder equals one rotation because it depends on
>> which motor is being used. So using IIO_ANGL_VEL doesn't work for this case.
> 
> Hmm. This always ugly when we have hotswappable external devices.  Ideal is
> to describe them with device tree or similar none the less as this stuff isn't
> really something userspace should have to figure out.
> 
>>
>> It seems to me that the proper generic unit for "speed" from the quadrature
>> encoder would be counts per second, hence the suggestion of a frequency unit.
> 
> It is probably not that clear cut, as what is it frequency of?  All depends on
> what mode the quadrature counter is working in x4 or x1 for simplest options.
> 
> 
>> I'm not sure if voltage frequency works here since a "count" on a quadrature
>> encoder is derived from two different voltage signals (and may vary depending
>> on how the encoder determines what one count it).
>>
>> Also, unrelated to my quadrature encoder project, I was thinking that
>> frequency counters would use this unit as well (although the voltage alt
>> makes more sense for this case).
>>
>> There are also sound sensors that measure frequency that could use this unit.
> 
> I have not fundamental issue with having a frequency channel, but only
> if we have a clear cut use case.  I suspect the right option here is to
> look at what extensions are needed to William's counter subsystem instead
> of in IIO (which frankly failed to stretch far enough to support counters
> well).
> 

Agreed. Let's drop this patch.
