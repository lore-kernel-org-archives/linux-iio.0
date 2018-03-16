Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34740 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751454AbeCPN0J (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Mar 2018 09:26:09 -0400
Received: by mail-wm0-f44.google.com with SMTP id a20so2752059wmd.1
        for <linux-iio@vger.kernel.org>; Fri, 16 Mar 2018 06:26:09 -0700 (PDT)
Subject: Re: Removal of blackfin architecture
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-iio@vger.kernel.org, Tom Lebreux <tomlebreux@cock.li>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
References: <5871ecb8-d726-0f6c-3e7a-da58896a97e2@gmail.com>
 <20180316140318.000014f6@huawei.com>
From: David Julian Veenstra <davidjulianveenstra@gmail.com>
Message-ID: <28aaf336-9abe-e12a-e25f-8c7b799249f6@gmail.com>
Date: Fri, 16 Mar 2018 14:26:07 +0100
MIME-Version: 1.0
In-Reply-To: <20180316140318.000014f6@huawei.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/16/2018 02:03 PM, Jonathan Cameron wrote:
> On Fri, 16 Mar 2018 13:50:44 +0100
> David Julian Veenstra <davidjulianveenstra@gmail.com> wrote:
>
>> Dear IIO Community,
> Hi David,
>> Currently, there are 3 people working on moving resolver driver out of
>> staging.
>> Rodrigo Siqueira is working on ad2s1210, Tom Lebreux is working on ad2s90,
>> and I'm working on ad2s1200.
>>
>> There is only a single blackfin board ([1]) that sets the proper spi
>> driver mod
>> alias and platform data for the ad2s1200 and the ad2s1210, and the proper
>> mod alias for ads90.
> These are still active products and actually have no connection to the
> blackfin architecture other than one random board every used them.
> (at a guess because that board was the one used to test them in the
> first place).
>
> Note that these days you won't even have visibility on whether a board
> has one of these connected as it will be handled via devicetree.
>
> Another thing to note is that these types of devices tend to end up
> used in boards which no one tends to upstream as they are part of
> custom industrial motor controllers.  That doesn't reduce the value
> in having the driver upstreamed however.
>
>> However, it seems that general support for blackfin architecture is
>> slated to be
>> removed, see [2] and [3]. The relevant spi master driver is also being
>> removed.
>>
>> What is the best course of action? Continue working on the drivers, or
>> remove
>> the drivers altogether?
>>
>> [1] See arch/blackfin/mach-bf537/boards/stamp.c
>> [2] https://marc.info/?l=linux-kernel&m=152112517630790&w=2
>> [3] https://marc.info/?w=4&r=1&s=%5BBlackfin+removal%5D&q=t
> In my view this just highlights the fact we should bring these into the modern
> world with proper documented device tree bindings and correct
> gpio assignments where needed.
>
> The ad2s90 has no platform data so will work just fine with
> a devicetree binding relying on the automatic probing of spi drivers.
> The other two need their platform data sorting out and will indeed
> not work without support in a board file.  There is no reason why
> that board file needs to upstream however (nice though that would be!)
>
> Jonathan
>
>> Best regards,
>> David Veenstra
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

I see, that makes sense. Thanks for the explanation!

Since, blackfin is being removed, I'll leave stamp.c alone.

Best regards,
David Veenstra
