Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-146.synserver.de ([212.40.185.146]:1204 "EHLO
	smtp-out-146.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932469Ab2JZMKX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Oct 2012 08:10:23 -0400
Message-ID: <508A7DA6.7050505@metafoo.de>
Date: Fri, 26 Oct 2012 14:10:14 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: Jonathan Cameron <jic23@kernel.org>,
	Denis Ciocca <denis.ciocca@gmail.com>,
	Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	Pavel Machek <pavel@denx.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"burman.yan@gmail.com" <burman.yan@gmail.com>
Subject: Re: STMicroelectronics accelerometers driver.
References: <5072F3B9.4050309@st.com> <5073260C.3010506@metafoo.de> <20121008195007.GA32042@elf.ucw.cz> <507338B5.60307@metafoo.de> <665718a4-de6b-4d09-ba80-35705fcf2595@email.android.com> <CAEE_umojW5OyB3yGgE54wH7_k__dBu9=Yew_0tCCf5--=C2g5g@mail.gmail.com> <507D9EA3.4070009@metafoo.de> <5085128C.7020507@st.com> <50858B44.2080006@kernel.org> <5087E2A8.4070304@st.com>
In-Reply-To: <5087E2A8.4070304@st.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/24/2012 02:44 PM, Denis CIOCCA wrote:
> Hi Jonathan,
> 
> 
>> For the non buffered case - reading is slow anyway so if anyone cares
>> they will be doing buffered reads.  For buffered reads this isn't going
>> to change often (and there is a lot of cost associated with bringing the buffer
>> up and down anyway) so a little cost in disabling the channel is minor
>> compared to the cost of hammering the bus unecessarily - particularly with
>> good old slow i2c.
>>
>> So I'd be inclined to turn on only channels we care about.  Do you have
>> an estimate of how long it will take to turn one on for a single read?
> 
> I have checked what you tell me about power on/off of the axis. For the
> buffered case I have modify the driver to power on and off the single
> axis. What you think about my driver now? It is necessary other modify?

We'll need at least another revision, since you did not address all comments
from my last review. But I guess 2-3 more revision are more realistic.

> Thanks
> 
> Denis
> 
> 
> (If you want I send this patch by git because I don't know if this is
> the better way)

For the final version it's better to use git send-email. Your mailclient for
example seems to replace tabs with spaces and also insert a extra newline
occasionally. This is not nice, but, well, does not really impact review.

> 
> 
> 
>  From b34e061a37655da5ab9bacde4d9a38bb9d3cf69f Mon Sep 17 00:00:00 2001
> From: Denis Ciocca <denis.ciocca@st.com>
> Date: Mon, 22 Oct 2012 11:17:27 +0200
> Subject: [PATCH 1/2] iio:accel: Add STMicroelectronics accelerometers driver
> 
> This patch adds generic accelerometer driver for STMicroelectronics
> accelerometers, currently it supports:
> LSM303DLH, LSM303DLHC, LIS3DH, LSM330D, LSM330DL, LSM330DLC, LSM303D,
> LSM9DS0, LIS331DLH, LSM303DL, LSM303DLM, LSM330
> 
> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
> ---
>   drivers/iio/accel/Kconfig                    |   37 +
>   drivers/iio/accel/Makefile                   |    6 +
>   drivers/iio/accel/st_accel_buffer.c          |  166 ++++
>   drivers/iio/accel/st_accel_core.c            | 1342
> ++++++++++++++++++++++++++
>   drivers/iio/accel/st_accel_i2c.c             |  139 +++
>   drivers/iio/accel/st_accel_spi.c             |  199 ++++
>   drivers/iio/accel/st_accel_trigger.c         |   84 ++
>   include/linux/iio/accel/st_accel.h           |  122 +++
>   include/linux/platform_data/st_accel_pdata.h |   27 +
>   9 files changed, 2122 insertions(+), 0 deletions(-)
>   create mode 100644 drivers/iio/accel/st_accel_buffer.c
>   create mode 100644 drivers/iio/accel/st_accel_core.c
>   create mode 100644 drivers/iio/accel/st_accel_i2c.c
>   create mode 100644 drivers/iio/accel/st_accel_spi.c
>   create mode 100644 drivers/iio/accel/st_accel_trigger.c
>   create mode 100644 include/linux/iio/accel/st_accel.h
>   create mode 100644 include/linux/platform_data/st_accel_pdata.h
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index b2510c4..d65e66a 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -13,4 +13,41 @@ config HID_SENSOR_ACCEL_3D
>           Say yes here to build support for the HID SENSOR
>           accelerometers 3D.
> 
> +config ST_ACCEL_3AXIS
> +       tristate "STMicroelectronics accelerometers 3-Axis Driver"
> +       depends on (I2C || SPI) && SYSFS
> +       help
> +         Say yes here to build support for STMicroelectronics accelerometers:
> +         LSM303DLH, LSM303DLHC, LIS3DH, LSM330D, LSM330DL, LSM330DLC, LSM303D,
> +         LSM9DS0, LIS331DLH, LSM303DL, LSM303DLM, LSM330.
> +
> +         This driver can also be built as a module. If so, the module
> +         will be called st_accel.
> +
> +config ST_ACCEL_3AXIS_I2C
> +       tristate "support I2C bus connection"
> +       depends on ST_ACCEL_3AXIS && I2C
> +       help
> +         Say yes here to build I2C support for STMicroelectronics accelerometers.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called st_accel_i2c.
> +
> +config ST_ACCEL_3AXIS_SPI
> +       tristate "support SPI bus connection"
> +       depends on ST_ACCEL_3AXIS && SPI_MASTER
> +       help
> +         Say yes here to build SPI support for STMicroelectronics accelerometers.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called st_accel_spi.
> +
> +config ST_ACCEL_3AXIS_TRIGGERED_BUFFER
> +       tristate "support triggered buffer"
> +       depends on ST_ACCEL_3AXIS
> +       select IIO_TRIGGERED_BUFFER
> +       select IIO_BUFFER
> +       help
> +         Default trigger and buffer for STMicroelectronics accelerometers driver.
> +
>   endmenu
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index 5bc6855..1541236 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -3,3 +3,9 @@
>   #
> 
>   obj-$(CONFIG_HID_SENSOR_ACCEL_3D) += hid-sensor-accel-3d.o
> +
> +st_accel-y := st_accel_core.o
> +obj-$(CONFIG_ST_ACCEL_3AXIS_I2C) += st_accel_i2c.o
> +obj-$(CONFIG_ST_ACCEL_3AXIS_SPI) += st_accel_spi.o
> +obj-$(CONFIG_ST_ACCEL_3AXIS_TRIGGERED_BUFFER) += st_accel_trigger.o
> st_accel_buffer.o
> +obj-$(CONFIG_ST_ACCEL_3AXIS) += st_accel.o
> diff --git a/drivers/iio/accel/st_accel_buffer.c
> b/drivers/iio/accel/st_accel_buffer.c
> new file mode 100644
> index 0000000..600ecc6
> --- /dev/null
> +++ b/drivers/iio/accel/st_accel_buffer.c
> @@ -0,0 +1,166 @@
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
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/stat.h>
> +#include <linux/interrupt.h>
> +#include <linux/byteorder/generic.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +#include <linux/iio/accel/st_accel.h>
> +
> +#define ST_ACCEL_ENABLE_ALL_CHANNELS           0x07
> +
> +
> +static int st_accel_read_all(struct iio_dev *indio_dev, u8 *rx_array)
> +{
> +       int len = 0, i, n = 0;
> +       u8 reg_addr[ST_ACCEL_NUMBER_DATA_CHANNELS];
> +       struct st_accel_data *adata = iio_priv(indio_dev);
> +
> +       for (i = 0; i < ST_ACCEL_NUMBER_DATA_CHANNELS; i++) {
> +               if (test_bit(i, indio_dev->active_scan_mask)) {
> +                       reg_addr[n] = indio_dev->channels[i].address;
> +                       n++;
> +               }
> +       }
> +       switch (n) {
> +       case 1:
> +               len = adata->read_multiple_byte(adata, reg_addr[0],
> +                                       ST_ACCEL_BYTE_FOR_CHANNEL, rx_array);
> +               break;
> +       case 2:
> +               if ((reg_addr[1] - reg_addr[0]) == ST_ACCEL_BYTE_FOR_CHANNEL) {
> +                       len = adata->read_multiple_byte(adata, reg_addr[0],
> +                                       ST_ACCEL_BYTE_FOR_CHANNEL*n,
> +                                       rx_array);
> +               } else {
> +                       len = adata->read_multiple_byte(adata, reg_addr[0],
> +                               ST_ACCEL_BYTE_FOR_CHANNEL*
> +                               ST_ACCEL_NUMBER_DATA_CHANNELS,
> +                               rx_array);
> +                       rx_array[2] = rx_array[4];
> +                       rx_array[3] = rx_array[5];
> +                       len = ST_ACCEL_BYTE_FOR_CHANNEL*n;
> +               }
> +               break;
> +       case 3:
> +               len = adata->read_multiple_byte(adata, reg_addr[0],
> +                       ST_ACCEL_BYTE_FOR_CHANNEL*ST_ACCEL_NUMBER_DATA_CHANNELS,
> +                       rx_array);
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return len;
> +}
> +
> +static int st_accel_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
> +{
> +       int ret, i, scan_count;
> +       u8 rx_array[ST_ACCEL_BYTE_FOR_CHANNEL*ST_ACCEL_NUMBER_DATA_CHANNELS];
> +       s16 *data = (s16 *)buf;
> +
> +       ret = st_accel_read_all(indio_dev, rx_array);
> +       if (ret < 0)
> +               return ret;
> +
> +       scan_count = bitmap_weight(indio_dev->active_scan_mask,
> +                                                       indio_dev->masklength);
> +
> +       for (i = 0; i < scan_count; i++)
> +               data[i] = (s16)(((s16)(rx_array[2*i+1]) << 8) | rx_array[2*i]);

There is no need to perform endian conversion

> +
> +       return i*sizeof(data[0]);
> +}
> +
> +static irqreturn_t st_accel_trigger_handler(int irq, void *p)
> +{
> +       struct iio_poll_func *pf = p;
> +       struct iio_dev *indio_dev = pf->indio_dev;
> +       int len = 0;
> +       char *data;
> +
> +       data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
> +       if (data == NULL)
> +               goto done;

You could preallocate data in your postenable callback, so you don't have to
do this each time the trigger handler is called.

> +       if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))

The bitmap will never be empty at this point

> +               len = st_accel_get_buffer_element(indio_dev, data);
> +       else
> +               goto done;
> +       if (indio_dev->scan_timestamp)
> +               *(s64 *)((u8 *)data + ALIGN(len, sizeof(s64))) = pf->timestamp;
> +       iio_push_to_buffer(indio_dev->buffer, data);
> +       kfree(data);
> +
> +done:
> +       iio_trigger_notify_done(indio_dev->trig);
> +       return IRQ_HANDLED;
> +}
> +
> +static int st_accel_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +       int err, i;
> +       u8 active_bit = 0x00;
> +
> +       for (i = 0; i < ST_ACCEL_NUMBER_DATA_CHANNELS; i++)
> +               if (test_bit(i, indio_dev->active_scan_mask))
> +                       active_bit |= (1 << i);
> +
> +       err = st_accel_set_axis_enable(indio_dev, active_bit);
> +       if (err < 0)
> +               goto st_accel_buffer_postenable_error;
> +
> +       err = iio_triggered_buffer_postenable(indio_dev);
> +
> +st_accel_buffer_postenable_error:
> +       return err;
> +}
> +
> +static int st_accel_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +       int err;
> +
> +       err = iio_triggered_buffer_predisable(indio_dev);
> +       if (err < 0)
> +               goto st_accel_buffer_predisable_error;
> +
> +       err = st_accel_set_axis_enable(indio_dev, ST_ACCEL_ENABLE_ALL_CHANNELS);
> +
> +st_accel_buffer_predisable_error:
> +       return err;
> +}
> +
> +static const struct iio_buffer_setup_ops st_accel_buffer_setup_ops = {
> +       .preenable = &iio_sw_buffer_preenable,
> +       .postenable = &st_accel_buffer_postenable,
> +       .predisable = &st_accel_buffer_predisable,
> +};
> +
> +int st_accel_allocate_ring(struct iio_dev *indio_dev)
> +{
> +       indio_dev->scan_timestamp = true;
> +       return iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
> +                       &st_accel_trigger_handler, &st_accel_buffer_setup_ops);
> +}
> +EXPORT_SYMBOL(st_accel_allocate_ring);
> +
> +void st_accel_deallocate_ring(struct iio_dev *indio_dev)
> +{
> +       iio_triggered_buffer_cleanup(indio_dev);
> +}
> +EXPORT_SYMBOL(st_accel_deallocate_ring);
> diff --git a/drivers/iio/accel/st_accel_core.c
> b/drivers/iio/accel/st_accel_core.c
> new file mode 100644
> index 0000000..97ea1b7
> --- /dev/null
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -0,0 +1,1342 @@
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
> +#include <linux/errno.h>
> +#include <linux/types.h>
> +#include <linux/mutex.h>
> +#include <linux/interrupt.h>
> +#include <linux/i2c.h>
> +#include <linux/gpio.h>
> +#include <linux/irq.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/buffer.h>
> +
> +#include <linux/iio/accel/st_accel.h>
> +#include <linux/platform_data/st_accel_pdata.h>
> +
[...]

> +static int st_accel_write_data_with_mask(struct iio_dev *indio_dev, u8
> reg_addr,
> +                                               u8 mask, short num_bit, u8 data)
> +{
> +       int err, j, pos;
> +       u8 prev_data;
> +       u8 new_data;
> +       struct st_accel_data *adata = iio_priv(indio_dev);
> +
> +       pos = 8 - num_bit;
> +       for (j = 128; j >= 0; j = j/2) {
> +               if (mask / j > 0)
> +                       break;
> +               else
> +                       pos--;
> +       }

is this pos = __ffs(mask)? Or can't you just pass in pos directly instead of
num_bit? I think that would make the code much more straight forward.

> +
> +       err = adata->read_byte(adata, reg_addr, &prev_data);
> +       if (err < 0)
> +               goto st_accel_write_data_with_mask_error;
> +
> +       new_data = ((prev_data & (~mask)) | ((data << pos) & mask));
> +       err = adata->write_byte(adata, reg_addr, new_data);
> +
> +st_accel_write_data_with_mask_error:
> +       return err;
> +}
> +
> +static int st_accel_match_odr(const struct st_accel_sensors *sensor,
> +               unsigned int odr, struct st_accel_odr_available *odr_out)
> +{
> +       int i, ret = -1;

Since you pass it on to userspace this needs to be a proper error code, e.g.
EINVAL

> +
> +       for (i = 0; i < ARRAY_SIZE(sensor->odr.odr_avl); i++) {
> +               if (sensor->odr.odr_avl[i].hz == odr) {
> +                       odr_out->hz = sensor->odr.odr_avl[i].hz;
> +                       odr_out->value = sensor->odr.odr_avl[i].value;
> +                       ret = 0;
> +                       break;
> +               }
> +       }
> +
> +       return ret;
> +}
> +
> +static int st_accel_match_fs(const struct st_accel_sensors *sensor,
> +               unsigned int fs, struct st_accel_fullscale_available *fs_out)
> +{
> +       int i, ret = -1;

Same here

> +
> +       for (i = 0; i < ARRAY_SIZE(sensor->fs.fs_avl); i++) {
> +               if (sensor->fs.fs_avl[i].num == fs) {
> +                       fs_out->num = sensor->fs.fs_avl[i].num;
> +                       fs_out->gain = sensor->fs.fs_avl[i].gain;
> +                       fs_out->value = sensor->fs.fs_avl[i].value;
> +                       ret = 0;
> +                       break;
> +               }
> +       }
> +
> +       return ret;
> +}
> +
[...]
> +
> +static int st_accel_set_enable(struct iio_dev *indio_dev, int enable)

I'd just let this take a bool instead of an int, lets you avoid some casts.
ST_ACCEL_{ON,OFF} is kind of your custom bool, just use true and false instead

> +{
[...]
> +
> +static int st_accel_read_raw(struct iio_dev *indio_dev,
> +                       struct iio_chan_spec const *ch, int *val,
> +                                                       int *val2, long mask)
> +{
> +       int err;
> +       u8 outdata[ST_ACCEL_BYTE_FOR_CHANNEL];
> +       struct st_accel_data *adata = iio_priv(indio_dev);
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_RAW:
> +               mutex_lock(&indio_dev->mlock);
> +               if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
> +                       err = -EBUSY;
> +                       goto read_error;
> +               } else {
> +                       if (!adata->enabled) {
> +                               err = -EIO;
> +                               goto read_error;
> +                       } else {
> +                               err = adata->read_multiple_byte(adata,
> +                                       ch->address, ST_ACCEL_BYTE_FOR_CHANNEL,
> +                                       outdata);
> +                               if (err < 0)
> +                                       goto read_error;
> +
> +                               *val = ((s16)(((s16)(outdata[1]) << 8)
> +                                       | outdata[0])) >> ch->scan_type.shift;
> +                       }
> +               }
> +               mutex_unlock(&indio_dev->mlock);
> +               return IIO_VAL_INT;
> +       case IIO_CHAN_INFO_SCALE:
> +               *val = 0;
> +               *val2 = UG_TO_MS2(adata->gain);

There is no a generic macro for G to MS2 in iio called IIO_G_TO_M_S_2. I
think you can also do the conversion of G to m/s**2 at compile time when you
initilize the gain attributes of the st_accel_fullscale strutcs

> +               return IIO_VAL_INT_PLUS_NANO;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +read_error:
> +       mutex_unlock(&indio_dev->mlock);
> +       return err;
> +}
> +
> +static int st_accel_check_device_list(struct iio_dev *indio_dev, u8 wai)
> +{
> +       int i;
> +       bool found;
> +       struct st_accel_data *adata = iio_priv(indio_dev);
> +
> +       found = false;
> +       for (i = 0; i < ARRAY_SIZE(st_accel_sensors); i++) {
> +               if (st_accel_sensors[i].wai == wai) {
> +                       found = true;
> +                       break;
> +               }
> +       }
> +       if (!found)

You can just do 'i != ARRAY_SIZE(st_accel_sensors)' instead of 'found'.

> +               goto check_device_error;
> +
> +       adata->index = i;
> +
> +       return i;
> +
> +check_device_error:
> +       dev_err(&indio_dev->dev, "device not supported -> wai (0x%x).\n", wai);
> +       return -ENODEV;
> +}
[...]
[...]
> +static ssize_t st_accel_sysfs_get_fullscale(struct device *dev,
> +                               struct device_attribute *attr, char *buf)
> +{
> +       struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +       struct st_accel_data *adata = iio_priv(indio_dev);
> +
> +       return sprintf(buf, "%d\n", adata->fullscale);
> +}
> +
> +static ssize_t st_accel_sysfs_set_fullscale(struct device *dev,
> +               struct device_attribute *attr, const char *buf, size_t size)
> +{
> +       int err;
> +       unsigned int fs;
> +       struct st_accel_fullscale_available fs_out;
> +       struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +       struct st_accel_data *adata = iio_priv(indio_dev);
> +
> +       err = kstrtoint(buf, 10, &fs);
> +       if (err < 0)
> +               goto conversion_error;
> +
> +       mutex_lock(&indio_dev->mlock);
> +       err = st_accel_match_fs(&st_accel_sensors[adata->index], fs, &fs_out);
> +       if (err < 0)
> +               goto match_fullscale_error;
> +
> +       err = st_accel_set_fullscale(indio_dev, &fs_out);
> +       if (err < 0) {
> +               dev_err(&indio_dev->dev,
> +                       "failed to set new fullscale. (errn %d).\n", err);
> +       }
> +
> +match_fullscale_error:
> +       mutex_unlock(&indio_dev->mlock);
> +conversion_error:
> +       return size;
> +}

I don't think you need the fullscale attribute. This is just the same as the
scale attribute just in a different representation, as far as I can see.

> +
> +static ssize_t st_accel_sysfs_fullscale_available(struct device *dev,
> +                               struct device_attribute *attr, char *buf)
> +{
> +       int i, len = 0;
> +       struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +       struct st_accel_data *adata = iio_priv(indio_dev);
> +
> +       mutex_lock(&indio_dev->mlock);
> +       for (i = 0; i < ARRAY_SIZE(st_accel_sensors[adata->index].fs.fs_avl);
> +                                                                       i++) {
> +               if (st_accel_sensors[adata->index].fs.fs_avl[i].num == 0)
> +                       break;
> +
> +               len += sprintf(buf+len, "%d ",
> +                       st_accel_sensors[adata->index].fs.fs_avl[i].num);
> +       }
> +       mutex_unlock(&indio_dev->mlock);
> +
> +       len--;
> +       len += sprintf(buf+len, "\n");

just buf[len-1] = '\n'; would be simpler

> +       return len;
> +}
> +
> +static ssize_t st_accel_sysfs_sampling_frequency_available(struct
> device *dev,
> +                               struct device_attribute *attr, char *buf)
> +{
> +       int i, len = 0;
> +       struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +       struct st_accel_data *adata = iio_priv(indio_dev);
> +
> +       mutex_lock(&indio_dev->mlock);
> +       for (i = 0; i < ARRAY_SIZE(st_accel_sensors[adata->index].odr.odr_avl);
> +                                                                       i++) {
> +               if (st_accel_sensors[adata->index].odr.odr_avl[i].hz == 0)
> +                       break;
> +
> +               len += sprintf(buf+len, "%d ",
> +                       st_accel_sensors[adata->index].odr.odr_avl[i].hz);
> +       }
> +       mutex_unlock(&indio_dev->mlock);
> +
> +       len--;
> +       len += sprintf(buf+len, "\n");

just buf[len-1] = '\n'; would be simpler

> +       return len;
> +}
> +
> +/**
> + * IIO_DEVICE_ATTR - sampling_frequency_available
> + * @read: show all frequency available of the sensor.
> + *
> + */
> +
> +static IIO_DEVICE_ATTR(sampling_frequency_available, S_IRUGO,
> +               st_accel_sysfs_sampling_frequency_available, NULL , 0);
> +
> +/**
> + * IIO_DEVICE_ATTR - fullscale_available
> + * @read: show all fullscale available of the sensor.
> + *
> + */
> +
> +static IIO_DEVICE_ATTR(fullscale_available, S_IRUGO,
> +               st_accel_sysfs_fullscale_available, NULL , 0);
> +
> +/**
> + * IIO_DEVICE_ATTR - fullscale
> + * @read: show the current fullscale of the sensor.
> + * @write: store the current fullscale of the sensor.
> + *
> + */
> +
> +static IIO_DEVICE_ATTR(fullscale, S_IWUSR | S_IRUGO,
> +               st_accel_sysfs_get_fullscale, st_accel_sysfs_set_fullscale , 0);
> +

You need to document the non-standard sysfs files in a text document in
Documentation/ABI/testing/sysfs-bus-iio-accel-st. See the other files in
that folder for an example

> +/**
> + * IIO_DEVICE_ATTR - enable
> + * @read: show the current status of the sensor.
> + * @write: power on/off the sensor.
> + *
> + */
> +
> +static IIO_DEVICE_ATTR(enable, S_IWUSR | S_IRUGO,
> st_accel_sysfs_get_enable,
> +               st_accel_sysfs_set_enable , 0);
> +
> +static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
> +                       st_accel_sysfs_get_sampling_frequency,
> +                                       st_accel_sysfs_set_sampling_frequency);
> +

I still don't get why you need this. Can't you just power-up and down the
device on demand?
> +
[...]
> +int st_accel_iio_probe(struct iio_dev *indio_dev)
> +{
> +       int err;
> +       u8 wai;
> +       struct st_accel_data *adata = iio_priv(indio_dev);
> +       struct st_accel_platform_data *pdata;
> +
> +       mutex_init(&adata->slock);
> +       indio_dev->modes = INDIO_DIRECT_MODE;
> +       indio_dev->info = &acc_info;
> +
> +       err = st_accel_get_wai_device(indio_dev,
> +                                       ST_ACCEL_DEFAULT_WAI_ADDRESS, &wai);
> +       if (err < 0)
> +               goto st_accel_iio_probe_error;
> +
> +       err = st_accel_check_device_list(indio_dev, wai);
> +       if (err < 0)
> +               goto st_accel_iio_probe_error;
> +
> +       adata->multiread_bit = st_accel_sensors[adata->index].multi_read_bit;
> +       indio_dev->channels = st_accel_sensors[adata->index].ch;
> +       indio_dev->num_channels = ST_ACCEL_NUMBER_ALL_CHANNELS;
> +       pdata = adata->dev->platform_data;

How about if (!pdata)
		pdata = &st_accel_default_pdata;

> +       if (pdata == NULL) {
> +               adata->fullscale = st_accel_default_pdata.fullscale;
> +               adata->odr = st_accel_default_pdata.sampling_frequency;
> +       } else {
> +               adata->fullscale = pdata->fullscale;
> +               adata->odr = pdata->sampling_frequency;
> +       }
> +
> +       err = st_accel_init_sensor(indio_dev);
> +       if (err < 0)
> +               goto st_accel_iio_probe_error;
> +
> +       err = st_accel_allocate_ring(indio_dev);
> +       if (err < 0)
> +               goto st_accel_iio_probe_error;
> +
> +       if (*adata->irq_data_ready > 0) {
> +               err = st_accel_probe_trigger(indio_dev);
> +               if (err < 0)
> +                       goto acc_probe_trigger_error;
> +       }
> +
> +       err = iio_device_register(indio_dev);
> +       if (err)
> +               goto iio_device_register_error;
> +
> +       return err;
> +
> +iio_device_register_error:
> +       st_accel_remove_trigger(indio_dev);
> +acc_probe_trigger_error:
> +       st_accel_deallocate_ring(indio_dev);
> +st_accel_iio_probe_error:
> +       return err;
> +}
> +EXPORT_SYMBOL(st_accel_iio_probe);
> +
> +void st_accel_iio_remove(struct iio_dev *indio_dev)
> +{
> +       iio_device_unregister(indio_dev);
> +       st_accel_remove_trigger(indio_dev);
> +       st_accel_deallocate_ring(indio_dev);
> +       iio_device_free(indio_dev);
> +}
> +EXPORT_SYMBOL(st_accel_iio_remove);
> +
> +MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
> +MODULE_DESCRIPTION("STMicroelectronics accelerometers driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/accel/st_accel_i2c.c
> b/drivers/iio/accel/st_accel_i2c.c
> new file mode 100644
> index 0000000..7cfeb4c
> --- /dev/null
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -0,0 +1,139 @@
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
> +#include <linux/iio/trigger.h>
> +
> +#include <linux/iio/accel/st_accel.h>
> +
> +
> +#define ST_ACCEL_I2C_MULTIREAD                 0x80
> +
> +static int st_accel_i2c_read_byte(struct st_accel_data *adata,
> +                                               u8 reg_addr, u8 *res_byte)
> +{
> +       int err;
> +
> +       err = i2c_smbus_read_byte_data(to_i2c_client(adata->dev), reg_addr);
> +       if (err < 0)
> +               goto st_accel_i2c_read_byte_error;
> +       *res_byte = err & 0xff;
> +       return err;

Shouldn't this be return 0?

> +
> +st_accel_i2c_read_byte_error:
> +       return -EIO;

Just return err

> +}
> +
> +static int st_accel_i2c_read_multiple_byte(struct st_accel_data *adata,
> +                                               u8 reg_addr, int len, u8 *data)
> +{
> +       int err;
> +
> +       if (adata->multiread_bit == true)
> +               reg_addr |= ST_ACCEL_I2C_MULTIREAD;
> +
> +       err = i2c_smbus_read_i2c_block_data(to_i2c_client(adata->dev),
> +                                                       reg_addr, len, data);
> +       if (err < 0)
> +               goto st_accel_i2c_read_multiple_byte_error;
> +
> +       return err;
> +
> +st_accel_i2c_read_multiple_byte_error:
> +       return -EIO;

Just return err. Also makes the code much simpler since you don't need the
goto and could just do a  return i2c_smbus_read_i2c_block_data(...)

> +}
> +
[...]
> diff --git a/drivers/iio/accel/st_accel_spi.c
> b/drivers/iio/accel/st_accel_spi.c
> new file mode 100644
> index 0000000..40279bd
> --- /dev/null
> +++ b/drivers/iio/accel/st_accel_spi.c
> @@ -0,0 +1,199 @@
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
> +#include <linux/spi/spi.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +
> +#include <linux/iio/accel/st_accel.h>
> +
> +
> +#define ACC_SPI_READ           0x80;
> +#define ACC_SPI_MULTIREAD      0xc0
> +
> +static int st_accel_spi_read_byte(struct st_accel_data *adata,
> +                                               u8 reg_addr, u8 *res_byte)
> +{
> +       struct spi_message msg;
> +       int err;
> +       u8 tx;
> +
> +       struct spi_transfer xfers[] = {
> +               {
> +                       .tx_buf = &tx,
> +                       .bits_per_word = 8,
> +                       .len = 1,
> +               },
> +               {
> +                       .rx_buf = res_byte,
> +                       .bits_per_word = 8,
> +                       .len = 1,
> +               }
> +       };
> +
> +       mutex_lock(&adata->slock);
> +       tx = reg_addr | ACC_SPI_READ;
> +       spi_message_init(&msg);
> +       spi_message_add_tail(&xfers[0], &msg);
> +       spi_message_add_tail(&xfers[1], &msg);
> +       err = spi_sync(to_spi_device(adata->dev), &msg);
> +       mutex_unlock(&adata->slock);

Why does the spi code require locking and the i2c does not? Everything here
seems to be on the stack, and the SPI bus has internal locking, so I don't
think it is necessary to take slock.

> +       if (err)
> +               goto acc_spi_read_byte_error;
> +
> +       return err;
> +
> +acc_spi_read_byte_error:
> +       return -EIO;

Just returne err.

> +}
> +
> +static int st_accel_spi_read_multiple_byte(struct st_accel_data *adata,
> +                                               u8 reg_addr, int len, u8 *data)
> +{
> +       struct spi_message msg;
> +       int err;
> +       u8 tx;
> +
> +       struct spi_transfer xfers[] = {
> +               {
> +                       .tx_buf = &tx,
> +                       .bits_per_word = 8,
> +                       .len = 1,
> +               },
> +               {
> +                       .rx_buf = data,
> +                       .bits_per_word = 8,
> +                       .len = len,
> +               }
> +       };
> +
> +       mutex_lock(&adata->slock);
> +       if (adata->multiread_bit == true)
> +               tx = reg_addr | ACC_SPI_MULTIREAD;
> +       else
> +               tx = reg_addr | ACC_SPI_READ;
> +
> +       spi_message_init(&msg);
> +       spi_message_add_tail(&xfers[0], &msg);
> +       spi_message_add_tail(&xfers[1], &msg);
> +       err = spi_sync(to_spi_device(adata->dev), &msg);
> +       mutex_unlock(&adata->slock);

Same thing about locking as above

> +       if (err)
> +               goto acc_spi_read_multiple_byte_error;
> +       return len;
> +
> +acc_spi_read_multiple_byte_error:
> +       return -EIO;

Just return err

> +}
> +
> +static int st_accel_spi_write_byte(struct st_accel_data *adata,
> +                                                       u8 reg_addr, u8 data)
> +{
> +       struct spi_message msg;
> +       int err;
> +       u8 tx[2];
> +
> +       struct spi_transfer xfers[] = {
> +               {
> +                       .tx_buf = tx,
> +                       .bits_per_word = 8,
> +                       .len = 2,
> +               }
> +       };
> +
> +       mutex_lock(&adata->slock);
> +       tx[0] = reg_addr;
> +       tx[1] = data;
> +       spi_message_init(&msg);
> +       spi_message_add_tail(&xfers[0], &msg);
> +       err = spi_sync(to_spi_device(adata->dev), &msg);
> +       mutex_unlock(&adata->slock);

Again, is the lock necessary?

> +
> +       return err;
> +}
> +
[...]
> diff --git a/drivers/iio/accel/st_accel_trigger.c
> b/drivers/iio/accel/st_accel_trigger.c
[...]
> diff --git a/include/linux/iio/accel/st_accel.h
> b/include/linux/iio/accel/st_accel.h
> new file mode 100644
> index 0000000..557d8cf
> --- /dev/null
> +++ b/include/linux/iio/accel/st_accel.h
> @@ -0,0 +1,122 @@
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
> +/*
> + * Supported sensors:
> + * LSM303DLH
> + * LSM303DLHC
> + * LIS3DH
> + * LSM330D
> + * LSM330DL
> + * LSM330DLC
> + * LSM303D
> + * LSM9DS0
> + * LIS331DLH
> + * LSM303DL
> + * LSM303DLM
> + * LSM330
> + *
> + */
> +
> +
> +#ifndef ST_ACCEL_H
> +#define ST_ACCEL_H
> +
> +#define LSM303DLH_ACCEL_DEV_NAME       "lsm303dlh_accel"
> +#define LSM303DLHC_ACCEL_DEV_NAME      "lsm303dlhc_accel"
> +#define LIS3DH_ACCEL_DEV_NAME          "lis3dh"
> +#define LSM330D_ACCEL_DEV_NAME         "lsm330d_accel"
> +#define LSM330DL_ACCEL_DEV_NAME                "lsm330dl_accel"
> +#define LSM330DLC_ACCEL_DEV_NAME       "lsm330dlc_accel"
> +#define LSM303D_ACCEL_DEV_NAME         "lsm303d"
> +#define LSM9DS0_ACCEL_DEV_NAME         "lsm9ds0"
> +#define LIS331DLH_ACCEL_DEV_NAME       "lis331dlh"
> +#define LSM303DL_ACCEL_DEV_NAME                "lsm303dl_accel"
> +#define LSM303DLM_ACCEL_DEV_NAME       "lsm303dlm_accel"
> +#define LSM330_ACCEL_DEV_NAME          "lsm330_accel"
> +
> +#define ST_ACCEL_NUMBER_ALL_CHANNELS   4
> +#define ST_ACCEL_NUMBER_DATA_CHANNELS  3
> +#define ST_ACCEL_BYTE_FOR_CHANNEL      2
> +#define ST_ACCEL_SCAN_X                        0
> +#define ST_ACCEL_SCAN_Y                        1
> +#define ST_ACCEL_SCAN_Z                        2
> +
> +/**
> + * struct st_accel_data - ST accel device status
> + * @dev: Pointer to instance of struct device (I2C or SPI).
> + * @name: Name of the sensor in use.
> + * @enabled: Status of the sensor (0->off, 1->on).
> + * @index: Number used to point the sensor being used in the
> + *     st_accel_sensors struct.
> + * @fullscale: Maximum range of measure by the sensor.
> + * @gain: Sensitivity of the sensor [ug/LSB].
> + * @odr: Output data rate of the sensor.
> + * @multiread_bit: Use or not particular bit for [I2C/SPI] multiread.
> + * @read_byte: Function used to read one byte.
> + * @write_byte: Function used to write one byte.
> + * @read_multiple_byte: Function used to read multiple byte.
> + * @trig: The trigger in use by the core driver.
> + * @irq_data_ready: IRQ number for data ready on INT1 pin.
> + * @slock: mutex for read and write operation.
> + *
> + */
> +
> +struct st_accel_data {
> +       struct device *dev;
> +       bool enabled;
> +       short index;
> +
> +       unsigned int fullscale;
> +       unsigned int gain;
> +       unsigned int odr;
> +
> +       bool multiread_bit;
> +       int (*read_byte) (struct st_accel_data *adata, u8 reg_addr,
> +                                                               u8 *res_byte);
> +       int (*write_byte) (struct st_accel_data *adata, u8 reg_addr, u8 data);
> +       int (*read_multiple_byte) (struct st_accel_data *adata, u8 reg_addr,
> +                                                       int len, u8 *data);
> +
> +       struct iio_trigger *trig;
> +       int *irq_data_ready;

I still don't get why this has to be a pointer...

> +       struct mutex slock;
> +};
> +
> +int st_accel_iio_probe(struct iio_dev *indio_dev);
> +void st_accel_iio_remove(struct iio_dev *indio_dev);
> +int st_accel_set_dataready_irq(struct iio_dev *indio_dev, bool enable);
> +int st_accel_set_axis_enable(struct iio_dev *indio_dev, u8 axis_enable);
> +
> +#ifdef CONFIG_IIO_BUFFER
> +int st_accel_probe_trigger(struct iio_dev *indio_dev);
> +void st_accel_remove_trigger(struct iio_dev *indio_dev);
> +int st_accel_allocate_ring(struct iio_dev *indio_dev);
> +void st_accel_deallocate_ring(struct iio_dev *indio_dev);
> +#else /* CONFIG_IIO_BUFFER */
> +static inline int st_accel_probe_trigger(struct iio_dev *indio_dev)
> +{
> +       return 0;
> +}
> +static inline void st_accel_remove_trigger(struct iio_dev *indio_dev)
> +{
> +       return;
> +}
> +static inline int st_accel_allocate_ring(struct iio_dev *indio_dev)
> +{
> +       return 0;
> +}
> +static inline void st_accel_deallocate_ring(struct iio_dev *indio_dev)
> +{
> +       return;
> +}
> +#endif /* CONFIG_IIO_BUFFER */
> +
> +#endif /* ST_ACCEL_H */
> diff --git a/include/linux/platform_data/st_accel_pdata.h
> b/include/linux/platform_data/st_accel_pdata.h
> new file mode 100644
> index 0000000..416489b
> --- /dev/null
> +++ b/include/linux/platform_data/st_accel_pdata.h
> @@ -0,0 +1,27 @@
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
> +
> +#ifndef ST_ACCEL_PDATA_H
> +#define ST_ACCEL_PDATA_H
> +
> +
> +/**
> + * struct st_accel_platform_data - ST accel device platform data
> + * @fullscale: Value of fullscale used for the sensor.
> + * @sampling_frequency: Value of sampling frequency used for the sensor.
> + */
> +
> +struct st_accel_platform_data {
> +       int fullscale;
> +       int sampling_frequency;
> +};
> +
> +#endif /* ST_ACCEL_PDATA_H */
> --
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

