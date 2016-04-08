Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:33899 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758344AbcDHSxl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 8 Apr 2016 14:53:41 -0400
Received: by mail-vk0-f65.google.com with SMTP id a6so6948329vkh.1
        for <linux-iio@vger.kernel.org>; Fri, 08 Apr 2016 11:53:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160408104313.GA12944@vdogaru>
References: <1460044621-17274-1-git-send-email-akinobu.mita@gmail.com>
	<20160408104313.GA12944@vdogaru>
Date: Sat, 9 Apr 2016 03:53:39 +0900
Message-ID: <CAC5umyjDk_LE-g+yJ5Lin+OPE2T5-3_V5VO_tO+F5TGaPp=tvg@mail.gmail.com>
Subject: Re: [PATCH] iio: pressure: bmp280: add support for BMP180
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Vlad Dogaru <vlad.dogaru@intel.com>
Cc: linux-iio@vger.kernel.org,
	Christoph Mair <christoph.mair@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

2016-04-08 19:43 GMT+09:00 Vlad Dogaru <vlad.dogaru@intel.com>:
> On Fri, Apr 08, 2016 at 12:57:01AM +0900, Akinobu Mita wrote:
>> This adds support for the BMP180 to the bmp280 iio driver.
>> The BMP180 has already been supported by misc/bmp085 driver but it
>> doesn't use iio framework.
>>
>> This also adds ability to control the oversampling ratio of the
>> temperature and pressure measurement for both bmp180 and bmp280.
>> (bmp280 is untested)
>
> I think this would be better as two separate patches: one that adds
> support for the new chip, and the second which adds the oversampling
> ratio.  Once you split these up, I can validate that oversampling works
> with the bmp280.

Sounds good.

>> @@ -310,22 +374,135 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
>>       return ret;
>>  }
>>
>> +static int bmp280_write_oversampling_ratio_temp(struct bmp280_data *data,
>> +                                            int val)
>> +{
>> +     int i;
>> +     const int *avail = data->oversampling_temp_avail;
>> +     const int n = data->num_oversampling_temp_avail;
>> +
>> +     for (i = 0; i < n; i++) {
>> +             if (avail[i] == val) {
>> +                     data->oversampling_temp = ilog2(val);
>> +
>> +                     return data->ops->init(data);
>> +             }
>> +     }
>> +     return -EINVAL;
>> +}
>> +
>> +static int bmp280_write_oversampling_ratio_press(struct bmp280_data *data,
>> +                                            int val)
>> +{
>> +     int i;
>> +     const int *avail = data->oversampling_press_avail;
>> +     const int n = data->num_oversampling_press_avail;
>> +
>> +     for (i = 0; i < n; i++) {
>> +             if (avail[i] == val) {
>> +                     data->oversampling_press = ilog2(val);
>> +
>> +                     return data->ops->init(data);
>
> I find it odd that we're calling a function named "init" at something
> other than initialization, maybe change it to "write_config" or
> something similar?  But the logic for bmp280 seems good.

OK.  I'll rename to "config".

>> +static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
>> +{
>> +     int ret;
>> +     const int conversion_time_max[] = { 4500, 7500, 13500, 25500 };
>> +     unsigned int delay_us;
>> +     unsigned int ctrl;
>> +
>> +     ret = regmap_write(data->regmap, BMP280_REG_CTRL_MEAS, ctrl_meas);
>> +     if (ret)
>> +             return ret;
>> +
>> +     if (ctrl_meas == BMP180_MEAS_TEMP)
>> +             delay_us = 4500;
>> +     else
>> +             delay_us = conversion_time_max[data->oversampling_press];
>> +
>> +     usleep_range(delay_us, delay_us + 1000);
>> +
>> +     ret = regmap_read(data->regmap, BMP280_REG_CTRL_MEAS, &ctrl);
>> +     if (ret)
>> +             return ret;
>> +
>> +     /*
>> +      * The value of this bit reset to "0" after conversion is complete
>> +      */
>> +     if (ctrl & BMP180_MEAS_SCO)
>> +             return -EIO;
>> +
>> +     return 0;
>> +}

...

>> +static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
>> +{
>> +     int ret;
>> +     __be32 tmp = 0;
>> +     u8 oss = data->oversampling_press;
>> +
>> +     ret = bmp180_measure(data, BMP180_MEAS_PRESS_X(oss));
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB, (u8 *)&tmp, 3);
>> +     if (ret)
>> +             return ret;
>> +
>> +     *val = (be32_to_cpu(tmp) >> 8) >> (8 - oss);
>> +
>> +     return 0;
>> +}
>> +
>> +/*
>> + * Returns pressure in Pa, resolution is 1 Pa.
>> + *
>> + * Taken from datasheet, Section 3.5, "Calculating pressure and temperature".
>> + */
>> +static u32 bmp180_compensate_press(struct bmp280_data *data, s32 adc_press)
>> +{
>> +     int ret;
>> +     s32 x1, x2, x3, p;
>> +     s32 b3, b6;
>> +     u32 b4, b7;
>> +     s32 oss = data->oversampling_press;
>> +     struct bmp180_calib calib;
>> +
>> +     ret = bmp180_read_calib(data, &calib);
>> +     if (ret < 0) {
>> +             dev_err(&data->client->dev,
>> +                     "failed to read calibration coefficients\n");
>> +             return ret;
>> +     }
>> +
>> +     b6 = data->t_fine - 4000;
>> +     x1 = (calib.B2 * (b6 * b6 >> 12)) >> 11;
>> +     x2 = calib.AC2 * b6 >> 11;
>> +     x3 = x1 + x2;
>> +     b3 = (((calib.AC1 * 4 + x3) << oss) + 2) / 4;
>> +     x1 = calib.AC3 * b6 >> 13;
>> +     x2 = (calib.B1 * ((b6 * b6) >> 12)) >> 16;
>> +     x3 = (x1 + x2 + 2) >> 2;
>> +     b4 = calib.AC4 * (u32)(x3 + 32768) >> 15;
>> +     b7 = ((u32)adc_press - b3) * (50000 >> oss);
>> +     if (b7 < 0x80000000)
>> +             p = (b7 * 2) / b4;
>> +     else
>> +             p = (b7 / b4) * 2;
>> +
>> +     x1 = (p >> 8) * (p >> 8);
>> +     x1 = (x1 * 3038) >> 16;
>> +     x2 = (-7357 * p) >> 16;
>> +
>> +     return p + ((x1 + x2 + 3791) >> 4);
>> +}
>> +
>> +static int bmp180_read_press(struct bmp280_data *data,
>> +                          int *val, int *val2)
>> +{
>> +     int ret;
>> +     s32 adc_press;
>> +     u32 comp_press;
>> +
>> +     /* Read and compensate temperature so we get a reading of t_fine. */
>> +     ret = bmp180_read_temp(data, NULL);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = bmp180_read_adc_press(data, &adc_press);
>> +     if (ret)
>> +             return ret;
>> +
>> +     comp_press = bmp180_compensate_press(data, adc_press);
>> +
>> +     *val = comp_press;
>> +     *val2 = 1000;
>> +
>> +     return IIO_VAL_FRACTIONAL;
>> +}
>> +
>> +static int bmp180_chip_init(struct bmp280_data *data)
>> +{
>> +     return 0;
>> +}
>
> When setting the oversampling ratio, we do a lookup in the available
> values array, then call ops->init to write the values to the register.
> This function does nothing in the bmp180 case.  Or am I missing
> something?

Your understanding is correct.  There is nothing to do for bmp180 when
the oversampling setting is changed by the user.  When the actual
measurement is requested, the measurement conversion is started by
writing ctrl_meas register with the oversampling setting and start
conversion bit.
