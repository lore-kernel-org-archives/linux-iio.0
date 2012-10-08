Return-Path: <lars@metafoo.de>
Message-ID: <5073260C.3010506@metafoo.de>
Date: Mon, 08 Oct 2012 21:14:20 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Jonathan Cameron <jic23@kernel.org>,
 "burman.yan@gmail.com" <burman.yan@gmail.com>,
 "pavel@ucw.cz" <pavel@ucw.cz>
Subject: Re: STMicroelectronics accelerometers driver.
References: <5072F3B9.4050309@st.com>
In-Reply-To: <5072F3B9.4050309@st.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 10/08/2012 05:39 PM, Denis CIOCCA wrote:
> Hi everybody,
> 
> I submit to you my linux device driver to support the latest ST
> accelerometers. I want do submission to the linux community and I ask
> you suggestions and proposals.
> Thanks
> 
> Denis
> 

Hi just a quick and rough review. One general thing: It would be good if you
would namespace your function names, struct names, defines, etc. Currently some
of them aren't namespaced at all and some just use 'accel'. Maybe use
"st_accel" instead.

> 
>  From c965b7f522d858a48e3bbcc723cb2ff4c00397f4 Mon Sep 17 00:00:00 2001
> From: Denis Ciocca <denis.ciocca@st.com>
> Date: Mon, 8 Oct 2012 17:04:32 +0200
> Subject: [PATCH 1/2] add driver

You need a better patch description than this ;)

> 
> ---
>   .../STMicroelectronics_accelerometers_iio_buffer.c |  155 ++
>   .../STMicroelectronics_accelerometers_iio_core.c   | 1495
> ++++++++++++++++++++
>   .../STMicroelectronics_accelerometers_iio_i2c.c    |  124 ++
>   .../STMicroelectronics_accelerometers_iio_spi.c    |  209 +++
>   ...STMicroelectronics_accelerometers_iio_trigger.c |   96 ++
>   5 files changed, 2079 insertions(+), 0 deletions(-)
>   create mode 100644
> drivers/iio/accel/STMicroelectronics_accelerometers_iio_buffer.c
>   create mode 100644
> drivers/iio/accel/STMicroelectronics_accelerometers_iio_core.c
>   create mode 100644
> drivers/iio/accel/STMicroelectronics_accelerometers_iio_i2c.c
>   create mode 100644
> drivers/iio/accel/STMicroelectronics_accelerometers_iio_spi.c
>   create mode 100644
> drivers/iio/accel/STMicroelectronics_accelerometers_iio_trigger.c

the file names are a bit excessive in my opinion. How about
st_accel_{buffer,core,i2c,...}.c?

> 
> diff --git
> a/drivers/iio/accel/STMicroelectronics_accelerometers_iio_buffer.c
> b/drivers/iio/accel/STMicroelectronics_accelerometers_iio_buffer.c
> new file mode 100644
> index 0000000..44e3f3d
> --- /dev/null
> +++ b/drivers/iio/accel/STMicroelectronics_accelerometers_iio_buffer.c
> @@ -0,0 +1,155 @@
> +/*
> + * STMicroelectronics accelerometers driver
> + *
> + * Copyright 2012 STMicroelectronics Inc.
> + *
> + * Denis Ciocca <denis.ciocca@st.com>
> + *
> + * Licensed under the GPL-2.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/stat.h>
> +#include <linux/interrupt.h>
> +#include <linux/byteorder/generic.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/iio/trigger_consumer.h>
> +
> +#include <linux/iio/acc/STMicroelectronics_accelerometers_iio.h>
> +
> +
> +static int acc_read_all(struct iio_dev *indio_dev, u8 *rx_array)
> +{
> +       int len;
> +       struct acc_data *adata = iio_priv(indio_dev);
> +
> +       len = adata->read_multiple_byte(adata,
> +               indio_dev->channels[ACC_SCAN_X].address,
> +               ACC_BYTE_FOR_CHANNEL*ACC_NUMBER_DATA_CHANNELS, rx_array);
> +       if (len < 0)
> +               goto read_error;
> +
> +       return len;
> +
> +read_error:
> +       return -EIO;
> +}
> +
> +static int acc_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
> +{
> +       int ret, i, n = 0;
> +       u8 *rx_array;
> +       u8 mask = 0x01;
> +       s16 *data = (s16 *)buf;
> +
> +       rx_array = kzalloc(ACC_BYTE_FOR_CHANNEL*ACC_NUMBER_DATA_CHANNELS,
> +                                                               GFP_KERNEL);
> +       if (rx_array == NULL)
> +               return -ENOMEM;
> +       ret = acc_read_all(indio_dev, rx_array);
> +       if (ret < 0)
> +               return ret;
> +       for (i = 0; i < ACC_NUMBER_DATA_CHANNELS; i++) {
> +               if ((*indio_dev->active_scan_mask & mask) > 0) {
> +                       if (indio_dev->channels[i].scan_type.endianness ==
> +                                                               IIO_LE) {
> +                               data[n] = (s16)(cpu_to_le16(le16_to_cpu((
> +                               (__le16 *)rx_array)[i]))) >>
> +                               indio_dev->channels[i].scan_type.shift;
> +                               n++;
> +                       } else {
> +                               data[n] = (s16)(cpu_to_le16(be16_to_cpu((
> +                               (__be16 *)rx_array)[i]))) >>
> +                               indio_dev->channels[i].scan_type.shift;
> +                               n++;
> +                       }
> +               }
> +               mask = mask << 1;
> +       }


In buffered mode the samples should not be postprocessed. Userspace expects the
samples in the format as described by the scan_type. The buffer demuxing should
be handled by the IIO core. If you set up available_scan_masks correctly it
will automatically do the right thing.

> +       kfree(rx_array);
> +       return i*sizeof(data[0]);
> +}
> +
[...]
> +
> +int acc_allocate_ring(struct iio_dev *indio_dev)
> +{
> +       int ret;
> +       struct iio_buffer *buffer;
> +       struct acc_data *adata = iio_priv(indio_dev);
> +
> +       buffer = iio_kfifo_allocate(indio_dev);
> +       if (buffer == NULL) {
> +               ret = -ENOMEM;
> +               goto acc_configure_ring_error;
> +       }
> +       indio_dev->buffer = buffer;
> +       indio_dev->scan_timestamp = true;
> +       indio_dev->buffer->scan_timestamp = true;
> +       indio_dev->setup_ops = &acc_buf_setup_ops;
> +       indio_dev->pollfunc = iio_alloc_pollfunc(
> +                                               &iio_pollfunc_store_time,
> +                                               &acc_trigger_handler,
> +                                               IRQF_ONESHOT,
> +                                               indio_dev,
> +                                               "%s_consumer%d",
> +                                               indio_dev->name,
> +                                               indio_dev->id);
> +       if (indio_dev->pollfunc == NULL) {
> +               ret = -ENOMEM;
> +               goto iio_alloc_pollfunc_error;
> +       }
> +       indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
> +       ret = iio_buffer_register(indio_dev, indio_dev->channels,
> +                                               ACC_NUMBER_ALL_CHANNELS);
> +       if (ret < 0) {
> +               pr_err("%s: iio_buffer_register failed.\n", adata->name);
> +               goto iio_buffer_register_error;
> +       }
> +       pr_info("%s: allocate buffer -> done.\n", adata->name);


This looks like you could make use of the generic triggered_buffer code. Please
have a look at the different drivers which already make use of it.

> +       return 0;
> +
> +iio_buffer_register_error:
> +iio_alloc_pollfunc_error:
> +       iio_kfifo_free(buffer);
> +acc_configure_ring_error:
> +       return ret;
> +}
> +
> +void acc_deallocate_ring(struct iio_dev *indio_dev)
> +{
> +       iio_dealloc_pollfunc(indio_dev->pollfunc);
> +       iio_kfifo_free(indio_dev->buffer);
> +       iio_buffer_unregister(indio_dev);
> +}
> diff --git
> a/drivers/iio/accel/STMicroelectronics_accelerometers_iio_core.c
> b/drivers/iio/accel/STMicroelectronics_accelerometers_iio_core.c
> new file mode 100644
> index 0000000..f9ccbf6
> --- /dev/null
> +++ b/drivers/iio/accel/STMicroelectronics_accelerometers_iio_core.c
> @@ -0,0 +1,1495 @@
[...]
> +static struct sensor {
> +       u8 wai;
> +       struct odr odr;
> +       struct power pw;
> +       struct fullscale fs;
> +       struct data_out data;
> +       struct data_ready_irq drdy_irq;
> +       struct iio_chan_spec *ch;
> +} sensor[] = {
> +       {
> +       .wai = S1_WAI_EXP,
> +       .ch = (struct iio_chan_spec *)default_channels,
> +       },
> +       {
> +       .wai = S2_WAI_EXP,
> +       .ch = (struct iio_chan_spec *)s2_channels,
> +       .odr = {
> +               .odr_avl[0] = {

I'd use
 .odr_avl = {
	[0] = {
		...
	},
	[1] = {
		...

Makes things a bit more readable in my opinion.
	

> +                       .hz = S2_ODR_AVL_3HZ,
> +                       .value = S2_ODR_AVL_3HZ_VALUE,
> +               },
[...]
> +
> +static int acc_write_data_with_mask(struct iio_dev *indio_dev, u8 reg_addr,
> +                                               u8 mask, short num_bit, u8 data)
> +{
> +       int err, j, pos;
> +       u8 prev_data;
> +       u8 new_data;
> +       struct acc_data *adata = iio_priv(indio_dev);
> +
> +       pos = 7;
> +       for (j = 128; j >= 0; j = j/2) {

Missing spaces, please run checkpatch.pl before submitting a patch

> +               if (mask/j > 0)

Missing space

> +                       break;
> +               else
> +                       pos--;
> +       }
> +
> +       prev_data = adata->read_byte(adata, reg_addr);
> +       if (prev_data < 0)
> +               goto i2c_write_data_with_mask_error;
> +       prev_data &= 0xff;
> +       new_data = ((prev_data & (~mask)) | ((data << (pos-num_bit+1)) & mask));

Missing spaces

> +       err = adata->write_byte(adata, reg_addr, new_data);
> +       if (err)
> +               goto i2c_write_data_with_mask_error;

The label you jump to here is just on the next line...

> +
> +i2c_write_data_with_mask_error:
> +       return err;
> +}
> +
[...]


> +static int acc_read_raw(struct iio_dev *indio_dev,
> +                       struct iio_chan_spec const *ch, int *val,
> +                                                       int *val2, long mask)
> +{
> +       int err;
> +       int data_tmp;
> +       u8 outdata[ACC_BYTE_FOR_CHANNEL];
> +       struct acc_data *adata = iio_priv(indio_dev);
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_RAW:
> +               if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
> +                       err = -EBUSY;
> +               } else {
> +                       err = atomic_read(&adata->enabled);
> +                       if (!err) {
> +                               err = -EHOSTDOWN;

"Host is down", I don't think this is best error message here. Also is there
any reason why you can't powerup/powerdown the device on demand?


> +                       } else {
> +                               err = adata->read_multiple_byte(adata,
> +                                       ch->address, ACC_BYTE_FOR_CHANNEL,
> +                                       outdata);
> +                               if (err < 0)
> +                                       goto read_error;
> +
> +                               if (ch->scan_type.endianness == IIO_LE)
> +                                       *val = (s32)(s16)(cpu_to_le16(
> +                                       le16_to_cpu(((__le16 *)outdata)[0])))
> +                                       >> ch->scan_type.shift;
> +                               else
> +                                       *val = (s32)(s16)(cpu_to_le16(
> +                                       be16_to_cpu(((__be16 *)outdata)[0])))
> +                                       >> ch->scan_type.shift;
> +                       }
> +               }
> +               return IIO_VAL_INT;
> +       case IIO_CHAN_INFO_SCALE:
> +               data_tmp = adata->gain*UG_TO_MS2;
> +               *val = 0;
> +               *val2 = data_tmp;
> +               return IIO_VAL_INT_PLUS_NANO;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +read_error:
> +       pr_err("%s: failed to read i2c raw data!\n", adata->name);
> +       return err;
> +}
> +
> +static int acc_check_irq(struct iio_dev *indio_dev)
> +{
> +       int err;
> +       struct acc_data *adata = iio_priv(indio_dev);
> +
> +       if (adata->irq_data_ready <= 0)

This will always be true since you made irq_data_ready a pointer, doesn't the
compiler complain here?

> +               err = -EINVAL;
> +       else
> +               err = 0;
> +
> +       return err;
> +}
> +
> +
> +static int set_platform_data(struct iio_dev *indio_dev)
> +{
> +       int err;
> +       struct acc_data *adata;
> +
> +       adata = iio_priv(indio_dev);
> +       adata->pdata = kmalloc(sizeof(struct acc_platform_data), GFP_KERNEL);
> +       if (adata->pdata == NULL) {
> +               pr_err("%s: failed to allocate memory for pdata.\n",
> +                                                               adata->name);
> +               err = -ENOMEM;
> +               goto pdata_malloc_error;
> +       }
> +       if (adata->client == NULL) {
> +               if (adata->spi->dev.platform_data != NULL) {
> +                       memcpy(adata->pdata, adata->spi->dev.platform_data,
> +                                       sizeof(struct acc_platform_data));
> +               } else {
> +                       memcpy(adata->pdata, &acc_default_pdata,
> +                                       sizeof(struct acc_platform_data));
> +               }
> +       } else if (adata->spi == NULL) {
> +               if (adata->client->dev.platform_data != NULL) {
> +                       memcpy(adata->pdata, adata->client->dev.platform_data,
> +                                       sizeof(struct acc_platform_data));
> +               } else {
> +                       memcpy(adata->pdata, &acc_default_pdata,
> +                                       sizeof(struct acc_platform_data));
> +               }
> +       }
> +       return 0;
> +
> +pdata_malloc_error:
> +       return err;
> +}

Is platform_data really used outside of probe? If not you could get rid of this.

> +
> +static void set_sensor_parameters(struct iio_dev *indio_dev)
> +{
> +       struct acc_data *adata;
> +
> +       adata = iio_priv(indio_dev);
> +       if (!sensor[adata->index].odr.addr)
> +               sensor[adata->index].odr.addr = DEFAULT_ODR_ADDR;
> +       if (!sensor[adata->index].odr.mask)
> +               sensor[adata->index].odr.mask = DEFAULT_ODR_MASK;
> +       if (!sensor[adata->index].odr.num_bit)
> +                       sensor[adata->index].odr.num_bit = DEFAULT_ODR_N_BIT;
> +       if (!sensor[adata->index].pw.addr)
> +               sensor[adata->index].pw.addr = DEFAULT_POWER_ADDR;
> +       if (!sensor[adata->index].pw.mask)
> +               sensor[adata->index].pw.mask = DEFAULT_POWER_MASK;
> +       if (!sensor[adata->index].pw.num_bit)
> +                       sensor[adata->index].pw.num_bit = DEFAULT_POWER_N_BIT;
> +       if (!sensor[adata->index].pw.value_off)
> +               sensor[adata->index].pw.value_off = DEFAULT_POWER_OFF_VALUE;
> +       if (!sensor[adata->index].pw.value_on)
> +               sensor[adata->index].pw.value_on = DEFAULT_POWER_ON_VALUE;
> +       if (!sensor[adata->index].odr.odr_avl[0].hz) {
> +               sensor[adata->index].odr.odr_avl[0].hz = DEFAULT_ODR_AVL_1HZ;
> +               sensor[adata->index].odr.odr_avl[0].value =
> +                                               DEFAULT_ODR_AVL_1HZ_VALUE;
> +               sensor[adata->index].odr.odr_avl[1].hz = DEFAULT_ODR_AVL_10HZ;
> +               sensor[adata->index].odr.odr_avl[1].value =
> +                                               DEFAULT_ODR_AVL_10HZ_VALUE;
> +               sensor[adata->index].odr.odr_avl[2].hz = DEFAULT_ODR_AVL_25HZ;
> +               sensor[adata->index].odr.odr_avl[2].value =
> +                                               DEFAULT_ODR_AVL_25HZ_VALUE;
> +               sensor[adata->index].odr.odr_avl[3].hz = DEFAULT_ODR_AVL_50HZ;
> +               sensor[adata->index].odr.odr_avl[3].value =
> +                                               DEFAULT_ODR_AVL_50HZ_VALUE;
> +               sensor[adata->index].odr.odr_avl[4].hz =
> +                                               DEFAULT_ODR_AVL_100HZ;
> +               sensor[adata->index].odr.odr_avl[4].value =
> +                                               DEFAULT_ODR_AVL_100HZ_VALUE;
> +               sensor[adata->index].odr.odr_avl[5].hz =
> +                                               DEFAULT_ODR_AVL_200HZ;
> +               sensor[adata->index].odr.odr_avl[5].value =
> +                                               DEFAULT_ODR_AVL_200HZ_VALUE;
> +               sensor[adata->index].odr.odr_avl[6].hz =
> +                                               DEFAULT_ODR_AVL_400HZ;
> +               sensor[adata->index].odr.odr_avl[6].value =
> +                                               DEFAULT_ODR_AVL_400HZ_VALUE;
> +               sensor[adata->index].odr.odr_avl[7].hz =
> +                                               DEFAULT_ODR_AVL_1600HZ;
> +               sensor[adata->index].odr.odr_avl[7].value =
> +                                               DEFAULT_ODR_AVL_1600HZ_VALUE;
> +       }
> +       if (!sensor[adata->index].fs.addr)
> +               sensor[adata->index].fs.addr = DEFAULT_FS_ADDR;
> +       if (!sensor[adata->index].fs.mask)
> +               sensor[adata->index].fs.mask = DEFAULT_FS_MASK;
> +       if (!sensor[adata->index].fs.num_bit)
> +               sensor[adata->index].fs.num_bit = DEFAULT_FS_N_BIT;
> +       if (!sensor[adata->index].fs.fs_avl[0].num) {
> +               sensor[adata->index].fs.fs_avl[0].num = DEFAULT_FS_AVL_2_NUM;
> +               sensor[adata->index].fs.fs_avl[0].value =
> +                                               DEFAULT_FS_AVL_2_VALUE;
> +               sensor[adata->index].fs.fs_avl[0].gain =
> +                                               DEFAULT_FS_AVL_2_GAIN;
> +               sensor[adata->index].fs.fs_avl[1].num = DEFAULT_FS_AVL_4_NUM;
> +               sensor[adata->index].fs.fs_avl[1].value =
> +                                               DEFAULT_FS_AVL_4_VALUE;
> +               sensor[adata->index].fs.fs_avl[1].gain =
> +                                               DEFAULT_FS_AVL_4_GAIN;
> +               sensor[adata->index].fs.fs_avl[2].num = DEFAULT_FS_AVL_8_NUM;
> +               sensor[adata->index].fs.fs_avl[2].value =
> +                                               DEFAULT_FS_AVL_8_VALUE;
> +               sensor[adata->index].fs.fs_avl[2].gain =
> +                                               DEFAULT_FS_AVL_8_GAIN;
> +               sensor[adata->index].fs.fs_avl[3].num = DEFAULT_FS_AVL_16_NUM;
> +               sensor[adata->index].fs.fs_avl[3].value =
> +                                               DEFAULT_FS_AVL_16_VALUE;
> +               sensor[adata->index].fs.fs_avl[3].gain =
> +                                               DEFAULT_FS_AVL_16_GAIN;
> +       }
> +       if (!sensor[adata->index].data.addr[X_AXIS][DATA_LOW])
> +               sensor[adata->index].data.addr[X_AXIS][DATA_LOW] =
> +                                                       (DEFAULT_OUT_X_L);
> +       if (!sensor[adata->index].data.addr[X_AXIS][DATA_HIGH])
> +               sensor[adata->index].data.addr[X_AXIS][DATA_HIGH] =
> +                                                       DEFAULT_OUT_X_H;
> +       if (!sensor[adata->index].data.addr[Y_AXIS][DATA_LOW])
> +               sensor[adata->index].data.addr[Y_AXIS][DATA_LOW] =
> +                                                       (DEFAULT_OUT_Y_L);
> +       if (!sensor[adata->index].data.addr[Y_AXIS][DATA_HIGH])
> +               sensor[adata->index].data.addr[Y_AXIS][DATA_HIGH] =
> +                                                       DEFAULT_OUT_Y_H;
> +       if (!sensor[adata->index].data.addr[Z_AXIS][DATA_LOW])
> +               sensor[adata->index].data.addr[Z_AXIS][DATA_LOW] =
> +                                                       (DEFAULT_OUT_Z_L);
> +       if (!sensor[adata->index].data.addr[Z_AXIS][DATA_HIGH])
> +               sensor[adata->index].data.addr[Z_AXIS][DATA_HIGH] =
> +                                                       DEFAULT_OUT_Z_H;
> +       if (!sensor[adata->index].drdy_irq.addr)
> +               sensor[adata->index].drdy_irq.addr = DEFAULT_DRDY_IRQ_ADDR;
> +       if (!sensor[adata->index].drdy_irq.mask)
> +               sensor[adata->index].drdy_irq.mask = DEFAULT_DRDY_IRQ_MASK;
> +       if (!sensor[adata->index].data.bdu.addr)
> +               sensor[adata->index].data.bdu.addr = DEFAULT_BDU_ADDR;
> +       if (!sensor[adata->index].data.bdu.mask)
> +               sensor[adata->index].data.bdu.mask = DEFAULT_BDU_MASK;
> +       if (!sensor[adata->index].drdy_irq.ig1.en_addr)
> +               sensor[adata->index].drdy_irq.ig1.en_addr = DEFAULT_IG1_EN_ADDR;
> +       if (!sensor[adata->index].drdy_irq.ig1.en_mask)
> +               sensor[adata->index].drdy_irq.ig1.en_mask = DEFAULT_IG1_EN_MASK;
> +       if (!sensor[adata->index].drdy_irq.ig1.latching_mask_addr)
> +               sensor[adata->index].drdy_irq.ig1.latching_mask_addr =
> +                                               DEFAULT_IG1_LATCHING_MASK_ADDR;
> +       if (!sensor[adata->index].drdy_irq.ig1.latching_mask)
> +               sensor[adata->index].drdy_irq.ig1.latching_mask =
> +                                               DEFAULT_IG1_LATCHING_MASK;

Any reason to not initialize the static sensor array directly with these
defaults? This function is idempotent, but still it would be nice to make
"sensor" const.

> +}
> +
[...]
> +static ssize_t sysfs_sampling_frequency_available(struct device *dev,
> +                               struct device_attribute *attr, char *buf)
> +{
> +       int i, n, len;
> +       char tmp[4];
> +       char sampling_frequency[30] = "";
> +       struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +       struct acc_data *adata = iio_priv(indio_dev);
> +
> +       mutex_lock(&indio_dev->mlock);
> +       n = ARRAY_SIZE(sensor[adata->index].odr.odr_avl);
> +       for (i = 0; i < n; i++) {
> +               if (sensor[adata->index].odr.odr_avl[i].hz != 0) {
> +                       len = strlen(&sampling_frequency[0]);
> +                       sprintf(tmp, "%d ",
> +                               sensor[adata->index].odr.odr_avl[i].hz);
> +                       strcpy(&sampling_frequency[len], tmp);
> +               } else
> +                       break;
> +       }
> +       mutex_unlock(&indio_dev->mlock);
> +
> +       return sprintf(buf, "%s\n", sampling_frequency);

Ok, so first you sprintf your value into tmp, then you copy temp to
sampling_frequency and finally you copy sampling_frequency. You could just
sprintf directly into buf. Also try to use scnprintf with a limit of PAGE_SIZE

> +}
> +
> +static IIO_DEVICE_ATTR(sampling_frequency_available, S_IRUGO,
> +                               sysfs_sampling_frequency_available, NULL , 0);
> +static IIO_DEVICE_ATTR(fullscale_available, S_IRUGO,
> +                               sysfs_fullscale_available, NULL , 0);
> +static IIO_DEVICE_ATTR(fullscale, S_IWUSR | S_IRUGO, sysfs_get_fullscale,
> +                               sysfs_set_fullscale , 0);
> +static IIO_DEVICE_ATTR(enable, S_IWUSR | S_IRUGO, sysfs_get_enable,
> +                                               sysfs_set_enable , 0);
> +static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
> sysfs_get_sampling_frequency,
> +                               sysfs_set_sampling_frequency);

Any non-standard attributes need documentation.

> +int acc_iio_default(struct iio_dev *indio_dev)

I'd call this _probe instead of _default.

> +{
> +       int err;
> +       u8 wai;
> +       struct acc_data *adata = iio_priv(indio_dev);
> +
> +       mutex_init(&adata->slock);
> +       indio_dev->modes = INDIO_DIRECT_MODE;
> +       indio_dev->info = &acc_info;
> +
> +       err = get_wai_device(indio_dev, DEFAULT_WAI_ADDRESS, &wai);
> +       if (err < 0)
> +               goto get_wai_error;
> +       err = check_device_list(indio_dev, wai);
> +       if (err < 0)
> +               goto check_device_list_error;
> +       set_sensor_parameters(indio_dev);
> +       err = set_platform_data(indio_dev);
> +       if (err < 0)
> +               goto set_platform_data_error;
> +       err = validate_platform_data(indio_dev);
> +       if (err < 0)
> +               goto validate_platform_data_error;
> +       register_channels(indio_dev);
> +
> +       err = init_sensor(indio_dev);
> +       if (err < 0)
> +               goto init_sensor_error;
> +
> +       if (sensor[adata->index].wai == S5_WAI_EXP)
> +               adata->multiread_bit = 0;
> +       else
> +               adata->multiread_bit = 1;
> +
> +       err = acc_check_irq(indio_dev);
> +       if (err < 0)
> +               goto gpio_check_error;
> +       err = acc_allocate_ring(indio_dev);
> +       if (err < 0)
> +               goto acc_allocate_ring_error;
> +
> +       err = acc_probe_trigger(indio_dev);
> +       if (err < 0)
> +               goto acc_probe_trigger_error;
> +
> +       err = iio_device_register(indio_dev);
> +       if (err)
> +               goto iio_device_register_error;
> +
> +       pr_info("%s: probe end correctly.\n", adata->name);
> +
> +       return err;
> +
> +iio_device_register_error:
> +       acc_remove_trigger(indio_dev);
> +acc_probe_trigger_error:
> +       acc_deallocate_ring(indio_dev);
> +acc_allocate_ring_error:
> +gpio_check_error:
> +init_sensor_error:
> +validate_platform_data_error:
> +       kfree(adata->pdata);
> +set_platform_data_error:
> +check_device_list_error:
> +get_wai_error:
> +       return err;
> +}
> +
> +int acc_iio_remove(struct iio_dev *indio_dev)
> +{
> +       struct acc_data *adata = iio_priv(indio_dev);
> +
> +       acc_remove_trigger(indio_dev);
> +       acc_deallocate_ring(indio_dev);
> +       kfree(adata->pdata);
> +       iio_device_unregister(indio_dev);
> +
> +       return 0;
> +}
> +
> +MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
> +MODULE_DESCRIPTION("STMicroelectronics accelerometers driver");
> +MODULE_LICENSE("GPL v2");
> diff --git
> a/drivers/iio/accel/STMicroelectronics_accelerometers_iio_i2c.c
> b/drivers/iio/accel/STMicroelectronics_accelerometers_iio_i2c.c
> new file mode 100644
> index 0000000..f443e52
> --- /dev/null
> +++ b/drivers/iio/accel/STMicroelectronics_accelerometers_iio_i2c.c
> @@ -0,0 +1,124 @@
> +/*
> + * STMicroelectronics accelerometers driver
> + *
> + * Copyright 2012 STMicroelectronics Inc.
> + *
> + * Denis Ciocca <denis.ciocca@st.com>
> + *
> + * Licensed under the GPL-2.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +
> +#include <linux/iio/acc/STMicroelectronics_accelerometers_iio.h>
> +
> +
> +#define        ACC_I2C_MULTIREAD       0x80
> +
> +
> +static inline s32 acc_i2c_read_byte(struct acc_data *adata, u8 reg_addr)
> +{
> +       return i2c_smbus_read_byte_data(adata->client, reg_addr);
> +}
> +
> +static inline s32 acc_i2c_read_multiple_byte(struct acc_data *adata,
> +                                               u8 reg_addr, int len, u8 *data)
> +{
> +       if (adata->multiread_bit != 0)
> +               reg_addr |= ACC_I2C_MULTIREAD;
> +       return i2c_smbus_read_i2c_block_data(adata->client,
> +                                                       reg_addr, len, data);
> +}
> +
> +static inline s32 acc_i2c_write_byte(struct acc_data *adata,
> +                                                       u8 reg_addr, u8 data)
> +{
> +       return i2c_smbus_write_byte_data(adata->client, reg_addr, data);
> +}
> +
> +static int __devinit acc_i2c_probe(struct i2c_client *client,
> +                               const struct i2c_device_id *id)
> +{
> +       struct iio_dev *indio_dev;
> +       struct acc_data *adata;
> +       int err;
> +
> +       pr_info("%s: probe start.\n", client->name);

This line is just noise, I'd remove it

> +       indio_dev = iio_device_alloc(sizeof(*adata));
> +       if (indio_dev == NULL) {
> +               err = -ENOMEM;
> +               goto iio_device_alloc_error;
> +       }
> +
> +       adata = iio_priv(indio_dev);
> +       adata->client = client;
> +       i2c_set_clientdata(client, indio_dev);
> +
> +       indio_dev->dev.parent = &client->dev;
> +       indio_dev->name = client->name;
> +
> +       adata->read_byte = acc_i2c_read_byte;
> +       adata->write_byte = acc_i2c_write_byte;
> +       adata->read_multiple_byte = acc_i2c_read_multiple_byte;
> +       adata->name = &client->name[0];

adata->name = client->name;

> +       adata->irq_data_ready = &client->irq;

Why do you take a pointer here?

> +
> +       err = acc_iio_default(indio_dev);
> +       if (err < 0)
> +               goto acc_iio_default_error;
> +
> +       return 0;
> +
> +acc_iio_default_error:
> +       iio_device_free(indio_dev);
> +iio_device_alloc_error:
> +       return err;
> +}
> +
[...]

No new line her
> +MODULE_DEVICE_TABLE(i2c, acc_id_table);
> +
> +static struct i2c_driver acc_driver = {
> +       .driver = {
> +               .owner = THIS_MODULE,
> +               .name = "STMicroelectronics i2c accelerometers",
> +       },
> +       .probe = acc_i2c_probe,
> +       .remove = __devexit_p(acc_i2c_remove),
> +       .id_table = acc_id_table,
> +};
> +

No new line her

> +module_i2c_driver(acc_driver);
> +
> +MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
> +MODULE_DESCRIPTION("STMicroelectronics accelerometers i2c driver");
> +MODULE_LICENSE("GPL v2");
> diff --git
> a/drivers/iio/accel/STMicroelectronics_accelerometers_iio_spi.c
> b/drivers/iio/accel/STMicroelectronics_accelerometers_iio_spi.c
> new file mode 100644
> index 0000000..f1ac211
> --- /dev/null
> +++ b/drivers/iio/accel/STMicroelectronics_accelerometers_iio_spi.c
> @@ -0,0 +1,209 @@
[...]
> +
> +static int __devinit acc_spi_probe(struct spi_device *client)
> +{
> +       struct iio_dev *indio_dev;
> +       struct acc_data *adata;
> +       int err;
> +
> +       pr_info("%s: probe start.\n", client->modalias);

That's just noise, I'd remove it.

> +       indio_dev = iio_device_alloc(sizeof(*adata));
> +       if (indio_dev == NULL) {
> +               err = -ENOMEM;
> +               goto iio_device_alloc_error;
> +       }
> +
> +       adata = iio_priv(indio_dev);
> +       adata->spi = client;
> +       spi_set_drvdata(client, indio_dev);
> +
> +       indio_dev->dev.parent = &client->dev;
> +       indio_dev->name = client->modalias;
> +
> +       adata->read_byte = acc_spi_read_byte;
> +       adata->write_byte = acc_spi_write_byte;
> +       adata->read_multiple_byte = acc_spi_read_multiple_byte;
> +       adata->name = &client->modalias[0];

adata->name = client->modalias;

> +       adata->irq_data_ready = &client->irq;
> +
> +       /* dummy read */

It would be good if the comment mentioned why a dummy read is necessary.

> +       adata->read_byte(adata, 0x0f);
> +
> +       err = acc_iio_default(indio_dev);
> +       if (err < 0)
> +               goto acc_iio_default_error;
> +
> +       return 0;
> +
> +acc_iio_default_error:
> +       iio_device_free(indio_dev);
> +iio_device_alloc_error:
> +       return err;
> +}
> +
> +static int __devexit acc_spi_remove(struct spi_device *spi)
> +{
> +       int err;
> +       struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +
> +       err = acc_iio_remove(indio_dev);

err is not used.

> +       iio_device_free(indio_dev);

Why not put the iio_device_free in acc_iio_remove?

> +
> +       return 0;
> +}
> +
[...]
> +

No newline here

> +MODULE_DEVICE_TABLE(spi, acc_id_table);
> +
> +static struct spi_driver acc_driver = {
> +       .driver = {
> +               .owner = THIS_MODULE,
> +               .name = "STMicroelectronics spi accelerometers",

Maybe use "st-accel" here instead

> +       },
> +       .probe = acc_spi_probe,
> +       .remove = __devexit_p(acc_spi_remove),
> +       .id_table = acc_id_table,
> +};
> +

No newline here

> +module_spi_driver(acc_driver);
> +
> +MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
> +MODULE_DESCRIPTION("STMicroelectronics accelerometers spi driver");
> +MODULE_LICENSE("GPL v2");
> diff --git
> a/drivers/iio/accel/STMicroelectronics_accelerometers_iio_trigger.c
> b/drivers/iio/accel/STMicroelectronics_accelerometers_iio_trigger.c
> new file mode 100644
> index 0000000..843af4c
> --- /dev/null
> +++ b/drivers/iio/accel/STMicroelectronics_accelerometers_iio_trigger.c
> @@ -0,0 +1,96 @@
> +/*
> + * STMicroelectronics accelerometers driver
> + *
> + * Copyright 2012 STMicroelectronics Inc.
> + *
> + * Denis Ciocca <denis.ciocca@st.com>
> + *
> + * Licensed under the GPL-2.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/interrupt.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +
> +#include <linux/iio/acc/STMicroelectronics_accelerometers_iio.h>
> +
> +
> +static irqreturn_t acc_data_ready_trig_poll(int irq, void *trig)
> +{
> +       iio_trigger_poll(trig, iio_get_time_ns());
> +       return IRQ_HANDLED;
> +}

This is just a open-coded iio_trigger_generic_data_rdy_poll, use it instead.

> +
> +static int iio_trig_acc_set_state(struct iio_trigger *trig, bool state)
> +{
> +       struct iio_dev *indio_dev = trig->private_data;
> +       return acc_set_dataready_irq(indio_dev, state);
> +}
> +
> +static const struct iio_trigger_ops iio_acc_trigger_ops = {
> +       .owner = THIS_MODULE,
> +       .set_trigger_state = &iio_trig_acc_set_state,
> +};
> +
> +int acc_probe_trigger(struct iio_dev *indio_dev)
> +{
> +       int err;
> +       struct acc_data *adata = iio_priv(indio_dev);
> +
> +       adata->trig = iio_trigger_alloc("%s-trigger", indio_dev->name);
> +       if (adata->trig == NULL) {
> +               err = -ENOMEM;
> +               pr_err("%s: failed to allocate iio trigger.\n", adata->name);
> +               goto iio_trigger_alloc_error;
> +       }
> +
> +       err = request_threaded_irq(*adata->irq_data_ready,
> +                       acc_data_ready_trig_poll,
> +                       NULL,
> +                       IRQF_TRIGGER_RISING,
> +                       "IRQ_data_ready",
> +                       adata->trig);

request_irq. Your thread_fn is NULL. Also maybe use a better name, I'd
recommand trigger->name.

> +       if (err) {
> +               pr_err("%s: failed to request threaded irq [%d].\n",
> +                                       adata->name, *adata->irq_data_ready);
> +               goto request_irq_error;
> +       }
> +       adata->trig->private_data = indio_dev;
> +       adata->trig->ops = &iio_acc_trigger_ops;
> +
> +       if (adata->client != NULL)
> +               adata->trig->dev.parent = &adata->client->dev;
> +       else
> +               adata->trig->dev.parent = &adata->spi->dev;
> +
> +       err = iio_trigger_register(adata->trig);
> +       if (err < 0) {
> +               pr_err("%s: failed to register iio trigger.\n", adata->name);
> +               goto iio_trigger_register_error;
> +       }
> +       indio_dev->trig = adata->trig;
> +       pr_info("%s: using [%s] trigger.\n", adata->name,
> +                                                       adata->trig->name);
> +       return 0;
> +
> +iio_trigger_register_error:
> +       free_irq(*adata->irq_data_ready, adata->trig);
> +request_irq_error:
> +       iio_trigger_free(adata->trig);
> +iio_trigger_alloc_error:
> +       return err;
> +}
[...]
> --
> 1.7.0.4
> 
> 
>  From 1fe8b75e0ec1197781c559935de23e116773c441 Mon Sep 17 00:00:00 2001
> From: Denis Ciocca <denis.ciocca@st.com>
> Date: Mon, 8 Oct 2012 17:08:43 +0200
> Subject: [PATCH 2/2] add header file
> 
> ---
>   .../acc/STMicroelectronics_accelerometers_iio.h    |  116
> ++++++++++++++++++++
>   1 files changed, 116 insertions(+), 0 deletions(-)
>   create mode 100644
> include/linux/iio/acc/STMicroelectronics_accelerometers_iio.h
> 
> diff --git
> a/include/linux/iio/acc/STMicroelectronics_accelerometers_iio.h
> b/include/linux/iio/acc/STMicroelectronics_accelerometers_iio.h
> new file mode 100644
> index 0000000..e6f18ad
> --- /dev/null
> +++ b/include/linux/iio/acc/STMicroelectronics_accelerometers_iio.h
> @@ -0,0 +1,116 @@
> +/*
> + * STMicroelectronics accelerometers driver
> + *
> + * Copyright 2012 STMicroelectronics Inc.
> + *
> + * Denis Ciocca <denis.ciocca@st.com>
> + * v. 1.0.0
> + * Licensed under the GPL-2.
> + */
> +
> [...]
> +
> +struct acc_platform_data {
> +       int fullscale;
> +       int sampling_frequency;
> +};
> +
> +struct acc_data {
> +       struct i2c_client *client;
> +       struct spi_device *spi;

Since a device will either be a spi or i2c device there is no need to have
pointers to both here. You can use a struct device and use to_i2c_client and
to_spi_device in the raw bus read/write callbacks. This will also help to clean
a few places in your driver where you do if(acc->client) .. else if (acc->spi)

> +       struct acc_platform_data *pdata;
> +       char *name;
> +
> +       short index;
> +
> +       atomic_t enabled;
> +       int fullscale;
> +       int gain;
> +       int odr;
> +
> +       int multiread_bit;
> +       int (*read_byte) (struct acc_data *adata, u8 reg_addr);
> +       int (*write_byte) (struct acc_data *adata, u8 reg_addr, u8 data);
> +       int (*read_multiple_byte) (struct acc_data *adata, u8 reg_addr,
> +                                                       int len, u8 *data);
> +
> +#ifdef CONFIG_STMICROELECTRONICS_ACCELEROMETERS_BUF_KFIFO
> +       struct iio_trigger *trig;
> +#endif /* CONFIG_STMICROELECTRONICS_ACCELEROMETERS_BUF_KFIFO */
> +
> +       int *irq_data_ready;
> +       struct mutex slock;
> +
> +};
> +
[...]
> +
> +#endif /* ST_ACCELEROMETERS_IIO_ACC_H */

There is no need for most of this to be globally visible. Put everything except
for the platform data into a local header drivers/iio/accel. And put the header
containing the platform data in include/linux/platform_data/
