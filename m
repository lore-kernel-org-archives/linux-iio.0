Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:61710 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756283Ab3BAKGP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 1 Feb 2013 05:06:15 -0500
Message-ID: <510B93F1.6070303@metafoo.de>
Date: Fri, 01 Feb 2013 11:07:45 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
CC: jic23@cam.ac.uk, linux-iio@vger.kernel.org,
	Thorsten Nowak <thorsten.nowak@iis.fraunhofer.de>
Subject: Re: [PATCH V4] iio: gyro: Add itg3200
References: <510AC28D.3050603@metafoo.de> <1359708687-15309-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
In-Reply-To: <1359708687-15309-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/01/2013 09:51 AM, Manuel Stahl wrote:
> This patch adds support for the InvenSense itg3200.
> The itg3200 is a three-axis gyro with 16-bit ADC and
> I2C interface.
> 
> Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>

Looks good,

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>  drivers/iio/gyro/Kconfig          |    8 +
>  drivers/iio/gyro/Makefile         |    4 +
>  drivers/iio/gyro/itg3200_buffer.c |  156 ++++++++++++++
>  drivers/iio/gyro/itg3200_core.c   |  401 +++++++++++++++++++++++++++++++++++++
>  include/linux/iio/gyro/itg3200.h  |  154 ++++++++++++++
>  5 files changed, 723 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/iio/gyro/itg3200_buffer.c
>  create mode 100644 drivers/iio/gyro/itg3200_core.c
>  create mode 100644 include/linux/iio/gyro/itg3200.h
> 
> diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
> index 752ac8a..343a3e0 100644
> --- a/drivers/iio/gyro/Kconfig
> +++ b/drivers/iio/gyro/Kconfig
> @@ -30,4 +30,12 @@ config HID_SENSOR_GYRO_3D
>  	  Say yes here to build support for the HID SENSOR
>  	  Gyroscope 3D.
>  
> +config ITG3200
> +	tristate "InvenSense ITG3200 Digital 3-Axis Gyroscope I2C driver"
> +	depends on I2C
> +	select IIO_TRIGGERED_BUFFER if IIO_BUFFER
> +	help
> +	  Say yes here to add support for the InvenSense ITG3200 digital
> +	  3-axis gyroscope sensor.
> +
>  endmenu
> diff --git a/drivers/iio/gyro/Makefile b/drivers/iio/gyro/Makefile
> index 9b090ee..99ae7d6 100644
> --- a/drivers/iio/gyro/Makefile
> +++ b/drivers/iio/gyro/Makefile
> @@ -5,3 +5,7 @@
>  obj-$(CONFIG_ADIS16080) += adis16080.o
>  obj-$(CONFIG_ADIS16136) += adis16136.o
>  obj-$(CONFIG_HID_SENSOR_GYRO_3D) += hid-sensor-gyro-3d.o
> +
> +itg3200-y               := itg3200_core.o
> +itg3200-$(CONFIG_IIO_BUFFER) += itg3200_buffer.o
> +obj-$(CONFIG_ITG3200)   += itg3200.o
> diff --git a/drivers/iio/gyro/itg3200_buffer.c b/drivers/iio/gyro/itg3200_buffer.c
> new file mode 100644
> index 0000000..f667d2c
> --- /dev/null
> +++ b/drivers/iio/gyro/itg3200_buffer.c
> @@ -0,0 +1,156 @@
> +/*
> + * itg3200_buffer.c -- support InvenSense ITG3200
> + *                     Digital 3-Axis Gyroscope driver
> + *
> + * Copyright (c) 2011 Christian Strobel <christian.strobel@iis.fraunhofer.de>
> + * Copyright (c) 2011 Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
> + * Copyright (c) 2012 Thorsten Nowak <thorsten.nowak@iis.fraunhofer.de>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/gyro/itg3200.h>
> +
> +
> +static int itg3200_read_all_channels(struct i2c_client *i2c, __be16 *buf)
> +{
> +	u8 tx = 0x80 | ITG3200_REG_TEMP_OUT_H;
> +	struct i2c_msg msg[2] = {
> +		{
> +			.addr = i2c->addr,
> +			.flags = i2c->flags,
> +			.len = 1,
> +			.buf = &tx,
> +		},
> +		{
> +			.addr = i2c->addr,
> +			.flags = i2c->flags | I2C_M_RD,
> +			.len = ITG3200_SCAN_ELEMENTS * sizeof(s16),
> +			.buf = (char *)&buf,
> +		},
> +	};
> +
> +	return i2c_transfer(i2c->adapter, msg, 2);
> +}
> +
> +static irqreturn_t itg3200_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct itg3200 *st = iio_priv(indio_dev);
> +	__be16 buf[ITG3200_SCAN_ELEMENTS + sizeof(s64)/sizeof(u16)];
> +
> +	int ret = itg3200_read_all_channels(st->i2c, buf);
> +	if (ret < 0)
> +		goto error_ret;
> +
> +	if (indio_dev->scan_timestamp)
> +		memcpy(buf + indio_dev->scan_bytes - sizeof(s64),
> +				&pf->timestamp, sizeof(pf->timestamp));
> +
> +	iio_push_to_buffers(indio_dev, (u8 *)buf);
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +error_ret:
> +	return IRQ_HANDLED;
> +}
> +
> +int itg3200_buffer_configure(struct iio_dev *indio_dev)
> +{
> +	return iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
> +		itg3200_trigger_handler, NULL);
> +}
> +
> +void itg3200_buffer_unconfigure(struct iio_dev *indio_dev)
> +{
> +	iio_triggered_buffer_cleanup(indio_dev);
> +}
> +
> +
> +static int itg3200_data_rdy_trigger_set_state(struct iio_trigger *trig,
> +		bool state)
> +{
> +	struct iio_dev *indio_dev = trig->private_data;
> +	int ret;
> +	u8 msc;
> +
> +	ret = itg3200_read_reg_8(indio_dev, ITG3200_REG_IRQ_CONFIG, &msc);
> +	if (ret)
> +		goto error_ret;
> +
> +	if (state)
> +		msc |= ITG3200_IRQ_DATA_RDY_ENABLE;
> +	else
> +		msc &= ~ITG3200_IRQ_DATA_RDY_ENABLE;
> +
> +	ret = itg3200_write_reg_8(indio_dev, ITG3200_REG_IRQ_CONFIG, msc);
> +	if (ret)
> +		goto error_ret;
> +
> +error_ret:
> +	return ret;
> +
> +}
> +
> +static const struct iio_trigger_ops itg3200_trigger_ops = {
> +	.owner = THIS_MODULE,
> +	.set_trigger_state = &itg3200_data_rdy_trigger_set_state,
> +};
> +
> +int itg3200_probe_trigger(struct iio_dev *indio_dev)
> +{
> +	int ret;
> +	struct itg3200 *st = iio_priv(indio_dev);
> +
> +	st->trig = iio_trigger_alloc("%s-dev%d", indio_dev->name,
> +				     indio_dev->id);
> +	if (!st->trig)
> +		return -ENOMEM;
> +
> +	ret = request_irq(st->i2c->irq,
> +			  &iio_trigger_generic_data_rdy_poll,
> +			  IRQF_TRIGGER_RISING,
> +			  "itg3200_data_rdy",
> +			  st->trig);
> +	if (ret)
> +		goto error_free_trig;
> +
> +
> +	st->trig->dev.parent = &st->i2c->dev;
> +	st->trig->ops = &itg3200_trigger_ops;
> +	st->trig->private_data = indio_dev;
> +	ret = iio_trigger_register(st->trig);
> +	if (ret)
> +		goto error_free_irq;
> +
> +	/* select default trigger */
> +	indio_dev->trig = st->trig;
> +
> +	return 0;
> +
> +error_free_irq:
> +	free_irq(st->i2c->irq, st->trig);
> +error_free_trig:
> +	iio_trigger_free(st->trig);
> +	return ret;
> +}
> +
> +void itg3200_remove_trigger(struct iio_dev *indio_dev)
> +{
> +	struct itg3200 *st = iio_priv(indio_dev);
> +
> +	iio_trigger_unregister(st->trig);
> +	free_irq(st->i2c->irq, st->trig);
> +	iio_trigger_free(st->trig);
> +}
> diff --git a/drivers/iio/gyro/itg3200_core.c b/drivers/iio/gyro/itg3200_core.c
> new file mode 100644
> index 0000000..df2e6aa
> --- /dev/null
> +++ b/drivers/iio/gyro/itg3200_core.c
> @@ -0,0 +1,401 @@
> +/*
> + * itg3200_core.c -- support InvenSense ITG3200
> + *                   Digital 3-Axis Gyroscope driver
> + *
> + * Copyright (c) 2011 Christian Strobel <christian.strobel@iis.fraunhofer.de>
> + * Copyright (c) 2011 Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
> + * Copyright (c) 2012 Thorsten Nowak <thorsten.nowak@iis.fraunhofer.de>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * TODO:
> + * - Support digital low pass filter
> + * - Support power management
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/i2c.h>
> +#include <linux/gpio.h>
> +#include <linux/slab.h>
> +#include <linux/stat.h>
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/buffer.h>
> +
> +#include <linux/iio/gyro/itg3200.h>
> +
> +
> +int itg3200_write_reg_8(struct iio_dev *indio_dev,
> +		u8 reg_address, u8 val)
> +{
> +	struct itg3200 *st = iio_priv(indio_dev);
> +
> +	return i2c_smbus_write_byte_data(st->i2c, 0x80 | reg_address, val);
> +}
> +
> +int itg3200_read_reg_8(struct iio_dev *indio_dev,
> +		u8 reg_address, u8 *val)
> +{
> +	struct itg3200 *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(st->i2c, reg_address);
> +	if (ret < 0)
> +		return ret;
> +	*val = ret;
> +	return 0;
> +}
> +
> +static int itg3200_read_reg_s16(struct iio_dev *indio_dev, u8 lower_reg_address,
> +		int *val)
> +{
> +	struct itg3200 *st = iio_priv(indio_dev);
> +	struct i2c_client *client = st->i2c;
> +	int ret;
> +	s16 out;
> +
> +	struct i2c_msg msg[2] = {
> +		{
> +			.addr = client->addr,
> +			.flags = client->flags,
> +			.len = 1,
> +			.buf = (char *)&lower_reg_address,
> +		},
> +		{
> +			.addr = client->addr,
> +			.flags = client->flags | I2C_M_RD,
> +			.len = 2,
> +			.buf = (char *)&out,
> +		},
> +	};
> +
> +	lower_reg_address |= 0x80;
> +	ret = i2c_transfer(client->adapter, msg, 2);
> +	be16_to_cpus(&out);
> +	*val = out;
> +
> +	return (ret == 2) ? 0 : ret;
> +}
> +
> +static int itg3200_read_raw(struct iio_dev *indio_dev,
> +		const struct iio_chan_spec *chan,
> +		int *val, int *val2, long info)
> +{
> +	int ret = 0;
> +	u8 reg;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		reg = (u8)chan->address;
> +		ret = itg3200_read_reg_s16(indio_dev, reg, val);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;
> +		if (chan->type == IIO_TEMP)
> +			*val2 = 1000000000/280;
> +		else
> +			*val2 = 1214142; /* (1 / 14,375) * (PI / 180) */
> +		return IIO_VAL_INT_PLUS_NANO;
> +	case IIO_CHAN_INFO_OFFSET:
> +		/* Only the temperature channel has an offset */
> +		*val = 23000;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static ssize_t itg3200_read_frequency(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	int ret, sps;
> +	u8 val;
> +
> +	ret = itg3200_read_reg_8(indio_dev, ITG3200_REG_DLPF, &val);
> +	if (ret)
> +		return ret;
> +
> +	sps = (val & ITG3200_DLPF_CFG_MASK) ? 1000 : 8000;
> +
> +	ret = itg3200_read_reg_8(indio_dev, ITG3200_REG_SAMPLE_RATE_DIV, &val);
> +	if (ret)
> +		return ret;
> +
> +	sps /= val + 1;
> +
> +	return sprintf(buf, "%d\n", sps);
> +}
> +
> +static ssize_t itg3200_write_frequency(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	unsigned val;
> +	int ret;
> +	u8 t;
> +
> +	ret = kstrtouint(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&indio_dev->mlock);
> +
> +	ret = itg3200_read_reg_8(indio_dev, ITG3200_REG_DLPF, &t);
> +	if (ret)
> +		goto err_ret;
> +
> +	if (val == 0) {
> +		ret = -EINVAL;
> +		goto err_ret;
> +	}
> +	t = ((t & ITG3200_DLPF_CFG_MASK) ? 1000u : 8000u) / val - 1;
> +
> +	ret = itg3200_write_reg_8(indio_dev, ITG3200_REG_SAMPLE_RATE_DIV, t);
> +
> +err_ret:
> +	mutex_unlock(&indio_dev->mlock);
> +
> +	return ret ? ret : len;
> +}
> +
> +/*
> + * Reset device and internal registers to the power-up-default settings
> + * Use the gyro clock as reference, as suggested by the datasheet
> + */
> +static int itg3200_reset(struct iio_dev *indio_dev)
> +{
> +	struct itg3200 *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	dev_dbg(&st->i2c->dev, "reset device");
> +
> +	ret = itg3200_write_reg_8(indio_dev,
> +			ITG3200_REG_POWER_MANAGEMENT,
> +			ITG3200_RESET);
> +	if (ret) {
> +		dev_err(&st->i2c->dev, "error resetting device");
> +		goto error_ret;
> +	}
> +
> +	/* Wait for PLL (1ms according to datasheet) */
> +	udelay(1500);
> +
> +	ret = itg3200_write_reg_8(indio_dev,
> +			ITG3200_REG_IRQ_CONFIG,
> +			ITG3200_IRQ_ACTIVE_HIGH |
> +			ITG3200_IRQ_PUSH_PULL |
> +			ITG3200_IRQ_LATCH_50US_PULSE |
> +			ITG3200_IRQ_LATCH_CLEAR_ANY);
> +
> +	if (ret)
> +		dev_err(&st->i2c->dev, "error init device");
> +
> +error_ret:
> +	return ret;
> +}
> +
> +/* itg3200_enable_full_scale() - Disables the digital low pass filter */
> +static int itg3200_enable_full_scale(struct iio_dev *indio_dev)
> +{
> +	u8 val;
> +	int ret;
> +
> +	ret = itg3200_read_reg_8(indio_dev, ITG3200_REG_DLPF, &val);
> +	if (ret)
> +		goto err_ret;
> +
> +	val |= ITG3200_DLPF_FS_SEL_2000;
> +	return itg3200_write_reg_8(indio_dev, ITG3200_REG_DLPF, val);
> +
> +err_ret:
> +	return ret;
> +}
> +
> +static int itg3200_initial_setup(struct iio_dev *indio_dev)
> +{
> +	struct itg3200 *st = iio_priv(indio_dev);
> +	int ret;
> +	u8 val;
> +
> +	ret = itg3200_read_reg_8(indio_dev, ITG3200_REG_ADDRESS, &val);
> +	if (ret)
> +		goto err_ret;
> +
> +	if (((val >> 1) & 0x3f) != 0x34) {
> +		dev_err(&st->i2c->dev, "invalid reg value 0x%02x", val);
> +		ret = -ENXIO;
> +		goto err_ret;
> +	}
> +
> +	ret = itg3200_reset(indio_dev);
> +	if (ret)
> +		goto err_ret;
> +
> +	ret = itg3200_enable_full_scale(indio_dev);
> +err_ret:
> +	return ret;
> +}
> +
> +#define ITG3200_TEMP_INFO_MASK	(IIO_CHAN_INFO_OFFSET_SHARED_BIT | \
> +				 IIO_CHAN_INFO_SCALE_SHARED_BIT | \
> +				 IIO_CHAN_INFO_RAW_SEPARATE_BIT)
> +#define ITG3200_GYRO_INFO_MASK	(IIO_CHAN_INFO_SCALE_SHARED_BIT | \
> +				 IIO_CHAN_INFO_RAW_SEPARATE_BIT)
> +
> +#define ITG3200_ST						\
> +	{ .sign = 's', .realbits = 16, .storagebits = 16, .endianness = IIO_BE }
> +
> +#define ITG3200_GYRO_CHAN(_mod) { \
> +	.type = IIO_ANGL_VEL, \
> +	.modified = 1, \
> +	.channel2 = IIO_MOD_ ## _mod, \
> +	.info_mask = ITG3200_GYRO_INFO_MASK, \
> +	.address = ITG3200_REG_GYRO_ ## _mod ## OUT_H, \
> +	.scan_index = ITG3200_SCAN_GYRO_ ## _mod, \
> +	.scan_type = ITG3200_ST, \
> +}
> +
> +static const struct iio_chan_spec itg3200_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.channel2 = IIO_NO_MOD,
> +		.info_mask = ITG3200_TEMP_INFO_MASK,
> +		.address = ITG3200_REG_TEMP_OUT_H,
> +		.scan_index = ITG3200_SCAN_TEMP,
> +		.scan_type = ITG3200_ST,
> +	},
> +	ITG3200_GYRO_CHAN(X),
> +	ITG3200_GYRO_CHAN(Y),
> +	ITG3200_GYRO_CHAN(Z),
> +	IIO_CHAN_SOFT_TIMESTAMP(ITG3200_SCAN_ELEMENTS),
> +};
> +
> +/* IIO device attributes */
> +static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO, itg3200_read_frequency,
> +		itg3200_write_frequency);
> +
> +static struct attribute *itg3200_attributes[] = {
> +	&iio_dev_attr_sampling_frequency.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group itg3200_attribute_group = {
> +	.attrs = itg3200_attributes,
> +};
> +
> +static const struct iio_info itg3200_info = {
> +	.attrs = &itg3200_attribute_group,
> +	.read_raw = &itg3200_read_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static const unsigned long itg3200_available_scan_masks[] = { 0xffffffff, 0x0 };
> +
> +static int itg3200_probe(struct i2c_client *client,
> +		const struct i2c_device_id *id)
> +{
> +	int ret;
> +	struct itg3200 *st;
> +	struct iio_dev *indio_dev;
> +
> +	dev_dbg(&client->dev, "probe I2C dev with IRQ %i", client->irq);
> +
> +	indio_dev = iio_device_alloc(sizeof(*st));
> +	if (indio_dev == NULL) {
> +		ret =  -ENOMEM;
> +		goto error_ret;
> +	}
> +
> +	st = iio_priv(indio_dev);
> +
> +	i2c_set_clientdata(client, indio_dev);
> +	st->i2c = client;
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->name = client->dev.driver->name;
> +	indio_dev->channels = itg3200_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(itg3200_channels);
> +	indio_dev->available_scan_masks = itg3200_available_scan_masks;
> +	indio_dev->info = &itg3200_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = itg3200_buffer_configure(indio_dev);
> +	if (ret)
> +		goto error_free_dev;
> +
> +	if (client->irq) {
> +		ret = itg3200_probe_trigger(indio_dev);
> +		if (ret)
> +			goto error_unconfigure_buffer;
> +	}
> +
> +	ret = itg3200_initial_setup(indio_dev);
> +	if (ret)
> +		goto error_remove_trigger;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		goto error_remove_trigger;
> +
> +	return 0;
> +
> +error_remove_trigger:
> +	if (client->irq)
> +		itg3200_remove_trigger(indio_dev);
> +error_unconfigure_buffer:
> +	itg3200_buffer_unconfigure(indio_dev);
> +error_free_dev:
> +	iio_device_free(indio_dev);
> +error_ret:
> +	return ret;
> +}
> +
> +static int itg3200_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +
> +	iio_device_unregister(indio_dev);
> +
> +	if (client->irq)
> +		itg3200_remove_trigger(indio_dev);
> +
> +	itg3200_buffer_unconfigure(indio_dev);
> +
> +	iio_device_free(indio_dev);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id itg3200_id[] = {
> +	{ "itg3200", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, itg3200_id);
> +
> +static struct i2c_driver itg3200_driver = {
> +	.driver = {
> +		.owner  = THIS_MODULE,
> +		.name	= "itg3200",
> +	},
> +	.id_table	= itg3200_id,
> +	.probe		= itg3200_probe,
> +	.remove		= itg3200_remove,
> +};
> +
> +module_i2c_driver(itg3200_driver);
> +
> +MODULE_AUTHOR("Christian Strobel <christian.strobel@iis.fraunhofer.de>");
> +MODULE_DESCRIPTION("ITG3200 Gyroscope I2C driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/iio/gyro/itg3200.h b/include/linux/iio/gyro/itg3200.h
> new file mode 100644
> index 0000000..c53f169
> --- /dev/null
> +++ b/include/linux/iio/gyro/itg3200.h
> @@ -0,0 +1,154 @@
> +/*
> + * itg3200.h -- support InvenSense ITG3200
> + *              Digital 3-Axis Gyroscope driver
> + *
> + * Copyright (c) 2011 Christian Strobel <christian.strobel@iis.fraunhofer.de>
> + * Copyright (c) 2011 Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
> + * Copyright (c) 2012 Thorsten Nowak <thorsten.nowak@iis.fraunhofer.de>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef I2C_ITG3200_H_
> +#define I2C_ITG3200_H_
> +
> +#include <linux/iio/iio.h>
> +
> +/* Register with I2C address (34h) */
> +#define ITG3200_REG_ADDRESS		0x00
> +
> +/* Sample rate divider
> + * Range: 0 to 255
> + * Default value: 0x00 */
> +#define ITG3200_REG_SAMPLE_RATE_DIV	0x15
> +
> +/* Digital low pass filter settings */
> +#define ITG3200_REG_DLPF		0x16
> +/* DLPF full scale range */
> +#define ITG3200_DLPF_FS_SEL_2000	0x18
> +/* Bandwidth (Hz) and internal sample rate
> + * (kHz) of DLPF */
> +#define ITG3200_DLPF_256_8		0x00
> +#define ITG3200_DLPF_188_1		0x01
> +#define ITG3200_DLPF_98_1		0x02
> +#define ITG3200_DLPF_42_1		0x03
> +#define ITG3200_DLPF_20_1		0x04
> +#define ITG3200_DLPF_10_1		0x05
> +#define ITG3200_DLPF_5_1		0x06
> +
> +#define ITG3200_DLPF_CFG_MASK		0x07
> +
> +/* Configuration for interrupt operations */
> +#define ITG3200_REG_IRQ_CONFIG		0x17
> +/* Logic level */
> +#define ITG3200_IRQ_ACTIVE_LOW		0x80
> +#define ITG3200_IRQ_ACTIVE_HIGH		0x00
> +/* Drive type */
> +#define ITG3200_IRQ_OPEN_DRAIN		0x40
> +#define ITG3200_IRQ_PUSH_PULL		0x00
> +/* Latch mode */
> +#define ITG3200_IRQ_LATCH_UNTIL_CLEARED	0x20
> +#define ITG3200_IRQ_LATCH_50US_PULSE	0x00
> +/* Latch clear method */
> +#define ITG3200_IRQ_LATCH_CLEAR_ANY	0x10
> +#define ITG3200_IRQ_LATCH_CLEAR_STATUS	0x00
> +/* Enable interrupt when device is ready */
> +#define ITG3200_IRQ_DEVICE_RDY_ENABLE	0x04
> +/* Enable interrupt when data is available */
> +#define ITG3200_IRQ_DATA_RDY_ENABLE	0x01
> +
> +/* Determine the status of ITG-3200 interrupts */
> +#define ITG3200_REG_IRQ_STATUS		0x1A
> +/* Status of 'device is ready'-interrupt */
> +#define ITG3200_IRQ_DEVICE_RDY_STATUS	0x04
> +/* Status of 'data is available'-interrupt */
> +#define ITG3200_IRQ_DATA_RDY_STATUS	0x01
> +
> +/* Sensor registers */
> +#define ITG3200_REG_TEMP_OUT_H		0x1B
> +#define ITG3200_REG_TEMP_OUT_L		0x1C
> +#define ITG3200_REG_GYRO_XOUT_H		0x1D
> +#define ITG3200_REG_GYRO_XOUT_L		0x1E
> +#define ITG3200_REG_GYRO_YOUT_H		0x1F
> +#define ITG3200_REG_GYRO_YOUT_L		0x20
> +#define ITG3200_REG_GYRO_ZOUT_H		0x21
> +#define ITG3200_REG_GYRO_ZOUT_L		0x22
> +
> +/* Power management */
> +#define ITG3200_REG_POWER_MANAGEMENT	0x3E
> +/* Reset device and internal registers to the
> + * power-up-default settings */
> +#define ITG3200_RESET			0x80
> +/* Enable low power sleep mode */
> +#define ITG3200_SLEEP			0x40
> +/* Put according gyroscope in standby mode */
> +#define ITG3200_STANDBY_GYRO_X		0x20
> +#define ITG3200_STANDBY_GYRO_Y		0x10
> +#define ITG3200_STANDBY_GYRO_Z		0x08
> +/* Determine the device clock source */
> +#define ITG3200_CLK_INTERNAL		0x00
> +#define ITG3200_CLK_GYRO_X		0x01
> +#define ITG3200_CLK_GYRO_Y		0x02
> +#define ITG3200_CLK_GYRO_Z		0x03
> +#define ITG3200_CLK_EXT_32K		0x04
> +#define ITG3200_CLK_EXT_19M		0x05
> +
> +
> +/**
> + * struct itg3200 - device instance specific data
> + * @i2c:    actual i2c_client
> + * @trig:   data ready trigger from itg3200 pin
> + **/
> +struct itg3200 {
> +	struct i2c_client	*i2c;
> +	struct iio_trigger	*trig;
> +};
> +
> +enum ITG3200_SCAN_INDEX {
> +	ITG3200_SCAN_TEMP,
> +	ITG3200_SCAN_GYRO_X,
> +	ITG3200_SCAN_GYRO_Y,
> +	ITG3200_SCAN_GYRO_Z,
> +	ITG3200_SCAN_ELEMENTS,
> +};
> +
> +int itg3200_write_reg_8(struct iio_dev *indio_dev,
> +		u8 reg_address, u8 val);
> +
> +int itg3200_read_reg_8(struct iio_dev *indio_dev,
> +		u8 reg_address, u8 *val);
> +
> +
> +#ifdef CONFIG_IIO_BUFFER
> +
> +void itg3200_remove_trigger(struct iio_dev *indio_dev);
> +int itg3200_probe_trigger(struct iio_dev *indio_dev);
> +
> +int itg3200_buffer_configure(struct iio_dev *indio_dev);
> +void itg3200_buffer_unconfigure(struct iio_dev *indio_dev);
> +
> +#else /* CONFIG_IIO_BUFFER */
> +
> +static inline void itg3200_remove_trigger(struct iio_dev *indio_dev)
> +{
> +}
> +
> +static inline int itg3200_probe_trigger(struct iio_dev *indio_dev)
> +{
> +	return 0;
> +}
> +
> +static inline int itg3200_buffer_configure(struct iio_dev *indio_dev)
> +{
> +	return 0;
> +}
> +
> +static inline void itg3200_buffer_unconfigure(struct iio_dev *indio_dev)
> +{
> +}
> +
> +#endif  /* CONFIG_IIO_RING_BUFFER */
> +
> +#endif /* ITG3200_H_ */

