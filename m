Return-Path: <SRS0=nSRN=4U=gmail.com=lorenzo.bianconi83@kernel.org>
MIME-Version: 1.0
In-Reply-To: <904c2f14-5fc3-9b05-a4e0-30c30963e695@kernel.org>
References: <20170510204005.2576-1-lorenzo.bianconi@st.com>
 <20170510205717.GA18948@607924cbbc93> <20170511093512.GA4932@ctocxl0005.oa.cto.st.com>
 <904c2f14-5fc3-9b05-a4e0-30c30963e695@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date: Sun, 14 May 2017 17:14:29 +0200
Message-ID: <CAA2SeNLavKqd102Vdk0bT1KF9CSyb=Rf-480yXzVJsH51ODiPQ@mail.gmail.com>
Subject: Re: [PATCH] iio: humidity: hts221: add power management support
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lorenzo BIANCONI <lorenzo.bianconi@st.com>, Brian Masney <masneyb@onstation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

> On 11/05/17 10:35, Lorenzo BIANCONI wrote:
>>
>> Hi Brian,
>>
>> Thanks for the review. Comments inline.
>>
>> Regards,
>> Lorenzo
>>
>>> On Wed, May 10, 2017 at 10:40:05PM +0200, Lorenzo Bianconi wrote:
>>>>
>>>> Add system sleep power management support to hts221 driver
>>>>
>>>> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
>>>> ---
>>>>   drivers/iio/humidity/hts221.h      |  3 ++
>>>>   drivers/iio/humidity/hts221_core.c | 56
>>>> +++++++++++++++++++++++++++++++++++---
>>>>   drivers/iio/humidity/hts221_i2c.c  |  1 +
>>>>   drivers/iio/humidity/hts221_spi.c  |  1 +
>>>>   4 files changed, 57 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/iio/humidity/hts221.h
>>>> b/drivers/iio/humidity/hts221.h
>>>> index c7154665512e..94510266e0a5 100644
>>>> --- a/drivers/iio/humidity/hts221.h
>>>> +++ b/drivers/iio/humidity/hts221.h
>>>> @@ -57,12 +57,15 @@ struct hts221_hw {
>>>>         struct hts221_sensor sensors[HTS221_SENSOR_MAX];
>>>>   +     bool enabled;
>>>>         u8 odr;
>>>>         const struct hts221_transfer_function *tf;
>>>>         struct hts221_transfer_buffer tb;
>>>>   };
>>>>   +extern const struct dev_pm_ops hts221_pm_ops;
>>>> +
>>>>   int hts221_config_drdy(struct hts221_hw *hw, bool enable);
>>>>   int hts221_probe(struct iio_dev *iio_dev);
>>>>   int hts221_power_on(struct hts221_hw *hw);
>>>> diff --git a/drivers/iio/humidity/hts221_core.c
>>>> b/drivers/iio/humidity/hts221_core.c
>>>> index 3f3ef4a1a474..ccb07e7f993f 100644
>>>> --- a/drivers/iio/humidity/hts221_core.c
>>>> +++ b/drivers/iio/humidity/hts221_core.c
>>>> @@ -13,6 +13,7 @@
>>>>   #include <linux/device.h>
>>>>   #include <linux/iio/sysfs.h>
>>>>   #include <linux/delay.h>
>>>> +#include <linux/pm.h>
>>>>   #include <asm/unaligned.h>
>>>>     #include "hts221.h"
>>>> @@ -307,15 +308,30 @@ hts221_sysfs_temp_oversampling_avail(struct device
>>>> *dev,
>>>>     int hts221_power_on(struct hts221_hw *hw)
>>>>   {
>>>> -       return hts221_update_odr(hw, hw->odr);
>>>> +       int err;
>>>> +
>>>> +       err = hts221_update_odr(hw, hw->odr);
>>>> +       if (err < 0)
>>>> +               return err;
>>>> +
>>>> +       hw->enabled = true;
>>>> +
>>>> +       return 0;
>>>>   }
>>>>     int hts221_power_off(struct hts221_hw *hw)
>>>>   {
>>>> -       u8 data[] = {0x00, 0x00};
>>>> +       __le16 data = 0;
>>>> +       int err;
>>>>   -     return hw->tf->write(hw->dev, HTS221_REG_CNTRL1_ADDR,
>>>> sizeof(data),
>>>> -                            data);
>>>> +       err = hw->tf->write(hw->dev, HTS221_REG_CNTRL1_ADDR,
>>>> sizeof(data),
>>>> +                           (u8 *)&data);
>>>> +       if (err < 0)
>>>> +               return err;
>>>> +
>>>> +       hw->enabled = false;
>>>> +
>>>> +       return 0;
>>>>   }
>>>>     static int hts221_parse_temp_caldata(struct hts221_hw *hw)
>>>> @@ -682,6 +698,38 @@ int hts221_probe(struct iio_dev *iio_dev)
>>>>   }
>>>>   EXPORT_SYMBOL(hts221_probe);
>>>>   +#ifdef CONFIG_PM
>>>> +static int hts221_suspend(struct device *dev)
>>>
>>>
>>> You can get rid of this #ifdef by adding __maybe_unused to the
>>> _suspend and _resume function declarations. This will allow for
>>> additional compile-time code checking if power management is
>>> disabled.
>>
>>
>> Fair enough :). I did in that way to maintain consistency with other
>> drivers.
>
> More recent thinking is that the ifdef route is a mess hence
> the __maybe_unused option is becoming more common and is the
> preferred choice now.  People are slowly working their way through
> older drivers tidying this up but lots still to do.
>
> Jonathan

Fine, v2 on the way.

Regards,
Lorenzo

>>
>>
>>>
>>> If desired, one way to get rid of the enabled flag would be to
>>> add support for runtime power management to automatically shutdown
>>> the chip after a period of inactivity. See
>>> https://lkml.org/lkml/2017/4/25/101 for an example.
>>>
>>
>> I am not a pm_runtime expert but according to the documentation
>> runtime_suspend
>> callback is called when device's usage counter and counter of 'active'
>> children
>> of the device are equal to 0. Moreover device possible states are
>> 'disabled'
>> (HTS221_REG_CNTRL1_ADDR register set to 0) or 'active'
>> (HTS221_REG_CNTRL1_ADDR
>> register configured with a given sample rate). In the first condition
>> runtime_suspend() will not take any effect whereas in the latter one the
>> callback will not be called since device's usage counter is grater than 0.
>> Moreover implement system-wide pm support through runtime pm support just
>> to
>> avoid a boolean flag seems a little bit overkill to me. What do you think?
>> Is my understanding correct?
>>
>>> Brian
>>
>>
>> -- --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>



-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch;
unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp;
umount; make clean; sleep
