Return-Path: <knaack.h@gmx.de>
Message-ID: <5458003C.90107@gmx.de>
Date: Mon, 03 Nov 2014 23:22:52 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Gwendal Grignou <gwendal@chromium.org>,
 srinivas.pandruvada@linux.intel.com, jic23@kernel.org
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: ak8975: Add AKM0991x support.
References: <1414620097-6787-1-git-send-email-gwendal@chromium.org> <1414620097-6787-2-git-send-email-gwendal@chromium.org>
In-Reply-To: <1414620097-6787-2-git-send-email-gwendal@chromium.org>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-iio@vger.kernel.org>

Gwendal Grignou schrieb am 29.10.2014 23:01:
> File and config id remains the same, but driver is now named akxxxx.
> Move AKM09911 support in the same file.
> 
Find some comments inline.
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/iio/magnetometer/Kconfig   |  19 +-
>  drivers/iio/magnetometer/Makefile  |   1 -
>  drivers/iio/magnetometer/ak09911.c | 326 -------------------
>  drivers/iio/magnetometer/ak8975.c  | 627 ++++++++++++++++++++++++++-----------
>  4 files changed, 448 insertions(+), 525 deletions(-)
>  delete mode 100644 drivers/iio/magnetometer/ak09911.c
> 
> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> index b2dba9e..67f005d 100644
> --- a/drivers/iio/magnetometer/Kconfig
> +++ b/drivers/iio/magnetometer/Kconfig
> @@ -6,26 +6,15 @@
>  menu "Magnetometer sensors"
>  
>  config AK8975
> -	tristate "Asahi Kasei AK8975 3-Axis Magnetometer"
> +	tristate "Asahi Kasei AK 3-Axis Magnetometer"
>  	depends on I2C
>  	depends on GPIOLIB
>  	help
> -	  Say yes here to build support for Asahi Kasei AK8975 3-Axis
> -	  Magnetometer. This driver can also support AK8963, if i2c
> -	  device name is identified as ak8963.
> +	  Say yes here to build support for Asahi Kasei AK8975, AK8963,
> +	  AK09911 or AK09912 3-Axis Magnetometer.
>  
>  	  To compile this driver as a module, choose M here: the module
> -	  will be called ak8975.
> -
> -config AK09911
> -	tristate "Asahi Kasei AK09911 3-axis Compass"
> -	depends on I2C
> -	help
> -	  Say yes here to build support for Asahi Kasei AK09911 3-Axis
> -	  Magnetometer.
> -
> -	  To compile this driver as a module, choose M here: the module
> -	  will be called ak09911.
> +	  will be called akxxxx.
>  
>  config MAG3110
>  	tristate "Freescale MAG3110 3-Axis Magnetometer"
> diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
> index b91315e..0f5d3c9 100644
> --- a/drivers/iio/magnetometer/Makefile
> +++ b/drivers/iio/magnetometer/Makefile
> @@ -3,7 +3,6 @@
>  #
>  
>  # When adding new entries keep the list in alphabetical order
> -obj-$(CONFIG_AK09911)	+= ak09911.o
>  obj-$(CONFIG_AK8975)	+= ak8975.o
>  obj-$(CONFIG_MAG3110)	+= mag3110.o
>  obj-$(CONFIG_HID_SENSOR_MAGNETOMETER_3D) += hid-sensor-magn-3d.o
> diff --git a/drivers/iio/magnetometer/ak09911.c b/drivers/iio/magnetometer/ak09911.c
> deleted file mode 100644
> index b2bc942..0000000
> --- a/drivers/iio/magnetometer/ak09911.c
> +++ /dev/null
> @@ -1,326 +0,0 @@
> -/*
> - * AK09911 3-axis compass driver
> - * Copyright (c) 2014, Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU General Public License,
> - * version 2, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> - * more details.
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/init.h>
> -#include <linux/types.h>
> -#include <linux/slab.h>
> -#include <linux/delay.h>
> -#include <linux/i2c.h>
> -#include <linux/acpi.h>
> -#include <linux/iio/iio.h>
> -
> -#define AK09911_REG_WIA1		0x00
> -#define AK09911_REG_WIA2		0x01
> -#define AK09911_WIA1_VALUE		0x48
> -#define AK09911_WIA2_VALUE		0x05
> -
> -#define AK09911_REG_ST1			0x10
> -#define AK09911_REG_HXL			0x11
> -#define AK09911_REG_HXH			0x12
> -#define AK09911_REG_HYL			0x13
> -#define AK09911_REG_HYH			0x14
> -#define AK09911_REG_HZL			0x15
> -#define AK09911_REG_HZH			0x16
> -
> -#define AK09911_REG_ASAX		0x60
> -#define AK09911_REG_ASAY		0x61
> -#define AK09911_REG_ASAZ		0x62
> -
> -#define AK09911_REG_CNTL1		0x30
> -#define AK09911_REG_CNTL2		0x31
> -#define AK09911_REG_CNTL3		0x32
> -
> -#define AK09911_MODE_SNG_MEASURE	0x01
> -#define AK09911_MODE_SELF_TEST		0x10
> -#define AK09911_MODE_FUSE_ACCESS	0x1F
> -#define AK09911_MODE_POWERDOWN		0x00
> -#define AK09911_RESET_DATA		0x01
> -
> -#define AK09911_REG_CNTL1		0x30
> -#define AK09911_REG_CNTL2		0x31
> -#define AK09911_REG_CNTL3		0x32
> -
> -#define AK09911_RAW_TO_GAUSS(asa)	((((asa) + 128) * 6000) / 256)
> -
> -#define AK09911_MAX_CONVERSION_TIMEOUT_MS	500
> -#define AK09911_CONVERSION_DONE_POLL_TIME_MS	10
> -
> -struct ak09911_data {
> -	struct i2c_client	*client;
> -	struct mutex		lock;
> -	u8			asa[3];
> -	long			raw_to_gauss[3];
> -};
> -
> -static const int ak09911_index_to_reg[] = {
> -	AK09911_REG_HXL, AK09911_REG_HYL, AK09911_REG_HZL,
> -};
> -
> -static int ak09911_set_mode(struct i2c_client *client, u8 mode)
> -{
> -	int ret;
> -
> -	switch (mode) {
> -	case AK09911_MODE_SNG_MEASURE:
> -	case AK09911_MODE_SELF_TEST:
> -	case AK09911_MODE_FUSE_ACCESS:
> -	case AK09911_MODE_POWERDOWN:
> -		ret = i2c_smbus_write_byte_data(client,
> -						AK09911_REG_CNTL2, mode);
> -		if (ret < 0) {
> -			dev_err(&client->dev, "set_mode error\n");
> -			return ret;
> -		}
> -		/* After mode change wait atleast 100us */
> -		usleep_range(100, 500);
> -		break;
> -	default:
> -		dev_err(&client->dev,
> -			"%s: Unknown mode(%d).", __func__, mode);
> -		return -EINVAL;
> -	}
> -
> -	return ret;
> -}
> -
> -/* Get Sensitivity Adjustment value */
> -static int ak09911_get_asa(struct i2c_client *client)
> -{
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -	struct ak09911_data *data = iio_priv(indio_dev);
> -	int ret;
> -
> -	ret = ak09911_set_mode(client, AK09911_MODE_FUSE_ACCESS);
> -	if (ret < 0)
> -		return ret;
> -
> -	/* Get asa data and store in the device data. */
> -	ret = i2c_smbus_read_i2c_block_data(client, AK09911_REG_ASAX,
> -					    3, data->asa);
> -	if (ret < 0) {
> -		dev_err(&client->dev, "Not able to read asa data\n");
> -		return ret;
> -	}
> -
> -	ret = ak09911_set_mode(client,  AK09911_MODE_POWERDOWN);
> -	if (ret < 0)
> -		return ret;
> -
> -	data->raw_to_gauss[0] = AK09911_RAW_TO_GAUSS(data->asa[0]);
> -	data->raw_to_gauss[1] = AK09911_RAW_TO_GAUSS(data->asa[1]);
> -	data->raw_to_gauss[2] = AK09911_RAW_TO_GAUSS(data->asa[2]);
> -
> -	return 0;
> -}
> -
> -static int ak09911_verify_chip_id(struct i2c_client *client)
> -{
> -	u8 wia_val[2];
> -	int ret;
> -
> -	ret = i2c_smbus_read_i2c_block_data(client, AK09911_REG_WIA1,
> -					    2, wia_val);
> -	if (ret < 0) {
> -		dev_err(&client->dev, "Error reading WIA\n");
> -		return ret;
> -	}
> -
> -	dev_dbg(&client->dev, "WIA %02x %02x\n", wia_val[0], wia_val[1]);
> -
> -	if (wia_val[0] != AK09911_WIA1_VALUE ||
> -		wia_val[1] != AK09911_WIA2_VALUE) {
> -		dev_err(&client->dev, "Device ak09911 not found\n");
> -		return -ENODEV;
> -	}
> -
> -	return 0;
> -}
> -
> -static int wait_conversion_complete_polled(struct ak09911_data *data)
> -{
> -	struct i2c_client *client = data->client;
> -	u8 read_status;
> -	u32 timeout_ms = AK09911_MAX_CONVERSION_TIMEOUT_MS;
> -	int ret;
> -
> -	/* Wait for the conversion to complete. */
> -	while (timeout_ms) {
> -		msleep_interruptible(AK09911_CONVERSION_DONE_POLL_TIME_MS);
> -		ret = i2c_smbus_read_byte_data(client, AK09911_REG_ST1);
> -		if (ret < 0) {
> -			dev_err(&client->dev, "Error in reading ST1\n");
> -			return ret;
> -		}
> -		read_status = ret & 0x01;
> -		if (read_status)
> -			break;
> -		timeout_ms -= AK09911_CONVERSION_DONE_POLL_TIME_MS;
> -	}
> -	if (!timeout_ms) {
> -		dev_err(&client->dev, "Conversion timeout happened\n");
> -		return -EIO;
> -	}
> -
> -	return read_status;
> -}
> -
> -static int ak09911_read_axis(struct iio_dev *indio_dev, int index, int *val)
> -{
> -	struct ak09911_data *data = iio_priv(indio_dev);
> -	struct i2c_client *client = data->client;
> -	int ret;
> -
> -	mutex_lock(&data->lock);
> -
> -	ret = ak09911_set_mode(client, AK09911_MODE_SNG_MEASURE);
> -	if (ret < 0)
> -		goto fn_exit;
> -
> -	ret = wait_conversion_complete_polled(data);
> -	if (ret < 0)
> -		goto fn_exit;
> -
> -	/* Read data */
> -	ret = i2c_smbus_read_word_data(client, ak09911_index_to_reg[index]);
> -	if (ret < 0) {
> -		dev_err(&client->dev, "Read axis data fails\n");
> -		goto fn_exit;
> -	}
> -
> -	mutex_unlock(&data->lock);
> -
> -	/* Clamp to valid range. */
> -	*val = sign_extend32(clamp_t(s16, ret, -8192, 8191), 13);
> -
> -	return IIO_VAL_INT;
> -
> -fn_exit:
> -	mutex_unlock(&data->lock);
> -
> -	return ret;
> -}
> -
> -static int ak09911_read_raw(struct iio_dev *indio_dev,
> -			    struct iio_chan_spec const *chan,
> -			    int *val, int *val2,
> -			    long mask)
> -{
> -	struct ak09911_data *data = iio_priv(indio_dev);
> -
> -	switch (mask) {
> -	case IIO_CHAN_INFO_RAW:
> -		return ak09911_read_axis(indio_dev, chan->address, val);
> -	case IIO_CHAN_INFO_SCALE:
> -		*val = 0;
> -		*val2 = data->raw_to_gauss[chan->address];
> -		return IIO_VAL_INT_PLUS_MICRO;
> -	}
> -
> -	return -EINVAL;
> -}
> -
> -#define AK09911_CHANNEL(axis, index)					\
> -	{								\
> -		.type = IIO_MAGN,					\
> -		.modified = 1,						\
> -		.channel2 = IIO_MOD_##axis,				\
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> -			     BIT(IIO_CHAN_INFO_SCALE),			\
> -		.address = index,					\
> -	}
> -
> -static const struct iio_chan_spec ak09911_channels[] = {
> -	AK09911_CHANNEL(X, 0), AK09911_CHANNEL(Y, 1), AK09911_CHANNEL(Z, 2),
> -};
> -
> -static const struct iio_info ak09911_info = {
> -	.read_raw = &ak09911_read_raw,
> -	.driver_module = THIS_MODULE,
> -};
> -
> -static const struct acpi_device_id ak_acpi_match[] = {
> -	{"AK009911", 0},
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(acpi, ak_acpi_match);
> -
> -static int ak09911_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> -{
> -	struct iio_dev *indio_dev;
> -	struct ak09911_data *data;
> -	const char *name;
> -	int ret;
> -
> -	ret = ak09911_verify_chip_id(client);
> -	if (ret) {
> -		dev_err(&client->dev, "AK00911 not detected\n");
> -		return -ENODEV;
> -	}
> -
> -	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> -	if (indio_dev == NULL)
> -		return -ENOMEM;
> -
> -	data = iio_priv(indio_dev);
> -	i2c_set_clientdata(client, indio_dev);
> -
> -	data->client = client;
> -	mutex_init(&data->lock);
> -
> -	ret = ak09911_get_asa(client);
> -	if (ret)
> -		return ret;
> -
> -	if (id)
> -		name = id->name;
> -	else if (ACPI_HANDLE(&client->dev))
> -		name = dev_name(&client->dev);
> -	else
> -		return -ENODEV;
> -
> -	dev_dbg(&client->dev, "Asahi compass chip %s\n", name);
> -
> -	indio_dev->dev.parent = &client->dev;
> -	indio_dev->channels = ak09911_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(ak09911_channels);
> -	indio_dev->info = &ak09911_info;
> -	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->name = name;
> -
> -	return devm_iio_device_register(&client->dev, indio_dev);
> -}
> -
> -static const struct i2c_device_id ak09911_id[] = {
> -	{"ak09911", 0},
> -	{}
> -};
> -
> -MODULE_DEVICE_TABLE(i2c, ak09911_id);
> -
> -static struct i2c_driver ak09911_driver = {
> -	.driver = {
> -		.name	= "ak09911",
> -		.acpi_match_table = ACPI_PTR(ak_acpi_match),
> -	},
> -	.probe		= ak09911_probe,
> -	.id_table	= ak09911_id,
> -};
> -module_i2c_driver(ak09911_driver);
> -
> -MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
> -MODULE_LICENSE("GPL v2");
> -MODULE_DESCRIPTION("AK09911 Compass driver");
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index bf5ef07..190c21c 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -35,9 +35,10 @@
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +
>  /*
> - * Register definitions, as well as various shifts and masks to get at the
> - * individual fields of the registers.
> + * AK_8975 Register definitions, as well as various shifts and masks to get
> + * at the individual fields of the registers.
>   */
>  #define AK8975_REG_WIA			0x00
>  #define AK8975_DEVICE_ID		0x48
> @@ -62,12 +63,12 @@
>  #define AK8975_REG_ST2_HOFL_MASK	(1 << AK8975_REG_ST2_HOFL_SHIFT)
>  
>  #define AK8975_REG_CNTL			0x0A
> +#define AK8975_REG_CNTL_MODE_POWER_DOWN	0x00
> +#define AK8975_REG_CNTL_MODE_ONCE	0x01
> +#define AK8975_REG_CNTL_MODE_SELF_TEST	0x08
> +#define AK8975_REG_CNTL_MODE_FUSE_ROM	0x0F
>  #define AK8975_REG_CNTL_MODE_SHIFT	0
>  #define AK8975_REG_CNTL_MODE_MASK	(0xF << AK8975_REG_CNTL_MODE_SHIFT)
> -#define AK8975_REG_CNTL_MODE_POWER_DOWN	0
> -#define AK8975_REG_CNTL_MODE_ONCE	1
> -#define AK8975_REG_CNTL_MODE_SELF_TEST	8
> -#define AK8975_REG_CNTL_MODE_FUSE_ROM	0xF
>  
>  #define AK8975_REG_RSVC			0x0B
>  #define AK8975_REG_ASTC			0x0C
> @@ -81,59 +82,369 @@
>  #define AK8975_MAX_REGS			AK8975_REG_ASAZ
>  
>  /*
> - * Miscellaneous values.
> + * AK09912 Register definitions
> + */
> +#define AK09912_REG_WIA1		0x00
> +#define AK09912_COMPANY_ID		0x48
> +#define AK09912_REG_WIA2		0x01
> +#define AK09912_DEVICE_ID		0x04
> +#define AK09911_DEVICE_ID		0x05
> +
> +#define AK09912_REG_INFO1		0x02
> +#define AK09912_REG_INFO2		0x03
These two registers only exist in AK09911.
> +
> +#define AK09912_REG_ST1			0x10
> +
> +#define AK09912_REG_ST1_DRDY_SHIFT	0
> +#define AK09912_REG_ST1_DRDY_MASK	(1 << AK09912_REG_ST1_DRDY_SHIFT)
> +
> +#define AK09912_REG_HXL			0x11
> +#define AK09912_REG_HXH			0x12
> +#define AK09912_REG_HYL			0x13
> +#define AK09912_REG_HYH			0x14
> +#define AK09912_REG_HZL			0x15
> +#define AK09912_REG_HZH			0x16
> +#define AK09912_REG_TMPS		0x17
> +
> +#define AK09912_REG_ST2			0x18
> +#define AK09912_REG_ST2_HOFL_SHIFT	3
> +#define AK09912_REG_ST2_HOFL_MASK	(1 << AK09912_REG_ST2_HOFL_SHIFT)
> +
> +#define AK09912_REG_CNTL1		0x30
> +
> +
> +#define AK09912_REG_CNTL2		0x31
> +#define AK09912_REG_CNTL_MODE_POWER_DOWN	0x00
> +#define AK09912_REG_CNTL_MODE_ONCE	0x01
> +#define AK09912_REG_CNTL_MODE_SELF_TEST	0x10
> +#define AK09912_REG_CNTL_MODE_FUSE_ROM	0x1F
> +#define AK09912_REG_CNTL2_MODE_SHIFT	0
> +#define AK09912_REG_CNTL2_MODE_MASK	(0x1F << AK09912_REG_CNTL2_MODE_SHIFT)
> +
> +#define AK09912_REG_CNTL3		0x32
> +
> +#define AK09912_REG_TS1			0x33
> +#define AK09912_REG_TS2			0x34
> +#define AK09912_REG_TS3			0x35
> +#define AK09912_REG_I2CDIS		0x36
> +#define AK09912_REG_TS4			0x37
> +
> +#define AK09912_REG_ASAX		0x60
> +#define AK09912_REG_ASAY		0x61
> +#define AK09912_REG_ASAZ		0x62
> +
> +#define AK09912_MAX_REGS		AK09912_REG_ASAZ
> +
> +
> +/*
> + * Precalculate scale factor (in Gauss units) for each axis and
> + * store in the device data.
> + *
> + * This scale factor is axis-dependent, and is derived from 3 calibration
> + * factors ASA(x), ASA(y), and ASA(z).
> + *
> + * These ASA values are read from the sensor device at start of day, and
> + * cached in the device context struct.
> + *
> + * Adjusting the flux value with the sensitivity adjustment value should be
> + * done via the following formula:
> + *
> + * Hadj = H * ( ( ( (ASA-128)*0.5 ) / 128 ) + 1 )
> + * where H is the raw value, ASA is the sensitivity adjustment, and Hadj
> + * is the resultant adjusted value.
> + *
> + * We reduce the formula to:
> + *
> + * Hadj = H * (ASA + 128) / 256
> + *
> + * H is in the range of -4096 to 4095.  The magnetometer has a range of
> + * +-1229uT.  To go from the raw value to uT is:
> + *
> + * HuT = H * 1229/4096, or roughly, 3/10.
> + *
> + * Since 1uT = 0.01 gauss, our final scale factor becomes:
> + *
> + * Hadj = H * ((ASA + 128) / 256) * 3/10 * 1/100
> + * Hadj = H * ((ASA + 128) * 0.003) / 256
> + *
> + * Since ASA doesn't change, we cache the resultant scale factor into the
> + * device context in ak8975_setup().
> + */
> +long ak8975_raw_to_gauss(uint16_t data)
You are using types like u16 later in your code as well, so just be consistent. u16 is commonly used and shorter/easier.
> +{
> +	return (((long)data + 128) * 3000) / 256;
I like the verbose explanation, but I somehow missed the part, where 0.003 turned into 3000.
> +}
> +
> +/*
> + * For AK8963, same calculation, except the device is less sensitive:
> + *
> + * H is in the range of +-8190.  The magnetometer has a range of
> + * +-4912uT.  To go from the raw value to uT is:
> + *
> + * HuT = H * 4912/8190, or roughly, 6/10, instead of 3/10.
> + */
> +long ak8963_09911_raw_to_gauss(uint16_t data)
> +{
> +	return (((long)data + 128) * 6000) / 256;
> +}
> +
> +/*
> + * For AK09912, same calculation, except the device is more sensitive:
> + *
> + * H is in the range of -32752 to 32752.  The magnetometer has a range of
> + * +-4912uT.  To go from the raw value to uT is:
> + *
> + * HuT = H * 4912/32752, or roughly, 3/20, instead of 3/10.
> + */
> +long ak09912_raw_to_gauss(uint16_t data)
> +{
> +	return (((long)data + 128) * 1500) / 256;
> +}
> +
> +/*
> + * Return 0 if the i2c device is supported,
> + * return a negative error number otherwise
>   */
> -#define AK8975_MAX_CONVERSION_TIMEOUT	500
> -#define AK8975_CONVERSION_DONE_POLL_TIME 10
> -#define AK8975_DATA_READY_TIMEOUT	((100*HZ)/1000)
> -#define RAW_TO_GAUSS_8975(asa) ((((asa) + 128) * 3000) / 256)
> -#define RAW_TO_GAUSS_8963(asa) ((((asa) + 128) * 6000) / 256)
> -
> -/* Compatible Asahi Kasei Compass parts */
> -enum asahi_compass_chipset {
> +int ak09912_who_i_am(struct i2c_client *client)
> +{
> +	u8 wia_val[2];
> +	int ret;
> +
> +	ret = i2c_smbus_read_i2c_block_data(client, AK09912_REG_WIA1,
> +					    2, wia_val);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Error reading WIA\n");
> +		return ret;
> +	}
> +
> +	if (wia_val[0] != AK09912_COMPANY_ID ||
> +		wia_val[1] != AK09912_DEVICE_ID) {
> +		dev_err(&client->dev, "Device ak09912 not found\n");
> +		return -ENODEV;
> +	}
> +	return 0;
> +}
> +
> +int ak09911_who_i_am(struct i2c_client *client)
> +{
> +	u8 wia_val[2];
> +	int ret;
> +
> +	ret = i2c_smbus_read_i2c_block_data(client, AK09912_REG_WIA1,
> +					    2, wia_val);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Error reading WIA\n");
> +		return ret;
> +	}
> +
> +	if (wia_val[0] != AK09912_COMPANY_ID ||
> +		wia_val[1] != AK09912_DEVICE_ID) {
This needs to be compared against AK09911_DEVICE_ID.
> +		dev_err(&client->dev, "Device ak09911 not found\n");
> +		return -ENODEV;
> +	}
> +	return 0;
> +}
> +
> +int ak8975_8963_who_i_am(struct i2c_client *client)
> +{
> +	int device_id;
> +	int ret;
> +	/* Confirm that the device we're talking to is really an AK8975. */
> +	ret = i2c_smbus_read_byte_data(client, AK8975_REG_WIA);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Error reading WIA\n");
> +		return ret;
> +	}
> +	device_id = ret;
> +	if (device_id != AK8975_DEVICE_ID) {
> +		dev_err(&client->dev, "Device ak8975 not found\n");
> +		return -ENODEV;
> +	}
> +	return 0;
> +}
> +
Why not have one generic function with second parameter ak_type? Thus commonly checking WIA for 0x48, and only for ak091x for a valid WIA2?
> +enum ak_type {
>  	AK8975,
>  	AK8963,
> +	AK09911,
> +	AK09912,
> +	AK_MAX_TYPE
> +};
> +
> +enum ak_ctrl_reg_addr {
> +	ST1,
> +	ST2,
> +	CNTL,
> +	ASA_BASE,
> +	MAX_REGS,
> +	REGS_END,
> +};
> +
> +enum ak_ctrl_reg_mask {
> +	ST1_DRDY,
> +	ST2_HOFL,
> +	ST2_DERR,
> +	CNTL_MODE,
> +	MASK_END,
> +};
> +
> +enum ak_ctrl_mode {
> +	POWER_DOWN,
> +	MODE_ONCE,
> +	SELF_TEST,
> +	FUSE_ROM,
> +	MODE_END,
> +};
> +
> +struct akxxxx_def {
> +	int (*who_i_am)(struct i2c_client *client);
> +	long (*raw_to_gauss)(uint16_t data);
> +	uint8_t ctrl_regs[REGS_END];
> +	uint8_t ctrl_masks[MASK_END];
> +	uint8_t ctrl_modes[MODE_END];
> +	uint8_t data_regs[3];
Just use u8 and u16.
> +} akxxxx_def_array[AK_MAX_TYPE] = {
> +{
> +	.who_i_am = ak8975_8963_who_i_am,
> +	.raw_to_gauss = ak8975_raw_to_gauss,
> +	.ctrl_regs = {
> +		AK8975_REG_ST1,
> +		AK8975_REG_ST2,
> +		AK8975_REG_CNTL,
> +		AK8975_REG_ASAX,
> +		AK8975_MAX_REGS},
> +	.ctrl_masks = {
> +		AK8975_REG_ST1_DRDY_MASK,
> +		AK8975_REG_ST2_HOFL_MASK,
> +		AK8975_REG_ST2_DERR_MASK,
> +		AK8975_REG_CNTL_MODE_MASK},
> +	.ctrl_modes = {
> +		AK8975_REG_CNTL_MODE_POWER_DOWN,
> +		AK8975_REG_CNTL_MODE_ONCE,
> +		AK8975_REG_CNTL_MODE_SELF_TEST,
> +		AK8975_REG_CNTL_MODE_FUSE_ROM},
> +	.data_regs = {
> +		AK8975_REG_HXL,
> +		AK8975_REG_HYL,
> +		AK8975_REG_HZL},
> +},
> +{
> +	.who_i_am = ak8975_8963_who_i_am,
> +	.raw_to_gauss = ak8963_09911_raw_to_gauss,
> +	.ctrl_regs = {
> +		AK8975_REG_ST1,
> +		AK8975_REG_ST2,
> +		AK8975_REG_CNTL,
> +		AK8975_REG_ASAX,
> +		AK8975_MAX_REGS},
> +	.ctrl_masks = {
> +		AK8975_REG_ST1_DRDY_MASK,
> +		AK8975_REG_ST2_HOFL_MASK,
> +		AK8975_REG_ST2_DERR_MASK,
This device doesn't have DERR.
> +		AK8975_REG_CNTL_MODE_MASK},
> +	.ctrl_modes = {
> +		AK8975_REG_CNTL_MODE_POWER_DOWN,
> +		AK8975_REG_CNTL_MODE_ONCE,
> +		AK8975_REG_CNTL_MODE_SELF_TEST,
> +		AK8975_REG_CNTL_MODE_FUSE_ROM},
> +	.data_regs = {
> +		AK8975_REG_HXL,
> +		AK8975_REG_HYL,
> +		AK8975_REG_HZL},
> +},
> +{
> +	.who_i_am = ak09911_who_i_am,
> +	.raw_to_gauss = ak8963_09911_raw_to_gauss,
> +	.ctrl_regs = {
> +		AK09912_REG_ST1,
> +		AK09912_REG_ST2,
> +		AK09912_REG_CNTL2,
> +		AK09912_REG_ASAX,
> +		AK09912_MAX_REGS},
> +	.ctrl_masks = {
> +		AK09912_REG_ST1_DRDY_MASK,
> +		AK09912_REG_ST2_HOFL_MASK,
> +		0,
> +		AK09912_REG_CNTL2_MODE_MASK},
> +	.ctrl_modes = {
> +		AK09912_REG_CNTL_MODE_POWER_DOWN,
> +		AK09912_REG_CNTL_MODE_ONCE,
> +		AK09912_REG_CNTL_MODE_SELF_TEST,
> +		AK09912_REG_CNTL_MODE_FUSE_ROM},
> +	.data_regs = {
> +		AK09912_REG_HXL,
> +		AK09912_REG_HYL,
> +		AK09912_REG_HZL},
> +},
> +{
> +	.who_i_am = ak09912_who_i_am,
> +	.raw_to_gauss = ak09912_raw_to_gauss,
> +	.ctrl_regs = {
> +		AK09912_REG_ST1,
> +		AK09912_REG_ST2,
> +		AK09912_REG_CNTL2,
> +		AK09912_REG_ASAX,
> +		AK09912_MAX_REGS},
> +	.ctrl_masks = {
> +		AK09912_REG_ST1_DRDY_MASK,
> +		AK09912_REG_ST2_HOFL_MASK,
> +		0,
> +		AK09912_REG_CNTL2_MODE_MASK},
> +	.ctrl_modes = {
> +		AK09912_REG_CNTL_MODE_POWER_DOWN,
> +		AK09912_REG_CNTL_MODE_ONCE,
> +		AK09912_REG_CNTL_MODE_SELF_TEST,
> +		AK09912_REG_CNTL_MODE_FUSE_ROM},
> +	.data_regs = {
> +		AK09912_REG_HXL,
> +		AK09912_REG_HYL,
> +		AK09912_REG_HZL},
> +}
>  };
>  
>  /*
> + * Miscellaneous values.
> + */
> +#define AKXXXX_MAX_CONVERSION_TIMEOUT	500
> +#define AKXXXX_CONVERSION_DONE_POLL_TIME 10
> +#define AKXXXX_DATA_READY_TIMEOUT	((100*HZ)/1000)
These definitions should be moved up to the other ones.
> +
> +
> +/*
>   * Per-instance context data for the device.
>   */
> -struct ak8975_data {
> +struct akxxxx_data {
>  	struct i2c_client	*client;
> +	struct akxxxx_def       *def;
>  	struct attribute_group	attrs;
>  	struct mutex		lock;
>  	u8			asa[3];
>  	long			raw_to_gauss[3];
> -	u8			reg_cache[AK8975_MAX_REGS];
>  	int			eoc_gpio;
>  	int			eoc_irq;
>  	wait_queue_head_t	data_ready_queue;
>  	unsigned long		flags;
> -	enum asahi_compass_chipset chipset;
> -};
> -
> -static const int ak8975_index_to_reg[] = {
> -	AK8975_REG_HXL, AK8975_REG_HYL, AK8975_REG_HZL,
> +	u8			cntl_cache;
>  };
>  
>  /*
>   * Helper function to write to the I2C device's registers.
>   */
This comment should be updated or removed.
> -static int ak8975_write_data(struct i2c_client *client,
> -			     u8 reg, u8 val, u8 mask, u8 shift)
> +static int akxxxx_set_mode(struct akxxxx_data *data, enum ak_ctrl_mode mode)
>  {
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -	struct ak8975_data *data = iio_priv(indio_dev);
>  	u8 regval;
>  	int ret;
>  
> -	regval = (data->reg_cache[reg] & ~mask) | (val << shift);
> -	ret = i2c_smbus_write_byte_data(client, reg, regval);
> +	regval = (data->cntl_cache & ~data->def->ctrl_masks[CNTL_MODE]) |
> +		data->def->ctrl_modes[mode];
> +	ret = i2c_smbus_write_byte_data(
> +		data->client, data->def->ctrl_regs[CNTL], regval);
Improve your indentation. Use checkpatch.pl with the strict switch to find these issues.
>  	if (ret < 0) {
> -		dev_err(&client->dev, "Write to device fails status %x\n", ret);
>  		return ret;
>  	}
> -	data->reg_cache[reg] = regval;
> +	data->cntl_cache = regval;
> +	/* After mode change wait atleast 100us */
> +	usleep_range(100, 500);
>  
>  	return 0;
>  }
> @@ -141,9 +452,9 @@ static int ak8975_write_data(struct i2c_client *client,
>  /*
>   * Handle data ready irq
>   */
> -static irqreturn_t ak8975_irq_handler(int irq, void *data)
> +static irqreturn_t akxxxx_irq_handler(int irq, void *data)
>  {
> -	struct ak8975_data *ak8975 = data;
> +	struct akxxxx_data *ak8975 = data;
>  
>  	set_bit(0, &ak8975->flags);
>  	wake_up(&ak8975->data_ready_queue);
> @@ -154,7 +465,7 @@ static irqreturn_t ak8975_irq_handler(int irq, void *data)
>  /*
>   * Install data ready interrupt handler
>   */
> -static int ak8975_setup_irq(struct ak8975_data *data)
> +static int akxxxx_setup_irq(struct akxxxx_data *data)
>  {
>  	struct i2c_client *client = data->client;
>  	int rc;
> @@ -165,7 +476,7 @@ static int ak8975_setup_irq(struct ak8975_data *data)
>  	else
>  		irq = gpio_to_irq(data->eoc_gpio);
>  
> -	rc = devm_request_irq(&client->dev, irq, ak8975_irq_handler,
> +	rc = devm_request_irq(&client->dev, irq, akxxxx_irq_handler,
>  			 IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>  			 dev_name(&client->dev), data);
>  	if (rc < 0) {
> @@ -187,53 +498,31 @@ static int ak8975_setup_irq(struct ak8975_data *data)
>   * Perform some start-of-day setup, including reading the asa calibration
>   * values and caching them.
>   */
> -static int ak8975_setup(struct i2c_client *client)
> +static int akxxxx_setup(struct i2c_client *client)
>  {
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -	struct ak8975_data *data = iio_priv(indio_dev);
> -	u8 device_id;
> +	struct akxxxx_data *data = iio_priv(indio_dev);
>  	int ret;
>  
> -	/* Confirm that the device we're talking to is really an AK8975. */
> -	ret = i2c_smbus_read_byte_data(client, AK8975_REG_WIA);
> -	if (ret < 0) {
> -		dev_err(&client->dev, "Error reading WIA\n");
> -		return ret;
> -	}
> -	device_id = ret;
> -	if (device_id != AK8975_DEVICE_ID) {
> -		dev_err(&client->dev, "Device ak8975 not found\n");
> -		return -ENODEV;
> -	}
> -
>  	/* Write the fused rom access mode. */
> -	ret = ak8975_write_data(client,
> -				AK8975_REG_CNTL,
> -				AK8975_REG_CNTL_MODE_FUSE_ROM,
> -				AK8975_REG_CNTL_MODE_MASK,
> -				AK8975_REG_CNTL_MODE_SHIFT);
> +	ret = akxxxx_set_mode(data, FUSE_ROM);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "Error in setting fuse access mode\n");
>  		return ret;
>  	}
>  
>  	/* Get asa data and store in the device data. */
> -	ret = i2c_smbus_read_i2c_block_data(client, AK8975_REG_ASAX,
> -					    3, data->asa);
> +	ret = i2c_smbus_read_i2c_block_data(client,
> +			data->def->ctrl_regs[ASA_BASE], 3, data->asa);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "Not able to read asa data\n");
>  		return ret;
>  	}
>  
>  	/* After reading fuse ROM data set power-down mode */
> -	ret = ak8975_write_data(client,
> -				AK8975_REG_CNTL,
> -				AK8975_REG_CNTL_MODE_POWER_DOWN,
> -				AK8975_REG_CNTL_MODE_MASK,
> -				AK8975_REG_CNTL_MODE_SHIFT);
> -
> +	ret = akxxxx_set_mode(data, POWER_DOWN);
Although it is missing in the original driver: what about checking ret?
And according to the datasheet, you should wait at least 100 µs after setting POWER_DOWN before setting other modes.
>  	if (data->eoc_gpio > 0 || client->irq) {
> -		ret = ak8975_setup_irq(data);
> +		ret = akxxxx_setup_irq(data);
>  		if (ret < 0) {
>  			dev_err(&client->dev,
>  				"Error setting data ready interrupt\n");
> @@ -246,96 +535,50 @@ static int ak8975_setup(struct i2c_client *client)
>  		return ret;
This function is a mess. This check up here (in the original file) belongs below the POWER_DOWN setting! Please take care of it, while you are on it.
>  	}
>  
> -/*
> - * Precalculate scale factor (in Gauss units) for each axis and
> - * store in the device data.
> - *
> - * This scale factor is axis-dependent, and is derived from 3 calibration
> - * factors ASA(x), ASA(y), and ASA(z).
> - *
> - * These ASA values are read from the sensor device at start of day, and
> - * cached in the device context struct.
> - *
> - * Adjusting the flux value with the sensitivity adjustment value should be
> - * done via the following formula:
> - *
> - * Hadj = H * ( ( ( (ASA-128)*0.5 ) / 128 ) + 1 )
> - *
> - * where H is the raw value, ASA is the sensitivity adjustment, and Hadj
> - * is the resultant adjusted value.
> - *
> - * We reduce the formula to:
> - *
> - * Hadj = H * (ASA + 128) / 256
> - *
> - * H is in the range of -4096 to 4095.  The magnetometer has a range of
> - * +-1229uT.  To go from the raw value to uT is:
> - *
> - * HuT = H * 1229/4096, or roughly, 3/10.
> - *
> - * Since 1uT = 0.01 gauss, our final scale factor becomes:
> - *
> - * Hadj = H * ((ASA + 128) / 256) * 3/10 * 1/100
> - * Hadj = H * ((ASA + 128) * 0.003) / 256
> - *
> - * Since ASA doesn't change, we cache the resultant scale factor into the
> - * device context in ak8975_setup().
> - */
> -	if (data->chipset == AK8963) {
> -		/*
> -		 * H range is +-8190 and magnetometer range is +-4912.
> -		 * So HuT using the above explanation for 8975,
> -		 * 4912/8190 = ~ 6/10.
> -		 * So the Hadj should use 6/10 instead of 3/10.
> -		 */
> -		data->raw_to_gauss[0] = RAW_TO_GAUSS_8963(data->asa[0]);
> -		data->raw_to_gauss[1] = RAW_TO_GAUSS_8963(data->asa[1]);
> -		data->raw_to_gauss[2] = RAW_TO_GAUSS_8963(data->asa[2]);
> -	} else {
> -		data->raw_to_gauss[0] = RAW_TO_GAUSS_8975(data->asa[0]);
> -		data->raw_to_gauss[1] = RAW_TO_GAUSS_8975(data->asa[1]);
> -		data->raw_to_gauss[2] = RAW_TO_GAUSS_8975(data->asa[2]);
> -	}
> +	data->raw_to_gauss[0] = data->def->raw_to_gauss(data->asa[0]);
> +	data->raw_to_gauss[1] = data->def->raw_to_gauss(data->asa[1]);
> +	data->raw_to_gauss[2] = data->def->raw_to_gauss(data->asa[2]);
>  
>  	return 0;
>  }
>  
> -static int wait_conversion_complete_gpio(struct ak8975_data *data)
> +static int wait_conversion_complete_gpio(struct akxxxx_data *data)
>  {
>  	struct i2c_client *client = data->client;
> -	u32 timeout_ms = AK8975_MAX_CONVERSION_TIMEOUT;
> +	u32 timeout_ms = AKXXXX_MAX_CONVERSION_TIMEOUT;
>  	int ret;
>  
>  	/* Wait for the conversion to complete. */
>  	while (timeout_ms) {
> -		msleep(AK8975_CONVERSION_DONE_POLL_TIME);
> +		msleep(AKXXXX_CONVERSION_DONE_POLL_TIME);
>  		if (gpio_get_value(data->eoc_gpio))
>  			break;
> -		timeout_ms -= AK8975_CONVERSION_DONE_POLL_TIME;
> +		timeout_ms -= AKXXXX_CONVERSION_DONE_POLL_TIME;
>  	}
>  	if (!timeout_ms) {
>  		dev_err(&client->dev, "Conversion timeout happened\n");
>  		return -EINVAL;
>  	}
>  
> -	ret = i2c_smbus_read_byte_data(client, AK8975_REG_ST1);
> +	ret = i2c_smbus_read_byte_data(client, data->def->ctrl_regs[ST1]);
>  	if (ret < 0)
>  		dev_err(&client->dev, "Error in reading ST1\n");
>  
>  	return ret;
>  }
>  
> -static int wait_conversion_complete_polled(struct ak8975_data *data)
> +static int wait_conversion_complete_polled(struct akxxxx_data *data)
>  {
>  	struct i2c_client *client = data->client;
>  	u8 read_status;
> -	u32 timeout_ms = AK8975_MAX_CONVERSION_TIMEOUT;
> +	u32 timeout_ms = AKXXXX_MAX_CONVERSION_TIMEOUT;
>  	int ret;
>  
>  	/* Wait for the conversion to complete. */
>  	while (timeout_ms) {
> -		msleep(AK8975_CONVERSION_DONE_POLL_TIME);
> -		ret = i2c_smbus_read_byte_data(client, AK8975_REG_ST1);
> +		msleep(AKXXXX_CONVERSION_DONE_POLL_TIME);
> +		ret = i2c_smbus_read_byte_data(
> +				client, data->def->ctrl_regs[ST1]);
>  		if (ret < 0) {
>  			dev_err(&client->dev, "Error in reading ST1\n");
>  			return ret;
> @@ -343,7 +586,7 @@ static int wait_conversion_complete_polled(struct ak8975_data *data)
>  		read_status = ret;
>  		if (read_status)
>  			break;
> -		timeout_ms -= AK8975_CONVERSION_DONE_POLL_TIME;
> +		timeout_ms -= AKXXXX_CONVERSION_DONE_POLL_TIME;
>  	}
>  	if (!timeout_ms) {
>  		dev_err(&client->dev, "Conversion timeout happened\n");
> @@ -354,13 +597,13 @@ static int wait_conversion_complete_polled(struct ak8975_data *data)
>  }
>  
>  /* Returns 0 if the end of conversion interrupt occured or -ETIME otherwise */
> -static int wait_conversion_complete_interrupt(struct ak8975_data *data)
> +static int wait_conversion_complete_interrupt(struct akxxxx_data *data)
>  {
>  	int ret;
>  
>  	ret = wait_event_timeout(data->data_ready_queue,
>  				 test_bit(0, &data->flags),
> -				 AK8975_DATA_READY_TIMEOUT);
> +				 AKXXXX_DATA_READY_TIMEOUT);
>  	clear_bit(0, &data->flags);
>  
>  	return ret > 0 ? 0 : -ETIME;
> @@ -369,20 +612,16 @@ static int wait_conversion_complete_interrupt(struct ak8975_data *data)
>  /*
>   * Emits the raw flux value for the x, y, or z axis.
>   */
> -static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
> +static int akxxxx_read_axis(struct iio_dev *indio_dev, int index, int *val)
>  {
> -	struct ak8975_data *data = iio_priv(indio_dev);
> +	struct akxxxx_data *data = iio_priv(indio_dev);
>  	struct i2c_client *client = data->client;
>  	int ret;
>  
>  	mutex_lock(&data->lock);
>  
>  	/* Set up the device for taking a sample. */
> -	ret = ak8975_write_data(client,
> -				AK8975_REG_CNTL,
> -				AK8975_REG_CNTL_MODE_ONCE,
> -				AK8975_REG_CNTL_MODE_MASK,
> -				AK8975_REG_CNTL_MODE_SHIFT);
> +	ret = akxxxx_set_mode(data, MODE_ONCE);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "Error in setting operating mode\n");
>  		goto exit;
> @@ -399,14 +638,15 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
>  		goto exit;
>  
>  	/* This will be executed only for non-interrupt based waiting case */
> -	if (ret & AK8975_REG_ST1_DRDY_MASK) {
> -		ret = i2c_smbus_read_byte_data(client, AK8975_REG_ST2);
> +	if (ret & data->def->ctrl_masks[ST1_DRDY]) {
> +		ret = i2c_smbus_read_byte_data(
> +				client, data->def->ctrl_regs[ST2]);
>  		if (ret < 0) {
>  			dev_err(&client->dev, "Error in reading ST2\n");
>  			goto exit;
>  		}
> -		if (ret & (AK8975_REG_ST2_DERR_MASK |
> -			   AK8975_REG_ST2_HOFL_MASK)) {
> +		if (ret & (data->def->ctrl_masks[ST2_DERR] |
> +			   data->def->ctrl_masks[ST2_HOFL])) {
>  			dev_err(&client->dev, "ST2 status error 0x%x\n", ret);
>  			ret = -EINVAL;
>  			goto exit;
> @@ -415,7 +655,7 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
>  
>  	/* Read the flux value from the appropriate register
>  	   (the register is specified in the iio device attributes). */
> -	ret = i2c_smbus_read_word_data(client, ak8975_index_to_reg[index]);
> +	ret = i2c_smbus_read_word_data(client, data->def->data_regs[index]);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "Read axis data fails\n");
>  		goto exit;
The original driver does some value clamping in the following lines. Since the resolution on the new supported devices is different, you need to adjust the clamping.
> @@ -432,16 +672,16 @@ exit:
>  	return ret;
>  }
>  
> -static int ak8975_read_raw(struct iio_dev *indio_dev,
> +static int akxxxx_read_raw(struct iio_dev *indio_dev,
>  			   struct iio_chan_spec const *chan,
>  			   int *val, int *val2,
>  			   long mask)
>  {
> -	struct ak8975_data *data = iio_priv(indio_dev);
> +	struct akxxxx_data *data = iio_priv(indio_dev);
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		return ak8975_read_axis(indio_dev, chan->address, val);
> +		return akxxxx_read_axis(indio_dev, chan->address, val);
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = 0;
>  		*val2 = data->raw_to_gauss[chan->address];
> @@ -450,7 +690,7 @@ static int ak8975_read_raw(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
>  
> -#define AK8975_CHANNEL(axis, index)					\
> +#define AKXXXX_CHANNEL(axis, index)					\
>  	{								\
>  		.type = IIO_MAGN,					\
>  		.modified = 1,						\
> @@ -460,40 +700,41 @@ static int ak8975_read_raw(struct iio_dev *indio_dev,
>  		.address = index,					\
>  	}
>  
> -static const struct iio_chan_spec ak8975_channels[] = {
> -	AK8975_CHANNEL(X, 0), AK8975_CHANNEL(Y, 1), AK8975_CHANNEL(Z, 2),
> +static const struct iio_chan_spec akxxxx_channels[] = {
> +	AKXXXX_CHANNEL(X, 0), AKXXXX_CHANNEL(Y, 1), AKXXXX_CHANNEL(Z, 2),
>  };
>  
> -static const struct iio_info ak8975_info = {
> -	.read_raw = &ak8975_read_raw,
> +static const struct iio_info akxxxx_info = {
> +	.read_raw = &akxxxx_read_raw,
>  	.driver_module = THIS_MODULE,
>  };
>  
> -static const struct acpi_device_id ak_acpi_match[] = {
> -	{"AK8975", AK8975},
> -	{"AK8963", AK8963},
> -	{"INVN6500", AK8963},
> +static const struct acpi_device_id akxxxx_acpi_match[] = {
> +	{"AK8975", (uintptr_t)&akxxxx_def_array[AK8975]},
> +	{"AK8963", (uintptr_t)&akxxxx_def_array[AK8963]},
> +	{"AK09911", (uintptr_t)&akxxxx_def_array[AK09911]},
> +	{"AK09912", (uintptr_t)&akxxxx_def_array[AK09912]},
>  	{ },
>  };
> -MODULE_DEVICE_TABLE(acpi, ak_acpi_match);
> +MODULE_DEVICE_TABLE(acpi, akxxxx_acpi_match);
>  
> -static const char *ak8975_match_acpi_device(struct device *dev,
> -					    enum asahi_compass_chipset *chipset)
> +static const char *akxxxx_match_acpi_device(struct device *dev,
> +					    struct akxxxx_def **def)
>  {
>  	const struct acpi_device_id *id;
>  
>  	id = acpi_match_device(dev->driver->acpi_match_table, dev);
>  	if (!id)
>  		return NULL;
> -	*chipset = (int)id->driver_data;
> +	*def = (struct akxxxx_def *)id->driver_data;
>  
>  	return dev_name(dev);
>  }
>  
> -static int ak8975_probe(struct i2c_client *client,
> +static int akxxxx_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
> -	struct ak8975_data *data;
> +	struct akxxxx_data *data;
>  	struct iio_dev *indio_dev;
>  	int eoc_gpio;
>  	int err;
> @@ -513,8 +754,8 @@ static int ak8975_probe(struct i2c_client *client,
>  	/* We may not have a GPIO based IRQ to scan, that is fine, we will
>  	   poll if so */
>  	if (gpio_is_valid(eoc_gpio)) {
> -		err = devm_gpio_request_one(&client->dev, eoc_gpio,
> -							GPIOF_IN, "ak_8975");
> +		err = devm_gpio_request_one(
> +			&client->dev, eoc_gpio, GPIOF_IN, id->name);
>  		if (err < 0) {
>  			dev_err(&client->dev,
>  				"failed to request GPIO %d, error %d\n",
> @@ -534,23 +775,27 @@ static int ak8975_probe(struct i2c_client *client,
>  	data->client = client;
>  	data->eoc_gpio = eoc_gpio;
>  	data->eoc_irq = 0;
> -
>  	/* id will be NULL when enumerated via ACPI */
>  	if (id) {
> -		data->chipset =
> -			(enum asahi_compass_chipset)(id->driver_data);
> +		data->def = (struct akxxxx_def *)id->driver_data;
>  		name = id->name;
>  	} else if (ACPI_HANDLE(&client->dev))
> -		name = ak8975_match_acpi_device(&client->dev, &data->chipset);
> +		name = akxxxx_match_acpi_device(&client->dev, &data->def);
>  	else
>  		return -ENOSYS;
>  
> +	if (data->def->who_i_am(client) < 0) {
> +		dev_err(&client->dev, "Unexpected device\n");
> +		return -ENODEV;
> +	}
> +
> +	/* id will be NULL when enumerated via ACPI */
Do we need this comment again?
>  	dev_dbg(&client->dev, "Asahi compass chip %s\n", name);
>  
>  	/* Perform some basic start-of-day setup of the device. */
> -	err = ak8975_setup(client);
> +	err = akxxxx_setup(client);
>  	if (err < 0) {
> -		dev_err(&client->dev, "AK8975 initialization fails\n");
> +		dev_err(&client->dev, "%s initialization fails\n", name);
>  		return err;
>  	}
>  
> @@ -558,9 +803,9 @@ static int ak8975_probe(struct i2c_client *client,
>  	mutex_init(&data->lock);
>  	data->eoc_gpio = eoc_gpio;
>  	indio_dev->dev.parent = &client->dev;
> -	indio_dev->channels = ak8975_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(ak8975_channels);
> -	indio_dev->info = &ak8975_info;
> +	indio_dev->channels = akxxxx_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(akxxxx_channels);
> +	indio_dev->info = &akxxxx_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->name = name;
>  	err = devm_iio_device_register(&client->dev, indio_dev);
> @@ -570,32 +815,48 @@ static int ak8975_probe(struct i2c_client *client,
>  	return 0;
>  }
>  
> -static const struct i2c_device_id ak8975_id[] = {
> -	{"ak8975", AK8975},
> -	{"ak8963", AK8963},
> +static const struct i2c_device_id akxxxx_id[] = {
> +	{"ak8975", (uintptr_t)&akxxxx_def_array[AK8975]},
> +	{"ak8963", (uintptr_t)&akxxxx_def_array[AK8963]},
> +	{"ak09911", (uintptr_t)&akxxxx_def_array[AK09911]},
> +	{"ak09912", (uintptr_t)&akxxxx_def_array[AK09912]},
>  	{}
>  };
>  
> -MODULE_DEVICE_TABLE(i2c, ak8975_id);
> -
> -static const struct of_device_id ak8975_of_match[] = {
> -	{ .compatible = "asahi-kasei,ak8975", },
> -	{ .compatible = "ak8975", },
> +MODULE_DEVICE_TABLE(i2c, akxxxx_id);
> +
> +static const struct of_device_id akxxxx_of_match[] = {
> +	{ .compatible = "asahi-kasei,ak8975",
> +	  .data = &akxxxx_def_array[AK8975]},
> +	{ .compatible = "ak8975",
> +	  .data = &akxxxx_def_array[AK8975]},
> +	{ .compatible = "asahi-kasei,ak8963",
> +	  .data = &akxxxx_def_array[AK8963]},
> +	{ .compatible = "ak8963",
> +	  .data = &akxxxx_def_array[AK8963]},
> +	{ .compatible = "asahi-kasei,ak09911",
> +	  .data = &akxxxx_def_array[AK09911]},
> +	{ .compatible = "ak09911",
> +	  .data = &akxxxx_def_array[AK09911]},
> +	{ .compatible = "asahi-kasei,ak09912",
> +	  .data = &akxxxx_def_array[AK09912]},
> +	{ .compatible = "ak09912",
> +	  .data = &akxxxx_def_array[AK09912]},
>  	{ }
>  };
> -MODULE_DEVICE_TABLE(of, ak8975_of_match);
> +MODULE_DEVICE_TABLE(of, akxxxx_of_match);
>  
> -static struct i2c_driver ak8975_driver = {
> +static struct i2c_driver akxxxx_driver = {
>  	.driver = {
> -		.name	= "ak8975",
> -		.of_match_table = ak8975_of_match,
> -		.acpi_match_table = ACPI_PTR(ak_acpi_match),
> +		.name	= "akxxxx",
> +		.of_match_table = of_match_ptr(akxxxx_of_match),
> +		.acpi_match_table = ACPI_PTR(akxxxx_acpi_match),
>  	},
> -	.probe		= ak8975_probe,
> -	.id_table	= ak8975_id,
> +	.probe		= akxxxx_probe,
> +	.id_table	= akxxxx_id,
>  };
> -module_i2c_driver(ak8975_driver);
> +module_i2c_driver(akxxxx_driver);
>  
>  MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
> -MODULE_DESCRIPTION("AK8975 magnetometer driver");
> +MODULE_DESCRIPTION("ak8975 and ak09912 magnetometer driver");
>  MODULE_LICENSE("GPL");
> 
