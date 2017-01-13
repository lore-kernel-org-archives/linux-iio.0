Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34034 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbdAMXvb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Jan 2017 18:51:31 -0500
Received: by mail-lf0-f65.google.com with SMTP id q89so7270623lfi.1
        for <linux-iio@vger.kernel.org>; Fri, 13 Jan 2017 15:51:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <85c07462-c175-faf8-8dae-403a6291331e@gmail.com>
References: <2c7996a6-9c55-4cee-75a1-01be8732c42a@gmail.com>
 <CAFBinCC_AYS0ogzdpGVRoeS2ETjcD6fdmzq3kmX_u=9heBu6oA@mail.gmail.com> <85c07462-c175-faf8-8dae-403a6291331e@gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 14 Jan 2017 00:51:09 +0100
Message-ID: <CAFBinCBwbcYRVfhyPN=2ZcNhteLu9Eu43MxhTFgS3dsmrtqEVA@mail.gmail.com>
Subject: Re: [PATCH 4/4] ARM64: dts: meson: meson-gx: add the SAR ADC
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Jan 13, 2017 at 9:14 PM, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> Am 13.01.2017 um 20:50 schrieb Martin Blumenstingl:
>> Hi Heiner,
>>
>> On Fri, Jan 13, 2017 at 8:32 PM, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>> Sorry, I'm not subscribed to the two mailing lists, therefore my reply
>>> is outside the thread.
>>>
>>> I'm currently experimenting with an own rudimentary driver for SAR ADC
>>> on a Odroid C2 (S905GXBB). So I have some remarks based on my experience.
>> I hope that we haven't been duplicating too much work!
>>
> No, my driver doesn't include all the clock handling and relies on the
> boot loader / firmware to do this. Also I don't support averaging mode.
> Your driver is much more comprehensive and I would go with it.
>
> I have some features like interrupt mode and calibration which are not
> yet supported in your driver but they can be easily migrated and added
> later.
indeed, that'll leave some fun for you as well :-)
