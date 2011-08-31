Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:16680
	"EHLO VA3EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754732Ab1HaLup convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 31 Aug 2011 07:50:45 -0400
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	Drivers <Drivers@analog.com>
Date: Wed, 31 Aug 2011 12:49:41 +0100
Subject: RE: [PATCH 05/12] iio: ad7291: don't swab results twice and
 introduce more register defines
Message-ID: <544AC56F16B56944AEC3BD4E3D59177146E6F63983@LIMKCMBX1.ad.analog.com>
References: <1314788260-5791-1-git-send-email-michael.hennerich@analog.com>
 <1314788260-5791-5-git-send-email-michael.hennerich@analog.com>
 <4E5E1AEA.9060808@cam.ac.uk>
In-Reply-To: <4E5E1AEA.9060808@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan Cameron wrote on 2011-08-31:
> On 08/31/11 11:57, michael.hennerich@analog.com wrote:
>> From: Michael Hennerich <michael.hennerich@analog.com>
>>
> oops. my bad on the double swab I think. Anyhow all looks sane an good.
> That fixme with the reverse register order is odd.  Guessing you are
> chasing that down with the hardware guys?

If you like you can remove the FIXME.
I checked the behavior on hardware, and it seems to be a datasheet errata.

>>
>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com> merged
>> ---
>>  drivers/staging/iio/adc/ad7291.c |   90 ++++++++++++++++++++++++----
>>  --------- 1 files changed, 58 insertions(+), 32 deletions(-)
>> diff --git a/drivers/staging/iio/adc/ad7291.c
>> b/drivers/staging/iio/adc/ad7291.c index 382ca3e..2fafca7 100644 ---
>> a/drivers/staging/iio/adc/ad7291.c +++
>> b/drivers/staging/iio/adc/ad7291.c @@ -33,18 +33,43 @@
>>  /*
>>   * AD7291 registers definition
>>   */
>> -#define AD7291_COMMAND                      0
>> -#define AD7291_VOLTAGE                      1
>> -#define AD7291_T_SENSE                      2
>> -#define AD7291_T_AVERAGE            3
>> -#define AD7291_VOLTAGE_LIMIT_BASE   4
>> -#define AD7291_VOLTAGE_LIMIT_COUNT  8
>> +#define AD7291_COMMAND                      0x00
>> +#define AD7291_VOLTAGE                      0x01
>> +#define AD7291_T_SENSE                      0x02
>> +#define AD7291_T_AVERAGE            0x03
>> +#define AD7291_CH0_DATA_HIGH                0x04
>> +#define AD7291_CH0_DATA_LOW         0x05
>> +#define AD7291_CH0_HYST                     0x06
>> +#define AD7291_CH1_DATA_HIGH                0x07
>> +#define AD7291_CH1_DATA_LOW         0x08
>> +#define AD7291_CH1_HYST                     0x09
>> +#define AD7291_CH2_DATA_HIGH                0x0A
>> +#define AD7291_CH2_DATA_LOW         0x0B
>> +#define AD7291_CH2_HYST                     0x0C
>> +#define AD7291_CH3_DATA_HIGH                0x0D
>> +#define AD7291_CH3_DATA_LOW         0x0E
>> +#define AD7291_CH3_HYST                     0x0F
>> +#define AD7291_CH4_DATA_HIGH                0x10
>> +#define AD7291_CH4_DATA_LOW         0x11
>> +#define AD7291_CH4_HYST                     0x12
>> +#define AD7291_CH5_DATA_HIGH                0x13
>> +#define AD7291_CH5_DATA_LOW         0x14
>> +#define AD7291_CH5_HYST                     0x15
>> +#define AD7291_CH6_DATA_HIGH                0x16
>> +#define AD7291_CH6_DATA_LOW         0x17
>> +#define AD7291_CH6_HYST                     0x18
>> +#define AD7291_CH7_DATA_HIGH                0x19
>> +#define AD7291_CH7_DATA_LOW         0x1A
>> +#define AD7291_CH7_HYST                     0x2B
>>  #define AD7291_T_SENSE_HIGH         0x1C
>>  #define AD7291_T_SENSE_LOW          0x1D
>>  #define AD7291_T_SENSE_HYST         0x1E
>>  #define AD7291_VOLTAGE_ALERT_STATUS 0x1F
>>  #define AD7291_T_ALERT_STATUS               0x20
>> +#define AD7291_VOLTAGE_LIMIT_COUNT  8
>> +
>> +
>>  /*
>>   * AD7291 command
>>   */
>> @@ -197,7 +222,7 @@ static inline ssize_t ad7291_show_hyst(struct
> device *dev,
>>      if (ret < 0)
>>              return ret;
>> -    return sprintf(buf, "%d\n", data & 0x0FFF);
>> +    return sprintf(buf, "%d\n", data & AD7291_VALUE_MASK);
>>  }
>>
>>  static inline ssize_t ad7291_set_hyst(struct device *dev,
>> @@ -227,28 +252,28 @@ static
> IIO_DEVICE_ATTR(in_temp0_thresh_both_hyst_raw,
>>                     AD7291_T_SENSE_HYST);
>>  static IIO_DEVICE_ATTR(in_voltage0_thresh_both_hyst_raw,
>>                     S_IRUGO | S_IWUSR,
>> -                   ad7291_show_hyst, ad7291_set_hyst, 0x06);
>> +                   ad7291_show_hyst, ad7291_set_hyst, AD7291_CH0_HYST);
>>  static IIO_DEVICE_ATTR(in_voltage1_thresh_both_hyst_raw,
>>                     S_IRUGO | S_IWUSR,
>> -                   ad7291_show_hyst, ad7291_set_hyst, 0x09);
>> +                   ad7291_show_hyst, ad7291_set_hyst, AD7291_CH1_HYST);
>>  static IIO_DEVICE_ATTR(in_voltage2_thresh_both_hyst_raw,
>>                     S_IRUGO | S_IWUSR,
>> -                   ad7291_show_hyst, ad7291_set_hyst, 0x0C);
>> +                   ad7291_show_hyst, ad7291_set_hyst, AD7291_CH2_HYST);
>>  static IIO_DEVICE_ATTR(in_voltage3_thresh_both_hyst_raw,
>>                     S_IRUGO | S_IWUSR,
>> -                   ad7291_show_hyst, ad7291_set_hyst, 0x0F);
>> +                   ad7291_show_hyst, ad7291_set_hyst, AD7291_CH3_HYST);
>>  static IIO_DEVICE_ATTR(in_voltage4_thresh_both_hyst_raw,
>>                     S_IRUGO | S_IWUSR,
>> -                   ad7291_show_hyst, ad7291_set_hyst, 0x12);
>> +                   ad7291_show_hyst, ad7291_set_hyst, AD7291_CH4_HYST);
>>  static IIO_DEVICE_ATTR(in_voltage5_thresh_both_hyst_raw,
>>                     S_IRUGO | S_IWUSR,
>> -                   ad7291_show_hyst, ad7291_set_hyst, 0x15);
>> +                   ad7291_show_hyst, ad7291_set_hyst, AD7291_CH5_HYST);
>>  static IIO_DEVICE_ATTR(in_voltage6_thresh_both_hyst_raw,
>>                     S_IRUGO | S_IWUSR,
>> -                   ad7291_show_hyst, ad7291_set_hyst, 0x18);
>> +                   ad7291_show_hyst, ad7291_set_hyst, AD7291_CH6_HYST);
>>  static IIO_DEVICE_ATTR(in_voltage7_thresh_both_hyst_raw,
>>                     S_IRUGO | S_IWUSR,
>> -                   ad7291_show_hyst, ad7291_set_hyst, 0x1B);
>> +                   ad7291_show_hyst, ad7291_set_hyst, AD7291_CH7_HYST);
>>
>>  static struct attribute *ad7291_event_attributes[] = {
>>      &iio_dev_attr_in_temp0_thresh_both_hyst_raw.dev_attr.attr,
>> @@ -265,16 +290,16 @@ static struct attribute
>> *ad7291_event_attributes[] = {
>>
>>  /* high / low */
>>  static u8 ad7291_limit_regs[9][2] = {
>> -    { 0x04, 0x05 },
>> -    { 0x07, 0x08 },
>> -    { 0x0A, 0x0B },
>> -    { 0x0E, 0x0D }, /* note reversed order */
>> -    { 0x10, 0x11 },
>> -    { 0x13, 0x14 },
>> -    { 0x16, 0x17 },
>> -    { 0x19, 0x1A },
>> +    { AD7291_CH0_DATA_HIGH, AD7291_CH0_DATA_LOW },
>> +    { AD7291_CH1_DATA_HIGH, AD7291_CH1_DATA_LOW },
>> +    { AD7291_CH2_DATA_HIGH, AD7291_CH2_DATA_LOW },
>> +    { AD7291_CH3_DATA_HIGH, AD7291_CH3_DATA_LOW }, /* FIXME: ? */
>> +    { AD7291_CH4_DATA_HIGH, AD7291_CH4_DATA_LOW },
>> +    { AD7291_CH5_DATA_HIGH, AD7291_CH5_DATA_LOW },
>> +    { AD7291_CH6_DATA_HIGH, AD7291_CH6_DATA_LOW },
>> +    { AD7291_CH7_DATA_HIGH, AD7291_CH7_DATA_LOW },
>>      /* temp */
>> -    { 0x1C, 0x1D },
>> +    { AD7291_T_SENSE_HIGH, AD7291_T_SENSE_LOW },
>>  };
>>
>>  static int ad7291_read_event_value(struct iio_dev *indio_dev,
>> @@ -297,7 +322,7 @@ static int ad7291_read_event_value(struct iio_dev
> *indio_dev,
>>              ret = ad7291_i2c_read(chip, reg, &uval);
>>              if (ret < 0)
>>                      return ret;
>> -            *val = swab16(uval) & 0x0FFF;
>> +            *val = uval & AD7291_VALUE_MASK;
>>              return 0;
>>
>>      case IIO_TEMP:
>> @@ -308,7 +333,7 @@ static int ad7291_read_event_value(struct iio_dev
> *indio_dev,
>>              ret = ad7291_i2c_read(chip, reg, &signval);
>>              if (ret < 0)
>>                      return ret;
>> -            signval = (s16)((swab16(signval) & 0x0FFF) << 4) >> 4;
>> +            signval = (s16)((signval & AD7291_VALUE_MASK) << 4) >> 4;
>>              *val = signval;
>>              return 0;
>>      default:
>> @@ -331,9 +356,7 @@ static int ad7291_write_event_value(struct
> iio_dev *indio_dev,
>>              reg = ad7291_limit_regs[IIO_EVENT_CODE_EXTRACT_NUM(event_code)]
>>                      [!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
>>  IIO_EV_DIR_RISING)]; -              return ad7291_i2c_write(chip, reg, val); -
>>      case IIO_TEMP:          if (val > 2047 || val < -2048)                  return -EINVAL;
>> @@ -385,6 +408,7 @@ static int ad7291_write_event_config(struct
> iio_dev *indio_dev,
>>       * use continuous sampling mode.         * Possible to disable temp as well
>>  but that makes single read tricky.   */ +   switch
>>  (IIO_EVENT_CODE_EXTRACT_TYPE(event_code)) {         case IIO_VOLTAGE:               if
>>  ((!state) && (chip->c_mask &
>> @@ -398,7 +422,7 @@ static int ad7291_write_event_config(struct
> iio_dev *indio_dev,
>>              else
>>                      break;
>> -            regval &= 0xFFFE;
>> +            regval &= ~AD7291_AUTOCYCLE;
>>              regval |= ((u16)chip->c_mask << 8);
>>              if (chip->c_mask) /* Enable autocycle? */
>>                      regval |= AD7291_AUTOCYCLE;
>> @@ -455,7 +479,7 @@ static int ad7291_read_raw(struct iio_dev
> *indio_dev,
>>                              mutex_unlock(&chip->state_lock);
>>                              return ret;
>>                      }
>> -                    *val = swab16((u16)ret) & 0x0FFF;
>> +                    *val = swab16((u16)ret) & AD7291_VALUE_MASK;
>>                      mutex_unlock(&chip->state_lock);
>>                      return IIO_VAL_INT;
>>              case IIO_TEMP:
>> @@ -464,7 +488,8 @@ static int ad7291_read_raw(struct iio_dev
> *indio_dev,
>>                                                     AD7291_T_SENSE);
>>                      if (ret < 0)
>>                              return ret;
>> -                    signval = (s16)((swab16((u16)ret) & 0x0FFF) << 4) >> 4; +                       signval
>> = (s16)((swab16((u16)ret) & +                                AD7291_VALUE_MASK) << 4) >> 4;
>>                      *val = signval;
>>                      return IIO_VAL_INT;
>>              default:
>> @@ -475,7 +500,8 @@ static int ad7291_read_raw(struct iio_dev
> *indio_dev,
>>                                             AD7291_T_AVERAGE);
>>                      if (ret < 0)
>>                              return ret;
>> -                    signval = (s16)((swab16((u16)ret) & 0x0FFF) << 4) >> 4; +                       signval
>> = (s16)((swab16((u16)ret) & +                                AD7291_VALUE_MASK) << 4) >> 4;
>>                      *val = signval;
>>                      return IIO_VAL_INT;
>>      case (1 << IIO_CHAN_INFO_SCALE_SHARED):
>

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif



