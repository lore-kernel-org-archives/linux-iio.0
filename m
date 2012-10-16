Return-Path: <lars@metafoo.de>
Message-ID: <507D9EA3.4070009@metafoo.de>
Date: Tue, 16 Oct 2012 19:51:31 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Denis Ciocca <denis.ciocca@gmail.com>
CC: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
 Pavel Machek <pavel@denx.de>,
 Denis CIOCCA <denis.ciocca@st.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Jonathan Cameron <jic23@kernel.org>,
 "burman.yan@gmail.com" <burman.yan@gmail.com>
Subject: Re: STMicroelectronics accelerometers driver.
References: <5072F3B9.4050309@st.com> <5073260C.3010506@metafoo.de> <20121008195007.GA32042@elf.ucw.cz> <507338B5.60307@metafoo.de> <665718a4-de6b-4d09-ba80-35705fcf2595@email.android.com> <CAEE_umojW5OyB3yGgE54wH7_k__dBu9=Yew_0tCCf5--=C2g5g@mail.gmail.com>
In-Reply-To: <CAEE_umojW5OyB3yGgE54wH7_k__dBu9=Yew_0tCCf5--=C2g5g@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 10/14/2012 05:05 PM, Denis Ciocca wrote:
> Hi guys,
> 
> according to your requests I have modified my driver. Only one things
> about this function:

Hi,

you did not address all the issues addressed during the last review. Most
importantly the functions, structs, defines, etc. are still no namespaced.
Please add a st_acc_ prefix to your functions, etc. Add a st_acc_spi_
st_acc_i2c_ prefix to functions which are spi or i2c specific.

> 
> static int acc_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
> 
> You tell to me:
> 
>> In buffered mode the samples should not be postprocessed. Userspace expects the
>> samples in the format as described by the scan_type. The buffer demuxing should
>> be handled by the IIO core. If you set up available_scan_masks correctly it
>> will automatically do the right thing.
> 
> I agree with you for the postprocessed samples part, but I don't understand very
> well the second one.
> I saw the other drivers, if I check only the available_scan_masks variable
> I don't know which channels are actives and which not.
> I will read every time all data channels, but I choose which channel
> put in the buffer.
> 
> Thanks,
> Denis
> 
> 
> 
> 
> 
> From 0917bcc1e22462db0469709d1020b5378d91959c Mon Sep 17 00:00:00 2001
> From: userid <userid@MacBookAir.(none)>

This needs a proper from tag. See here
http://git-scm.com/book/en/Customizing-Git-Git-Configuration how to setup
your name and email for git.

> Date: Sun, 14 Oct 2012 00:05:54 +0200
> Subject: [PATCH] Add STMicroelectronics accelerometers driver to support I2C
>  and SPI devices.

The title should start with the subsystem tag, in this case "iio:accel:"
Also no fullstop at the end of the title, I'd also not include the "to
support I2C  and SPI devices" to keep the title short.

This also needs a short description of what the patch does.

E.g. "This patch adds generic accelerometer driver for STMicroelectronics
accelerometers, currently it supports ..."

Also it is helpful for reviews to include a small changelog of what was
changed in this revision of the driver.

> 
> ---
>  drivers/iio/accel/Kconfig                    |   32 +
>  drivers/iio/accel/Makefile                   |    6 +
>  drivers/iio/accel/ST_accel_buffer.c          |  122 +++
>  drivers/iio/accel/ST_accel_core.c            | 1335 ++++++++++++++++++++++++++
>  drivers/iio/accel/ST_accel_i2c.c             |  165 ++++
>  drivers/iio/accel/ST_accel_spi.c             |  236 +++++
>  drivers/iio/accel/ST_accel_trigger.c         |   87 ++
>  include/linux/iio/accel/ST_accel.h           |  120 +++
>  include/linux/platform_data/ST_accel_pdata.h |   34 +
>  9 files changed, 2137 insertions(+)
>  create mode 100644 drivers/iio/accel/ST_accel_buffer.c
>  create mode 100644 drivers/iio/accel/ST_accel_core.c
>  create mode 100644 drivers/iio/accel/ST_accel_i2c.c
>  create mode 100644 drivers/iio/accel/ST_accel_spi.c
>  create mode 100644 drivers/iio/accel/ST_accel_trigger.c
>  create mode 100644 include/linux/iio/accel/ST_accel.h
>  create mode 100644 include/linux/platform_data/ST_accel_pdata.h
> 

Make the file names all lowercase

> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index b2510c4..13cc44f 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -13,4 +13,36 @@ config HID_SENSOR_ACCEL_3D
>  	  Say yes here to build support for the HID SENSOR
>  	  accelerometers 3D.
> 
> +config ST_ACCEL_3AXIS
> +	tristate "STMicroelectronics accelerometers 3-Axis Driver"
> +	depends on (I2C || SPI)
> +	help
> +	  Say yes here to build support for STMicroelectronics accelerometers.
> +
> +choice
> +	prompt "Bus type"
> +	depends on ST_ACCEL_3AXIS

I don't think there is a reason to make SPI and I2C support exclusive of
each other. The driver should work just fine if both are built in.

> +
> +config ST_ACCEL_3AXIS_I2C
> +	bool "support I2C bus connection"
> +	depends on I2C && ST_ACCEL_3AXIS
> +	help
> +	  Say yes here to build I2C support for STMicroelectronics accelerometers.
> +
> +config ST_ACCEL_3AXIS_SPI
> +	bool "support SPI bus connection"
> +	depends on SPI && ST_ACCEL_3AXIS
> +	help
> +	Say yes here to build SPI support for STMicroelectronics accelerometers.
> +
> +endchoice
> +
> +config ST_ACCEL_3AXIS_TRIGGERED_BUFFER
> +	tristate "support triggered buffer"
> +	depends on ST_ACCEL_3AXIS
> +	select IIO_TRIGGERED_BUFFER
> +	select IIO_BUFFER
> +	help
> +	  Default trigger and buffer for STMicroelectronics accelerometers driver.
> +
>  endmenu
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index 5bc6855..b797db4 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -3,3 +3,9 @@
>  #
> 
>  obj-$(CONFIG_HID_SENSOR_ACCEL_3D) += hid-sensor-accel-3d.o
> +
> +ST_accel-y := ST_accel_core.o
> +obj-$(CONFIG_ST_ACCEL_3AXIS_I2C) += ST_accel_i2c.o
> +obj-$(CONFIG_ST_ACCEL_3AXIS_SPI) += ST_accel_spi.o
> +obj-$(CONFIG_ST_ACCEL_3AXIS_TRIGGERED_BUFFER) += ST_accel_trigger.o
> ST_accel_buffer.o
> +obj-$(CONFIG_ST_ACCEL_3AXIS) += ST_accel.o
> \ No newline at end of file
> diff --git a/drivers/iio/accel/ST_accel_buffer.c
> b/drivers/iio/accel/ST_accel_buffer.c
> new file mode 100644
> index 0000000..61ee836
> --- /dev/null
> +++ b/drivers/iio/accel/ST_accel_buffer.c
> @@ -0,0 +1,122 @@
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
> +#include <linux/iio/accel/ST_accel.h>
> +
> +
> +#define ST_ACCEL_NUMBER_DATA_CHANNELS		3
> +
> +static int acc_read_all(struct iio_dev *indio_dev, u8 *rx_array)
> +{
> +	int len;
> +	struct st_acc_data *adata = iio_priv(indio_dev);
> +
> +	len = adata->read_multiple_byte(adata,
> +		indio_dev->channels[ST_ACC_SCAN_X].address,
> +		ST_ACC_BYTE_FOR_CHANNEL*ST_ACCEL_NUMBER_DATA_CHANNELS,
> +		rx_array);
> +	if (len < 0)
> +		goto read_error;
> +
> +	return len;
> +
> +read_error:
> +	return -EIO;
> +}
> +
> +static int acc_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
> +{
> +	int ret, i, n = 0;
> +	u8 *rx_array;
> +	u8 mask = 0x01;
> +	s16 *data = (s16 *)buf;
> +	int scan_count = bitmap_weight(indio_dev->active_scan_mask,
> +				       indio_dev->masklength);
> +
> +	rx_array = kzalloc(ST_ACC_BYTE_FOR_CHANNEL*
> +				ST_ACCEL_NUMBER_DATA_CHANNELS, GFP_KERNEL);
> +	if (rx_array == NULL)
> +		return -ENOMEM;
> +	ret = acc_read_all(indio_dev, rx_array);
> +	if (ret < 0)
> +		return ret;
> +	for (i = 0; i < ST_ACCEL_NUMBER_DATA_CHANNELS; i++) {
> +		if ((*indio_dev->active_scan_mask & mask) > 0) {
> +			if (indio_dev->channels[i].scan_type.endianness ==
> +								IIO_LE) {
> +				data[n] = (s16)(cpu_to_le16(le16_to_cpu((
> +				(__le16 *)rx_array)[i])));
> +				n++;
> +			} else {
> +				data[n] = (s16)(cpu_to_be16(be16_to_cpu((
> +				(__be16 *)rx_array)[i])));
> +				n++;
> +			}

Don't do any endian conversion, userspace expects the data to be layed out
as described by the scan_type

> +		}
> +		mask = mask << 1;
> +	}
> +	kfree(rx_array);
> +	return i*sizeof(data[0]);
> +}
> +
> +static irqreturn_t acc_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	int len = 0;
> +	char *data;
> +
> +	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
> +	if (data == NULL)
> +		goto done;
> +	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
> +		len = acc_get_buffer_element(indio_dev, data);
> +	else
> +		goto done;
> +	if (indio_dev->scan_timestamp)
> +		*(s64 *)((u8 *)data + ALIGN(len, sizeof(s64))) = pf->timestamp;
> +	iio_push_to_buffer(indio_dev->buffer, data);
> +	kfree(data);
> +
> +done:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct iio_buffer_setup_ops acc_buf_setup_ops = {
> +	.preenable = &iio_sw_buffer_preenable,
> +	.postenable = &iio_triggered_buffer_postenable,
> +	.predisable = &iio_triggered_buffer_predisable,
> +};

This is just the default buffer_ops for triggered buffers. Just pass NULL as
the last parameter to iio_triggered_buffer_setup.

> +
> +int acc_allocate_ring(struct iio_dev *indio_dev)
> +{
> +	return iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
> +			&acc_trigger_handler, &acc_buf_setup_ops);
> +}
> +EXPORT_SYMBOL(acc_allocate_ring);
> +
> +void acc_deallocate_ring(struct iio_dev *indio_dev)
> +{
> +	iio_triggered_buffer_cleanup(indio_dev);
> +}
> +EXPORT_SYMBOL(acc_deallocate_ring);
> diff --git a/drivers/iio/accel/ST_accel_core.c
> b/drivers/iio/accel/ST_accel_core.c
> new file mode 100644
> index 0000000..5b30155
> --- /dev/null
> +++ b/drivers/iio/accel/ST_accel_core.c
> @@ -0,0 +1,1335 @@
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
> +#include <linux/iio/accel/ST_accel.h>
> +
> +
[...]
> +
> +struct odr_available {
> +	int hz;

unsigned int some of the other structs memebers could also be made unsigned

> +	u8 value;
> +};
> +
> [...]
> +
> +/**
> + * struct st_accel_sensors - ST accel sensors list
> + * @wai: Contents of WhoAmI register.
> + * @ch: IIO channels for the sensor.
> + * @odr: Output data rate register and odr list available.
> + * @pw: Power register of the sensor.
> + * @fs: Full scale register and fs list available.
> + * @bdu: Block data update register.
> + * @drdy_irq: Data ready register of the sensor.
> + * @ multi_read_bit: Use or not particular bit for [I2C/SPI] multiread.

extra space

> + */
> +
> +static const struct st_accel_sensors {
> +	u8 wai;
> +	struct iio_chan_spec *ch;
> +	struct odr odr;
> +	struct power pw;
> +	struct fullscale fs;
> +	struct bdu bdu;
> +	struct data_ready_irq drdy_irq;
> +	bool multi_read_bit;
> +} st_accel_sensors[] = {
> +	{

An extra level of indention would be good after this line

> +	.wai = S1_WAI_EXP,
> +	.ch = (struct iio_chan_spec *)default_channels,
[...]
> }
> +
> +static int acc_write_data_with_mask(struct iio_dev *indio_dev, u8 reg_addr,
> +						u8 mask, short num_bit, u8 data)
> +{
> +	int err, j, pos;
> +	u8 prev_data;
> +	u8 new_data;
> +	struct st_acc_data *adata = iio_priv(indio_dev);
> +
> +	pos = 7;
> +	for (j = 128; j >= 0; j = j/2) {
> +		if (mask/j > 0)

Missing space around the "/"

> +			break;
> +		else

I'd remove the else

> +			pos--;
> +	}
> +
> +	err = adata->read_byte(adata, reg_addr, &prev_data);
> +	if (err < 0)
> +		goto i2c_write_data_with_mask_error;
> +
> +	new_data = ((prev_data & (~mask)) | ((data << (pos-num_bit+1)) & mask));
> +	err = adata->write_byte(adata, reg_addr, new_data);
> +
> +i2c_write_data_with_mask_error:

Since this is not i2c specific I'd remove the "i2c" from the label name

> +	return err;
> +}
> +
> +static int match_odr(const struct st_accel_sensors *sensor, int odr,
> +						struct odr_available *odr_out)
> +{
> +	int n, i, ret = -1;
> +
> +	n = ARRAY_SIZE(sensor->odr.odr_avl);
> +	for (i = 0; i < n; i++)

I'd put the ARRAY_SIZE in the for header, also brackets around the for body.

> +		if (sensor->odr.odr_avl[i].hz == odr) {
> +			odr_out->hz = sensor->odr.odr_avl[i].hz;
> +			odr_out->value = sensor->odr.odr_avl[i].value;
> +			ret = 0;
> +			break;
> +		}
> +
> +	return ret;
> +}
> +
> +static int match_fs(const struct st_accel_sensors *sensor, int fs,
> +					struct fullscale_available *fs_out)
> +{
> +	int n, i, ret = -1;
> +
> +	n = ARRAY_SIZE(sensor->fs.fs_avl);
> +	for (i = 0; i < n; i++)

same here

> +		if (sensor->fs.fs_avl[i].num == fs) {
> +			fs_out->num = sensor->fs.fs_avl[i].num;
> +			fs_out->gain = sensor->fs.fs_avl[i].gain;
> +			fs_out->value = sensor->fs.fs_avl[i].value;
> +			ret = 0;
> +			break;
> +		}
> +
> +	return ret;
> +}
> +
> +int acc_set_dataready_irq(struct iio_dev *indio_dev, bool enable)
> +{
> +	int err;
> +	struct st_acc_data *adata;
> +
> +	adata = iio_priv(indio_dev);
> +	if (st_accel_sensors[adata->index].drdy_irq.ig1.en_addr > 0) {
> +		err = acc_write_data_with_mask(indio_dev,
> +			st_accel_sensors[adata->index].drdy_irq.ig1.en_addr,
> +			st_accel_sensors[adata->index].drdy_irq.ig1.en_mask, 1,
> +			(int)enable);
> +		if (err < 0)
> +			goto acc_set_dataready_irq_error;
> +	}
> +
> +	if (st_accel_sensors[adata->index].drdy_irq.ig1.latch_mask_addr > 0) {
> +		err = acc_write_data_with_mask(indio_dev,
> +		st_accel_sensors[adata->index].drdy_irq.ig1.latch_mask_addr,
> +		st_accel_sensors[adata->index].drdy_irq.ig1.latching_mask, 1,
> +			(int)enable);
> +		if (err < 0)
> +			goto acc_set_dataready_irq_error;
> +	}
> +
> +	err = acc_write_data_with_mask(indio_dev,
> +		st_accel_sensors[adata->index].drdy_irq.addr,
> +		st_accel_sensors[adata->index].drdy_irq.mask, 1, (int)enable);
> +	if (err < 0)
> +		goto acc_set_dataready_irq_error;
> +
> +	return 0;
> +
> +acc_set_dataready_irq_error:
> +	return -EIO;

just pass on the error code in err.

> +}
> +EXPORT_SYMBOL(acc_set_dataready_irq);
> +
> +static int set_bdu(struct iio_dev *indio_dev, const struct bdu *bdu, u8 value)
> +{
> +	int err;
> +
> +	err = acc_write_data_with_mask(indio_dev,
> +					bdu->addr,
> +					bdu->mask,
> +					1,
> +					value);

I think this would fit all in one line without hitting the 80 char limit

> +
> +	return err;
> +}
> +
> +static int set_odr(struct iio_dev *indio_dev,
> +					struct odr_available *odr_available)
> +{
> +	int err;
> +	struct st_acc_data *adata = iio_priv(indio_dev);
> +
> +	if ((st_accel_sensors[adata->index].odr.addr ==
> +		st_accel_sensors[adata->index].pw.addr) &&
> +			(st_accel_sensors[adata->index].odr.mask ==
> +				st_accel_sensors[adata->index].pw.mask)) {
> +		if (atomic_read(&adata->enabled) == ST_ACCEL_ON) {
> +			err = acc_write_data_with_mask(indio_dev,
> +				st_accel_sensors[adata->index].odr.addr,
> +				st_accel_sensors[adata->index].odr.mask,
> +				st_accel_sensors[adata->index].odr.num_bit,
> +				odr_available->value);
> +			if (err < 0)
> +				goto set_odr_error;
> +		} else {
> +			adata->odr = odr_available->hz;
> +			err = 0;
> +		}
> +	} else {
> +		err = acc_write_data_with_mask(indio_dev,
> +				st_accel_sensors[adata->index].odr.addr,
> +				st_accel_sensors[adata->index].odr.mask,
> +				st_accel_sensors[adata->index].odr.num_bit,
> +				odr_available->value);
> +		if (err < 0)
> +			goto set_odr_error;
> +	}
> +
> +set_odr_error:
> +	return err;
> +}
> +
> +static int set_enable(struct iio_dev *indio_dev, int enable)
> +{
> +	int found, err;
> +	u8 tmp_value;
> +	struct odr_available *odr_out;
> +	struct st_acc_data *adata = iio_priv(indio_dev);
> +
> +	odr_out = kzalloc(sizeof(*odr_out), GFP_KERNEL);
> +	if (odr_out == NULL) {
> +		err = -ENOMEM;
> +		goto odr_out_allocate_memory_error;
> +	}

Allocate odr_out on the stack

> +
> +	switch (enable) {
> +	case ST_ACCEL_ON:
> +		found = 0;
> +		tmp_value = st_accel_sensors[adata->index].pw.value_on;
> +		if ((st_accel_sensors[adata->index].odr.addr ==
> +				st_accel_sensors[adata->index].pw.addr) &&
> +			(st_accel_sensors[adata->index].odr.mask ==
> +				st_accel_sensors[adata->index].pw.mask)) {
> +			err = match_odr(&st_accel_sensors[adata->index],
> +							adata->odr, odr_out);
> +			if (err < 0)
> +				goto set_enable_error;
> +			tmp_value = odr_out->value;
> +			found = 1;
> +		}
> +		err = acc_write_data_with_mask(indio_dev,
> +				st_accel_sensors[adata->index].pw.addr,
> +				st_accel_sensors[adata->index].pw.mask,
> +				st_accel_sensors[adata->index].pw.num_bit,
> +				tmp_value);
> +		if (err < 0)
> +			goto set_enable_error;
> +		atomic_set(&adata->enabled, ST_ACCEL_ON);
> +		if (found == 1)
> +			adata->odr = odr_out->hz;
> +		break;
> +	case ST_ACCEL_OFF:
> +		err = acc_write_data_with_mask(indio_dev,
> +				st_accel_sensors[adata->index].pw.addr,
> +				st_accel_sensors[adata->index].pw.mask,
> +				st_accel_sensors[adata->index].pw.num_bit,
> +				st_accel_sensors[adata->index].pw.value_off);
> +		if (err < 0)
> +			goto set_enable_error;
> +		atomic_set(&adata->enabled, ST_ACCEL_OFF);
> +		break;
> +	default:
> +		err = -1;

Use a proper error value e.g. -EINVAL

> +		goto set_enable_error;
> +	}
> +
> +set_enable_error:
> +	kfree(odr_out);
> +odr_out_allocate_memory_error:
> +	return err;
> +}
> +
> [...]
> +
> +static int acc_read_raw(struct iio_dev *indio_dev,
> +			struct iio_chan_spec const *ch, int *val,
> +							int *val2, long mask)
> +{
> +	int err;
> +	int data_tmp;
> +	u8 outdata[ST_ACC_BYTE_FOR_CHANNEL];
> +	struct st_acc_data *adata = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
> +			err = -EBUSY;
> +			goto read_error;
> +		} else {
> +			err = atomic_read(&adata->enabled);
> +			if (!err) {
> +				err = -EHOSTDOWN;

EHOSTDOWN is not a appropricate error in this case. This is not a socket!

> +				goto read_error;
> +			} else {
> +				err = adata->read_multiple_byte(adata,
> +					ch->address, ST_ACC_BYTE_FOR_CHANNEL,
> +					outdata);
> +				if (err < 0)
> +					goto read_error;
> +
> +				if (ch->scan_type.endianness == IIO_LE)
> +					*val = (s32)(s16)(cpu_to_le16(
> +					le16_to_cpu(((__le16 *)outdata)[0])))
> +					>> ch->scan_type.shift;
> +				else
> +					*val = (s32)(s16)(cpu_to_le16(
> +					be16_to_cpu(((__be16 *)outdata)[0])))
> +					>> ch->scan_type.shift;

All these casts look kind of crazy.

> +			}
> +		}
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		data_tmp = UG_TO_MS2(adata->gain);
> +		*val = 0;
> +		*val2 = data_tmp;
> +		return IIO_VAL_INT_PLUS_NANO;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +read_error:
> +	return err;
> +}
> +
> +static int acc_check_irq(struct iio_dev *indio_dev)
> +{
> +	int err;
> +	struct st_acc_data *adata = iio_priv(indio_dev);
> +
> +	if (*adata->irq_data_ready <= 0)
> +		err = -EINVAL;
> +	else
> +		err = 0;
> +

There is onlu one caller of this function, just inline the code int that
function

> +	return err;
> +}
> +
> +static void register_channels(struct iio_dev *indio_dev)
> +{
> +	struct st_acc_data *adata = iio_priv(indio_dev);
> +
> +	indio_dev->channels = st_accel_sensors[adata->index].ch;
> +	indio_dev->num_channels = ST_ACC_NUMBER_ALL_CHANNELS;

Same here

> +}
> +
> +static void set_sensor_parameters(struct iio_dev *indio_dev)
> +{
> +	struct st_acc_data *adata = iio_priv(indio_dev);
> +
> +	adata->multiread_bit = st_accel_sensors[adata->index].multi_read_bit;

Same here

> +}
> +
> +static int check_device_list(struct iio_dev *indio_dev, u8 wai)
> +{
> +	int i, sensor_length, found;
> +	struct st_acc_data *adata = iio_priv(indio_dev);
> +
> +	found = 0;
> +	sensor_length = ARRAY_SIZE(st_accel_sensors);
> +	for (i = 0; i < sensor_length; i++) {

I'd just put the ARRAY_SIZE(...) in the for header and get rid of the extra
variable.

> +		if (st_accel_sensors[i].wai == wai) {
> +			found = 1;
> +			break;
> +		}
> +	}
> +	if (found != 1)
> +		goto check_device_error;
> +	adata->index = i;
> +	return i;
> +
> +check_device_error:
> +	pr_err("%s: device not supported -> wai (0x%x).\n", adata->name, wai);

dev_err. As a rule of thumb don't use the pr_ functions in device drivers.

> +	return -ENODEV;
> +}
> +
> +static int get_wai_device(struct iio_dev *indio_dev, u8 reg_addr, u8 *value)
> +{
> +	int ret;
> +	u8 buf;
> +	struct st_acc_data *adata;
> +
> +	adata = iio_priv(indio_dev);
> +	buf = reg_addr;
> +	ret = adata->read_byte(adata, reg_addr, value);
> +	if (ret < 0)
> +		goto read_byte_wai_error;
> +
> +	return 0;
> +
> +read_byte_wai_error:
> +	pr_err("%s: failed to read wai register (0x%x).\n",
> +							adata->name, reg_addr);

dev_err, there are a few more pr_errs throughout the driver, those should be
fixed up as well. Useing dev_err will also allow you to remove the name
field from the st_acc_data struct

> +	return -EIO;
> +}
> +
> +static ssize_t sysfs_set_sampling_frequency(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t size)
> +{
> +	int err;
> +	unsigned long freq;
> +	struct odr_available *odr_out;
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct st_acc_data *adata = iio_priv(indio_dev);
> +
> +	err = kstrtoul(buf, 10, &freq);

use kstrtoint instead of casting freq to int later on

> +	if (err) {
> +		pr_err("%s: input is not a number! (errn %d).\n",
> +							adata->name, err);

This message is just noise

> +		goto sysfs_set_sampling_frequency_error;
> +	}
> +
> +	mutex_lock(&indio_dev->mlock);
> +	odr_out = kzalloc(sizeof(*odr_out), GFP_KERNEL);

Allocate odr_out on the stack

> +	if (odr_out == NULL)
> +		goto odr_out_allocate_memory_error;
> +
> +	err = match_odr(&st_accel_sensors[adata->index], (int)freq, odr_out);
> +	if (err < 0)
> +		goto sysfs_set_sampling_frequency_error;
> +	err = set_odr(indio_dev, odr_out);
> +	if (err < 0) {
> +		pr_err("%s: failed to set sampling frequency to %d.\n",
> +							adata->name, (int)freq);
> +		goto sysfs_set_sampling_frequency_error;
> +	}
> +	adata->odr = odr_out->hz;
> +	kfree(odr_out);
> +
> +odr_out_allocate_memory_error:
> +	mutex_unlock(&indio_dev->mlock);
> +sysfs_set_sampling_frequency_error:
> +	return size;
> +}
> +
> +static ssize_t sysfs_get_sampling_frequency(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	ssize_t ret;
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct st_acc_data *adata = iio_priv(indio_dev);
> +
> +	ret = sprintf(buf, "%d\n", adata->odr);
> +
> +	return ret;

I'd just do return sprintf(...)

> +}
> +
> +static ssize_t sysfs_set_enable(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t size)
> +{
> +	int err;
> +	unsigned long en;
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct st_acc_data *adata = iio_priv(indio_dev);
> +



> +	err = kstrtoul(buf, 10, &en);
> +	if (err) {
> +		pr_err("%s: input is not a number! (errn %d).\n",
> +							adata->name, err);
> +		goto set_enable_error;
> +	}

strtobool

> +
> +	mutex_lock(&indio_dev->mlock);
> +	err = set_enable(indio_dev, (int)en);
> +	if (err < 0)
> +		pr_err("%s: failed to set enable to %d.\n",
> +							adata->name, (int)en);
> +	mutex_unlock(&indio_dev->mlock);
> +
> +set_enable_error:
> +	return size;
> +}
> +
> +static ssize_t sysfs_get_enable(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	ssize_t ret;
> +	int status;
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct st_acc_data *adata = iio_priv(indio_dev);
> +
> +	status = atomic_read(&adata->enabled);
> +	ret = sprintf(buf, "%d\n", status);

I'd just do return sprintf(...)

> +
> +	return ret;
> +}
> +
> +static ssize_t sysfs_get_fullscale(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	ssize_t ret;
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct st_acc_data *adata = iio_priv(indio_dev);
> +
> +	ret = sprintf(buf, "%d\n", adata->fullscale);

same here

> +
> +	return ret;
> +}
> +
> +static ssize_t sysfs_set_fullscale(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t size)
> +{
> +	int err;
> +	unsigned long fs;
> +	struct fullscale_available *fs_out;
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct st_acc_data *adata = iio_priv(indio_dev);
> +
> +	err = kstrtoul(buf, 10, &fs);
> +	if (err) {
> +		pr_err("%s: input is not a number! (errn %d).\n",
> +							adata->name, err);

This is just noise, the caller will be notified by the error code that it's
input was invalid.

> +		goto set_fullscale_error;
> +	}
> +
> +	mutex_lock(&indio_dev->mlock);
> +	fs_out = kzalloc(sizeof(*fs_out), GFP_KERNEL);

Allocate fs_out on the stack

> +	if (fs_out == NULL)
> +		goto fs_out_allocate_memory_error;
> +
> +	err = match_fs(&st_accel_sensors[adata->index], fs, fs_out);
> +	if (err < 0) {
> +		pr_err("%s: input is not a valid fullscale! (errn %d).\n",
> +							adata->name, err);

This too

> +		goto match_fullscale_error;
> +	}
> +	err = set_fullscale(indio_dev, fs_out);
> +	if (err < 0) {
> +		pr_err("%s: failed to set new fullscale. (errn %d).\n",
> +							adata->name, err);
> +	}
> +
> +match_fullscale_error:
> +	kfree(fs_out);
> +fs_out_allocate_memory_error:
> +	mutex_unlock(&indio_dev->mlock);
> +set_fullscale_error:
> +	return size;
> +}
> +
> +static ssize_t sysfs_fullscale_available(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	int i, n, len;
> +	char tmp[4];
> +	char fullscale[30] = "";
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct st_acc_data *adata = iio_priv(indio_dev);
> +
> +	mutex_lock(&indio_dev->mlock);
> +	n = ARRAY_SIZE(st_accel_sensors[adata->index].fs.fs_avl);
> +	for (i = 0; i < n; i++) {
> +		if (st_accel_sensors[adata->index].fs.fs_avl[i].num != 0) {
> +			len = strlen(&fullscale[0]);
> +			sprintf(tmp, "%d ",
> +			st_accel_sensors[adata->index].fs.fs_avl[i].num);
> +			strcpy(&fullscale[len], tmp);
> +		} else
> +			break;
> +	}
> +	mutex_unlock(&indio_dev->mlock);
> +
> +	return sprintf(buf, "%s\n", fullscale);

This function does still the crazy sprintf, strcpy, sprintf combo

In general the same comments as to sysfs_sampling_frequency_available apply
here.

> +}
> +
> +static ssize_t sysfs_sampling_frequency_available(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	int i, n, len;
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct st_acc_data *adata = iio_priv(indio_dev);
> +
> +	mutex_lock(&indio_dev->mlock);
> +	n = ARRAY_SIZE(st_accel_sensors[adata->index].odr.odr_avl);
> +	for (i = 0; i < n; i++) {
> +		if (st_accel_sensors[adata->index].odr.odr_avl[i].hz != 0) {

I'd rewrite this as

		if (st_accel_sensors[adata->index].odr.odr_avl[i].hz == 0)
			break;
		...


> +			len = strlen(buf);
> +			sprintf(buf+len, "%d ",
> +			st_accel_sensors[adata->index].odr.odr_avl[i].hz);

sprintf returns the number of characters written, so you don't need to run
strlen each loop interation. Also use scnprint with a limit of PAGE_SIZE
this avoids the (theoretical) buffer overflow. Your code could look
something like this:

len += scnprintf(buf+len, PAGE_SIZE, ...)

> +		} else
> +			break;
> +	}
> +	mutex_unlock(&indio_dev->mlock);
> +
> +	len = strlen(buf);
> +	return sprintf(buf+len, "\n");

This will return 1 instead of the actuall string length. I'd rewrite this as

	buf[len] = "\n"
	return len;

This will replace the last space in the string with a newline, so you won't
end up with a trailing space.


> +}
> +
> +static IIO_DEVICE_ATTR(sampling_frequency_available, S_IRUGO,
> +				sysfs_sampling_frequency_available, NULL , 0);
> +static IIO_DEVICE_ATTR(fullscale_available, S_IRUGO,
> +				sysfs_fullscale_available, NULL , 0);
> +static IIO_DEVICE_ATTR(fullscale, S_IWUSR | S_IRUGO, sysfs_get_fullscale,
> +				sysfs_set_fullscale , 0);
> +static IIO_DEVICE_ATTR(enable, S_IWUSR | S_IRUGO, sysfs_get_enable,
> +						sysfs_set_enable , 0);
> +static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO, sysfs_get_sampling_frequency,
> +				sysfs_set_sampling_frequency);
> +
> +static struct attribute *acc_attributes[] = {
> +	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> +	&iio_dev_attr_fullscale_available.dev_attr.attr,
> +	&iio_dev_attr_fullscale.dev_attr.attr,
> +	&iio_dev_attr_enable.dev_attr.attr,
> +	&iio_dev_attr_sampling_frequency.dev_attr.attr,
> +	NULL,
> +};

Non standard attributes need to be documented.

> +
> +static int init_sensor(struct iio_dev *indio_dev)
> +{
> +	int err;
> +	struct odr_available *odr_out;
> +	struct fullscale_available *fs_out;
> +	struct st_acc_data *adata = iio_priv(indio_dev);
> +
> +	odr_out = kzalloc(sizeof(*odr_out), GFP_KERNEL);
> +	if (odr_out == NULL)
> +		goto odr_out_allocate_memory_error;
> +	fs_out = kzalloc(sizeof(*fs_out), GFP_KERNEL);
> +	if (fs_out == NULL)
> +		goto fs_out_allocate_memory_error;
> +	set_enable(indio_dev, ST_ACCEL_OFF);
> +	match_fs(&st_accel_sensors[adata->index], adata->fullscale, fs_out);
> +	err = set_fullscale(indio_dev, fs_out);
> +	if (err < 0)
> +		goto init_error;
> +	match_odr(&st_accel_sensors[adata->index], adata->odr, odr_out);
> +	err = set_odr(indio_dev, odr_out);
> +	if (err < 0)
> +		goto init_error;
> +	err = set_bdu(indio_dev,
> +			&st_accel_sensors[adata->index].bdu, (u8)ST_ACCEL_ON);
> +	if (err < 0)
> +		goto init_error;
> +	kfree(odr_out);
> +	kfree(fs_out);

Allocate both odr_out and fs_out on the stack.

Also this function could use a few newlines.

> +
> +	return 0;
> +
> +init_error:
> +	kfree(fs_out);
> +fs_out_allocate_memory_error:
> +	kfree(odr_out);
> +odr_out_allocate_memory_error:
> +	return -EIO;
> +}
> +
> +int acc_iio_probe(struct iio_dev *indio_dev)
> +{
> +	int err;
> +	u8 wai;
> +	struct st_acc_data *adata = iio_priv(indio_dev);
> +
> +	mutex_init(&adata->slock);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &acc_info;
> +
> +	err = get_wai_device(indio_dev, ST_DEFAULT_WAI_ADDRESS, &wai);
> +	if (err < 0)
> +		goto get_wai_error;

Missing newline

> +	err = check_device_list(indio_dev, wai);
> +	if (err < 0)
> +		goto check_device_list_error;

Missing newline

> +	set_sensor_parameters(indio_dev);
> +	register_channels(indio_dev);

Missing newline

> +	err = init_sensor(indio_dev);
> +	if (err < 0)
> +		goto init_sensor_error;
> +
> +	err = acc_check_irq(indio_dev);
> +	if (err < 0)
> +		goto gpio_check_error;

Missing newline

> +	err = acc_allocate_ring(indio_dev);
> +	if (err < 0)
> +		goto acc_allocate_ring_error;
> +
> +	err = acc_probe_trigger(indio_dev);
> +	if (err < 0)
> +		goto acc_probe_trigger_error;
> +
> +	err = iio_device_register(indio_dev);
> +	if (err)
> +		goto iio_device_register_error;
> +
> +	pr_info("%s: probe end correctly.\n", adata->name);

This is just noise. Imagine every driver doing this you'd end up with quite
a few lines of "Drivers has probed correctly" in your bootlog.

> +
> +	return err;
> +
> +iio_device_register_error:
> +	acc_remove_trigger(indio_dev);
> +acc_probe_trigger_error:
> +	acc_deallocate_ring(indio_dev);
> +acc_allocate_ring_error:
> +gpio_check_error:
> +init_sensor_error:
> +check_device_list_error:
> +get_wai_error:

No need for all these labels

> +	return err;
> +}
> +EXPORT_SYMBOL(acc_iio_probe);
> +
> +void acc_iio_remove(struct iio_dev *indio_dev)
> +{
> +	acc_remove_trigger(indio_dev);
> +	acc_deallocate_ring(indio_dev);
> +	iio_device_unregister(indio_dev);
> +	iio_device_free(indio_dev);

Rule of thumb: First iio_device_unregister then everything else and
iio_device_free last

> +}
> +EXPORT_SYMBOL(acc_iio_remove);
> +
> +MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
> +MODULE_DESCRIPTION("STMicroelectronics accelerometers driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/accel/ST_accel_i2c.c b/drivers/iio/accel/ST_accel_i2c.c
> new file mode 100644
> index 0000000..55bca3a
> --- /dev/null
> +++ b/drivers/iio/accel/ST_accel_i2c.c
> @@ -0,0 +1,165 @@
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
> +#include <linux/iio/accel/ST_accel.h>
> +#include <linux/platform_data/ST_accel_pdata.h>
> +
> +
> +#define ST_ACCEL_I2C_MULTIREAD			0x80
> +
> +static inline s32 acc_i2c_read_byte(struct st_acc_data *adata, u8 reg_addr,
> +								u8 *res_byte)


This function obviously can not be inlined since it is used as a callback
and use int for the return type

> +{
> +	s32 err;
> +
> +	err = i2c_smbus_read_byte_data(to_i2c_client(adata->dev), reg_addr);
> +	if (err < 0)
> +		goto acc_i2c_read_byte_error;
> +	*res_byte = err & 0xff;
> +	return err;
> +
> +acc_i2c_read_byte_error:
> +	return -EIO;
> +}
> +
> +static inline s32 acc_i2c_read_multiple_byte(struct st_acc_data *adata,
> +						u8 reg_addr, int len, u8 *data)

same here

> +{
> +	s32 err;
> +
> +	if (adata->multiread_bit == true)
> +		reg_addr |= ST_ACCEL_I2C_MULTIREAD;
> +
> +	err = i2c_smbus_read_i2c_block_data(to_i2c_client(adata->dev),
> +							reg_addr, len, data);
> +	if (err < 0)
> +		goto acc_i2c_read_multiple_byte_error;
> +
> +	return err;
> +
> +acc_i2c_read_multiple_byte_error:
> +	return -EIO;
> +}
> +
> +static inline s32 acc_i2c_write_byte(struct st_acc_data *adata,
> +							u8 reg_addr, u8 data)

same here

> +{
> +	return i2c_smbus_write_byte_data(to_i2c_client(adata->dev),
> +								reg_addr, data);
> +}
> +
[...]
> +MODULE_DESCRIPTION("STMicroelectronics accelerometers i2c driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/accel/ST_accel_spi.c b/drivers/iio/accel/ST_accel_spi.c
> new file mode 100644
> index 0000000..c918715
> --- /dev/null
> +++ b/drivers/iio/accel/ST_accel_spi.c
> @@ -0,0 +1,236 @@
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
> +#include <linux/iio/accel/ST_accel.h>
> +#include <linux/platform_data/ST_accel_pdata.h>
> +
> +
> +#define ACC_SPI_READ		0x80;
> +#define ACC_SPI_MULTIREAD	0xc0
> +
> +static inline s32 acc_spi_read_byte(struct st_acc_data *adata, u8 reg_addr,
> +								u8 *res_byte)

This function obviously can not be inlined since it is used as a callback
and use int for the return type

> +{
> +	struct spi_message msg;
> +	int err;
> +	u8 tx;
> +
> +	struct spi_transfer xfers[] = {
> +		{
> +			.tx_buf = &tx,
> +			.bits_per_word = 8,
> +			.len = 1,
> +			.cs_change = 0,
> +			.delay_usecs = 10,
> +		},
> +		{
> +			.rx_buf = res_byte,
> +			.bits_per_word = 8,
> +			.len = 1,
> +			.cs_change = 0,
> +			.delay_usecs = 10,
> +		}
> +	};
> +
> +	mutex_lock(&adata->slock);
> +	tx = reg_addr | ACC_SPI_READ;
> +	spi_message_init(&msg);
> +	spi_message_add_tail(&xfers[0], &msg);
> +	spi_message_add_tail(&xfers[1], &msg);
> +	err = spi_sync(to_spi_device(adata->dev), &msg);
> +	mutex_unlock(&adata->slock);
> +	if (err)
> +		goto acc_spi_read_byte_error;
> +
> +

Rule of thumb: You should never have multiple consecutive newlines

> +	return err;
> +
> +acc_spi_read_byte_error:
> +	return -EIO;
> +}
> +
> +static inline s32 acc_spi_read_multiple_byte(struct st_acc_data *adata,
> +						u8 reg_addr, int len, u8 *data)

same here

> +{
> +	struct spi_message msg;
> +	int err;
> +	u8 tx;
> +
> +	struct spi_transfer xfers[] = {
> +		{
> +			.tx_buf = &tx,
> +			.bits_per_word = 8,
> +			.len = 1,
> +			.cs_change = 0,
> +			.delay_usecs = 10,
> +		},
> +		{
> +			.rx_buf = data,
> +			.bits_per_word = 8,
> +			.len = len,
> +			.cs_change = 0,
> +			.delay_usecs = 10,
> +		}
> +	};
> +
> +	mutex_lock(&adata->slock);
> +	if (adata->multiread_bit == true)
> +		tx = reg_addr | ACC_SPI_MULTIREAD;
> +	else
> +		tx = reg_addr | ACC_SPI_READ;
> +
> +	spi_message_init(&msg);
> +	spi_message_add_tail(&xfers[0], &msg);
> +	spi_message_add_tail(&xfers[1], &msg);
> +	err = spi_sync(to_spi_device(adata->dev), &msg);
> +	mutex_unlock(&adata->slock);
> +	if (err)
> +		goto acc_spi_read_multiple_byte_error;
> +	return len;
> +
> +acc_spi_read_multiple_byte_error:
> +	return -EIO;
> +}
> +
> +static inline s32 acc_spi_write_byte(struct st_acc_data *adata,
> +							u8 reg_addr, u8 data)

same here

> +{
> +	struct spi_message msg;
> +	int err;
> +	u8 tx[2];
> +
> +	struct spi_transfer xfers[] = {
> +		{
> +			.tx_buf = tx,
> +			.bits_per_word = 8,
> +			.len = 2,
> +			.cs_change = 0,

Usually if cs_change is 0 it is not explicitly initalized.

> +			.delay_usecs = 10,
> +		}
> +	};
> +
> +	mutex_lock(&adata->slock);
> +	tx[0] = reg_addr;
> +	tx[1] = data;
> +	spi_message_init(&msg);
> +	spi_message_add_tail(&xfers[0], &msg);
> +	err = spi_sync(to_spi_device(adata->dev), &msg);
> +	mutex_unlock(&adata->slock);
> +
> +	return err;
> +}
> +
> +void set_platform_data(struct spi_device *client, struct st_acc_data *adata)
> +{
> +	if (client->dev.platform_data == NULL) {
> +		adata->fullscale = st_acc_default_pdata.fullscale;
> +		adata->odr = st_acc_default_pdata.sampling_frequency;
> +	} else {
> +		adata->fullscale = ((struct st_acc_platform_data *)
> +			(client->dev.platform_data))->fullscale;
> +		adata->odr = ((struct st_acc_platform_data *)
> +			(client->dev.platform_data))->sampling_frequency;
> +	}
> +}

I'd move this to the generic part of the driver, it's the same for both SPI
and I2C. Also instead of the casting create a helper variale and use that.

struct st_acc_platform_data *pdata = adata->dev->platform_data;
adata->fullscale = pdata->fullscale;
...

> +
> +void set_trigger_parent(struct iio_dev *indio_dev)
> +{
> +	struct spi_device *client;
> +	struct st_acc_data *adata = iio_priv(indio_dev);
> +
> +	client = to_spi_device(adata->dev);
> +	adata->trig->dev.parent = &client->dev;
> +}

This should not be necessary. You convert your device to a SPI device and
then read the device again from the spi device. So in the end adata->dev and
&client->dev are the same. There is no need for this callback, just do
adata->trig->dev.parent = ata->dev; in the generic code.

> +
> +static int __devinit acc_spi_probe(struct spi_device *client)
> +{
> +	struct iio_dev *indio_dev;
> +	struct st_acc_data *adata;
> +	int err;
> +
> +	indio_dev = iio_device_alloc(sizeof(*adata));
> +	if (indio_dev == NULL) {
> +		err = -ENOMEM;
> +		goto iio_device_alloc_error;
> +	}
> +
> +	adata = iio_priv(indio_dev);
> +	adata->dev = &client->dev;
> +	spi_set_drvdata(client, indio_dev);
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->name = client->modalias;
> +
> +	adata->read_byte = acc_spi_read_byte;
> +	adata->write_byte = acc_spi_write_byte;
> +	adata->read_multiple_byte = acc_spi_read_multiple_byte;
> +	adata->set_trigger_parent = set_trigger_parent;
> +	adata->name = client->modalias;
> +	adata->irq_data_ready = &client->irq;
> +
> +	set_platform_data(client, adata);
> +	err = acc_iio_probe(indio_dev);
> +	if (err < 0)
> +		goto acc_iio_default_error;
> +
> +	return 0;
> +
> +acc_iio_default_error:
> +	iio_device_free(indio_dev);
> +iio_device_alloc_error:
> +	return err;
> +}
> +
> +static int __devexit acc_spi_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +
> +	acc_iio_remove(indio_dev);
> +	return 0;
> +}
> +
> +static const struct spi_device_id acc_id_table[] = {
> +	{ LSM303DLH_ACC_IIO_DEV_NAME, 0 },
> +	{ LSM303DLHC_ACC_IIO_DEV_NAME, 0 },
> +	{ LIS3DH_ACC_IIO_DEV_NAME, 0 },
> +	{ LSM330D_ACC_IIO_DEV_NAME, 0 },
> +	{ LSM330DL_ACC_IIO_DEV_NAME, 0 },
> +	{ LSM330DLC_ACC_IIO_DEV_NAME, 0 },
> +	{ LSM303D_ACC_IIO_DEV_NAME, 0 },
> +	{ LSM9DS0_ACC_IIO_DEV_NAME, 0 },
> +	{ LIS331DLH_ACC_IIO_DEV_NAME, 0 },
> +	{ LSM303DL_ACC_IIO_DEV_NAME, 0 },
> +	{ LSM303DLM_ACC_IIO_DEV_NAME, 0 },
> +	{ LSM330_ACC_IIO_DEV_NAME, 0 },
> +	{},

Since the second field won't be used in the driver you can just leave the it
blank,
e.g. { LSM330_ACC_IIO_DEV_NAME },

> +};
> +MODULE_DEVICE_TABLE(spi, acc_id_table);
> +
> +static struct spi_driver acc_driver = {
> +	.driver = {
> +		.owner = THIS_MODULE,
> +		.name = "ST-accel-spi",
> +	},
> +	.probe = acc_spi_probe,
> +	.remove = __devexit_p(acc_spi_remove),
> +	.id_table = acc_id_table,
> +};
> +module_spi_driver(acc_driver);
> +
> +MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
> +MODULE_DESCRIPTION("STMicroelectronics accelerometers spi driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/accel/ST_accel_trigger.c
> b/drivers/iio/accel/ST_accel_trigger.c
> new file mode 100644
> index 0000000..4375c31
> --- /dev/null
> +++ b/drivers/iio/accel/ST_accel_trigger.c
> @@ -0,0 +1,87 @@
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
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +
> +#include <linux/iio/accel/ST_accel.h>
> +
> +
> +static int iio_trig_acc_set_state(struct iio_trigger *trig, bool state)
> +{
> +	struct iio_dev *indio_dev = trig->private_data;
> +	return acc_set_dataready_irq(indio_dev, state);
> +}
> +
> +static const struct iio_trigger_ops iio_acc_trigger_ops = {
> +	.owner = THIS_MODULE,
> +	.set_trigger_state = &iio_trig_acc_set_state,
> +};
> +
> +int acc_probe_trigger(struct iio_dev *indio_dev)
> +{
> +	int err;
> +	struct st_acc_data *adata = iio_priv(indio_dev);
> +
> +	adata->trig = iio_trigger_alloc("%s-trigger", indio_dev->name);
> +	if (adata->trig == NULL) {
> +		err = -ENOMEM;
> +		pr_err("%s: failed to allocate iio trigger.\n", adata->name);
> +		goto iio_trigger_alloc_error;
> +	}
> +
> +	err = request_threaded_irq(*adata->irq_data_ready,
> +			iio_trigger_generic_data_rdy_poll,
> +			NULL,
> +			IRQF_TRIGGER_RISING,
> +			adata->trig->name,
> +			adata->trig);
> +	if (err) {
> +		pr_err("%s: failed to request threaded irq [%d].\n",
> +					adata->name, *adata->irq_data_ready);
> +		goto request_irq_error;
> +	}
> +	adata->trig->private_data = indio_dev;
> +	adata->trig->ops = &iio_acc_trigger_ops;
> +
> +	adata->set_trigger_parent(indio_dev);
> +
> +	err = iio_trigger_register(adata->trig);
> +	if (err < 0) {
> +		pr_err("%s: failed to register iio trigger.\n", adata->name);
> +		goto iio_trigger_register_error;
> +	}
> +	indio_dev->trig = adata->trig;
> +	pr_info("%s: using [%s] trigger.\n", adata->name, adata->trig->name);
> +	return 0;
> +
> +iio_trigger_register_error:
> +	free_irq(*adata->irq_data_ready, adata->trig);
> +request_irq_error:
> +	iio_trigger_free(adata->trig);
> +iio_trigger_alloc_error:
> +	return err;
> +}
> +EXPORT_SYMBOL(acc_probe_trigger);
> +
> +void acc_remove_trigger(struct iio_dev *indio_dev)
> +{
> +	struct st_acc_data *adata = iio_priv(indio_dev);
> +
> +	iio_trigger_unregister(adata->trig);
> +	free_irq(*adata->irq_data_ready, adata->trig);
> +	iio_trigger_free(adata->trig);
> +}
> +EXPORT_SYMBOL(acc_remove_trigger);
> diff --git a/include/linux/iio/accel/ST_accel.h
> b/include/linux/iio/accel/ST_accel.h
> new file mode 100644
> index 0000000..20d1973
> --- /dev/null
> +++ b/include/linux/iio/accel/ST_accel.h
> @@ -0,0 +1,120 @@
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
> + */
> +
> +
> +#ifndef ST_ACCELEROMETERS_IIO_ACC_H
> +#define ST_ACCELEROMETERS_IIO_ACC_H
> +
> +#define LSM303DLH_ACC_IIO_DEV_NAME	"lsm303dlh_acc_iio"
> +#define LSM303DLHC_ACC_IIO_DEV_NAME	"lsm303dlhc_acc_iio"
> +#define LIS3DH_ACC_IIO_DEV_NAME		"lis3dh_acc_iio"
> +#define LSM330D_ACC_IIO_DEV_NAME	"lsm330d_acc_iio"
> +#define LSM330DL_ACC_IIO_DEV_NAME	"lsm330dl_acc_iio"
> +#define LSM330DLC_ACC_IIO_DEV_NAME	"lsm330dlc_acc_iio"
> +#define LSM303D_ACC_IIO_DEV_NAME	"lsm303d_iio"
> +#define LSM9DS0_ACC_IIO_DEV_NAME	"lsm9ds0_iio"
> +#define LIS331DLH_ACC_IIO_DEV_NAME	"lis331dlh_acc_iio"
> +#define LSM303DL_ACC_IIO_DEV_NAME	"lsm303dl_acc_iio"
> +#define LSM303DLM_ACC_IIO_DEV_NAME	"lsm303dlm_acc_iio"
> +#define LSM330_ACC_IIO_DEV_NAME		"lsm330_acc_iio"

The acc_iio prefixes on the driver names should not be necessary

> +
> +#define ST_ACC_NUMBER_ALL_CHANNELS	4
> +#define ST_ACC_BYTE_FOR_CHANNEL		2
> +#define ST_ACC_SCAN_X			0
> +#define ST_ACC_SCAN_Y			1
> +#define ST_ACC_SCAN_Z			2
> +
> +/**
> + * struct st_acc_data - ST accel device status
> + * @dev: Pointer to instance of struct device (I2C or SPI).
> + * @name: Name of the sensor in use.
> + * @enabled: Status of the sensor (0->off, 1->on).
> + * @index: Number used to point the sensor being used in the
> + *	st_accel_sensors struct.
> + * @fullscale: Maximum range of measure by the sensor.
> + * @gain: Sensitivity of the sensor [ug/LSB].
> + * @odr: Output data rate of the sensor.
> + * @multiread_bit: Use or not particular bit for [I2C/SPI] multiread.
> + * @read_byte: Function used to read one byte.
> + * @write_byte: Function used to write one byte.
> + * @read_multiple_byte: Function used to read multiple byte.
> + * @set_trigger_parent: Function used to set the trigger parent.
> + * @trig: The trigger in use by the core driver.
> + * @irq_data_ready: IRQ number for data ready on INT1 pin.
> + * @slock: mutex for read and write operation.
> + */
> +
> +struct st_acc_data {
> +	struct device *dev;
> +	char *name;
> +	atomic_t enabled;

Why does this have to be atomic?

> +	short index;
> +
> +	int fullscale;
> +	int gain;
> +	int odr;
> +
> +	bool multiread_bit;
> +	int (*read_byte) (struct st_acc_data *adata, u8 reg_addr, u8 *res_byte);
> +	int (*write_byte) (struct st_acc_data *adata, u8 reg_addr, u8 data);
> +	int (*read_multiple_byte) (struct st_acc_data *adata, u8 reg_addr,
> +							int len, u8 *data);
> +	void (*set_trigger_parent) (struct iio_dev *indio_dev);
> +
> +	struct iio_trigger *trig;
> +	int *irq_data_ready;

Why does this have to be a pointer?

> +	struct mutex slock;
> +};
> +
> +int acc_iio_probe(struct iio_dev *indio_dev);
> +void acc_iio_remove(struct iio_dev *indio_dev);
> +int acc_set_dataready_irq(struct iio_dev *indio_dev, bool enable);
> +
> +#ifdef CONFIG_IIO_BUFFER
> +int acc_probe_trigger(struct iio_dev *indio_dev);
> +void acc_remove_trigger(struct iio_dev *indio_dev);
> +int acc_allocate_ring(struct iio_dev *indio_dev);
> +void acc_deallocate_ring(struct iio_dev *indio_dev);
> +#else /* CONFIG_IIO_BUFFER */
> +static inline int acc_probe_trigger(struct iio_dev *indio_dev)
> +{
> +	return 0;
> +}
> +static inline void acc_remove_trigger(struct iio_dev *indio_dev)
> +{
> +	return;
> +}
> +static inline int acc_allocate_ring(struct iio_dev *indio_dev)
> +{
> +	return 0;
> +}
> +static inline void acc_deallocate_ring(struct iio_dev *indio_dev)
> +{
> +	return;
> +}
> +#endif /* CONFIG_IIO_BUFFER */
> +
> +#endif /* ST_ACCELEROMETERS_IIO_ACC_H */
> diff --git a/include/linux/platform_data/ST_accel_pdata.h
> b/include/linux/platform_data/ST_accel_pdata.h
> new file mode 100644
> index 0000000..51f7b2c
> --- /dev/null
> +++ b/include/linux/platform_data/ST_accel_pdata.h
> @@ -0,0 +1,34 @@
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
> +#ifndef ST_ACCELEROMETERS_PDATA_ACC_H
> +#define ST_ACCELEROMETERS_PDATA_ACC_H
> +
> +#define DEFAULT_ACCEL_ODR_AVL_100HZ		100
> +#define DEFAULT_ACCEL_FS_AVL_2G			2
> +
> +/**
> + * struct st_acc_platform_data - ST accel device platform data
> + * @fullscale: Value of fullscale used for the sensor.
> + * @sampling_frequency: Value of sampling frequency used for the sensor.
> + */
> +
> +struct st_acc_platform_data {
> +	int fullscale;
> +	int sampling_frequency;
> +};
> +
> +static const struct st_acc_platform_data st_acc_default_pdata = {
> +	.fullscale = DEFAULT_ACCEL_FS_AVL_2G,
> +	.sampling_frequency = DEFAULT_ACCEL_ODR_AVL_100HZ,
> +};

This one should clearly not be defined in the header.

> +
> +#endif /* ST_ACCELEROMETERS_PDATA_ACC_H */
