Return-Path: <SRS0=3AiK=6M=gmail.com=lorenzo.bianconi83@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170709192827.2c343108@kernel.org>
References: <20170709165704.26311-1-lorenzo.bianconi@st.com>
 <20170709165704.26311-2-lorenzo.bianconi@st.com> <20170709192827.2c343108@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date: Sun, 9 Jul 2017 23:18:47 +0200
Message-ID: <CAA2SeNJmUFp7WaOsAEq+yLMSKrzQVkhmyMhB2OVWsbBAmv4nCg@mail.gmail.com>
Subject: Re: [PATCH 1/9] iio: humidity: hts221: refactor write_with_mask code
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Lorenzo BIANCONI <lorenzo.bianconi@st.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

> On Sun,  9 Jul 2017 18:56:56 +0200
> Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:
>
>> Move bit-shift in hts221_write_with_mask() instead of coding
>> the shift depth in the configured value. That change will be necessary
>> to fix an issue in device power-down procedure
>>
>> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
> A could of questions inline.

Hi Jonathan,

Thanks for quick review :)

>
> Jonathan
>> ---
>>  drivers/iio/humidity/hts221_core.c | 74 +++++++++++++++++---------------------
>>  1 file changed, 32 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
>> index a56da3999e00..f5181e4e1eff 100644
>> --- a/drivers/iio/humidity/hts221_core.c
>> +++ b/drivers/iio/humidity/hts221_core.c
>> @@ -32,30 +32,12 @@
>>  #define HTS221_HUMIDITY_AVG_MASK     0x07
>>  #define HTS221_TEMP_AVG_MASK         0x38
>>
>> -#define HTS221_ODR_MASK                      0x87
>> +#define HTS221_ODR_MASK                      0x03
>>  #define HTS221_BDU_MASK                      BIT(2)
>> +#define HTS221_ENABLE_MASK           BIT(7)
>>
>>  #define HTS221_DRDY_MASK             BIT(2)
>>
>> -#define HTS221_ENABLE_SENSOR         BIT(7)
>> -
>> -#define HTS221_HUMIDITY_AVG_4                0x00 /* 0.4 %RH */
>> -#define HTS221_HUMIDITY_AVG_8                0x01 /* 0.3 %RH */
>> -#define HTS221_HUMIDITY_AVG_16               0x02 /* 0.2 %RH */
>> -#define HTS221_HUMIDITY_AVG_32               0x03 /* 0.15 %RH */
>> -#define HTS221_HUMIDITY_AVG_64               0x04 /* 0.1 %RH */
>> -#define HTS221_HUMIDITY_AVG_128              0x05 /* 0.07 %RH */
>> -#define HTS221_HUMIDITY_AVG_256              0x06 /* 0.05 %RH */
>> -#define HTS221_HUMIDITY_AVG_512              0x07 /* 0.03 %RH */
>> -
>> -#define HTS221_TEMP_AVG_2            0x00 /* 0.08 degC */
>> -#define HTS221_TEMP_AVG_4            0x08 /* 0.05 degC */
>> -#define HTS221_TEMP_AVG_8            0x10 /* 0.04 degC */
>> -#define HTS221_TEMP_AVG_16           0x18 /* 0.03 degC */
>> -#define HTS221_TEMP_AVG_32           0x20 /* 0.02 degC */
>> -#define HTS221_TEMP_AVG_64           0x28 /* 0.015 degC */
>> -#define HTS221_TEMP_AVG_128          0x30 /* 0.01 degC */
>> -#define HTS221_TEMP_AVG_256          0x38 /* 0.007 degC */
>>
>>  /* calibration registers */
>>  #define HTS221_REG_0RH_CAL_X_H               0x36
>> @@ -90,28 +72,28 @@ static const struct hts221_avg hts221_avg_list[] = {
>>               .addr = HTS221_REG_AVG_ADDR,
>>               .mask = HTS221_HUMIDITY_AVG_MASK,
>>               .avg_avl = {
>> -                     { 4, HTS221_HUMIDITY_AVG_4 },
>> -                     { 8, HTS221_HUMIDITY_AVG_8 },
>> -                     { 16, HTS221_HUMIDITY_AVG_16 },
>> -                     { 32, HTS221_HUMIDITY_AVG_32 },
>> -                     { 64, HTS221_HUMIDITY_AVG_64 },
>> -                     { 128, HTS221_HUMIDITY_AVG_128 },
>> -                     { 256, HTS221_HUMIDITY_AVG_256 },
>> -                     { 512, HTS221_HUMIDITY_AVG_512 },
>> +                     {   4, 0x0 }, /* 0.4 %RH */
>> +                     {   8, 0x1 }, /* 0.3 %RH */
>> +                     {  16, 0x2 }, /* 0.2 %RH */
>> +                     {  32, 0x3 }, /* 0.15 %RH */
>> +                     {  64, 0x4 }, /* 0.1 %RH */
>> +                     { 128, 0x5 }, /* 0.07 %RH */
>> +                     { 256, 0x6 }, /* 0.05 %RH */
>> +                     { 512, 0x7 }, /* 0.03 %RH */
>>               },
>>       },
>>       {
>>               .addr = HTS221_REG_AVG_ADDR,
>>               .mask = HTS221_TEMP_AVG_MASK,
>>               .avg_avl = {
>> -                     { 2, HTS221_TEMP_AVG_2 },
>> -                     { 4, HTS221_TEMP_AVG_4 },
>> -                     { 8, HTS221_TEMP_AVG_8 },
>> -                     { 16, HTS221_TEMP_AVG_16 },
>> -                     { 32, HTS221_TEMP_AVG_32 },
>> -                     { 64, HTS221_TEMP_AVG_64 },
>> -                     { 128, HTS221_TEMP_AVG_128 },
>> -                     { 256, HTS221_TEMP_AVG_256 },
>> +                     {   2, 0x0 }, /* 0.08 degC */
>> +                     {   4, 0x1 }, /* 0.05 degC */
>> +                     {   8, 0x2 }, /* 0.04 degC */
>> +                     {  16, 0x3 }, /* 0.03 degC */
>> +                     {  32, 0x4 }, /* 0.02 degC */
>> +                     {  64, 0x5 }, /* 0.015 degC */
>> +                     { 128, 0x6 }, /* 0.01 degC */
>> +                     { 256, 0x7 }, /* 0.007 degC */
> Could we potentially use the index directly here rather than
> having to explicitly store it?  Would be more elegant perhaps..

Ack, will do in v2

>>               },
>>       },
>>  };
>> @@ -166,7 +148,7 @@ static int hts221_write_with_mask(struct hts221_hw *hw, u8 addr, u8 mask,
>>               goto unlock;
>>       }
>>
>> -     data = (data & ~mask) | (val & mask);
>> +     data = (data & ~mask) | ((val << __ffs(mask)) & mask);
>>
>>       err = hw->tf->write(hw->dev, addr, sizeof(data), &data);
>>       if (err < 0)
>> @@ -201,11 +183,10 @@ static int hts221_check_whoami(struct hts221_hw *hw)
>>
>>  int hts221_config_drdy(struct hts221_hw *hw, bool enable)
>>  {
>> -     u8 val = enable ? BIT(2) : 0;
>>       int err;
>>
>>       err = hts221_write_with_mask(hw, HTS221_REG_CNTRL3_ADDR,
>> -                                  HTS221_DRDY_MASK, val);
>> +                                  HTS221_DRDY_MASK, enable);
>>
>>       return err < 0 ? err : 0;
>>  }
>> @@ -213,7 +194,6 @@ int hts221_config_drdy(struct hts221_hw *hw, bool enable)
>>  static int hts221_update_odr(struct hts221_hw *hw, u8 odr)
>>  {
>>       int i, err;
>> -     u8 val;
>>
>>       for (i = 0; i < ARRAY_SIZE(hts221_odr_table); i++)
>>               if (hts221_odr_table[i].hz == odr)
>> @@ -222,9 +202,19 @@ static int hts221_update_odr(struct hts221_hw *hw, u8 odr)
>>       if (i == ARRAY_SIZE(hts221_odr_table))
>>               return -EINVAL;
>>
>> -     val = HTS221_ENABLE_SENSOR | HTS221_BDU_MASK | hts221_odr_table[i].val;
>> +     /* enable Block Data Update */
>> +     err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
>> +                                  HTS221_BDU_MASK, 1);
>> +     if (err < 0)
>> +             return err;
>> +
>> +     err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
>> +                                  HTS221_ODR_MASK, hts221_odr_table[i].val);
>> +     if (err < 0)
>> +             return err;
>> +
>>       err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
>> -                                  HTS221_ODR_MASK, val);
> This original code looks like a bug given the odr mask should only
> cover the odr bits, not the enable and bdu.
>
> Am I missing something?

Base on hts221_write_with_mask() code the original mask covers odr,
bdu and enable fields in CNTRL1 register.

>
> Taking one write and changing it to 3 isn't that nice, but I guess
> we aren't in a fast path here so fair enough given the cleaner
> resulting code.
>> +                                  HTS221_ENABLE_MASK, 1);
>>       if (err < 0)
>>               return err;
>>
>

Regards,
Lorenzo



-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch;
unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp;
umount; make clean; sleep
