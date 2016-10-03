Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:36439 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752090AbcJCNiV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Oct 2016 09:38:21 -0400
Received: by mail-yw0-f193.google.com with SMTP id r132so2967983ywg.3
        for <linux-iio@vger.kernel.org>; Mon, 03 Oct 2016 06:38:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20161002232524.GA2822@d830.WORKGROUP>
References: <20161001110418.GA25515@sayli-HP-15-Notebook-PC>
 <20161002050032.GA14117@d830.WORKGROUP> <e4800421-2dc9-2460-470b-a043d198f469@metafoo.de>
 <20161002232524.GA2822@d830.WORKGROUP>
From: sayli karnik <karniksayli1995@gmail.com>
Date: Mon, 3 Oct 2016 19:07:39 +0530
Message-ID: <CAKG5xWi6M5jemARfENuVgigaqUbvdJmeVbwpR3kWDM9d8LBW-w@mail.gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] iio: imu: bmi160: bmi160_core: Fix
 sparse warning
To: Alison Schofield <amsfield22@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        outreachy-kernel@googlegroups.com,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Oct 3, 2016 at 4:55 AM, Alison Schofield <amsfield22@gmail.com> wrote:
> On Sun, Oct 02, 2016 at 05:53:08PM +0200, Lars-Peter Clausen wrote:
>> On 10/02/2016 07:00 AM, Alison Schofield wrote:
>> [...]
>> >> ---
>> >>  drivers/iio/imu/bmi160/bmi160_core.c | 3 ++-
>> >>  1 file changed, 2 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
>> >> index e0251b8..5355507 100644
>> >> --- a/drivers/iio/imu/bmi160/bmi160_core.c
>> >> +++ b/drivers/iio/imu/bmi160/bmi160_core.c
>> >> @@ -398,7 +398,8 @@ static irqreturn_t bmi160_trigger_handler(int irq, void *p)
>> >>    struct iio_poll_func *pf = p;
>> >>    struct iio_dev *indio_dev = pf->indio_dev;
>> >>    struct bmi160_data *data = iio_priv(indio_dev);
>> >> -  s16 buf[16]; /* 3 sens x 3 axis x s16 + 3 x s16 pad + 4 x s16 tstamp */
>> >> +  __le16 buf[16];
>> >> +  /* 3 sens x 3 axis x __le16 + 3 x __le16 pad + 4 x __le16 tstamp */
>> >>    int i, ret, j = 0, base = BMI160_REG_DATA_MAGN_XOUT_L;
>> >>    __le16 sample;
>> >
>> > Wondering about this option below.  Data was read into an __le16, so that
>> > was good diligence on drivers part.  Seems we can use le16_to_cpu() for the
>> > conversion into the buf.
>> >
>> > --- a/drivers/iio/imu/bmi160/bmi160_core.c
>> > +++ b/drivers/iio/imu/bmi160/bmi160_core.c
>> > @@ -408,7 +408,7 @@ static irqreturn_t bmi160_trigger_handler(int irq, void *p)
>> >                                    &sample, sizeof(__le16));
>> >             if (ret < 0)
>> >                     goto done;
>> > -           buf[j++] = sample;
>> > +           buf[j++] = le16_to_cpu(sample);
>> >     }
>>
>> This conversion is usually skipped on purpose and delayed until it is
>> actually needed by the user. The IIO channel is accordingly marked that it
>> will produce LE data.
> Thanks Lars.  I knew that for buffers, overlooked it, now I'll know it
> better!
>
> So, Sayli, you probably got this from the analysis of the last patch.
> In buffered mode, we'll go ahead and return the data in it's 'native'
> order.  So, my suggestion to convert it here, is wrong.  Ignore ;)
>
Oh I see! So should I resend the patch with an updated
description?(cosmetic/bug fix)

thanks,
sayli

> alisons
>
>>
