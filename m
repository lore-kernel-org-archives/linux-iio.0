Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:32780 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752060AbcIAInq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Sep 2016 04:43:46 -0400
Received: by mail-oi0-f45.google.com with SMTP id c15so106971915oig.0
        for <linux-iio@vger.kernel.org>; Thu, 01 Sep 2016 01:43:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6c8174d4-0e53-edb3-8c3b-7304bb77ca91@kernel.org>
References: <1471354423-19186-1-git-send-email-linus.walleij@linaro.org>
 <1471354423-19186-11-git-send-email-linus.walleij@linaro.org> <6c8174d4-0e53-edb3-8c3b-7304bb77ca91@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 1 Sep 2016 10:43:45 +0200
Message-ID: <CACRpkdZLbu4NmRwiex=anGwHujha6iKwd2QaxghkS-W-VaVD6Q@mail.gmail.com>
Subject: Re: [PATCH 10/17] iio: accel: kxsd9: Fix scaling bug
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Aug 31, 2016 at 9:47 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 16/08/16 14:33, Linus Walleij wrote:
>> All the scaling of the KXSD9 involves multiplication with a
>> fraction number < 1.
>>
>> However the scaling value returned from IIO_INFO_SCALE was
>> unpredictable as only the micros of the value was assigned, and
>> not the integer part, resulting in scaling like this:
>>
>> $cat in_accel_scale
>> -1057462640.011978
>>
>> Fix this by assigning zero to the integer part.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> I'll pick this up for stable.  If you want to reorder so it's at the top
> of the series of the remaining patches that would be cool.
> If not I'll wiggle it till it fits.
>
> Tested-by: Jonathan Cameron <jic23@kernel.org>

OK rebasing it to front and tagging for stable, no
problem. Should've thought about it myself.

Yours,
Linus Walleij
