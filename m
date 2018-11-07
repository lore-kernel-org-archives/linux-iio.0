Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk1-f180.google.com ([209.85.222.180]:35445 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbeKHE3X (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Nov 2018 23:29:23 -0500
Received: by mail-qk1-f180.google.com with SMTP id v68-v6so22291787qka.2
        for <linux-iio@vger.kernel.org>; Wed, 07 Nov 2018 10:57:43 -0800 (PST)
From: Renato Lui Geh <renatogeh@gmail.com>
Date: Wed, 7 Nov 2018 16:57:37 -0200
To: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc: "giuliano.belinassi@usp.br" <giuliano.belinassi@usp.br>,
        "jic23@jic23.retrosnub.co.uk" <jic23@jic23.retrosnub.co.uk>,
        "giuliano.belinassi@gmail.com" <giuliano.belinassi@gmail.com>,
        "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>
Subject: Re: Questions related to some drivers
Message-ID: <20181107185735.wryk5o4wndy6bkzn@renatolg>
References: <20181017190028.wu2kgsooj64beh7o@smtp.gmail.com>
 <d0fc5a236a82d03fdbe4d05eb27ff3bd3ac36958.camel@analog.com>
 <20181018114145.amqff57holmecxpo@smtp.gmail.com>
 <CAEFO=4BjSiYeNW_n0PjoC3EqaN1Z8E1XB_CO+FJJdTwZo4enzg@mail.gmail.com>
 <20181023105126.408ef7ab@archlinux>
 <CAEFO=4Dc_v90MHFnniTpAcMvajpt3O55rtc730Pr0F6+Aau49A@mail.gmail.com>
 <6f9ad9ace7828741f25ea6e7c555c9f4e91a203b.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
In-Reply-To: <6f9ad9ace7828741f25ea6e7c555c9f4e91a203b.camel@analog.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/06, Ardelean, Alexandru wrote:
>Hey,
>
>You don't need to check any patterns, that's already being done in the
>driver (see `pattern` & `pattern_mask` fields).
>And see function ad7780_postprocess_sample().
>Though I will admit it would have been nicer if those patterns were
>generated from AD7780_PAT1 & AD7780_PAT0. So (if you want), you could
>update those pattern assignments with some macros ; for AD717x you may need
>to add AD7170_PAT2 (BIT(2))
>
>I am noticing a small bug with the driver now
>(in ad7780_postprocess_sample()).
>The AD7780_GAIN bit-field (for AD778x) overlaps with AD7170_PAT2 (for
>AD717x). So, maybe you could add a field called `is_ad778x` in
>`ad7780_chip_info` and initialize it to true in the `ad7780_chip_info_tbl`
>for AD7780 & AD7781 ; and only perform the AD7780_GAIN check for these
>devices.
>According to the datasheets AD7170 & AD7171 have a fixed gain of 1.
>
>I would ignore the ID0 & ID1 fields ; those seem to overlap a bit between
>AD717x & AD778x. And they're not very useful in the driver.
>

Hi,

Thank you for the clues on what to work on. We've just now sent a
patchset with the fixes you mentioned in the quoted block above.

>For AD778x you could also add support for the GAIN & FILTER pins via GPIOs,
>to control these settings. And then in the ad7780_postprocess_sample()
>function check if the GPIO settings (stored on a gpio_desc on ad7780_state)
>match the expected GAIN & FILTER bit settings ; if not return -EIO.
>
>All-in-all, the driver is almost ready to move out of staging (from my
>point of view).
>Not sure if anyone else has anything else to add.
>The bug should be fixed, and the rest is nice-to-have, but not necessarily
>a must (again, from my point of view) to keep it in staging.
>
>Also, generally: maybe do a comparative sweep between AD717x & AD778x
>datasheets and see if there's something left that's incorrect for any of
>these chips.

We'll take a look on these issues and study them further and will start
working on them once we're confident we understand them.

>Thanks
>Alex

Thanks,
Renato
