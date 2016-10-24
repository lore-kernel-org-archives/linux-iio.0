Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:32945 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934130AbcJXIHJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2016 04:07:09 -0400
Received: by mail-qk0-f196.google.com with SMTP id x11so1339036qka.0
        for <linux-iio@vger.kernel.org>; Mon, 24 Oct 2016 01:07:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <02678572-347e-a5a8-5c78-cf39c2b3284f@kernel.org>
References: <CAJ_EiSQ0KEXOqNOQvqcaF5=f-TJtxZNsWs39k6gHuzN_f1OT7w@mail.gmail.com>
 <02678572-347e-a5a8-5c78-cf39c2b3284f@kernel.org>
From: Matt Ranostay <matt@ranostay.consulting>
Date: Mon, 24 Oct 2016 01:07:07 -0700
Message-ID: <CAJ_EiSSv2O7MzuMs-3Gcb-05qcryAEFORLuYYv+q5CmA3-FRsQ@mail.gmail.com>
Subject: Re: [RFC] multipixel infrared thermopile sensors
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Oct 23, 2016 at 2:53 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 19/10/16 18:13, Matt Ranostay wrote:
>> Jonathan et all,
>>
>> Know this has been brought up in the past but what is the view of
>> multipixel infrared thermopiles?
>>
>> Initially I plan to do summing average of all the pixels and report
>> that back, but would like in the future to be able to push the pixel
>> data to the buffers.
>>
>> These of course are weird because they barely fit into iio, but nor do
>> they fit into v4l2 (especially since the data isn't DMA'able).
> DMA isn't really a requirement for v4l2.
>
> Usual rule of thumb that if no one else thinks it's in their scope and
> it measures something it goes in IIO :)
>
> So real question is do the v4l2 people think it should be in there?
>
> My gut feeling is yes.  These things are only going to get bigger as the
> technology moves on so will become more and more camera like.
>
> It's possible we'll ultimately end up bridging one way or the other
> between IIO and v4l2 but only once we have a clean use case for it
> and I'm not convinced this is one yet...
>
> Though maybe it is if exporting the average of pixels is actually how
> these devices are typically used...
>

Seem likely we need to have a v4l2 interface... esp for the that FLIR
module awhile back... (seems people made a module that was a USB class
device to avoid this :))

Only issue is that there are temperature trip points that can be set
which don't translate to v4l2...
And v4l2 is more DMA buffer driven but I guess a polling driver was
going to happen at some point...

> J
>>
>> Datasheet -> https://eewiki.net/download/attachments/13599167/Grid-EYE%20SPECIFICATIONS%28Reference%29.pdf
>>
>> Thanks,
>>
>> Matt
>>
>
