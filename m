Return-Path: <hdegoede@redhat.com>
Subject: Re: [PATCH] iio: accel: Add driver for the mCube MC3230 3-axis
 accelerometer
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20160911162907.22449-1-hdegoede@redhat.com>
 <alpine.DEB.2.02.1609111942500.28464@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <95a718cc-24c0-dfe9-6745-e3d933ba384b@redhat.com>
Date: Sun, 11 Sep 2016 20:59:29 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1609111942500.28464@pmeerw.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi,

On 11-09-16 19:47, Peter Meerwald-Stadler wrote:
>
>> Add an IIO driver for the mCube MC3230 3-axis accelerometer.
>
> comments below
>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
>>  drivers/iio/accel/Kconfig                          |  10 +
>>  drivers/iio/accel/Makefile                         |   1 +
>>  drivers/iio/accel/mc3230.c                         | 225 +++++++++++++++++++++
>>  4 files changed, 237 insertions(+)
>>  create mode 100644 drivers/iio/accel/mc3230.c
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
>> index badf5eb..fbbad64 100644
>> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
>> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
>> @@ -56,6 +56,7 @@ maxim,ds1050		5 Bit Programmable, Pulse-Width Modulator
>>  maxim,max1237		Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
>>  maxim,max6625		9-Bit/12-Bit Temperature Sensors with I²C-Compatible Serial Interface
>>  mc,rv3029c2		Real Time Clock Module with I2C-Bus
>> +mcube,mc3230		mCube 3-axis 8-bit digital accelerometer
>>  microchip,mcp4531-502	Microchip 7-bit Single I2C Digital Potentiometer (5k)
>>  microchip,mcp4531-103	Microchip 7-bit Single I2C Digital Potentiometer (10k)
>>  microchip,mcp4531-503	Microchip 7-bit Single I2C Digital Potentiometer (50k)
>> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
>> index 5630f23..3aee97d 100644
>> --- a/drivers/iio/accel/Kconfig
>> +++ b/drivers/iio/accel/Kconfig
>> @@ -138,6 +138,16 @@ config KXCJK1013
>>  	  To compile this driver as a module, choose M here: the module will
>>  	  be called kxcjk-1013.
>>
>> +config MC3230
>> +	tristate "mCube MC3230 Digital Accelerometer Driver"
>> +	depends on I2C
>> +	help
>> +	  Say yes here to build support for the mCube MC3230 low-g tri-axial
>> +	  digital accelerometer.
>> +
>> +	  To compile this driver as a module, choose M here: the
>> +	  module will be called mc3230.
>> +
>>  config MMA7455
>>  	tristate
>>  	select IIO_BUFFER
>> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
>> index e974841..07a0c72 100644
>> --- a/drivers/iio/accel/Makefile
>> +++ b/drivers/iio/accel/Makefile
>> @@ -13,6 +13,7 @@ obj-$(CONFIG_DMARD09)	+= dmard09.o
>>  obj-$(CONFIG_HID_SENSOR_ACCEL_3D) += hid-sensor-accel-3d.o
>>  obj-$(CONFIG_KXCJK1013) += kxcjk-1013.o
>>  obj-$(CONFIG_KXSD9)	+= kxsd9.o
>> +obj-$(CONFIG_MC3230)	+= mc3230.o
>>
>>  obj-$(CONFIG_MMA7455)		+= mma7455_core.o
>>  obj-$(CONFIG_MMA7455_I2C)	+= mma7455_i2c.o
>> diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
>> new file mode 100644
>> index 0000000..21127a9
>> --- /dev/null
>> +++ b/drivers/iio/accel/mc3230.c
>> @@ -0,0 +1,225 @@
>> +/**
>> + * mCube MC3230 3-Axis Accelerometer
>> + *
>> + * Copyright (c) 2016 Hans de Goede <hdegoede@redhat.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * IIO driver for mCube MC3230; 7-bit I2C address: 0x4c.
>> + */
>> +
>> +#include <linux/i2c.h>
>> +#include <linux/module.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
>> +
>> +#define MC3230_REG_XOUT			0x00
>> +#define MC3230_REG_YOUT			0x01
>> +#define MC3230_REG_ZOUT			0x02
>> +
>> +#define MC3230_REG_MODE			0x07
>> +#define MC3230_MODE_OPCON_MASK		0x03
>> +#define MC3230_MODE_OPCON_WAKE		0x01
>> +#define MC3230_MODE_OPCON_STANDBY	0x03
>> +
>> +#define MC3230_REG_CHIP_ID		0x18
>> +#define MC3230_CHIP_ID			0x01
>> +
>> +#define MC3230_REG_PRODUCT_CODE		0x3b
>> +#define MC3230_PRODUCT_CODE		0x19
>> +
>> +/*
>> + * The accelerometer has one measurement range:
>> + *
>> + * -1.5g - +1.5g (8-bit, signed)
>> + *
>> + * scale = (1.5 + 1.5) * 9.81 / (2^8 - 1)	= 0.115411765
>> + */
>> +
>> +#define MC3230_SCALE_AVAIL		"0.115411765"
>> +
>> +const int mc3230_nscale = 115411765;
>
> static

Ack.

>> +
>> +#define MC3230_CHANNEL(reg, axis) {	\
>> +	.type = IIO_ACCEL,	\
>> +	.address = reg,	\
>> +	.modified = 1,	\
>> +	.channel2 = IIO_MOD_##axis,	\
>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
>> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
>> +}
>> +
>> +static const struct iio_chan_spec mc3230_channels[] = {
>> +	MC3230_CHANNEL(MC3230_REG_XOUT, X),
>> +	MC3230_CHANNEL(MC3230_REG_YOUT, Y),
>> +	MC3230_CHANNEL(MC3230_REG_ZOUT, Z),
>> +};
>> +
>> +struct mc3230_data {
>> +	struct i2c_client *client;
>> +};
>> +
>> +static IIO_CONST_ATTR(in_accel_scale_available, MC3230_SCALE_AVAIL);
>> +
>> +static struct attribute *mc3230_attributes[] = {
>> +	&iio_const_attr_in_accel_scale_available.dev_attr.attr,
>> +	NULL,
>> +};
>> +
>> +static const struct attribute_group mc3230_attribute_group = {
>> +	.attrs = mc3230_attributes
>> +};
>> +
>> +static int mc3230_set_opcon(struct mc3230_data *data, int opcon)
>> +{
>> +	int ret;
>> +	struct i2c_client *client = data->client;
>> +
>
> guess we want locking here

This register only gets touched by this function, and this
function only gets called:

-pre iio_device_register
-post iio_device_unregister
-on suspend/resume

So I do not see what it could race with.

Regards,

Hans




>
>> +	ret = i2c_smbus_read_byte_data(client, MC3230_REG_MODE);
>> +	if (ret < 0) {
>> +		dev_err(&client->dev, "failed to read mode reg: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret &= ~MC3230_MODE_OPCON_MASK;
>> +	ret |= opcon;
>> +
>> +	ret = i2c_smbus_write_byte_data(client, MC3230_REG_MODE, ret);
>> +	if (ret < 0) {
>> +		dev_err(&client->dev, "failed to write mode reg: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int mc3230_read_raw(struct iio_dev *indio_dev,
>> +				struct iio_chan_spec const *chan,
>> +				int *val, int *val2, long mask)
>> +{
>> +	struct mc3230_data *data = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		ret = i2c_smbus_read_byte_data(data->client, chan->address);
>> +		if (ret < 0)
>> +			return ret;
>> +		*val = sign_extend32(ret, 7);
>> +		return IIO_VAL_INT;
>> +	case IIO_CHAN_INFO_SCALE:
>> +		*val = 0;
>> +		*val2 = mc3230_nscale;
>> +		return IIO_VAL_INT_PLUS_NANO;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static const struct iio_info mc3230_info = {
>> +	.driver_module	= THIS_MODULE,
>> +	.read_raw	= mc3230_read_raw,
>> +	.attrs		= &mc3230_attribute_group,
>> +};
>> +
>> +static int mc3230_probe(struct i2c_client *client,
>> +			const struct i2c_device_id *id)
>> +{
>> +	int ret;
>> +	struct iio_dev *indio_dev;
>> +	struct mc3230_data *data;
>> +
>> +	/* First check chip-id and product-id */
>> +	ret = i2c_smbus_read_byte_data(client, MC3230_REG_CHIP_ID);
>> +	if (ret != MC3230_CHIP_ID)
>> +		return (ret < 0) ? ret : -ENODEV;
>> +
>> +	ret = i2c_smbus_read_byte_data(client, MC3230_REG_PRODUCT_CODE);
>> +	if (ret != MC3230_PRODUCT_CODE)
>> +		return (ret < 0) ? ret : -ENODEV;
>> +
>> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>> +	if (!indio_dev) {
>> +		dev_err(&client->dev, "iio allocation failed!\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	data = iio_priv(indio_dev);
>> +	data->client = client;
>> +	i2c_set_clientdata(client, indio_dev);
>> +
>> +	indio_dev->dev.parent = &client->dev;
>> +	indio_dev->info = &mc3230_info;
>> +	indio_dev->name = "mc3230";
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->channels = mc3230_channels;
>> +	indio_dev->num_channels = ARRAY_SIZE(mc3230_channels);
>> +
>> +	ret = mc3230_set_opcon(data, MC3230_MODE_OPCON_WAKE);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = iio_device_register(indio_dev);
>> +	if (ret < 0) {
>> +		dev_err(&client->dev, "device_register failed\n");
>> +		mc3230_set_opcon(data, MC3230_MODE_OPCON_STANDBY);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int mc3230_remove(struct i2c_client *client)
>> +{
>> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>> +
>> +	iio_device_unregister(indio_dev);
>> +
>> +	return mc3230_set_opcon(iio_priv(indio_dev), MC3230_MODE_OPCON_STANDBY);
>> +}
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +static int mc3230_suspend(struct device *dev)
>> +{
>> +	struct mc3230_data *data;
>> +
>> +	data = iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
>> +
>> +	return mc3230_set_opcon(data, MC3230_MODE_OPCON_STANDBY);
>> +}
>> +
>> +static int mc3230_resume(struct device *dev)
>> +{
>> +	struct mc3230_data *data;
>> +
>> +	data = iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
>> +
>> +	return mc3230_set_opcon(data, MC3230_MODE_OPCON_WAKE);
>> +}
>> +#endif
>> +
>> +static SIMPLE_DEV_PM_OPS(mc3230_pm_ops, mc3230_suspend, mc3230_resume);
>> +
>> +static const struct i2c_device_id mc3230_i2c_id[] = {
>> +	{"mc3230", 0},
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(i2c, mc3230_i2c_id);
>> +
>> +static struct i2c_driver mc3230_driver = {
>> +	.driver = {
>> +		.name = "mc3230",
>> +		.pm = &mc3230_pm_ops,
>> +	},
>> +	.probe		= mc3230_probe,
>> +	.remove		= mc3230_remove,
>> +	.id_table	= mc3230_i2c_id,
>> +};
>> +
>> +module_i2c_driver(mc3230_driver);
>> +
>> +MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
>> +MODULE_DESCRIPTION("mCube MC3230 3-Axis Accelerometer driver");
>> +MODULE_LICENSE("GPL v2");
>>
>
