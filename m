Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f196.google.com ([209.85.217.196]:35524 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbcEPGEx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 16 May 2016 02:04:53 -0400
Received: by mail-lb0-f196.google.com with SMTP id mx9so6577780lbb.2
        for <linux-iio@vger.kernel.org>; Sun, 15 May 2016 23:04:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8349aadb-c655-95c5-9399-960331b047ca@kernel.org>
References: <f71d4bfe-fd29-7f00-d770-f62221118000@kernel.org> <8349aadb-c655-95c5-9399-960331b047ca@kernel.org>
From: Matt Ranostay <mranostay@gmail.com>
Date: Sun, 15 May 2016 23:02:33 -0700
Message-ID: <CAKzfze9iS_et6BkZGa3ZD1-AEiEK9r2wXLL41LNvxjO-acPngQ@mail.gmail.com>
Subject: Re: [RFC] Make the devm_iio_device_alloc call set iio_dev.dev.parent.
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, May 15, 2016 at 10:55 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 04/05/16 11:56, Jonathan Cameron wrote:
>> Hi All,
>>
>> One thing that I discovered via a recent input device review is that
>> the equivalent of our devm_iio_device_alloc there also sets the
>> dev.parent.
>>
>> Should we do the same in IIO?
>>
>> I'm a bit in too minds as it feels like it is only sort of 'part of the
>> allocation'.
>>
>> Still it drops one line from nearly every IIO driver.
>> Could do the same for dev_iio_trigger_alloc as well I guess for double
>> savings.
>>
>> Anyhow, a little cleanup that seemed like a moderately good idea to
>> me so I thought I'd see what the general view was.
>>
>> Jonathan
>
> I'm gong ahead with this - just for reference purposes the oddities so far
> are:
> stx104 which never set the parent.
> max30100 which never sets the parent.
> apds9960 which never sets the parent.
> ms5611_i2c never sets the parent.
> pulsed_light lidar never sets the parent.

Yike! I caused 3 odd drivers here :)

>
> lm3533 which sets the iio device parent to the mfd device parent, but allocates
> on the devm against the mfd. I'm not certain this is how it should have been done
> but now it is abi so we have to cope with it.
> We can handle this just fine by letting it override the default.
>
> Each patch is simple enough I'll probably just do this in one or two mega patches
> rather than one per driver...
>
> Same trick applies for the devm_iio_trigger_alloc though that is used rather less.
>
> Jonathan
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
