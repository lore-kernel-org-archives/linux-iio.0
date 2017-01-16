Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34700 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750919AbdAPOXG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Jan 2017 09:23:06 -0500
Received: by mail-yw0-f195.google.com with SMTP id a10so8844611ywa.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Jan 2017 06:23:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <eb9bf135-9ea3-99b7-6a21-264dceb8a178@metafoo.de>
References: <CAKNHny9CYKzSoyq_-T3q35rq=1y1ekQPXr2Rg1ByhabadMWv9A@mail.gmail.com>
 <d1c324a3-17c9-ed66-3946-ccf9a0bbce5d@kernel.org> <07a0ebde-dffe-ba6a-5fac-eade517b5a21@metafoo.de>
 <CAKNHny_oY0bsfTZK7_KDKCm=x=KXiMaGkkGXpDFcUXB9SYkoRg@mail.gmail.com> <eb9bf135-9ea3-99b7-6a21-264dceb8a178@metafoo.de>
From: Matthias Klumpp <matthias@tenstral.net>
Date: Mon, 16 Jan 2017 15:23:05 +0100
Message-ID: <CAKNHny_9FCDfBdTC-=AL3LwdPyqQ0M58rYT22gxULFgB1hA1LA@mail.gmail.com>
Subject: Re: Using IIO for high-speed DAQ
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

2017-01-14 18:49 GMT+01:00 Lars-Peter Clausen <lars@metafoo.de>:
> On 01/14/2017 06:18 PM, Matthias Klumpp wrote:
>>> The IIO framework itself does not impose a limit on the maximum sampling
>>> rate. It's all a matter of what the hardware is capable of handling. We have
>>> systems where we do 3-digit MSPS continuous transfers and GSPS oneshot
>>> transfers.
>>
>> Since this is the first time I touched this area: Is there a group of
>> chips which you would recommend that samples with 200ksps, has a 16bit
>> bit-depth and bipolar mode and is accessible at that speed via IIO?
>> I'll look around a bit to find a solution for this issue.
>
> Unfortunately this is often as  much about the AP as it is about the
> converter. In the setups we have we use a AP+FPGA combination where the AP
> runs Linux with IIO and the FPGA is responsible for handling the SPI flow
> control during the acquisition phase. For this we've developed the
> SPI-Engine framework[1]. It is compatible with most ADI single-channel SAR
> and Sigma-Delta ADCs[2].
> [...]

Thanks!
I was already looking into this, but also tried to access the BCM2835
on my Raspberry Pi test device directly (someone wrote a nice helper
library for that at [1]).
Turns out that using this library, I can easily achieve my desired
speed of 200ksps (it also turned out that with a few changes on the
setup, 6ksps can be just enough...).

Maybe the kernel abstraction is causing the delays I was experiencing,
or maybe my kernel driver is simply not optimized enough (it could
read multiple samples in batches).

If I find the bottleneck, I'll let you know...
Meanwhile, I am glad that I apparently got around making an FPGA-based
controller, that would have been a lot more work.

Regards,
    Matthias

[1]: http://www.airspayce.com/mikem/bcm2835/
