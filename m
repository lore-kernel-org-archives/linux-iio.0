Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:55312 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756383AbbA2C5q (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 28 Jan 2015 21:57:46 -0500
Received: by mail-wi0-f173.google.com with SMTP id r20so19137972wiv.0
        for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2015 18:57:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <54A969D9.8010408@kernel.org>
References: <1419122556-8100-1-git-send-email-octavian.purdila@intel.com>
	<1419122556-8100-7-git-send-email-octavian.purdila@intel.com>
	<54A969D9.8010408@kernel.org>
Date: Wed, 28 Jan 2015 12:33:13 +0200
Message-ID: <CAE1zotKTjxScYL=WZM68-pW3TAeN2Lm3JWoiBExdQQfAuL_gEQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] iio: bmc150: refactor interrupt enabling
From: Octavian Purdila <octavian.purdila@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Jan 4, 2015 at 6:27 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 21/12/14 00:42, Octavian Purdila wrote:
>> This patch combines the any motion and new data interrupts function
>> into a single, generic, interrupt enable function. On top of this, we
>> can later refactor triggers to make it easier to add new triggers.
>>
>> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
> Some really trivial suggests inline.  Looks good even without it being
> useful for later stuff ;)
>> ---
>>  drivers/iio/accel/bmc150-accel.c | 269 ++++++++++++++++-----------------------
>>  1 file changed, 113 insertions(+), 156 deletions(-)
>>
>> diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
>> index 92f1d2b..53d1d1d 100644
>> --- a/drivers/iio/accel/bmc150-accel.c
>> +++ b/drivers/iio/accel/bmc150-accel.c
>> @@ -144,6 +144,13 @@ struct bmc150_accel_chip_info {
>>       const struct bmc150_scale_info scale_table[4];
>>  };
>>
> I'd be tempted to define this at the place where you fill them below...

Done.

<snip>

>> +
>> +static int bmc150_accel_setup_any_motion_interrupt(
>> +                                     struct bmc150_accel_data *data,
>> +                                     bool status)
>> +{
>> +     return bmc150_accel_set_interrupt(data, &bmc150_accel_interrupts[1],
> Maybe define a matching enum so the indexes are obvious.
> Then is there a lot of point in having these wrappers? I'd just call
> it directly so you'd get something like.
>

The wrappers go away in one of the subsequent patches. I have kept
them here for now to make the review a bit simpler.

In another subsequent patch the interrupts are integrated to the
trigger structure and with that we can remove the ugly indexes as
well.
