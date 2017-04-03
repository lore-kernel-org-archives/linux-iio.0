Return-Path: <SRS0=/kGe=3L=gmail.com=lorenzo.bianconi83@kernel.org>
MIME-Version: 1.0
In-Reply-To: <fa370e4b-96b6-763b-361d-00a7932f78bc@kernel.org>
References: <20170403172739.7291-1-lorenzo.bianconi@st.com>
 <ae80091a-ca22-d23b-fa13-28241fdc2eca@kernel.org> <CAA2SeN+-9BXW9urWUq3Z4=_dfiQDF49XNe77c8idA-BANSugJg@mail.gmail.com>
 <fa370e4b-96b6-763b-361d-00a7932f78bc@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date: Mon, 3 Apr 2017 22:13:51 +0200
Message-ID: <CAA2SeNKELfzFSD9yV3g+o5+r6RKCKi=i-Psja2Va67CMvYFeFw@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: use i2c/spi device name for iio_dev name
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lorenzo BIANCONI <lorenzo.bianconi@st.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

> On 03/04/17 21:02, Lorenzo Bianconi wrote:
>>> On 03/04/17 18:27, Lorenzo Bianconi wrote:
>>>> Use the correct chip name (e.g. lsm6dsm) as suffix for iio_dev name
>>>> instead of a generic one (lsm6dsx)
>>>>
>>>> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
>>> Hmm. Always a fun one.  Technically this is changing a userspace
>>> ABI so is a problem unless we think no one will notice...
>>>
>>
>> Right.
>>
>>> The question is whether the gain is worth the potential risk?
>>
>> In this way we can support multiple chips at the same time (e.g.
>> lsm6dsm_accel and lsm6ds3h_gyro).
>> I needed that change when I had to support two different devices at
>> the same time, in particular lsm6dsm + lsm6ds3h.
>> What do you think? Does it worth? Fine if you think it does not :)
> There are lots of other ways of identifying devices, this one is
> just a convenience really....
>
> Lets leave it a few days and see if anyone else chips in.

Fine,
regards,

Lorenzo

>
> Jonathan
>>
>> Regards,
>> Lorenzo
>>
>>>
>>> What do people think?
>>>
>>> J
>>>> ---
>>>>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  4 +++-
>>>>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 14 +++++++++-----
>>>>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c  |  2 +-
>>>>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c  |  2 +-
>>>>  4 files changed, 14 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
>>>> index 6a9849e..4839db7 100644
>>>> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
>>>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
>>>> @@ -71,6 +71,7 @@ enum st_lsm6dsx_fifo_mode {
>>>>
>>>>  /**
>>>>   * struct st_lsm6dsx_sensor - ST IMU sensor instance
>>>> + * @name: Sensor name.
>>>>   * @id: Sensor identifier.
>>>>   * @hw: Pointer to instance of struct st_lsm6dsx_hw.
>>>>   * @gain: Configured sensor sensitivity.
>>>> @@ -83,6 +84,7 @@ enum st_lsm6dsx_fifo_mode {
>>>>   * @ts: Latest timestamp from the interrupt handler.
>>>>   */
>>>>  struct st_lsm6dsx_sensor {
>>>> +     char name[32];
>>>>       enum st_lsm6dsx_sensor_id id;
>>>>       struct st_lsm6dsx_hw *hw;
>>>>
>>>> @@ -133,7 +135,7 @@ struct st_lsm6dsx_hw {
>>>>  #endif /* CONFIG_SPI_MASTER */
>>>>  };
>>>>
>>>> -int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
>>>> +int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
>>>>                    const struct st_lsm6dsx_transfer_function *tf_ops);
>>>>  int st_lsm6dsx_sensor_enable(struct st_lsm6dsx_sensor *sensor);
>>>>  int st_lsm6dsx_sensor_disable(struct st_lsm6dsx_sensor *sensor);
>>>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>>>> index f80a3d4..98b51d7 100644
>>>> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>>>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>>>> @@ -642,7 +642,8 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
>>>>  }
>>>>
>>>>  static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
>>>> -                                            enum st_lsm6dsx_sensor_id id)
>>>> +                                            enum st_lsm6dsx_sensor_id id,
>>>> +                                            const char *name)
>>>>  {
>>>>       struct st_lsm6dsx_sensor *sensor;
>>>>       struct iio_dev *iio_dev;
>>>> @@ -666,27 +667,30 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
>>>>       case ST_LSM6DSX_ID_ACC:
>>>>               iio_dev->channels = st_lsm6dsx_acc_channels;
>>>>               iio_dev->num_channels = ARRAY_SIZE(st_lsm6dsx_acc_channels);
>>>> -             iio_dev->name = "lsm6dsx_accel";
>>>>               iio_dev->info = &st_lsm6dsx_acc_info;
>>>>
>>>>               sensor->decimator_mask = ST_LSM6DSX_REG_ACC_DEC_MASK;
>>>> +             scnprintf(sensor->name, sizeof(sensor->name), "%s_accel",
>>>> +                       name);
>>>>               break;
>>>>       case ST_LSM6DSX_ID_GYRO:
>>>>               iio_dev->channels = st_lsm6dsx_gyro_channels;
>>>>               iio_dev->num_channels = ARRAY_SIZE(st_lsm6dsx_gyro_channels);
>>>> -             iio_dev->name = "lsm6dsx_gyro";
>>>>               iio_dev->info = &st_lsm6dsx_gyro_info;
>>>>
>>>>               sensor->decimator_mask = ST_LSM6DSX_REG_GYRO_DEC_MASK;
>>>> +             scnprintf(sensor->name, sizeof(sensor->name), "%s_gyro",
>>>> +                       name);
>>>>               break;
>>>>       default:
>>>>               return NULL;
>>>>       }
>>>> +     iio_dev->name = sensor->name;
>>>>
>>>>       return iio_dev;
>>>>  }
>>>>
>>>> -int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
>>>> +int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
>>>>                    const struct st_lsm6dsx_transfer_function *tf_ops)
>>>>  {
>>>>       struct st_lsm6dsx_hw *hw;
>>>> @@ -710,7 +714,7 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
>>>>               return err;
>>>>
>>>>       for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
>>>> -             hw->iio_devs[i] = st_lsm6dsx_alloc_iiodev(hw, i);
>>>> +             hw->iio_devs[i] = st_lsm6dsx_alloc_iiodev(hw, i, name);
>>>>               if (!hw->iio_devs[i])
>>>>                       return -ENOMEM;
>>>>       }
>>>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
>>>> index 2e4ed26..09a51cf 100644
>>>> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
>>>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
>>>> @@ -61,7 +61,7 @@ static int st_lsm6dsx_i2c_probe(struct i2c_client *client,
>>>>                               const struct i2c_device_id *id)
>>>>  {
>>>>       return st_lsm6dsx_probe(&client->dev, client->irq,
>>>> -                             (int)id->driver_data,
>>>> +                             (int)id->driver_data, id->name,
>>>>                               &st_lsm6dsx_transfer_fn);
>>>>  }
>>>>
>>>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
>>>> index 1bf4a58..f765a50 100644
>>>> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
>>>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
>>>> @@ -78,7 +78,7 @@ static int st_lsm6dsx_spi_probe(struct spi_device *spi)
>>>>       const struct spi_device_id *id = spi_get_device_id(spi);
>>>>
>>>>       return st_lsm6dsx_probe(&spi->dev, spi->irq,
>>>> -                             (int)id->driver_data,
>>>> +                             (int)id->driver_data, id->name,
>>>>                               &st_lsm6dsx_transfer_fn);
>>>>  }
>>>>
>>>>
>>>
>>
>>
>>
>



-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch;
unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp;
umount; make clean; sleep
