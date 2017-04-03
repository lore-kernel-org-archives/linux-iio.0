Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36758 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751535AbdDCT4n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Apr 2017 15:56:43 -0400
Received: by mail-pg0-f66.google.com with SMTP id 81so32038287pgh.3
        for <linux-iio@vger.kernel.org>; Mon, 03 Apr 2017 12:56:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c5f46629-1f95-f560-9fbc-cef1724ecc31@kernel.org>
References: <20170402125845.11388-1-lorenzo.bianconi@st.com> <c5f46629-1f95-f560-9fbc-cef1724ecc31@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date: Mon, 3 Apr 2017 21:56:42 +0200
Message-ID: <CAA2SeNJf8R-8eYzD8Hxw1Jnoy24O3qLK7=c773KUo8RJFkfEJw@mail.gmail.com>
Subject: Re: [PATCH v3] iio: imu: st_lsm6dsx: do not apply ODR configuration
 in write_raw handler
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
        Lorenzo BIANCONI <lorenzo.bianconi@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> On 02/04/17 13:58, Lorenzo Bianconi wrote:
>> This patch allows to avoid a transitory that occurs when a given sensor
>> has been already enabled (e.g. gyroscope) and the user is configuring
>> the sample frequency of the other one (e.g. accelerometer).
>> The transitory lasts until the accelerometer is enabled.
>> During that time slice the gyroscope ODR is incorrectly modified as well.
>> At the end of the transitory both sensors work at the right frequency.
>> Fix it introducing st_lsm6dsx_check_odr() routine to check ODR consistency
>> in write_raw handler in order to apply frequency configuration just
>> in st_lsm6dsx_set_odr()
>>
>> Fixes: 290a6ce11d93 (iio: imu: add support to lsm6dsx driver)
>> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
> Looks like I forgot to mention that I applied this and it has now
> gone to Greg.

No worries :)
Regards,

Lorenzo

>
> Jonathan
>> ---
>> Changes since v2:
>> - Improve commit log
>> Changes since v1:
>> - Rename st_lsm6dsx_get_odr_val() in st_lsm6dsx_check_odr()
>> ---
>>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 41 ++++++++++++++++++----------
>>  1 file changed, 26 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>> index c433223..f80a3d4 100644
>> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>> @@ -308,32 +308,40 @@ static int st_lsm6dsx_set_full_scale(struct st_lsm6dsx_sensor *sensor,
>>       return 0;
>>  }
>>
>> -static int st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor, u16 odr)
>> +static int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u16 odr,
>> +                             u8 *val)
>>  {
>> -     enum st_lsm6dsx_sensor_id id = sensor->id;
>> -     int i, err;
>> -     u8 val;
>> +     int i;
>>
>>       for (i = 0; i < ST_LSM6DSX_ODR_LIST_SIZE; i++)
>> -             if (st_lsm6dsx_odr_table[id].odr_avl[i].hz == odr)
>> +             if (st_lsm6dsx_odr_table[sensor->id].odr_avl[i].hz == odr)
>>                       break;
>>
>>       if (i == ST_LSM6DSX_ODR_LIST_SIZE)
>>               return -EINVAL;
>>
>> -     val = st_lsm6dsx_odr_table[id].odr_avl[i].val;
>> -     err = st_lsm6dsx_write_with_mask(sensor->hw,
>> -                                      st_lsm6dsx_odr_table[id].reg.addr,
>> -                                      st_lsm6dsx_odr_table[id].reg.mask,
>> -                                      val);
>> -     if (err < 0)
>> -             return err;
>> -
>> +     *val = st_lsm6dsx_odr_table[sensor->id].odr_avl[i].val;
>>       sensor->odr = odr;
>>
>>       return 0;
>>  }
>>
>> +static int st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor, u16 odr)
>> +{
>> +     enum st_lsm6dsx_sensor_id id = sensor->id;
>> +     int err;
>> +     u8 val;
>> +
>> +     err = st_lsm6dsx_check_odr(sensor, odr, &val);
>> +     if (err < 0)
>> +             return err;
>> +
>> +     return st_lsm6dsx_write_with_mask(sensor->hw,
>> +                                       st_lsm6dsx_odr_table[id].reg.addr,
>> +                                       st_lsm6dsx_odr_table[id].reg.mask,
>> +                                       val);
>> +}
>> +
>>  int st_lsm6dsx_sensor_enable(struct st_lsm6dsx_sensor *sensor)
>>  {
>>       int err;
>> @@ -436,9 +444,12 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
>>       case IIO_CHAN_INFO_SCALE:
>>               err = st_lsm6dsx_set_full_scale(sensor, val2);
>>               break;
>> -     case IIO_CHAN_INFO_SAMP_FREQ:
>> -             err = st_lsm6dsx_set_odr(sensor, val);
>> +     case IIO_CHAN_INFO_SAMP_FREQ: {
>> +             u8 data;
>> +
>> +             err = st_lsm6dsx_check_odr(sensor, val, &data);
>>               break;
>> +     }
>>       default:
>>               err = -EINVAL;
>>               break;
>>
>



-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch;
unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp;
umount; make clean; sleep
