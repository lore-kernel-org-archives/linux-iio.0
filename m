Return-Path: <SRS0=rYtN=6I=pmeerw.net=pmeerw@kernel.org>
Date: Wed, 5 Jul 2017 14:04:12 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
cc: daniel.baluta@gmail.com, amsfield22@gmail.com, jic23@kernel.org,
    knaack.h@gmx.de, lars@metafoo.de, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: ccs811: Add support for AMS CCS811 VOC
 sensor
In-Reply-To: <1499247887-5154-1-git-send-email-narcisaanamaria12@gmail.com>
Message-ID: <alpine.DEB.2.20.1707051152080.16389@vps.pmeerw.net>
References: <1499247887-5154-1-git-send-email-narcisaanamaria12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

> Add support for CCS811 VOC sensor. This patch adds support
> for reading current and voltage across the sensor and TVOC
> and equivalent CO2 processed values.

nice, comments below
link to datasheet would be nice

should list limitations and TODOs, e.g. interrupt support, NTC
 
> Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
> ---
> This patch introduces a probe function and adds support for readings
> from CCS811 sensor. In probe function, ccs811_setup() function is called
> to perform initial setup of the sensor:
>     * ccs811_switch_to_application_mode() assures transition from boot mode
>     to application mode, by first checking for a valid application and then
>     selecting the APP_START register in order to start running the loaded app.
> 
>     * ccs811_set_drive_mode configures the sensor in the desired operating mode.
> 
> ccs811_read_raw performs readings from the 4 defined channels:
>     - current and voltage are read from the 2-byte RAW_DATA register.
>         6 bits represent the current and the lower 10 bits represent
>         the voltage across the sensor.
> 
>     - eCO2 and TVOC are read from the 8-byte ALG_RESULT_DATA register.
>         Only 5 bytes are read here: first 2 bytes represent equivalent CO2,
>         which ranges from 400 ppm to 8192 ppm; next 2 bytes represent TVOC,
>         varying from 0 ppb to 1187 ppb. Last byte is the status register,

see sysfs-bus-iio; IIO_CONCENTRATION should be a percentage value


>         which is read in order to check for errors.
> 
>  drivers/iio/chemical/Kconfig  |   7 ++
>  drivers/iio/chemical/Makefile |   1 +
>  drivers/iio/chemical/ccs811.c | 274 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 282 insertions(+)
>  create mode 100644 drivers/iio/chemical/ccs811.c
> 
> diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
> index cea7f98..4d799b5 100644
> --- a/drivers/iio/chemical/Kconfig
> +++ b/drivers/iio/chemical/Kconfig
> @@ -21,6 +21,13 @@ config ATLAS_PH_SENSOR
>  	 To compile this driver as module, choose M here: the
>  	 module will be called atlas-ph-sensor.
> 
> +config CCS811
> +	tristate "AMS CCS811 VOC sensor"
> +	depends on I2C
> +	help
> +	  Say Y here to build I2C interface support for the AMS
> +	  CCS811 VOC (Volatile Organic Compounds) sensor
> +
>  config IAQCORE
>  	tristate "AMS iAQ-Core VOC sensors"
>  	depends on I2C
> diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
> index b02202b..a629b29 100644
> --- a/drivers/iio/chemical/Makefile
> +++ b/drivers/iio/chemical/Makefile
> @@ -4,5 +4,6 @@
> 
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_ATLAS_PH_SENSOR)	+= atlas-ph-sensor.o
> +obj-$(CONFIG_CCS811)		+= ccs811.o
>  obj-$(CONFIG_IAQCORE)		+= ams-iaq-core.o
>  obj-$(CONFIG_VZ89X)		+= vz89x.o
> diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
> new file mode 100644
> index 0000000..2d736d4
> --- /dev/null
> +++ b/drivers/iio/chemical/ccs811.c
> @@ -0,0 +1,274 @@
> +/*
> + * ccs811.c - Support for AMS CCS811 VOC Sensor
> + *
> + * Copyright (C) 2017 Narcisa Vasile <narcisaanamaria12@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * IIO driver for AMS CCS811 (I2C address 0x5A/0x5B set by ADDR Low/High)
> + *
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +
> +#define CCS811_STATUS		0x00
> +#define CCS811_MEAS_MODE	0x01
> +#define CCS811_ALG_RESULT_DATA	0x02
> +#define CCS811_RAW_DATA		0x03
> +#define CCS811_HW_ID		0x20
> +#define CCS811_ERR		0xE0
> +#define CCS811_APP_START	0xF4

APP_START is undocumented?

> +
> +#define CCS811_VOLTAGE_MASK	0x3FF
> +
> +#define STATUS_DATA_READY	BIT(3)
> +#define STATUS_APP_VALID	BIT(4)
> +#define STATUS_FW_MODE		BIT(7)

prefix please

> +
> +enum operation_mode {

prefix please

> +	CCS811_MODE_IDLE = 0,
> +	CCS811_MODE_IAQ_SEC_1 = 1,
> +	CCS811_MODE_IAQ_SEC_10 = 2,
> +	CCS811_MODE_IAQ_SEC_60 = 3,
> +	CCS811_MODE_RAW_DATA = 4
> +};
> +
> +struct ccs811_data {
> +	struct i2c_client *client;
> +	u8 buffer[8];
> +};
> +
> +static const struct iio_chan_spec ccs811_channels[] = {
> +	{
> +		.type = IIO_CURRENT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
> +	},
> +	{
> +		.type = IIO_VOLTAGE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
> +	},
> +	{
> +		.type = IIO_CONCENTRATION,
> +		.channel2 = IIO_MOD_CO2,
> +		.modified = 1,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +	},
> +	{
> +		.type = IIO_CONCENTRATION,
> +		.channel2 = IIO_MOD_VOC,
> +		.modified = 1,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +	},
> +};
> +
> +static int ccs811_data_ready(struct i2c_client *client)
> +{
> +	int status;

maybe use 'ret' as everywhere else

> +
> +	status = i2c_smbus_read_byte_data(client, CCS811_STATUS);
> +	if (status < 0)
> +		return status;
> +
> +	if (!(status & STATUS_DATA_READY))
> +		return -EAGAIN;

most other drivers wait for data to become ready instead of erroring out

> +
> +	return 0;
> +}
> +
> +static int ccs811_set_drive_mode(struct i2c_client *client, int mode)

use
enum operation_mode
instead of int?

> +{
> +	int ret, status, meas_mode = 0;

no need to initialize meas_mode

> +
> +	if (mode < 0 || mode > 4)
> +		return -EINVAL;
> +
> +	meas_mode = mode << 4;

temporary variable needed?

> +
> +	ret = i2c_smbus_write_byte_data(client, CCS811_MEAS_MODE, meas_mode);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Check status for errors */
> +	status = i2c_smbus_read_byte_data(client, CCS811_STATUS);
> +	if (status < 0)
> +		return status;
> +
> +	/* First bit of status is set to 1, if an error occurred */

comments here are rather pointless

> +	if (status & 1)

maybe a #define? there are already _STATUS BIT()s

> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static int ccs811_switch_to_application_mode(struct i2c_client *client)
> +{
> +	int status, ret;

both needed?

> +
> +	status = i2c_smbus_read_byte_data(client, CCS811_STATUS);
> +	if (status < 0)
> +		return status;
> +
> +	if (!(status & STATUS_APP_VALID))
> +		return -EIO;
> +
> +	ret = i2c_smbus_read_byte_data(client, CCS811_APP_START);
> +	if (ret < 0)
> +		return ret;
> +
> +	status = i2c_smbus_read_byte_data(client, CCS811_STATUS);
> +	if (status < 0)
> +		return status;
> +
> +	if (!(status & STATUS_FW_MODE))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static int ccs811_setup(struct i2c_client *client)
> +{
> +	int ret;
> +
> +	ret = ccs811_switch_to_application_mode(client);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ccs811_set_drive_mode(client, CCS811_MODE_IAQ_SEC_1);

to would be nice to expose the 1 second interval to userspace... (or at 
least note this as a TODO)

> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int ccs811_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct ccs811_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = ccs811_data_ready(data->client);
> +	if (ret < 0)
> +		return ret;

I think there should be a mutex so that 
data_ready() and read()
are executed in a critical section

> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = i2c_smbus_read_word_swapped(data->client,
> +						  CCS811_RAW_DATA);
> +		if (ret < 0)
> +			return ret;
> +
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			*val = ret & CCS811_VOLTAGE_MASK;

this should be in millivolts (after _SCALE, _OFFSET)?
datasheet says that 1023 = 1.65V

> +			return IIO_VAL_INT;
> +		case IIO_CURRENT:

this should be in milliamps?
datasheet says this is 0 to 63 microamps...

> +			*val = ret >> 10;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;

break not needed

> +	case IIO_CHAN_INFO_PROCESSED:
> +		if (chan->type != IIO_CONCENTRATION)
> +			return -EINVAL;
> +
> +		ret = i2c_smbus_read_i2c_block_data(data->client,
> +						    CCS811_ALG_RESULT_DATA,
> +						    5, data->buffer);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* If the number of bytes read is different than what was

proper multi-line comment format please
/*
 *
 */

> +		 * requested or status error bit was set
> +		 */
> +		if (ret != 5 || (data->buffer[4] & 1))
> +			return -EIO;
> +
> +		switch (chan->channel2) {
> +		case IIO_MOD_CO2:

data->buffer could be a (packed) struct?
__be16 co2;
__be16 voc;
u8 status;
?


> +			*val = data->buffer[0] * 256 + data->buffer[1];
> +			return IIO_VAL_INT;
> +		case IIO_MOD_VOC:
> +			*val = data->buffer[2] * 256 + data->buffer[3];
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return -EINVAL;

return not needed

> +}
> +
> +static const struct iio_info ccs811_info = {
> +	.read_raw = ccs811_read_raw,
> +};
> +
> +static int ccs811_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ccs811_data *data;
> +	int hwid, ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA
> +				     | I2C_FUNC_SMBUS_WORD_DATA
> +				     | I2C_FUNC_SMBUS_READ_I2C_BLOCK))
> +		return -EOPNOTSUPP;
> +
> +	/* Check hardware id (should be 0x81 for this family of devices) */
> +	hwid = i2c_smbus_read_byte_data(client, CCS811_HW_ID);
> +	if (hwid < 0)
> +		return hwid;
> +
> +	if (hwid != 0x81) {
> +		dev_err(&client->dev, "no CCS811 sensor\n");
> +		return -ENODEV;
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	ret = ccs811_setup(client);
> +	if (ret < 0)
> +		return ret;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->name = id->name;
> +	indio_dev->info = &ccs811_info;
> +
> +	indio_dev->channels = ccs811_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ccs811_channels);
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);

set chip to idle if _register fails?

maye set chip to idle in _remove()?

> +}
> +
> +static const struct i2c_device_id ccs811_id[] = {
> +	{"ccs811", 0},
> +	{	}
> +};
> +MODULE_DEVICE_TABLE(i2c, ccs811_id);
> +
> +static struct i2c_driver ccs811_driver = {
> +	.driver = {
> +		.name = "ccs811",
> +	},
> +	.probe = ccs811_probe,
> +	.id_table = ccs811_id,
> +};
> +module_i2c_driver(ccs811_driver);
> +
> +MODULE_AUTHOR("Narcisa Vasile <narcisaanamaria12@gmail.com>");
> +MODULE_DESCRIPTION("CCS811 VOC SENSOR");

sensor

> +MODULE_LICENSE("GPL v2");
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
