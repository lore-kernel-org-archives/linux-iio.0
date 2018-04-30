Return-Path: <SRS0=phJX=HT=gmail.com=lorenzo.bianconi83@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1525078153.10678.9.camel@canonical.com>
References: <20180430051658.9856-1-shrirang.bagul@canonical.com>
 <CAA2SeNKTjVO7JBVV3qJMJhdM-j=r+igd_nADe+NH3Rux0oW1qA@mail.gmail.com> <1525078153.10678.9.camel@canonical.com>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date: Mon, 30 Apr 2018 11:05:57 +0200
Message-ID: <CAA2SeNKn6mavKBa8=pU5sPLWpLKY=A5GGnwRZcn65Mhzd-8jqQ@mail.gmail.com>
Subject: Re: [PATCH][for iio-for-4.17b] iio: humidity: hts221: Fix sensor
 reads after resume
To: Shrirang Bagul <shrirang.bagul@canonical.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

> On Mon, 2018-04-30 at 09:48 +0200, Lorenzo Bianconi wrote:
>> > CTRL1 register (ODR & BDU settings) gets reset after system comes back
>> > from suspend, causing subsequent reads from the sensor to fail.
>> >
>> > This patch restores the CTRL1 register after resume.
>> >
>>
>> Hi Shrirang,
>>
>> is just CTRL1 reset after suspend/resume or also other registers? are
>> IIO triggers enabled before the suspend or
>> are you reading data from sysfs?
>>
>> > Based on:
>> > git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git iio-for-4.17b
>> >
>> > Fixes: ffebe74b7c95 (iio: humidity: hts221: avoid useless ODR reconfiguration)
>> > Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
>> > ---
>> >  drivers/iio/humidity/hts221_core.c | 13 +++++++------
>> >  1 file changed, 7 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
>> > index 166946d4978d..5d7a652aa6d9 100644
>> > --- a/drivers/iio/humidity/hts221_core.c
>> > +++ b/drivers/iio/humidity/hts221_core.c
>> > @@ -658,12 +658,13 @@ static int __maybe_unused hts221_resume(struct device *dev)
>> >         struct hts221_hw *hw = iio_priv(iio_dev);
>> >         int err = 0;
>> >
>> > -       if (hw->enabled)
>> > -               err = regmap_update_bits(hw->regmap, HTS221_REG_CNTRL1_ADDR,
>> > -                                        HTS221_ENABLE_MASK,
>> > -                                        FIELD_PREP(HTS221_ENABLE_MASK,
>> > -                                                   true));
>> > -       return err;
>> > +       err = regmap_update_bits(hw->regmap, HTS221_REG_CNTRL1_ADDR,
>> > +                                HTS221_BDU_MASK,
>> > +                                FIELD_PREP(HTS221_BDU_MASK, 1));
>> > +       if (err < 0)
>> > +               return err;
>> > +
>> > +       return hts221_update_odr(hw, hw->odr);
>> >  }
>> >
> No need to re-enable the sensor here. hts221_read_oneshot() [called from hts221_read_raw()] does that every time before read:
>

Could please try to change other registers (e.g. rh or temp gain) and
double check values are properly configured resuming the sensor?
It is necessary to re-enable the sensor if you use IIO triggers and
the sensor was enabled before the suspend operation

> static int hts221_read_oneshot(struct hts221_hw *hw, u8 addr, int *val)
> {
>         __le16 data;
>         int err;
>
>         err = hts221_set_enable(hw, true);
>         if (err < 0)
>                 return err;
>
>         msleep(50);
>
>         err = regmap_bulk_read(hw->regmap, addr, &data, sizeof(data));
>         if (err < 0)
>                 return err;
>
>         hts221_set_enable(hw, false);
>
> Regards,
> Shrirang
>>
>> Here you need to re-enable the sensor if it was running before the
>> suspend operation.
>> Regards,
>>
>> Lorenzo
>>
>> >  const struct dev_pm_ops hts221_pm_ops = {
>> > --
>> > 2.14.1
>> >
>>
>>
>>



-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch;
unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp;
umount; make clean; sleep
