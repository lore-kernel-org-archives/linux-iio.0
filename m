Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:34595 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750742AbaFEIr4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 5 Jun 2014 04:47:56 -0400
Date: Thu, 5 Jun 2014 10:47:54 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc: jic23@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: AK09911 : 3 axis compass support
In-Reply-To: <alpine.DEB.2.01.1406051021180.25289@pmeerw.net>
Message-ID: <alpine.DEB.2.01.1406051047000.25289@pmeerw.net>
References: <1401842039-8766-1-git-send-email-srinivas.pandruvada@linux.intel.com> <alpine.DEB.2.01.1406040911500.32323@pmeerw.net> <538F5754.5000300@linux.intel.com> <alpine.DEB.2.01.1406051021180.25289@pmeerw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> > Thanks. Submitted new version. Only one question in-line.
> 
> ... and answer below

and another comment regarding clamping
 
> > > > Added IIO magnetometer driver for AK09911. In functionality is resembles
> > > > AK8975 or AK8963. But there are several differences, so instead of
> > > > modifying existing AK8975 driver and keep it clean, implemented as
> > > > a separate driver.
> > > > The key differences are:
> > > > - Register map is different and have different indexes
> > > > - AK09911 is a very compact interface with no DRDY pin. So no support
> > > >   of interrupt of GPIO poll
> > > 
> > > or GPIO poll?
> > > 
> > > > - Even for polled mode no mention on ST2 register, which is required in
> > > > ak8975 driver
> > > > - mode values are different for fuse access
> > > 
> > > comments inline
> > > 
> > > > diff --git a/drivers/iio/magnetometer/Kconfig
> > > > b/drivers/iio/magnetometer/Kconfig
> > > > index 05a364c54..b2dba9e 100644
> > > > --- a/drivers/iio/magnetometer/Kconfig
> > > > +++ b/drivers/iio/magnetometer/Kconfig
> > > > @@ -17,6 +17,16 @@ config AK8975
> > > >   	  To compile this driver as a module, choose M here: the module
> > > >   	  will be called ak8975.
> > > > 
> > > > +config AK09911
> > > > +	tristate "Asahi Kasei AK09911 3-axis Compass"
> > > > +	depends on I2C
> > > > +	help
> > > > +	  Say yes here to build support for Asahi Kasei AK09911 3-Axis
> > > > +	  Magnetometer.
> > > > +
> > > > +	  To compile this driver as a module, choose M here: the module
> > > > +	  will be called ak09911.
> > > > +
> > > >   config MAG3110
> > > >   	tristate "Freescale MAG3110 3-Axis Magnetometer"
> > > >   	depends on I2C
> > > > diff --git a/drivers/iio/magnetometer/Makefile
> > > > b/drivers/iio/magnetometer/Makefile
> > > > index 0f5d3c9..8526873 100644
> > > > --- a/drivers/iio/magnetometer/Makefile
> > > > +++ b/drivers/iio/magnetometer/Makefile
> > > > @@ -4,6 +4,7 @@
> > > > 
> > > >   # When adding new entries keep the list in alphabetical order
> > > >   obj-$(CONFIG_AK8975)	+= ak8975.o
> > > > +obj-$(CONFIG_AK09911)	+= ak09911.o
> > > 
> > > alphabetic, so before ak8975
> > > 
> > > >   obj-$(CONFIG_MAG3110)	+= mag3110.o
> > > >   obj-$(CONFIG_HID_SENSOR_MAGNETOMETER_3D) += hid-sensor-magn-3d.o
> > > > 
> > > > diff --git a/drivers/iio/magnetometer/ak09911.c
> > > > b/drivers/iio/magnetometer/ak09911.c
> > > > new file mode 100644
> > > > index 0000000..6a69856
> > > > --- /dev/null
> > > > +++ b/drivers/iio/magnetometer/ak09911.c
> > > > @@ -0,0 +1,346 @@
> > > > +/*
> > > > + * AK09911 3-axis compass driver
> > > > + * Copyright (c) 2014, Intel Corporation.
> > > > + *
> > > > + * This program is free software; you can redistribute it and/or modify
> > > > it
> > > > + * under the terms and conditions of the GNU General Public License,
> > > > + * version 2, as published by the Free Software Foundation.
> > > > + *
> > > > + * This program is distributed in the hope it will be useful, but WITHOUT
> > > > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> > > > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> > > > for
> > > > + * more details.
> > > > + */
> > > > +
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/init.h>
> > > > +#include <linux/types.h>
> > > > +#include <linux/slab.h>
> > > > +#include <linux/delay.h>
> > > > +#include <linux/i2c.h>
> > > > +#include <linux/acpi.h>
> > > > +#include <linux/iio/iio.h>
> > > > +
> > > > +#define AK09911_REG_WIA1		0x00
> > > > +#define AK09911_REG_WIA2		0x01
> > > > +#define AK09911_WIA1_VALUE		0x48
> > > > +#define AK09911_WIA2_VALUE		0x05
> > > > +
> > > > +#define AK09911_REG_ST1			0x10
> > > > +#define AK09911_REG_HXL			0x11
> > > > +#define AK09911_REG_HXH			0x12
> > > > +#define AK09911_REG_HYL			0x13
> > > > +#define AK09911_REG_HYH			0x14
> > > > +#define AK09911_REG_HZL			0x15
> > > > +#define AK09911_REG_HZH			0x16
> > > > +
> > > > +#define AK09911_REG_ASAX		0x60
> > > > +#define AK09911_REG_ASAY		0x61
> > > > +#define AK09911_REG_ASAZ		0x62
> > > > +
> > > > +#define AK09911_REG_CNTL1		0x30
> > > > +#define AK09911_REG_CNTL2		0x31
> > > > +#define AK09911_REG_CNTL3		0x32
> > > > +
> > > > +#define AK09911_MODE_SNG_MEASURE	0x01
> > > > +#define AK09911_MODE_SELF_TEST		0x10
> > > > +#define AK09911_MODE_FUSE_ACCESS	0x1F
> > > > +#define AK09911_MODE_POWERDOWN		0x00
> > > > +#define AK09911_RESET_DATA		0x01
> > > > +
> > > > +#define AK09911_REG_CNTL1		0x30
> > > > +#define AK09911_REG_CNTL2		0x31
> > > > +#define AK09911_REG_CNTL3		0x32
> > > > +
> > > > +#define RAW_TO_GAUSS(asa)	((((asa) + 128) * 6000) / 256)
> > > 
> > > prefix with AK09911_
> > > 
> > > > +
> > > > +#define AK09911_MAX_CONVERSION_TIMEOUT	500
> > > > +#define AK09911_CONVERSION_DONE_POLL_TIME 10
> > > 
> > > time unit?
> > > 
> > > > +
> > > > +struct ak09911_data {
> > > > +	struct i2c_client	*client;
> > > > +	struct mutex		lock;
> > > > +	u8			asa[3];
> > > > +	long			raw_to_gauss[3];
> > > > +};
> > > > +
> > > > +static const int ak09911_index_to_reg[] = {
> > > > +	AK09911_REG_HXL, AK09911_REG_HYL, AK09911_REG_HZL,
> > > > +};
> > > > +
> > > > +static int ak09911_set_mode(struct i2c_client *client, u8 mode)
> > > > +{
> > > > +	int ret;
> > > > +
> > > > +	switch (mode) {
> > > > +	case AK09911_MODE_SNG_MEASURE:
> > > > +	case AK09911_MODE_SELF_TEST:
> > > > +	case AK09911_MODE_FUSE_ACCESS:
> > > > +	case AK09911_MODE_POWERDOWN:
> > > > +		ret = i2c_smbus_write_byte_data(client,
> > > > +						AK09911_REG_CNTL2, mode);
> > > > +		if (ret < 0) {
> > > > +			dev_err(&client->dev, "set_mode error\n");
> > > > +			return ret;
> > > > +		}
> > > > +		/* After mode change wait atleast 100us */
> > > > +		usleep_range(100, 500);
> > > > +		break;
> > > > +	default:
> > > > +		dev_err(&client->dev,
> > > > +			"%s: Unknown mode(%d).", __func__, mode);
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +/* Get Sensitivity Adjustment value */
> > > > +static int ak09911_get_asa(struct i2c_client *client)
> > > > +{
> > > > +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> > > > +	struct ak09911_data *data = iio_priv(indio_dev);
> > > > +	int ret;
> > > > +
> > > > +	ret = ak09911_set_mode(client, AK09911_MODE_FUSE_ACCESS);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	/* Get asa data and store in the device data. */
> > > > +	ret = i2c_smbus_read_i2c_block_data(client, AK09911_REG_ASAX,
> > > > +					    3, data->asa);
> > > > +	if (ret < 0) {
> > > > +		dev_err(&client->dev, "Not able to read asa data\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	ret = ak09911_set_mode(client,  AK09911_MODE_POWERDOWN);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	data->raw_to_gauss[0] = RAW_TO_GAUSS(data->asa[0]);
> > > > +	data->raw_to_gauss[1] = RAW_TO_GAUSS(data->asa[1]);
> > > > +	data->raw_to_gauss[2] = RAW_TO_GAUSS(data->asa[2]);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int ak09911_verify_chip_id(struct i2c_client *client)
> > > > +{
> > > > +	u8 wia_val[2];
> > > > +	int ret;
> > > > +
> > > > +	ret = i2c_smbus_read_i2c_block_data(client, AK09911_REG_WIA1,
> > > > +					    3, wia_val);
> > > 
> > > wia_val has just 2 bytes?! should be 2
> > > 
> > > > +	if (ret < 0) {
> > > > +		dev_err(&client->dev, "Error reading WIA\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	dev_dbg(&client->dev, "WIA %02x %02x\n", wia_val[0], wia_val[1]);
> > > > +
> > > > +	if (wia_val[0] != AK09911_WIA1_VALUE ||
> > > > +					wia_val[1] != AK09911_WIA2_VALUE) {
> > > > +		dev_err(&client->dev, "Device ak09911 not found\n");
> > > > +		return -ENODEV;
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int wait_conversion_complete_polled(struct ak09911_data *data)
> > > > +{
> > > > +	struct i2c_client *client = data->client;
> > > > +	u8 read_status;
> > > > +	u32 timeout_ms = AK09911_MAX_CONVERSION_TIMEOUT;
> > > > +	int ret;
> > > > +
> > > > +	/* Wait for the conversion to complete. */
> > > > +	while (timeout_ms) {
> > > > +		msleep_interruptible(AK09911_CONVERSION_DONE_POLL_TIME);
> > > > +		ret = i2c_smbus_read_byte_data(client, AK09911_REG_ST1);
> > > > +		if (ret < 0) {
> > > > +			dev_err(&client->dev, "Error in reading ST1\n");
> > > > +			return ret;
> > > > +		}
> > > > +		read_status = ret & 0x01;
> > > > +		if (read_status)
> > > > +			break;
> > > > +		timeout_ms -= AK09911_CONVERSION_DONE_POLL_TIME;
> > > > +	}
> > > > +	if (!timeout_ms) {
> > > > +		dev_err(&client->dev, "Conversion timeout happened\n");
> > > > +		return -EINVAL;
> > > 
> > > -EIO
> > > 
> > > > +	}
> > > > +
> > > > +	return read_status;
> > > > +}
> > > > +
> > > > +static int ak09911_read_axis(struct iio_dev *indio_dev, int index, int
> > > > *val)
> > > > +{
> > > > +	struct ak09911_data *data = iio_priv(indio_dev);
> > > > +	struct i2c_client *client = data->client;
> > > > +	int ret;
> > > > +	u16 meas_reg;
> > > > +	s16 raw;
> > > > +
> > > > +	mutex_lock(&data->lock);
> > > > +
> > > > +	ret = ak09911_set_mode(client,  AK09911_MODE_SNG_MEASURE);
> > > 
> > > extra space before AK09911_MODE
> > > 
> > > > +	if (ret < 0)
> > > > +		goto fn_exit;
> > > > +
> > > > +	ret = wait_conversion_complete_polled(data);
> > > > +	if (ret < 0)
> > > > +		goto fn_exit;
> > > > +
> > > > +	/* Read data */
> > > > +	ret = i2c_smbus_read_word_data(client, ak09911_index_to_reg[index]);
> > > > +	if (ret < 0) {
> > > > +		dev_err(&client->dev, "Read axis data fails\n");
> > > > +		goto fn_exit;
> > > > +	}
> > > > +	meas_reg = ret;
> > > > +
> > > > +	mutex_unlock(&data->lock);
> > > > +
> > > > +	/* Endian conversion of the measured values. */
> > > > +	raw = (s16) (le16_to_cpu(meas_reg));
> > > 
> > > needed?
> > > I think i2c_smbus_read_word_data() does the endianness conversion already
> > > 
> > 
> > This is not obvious to me. I see WORD_DATA is passed to algorithm drivers for
> > a size indicator.
> 
> see https://lkml.org/lkml/2011/6/22/280
> 
> my understanding is that i2c_smbus_read_word_data() transfers two bytes, 
> LOW byte first, from the I2C device
>  
> if the I2C device has the high byte first, use 
> i2c_smbus_read_word_swapped()
> 
> this has nothing to do with host endianness, i2c_smbus_read_word_data() is 
> responsible to convert LOW byte, HIGH byte to a word in host endianess
> 
> WORD is not a size indicator, but a data type indicator
> 
> see e.g. i2c-core.c, i2c_smbus_xfer_emulated(), circa line 2532
> 
> the ak8975 does it wrong IMHO, and should be fixed
> 
> > > > +
> > > > +	/* Clamp to valid range. */
> > > > +	raw = clamp_t(s16, raw, -8192, 8192);

this should be
clamp_t(s16, raw, -8192, 8191)

> > > > +	*val = raw;
> > > > +	return IIO_VAL_INT;
> > > > +
> > > > +fn_exit:
> > > > +	mutex_unlock(&data->lock);
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static int ak09911_read_raw(struct iio_dev *indio_dev,
> > > > +			   struct iio_chan_spec const *chan,
> > > > +			   int *val, int *val2,
> > > > +			   long mask)
> > > > +{
> > > > +	struct ak09911_data *data = iio_priv(indio_dev);
> > > > +
> > > > +	switch (mask) {
> > > > +	case IIO_CHAN_INFO_RAW:
> > > > +		return ak09911_read_axis(indio_dev, chan->address, val);
> > > > +	case IIO_CHAN_INFO_SCALE:
> > > > +		*val = 0;
> > > > +		*val2 = data->raw_to_gauss[chan->address];
> > > > +		return IIO_VAL_INT_PLUS_MICRO;
> > > > +	}
> > > > +
> > > > +	return -EINVAL;
> > > > +}
> > > > +
> > > > +#define AK09911_CHANNEL(axis, index)
> > > > \
> > > > +	{								\
> > > > +		.type = IIO_MAGN,					\
> > > > +		.modified = 1,						\
> > > > +		.channel2 = IIO_MOD_##axis,				\
> > > > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> > > > +			     BIT(IIO_CHAN_INFO_SCALE),			\
> > > > +		.address = index,					\
> > > > +	}
> > > > +
> > > > +static const struct iio_chan_spec ak09911_channels[] = {
> > > > +	AK09911_CHANNEL(X, 0), AK09911_CHANNEL(Y, 1), AK09911_CHANNEL(Z, 2),
> > > > +};
> > > > +
> > > > +static const struct iio_info ak09911_info = {
> > > > +	.read_raw = &ak09911_read_raw,
> > > > +	.driver_module = THIS_MODULE,
> > > > +};
> > > > +
> > > > +static const struct acpi_device_id ak_acpi_match[] = {
> > > > +	{"AK009911", 0},
> > > > +	{ },
> > > > +};
> > > > +MODULE_DEVICE_TABLE(acpi, ak_acpi_match);
> > > > +
> > > > +static int ak09911_probe(struct i2c_client *client,
> > > > +			const struct i2c_device_id *id)
> > > > +{
> > > > +	struct iio_dev *indio_dev;
> > > > +	struct ak09911_data *data;
> > > > +	char *name;
> > > > +	int ret;
> > > > +
> > > > +	ret = ak09911_verify_chip_id(client);
> > > > +	if (ret) {
> > > > +		dev_err(&client->dev, "AK00911 not detected\n");
> > > 
> > > -ENODEV?
> > > > +		return -ENOSYS;
> > > > +	}
> > > > +
> > > > +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> > > > +	if (indio_dev == NULL)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	data = iio_priv(indio_dev);
> > > > +	i2c_set_clientdata(client, indio_dev);
> > > > +
> > > > +	data->client = client;
> > > > +	mutex_init(&data->lock);
> > > > +
> > > > +	ret = ak09911_get_asa(client);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	if (id)
> > > > +		name = (char *) id->name;
> > > > +	else if (ACPI_HANDLE(&client->dev))
> > > > +		name = (char *)dev_name(&client->dev);
> > > > +	else
> > > > +		return -ENOSYS;
> > > > +
> > > > +	dev_dbg(&client->dev, "Asahi compass chip %s\n", name);
> > > > +
> > > > +	indio_dev->dev.parent = &client->dev;
> > > > +	indio_dev->channels = ak09911_channels;
> > > > +	indio_dev->num_channels = ARRAY_SIZE(ak09911_channels);
> > > > +	indio_dev->info = &ak09911_info;
> > > > +	indio_dev->name = id->name;
> > > > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > > > +	indio_dev->name = name;
> > > > +	ret = iio_device_register(indio_dev);
> > > > 
> > > devm_iio_device_register()
> > > 
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int ak09911_remove(struct i2c_client *client)
> > > > +{
> > > > +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> > > > +
> > > > +	iio_device_unregister(indio_dev);
> > > 
> > > can be dropped when using devm_iio_device_register()
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static const struct i2c_device_id ak09911_id[] = {
> > > > +	{"ak09911", 0},
> > > > +	{}
> > > > +};
> > > > +
> > > > +MODULE_DEVICE_TABLE(i2c, ak09911_id);
> > > > +
> > > > +static struct i2c_driver ak09911_driver = {
> > > > +	.driver = {
> > > > +		.name	= "ak09911",
> > > > +		.acpi_match_table = ACPI_PTR(ak_acpi_match),
> > > > +	},
> > > > +	.probe		= ak09911_probe,
> > > > +	.remove		= ak09911_remove,
> > > > +	.id_table	= ak09911_id,
> > > > +};
> > > > +module_i2c_driver(ak09911_driver);
> > > > +
> > > > +MODULE_AUTHOR("Srinivas Pandruvada
> > > > <srinivas.pandruvada@linux.intel.com>");
> > > > +MODULE_LICENSE("GPL v2");
> > > > +MODULE_DESCRIPTION("AK09911 Compass driver");
> > > > 
> > > 
> > Thanks,
> > Srinivas
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
