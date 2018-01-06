Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36698 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753113AbeAFNmt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Jan 2018 08:42:49 -0500
Received: by mail-pl0-f65.google.com with SMTP id b12so4842351plm.3
        for <linux-iio@vger.kernel.org>; Sat, 06 Jan 2018 05:42:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180106120155.445097c2@archlinux>
References: <20180101141908.22531-1-lorenzo.bianconi@redhat.com>
 <20180106114735.34c3b198@archlinux> <20180106120155.445097c2@archlinux>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date: Sat, 6 Jan 2018 14:42:48 +0100
Message-ID: <CAA2SeN+3MytFkCQyYBGzfkTxH+SBLWFMuH+L43U5R-2JZHVG=Q@mail.gmail.com>
Subject: Re: [PATCH] iio: humidity: hts221: remove unnecessary get_unaligned_le16()
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> On Sat, 6 Jan 2018 11:47:35 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
>
>> On Mon,  1 Jan 2018 15:19:08 +0100
>> Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:
>>
>> > Remove unnecessary unaligned access routine in hts221_read_oneshot() and
>> > the related include
>> >
>> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
>> Whilst build testing this sparse came up with:
>>
>>   CHECK   drivers/iio/humidity/hts221_core.c
>> drivers/iio/humidity/hts221_core.c:278:19: warning: cast to restricted __le16
>> drivers/iio/humidity/hts221_core.c:289:18: warning: cast to restricted __le16
>> drivers/iio/humidity/hts221_core.c:295:18: warning: cast to restricted __le16
>> drivers/iio/humidity/hts221_core.c:327:18: warning: cast to restricted __le16
>> drivers/iio/humidity/hts221_core.c:333:18: warning: cast to restricted __le16
>>

Hi Jonathan,

>> There are definitely some suspicious bits of code there.  Would you mind
>> cleaning this up? Looks to me like the regmap specification should
>> be handling the endianness.
> Which won't work as the registers are 8 bits.  There for cal0 and cal1 are
> only 8 bits anyway so the conversion from le16_to_cpu isn't right.
>
> For cal_x0 you'll have to add a local le16 variable to tidy this up.
>
> For some of these the issue was there before your patch, but I'm fairly sure
> you introduced the first one.
>
> In any case, good to fix these.
>

Thanks for testing it. Running sparse on current testing branch seems
that issues are all already there before the regmap patch so I will
rebase regmap series ontop of a fix for them (so it will be available
even for stable branch).
Sorry for the noise :)

Regards,
Lorenzo

> Thanks,
>
> Jonathan
>>
>> Actually this is nasty enough that I'm going to back out the regmap conversion
>> for now.  Would you mind spinning a single patch doing the whole conversion
>> with this corrected.  Probably roll this patch into that series as well.
>>
>> I've kept the common code patch though as that is fine on its own.
>>
>> Thanks,
>>
>> Jonathan
>>
>> > ---
>> >  drivers/iio/humidity/hts221_core.c | 7 +++----
>> >  1 file changed, 3 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
>> > index 75d442e7b510..6df59e12c5e2 100644
>> > --- a/drivers/iio/humidity/hts221_core.c
>> > +++ b/drivers/iio/humidity/hts221_core.c
>> > @@ -14,7 +14,6 @@
>> >  #include <linux/iio/sysfs.h>
>> >  #include <linux/delay.h>
>> >  #include <linux/pm.h>
>> > -#include <asm/unaligned.h>
>> >  #include <linux/regmap.h>
>> >  #include <linux/bitfield.h>
>> >
>> > @@ -404,7 +403,7 @@ static int hts221_get_sensor_offset(struct hts221_hw *hw,
>> >
>> >  static int hts221_read_oneshot(struct hts221_hw *hw, u8 addr, int *val)
>> >  {
>> > -   u8 data[HTS221_DATA_SIZE];
>> > +   __le16 data;
>> >     int err;
>> >
>> >     err = hts221_set_enable(hw, true);
>> > @@ -413,13 +412,13 @@ static int hts221_read_oneshot(struct hts221_hw *hw, u8 addr, int *val)
>> >
>> >     msleep(50);
>> >
>> > -   err = regmap_bulk_read(hw->regmap, addr, data, sizeof(data));
>> > +   err = regmap_bulk_read(hw->regmap, addr, &data, sizeof(data));
>> >     if (err < 0)
>> >             return err;
>> >
>> >     hts221_set_enable(hw, false);
>> >
>> > -   *val = (s16)get_unaligned_le16(data);
>> > +   *val = (s16)le16_to_cpu(data);
>> >
>> >     return IIO_VAL_INT;
>> >  }
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch;
unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp;
umount; make clean; sleep
