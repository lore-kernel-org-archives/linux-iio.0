Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45631 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbeECJaE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 May 2018 05:30:04 -0400
Received: by mail-pg0-f66.google.com with SMTP id i29-v6so12693802pgn.12
        for <linux-iio@vger.kernel.org>; Thu, 03 May 2018 02:30:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1525333190.4358.20.camel@canonical.com>
References: <20180430051658.9856-1-shrirang.bagul@canonical.com>
 <CAA2SeNKTjVO7JBVV3qJMJhdM-j=r+igd_nADe+NH3Rux0oW1qA@mail.gmail.com>
 <1525078153.10678.9.camel@canonical.com> <CAA2SeNKn6mavKBa8=pU5sPLWpLKY=A5GGnwRZcn65Mhzd-8jqQ@mail.gmail.com>
 <1525079565.10678.10.camel@canonical.com> <1525333190.4358.20.camel@canonical.com>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date: Thu, 3 May 2018 11:30:02 +0200
Message-ID: <CAA2SeNJYAd_XbSU-MohZxP-7h2Jpwb_f6ho+9Z2Yc3pPg6jnVw@mail.gmail.com>
Subject: Re: [PATCH][for iio-for-4.17b] iio: humidity: hts221: Fix sensor
 reads after resume
To: Shrirang Bagul <shrirang.bagul@canonical.com>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, May 3, 2018 at 9:39 AM, Shrirang Bagul
<shrirang.bagul@canonical.com> wrote:
> On Mon, 2018-04-30 at 17:12 +0800, Shrirang Bagul wrote:
>> On Mon, 2018-04-30 at 11:05 +0200, Lorenzo Bianconi wrote:
>> > > On Mon, 2018-04-30 at 09:48 +0200, Lorenzo Bianconi wrote:
>> > > > > CTRL1 register (ODR & BDU settings) gets reset after system comes back
>> > > > > from suspend, causing subsequent reads from the sensor to fail.
>> > > > >
>> > > > > This patch restores the CTRL1 register after resume.
>> > > > >
>> > > >
>> > > > Hi Shrirang,
>> > > >
>> > > > is just CTRL1 reset after suspend/resume or also other registers? are
>> > > > IIO triggers enabled before the suspend or
>> > > > are you reading data from sysfs?
>> > > >
>> > > > > Based on:
>> > > > > git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git iio-for-4.17b
>> > > > >
>> > > > > Fixes: ffebe74b7c95 (iio: humidity: hts221: avoid useless ODR reconfiguration)
>> > > > > Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
>> > > > > ---
>> > > > >  drivers/iio/humidity/hts221_core.c | 13 +++++++------
>> > > > >  1 file changed, 7 insertions(+), 6 deletions(-)
>> > > > >
>> > > > > diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
>> > > > > index 166946d4978d..5d7a652aa6d9 100644
>> > > > > --- a/drivers/iio/humidity/hts221_core.c
>> > > > > +++ b/drivers/iio/humidity/hts221_core.c
>> > > > > @@ -658,12 +658,13 @@ static int __maybe_unused hts221_resume(struct device *dev)
>> > > > >         struct hts221_hw *hw = iio_priv(iio_dev);
>> > > > >         int err = 0;
>> > > > >
>> > > > > -       if (hw->enabled)
>> > > > > -               err = regmap_update_bits(hw->regmap, HTS221_REG_CNTRL1_ADDR,
>> > > > > -                                        HTS221_ENABLE_MASK,
>> > > > > -                                        FIELD_PREP(HTS221_ENABLE_MASK,
>> > > > > -                                                   true));
>> > > > > -       return err;
>> > > > > +       err = regmap_update_bits(hw->regmap, HTS221_REG_CNTRL1_ADDR,
>> > > > > +                                HTS221_BDU_MASK,
>> > > > > +                                FIELD_PREP(HTS221_BDU_MASK, 1));
>> > > > > +       if (err < 0)
>> > > > > +               return err;
>> > > > > +
>> > > > > +       return hts221_update_odr(hw, hw->odr);
>> > > > >  }
>> > > > >
>> > >
>> > > No need to re-enable the sensor here. hts221_read_oneshot() [called from hts221_read_raw()] does that every time before read:
>> > >
>> >
>> > Could please try to change other registers (e.g. rh or temp gain) and
>> > double check values are properly configured resuming the sensor?
> Further testing revealed that the contents of AV_CONF register value gets
> overwritten (set to 0x3F) every time system comes out of suspend.

Do you mean register HTS221_REG_AVG_ADDR (0x10)? 0x3f means oversampling_ratio
is set to max allowed value. It is a little bit weird since I tested
the sensor with an oscilloscope
before and after the suspend/resume operations and it seemed to work properly.
Could you please double-check the sensor is properly powered-up during
the suspend phase
(VDD line)?

Regards,
Lorenzo

>> > It is necessary to re-enable the sensor if you use IIO triggers and
>> > the sensor was enabled before the suspend operation
> Yes, I understand this is required, will handle this and restoring the AV_CONF
> register in the next version.
>
> I've tried using sysfs_trig_iio to test reading the sensor output from devfs
> (using iio_generic_buffer) but looks like this is not supported in the current
> driver. HW interrupts cannot be used on my system.
> Please suggest if there are other alternatives?
>>
>> Sure. I'll do some more testing and share the results.
>
>> >
>> > > static int hts221_read_oneshot(struct hts221_hw *hw, u8 addr, int *val)
>> > > {
>> > >         __le16 data;
>> > >         int err;
>> > >
>> > >         err = hts221_set_enable(hw, true);
>> > >         if (err < 0)
>> > >                 return err;
>> > >
>> > >         msleep(50);
>> > >
>> > >         err = regmap_bulk_read(hw->regmap, addr, &data, sizeof(data));
>> > >         if (err < 0)
>> > >                 return err;
>> > >
>> > >         hts221_set_enable(hw, false);
>> > >
>> > > Regards,
>> > > Shrirang
>> > > >
>> > > > Here you need to re-enable the sensor if it was running before the
>> > > > suspend operation.
>> > > > Regards,
>> > > >
>> > > > Lorenzo
>> > > >
>> > > > >  const struct dev_pm_ops hts221_pm_ops = {
>> > > > > --
>> > > > > 2.14.1
>> > > > >
>> > > >
>> > > >
>> > > >
>> >
>> >



-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch;
unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp;
umount; make clean; sleep
