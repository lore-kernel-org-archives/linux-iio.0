Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34606 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbdBTLzc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Feb 2017 06:55:32 -0500
MIME-Version: 1.0
In-Reply-To: <20170220093256.GC4124@Socrates-UM>
References: <1487239327-21406-1-git-send-email-eraretuya@gmail.com>
 <1487239327-21406-3-git-send-email-eraretuya@gmail.com> <525c10a9-adda-9e5b-7f1c-f77abd6f7cb0@kernel.org>
 <20170220064112.GA4124@Socrates-UM> <20170220093256.GC4124@Socrates-UM>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 20 Feb 2017 13:47:49 +0200
Message-ID: <CAHp75VcFc77xJLR_xFTxRZPy0bLcB4D+x7aQfHE1wXfqJ0aFGg@mail.gmail.com>
Subject: Re: [PATCH 2/4] iio: accel: adxl345: Split driver into core and I2C
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        daniel.baluta@gmail.com, amsfield22@gmail.com,
        Florian Vaussard <florian.vaussard@heig-vd.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Feb 20, 2017 at 11:32 AM, Eva Rachel Retuya <eraretuya@gmail.com> wrote:
> On Mon, Feb 20, 2017 at 02:41:12PM +0800, Eva Rachel Retuya wrote:
>> On Sun, Feb 19, 2017 at 01:11:29PM +0000, Jonathan Cameron wrote:
>> > On 16/02/17 10:02, Eva Rachel Retuya wrote:

>> Hello Jonathan,
>>
>> Thanks for the feedback. I amended the relevant commits as you say and
>> git detects the file adxl345.c -> adxl345_core.c as 78% renamed. The
>> reason for that percentage is that I did some probe/remove renames and
>> some other deletions here and there. Should I commit them separately in
>> order to get the move detection to work?
>>
>
> Moved the deletions/modifications into patch 1. I hope I got it right
> this time?

I'm not a Jonathan, but there my remarks.

1. Yes, this version looks better.
2. Just a hint: check -M (for move) and -C (for copy) parameters to
git format-patch.
3. And please avoid over quoting when answering mails.

Thanks.

-- 
With Best Regards,
Andy Shevchenko
