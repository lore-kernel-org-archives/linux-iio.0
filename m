Return-Path: <SRS0=JjNR=H2=gmail.com=lorenzo.bianconi83@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1525659688.4030.5.camel@canonical.com>
References: <20180430042546.8801-1-shrirang.bagul@canonical.com>
 <20180506171942.0a4802d7@archlinux> <1525659688.4030.5.camel@canonical.com>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date: Mon, 7 May 2018 23:34:46 +0200
Message-ID: <CAA2SeNJRridUUjb01SjCfpg31ZbWiMLzD+ZeRqRDEmK-uEcZug@mail.gmail.com>
Subject: Re: [PATCH] iio: humidity: hts221: Fix sensor reads after resume
To: Shrirang Bagul <shrirang.bagul@canonical.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, mario.tesi@st.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

> On Sun, 2018-05-06 at 17:19 +0100, Jonathan Cameron wrote:
>> On Mon, 30 Apr 2018 12:25:46 +0800
>> Shrirang Bagul <shrirang.bagul@canonical.com> wrote:
>>
>> > CTRL1 register (ODR & BDU settings) gets reset after system comes back
>> > from suspend, causing subsequent reads from the sensor to fail.
>> >
>> > This patch restores the CTRL1 register after resume.
>> >
>> > Based on:
>> > git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git iio-fixes-for-4.14b
>> >
>> > Since 4.17.rc1, this driver uses REGMAP; I'll send a separate patch to
>> > address this issue.
>> >
>> > Cc: stable@vger.kernel.org
>> > Fixes: ffebe74b7c95 (iio: humidity: hts221: avoid useless ODR reconfiguration)
>>
>> Looks like part of the problem was introduced in that patch, part well predated
>> it (BDU).
>>
>> > Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
>>
>> As you way, this needs to be a bit different to take into account
>> the change to regmap.  We'll need to have that upstream before we look
>> at a back port.  One element inline surprises me and needs further
>> explanation.
> I have sent a patch based on iio-for-4.17b [1], Lorenzo and I are still
> discussing our findings. It's not just the CTRL1 reg, but also the AV_CONF(0x10) reg.
> which loses it's contents coming out of suspend.
>
> [1] https://marc.info/?l=linux-iio&m=152534455701742&w=2
>>
>>
>> > ---
>> >  drivers/iio/humidity/hts221_core.c | 12 ++++++++----
>> >  1 file changed, 8 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
>> > index 32524a8dc66f..fed2da64fa3b 100644
>> > --- a/drivers/iio/humidity/hts221_core.c
>> > +++ b/drivers/iio/humidity/hts221_core.c
>> > @@ -674,11 +674,15 @@ static int __maybe_unused hts221_resume(struct device *dev)
>> >     struct hts221_hw *hw = iio_priv(iio_dev);
>> >     int err = 0;
>> >
>> > -   if (hw->enabled)
>> > -           err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
>> > -                                        HTS221_ENABLE_MASK, true);
>>
>> Why drop the enable setting?  Seems that we want to do this 'as well',
>> if the device was previous enabled.
> Yes, will cover this in v2.
>>
>> > +   err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
>> > +                                HTS221_BDU_MASK, 1);
>> > +   if (err < 0)
>> > +           goto fail_err;
>> >
>> > -   return err;
>> > +   err = hts221_update_odr(hw, hw->odr);
>> > +
>> > +fail_err:
>> > +   return err < 0 ? err : 0;
>> >  }
>> >
>> >  const struct dev_pm_ops hts221_pm_ops = {
>>
>>

I guess we need to double-check the setup first since BDU is
configured just at bootstrap and it is never reset during
suspend/resume or normal operation.
It seems an electrical issue (e.g. Vdd not stable during suspend).
Shrirang could you please double check the device is powered up during
the suspend phase?
Is device connected through I2C or SPI? Could you please paste
register map before and after the suspend/resume operation?

Regards,
Lorenzo

-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch;
unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp;
umount; make clean; sleep
