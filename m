Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:48447 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750914AbdBSJ32 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Feb 2017 04:29:28 -0500
Subject: Re: [Outreachy kernel] Re: [PATCH 2/3] staging: iio: ad7152: Use
 GENMASK() macro for left shifts
To: sayli karnik <karniksayli1995@gmail.com>
References: <cover.1487448326.git.karniksayli1995@gmail.com>
 <92240a3dca0138880fe47a7df0a5e6df869c8199.1487448326.git.karniksayli1995@gmail.com>
 <0b5ef4d0-14b5-1196-8bc4-deda9d8f75ce@metafoo.de>
 <CAKG5xWjTjrwGWN-wJwzL0GPGhC2kohovYe8Umtn54Rf=yawerg@mail.gmail.com>
Cc: outreachy-kernel <outreachy-kernel@googlegroups.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <45b398c9-0807-9eeb-76e0-74f167d1e585@metafoo.de>
Date: Sun, 19 Feb 2017 10:29:18 +0100
MIME-Version: 1.0
In-Reply-To: <CAKG5xWjTjrwGWN-wJwzL0GPGhC2kohovYe8Umtn54Rf=yawerg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/19/2017 07:01 AM, sayli karnik wrote:
[...]
>> [...]
>>>  /* CFG2 Register Bit Designations (AD7152_REG_CFG2) */
>>> -#define AD7152_CFG2_OSR(x)           (((x) & 0x3) << 4)
>>> +#define AD7152_CFG2_OSR(x)           GENMASK(((x) & 0x3), 4)
>>
>> The extra parenthesis around (x) & 0x3 are no needed when using the macro
>> (the macro will add them).
>>
> The outer parentheses are certainly not needed but for the ones around
> x, checkpatch.pl complains otherwise-
> CHECK: Macro argument 'x' may be better as '(x)' to avoid precedence issues

The one around x are needed and should stay.

