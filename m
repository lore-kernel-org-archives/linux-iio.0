Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:34485 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754019AbcIDUru (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Sep 2016 16:47:50 -0400
Received: by mail-oi0-f54.google.com with SMTP id m11so98741545oif.1
        for <linux-iio@vger.kernel.org>; Sun, 04 Sep 2016 13:46:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <39750671-7040-09f3-7fef-c81f2c1c6234@kernel.org>
References: <1472723089-25113-1-git-send-email-linus.walleij@linaro.org>
 <1472723089-25113-2-git-send-email-linus.walleij@linaro.org>
 <3570b844-6094-e03f-f75b-e4f58aaa9133@kernel.org> <39750671-7040-09f3-7fef-c81f2c1c6234@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 4 Sep 2016 22:46:08 +0200
Message-ID: <CACRpkdbZcgn0c9Y3J6t4ee2m9UwXTcptirR0i_LiTH6H88rCGQ@mail.gmail.com>
Subject: Re: [PATCH 02/15 v2] iio: accel: kxsd9: Split out transport mechanism
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Sep 3, 2016 at 9:29 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 03/09/16 18:37, Jonathan Cameron wrote:
>> On 01/09/16 10:44, Linus Walleij wrote:
>>> Split off a transport mechanism struct that will deal with the SPI
>>> traffic in preparation for adding I2C support.
>>>
>>> Tested-by: Jonathan Cameron <jic23@kernel.org>
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> Now this may be a little exciting as the two fixes are working their
>> way via a different route into stable.  I'll merge the fixes in once
>> moves start happening.
>>
>> Applied to the fixes-togreg branch of iio.git.
>
> This is getting way to fiddly in the later patches.
> I'm going to hold these until the fixes have worked their way through
> into staging-next.
>
> Will delay things a week or so - sorry about that!

Don't worry I know how it works and I have lots of patience :)

Yours,
Linus Walleij
