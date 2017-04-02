Return-Path: <SRS0=WaUd=3K=gmail.com=lorenzo.bianconi83@kernel.org>
MIME-Version: 1.0
In-Reply-To: <624c6f8f-19a1-c7ab-ca69-a4242b1dd9b2@kernel.org>
References: <20170327214207.30966-1-lorenzo.bianconi@st.com> <624c6f8f-19a1-c7ab-ca69-a4242b1dd9b2@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date: Sun, 2 Apr 2017 13:55:52 +0200
Message-ID: <CAA2SeNKmiUCRP8vD+N0jdvuCxtSkHC_7Fbg2wBs0GuVpz1ywwA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: imu: st_lsm6dsx: do not apply ODR configuration
 in write_raw handler
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lorenzo BIANCONI <lorenzo.bianconi@st.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

> On 27/03/17 22:42, Lorenzo Bianconi wrote:
>> This patch allows to avoid a transitory that occurs when a given sensor
>> has been already enabled (e.g. gyroscope) and the user is configuring
>> the sample frequency of the other one (e.g. accelerometer).
>> Until the accelerometer is enabled gyroscope ODR is modified as well.
>> Fix it introducing st_lsm6dsx_check_odr() routine to check ODR consistency
>> in write_raw handler in order to apply frequency configuration just
>> in st_lsm6dsx_set_odr()
>>
>> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
> Hi Lorenzo,

Hi Jonathan,

>
> Patch is great, but to make my life easier could you add a fixes
> tag + give me some idea of how important the issue is.
>
> I need to know if I should be rushing it into the kernel or the
> next merge window is fine.
>

Ack. The issue is not particularly severe (no crash or whatever). You
can notice it if a sensor has been already enabled and you just
configure the ODR of the other one without enabling it. I guess next
merge window is fine.
Anyway, v3 on the way.

Regards,
Lorenzo

> Thanks,
>
> Jonathan
>> ---
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
