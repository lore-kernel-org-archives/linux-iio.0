Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:33507 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbbHAIjQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 1 Aug 2015 04:39:16 -0400
Received: by wicmv11 with SMTP id mv11so81872588wic.0
        for <linux-iio@vger.kernel.org>; Sat, 01 Aug 2015 01:39:15 -0700 (PDT)
Message-ID: <55BC85AF.1030608@cogentembedded.com>
Date: Sat, 01 Aug 2015 11:39:11 +0300
From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
MIME-Version: 1.0
To: Matt Ranostay <mranostay@gmail.com>, marex@denx.de,
	matt@ohporter.com, pantelis.antoniou@gmail.com, jic23@kernel.org
CC: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: proximity: add support for PulsedLight LIDAR
References: <1438401484-22101-1-git-send-email-mranostay@gmail.com> <1438401484-22101-3-git-send-email-mranostay@gmail.com>
In-Reply-To: <1438401484-22101-3-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Matt,

Find minor comments.

On 01.08.2015 06:58, Matt Ranostay wrote:
> Add support for the PulsedLight LIDAR rangefinder sensor which allows
> high speed (over 300Hz) distance measurements using Barker Coding within
> 40 meter range.
>
> Support only tested on the "blue label" rev 2, but may work using polling
> at low sample frequencies on the original version.
>
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> ---
>   drivers/iio/proximity/Kconfig  |  13 ++
>   drivers/iio/proximity/Makefile |   1 +
>   drivers/iio/proximity/lidar.c  | 309 +++++++++++++++++++++++++++++++++++++++++
Add ABI documentation 
Documentation/ABI/testing/sysfs-bus-iio-proximity-lidar
>   3 files changed, 323 insertions(+)
>   create mode 100644 drivers/iio/proximity/lidar.c
>
> diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
> index 41a8d8f..8111e11 100644
> --- a/drivers/iio/proximity/Kconfig
> +++ b/drivers/iio/proximity/Kconfig
> @@ -20,6 +20,19 @@ endmenu
>   
>   menu "Proximity sensors"
>   
> +config LIDAR
> +	tristate "PulsedLight LIDAR sensor"
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	select REGMAP_I2C
You did not use REGMAP in your driver.
Probably it would be better to use this API in your driver since the 
chip seems fully SMBUS compatible.
> +	depends on I2C
> +	help
> +	  Say Y to build a driver for PulsedLight LIDAR range finding
> +	  sensor.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called lidar.
> +
>   config SX9500
>   	tristate "SX9500 Semtech proximity sensor"
>   	select IIO_BUFFER
> diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
> index 9818dc5..36a95f3 100644
> --- a/drivers/iio/proximity/Makefile
> +++ b/drivers/iio/proximity/Makefile
> @@ -4,4 +4,5 @@
>   
>   # When adding new entries keep the list in alphabetical order
>   obj-$(CONFIG_AS3935)		+= as3935.o
> +obj-$(CONFIG_LIDAR)		+= lidar.o
>   obj-$(CONFIG_SX9500)		+= sx9500.o
> diff --git a/drivers/iio/proximity/lidar.c b/drivers/iio/proximity/lidar.c
> new file mode 100644
> index 0000000..e56df58
> --- /dev/null
> +++ b/drivers/iio/proximity/lidar.c
> @@ -0,0 +1,309 @@
> +/*
> + * lidar.c - Support for PulsedLight LIDAR range finding sensor
> + *
> + * Copyright (C) 2015 Matt Ranostay <mranostay@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * TODO: runtime pm, interrupt mode, and signal strength reporting
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/delay.h>
> +#include <linux/mutex.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/triggered_buffer.h>
put it in alphabetic order
> +
> +#define LIDAR_REG_CONTROL	0x00
> +#define LIDAR_REG_CONTROL_ACQUIRE	BIT(2)
tab aligned
> +
> +#define LIDAR_REG_STATUS	0x01
> +#define LIDAR_REG_STATUS_RDY	BIT(0)
> +
> +#define LIDAR_REG_DATA_HBYTE	0x0f
> +#define LIDAR_REG_DATA_LBYTE	0x10
> +#define LIDAR_REG_DATA_MAX	0xffff
> +
> +#define LIDAR_DRV_NAME	"lidar"
> +
> +struct lidar_data {
> +	struct mutex lock;
> +	struct iio_dev *indio_dev;
> +	struct i2c_client *client;
> +
> +	/* config */
> +	int calib_bias;
> +
> +	u16 buffer[5]; /* 2 byte distance + 8 byte timestamp */
> +};
> +
> +static const struct iio_chan_spec lidar_channels[] = {
> +	{
> +		.type = IIO_DISTANCE,
> +		.info_mask_separate =
> +			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_CALIBBIAS),
> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.storagebits = 16,
> +		},
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(1),
> +};
> +
> +static inline int lidar_read_byte(struct lidar_data *data, int reg)
> +{
> +	struct i2c_client *client = data->client;
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte(client, reg);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "cannot write addr value");
> +		return ret;
> +	}
> +
> +	ret = i2c_smbus_read_byte(client);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "cannot read data value");
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static inline int lidar_write_control(struct lidar_data *data, int val)
> +{
> +	return i2c_smbus_write_byte_data(data->client, LIDAR_REG_CONTROL, val);
> +}
> +
> +static int lidar_read_measurement(struct lidar_data *data, u16 *reg)
> +{
> +	int ret;
> +	int val;
> +
> +	ret = lidar_read_byte(data, LIDAR_REG_DATA_HBYTE);
> +	if (ret < 0)
> +		return ret;
> +	val = ret << 8;
> +
> +	ret = lidar_read_byte(data, LIDAR_REG_DATA_LBYTE);
> +	if (ret < 0)
> +		return ret;
> +	val |= ret;
> +
> +	/* correct any possible overflow or underflow */
> +	val += data->calib_bias / 10000;
> +	if (val < 0)
> +		val = 0;
> +
> +	if (val > LIDAR_REG_DATA_MAX)
> +		val = LIDAR_REG_DATA_MAX;
> +
> +	*reg = val;
> +
> +	return 0;
> +}
> +
> +static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
> +{
> +	struct i2c_client *client = data->client;
> +	int tries = 10;
> +	int ret;
> +
> +	/* start sample */
> +	ret = lidar_write_control(data, LIDAR_REG_CONTROL_ACQUIRE);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "cannot send start measurement command");
> +		return ret;
> +	}
> +
> +	while (tries--) {
> +		usleep_range(1000, 2000);
> +
> +		ret = lidar_read_byte(data, LIDAR_REG_STATUS);
> +		if (ret < 0)
> +			break;
> +
> +		/* sample ready to read */
> +		if (!(ret & LIDAR_REG_STATUS_RDY)) {
> +			ret = lidar_read_measurement(data, reg);
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int lidar_read_raw(struct iio_dev *indio_dev,
> +			  struct iio_chan_spec const *chan,
> +			  int *val, int *val2, long mask)
> +{
> +	struct lidar_data *data = iio_priv(indio_dev);
> +	int ret = -EINVAL;
> +
> +	if (iio_buffer_enabled(indio_dev) && mask == IIO_CHAN_INFO_RAW)
> +		return -EBUSY;
> +
> +	mutex_lock(&data->lock);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW: {
> +		u16 reg;
> +
> +		ret = lidar_get_measurement(data, &reg);
> +		if (!ret) {
> +			*val = reg / 100;
> +			*val2 = (reg % 100) * 10000;
> +			ret = IIO_VAL_INT_PLUS_MICRO;
> +		}
> +		break;
> +	}
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		*val = 0;
> +		*val2 = data->calib_bias;
> +		ret = IIO_VAL_INT_PLUS_MICRO;
> +		break;
> +	}
> +
> +	mutex_unlock(&data->lock);
> +
> +	return ret;
> +}
> +
> +static int lidar_write_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int val, int val2, long mask)
> +{
> +	struct lidar_data *data = iio_priv(indio_dev);
> +
> +	if (mask == IIO_CHAN_INFO_CALIBBIAS) {
> +		if (val != 0)
> +			return -EINVAL;
> +
> +		/* cm increments only */
> +		if (val2 % 10000)
> +			return -EINVAL;
> +
> +		mutex_lock(&data->lock);
> +		data->calib_bias = val2;
> +		mutex_unlock(&data->lock);
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static irqreturn_t lidar_trigger_handler(int irq, void *private)
> +{
> +	struct iio_poll_func *pf = private;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct lidar_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = lidar_get_measurement(data, &data->buffer[0]);
> +	if (!ret) {
> +		iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> +						   iio_get_time_ns());
> +	} else {
> +		dev_err(&data->client->dev, "cannot read LIDAR measurement");
> +	}
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static struct iio_info lidar_info = {
> +	.driver_module = THIS_MODULE,
> +	.read_raw = lidar_read_raw,
> +	.write_raw = lidar_write_raw,
> +};
> +
> +static int lidar_probe(struct i2c_client *client,
> +		       const struct i2c_device_id *id)
> +{
> +	struct lidar_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	indio_dev->info = &lidar_info;
> +	indio_dev->name = LIDAR_DRV_NAME;
> +	indio_dev->channels = lidar_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(lidar_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	data->client = client;
> +	data->indio_dev = indio_dev;
> +	mutex_init(&data->lock);
> +
> +	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> +					 lidar_trigger_handler, NULL);
> +	if (ret)
> +		return ret;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		goto error_unreg_buffer;
> +
> +	return 0;
> +
> +error_unreg_buffer:
> +	iio_triggered_buffer_cleanup(indio_dev);
> +
> +	return ret;
> +}
> +
> +static int lidar_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +
> +	iio_device_unregister(indio_dev);
> +	iio_triggered_buffer_cleanup(indio_dev);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id lidar_id[] = {
> +	{"lidar", 0},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(i2c, lidar_id);
> +
> +static struct i2c_driver lidar_driver = {
> +	.driver = {
> +		.name	= LIDAR_DRV_NAME,
> +		.owner	= THIS_MODULE,
the .owner field is not needed since it is overridden in i2c_register_driver
> +	},
> +	.probe		= lidar_probe,
> +	.remove		= lidar_remove,
> +	.id_table	= lidar_id,
> +};
> +module_i2c_driver(lidar_driver);
> +
> +MODULE_AUTHOR("Matt Ranostay <mranostay@gmail.com>");
> +MODULE_DESCRIPTION("PulsedLight LIDAR sensor");
> +MODULE_LICENSE("GPL");

