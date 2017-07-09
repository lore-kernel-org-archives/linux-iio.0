Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34221 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752596AbdGIV00 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Jul 2017 17:26:26 -0400
MIME-Version: 1.0
In-Reply-To: <20170709193042.330fcd60@kernel.org>
References: <20170709165704.26311-1-lorenzo.bianconi@st.com>
 <20170709165704.26311-4-lorenzo.bianconi@st.com> <20170709193042.330fcd60@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date: Sun, 9 Jul 2017 23:26:24 +0200
Message-ID: <CAA2SeNKA8dos=8fOeK8pgeofPhSVfZPnOXoE1C=qaQKQb_n-vQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] iio: humidity: hts221: do not overwrite reserved data
 during power-down
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Lorenzo BIANCONI <lorenzo.bianconi@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> On Sun,  9 Jul 2017 18:56:58 +0200
> Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:
>
>> Fixes: e4a70e3e7d84 (iio: humidity: add support to hts221 rh/temp device)
>> Fixes: b7079eeac5da (iio: humidity: hts221: add power management support)
>> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
> This needs more description.  What is the effect of this?
>
> Which bits of data are we writing that we shouldn't be touching?

GENMASK(6, 3) in CTRL_REG1 and GENMASK(6, 2) in CTRL_REG2 are marked
reserved so it is better to not changed the original value (not
declared in the datasheet).
I will add a comment in v2

Regards,
Lorenzo

>
>
>> ---
>>  drivers/iio/humidity/hts221_core.c | 10 ++++------
>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
>> index 9546b0ea6283..b36734b8070e 100644
>> --- a/drivers/iio/humidity/hts221_core.c
>> +++ b/drivers/iio/humidity/hts221_core.c
>> @@ -305,11 +305,10 @@ int hts221_power_on(struct hts221_hw *hw)
>>
>>  int hts221_power_off(struct hts221_hw *hw)
>>  {
>> -     __le16 data = 0;
>>       int err;
>>
>> -     err = hw->tf->write(hw->dev, HTS221_REG_CNTRL1_ADDR, sizeof(data),
>> -                         (u8 *)&data);
>> +     err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
>> +                                  HTS221_ENABLE_MASK, false);
>>       if (err < 0)
>>               return err;
>>
>> @@ -692,11 +691,10 @@ static int __maybe_unused hts221_suspend(struct device *dev)
>>  {
>>       struct iio_dev *iio_dev = dev_get_drvdata(dev);
>>       struct hts221_hw *hw = iio_priv(iio_dev);
>> -     __le16 data = 0;
>>       int err;
>>
>> -     err = hw->tf->write(hw->dev, HTS221_REG_CNTRL1_ADDR, sizeof(data),
>> -                         (u8 *)&data);
>> +     err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
>> +                                  HTS221_ENABLE_MASK, false);
>>
>>       return err < 0 ? err : 0;
>>  }
>



-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch;
unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp;
umount; make clean; sleep
