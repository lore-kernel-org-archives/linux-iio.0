Return-Path: <SRS0=3AiK=6M=gmail.com=lorenzo.bianconi83@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170709194123.39fd6914@kernel.org>
References: <20170709165704.26311-1-lorenzo.bianconi@st.com>
 <20170709165704.26311-10-lorenzo.bianconi@st.com> <20170709194123.39fd6914@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date: Sun, 9 Jul 2017 23:28:29 +0200
Message-ID: <CAA2SeNLhBbTbMGDHyXGN02V4n0RHrwK-Bg0D_q9phpcEa3e7Rw@mail.gmail.com>
Subject: Re: [PATCH 9/9] iio: humidity: hts221: move drdy enable logic in hts221_trig_set_state()
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Lorenzo BIANCONI <lorenzo.bianconi@st.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

> On Sun,  9 Jul 2017 18:57:04 +0200
> Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:
>
>> Move data-ready configuration in hts221_buffer.c since it is only related
>> to trigger logic
>>
>> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
> The rest of the series looks good to me.  We are early in the cycle
> so should have plenty of time to pin down the question on how to handle
> irq line inversion visibility to the kernel.

Fine, pretty interesting stuff :)
Regards,
Lorenzo

>
> Jonathan
>> ---
>>  drivers/iio/humidity/hts221.h        |  1 -
>>  drivers/iio/humidity/hts221_buffer.c |  8 +++++++-
>>  drivers/iio/humidity/hts221_core.c   | 14 --------------
>>  3 files changed, 7 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/iio/humidity/hts221.h b/drivers/iio/humidity/hts221.h
>> index 0fbc89fe213d..2b4e5246447a 100644
>> --- a/drivers/iio/humidity/hts221.h
>> +++ b/drivers/iio/humidity/hts221.h
>> @@ -66,7 +66,6 @@ struct hts221_hw {
>>
>>  extern const struct dev_pm_ops hts221_pm_ops;
>>
>> -int hts221_config_drdy(struct hts221_hw *hw, bool enable);
>>  int hts221_write_with_mask(struct hts221_hw *hw, u8 addr, u8 mask, u8 val);
>>  int hts221_probe(struct iio_dev *iio_dev);
>>  int hts221_set_enable(struct hts221_hw *hw, bool enable);
>> diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
>> index f29f01a22375..9690dfe9a844 100644
>> --- a/drivers/iio/humidity/hts221_buffer.c
>> +++ b/drivers/iio/humidity/hts221_buffer.c
>> @@ -28,6 +28,8 @@
>>  #define HTS221_REG_DRDY_HL_MASK              BIT(7)
>>  #define HTS221_REG_DRDY_PP_OD_ADDR   0x22
>>  #define HTS221_REG_DRDY_PP_OD_MASK   BIT(6)
>> +#define HTS221_REG_DRDY_EN_ADDR              0x22
>> +#define HTS221_REG_DRDY_EN_MASK              BIT(2)
>>  #define HTS221_REG_STATUS_ADDR               0x27
>>  #define HTS221_RH_DRDY_MASK          BIT(1)
>>  #define HTS221_TEMP_DRDY_MASK                BIT(0)
>> @@ -36,8 +38,12 @@ static int hts221_trig_set_state(struct iio_trigger *trig, bool state)
>>  {
>>       struct iio_dev *iio_dev = iio_trigger_get_drvdata(trig);
>>       struct hts221_hw *hw = iio_priv(iio_dev);
>> +     int err;
>> +
>> +     err = hts221_write_with_mask(hw, HTS221_REG_DRDY_EN_ADDR,
>> +                                  HTS221_REG_DRDY_EN_MASK, state);
>>
>> -     return hts221_config_drdy(hw, state);
>> +     return err < 0 ? err : 0;
>>  }
>>
>>  static const struct iio_trigger_ops hts221_trigger_ops = {
>> diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
>> index dfacf64a6f2e..12c2bc5954e4 100644
>> --- a/drivers/iio/humidity/hts221_core.c
>> +++ b/drivers/iio/humidity/hts221_core.c
>> @@ -23,7 +23,6 @@
>>
>>  #define HTS221_REG_CNTRL1_ADDR               0x20
>>  #define HTS221_REG_CNTRL2_ADDR               0x21
>> -#define HTS221_REG_CNTRL3_ADDR               0x22
>>
>>  #define HTS221_REG_AVG_ADDR          0x10
>>  #define HTS221_REG_H_OUT_L           0x28
>> @@ -36,9 +35,6 @@
>>  #define HTS221_BDU_MASK                      BIT(2)
>>  #define HTS221_ENABLE_MASK           BIT(7)
>>
>> -#define HTS221_DRDY_MASK             BIT(2)
>> -
>> -
>>  /* calibration registers */
>>  #define HTS221_REG_0RH_CAL_X_H               0x36
>>  #define HTS221_REG_1RH_CAL_X_H               0x3a
>> @@ -180,16 +176,6 @@ static int hts221_check_whoami(struct hts221_hw *hw)
>>       return 0;
>>  }
>>
>> -int hts221_config_drdy(struct hts221_hw *hw, bool enable)
>> -{
>> -     int err;
>> -
>> -     err = hts221_write_with_mask(hw, HTS221_REG_CNTRL3_ADDR,
>> -                                  HTS221_DRDY_MASK, enable);
>> -
>> -     return err < 0 ? err : 0;
>> -}
>> -
>>  static int hts221_update_odr(struct hts221_hw *hw, u8 odr)
>>  {
>>       int i, err;
>



-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch;
unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp;
umount; make clean; sleep
