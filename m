Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:53273 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751303AbdKNE5W (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Nov 2017 23:57:22 -0500
MIME-Version: 1.0
In-Reply-To: <2a10434c-a2f3-8feb-d0f1-875aaf207f38@posteo.de>
References: <20171106071958.322-1-martink@posteo.de> <20171111003350.000077b7@huawei.com>
 <2a10434c-a2f3-8feb-d0f1-875aaf207f38@posteo.de>
From: harinath Nampally <harinath922@gmail.com>
Date: Mon, 13 Nov 2017 23:56:40 -0500
Message-ID: <CAAGUq_p8StnOX1TO5oR3kN1zH3P5v17urmJGweB=LrJDy7h8dA@mail.gmail.com>
Subject: Re: [PATCH] iio: mma8452: add power_mode sysfs configuration
To: Martin Kepplinger <martink@posteo.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Martin,

> But given your concerns, I would strip down this patch to only offer the
> already documented "low_noise" and "low_power" modes. It wouldn't be
> worth it to extend the ABI just because of this!
OK then we can map 'low_noise' to high resolution mode. But I am afraid
I can't test the functionality because I don't have proper instruments to
measure the current draw(in microAmps) accurately.

> I would like "oversampling" more than this "power_mode" too. For this
> driver it would be far more complicated to implement though. I doubt
> that it'll be done. power_mode is basically already there implicitely,
> and given that there *is* the ABI, we could offer it for free.
I think 'oversampling' is already implemented, as I see
'case IIO_CHAN_INFO_OVERSAMPLING_RATIO:'
being handled which is basically setting the all 4 different power modes.
If we also add 'power_mode', I think it would be like having two
different user interfaces for
same functionality. So I don't see much of value adding 'power_mode' as well.
Please correct me if I am wrong.

Thanks,
Harinath

On Sun, Nov 12, 2017 at 7:28 AM, Martin Kepplinger <martink@posteo.de> wrote:
> On 2017-11-11 01:33, Jonathan Cameron wrote:
>> On Mon, 6 Nov 2017 08:19:58 +0100
>> Martin Kepplinger <martink@posteo.de> wrote:
>>
>>> This adds the power_mode sysfs interface to the device as documented in
>>> sysfs-bus-iio.
>>>
>>> ---
>>>
>>> Note that I explicitely don't sign off on this.
>>>
>>> This is a starting point for anybody who can test it and check for correct
>>> API usage, and ABI correctness, as documented in Documentation/ABI/testing/sys-bus-iio
>>> (grep it for "power_mode"). The ABI doc probably would need an addition
>>> too, if the 4 power modes here seem generally useful (there are only
>>>  2 listed there)!
>>>
>>> So, if you can test this, feel free to set up a proper patch or
>>> two, and I'm happy to review.
>>>
>>> Please note that this patch is quite old. It really should be that simple
>>> as far as my understanding back then. We always list the available frequencies
>>> of the given power mode we are in, for example, already, and everything
>>> basically is in place except for the user interface.
>>
>> Hmm. A lot of devices support something along these lines.  The issue
>> has always been - how is userspace to figure out what to do with it?
>> It's all very vague...
>>
>> Funnily enough - this used to be really common, but is becoming less so
>> now - presumably because no one was using it much (or maybe I am reading
>> too much into that ;)
>>
>> Now the question is whether it can be tied to better defined things?
>>
>> Here low noise restricts the range to 4g.  Issue is that we don't actually
>> have writeable _available attributes (which correspond to range in this case).
>>
>
> Does it? Isn't it merely less oversampling.
>
>> Low power mode... This one is apparently oversampling.  If possible support
>> it as that as we have well defined interfaces for that.
>>
>> Jonathan.
>
> Ah, I remember; the oversampling settings was actually a reason why I
> hadn't submitted the patch :) The oversampling API would definitely be
> more accurate.
>
> I would like "oversampling" more than this "power_mode" too. For this
> driver it would be far more complicated to implement though. I doubt
> that it'll be done. power_mode is basically already there implicitely,
> and given that there *is* the ABI, we could offer it for free.
>
> But given your concerns, I would strip down this patch to only offer the
> already documented "low_noise" and "low_power" modes. It wouldn't be
> worth it to extend the ABI just because of this!
>
> Users would have a simple switch if they don't really *want* to know the
> details. I think it can be useful to just say "I don't care about power
> consuption. Be as accurate as possible" or "I just want this think to
> work. Use a little power as possible." Sure it's vage, but would it be
> useless?
