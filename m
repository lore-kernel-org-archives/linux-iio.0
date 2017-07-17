Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58082 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751318AbdGQVnf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Jul 2017 17:43:35 -0400
Date: Mon, 17 Jul 2017 22:43:26 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
Cc: linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@gmail.com>,
        Alison Schofield <amsfield22@gmail.com>
Subject: Re: [PATCH v3] iio: chemical: ccs811: Add support for AMS CCS811
 VOC sensor
Message-ID: <20170717224326.3630c521@jic23.retrosnub.co.uk>
In-Reply-To: <1500319683-3637-1-git-send-email-narcisaanamaria12@gmail.com>
References: <1500319683-3637-1-git-send-email-narcisaanamaria12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 17 Jul 2017 22:28:03 +0300
Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com> wrote:

> Add support for CCS811 VOC sensor. This patch adds support
> for reading current and voltage across the sensor and TVOC
> and equivalent CO2 values.
> 
> Scale and offset values have been computed according to datasheet:
>     - For current: raw value is in microamps
>         => 0.001 scale to convert to milliamps  
>     - For voltage: 1.65V = 1023, therefore 1650mV = 1023
>         => 1650.0/1023 = 1.612903 scale to convert to millivolts  
>     - For eCO2: raw value range is from 400ppm to 8192ppm.
>         => (val - 400) * (100 - 0) / (8192 - 400) + 0 =  
>            (val - 400) * 0.01283367 => offset: -400, scale = 0.012834
>            to get a percentage value
>     -For TVOC: raw value range is from 0ppb to 1187ppb.
>         => (val - 0) * 100 / (1187 - 0) + 0 = val * 0.0842459 =>  
>             scale = 0.084246 for getting a percentage value
> 
> Cc: Daniel Baluta <daniel.baluta@gmail.com>
> Cc: Alison Schofield <amsfield22@gmail.com>
> Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
There is one bit inline that ended up a little inelegant despite
being done in a theoretically acceptable way. 

So you don't have to do another round, I've tweaked it whilst applying
- please could you check the result is still good as I've been known
to mess up these little changes ;(

Nice little driver, looking forward to next part.
Jonathan
> ---
> Changes in v3:
>     - Define macros for the hardware id value, hardware version and
>       hardware version mask
>     - Define mask and value macros for FW_MODE bit of status register
>       for clarity
>     - Define mask and value macros for APP_VALID bit of status register
>       for clarity
>     - Remove enum operation_mode
>     - Add macros for operation mode masks
>     - Write to APP_START using i2c_smbus_write_byte, instead of
>       i2c_smbus_read_byte_data, as the datasheet requests a write of one byte
>       to transition from boot mode to application mode
>     - Remove check of status register after setting measurement mode
>       as the datasheet doesn't require checking for errors after this operation
>     - Remove set_drive_mode() function, as drive mode can be directly set
>       with one call to i2c_smbus_write_byte_data(). The rest of the function body
>       was just checking the STATUS register for errors, but this check was
>       removed.
>     - Fix race condition by holding the lock until all operations performed on
>       the data buffer are completed; add label out_unlock, in order to
>       make sure the lock is released in case of errors, too.
>     - Improve comment to explicitly show the maximum waiting time for a new
>       data sample to be ready.
> 	- Add comment to document the need for transition from boot mode to app mode
> 	- Rename ccs811_switch_to_application_mode to ccs811_start_sensor_application
> 	- Add functionality check flag for i2c_smbus_write_byte
> 	- Add comment above status register flags macros
> 	- Add comment explaining the purpose of FW_MODE bit in STATUS register
>     - Add check for when number of tries reaches 0, while waiting for
>       data-ready flag to be set.
>       Note: After 1 second has passed after the first check of the data-ready
>       flag, it goes inside the loop one more time and checks the data-ready
>       flag again. It should then break, either because data is ready,
>       or it is not, but number of tries has reached 0 and it will not go inside
>       the loop again.
>       If the "tries == 0" check is removed, it will wait 100ms more at the end,
>       before checking the "while" condition again and exiting the loop.
> 
> Changes in v2:
>     - Add scale and offset to obtain values expressed with correct units.
>     - RAW_READ register is not read anymore, since values for current and
>       voltage are read using ALG_RESULT_DATA register address. Remove the
>       check for I2C_SMBUS_WORD_DATA, since the corresponding function
>       is not used anymore.
>     - Define packed struct to hold data read from alg_result_data register.
>     - Add mutex to protect readings.
>     - Add _remove function and set chip to IDLE inside it.
>     - Group measurement reading and "data_ready" check inside new function.
>     - Introduce sleeps to wait for data to be ready.
>     - Add ccs811 prefix to enum operation_mode and to STATUS macros.
>     - Use ret instead of status variable to hold return values from functions.
>     - Use enum operation_mode instead of int as parameter to set_drive_mode().
>     - Drop temporary variable meas_mode.
>     - Drop pointless comments.
>     - Add macro for error bit in STATUS register.
>     - Drop useless break.
>     - Drop useless return.
>     - Change format of multi-line comment.
>     - Change word "SENSOR" to lowercase letters inside MODULE_DESCRIPTION.
>     - Remove empty comment line.
>     - Introduce MIN and MAX values to ccs811_operation_mode to detect invalid
>       values.
>     - Change style of braces.
>     - Replace VOC with "volatile organic compounds" in MODULE_DESCRIPTION.
>     - Add datasheet link.
>     - Check hardware version in probe
> 
>  drivers/iio/chemical/Kconfig  |   7 +
>  drivers/iio/chemical/Makefile |   1 +
>  drivers/iio/chemical/ccs811.c | 338 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 346 insertions(+)
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
> index 0000000..0e6b34a
> --- /dev/null
> +++ b/drivers/iio/chemical/ccs811.c
> @@ -0,0 +1,338 @@
> +/*
> + * ccs811.c - Support for AMS CCS811 VOC Sensor
> + *
> + * Copyright (C) 2017 Narcisa Vasile <narcisaanamaria12@gmail.com>
> + *
> + * Datasheet: ams.com/content/download/951091/2269479/CCS811_DS000459_3-00.pdf
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * IIO driver for AMS CCS811 (I2C address 0x5A/0x5B set by ADDR Low/High)
> + *
> + * TODO:
> + * 1. Make the drive mode selectable form userspace
> + * 2. Add support for interrupts
> + * 3. Adjust time to wait for data to be ready based on selected operation mode
> + * 4. Read error register and put the information in logs
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +
> +#define CCS811_STATUS		0x00
> +#define CCS811_MEAS_MODE	0x01
> +#define CCS811_ALG_RESULT_DATA	0x02
> +#define CCS811_RAW_DATA		0x03
> +#define CCS811_HW_ID		0x20
> +#define CCS881_HW_ID_VALUE	0x81
> +#define CCS811_HW_VERSION	0x21
> +#define CCS811_HW_VERSION_VALUE	0x10
> +#define CCS811_HW_VERSION_MASK	0xF0
> +#define CCS811_ERR		0xE0
> +/* Used to transition from boot to application mode */
> +#define CCS811_APP_START	0xF4
> +
> +/* Status register flags */
> +#define CCS811_STATUS_ERROR		BIT(0)
> +#define CCS811_STATUS_DATA_READY	BIT(3)
> +#define CCS811_STATUS_APP_VALID_MASK	BIT(4)
> +#define CCS811_STATUS_APP_VALID_LOADED	BIT(4)
> +/*
> + * Value of FW_MODE bit of STATUS register describes the sensor's state:
> + * 0: Firmware is in boot mode, this allows new firmware to be loaded
> + * 1: Firmware is in application mode. CCS811 is ready to take ADC measurements
> + */
> +#define CCS811_STATUS_FW_MODE_MASK	BIT(7)
> +#define CCS811_STATUS_FW_MODE_APPLICATION	BIT(7)
> +
> +/* Measurement modes */
> +#define CCS811_MODE_IDLE	0x00
> +#define CCS811_MODE_IAQ_1SEC	0x10
> +#define CCS811_MODE_IAQ_10SEC	0x20
> +#define CCS811_MODE_IAQ_60SEC	0x30
> +#define CCS811_MODE_RAW_DATA	0x40
> +
> +#define CCS811_VOLTAGE_MASK	0x3FF
> +
> +struct ccs811_reading {
> +	__be16 co2;
> +	__be16 voc;
> +	u8 status;
> +	u8 error;
> +	__be16 resistance;
> +} __attribute__((__packed__));
> +
> +struct ccs811_data {
> +	struct i2c_client *client;
> +	struct mutex lock; /* Protect readings */
> +	struct ccs811_reading buffer;
> +};
> +
> +static const struct iio_chan_spec ccs811_channels[] = {
> +	{
> +		.type = IIO_CURRENT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE)
> +	}, {
> +		.type = IIO_VOLTAGE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE)
> +	}, {
> +		.type = IIO_CONCENTRATION,
> +		.channel2 = IIO_MOD_CO2,
> +		.modified = 1,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_OFFSET) |
> +				      BIT(IIO_CHAN_INFO_SCALE)
> +	}, {
> +		.type = IIO_CONCENTRATION,
> +		.channel2 = IIO_MOD_VOC,
> +		.modified = 1,
> +		.info_mask_separate =  BIT(IIO_CHAN_INFO_RAW) |
> +				       BIT(IIO_CHAN_INFO_SCALE)
> +	},
> +};
> +
> +/*
> + * The CCS811 powers-up in boot mode. A setup write to CCS811_APP_START will
> + * transition the sensor to application mode.
> + */
> +static int ccs811_start_sensor_application(struct i2c_client *client)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(client, CCS811_STATUS);
> +	if (ret < 0)
> +		return ret;
> +
> +	if ((ret & CCS811_STATUS_APP_VALID_MASK) !=
> +	    CCS811_STATUS_APP_VALID_LOADED)
> +		return -EIO;
> +
> +	ret = i2c_smbus_write_byte(client, CCS811_APP_START);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_smbus_read_byte_data(client, CCS811_STATUS);
> +	if (ret < 0)
> +		return ret;
> +
> +	if ((ret & CCS811_STATUS_FW_MODE_MASK) !=
> +	    CCS811_STATUS_FW_MODE_APPLICATION) {
> +		dev_err(&client->dev, "Application failed to start. Sensor is still in boot mode.\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ccs811_setup(struct i2c_client *client)
> +{
> +	int ret;
> +
> +	ret = ccs811_start_sensor_application(client);
> +	if (ret < 0)
> +		return ret;
> +
> +	return i2c_smbus_write_byte_data(client, CCS811_MEAS_MODE,
> +					 CCS811_MODE_IAQ_1SEC);
> +}
> +
> +static int ccs811_get_measurement(struct ccs811_data *data)
> +{
> +	int ret, tries = 11;
> +
> +	/* Maximum waiting time: 1s, as measurements are made every second */
> +	while (tries-- > 0) {
> +		ret = i2c_smbus_read_byte_data(data->client, CCS811_STATUS);
> +		if (ret < 0)
> +			return ret;
> +
> +		if ((ret & CCS811_STATUS_DATA_READY) || tries == 0)
> +			break;
> +		msleep(100);
> +	}
> +	if (!(ret & CCS811_STATUS_DATA_READY))
> +		return -EIO;
> +
> +	return i2c_smbus_read_i2c_block_data(data->client,
> +					    CCS811_ALG_RESULT_DATA, 8,
> +					    (char *)&data->buffer);
> +}
> +
> +static int ccs811_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct ccs811_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&data->lock);
> +		ret = ccs811_get_measurement(data);
> +		if (ret < 0)
I know we always argue in favour of a single cleanup point
but this has ended up rather inelegant.  I'd put the addition
unlock here that will allow to bring it into the outer case
statement and end up with a cleaner bit of code.

If this is all that is left, I'll do it in the interests
of speed and moving on to more interesting new stuff.

Only obvious alternative would have been to break this block
out to a separate function with error handling, but that seems
like overkill on this occasion.

Anyhow, please check the result.
> +			goto out_unlock;
> +
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			*val = be16_to_cpu(data->buffer.resistance) &
> +					   CCS811_VOLTAGE_MASK;
> +			ret = IIO_VAL_INT;
> +			break;
> +		case IIO_CURRENT:
> +			*val = be16_to_cpu(data->buffer.resistance) >> 10;
> +			ret = IIO_VAL_INT;
> +			break;
> +		case IIO_CONCENTRATION:
> +			switch (chan->channel2) {
> +			case IIO_MOD_CO2:
> +				*val = be16_to_cpu(data->buffer.co2);
> +				ret =  IIO_VAL_INT;
> +				break;
> +			case IIO_MOD_VOC:
> +				*val = be16_to_cpu(data->buffer.voc);
> +				ret = IIO_VAL_INT;
> +				break;
> +			default:
> +				ret = -EINVAL;
> +			}
> +			break;
> +		default:
> +			ret = -EINVAL;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			*val = 1;
> +			*val2 = 612903;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		case IIO_CURRENT:
> +			*val = 0;
> +			*val2 = 1000;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		case IIO_CONCENTRATION:
> +			switch (chan->channel2) {
> +			case IIO_MOD_CO2:
> +				*val = 0;
> +				*val2 = 12834;
> +				return IIO_VAL_INT_PLUS_MICRO;
> +			case IIO_MOD_VOC:
> +				*val = 0;
> +				*val2 = 84246;
> +				return IIO_VAL_INT_PLUS_MICRO;
> +			default:
> +				return -EINVAL;
> +			}
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (!(chan->type == IIO_CONCENTRATION &&
> +		      chan->channel2 == IIO_MOD_CO2))
> +			return -EINVAL;
> +		*val = -400;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +out_unlock:
> +	mutex_unlock(&data->lock);
> +	return ret;
> +}
> +
> +static const struct iio_info ccs811_info = {
> +	.read_raw = ccs811_read_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static int ccs811_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ccs811_data *data;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WRITE_BYTE
> +				     | I2C_FUNC_SMBUS_BYTE_DATA
> +				     | I2C_FUNC_SMBUS_READ_I2C_BLOCK))
> +		return -EOPNOTSUPP;
> +
> +	/* Check hardware id (should be 0x81 for this family of devices) */
> +	ret = i2c_smbus_read_byte_data(client, CCS811_HW_ID);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret != CCS881_HW_ID_VALUE) {
> +		dev_err(&client->dev, "hardware id doesn't match CCS81x\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = i2c_smbus_read_byte_data(client, CCS811_HW_VERSION);
> +	if (ret < 0)
> +		return ret;
> +
> +	if ((ret & CCS811_HW_VERSION_MASK) != CCS811_HW_VERSION_VALUE) {
> +		dev_err(&client->dev, "no CCS811 sensor\n");
> +		return -ENODEV;
This test may prove a little over zealous in the future if the
interface tends to stay the same whilst tweaks are made elsewhere.
Still we don't know yet, so let us leave this here for now.
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
> +	mutex_init(&data->lock);
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->name = id->name;
> +	indio_dev->info = &ccs811_info;
> +
> +	indio_dev->channels = ccs811_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ccs811_channels);
> +
> +	return iio_device_register(indio_dev);
> +}
> +
> +static int ccs811_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +
> +	iio_device_unregister(indio_dev);
> +
> +	return i2c_smbus_write_byte_data(client, CCS811_MEAS_MODE,
> +					 CCS811_MODE_IDLE);
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
> +	.remove = ccs811_remove,
> +	.id_table = ccs811_id,
> +};
> +module_i2c_driver(ccs811_driver);
> +
> +MODULE_AUTHOR("Narcisa Vasile <narcisaanamaria12@gmail.com>");
> +MODULE_DESCRIPTION("CCS811 volatile organic compounds sensor");
> +MODULE_LICENSE("GPL v2");

