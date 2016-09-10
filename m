Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58687 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754821AbcIJP5g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Sep 2016 11:57:36 -0400
Subject: Re: [PATCH] iio: light: acpi-als: Add a tuning parameter interface.
To: Enric Balletbo Serra <eballetbo@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>
References: <1473157554-4990-1-git-send-email-enric.balletbo@collabora.com>
 <6b262774-fb80-7212-5426-dfc055689865@metafoo.de>
 <CAFqH_513e24aOZ8NJ+m0WtzKmf-n3R8FwwApFGWCdgoQbJRdNA@mail.gmail.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <cebd989a-6c84-fb60-eb26-e37b7eaf90ab@kernel.org>
Date: Sat, 10 Sep 2016 16:57:34 +0100
MIME-Version: 1.0
In-Reply-To: <CAFqH_513e24aOZ8NJ+m0WtzKmf-n3R8FwwApFGWCdgoQbJRdNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/09/16 17:48, Enric Balletbo Serra wrote:
> Hi Lars,
> 
> 2016-09-06 12:31 GMT+02:00 Lars-Peter Clausen <lars@metafoo.de>:
>> On 09/06/2016 12:25 PM, Enric Balletbo i Serra wrote:
>>> From: Bryan Freed <bfreed@chromium.org>
>>>
>>> Add IIO_CHAN_INFO_CALIBSCALE to the channel to scale up or down
>>> the raw measurements through the IIO framework.
>>>
>>> Add IIO_CHAN_INFO_PROCESSED to provide the interface to read the
>>> scaled measurements through the in_illuminance_input file.
>>
>> What is the use-case for this, how is this interface supposed to be used?
> 
> The idea behind this is be able to do a per-device calibration. The
> use case we're thinking is:
> 
>  1. Read raw measurements from sensor in controlled environment (at
> 30, 500 and 1000 lux)
>  2. do some math to calculate the calibration value.
>  3. write the value to calibscale (in_illuminance_calibscale)
>  4. read the calibrated measurement (in_illuminance_input)
> 
I can see where you are coming from but its a rather nasty fudge.
Given we have non trivial maths involved I'd be inclined to say this
should really be left for userspace HAL layers.

If we were getting it from ACPI tables (as the manufacturer had
done the measurements for the device) then we might expose it this
way but given userspace has to be involved to apply the tuning anyway
I'm not sure having a means to 'fudge' the kernel returned value
really makes sense.

Jonathan
> Regards,
>   Enric
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

