Return-Path: <giuseppe.barba@st.com>
From: Giuseppe BARBA <giuseppe.barba@st.com>
To: Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: Denis CIOCCA <denis.ciocca@st.com>
Date: Fri, 24 Jul 2015 10:49:11 +0200
Subject: Re: [PATCH V2] iio: st: rework code style removing goto statements
Message-ID: <55B1FC07.1050107@st.com>
References: <1437476935-29902-1-git-send-email-giuseppe.barba@st.com>
 <55B14EB3.1070306@kernel.org>
In-Reply-To: <55B14EB3.1070306@kernel.org>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

thanks for your review.

On 23/07/2015 22:29, Jonathan Cameron wrote:
> On 21/07/15 12:08, Giuseppe Barba wrote:
>> The scope of this patch is to remove some goto statements and its label
>> present into st sensors driver.
>>
>> Signed-off-by: Giuseppe Barba <giuseppe.barba@st.com>
> Some good stuff in here, but I'm unconvinced by a few cases.
> Don't over do the trying to shorten code.  Sometimes a bit of
> verbosity makes for easier code reading!
>
> J
>> ---
>>   drivers/iio/accel/st_accel_buffer.c               |  7 +--
>>   drivers/iio/accel/st_accel_core.c                 |  3 +-
>>   drivers/iio/common/st_sensors/st_sensors_buffer.c | 29 ++++-----
>>   drivers/iio/common/st_sensors/st_sensors_core.c   | 76 ++++++++++-----=
--------
>>   drivers/iio/common/st_sensors/st_sensors_i2c.c    |  5 +-
>>   drivers/iio/common/st_sensors/st_sensors_spi.c    | 10 ++-
>>   drivers/iio/gyro/st_gyro_buffer.c                 |  7 +--
>>   drivers/iio/gyro/st_gyro_core.c                   |  5 +-
>>   drivers/iio/magnetometer/st_magn_buffer.c         | 20 ++----
>>   drivers/iio/magnetometer/st_magn_core.c           |  5 +-
>>   drivers/iio/magnetometer/st_magn_i2c.c            |  6 +-
>>   drivers/iio/magnetometer/st_magn_spi.c            |  6 +-
>>   drivers/iio/pressure/st_pressure_buffer.c         | 20 ++----
>>   drivers/iio/pressure/st_pressure_core.c           | 13 ++--
>>   drivers/iio/pressure/st_pressure_spi.c            |  6 +-
>>   15 files changed, 78 insertions(+), 140 deletions(-)
>>
>> diff --git a/drivers/iio/accel/st_accel_buffer.c b/drivers/iio/accel/st_=
accel_buffer.c
>> index a1e642e..21b5ac4 100644
>> --- a/drivers/iio/accel/st_accel_buffer.c
>> +++ b/drivers/iio/accel/st_accel_buffer.c
>> @@ -41,10 +41,8 @@ static int st_accel_buffer_postenable(struct iio_dev =
*indio_dev)
>>        struct st_sensor_data *adata =3D iio_priv(indio_dev);
>>
>>        adata->buffer_data =3D kmalloc(indio_dev->scan_bytes, GFP_KERNEL)=
;
>> -     if (adata->buffer_data =3D=3D NULL) {
>> -             err =3D -ENOMEM;
>> -             goto allocate_memory_error;
>> -     }
>> +     if (adata->buffer_data =3D=3D NULL)
>> +             return -ENOMEM;
>>
>>        err =3D st_sensors_set_axis_enable(indio_dev,
>>                                        (u8)indio_dev->active_scan_mask[0=
]);
>> @@ -59,7 +57,6 @@ static int st_accel_buffer_postenable(struct iio_dev *=
indio_dev)
>>
>>   st_accel_buffer_postenable_error:
>>        kfree(adata->buffer_data);
>> -allocate_memory_error:
>>        return err;
>>   }
>>
>> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_ac=
cel_core.c
>> index ff30f88..beea981 100644
>> --- a/drivers/iio/accel/st_accel_core.c
>> +++ b/drivers/iio/accel/st_accel_core.c
>> @@ -559,7 +559,7 @@ static int st_accel_read_raw(struct iio_dev *indio_d=
ev,
>>        case IIO_CHAN_INFO_RAW:
>>                err =3D st_sensors_read_info_raw(indio_dev, ch, val);
>>                if (err < 0)
>> -                     goto read_error;
>> +                     break;
>>
>>                return IIO_VAL_INT;
>>        case IIO_CHAN_INFO_SCALE:
>> @@ -573,7 +573,6 @@ static int st_accel_read_raw(struct iio_dev *indio_d=
ev,
>>                return -EINVAL;
>>        }
>>
>> -read_error:
>>        return err;
>>   }
>>
>> diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers=
/iio/common/st_sensors/st_sensors_buffer.c
>> index e18bc67..4d1f75c 100644
>> --- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
>> +++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
>> @@ -32,10 +32,8 @@ int st_sensors_get_buffer_element(struct iio_dev *ind=
io_dev, u8 *buf)
>>                        indio_dev->channels[0].scan_type.storagebits >> 3=
;
>>
>>        addr =3D kmalloc(num_data_channels, GFP_KERNEL);
>> -     if (!addr) {
>> -             len =3D -ENOMEM;
>> -             goto st_sensors_get_buffer_element_error;
>> -     }
>> +     if (!addr)
>> +             return -ENOMEM;
>>
>>        for (i =3D 0; i < num_data_channels; i++) {
>>                if (test_bit(i, indio_dev->active_scan_mask)) {
>> @@ -59,7 +57,7 @@ int st_sensors_get_buffer_element(struct iio_dev *indi=
o_dev, u8 *buf)
>>                                           GFP_KERNEL);
>>                        if (!rx_array) {
>>                                len =3D -ENOMEM;
>> -                             goto st_sensors_free_memory;
>> +                             break;
>>                        }
>>
>>                        len =3D sdata->tf->read_multiple_byte(&sdata->tb,
>> @@ -68,7 +66,7 @@ int st_sensors_get_buffer_element(struct iio_dev *indi=
o_dev, u8 *buf)
>>                                rx_array, sdata->multiread_bit);
>>                        if (len < 0) {
>>                                kfree(rx_array);
>> -                             goto st_sensors_free_memory;
>> +                             break;
>>                        }
>>
>>                        for (i =3D 0; i < n * byte_for_channel; i++) {
>> @@ -88,16 +86,13 @@ int st_sensors_get_buffer_element(struct iio_dev *in=
dio_dev, u8 *buf)
>>                break;
>>        default:
>>                len =3D -EINVAL;
>> -             goto st_sensors_free_memory;
>> +             break;
>>        }
>> -     if (len !=3D byte_for_channel * n) {
> Another one that I think was clearer in the original.
Ok, I'll restore the original part.

>
>> +     if ((len > 0) && (len !=3D byte_for_channel * n))
>>                len =3D -EIO;
>> -             goto st_sensors_free_memory;
>> -     }
>>
>> -st_sensors_free_memory:
>>        kfree(addr);
>> -st_sensors_get_buffer_element_error:
>> +
>>        return len;
>>   }
>>   EXPORT_SYMBOL(st_sensors_get_buffer_element);
>> @@ -110,13 +105,11 @@ irqreturn_t st_sensors_trigger_handler(int irq, vo=
id *p)
>>        struct st_sensor_data *sdata =3D iio_priv(indio_dev);
>>
>>        len =3D st_sensors_get_buffer_element(indio_dev, sdata->buffer_da=
ta);
>> -     if (len < 0)
>> -             goto st_sensors_get_buffer_element_error;
>> -
>> -     iio_push_to_buffers_with_timestamp(indio_dev, sdata->buffer_data,
>> -             pf->timestamp);
>> +     if (len > 0)
>> +             iio_push_to_buffers_with_timestamp(indio_dev,
>> +                                                     sdata->buffer_data=
,
>> +                                                     pf->timestamp);
> I find this harder to read than the original.  Shorter yes, but sometimes
> the form of
>
> if error goto error cleanup is easier to follow...

Ok.

>
>>
>> -st_sensors_get_buffer_element_error:
>>        iio_trigger_notify_done(indio_dev->trig);
>>
>>        return IRQ_HANDLED;
>> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/i=
io/common/st_sensors/st_sensors_core.c
>> index 2e7fdb5..31f05f9 100644
>> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
>> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
>> @@ -35,34 +35,32 @@ static int st_sensors_write_data_with_mask(struct ii=
o_dev *indio_dev,
>>
>>        err =3D sdata->tf->read_byte(&sdata->tb, sdata->dev, reg_addr, &n=
ew_data);
>>        if (err < 0)
>> -             goto st_sensors_write_data_with_mask_error;
>> +             return err;
>>
>>        new_data =3D ((new_data & (~mask)) | ((data << __ffs(mask)) & mas=
k));
>> -     err =3D sdata->tf->write_byte(&sdata->tb, sdata->dev, reg_addr, ne=
w_data);
>>
>> -st_sensors_write_data_with_mask_error:
>> -     return err;
>> +     return sdata->tf->write_byte(&sdata->tb, sdata->dev, reg_addr,
>> +                                                             new_data);
>>   }
>>
>>   static int st_sensors_match_odr(struct st_sensor_settings *sensor_sett=
ings,
>>                        unsigned int odr, struct st_sensor_odr_avl *odr_o=
ut)
>>   {
>> -     int i, ret =3D -EINVAL;
>> +     int i;
>>
>>        for (i =3D 0; i < ST_SENSORS_ODR_LIST_MAX; i++) {
>>                if (sensor_settings->odr.odr_avl[i].hz =3D=3D 0)
>> -                     goto st_sensors_match_odr_error;
>> +                     break;
>>
>>                if (sensor_settings->odr.odr_avl[i].hz =3D=3D odr) {
>>                        odr_out->hz =3D sensor_settings->odr.odr_avl[i].h=
z;
>>                        odr_out->value =3D sensor_settings->odr.odr_avl[i=
].value;
>> -                     ret =3D 0;
>> -                     break;
>> +
>> +                     return 0;
>>                }
>>        }
>>
>> -st_sensors_match_odr_error:
>> -     return ret;
>> +     return -EINVAL;
>>   }
>>
>>   int st_sensors_set_odr(struct iio_dev *indio_dev, unsigned int odr)
>> @@ -73,7 +71,7 @@ int st_sensors_set_odr(struct iio_dev *indio_dev, unsi=
gned int odr)
>>
>>        err =3D st_sensors_match_odr(sdata->sensor_settings, odr, &odr_ou=
t);
>>        if (err < 0)
>> -             goto st_sensors_match_odr_error;
>> +             return err;
>>
>>        if ((sdata->sensor_settings->odr.addr =3D=3D
>>                                        sdata->sensor_settings->pw.addr) =
&&
>> @@ -96,7 +94,6 @@ int st_sensors_set_odr(struct iio_dev *indio_dev, unsi=
gned int odr)
>>        if (err >=3D 0)
>>                sdata->odr =3D odr_out.hz;
>>
>> -st_sensors_match_odr_error:
>>        return err;
>>   }
>>   EXPORT_SYMBOL(st_sensors_set_odr);
>> @@ -104,21 +101,19 @@ EXPORT_SYMBOL(st_sensors_set_odr);
>>   static int st_sensors_match_fs(struct st_sensor_settings *sensor_setti=
ngs,
>>                                        unsigned int fs, int *index_fs_av=
l)
>>   {
>> -     int i, ret =3D -EINVAL;
>> +     int i;
>>
>>        for (i =3D 0; i < ST_SENSORS_FULLSCALE_AVL_MAX; i++) {
>>                if (sensor_settings->fs.fs_avl[i].num =3D=3D 0)
>> -                     goto st_sensors_match_odr_error;
>> +                     break;
> Why not just return here?
>>
>>                if (sensor_settings->fs.fs_avl[i].num =3D=3D fs) {
>>                        *index_fs_avl =3D i;
>> -                     ret =3D 0;
>> -                     break;
>> +                     return 0;
>>                }
>>        }
>>
>> -st_sensors_match_odr_error:
>> -     return ret;
>> +     return -EINVAL;
>>   }
>>
>>   static int st_sensors_set_fullscale(struct iio_dev *indio_dev, unsigne=
d int fs)
>> @@ -130,22 +125,23 @@ static int st_sensors_set_fullscale(struct iio_dev=
 *indio_dev, unsigned int fs)
>>                return 0;
>>
>>        err =3D st_sensors_match_fs(sdata->sensor_settings, fs, &i);
>> -     if (err < 0)
>> -             goto st_accel_set_fullscale_error;
>> +     if (err < 0) {
>> +             dev_err(&indio_dev->dev, "requested fullscale is not suppo=
rted.\n");
>> +             return err;
>> +     }
>>
>>        err =3D st_sensors_write_data_with_mask(indio_dev,
>>                                sdata->sensor_settings->fs.addr,
>>                                sdata->sensor_settings->fs.mask,
>>                                sdata->sensor_settings->fs.fs_avl[i].valu=
e);
>> -     if (err < 0)
>> -             goto st_accel_set_fullscale_error;
>> +     if (err < 0) {
>> +             dev_err(&indio_dev->dev, "failed to set new fullscale.\n")=
;
>> +             return err;
>> +     }
>>
>>        sdata->current_fullscale =3D (struct st_sensor_fullscale_avl *)
>>                                        &sdata->sensor_settings->fs.fs_av=
l[i];
>> -     return err;
>>
>> -st_accel_set_fullscale_error:
>> -     dev_err(&indio_dev->dev, "failed to set new fullscale.\n");
>>        return err;
>>   }
>>
>> @@ -166,7 +162,8 @@ int st_sensors_set_enable(struct iio_dev *indio_dev,=
 bool enable)
>>                        err =3D st_sensors_match_odr(sdata->sensor_settin=
gs,
>>                                                        sdata->odr, &odr_=
out);
>>                        if (err < 0)
>> -                             goto set_enable_error;
>> +                             return err;
>> +
>>                        tmp_value =3D odr_out.value;
>>                        found =3D true;
>>                }
>> @@ -174,7 +171,7 @@ int st_sensors_set_enable(struct iio_dev *indio_dev,=
 bool enable)
>>                                sdata->sensor_settings->pw.addr,
>>                                sdata->sensor_settings->pw.mask, tmp_valu=
e);
>>                if (err < 0)
>> -                     goto set_enable_error;
>> +                     return err;
>>
>>                sdata->enabled =3D true;
>>
>> @@ -186,12 +183,11 @@ int st_sensors_set_enable(struct iio_dev *indio_de=
v, bool enable)
>>                                sdata->sensor_settings->pw.mask,
>>                                sdata->sensor_settings->pw.value_off);
>>                if (err < 0)
>> -                     goto set_enable_error;
>> +                     return err;
>>
>>                sdata->enabled =3D false;
>>        }
>>
>> -set_enable_error:
>>        return err;
>>   }
>>   EXPORT_SYMBOL(st_sensors_set_enable);
>> @@ -375,7 +371,7 @@ int st_sensors_set_dataready_irq(struct iio_dev *ind=
io_dev, bool enable)
>>                                sdata->sensor_settings->drdy_irq.ig1.en_m=
ask,
>>                                (int)enable);
>>                if (err < 0)
>> -                     goto st_accel_set_dataready_irq_error;
>> +                     return err;
>>        }
>>
>>        if (sdata->drdy_int_pin =3D=3D 1)
>> @@ -384,12 +380,9 @@ int st_sensors_set_dataready_irq(struct iio_dev *in=
dio_dev, bool enable)
>>                drdy_mask =3D sdata->sensor_settings->drdy_irq.mask_int2;
>>
>>        /* Enable/Disable the interrupt generator for data ready. */
>> -     err =3D st_sensors_write_data_with_mask(indio_dev,
>> +     return st_sensors_write_data_with_mask(indio_dev,
>>                                        sdata->sensor_settings->drdy_irq.=
addr,
>>                                        drdy_mask, (int)enable);
>> -
>> -st_accel_set_dataready_irq_error:
>> -     return err;
>>   }
>>   EXPORT_SYMBOL(st_sensors_set_dataready_irq);
>>
>> @@ -406,13 +399,10 @@ int st_sensors_set_fullscale_by_gain(struct iio_de=
v *indio_dev, int scale)
>>                }
>>        }
>>        if (err < 0)
>> -             goto st_sensors_match_scale_error;
>> +             return err;
>>
>> -     err =3D st_sensors_set_fullscale(indio_dev,
>> +     return st_sensors_set_fullscale(indio_dev,
>>                                sdata->sensor_settings->fs.fs_avl[i].num)=
;
>> -
>> -st_sensors_match_scale_error:
>> -     return err;
>>   }
>>   EXPORT_SYMBOL(st_sensors_set_fullscale_by_gain);
>>
>> @@ -456,22 +446,22 @@ int st_sensors_read_info_raw(struct iio_dev *indio=
_dev,
>>        mutex_lock(&indio_dev->mlock);
>>        if (indio_dev->currentmode =3D=3D INDIO_BUFFER_TRIGGERED) {
>>                err =3D -EBUSY;
>> -             goto out;
>> +             goto st_sensors_mutex_unlock;
>>        } else {
>>                err =3D st_sensors_set_enable(indio_dev, true);
>>                if (err < 0)
>> -                     goto out;
>> +                     goto st_sensors_mutex_unlock;
>>
>>                msleep((sdata->sensor_settings->bootime * 1000) / sdata->=
odr);
>>                err =3D st_sensors_read_axis_data(indio_dev, ch, val);
>>                if (err < 0)
>> -                     goto out;
>> +                     goto st_sensors_mutex_unlock;
>>
>>                *val =3D *val >> ch->scan_type.shift;
>>
>>                err =3D st_sensors_set_enable(indio_dev, false);
>>        }
>> -out:
>> +st_sensors_mutex_unlock:
>>        mutex_unlock(&indio_dev->mlock);
>>
>>        return err;
>> diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/ii=
o/common/st_sensors/st_sensors_i2c.c
>> index 98cfee29..793d7a8 100644
>> --- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
>> +++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
>> @@ -33,12 +33,11 @@ static int st_sensors_i2c_read_byte(struct st_sensor=
_transfer_buffer *tb,
>>
>>        err =3D i2c_smbus_read_byte_data(to_i2c_client(dev), reg_addr);
>>        if (err < 0)
>> -             goto st_accel_i2c_read_byte_error;
>> +             return err;
>>
>>        *res_byte =3D err & 0xff;
>>
>> -st_accel_i2c_read_byte_error:
>> -     return err < 0 ? err : 0;
>> +     return 0;
>>   }
>>
>>   static int st_sensors_i2c_read_multiple_byte(
>> diff --git a/drivers/iio/common/st_sensors/st_sensors_spi.c b/drivers/ii=
o/common/st_sensors/st_sensors_spi.c
>> index 5b37737..d7a14e0 100644
>> --- a/drivers/iio/common/st_sensors/st_sensors_spi.c
>> +++ b/drivers/iio/common/st_sensors/st_sensors_spi.c
>> @@ -51,16 +51,14 @@ static int st_sensors_spi_read(struct st_sensor_tran=
sfer_buffer *tb,
>>                tb->tx_buf[0] =3D reg_addr | ST_SENSORS_SPI_READ;
>>
>>        err =3D spi_sync_transfer(to_spi_device(dev), xfers, ARRAY_SIZE(x=
fers));
>> -     if (err)
>> -             goto acc_spi_read_error;
>> +     if (err) {
>> +             mutex_unlock(&tb->buf_lock);
>> +             return err;
>> +     }
>>
>>        memcpy(data, tb->rx_buf, len);
>>        mutex_unlock(&tb->buf_lock);
>>        return len;
>> -
>> -acc_spi_read_error:
>> -     mutex_unlock(&tb->buf_lock);
>> -     return err;
>>   }
>>
>>   static int st_sensors_spi_read_byte(struct st_sensor_transfer_buffer *=
tb,
>> diff --git a/drivers/iio/gyro/st_gyro_buffer.c b/drivers/iio/gyro/st_gyr=
o_buffer.c
>> index d67b17b..9da07ed 100644
>> --- a/drivers/iio/gyro/st_gyro_buffer.c
>> +++ b/drivers/iio/gyro/st_gyro_buffer.c
>> @@ -41,10 +41,8 @@ static int st_gyro_buffer_postenable(struct iio_dev *=
indio_dev)
>>        struct st_sensor_data *gdata =3D iio_priv(indio_dev);
>>
>>        gdata->buffer_data =3D kmalloc(indio_dev->scan_bytes, GFP_KERNEL)=
;
>> -     if (gdata->buffer_data =3D=3D NULL) {
>> -             err =3D -ENOMEM;
>> -             goto allocate_memory_error;
>> -     }
>> +     if (gdata->buffer_data =3D=3D NULL)
>> +             return -ENOMEM;
>>
>>        err =3D st_sensors_set_axis_enable(indio_dev,
>>                                        (u8)indio_dev->active_scan_mask[0=
]);
>> @@ -59,7 +57,6 @@ static int st_gyro_buffer_postenable(struct iio_dev *i=
ndio_dev)
>>
>>   st_gyro_buffer_postenable_error:
>>        kfree(gdata->buffer_data);
>> -allocate_memory_error:
>>        return err;
>>   }
>>
>> diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_=
core.c
>> index 4b993a5..668e099 100644
>> --- a/drivers/iio/gyro/st_gyro_core.c
>> +++ b/drivers/iio/gyro/st_gyro_core.c
>> @@ -324,7 +324,7 @@ static int st_gyro_read_raw(struct iio_dev *indio_de=
v,
>>        case IIO_CHAN_INFO_RAW:
>>                err =3D st_sensors_read_info_raw(indio_dev, ch, val);
>>                if (err < 0)
>> -                     goto read_error;
>> +                     break;
>>
>>                return IIO_VAL_INT;
>>        case IIO_CHAN_INFO_SCALE:
>> @@ -338,7 +338,6 @@ static int st_gyro_read_raw(struct iio_dev *indio_de=
v,
>>                return -EINVAL;
>>        }
>>
>> -read_error:
>>        return err;
>>   }
>>
>> @@ -357,7 +356,7 @@ static int st_gyro_write_raw(struct iio_dev *indio_d=
ev,
>>                mutex_lock(&indio_dev->mlock);
>>                err =3D st_sensors_set_odr(indio_dev, val);
>>                mutex_unlock(&indio_dev->mlock);
>> -             return err;
>> +             break;
>>        default:
>>                err =3D -EINVAL;
>>        }
>> diff --git a/drivers/iio/magnetometer/st_magn_buffer.c b/drivers/iio/mag=
netometer/st_magn_buffer.c
>> index ecd3bd0..ea4006f 100644
>> --- a/drivers/iio/magnetometer/st_magn_buffer.c
>> +++ b/drivers/iio/magnetometer/st_magn_buffer.c
>> @@ -41,21 +41,14 @@ static int st_magn_buffer_postenable(struct iio_dev =
*indio_dev)
>>        struct st_sensor_data *mdata =3D iio_priv(indio_dev);
>>
>>        mdata->buffer_data =3D kmalloc(indio_dev->scan_bytes, GFP_KERNEL)=
;
>> -     if (mdata->buffer_data =3D=3D NULL) {
>> -             err =3D -ENOMEM;
>> -             goto allocate_memory_error;
>> -     }
>> +     if (mdata->buffer_data =3D=3D NULL)
>> +             return -ENOMEM;
>>
>>        err =3D iio_triggered_buffer_postenable(indio_dev);
>>        if (err < 0)
>> -             goto st_magn_buffer_postenable_error;
>> +             kfree(mdata->buffer_data);
>>
>>        return err;
>> -
>> -st_magn_buffer_postenable_error:
>> -     kfree(mdata->buffer_data);
>> -allocate_memory_error:
>> -     return err;
>>   }
>>
>>   static int st_magn_buffer_predisable(struct iio_dev *indio_dev)
>> @@ -64,12 +57,9 @@ static int st_magn_buffer_predisable(struct iio_dev *=
indio_dev)
>>        struct st_sensor_data *mdata =3D iio_priv(indio_dev);
>>
>>        err =3D iio_triggered_buffer_predisable(indio_dev);
>> -     if (err < 0)
>> -             goto st_magn_buffer_predisable_error;
>> -
>> -     err =3D st_sensors_set_enable(indio_dev, false);
>> +     if (err >=3D 0)
>> +             err =3D st_sensors_set_enable(indio_dev, false);
> Again, shorter, but harder to read.  Leave it as it was.
>>
>> -st_magn_buffer_predisable_error:
>>        kfree(mdata->buffer_data);
>>        return err;
>>   }
>> diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magne=
tometer/st_magn_core.c
>> index f8dc4b8..abf75c5 100644
>> --- a/drivers/iio/magnetometer/st_magn_core.c
>> +++ b/drivers/iio/magnetometer/st_magn_core.c
>> @@ -497,7 +497,7 @@ static int st_magn_read_raw(struct iio_dev *indio_de=
v,
>>        case IIO_CHAN_INFO_RAW:
>>                err =3D st_sensors_read_info_raw(indio_dev, ch, val);
>>                if (err < 0)
>> -                     goto read_error;
>> +                     break;
> return err; preferred.
I'm agree. But In this case the return statement at the end of the
function has no sense to be there. Can I remove this return?

>>
>>                return IIO_VAL_INT;
>>        case IIO_CHAN_INFO_SCALE:
>> @@ -515,7 +515,6 @@ static int st_magn_read_raw(struct iio_dev *indio_de=
v,
>>                return -EINVAL;
>>        }
>>
>> -read_error:
>>        return err;
>>   }
>>
>> @@ -534,7 +533,7 @@ static int st_magn_write_raw(struct iio_dev *indio_d=
ev,
>>                mutex_lock(&indio_dev->mlock);
>>                err =3D st_sensors_set_odr(indio_dev, val);
>>                mutex_unlock(&indio_dev->mlock);
>> -             return err;
>> +             break;
> recent idioms in kernel are to return as early as possible. As such
> original is preferred.

Ok.

>>        default:
>>                err =3D -EINVAL;
>>        }
>> diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnet=
ometer/st_magn_i2c.c
>> index 8aa37af..787e5bb 100644
>> --- a/drivers/iio/magnetometer/st_magn_i2c.c
>> +++ b/drivers/iio/magnetometer/st_magn_i2c.c
>> @@ -60,14 +60,10 @@ static int st_magn_i2c_probe(struct i2c_client *clie=
nt,
>>
>>        mdata =3D iio_priv(indio_dev);
>>        st_sensors_of_i2c_probe(client, st_magn_of_match);
>> -
>>        st_sensors_i2c_configure(indio_dev, client, mdata);
>> -
>>        err =3D st_magn_common_probe(indio_dev);
>> -     if (err < 0)
>> -             return err;
>>
>> -     return 0;
>> +     return (err < 0) ? err : 0;
>>   }
>>
>>   static int st_magn_i2c_remove(struct i2c_client *client)
>> diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnet=
ometer/st_magn_spi.c
>> index 0abca2c..1d78dae 100644
>> --- a/drivers/iio/magnetometer/st_magn_spi.c
>> +++ b/drivers/iio/magnetometer/st_magn_spi.c
>> @@ -29,14 +29,10 @@ static int st_magn_spi_probe(struct spi_device *spi)
>>                return -ENOMEM;
>>
>>        mdata =3D iio_priv(indio_dev);
>> -
>>        st_sensors_spi_configure(indio_dev, spi, mdata);
>> -
>>        err =3D st_magn_common_probe(indio_dev);
>> -     if (err < 0)
>> -             return err;
>>
>> -     return 0;
>> +     return (err < 0) ? err : 0;
> As mentioned below, I find the new option harder to read.
> (note I review backwards so this applies to other cases above this point)=
.
Ok.

>>   }
>>
>>   static int st_magn_spi_remove(struct spi_device *spi)
>> diff --git a/drivers/iio/pressure/st_pressure_buffer.c b/drivers/iio/pre=
ssure/st_pressure_buffer.c
>> index 2ff53f2..d8a83e7 100644
>> --- a/drivers/iio/pressure/st_pressure_buffer.c
>> +++ b/drivers/iio/pressure/st_pressure_buffer.c
>> @@ -41,21 +41,14 @@ static int st_press_buffer_postenable(struct iio_dev=
 *indio_dev)
>>        struct st_sensor_data *press_data =3D iio_priv(indio_dev);
>>
>>        press_data->buffer_data =3D kmalloc(indio_dev->scan_bytes, GFP_KE=
RNEL);
>> -     if (press_data->buffer_data =3D=3D NULL) {
>> -             err =3D -ENOMEM;
>> -             goto allocate_memory_error;
>> -     }
>> +     if (press_data->buffer_data =3D=3D NULL)
>> +             return -ENOMEM;
>>
>>        err =3D iio_triggered_buffer_postenable(indio_dev);
>>        if (err < 0)
>> -             goto st_press_buffer_postenable_error;
>> +             kfree(press_data->buffer_data);
>>
>>        return err;
>> -
>> -st_press_buffer_postenable_error:
>> -     kfree(press_data->buffer_data);
>> -allocate_memory_error:
>> -     return err;
>>   }
>>
>>   static int st_press_buffer_predisable(struct iio_dev *indio_dev)
>> @@ -64,12 +57,9 @@ static int st_press_buffer_predisable(struct iio_dev =
*indio_dev)
>>        struct st_sensor_data *press_data =3D iio_priv(indio_dev);
>>
>>        err =3D iio_triggered_buffer_predisable(indio_dev);
>> -     if (err < 0)
>> -             goto st_press_buffer_predisable_error;
>> -
>> -     err =3D st_sensors_set_enable(indio_dev, false);
>> +     if (err >=3D 0)
>> +             err =3D st_sensors_set_enable(indio_dev, false);
> Not keen on this one.  The code may be shorter, but it is harder
> to read.  Gotos are the right option if, like here, there is common
> cleanup to be done.
Clear.

>
>>
>> -st_press_buffer_predisable_error:
>>        kfree(press_data->buffer_data);
>>        return err;
>>   }
>> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/press=
ure/st_pressure_core.c
>> index eb41d2b..b26b1a8 100644
>> --- a/drivers/iio/pressure/st_pressure_core.c
>> +++ b/drivers/iio/pressure/st_pressure_core.c
>> @@ -325,10 +325,12 @@ static int st_press_write_raw(struct iio_dev *indi=
o_dev,
>>                mutex_lock(&indio_dev->mlock);
>>                err =3D st_sensors_set_odr(indio_dev, val);
>>                mutex_unlock(&indio_dev->mlock);
>> -             return err;
>> +             break;
> Original is the more standard option in recent kernel idioms.
Ok.

>
>>        default:
>>                return -EINVAL;
>>        }
>> +
>> +     return err;
>>   }
>>
>>   static int st_press_read_raw(struct iio_dev *indio_dev,
>> @@ -342,7 +344,7 @@ static int st_press_read_raw(struct iio_dev *indio_d=
ev,
>>        case IIO_CHAN_INFO_RAW:
>>                err =3D st_sensors_read_info_raw(indio_dev, ch, val);
>>                if (err < 0)
>> -                     goto read_error;
>> +                     break;
>>
>>                return IIO_VAL_INT;
>>        case IIO_CHAN_INFO_SCALE:
>> @@ -356,8 +358,7 @@ static int st_press_read_raw(struct iio_dev *indio_d=
ev,
>>                        *val2 =3D press_data->current_fullscale->gain2;
>>                        break;
>>                default:
>> -                     err =3D -EINVAL;
>> -                     goto read_error;
>> +                     return -EINVAL;
>>                }
>>
>>                return IIO_VAL_INT_PLUS_NANO;
>> @@ -368,8 +369,7 @@ static int st_press_read_raw(struct iio_dev *indio_d=
ev,
>>                        *val2 =3D 10;
>>                        break;
>>                default:
>> -                     err =3D -EINVAL;
>> -                     goto read_error;
>> +                     return -EINVAL;
>>                }
>>
>>                return IIO_VAL_FRACTIONAL;
>> @@ -380,7 +380,6 @@ static int st_press_read_raw(struct iio_dev *indio_d=
ev,
>>                return -EINVAL;
>>        }
>>
>> -read_error:
>>        return err;
>>   }
>>
>> diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressu=
re/st_pressure_spi.c
>> index 1ffa6d4..21aac46 100644
>> --- a/drivers/iio/pressure/st_pressure_spi.c
>> +++ b/drivers/iio/pressure/st_pressure_spi.c
>> @@ -29,14 +29,10 @@ static int st_press_spi_probe(struct spi_device *spi=
)
>>                return -ENOMEM;
>>
>>        press_data =3D iio_priv(indio_dev);
>> -
>>        st_sensors_spi_configure(indio_dev, spi, press_data);
>> -
>>        err =3D st_press_common_probe(indio_dev);
>> -     if (err < 0)
>> -             return err;
>>
>> -     return 0;
>> +     return (err < 0) ? err : 0;
> In my view this one is actually harder to read than before.
> I couldn't immediately see why err would be > 0 in this call.
>
> If not, a simple
> return st_press_common_probe(...);
> would be prefered.
Ok, I'm agree with you.
