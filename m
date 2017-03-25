Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35256 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751258AbdCYRBQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Mar 2017 13:01:16 -0400
Received: by mail-pg0-f67.google.com with SMTP id g2so3460681pge.2
        for <linux-iio@vger.kernel.org>; Sat, 25 Mar 2017 10:00:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e74afe9c-2312-2e83-e851-0a348f20c616@kernel.org>
References: <20170321222747.5863-1-lorenzo.bianconi@st.com> <e74afe9c-2312-2e83-e851-0a348f20c616@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date: Sat, 25 Mar 2017 18:00:26 +0100
Message-ID: <CAA2SeN+WiPx2+YM+kV1TuTh7U1JB2Ay3_9K7C9y7JNgDhiQvNA@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: do not apply ODR configuration in
 write_raw handler
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
        Lorenzo BIANCONI <lorenzo.bianconi@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

> On 21/03/17 22:27, Lorenzo Bianconi wrote:
>> introduce st_lsm6dsx_get_odr_val() routine to check ODR consistency in
>> write_raw hablder in order to apply frequency configuration just in
>> st_lsm6dsx_set_odr()
> handler.
>>
>> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
> So the advantage of this one is that it saves a pointless double write?

Right. Moreover this patch allows to avoid a transitory that occurs
when a given sensor has been already enabled (i.e. gyroscope) and the
user is configuring the sample frequency of the other one (i.e.
accel).
Until the accel is enabled ODR of gyro is modified as well. I will add
this comment in v2.

>> ---
>>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 41 ++++++++++++++++++----------
>>  1 file changed, 26 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>> index c433223..70096f4 100644
>> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>> @@ -308,32 +308,40 @@ static int st_lsm6dsx_set_full_scale(struct st_lsm6dsx_sensor *sensor,
>>       return 0;
>>  }
>>
>> -static int st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor, u16 odr)
>> +static int st_lsm6dsx_get_odr_val(struct st_lsm6dsx_sensor *sensor, u16 odr,
>> +                               u8 *val)
> Odd naming.., this sounds like it is reading the value back, whereas it's just
> checking for validity.

Right, it checks the validity of requested odr and return back the
corresponding hw value.
Maybe it is better to split it in two separate routines, what do you think?

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
> Nothing ever looks at the value in *val after this call so why update?

it is used in st_lsm6dsx_set_odr()

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
>> +     err = st_lsm6dsx_get_odr_val(sensor, odr, &val);
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
>> +             err = st_lsm6dsx_get_odr_val(sensor, val, &data);
>>               break;
>> +     }
>>       default:
>>               err = -EINVAL;
>>               break;
>>
>

Regards,
Lorenzo

-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch;
unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp;
umount; make clean; sleep
