Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:34923 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753483Ab3BPQCe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 16 Feb 2013 11:02:34 -0500
Message-ID: <511FADFF.1040604@metafoo.de>
Date: Sat, 16 Feb 2013 17:04:15 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: Jean Delvare <khali@linux-fr.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Jonathan Cameron <jic23@cam.ac.uk>, lm-sensors@lm-sensors.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 7/9] hwmon: (adt7410) Add support for the adt7310/adt7320
References: <1360947438-2550-1-git-send-email-lars@metafoo.de> <1360947438-2550-7-git-send-email-lars@metafoo.de> <20130215203243.GG32433@roeck-us.net>
In-Reply-To: <20130215203243.GG32433@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/15/2013 09:32 PM, Guenter Roeck wrote:
> On Fri, Feb 15, 2013 at 05:57:16PM +0100, Lars-Peter Clausen wrote:
>> The adt7310/adt7320 is the SPI version of the adt7410/adt7320. The register map
>> layout is a bit different, i.e. the register addresses differ between the two
>> variants, but the bit layouts of the individual registers are identical. So both
>> chip variants can easily be supported by the same driver. The issue of non
>> matching register address layouts is solved by a simple look-up table which
>> translates the I2C addresses to the SPI addresses.
>>
>> The patch moves the bulk of the adt7410 driver to a common module that will be
>> shared by the adt7410 and adt7310 drivers. This common module implements the
>> driver logic and uses a set of virtual functions to perform IO access. The
>> adt7410 and adt7310 driver modules provide proper implementations of these IO
>> accessor functions for I2C respective SPI.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> ---
>>  drivers/hwmon/Kconfig   |  20 ++
>>  drivers/hwmon/Makefile  |   2 +
>>  drivers/hwmon/adt7310.c | 160 ++++++++++++++++
>>  drivers/hwmon/adt7410.c | 472 ++++++-----------------------------------------
>>  drivers/hwmon/adt7x10.c | 476 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/hwmon/adt7x10.h |  47 +++++
>>  6 files changed, 758 insertions(+), 419 deletions(-)
>>  create mode 100644 drivers/hwmon/adt7310.c
>>  create mode 100644 drivers/hwmon/adt7x10.c
>>  create mode 100644 drivers/hwmon/adt7x10.h
>>
>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>> index 89ac1cb..aaa14f4 100644
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
>> @@ -179,9 +179,29 @@ config SENSORS_ADM9240
>>  	  This driver can also be built as a module.  If so, the module
>>  	  will be called adm9240.
>>  
>> +config SENSORS_ADT7X10
>> +	tristate
>> +	help
>> +	  This module contains common code shared by the ADT7310/ADT7320 and
>> +	  ADT7410/ADT7420 temperature monitoring chip drivers.
>> +
>> +	  If build as a module, the module will be called adt7x10.
>> +
>> +config SENSORS_ADT7310
>> +	tristate "Analog Devices ADT7310/ADT7320"
>> +	depends on SPI_MASTER
>> +	select SENSORS_ADT7X10
>> +	help
>> +	  If you say yes here you get support for the Analog Devices
>> +	  ADT7310 and ADT7320 temperature monitoring chips.
>> +
>> +	  This driver can also be built as a module. If so, the module
>> +	  will be called adt7310.
>> +
>>  config SENSORS_ADT7410
>>  	tristate "Analog Devices ADT7410/ADT7420"
>>  	depends on I2C
>> +	select SENSORS_ADT7X10
>>  	help
>>  	  If you say yes here you get support for the Analog Devices
>>  	  ADT7410 and ADT7420 temperature monitoring chips.
>> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
>> index 8d6d97e..5d36a57 100644
>> --- a/drivers/hwmon/Makefile
>> +++ b/drivers/hwmon/Makefile
>> @@ -34,6 +34,8 @@ obj-$(CONFIG_SENSORS_ADM9240)	+= adm9240.o
>>  obj-$(CONFIG_SENSORS_ADS1015)	+= ads1015.o
>>  obj-$(CONFIG_SENSORS_ADS7828)	+= ads7828.o
>>  obj-$(CONFIG_SENSORS_ADS7871)	+= ads7871.o
>> +obj-$(CONFIG_SENSORS_ADT7X10)	+= adt7x10.o
>> +obj-$(CONFIG_SENSORS_ADT7310)	+= adt7310.o
>>  obj-$(CONFIG_SENSORS_ADT7410)	+= adt7410.o
>>  obj-$(CONFIG_SENSORS_ADT7411)	+= adt7411.o
>>  obj-$(CONFIG_SENSORS_ADT7462)	+= adt7462.o
>> diff --git a/drivers/hwmon/adt7310.c b/drivers/hwmon/adt7310.c
>> new file mode 100644
>> index 0000000..0483e6c
>> --- /dev/null
>> +++ b/drivers/hwmon/adt7310.c
>> @@ -0,0 +1,160 @@
>> +/*
>> + * ADT7310/ADT7310 digital temperature sensor driver
>> + *
>> + * Copyright 2010-2013 Analog Devices Inc.
>> + *   Author: Lars-Peter Clausen <lars@metafoo.de>
>> + *
>> + * Licensed under the GPL-2 or later.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/spi/spi.h>
>> +
>> +#include "adt7x10.h"
>> +
>> +static const u8 adt7371_reg_table[] = {
>> +	[ADT7410_TEMPERATURE]   = ADT7310_TEMPERATURE,
>> +	[ADT7410_STATUS]	= ADT7310_STATUS,
>> +	[ADT7410_CONFIG]	= ADT7310_CONFIG,
>> +	[ADT7410_T_ALARM_HIGH]	= ADT7310_T_ALARM_HIGH,
>> +	[ADT7410_T_ALARM_LOW]	= ADT7310_T_ALARM_LOW,
>> +	[ADT7410_T_CRIT]	= ADT7310_T_CRIT,
>> +	[ADT7410_T_HYST]	= ADT7310_T_HYST,
>> +	[ADT7410_ID]		= ADT7310_ID,
>> +};
>> +
>> +#define ADT7310_CMD_REG_MASK			0x28
>> +#define ADT7310_CMD_REG_OFFSET			3
>> +#define ADT7310_CMD_READ			0x40
>> +#define ADT7310_CMD_CON_READ			0x4
>> +
>> +#define AD7310_COMMAND(reg) (adt7371_reg_table[(reg)] << ADT7310_CMD_REG_OFFSET)
>> +
>> +static int adt7310_spi_read_word(struct device *dev,
>> +	u8 reg, u16 *data)
> 
> I don't really like the approach of separating the return value from the error
> code, if both can be returned directly. There are two reasons: First, the code
> gets more complex, and second, the compiler tends to get confused under some
> conditions abd believe that the return value is not set. And I really don't want
> to have to deal with the resulting build warnings, after getting rid of pretty
> much all such warnings in the hwmon subsystem. So I'd really appreciate if you
> could rewrite this and the subsequent patches to return both error and value as
> function return values.
> 

I can change it, but I don't think that the current code will confuse the
compiler, the return value is set under all circumstances. And the code
actually gets slightly more complex by rewriting it. Most of the time we don't
want to store the result of the read operation on stack but rather somewhere else.

	ret = adt7410_read_word(dev, TEMP);
	if (ret < 0) {
		...
	}
	data->temp[0] = ret;

Without the change we can write it as:

	ret = adt7410_read_word(dev, TEMP, &data->temp[0])
	if (ret) {
		...
	}

The difference is not that big, so I won't argue over it if you prefer the
first version.

Thanks,
- Lars

>> +{
>> +	struct spi_device *spi = to_spi_device(dev);
>> +	u8 command = AD7310_COMMAND(reg);
>> +	int ret = 0;
>> +
>> +	command |= ADT7310_CMD_READ;
>> +	ret = spi_write(spi, &command, sizeof(command));
>> +	if (ret < 0) {
>> +		dev_err(dev, "SPI write command error\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = spi_read(spi, (u8 *)data, sizeof(*data));
>> +	if (ret < 0) {
>> +		dev_err(dev, "SPI read word error\n");
>> +		return ret;
>> +	}
>> +
>> +	*data = be16_to_cpu(*data);
>> +
>> +	return 0;
>> +}
>> +
>> +static int adt7310_spi_write_word(struct device *dev, u8 reg,
>> +	u16 data)
>> +{
>> +	struct spi_device *spi = to_spi_device(dev);
>> +	u8 buf[3];
>> +	int ret = 0;
>> +
>> +	buf[0] = AD7310_COMMAND(reg);
>> +	buf[1] = (u8)(data >> 8);
>> +	buf[2] = (u8)(data & 0xFF);
>> +
>> +	ret = spi_write(spi, buf, 3);
>> +	if (ret < 0) {
>> +		dev_err(dev, "SPI write word error\n");
>> +		return ret;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int adt7310_spi_read_byte(struct device *dev, u8 reg,
>> +	u8 *data)
>> +{
>> +	struct spi_device *spi = to_spi_device(dev);
>> +	u8 command = AD7310_COMMAND(reg);
>> +	int ret = 0;
>> +
>> +	command |= ADT7310_CMD_READ;
>> +	ret = spi_write(spi, &command, sizeof(command));
>> +	if (ret < 0) {
>> +		dev_err(dev, "SPI write command error\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = spi_read(spi, data, sizeof(*data));
>> +	if (ret < 0) {
>> +		dev_err(dev, "SPI read byte error\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int adt7310_spi_write_byte(struct device *dev, u8 reg,
>> +	u8 data)
>> +{
>> +	struct spi_device *spi = to_spi_device(dev);
>> +	u8 buf[2];
>> +	int ret = 0;
>> +
>> +	buf[0] = AD7310_COMMAND(reg);
>> +	buf[1] = data;
>> +
>> +	ret = spi_write(spi, buf, 2);
>> +	if (ret < 0) {
>> +		dev_err(dev, "SPI write byte error\n");
>> +		return ret;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct adt7410_ops adt7310_spi_ops = {
>> +	.read_word = adt7310_spi_read_word,
>> +	.write_word = adt7310_spi_write_word,
>> +	.read_byte = adt7310_spi_read_byte,
>> +	.write_byte = adt7310_spi_write_byte,
>> +};
>> +
>> +static int adt7310_spi_probe(struct spi_device *spi)
>> +{
>> +	return adt7410_probe(&spi->dev, spi_get_device_id(spi)->name,
>> +			&adt7310_spi_ops);
>> +}
>> +
>> +static int adt7310_spi_remove(struct spi_device *spi)
>> +{
>> +	return adt7410_remove(&spi->dev);
>> +}
>> +
>> +static const struct spi_device_id adt7310_id[] = {
>> +	{ "adt7310", 0 },
>> +	{ "adt7320", 0 },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(spi, adt7310_id);
>> +
>> +static struct spi_driver adt7310_driver = {
>> +	.driver = {
>> +		.name = "adt7310",
>> +		.owner = THIS_MODULE,
>> +		.pm	= ADT7410_DEV_PM_OPS,
>> +	},
>> +	.probe = adt7310_spi_probe,
>> +	.remove = adt7310_spi_remove,
>> +	.id_table = adt7310_id,
>> +};
>> +module_spi_driver(adt7310_driver);
>> +
>> +MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
>> +MODULE_DESCRIPTION("ADT7310/ADT7420 driver");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/hwmon/adt7410.c b/drivers/hwmon/adt7410.c
>> index 5de0376..13734c5 100644
>> --- a/drivers/hwmon/adt7410.c
>> +++ b/drivers/hwmon/adt7410.c
>> @@ -1,483 +1,117 @@
>>  /*
>> - * adt7410.c - Part of lm_sensors, Linux kernel modules for hardware
>> - *	 monitoring
>> - * This driver handles the ADT7410 and compatible digital temperature sensors.
>> - * Hartmut Knaack <knaack.h@gmx.de> 2012-07-22
>> - * based on lm75.c by Frodo Looijaard <frodol@dds.nl>
>> - * and adt7410.c from iio-staging by Sonic Zhang <sonic.zhang@analog.com>
>> + * ADT7410/ADT7420 digital temperature sensor driver
>>   *
>> - * This program is free software; you can redistribute it and/or modify
>> - * it under the terms of the GNU General Public License as published by
>> - * the Free Software Foundation; either version 2 of the License, or
>> - * (at your option) any later version.
>> + * Copyright 2010-2013 Analog Devices Inc.
>> + *   Author: Lars-Peter Clausen <lars@metafoo.de>
>>   *
>> - * This program is distributed in the hope that it will be useful,
>> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> - * GNU General Public License for more details.
>> - *
>> - * You should have received a copy of the GNU General Public License
>> - * along with this program; if not, write to the Free Software
>> - * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>> + * Licensed under the GPL-2 or later.
>>   */
>>  
>>  #include <linux/module.h>
>>  #include <linux/init.h>
>> -#include <linux/slab.h>
>> -#include <linux/jiffies.h>
>>  #include <linux/i2c.h>
>> -#include <linux/hwmon.h>
>> -#include <linux/hwmon-sysfs.h>
>> -#include <linux/err.h>
>> -#include <linux/mutex.h>
>> -#include <linux/delay.h>
>> -
>> -/*
>> - * ADT7410 registers definition
>> - */
>>  
>> -#define ADT7410_TEMPERATURE		0
>> -#define ADT7410_STATUS			2
>> -#define ADT7410_CONFIG			3
>> -#define ADT7410_T_ALARM_HIGH		4
>> -#define ADT7410_T_ALARM_LOW		6
>> -#define ADT7410_T_CRIT			8
>> -#define ADT7410_T_HYST			0xA
>> +#include "adt7x10.h"
>>  
>> -/*
>> - * ADT7410 status
>> - */
>> -#define ADT7410_STAT_T_LOW		(1 << 4)
>> -#define ADT7410_STAT_T_HIGH		(1 << 5)
>> -#define ADT7410_STAT_T_CRIT		(1 << 6)
>> -#define ADT7410_STAT_NOT_RDY		(1 << 7)
>> -
>> -/*
>> - * ADT7410 config
>> - */
>> -#define ADT7410_FAULT_QUEUE_MASK	(1 << 0 | 1 << 1)
>> -#define ADT7410_CT_POLARITY		(1 << 2)
>> -#define ADT7410_INT_POLARITY		(1 << 3)
>> -#define ADT7410_EVENT_MODE		(1 << 4)
>> -#define ADT7410_MODE_MASK		(1 << 5 | 1 << 6)
>> -#define ADT7410_FULL			(0 << 5 | 0 << 6)
>> -#define ADT7410_PD			(1 << 5 | 1 << 6)
>> -#define ADT7410_RESOLUTION		(1 << 7)
>> -
>> -/*
>> - * ADT7410 masks
>> - */
>> -#define ADT7410_T13_VALUE_MASK			0xFFF8
>> -#define ADT7410_T_HYST_MASK			0xF
>> -
>> -/* straight from the datasheet */
>> -#define ADT7410_TEMP_MIN (-55000)
>> -#define ADT7410_TEMP_MAX 150000
>> -
>> -enum adt7410_type {		/* keep sorted in alphabetical order */
>> -	adt7410,
>> -};
>> -
>> -static const u8 ADT7410_REG_TEMP[4] = {
>> -	ADT7410_TEMPERATURE,		/* input */
>> -	ADT7410_T_ALARM_HIGH,		/* high */
>> -	ADT7410_T_ALARM_LOW,		/* low */
>> -	ADT7410_T_CRIT,			/* critical */
>> -};
>> -
>> -/* Each client has this additional data */
>> -struct adt7410_data {
>> -	struct device		*hwmon_dev;
>> -	struct mutex		update_lock;
>> -	u8			config;
>> -	u8			oldconfig;
>> -	bool			valid;		/* true if registers valid */
>> -	unsigned long		last_updated;	/* In jiffies */
>> -	s16			temp[4];	/* Register values,
>> -						   0 = input
>> -						   1 = high
>> -						   2 = low
>> -						   3 = critical */
>> -	u8			hyst;		/* hysteresis offset */
>> -};
>> -
>> -/*
>> - * adt7410 register access by I2C
>> - */
>> -static int adt7410_temp_ready(struct i2c_client *client)
>> -{
>> -	int i, status;
>> -
>> -	for (i = 0; i < 6; i++) {
>> -		status = i2c_smbus_read_byte_data(client, ADT7410_STATUS);
>> -		if (status < 0)
>> -			return status;
>> -		if (!(status & ADT7410_STAT_NOT_RDY))
>> -			return 0;
>> -		msleep(60);
>> -	}
>> -	return -ETIMEDOUT;
>> -}
>> -
>> -static int adt7410_update_temp(struct device *dev)
>> +static int adt7410_i2c_read_word(struct device *dev, u8 reg, u16 *data)
>>  {
>>  	struct i2c_client *client = to_i2c_client(dev);
>> -	struct adt7410_data *data = i2c_get_clientdata(client);
>>  	int ret = 0;
>>  
>> -	mutex_lock(&data->update_lock);
>> -
>> -	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
>> -	    || !data->valid) {
>> -
>> -		dev_dbg(&client->dev, "Starting update\n");
>> -
>> -		ret = adt7410_temp_ready(client); /* check for new value */
>> -		if (ret)
>> -			goto abort;
>> -
>> -		ret = i2c_smbus_read_word_swapped(client, ADT7410_REG_TEMP[0]);
>> -		if (ret) {
>> -			dev_dbg(dev, "Failed to read value: reg %d, error %d\n",
>> -				ADT7410_REG_TEMP[0], ret);
>> -			goto abort;
>> -		}
>> -		data->temp[0] = ret;
>> -
>> -		data->last_updated = jiffies;
>> -		data->valid = true;
>> -	}
>> -
>> -abort:
>> -	mutex_unlock(&data->update_lock);
>> -	return ret;
>> -}
>> -
>> -static int adt7410_fill_cache(struct i2c_client *client)
>> -{
>> -	struct adt7410_data *data = i2c_get_clientdata(client);
>> -	int ret;
>> -	int i;
>> -
>> -	for (i = 1; i < 3; i++) {
>> -		ret = i2c_smbus_read_word_swapped(client, ADT7410_REG_TEMP[i]);
>> -		if (ret) {
>> -			dev_dbg(&client->dev,
>> -				"Failed to read value: reg %d, error %d\n",
>> -				ADT7410_REG_TEMP[0], ret);
>> -			return ret;
>> -		}
>> -		data->temp[i] = ret;
>> -	}
>> -
>> -	ret = i2c_smbus_read_byte_data(client, ADT7410_T_HYST);
>> -	if (ret) {
>> -		dev_dbg(&client->dev,
>> -			"Failed to read value: hyst reg, error %d\n",
>> -			ret);
>> +	ret = i2c_smbus_read_word_swapped(client, reg);
>> +	if (ret < 0) {
>> +		dev_err(dev, "I2C read error\n");
>>  		return ret;
>>  	}
>> -	data->hyst = ret;
>> -
>> -	return 0;
>> -}
>>  
>> -static s16 ADT7410_TEMP_TO_REG(long temp)
>> -{
>> -	return DIV_ROUND_CLOSEST(clamp_val(temp, ADT7410_TEMP_MIN,
>> -					   ADT7410_TEMP_MAX) * 128, 1000);
>> -}
>> +	*data = ret;
>>  
>> -static int ADT7410_REG_TO_TEMP(struct adt7410_data *data, s16 reg)
>> -{
>> -	/* in 13 bit mode, bits 0-2 are status flags - mask them out */
>> -	if (!(data->config & ADT7410_RESOLUTION))
>> -		reg &= ADT7410_T13_VALUE_MASK;
>> -	/*
>> -	 * temperature is stored in twos complement format, in steps of
>> -	 * 1/128°C
>> -	 */
>> -	return DIV_ROUND_CLOSEST(reg * 1000, 128);
>> +	return 0;
>>  }
>>  
>> -/*-----------------------------------------------------------------------*/
>> -
>> -/* sysfs attributes for hwmon */
>> -
>> -static ssize_t adt7410_show_temp(struct device *dev,
>> -				 struct device_attribute *da, char *buf)
>> +static int adt7410_i2c_write_word(struct device *dev, u8 reg, u16 data)
>>  {
>> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
>>  	struct i2c_client *client = to_i2c_client(dev);
>> -	struct adt7410_data *data = i2c_get_clientdata(client);
>> -
>> -	if (attr->index == 0) {
>> -		int ret;
>> +	int ret = 0;
>>  
>> -		ret = adt7410_update_temp(dev);
>> -		if (ret)
>> -			return ret;
>> -	}
>> +	ret = i2c_smbus_write_word_swapped(client, reg, data);
>> +	if (ret < 0)
>> +		dev_err(dev, "I2C write error\n");
>>  
>> -	return sprintf(buf, "%d\n", ADT7410_REG_TO_TEMP(data,
>> -		       data->temp[attr->index]));
>> +	return ret;
>>  }
>>  
>> -static ssize_t adt7410_set_temp(struct device *dev,
>> -				struct device_attribute *da,
>> -				const char *buf, size_t count)
>> +static int adt7410_i2c_read_byte(struct device *dev, u8 reg, u8 *data)
>>  {
>> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
>>  	struct i2c_client *client = to_i2c_client(dev);
>> -	struct adt7410_data *data = i2c_get_clientdata(client);
>> -	int nr = attr->index;
>> -	long temp;
>> -	int ret;
>> +	int ret = 0;
>>  
>> -	ret = kstrtol(buf, 10, &temp);
>> -	if (ret)
>> +	ret = i2c_smbus_read_byte_data(client, reg);
>> +	if (ret < 0) {
>> +		dev_err(dev, "I2C read error\n");
>>  		return ret;
>> +	}
>>  
>> -	mutex_lock(&data->update_lock);
>> -	data->temp[nr] = ADT7410_TEMP_TO_REG(temp);
>> -	ret = i2c_smbus_write_word_swapped(client, ADT7410_REG_TEMP[nr],
>> -					   data->temp[nr]);
>> -	if (ret)
>> -		count = ret;
>> -	mutex_unlock(&data->update_lock);
>> -	return count;
>> -}
>> -
>> -static ssize_t adt7410_show_t_hyst(struct device *dev,
>> -				   struct device_attribute *da,
>> -				   char *buf)
>> -{
>> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
>> -	struct i2c_client *client = to_i2c_client(dev);
>> -	struct adt7410_data *data = i2c_get_clientdata(client);
>> -	int nr = attr->index;
>> -	int hyst;
>> -
>> -	hyst = (data->hyst & ADT7410_T_HYST_MASK) * 1000;
>> -
>> -	/*
>> -	 * hysteresis is stored as a 4 bit offset in the device, convert it
>> -	 * to an absolute value
>> -	 */
>> -	if (nr == 2)	/* min has positive offset, others have negative */
>> -		hyst = -hyst;
>> -	return sprintf(buf, "%d\n",
>> -		       ADT7410_REG_TO_TEMP(data, data->temp[nr]) - hyst);
>> -}
>> -
>> -static ssize_t adt7410_set_t_hyst(struct device *dev,
>> -				  struct device_attribute *da,
>> -				  const char *buf, size_t count)
>> -{
>> -	struct i2c_client *client = to_i2c_client(dev);
>> -	struct adt7410_data *data = i2c_get_clientdata(client);
>> -	int limit, ret;
>> -	long hyst;
>> -
>> -	ret = kstrtol(buf, 10, &hyst);
>> -	if (ret)
>> -		return ret;
>> -	/* convert absolute hysteresis value to a 4 bit delta value */
>> -	limit = ADT7410_REG_TO_TEMP(data, data->temp[1]);
>> -	hyst = clamp_val(hyst, ADT7410_TEMP_MIN, ADT7410_TEMP_MAX);
>> -	data->hyst = clamp_val(DIV_ROUND_CLOSEST(limit - hyst, 1000), 0,
>> -			       ADT7410_T_HYST_MASK);
>> -	ret = i2c_smbus_write_byte_data(client, ADT7410_T_HYST, data->hyst);
>> -	if (ret)
>> -		return ret;
>> +	*data = (u8)ret;
>>  
>> -	return count;
>> +	return 0;
>>  }
>>  
>> -static ssize_t adt7410_show_alarm(struct device *dev,
>> -				  struct device_attribute *da,
>> -				  char *buf)
>> +static int adt7410_i2c_write_byte(struct device *dev, u8 reg, u8 data)
>>  {
>>  	struct i2c_client *client = to_i2c_client(dev);
>> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
>> -	int ret;
>> +	int ret = 0;
>>  
>> -	ret = i2c_smbus_read_byte_data(client, ADT7410_STATUS);
>> +	ret = i2c_smbus_write_byte_data(client, reg, data);
>>  	if (ret < 0)
>> -		return ret;
>> +		dev_err(&client->dev, "I2C write error\n");
>>  
>> -	return sprintf(buf, "%d\n", !!(ret & attr->index));
>> +	return ret;
>>  }
>>  
>> -static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, adt7410_show_temp, NULL, 0);
>> -static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO,
>> -			  adt7410_show_temp, adt7410_set_temp, 1);
>> -static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO,
>> -			  adt7410_show_temp, adt7410_set_temp, 2);
>> -static SENSOR_DEVICE_ATTR(temp1_crit, S_IWUSR | S_IRUGO,
>> -			  adt7410_show_temp, adt7410_set_temp, 3);
>> -static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO,
>> -			  adt7410_show_t_hyst, adt7410_set_t_hyst, 1);
>> -static SENSOR_DEVICE_ATTR(temp1_min_hyst, S_IRUGO,
>> -			  adt7410_show_t_hyst, NULL, 2);
>> -static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IRUGO,
>> -			  adt7410_show_t_hyst, NULL, 3);
>> -static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, adt7410_show_alarm,
>> -			  NULL, ADT7410_STAT_T_LOW);
>> -static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, adt7410_show_alarm,
>> -			  NULL, ADT7410_STAT_T_HIGH);
>> -static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, adt7410_show_alarm,
>> -			  NULL, ADT7410_STAT_T_CRIT);
>> -
>> -static struct attribute *adt7410_attributes[] = {
>> -	&sensor_dev_attr_temp1_input.dev_attr.attr,
>> -	&sensor_dev_attr_temp1_max.dev_attr.attr,
>> -	&sensor_dev_attr_temp1_min.dev_attr.attr,
>> -	&sensor_dev_attr_temp1_crit.dev_attr.attr,
>> -	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
>> -	&sensor_dev_attr_temp1_min_hyst.dev_attr.attr,
>> -	&sensor_dev_attr_temp1_crit_hyst.dev_attr.attr,
>> -	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
>> -	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
>> -	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
>> -	NULL
>> -};
>> -
>> -static const struct attribute_group adt7410_group = {
>> -	.attrs = adt7410_attributes,
>> +static const struct adt7410_ops adt7410_i2c_ops = {
>> +	.read_word = adt7410_i2c_read_word,
>> +	.write_word = adt7410_i2c_write_word,
>> +	.read_byte = adt7410_i2c_read_byte,
>> +	.write_byte = adt7410_i2c_write_byte,
>>  };
>>  
>> -/*-----------------------------------------------------------------------*/
>> -
>> -/* device probe and removal */
>> -
>> -static int adt7410_probe(struct i2c_client *client,
>> -			 const struct i2c_device_id *id)
>> +static int adt7410_i2c_probe(struct i2c_client *client,
>> +	const struct i2c_device_id *id)
>>  {
>> -	struct adt7410_data *data;
>> -	int ret;
>>  
>>  	if (!i2c_check_functionality(client->adapter,
>>  			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
>>  		return -ENODEV;
>>  
>> -	data = devm_kzalloc(&client->dev, sizeof(struct adt7410_data),
>> -			    GFP_KERNEL);
>> -	if (!data)
>> -		return -ENOMEM;
>> -
>> -	i2c_set_clientdata(client, data);
>> -	mutex_init(&data->update_lock);
>> -
>> -	/* configure as specified */
>> -	ret = i2c_smbus_read_byte_data(client, ADT7410_CONFIG);
>> -	if (ret < 0) {
>> -		dev_dbg(&client->dev, "Can't read config? %d\n", ret);
>> -		return ret;
>> -	}
>> -	data->oldconfig = ret;
>> -	/*
>> -	 * Set to 16 bit resolution, continous conversion and comparator mode.
>> -	 */
>> -	ret &= ~ADT7410_MODE_MASK;
>> -	data->config = ret | ADT7410_FULL | ADT7410_RESOLUTION |
>> -			ADT7410_EVENT_MODE;
>> -	if (data->config != data->oldconfig) {
>> -		ret = i2c_smbus_write_byte_data(client, ADT7410_CONFIG,
>> -						data->config);
>> -		if (ret)
>> -			return ret;
>> -	}
>> -	dev_dbg(&client->dev, "Config %02x\n", data->config);
>> -
>> -	ret = adt7410_fill_cache(client);
>> -	if (ret)
>> -		goto exit_restore;
>> -
>> -	/* Register sysfs hooks */
>> -	ret = sysfs_create_group(&client->dev.kobj, &adt7410_group);
>> -	if (ret)
>> -		goto exit_restore;
>> -
>> -	data->hwmon_dev = hwmon_device_register(&client->dev);
>> -	if (IS_ERR(data->hwmon_dev)) {
>> -		ret = PTR_ERR(data->hwmon_dev);
>> -		goto exit_remove;
>> -	}
>> -
>> -	dev_info(&client->dev, "sensor '%s'\n", client->name);
>> -
>> -	return 0;
>> -
>> -exit_remove:
>> -	sysfs_remove_group(&client->dev.kobj, &adt7410_group);
>> -exit_restore:
>> -	i2c_smbus_write_byte_data(client, ADT7410_CONFIG, data->oldconfig);
>> -	return ret;
>> +	return adt7410_probe(&client->dev, NULL, &adt7410_i2c_ops);
>>  }
>>  
>> -static int adt7410_remove(struct i2c_client *client)
>> +static int adt7410_i2c_remove(struct i2c_client *client)
>>  {
>> -	struct adt7410_data *data = i2c_get_clientdata(client);
>> -
>> -	hwmon_device_unregister(data->hwmon_dev);
>> -	sysfs_remove_group(&client->dev.kobj, &adt7410_group);
>> -	if (data->oldconfig != data->config)
>> -		i2c_smbus_write_byte_data(client, ADT7410_CONFIG,
>> -					  data->oldconfig);
>> -	return 0;
>> +	return adt7410_remove(&client->dev);
>>  }
>>  
>> -static const struct i2c_device_id adt7410_ids[] = {
>> -	{ "adt7410", adt7410, },
>> -	{ "adt7420", adt7410, },
>> -	{ /* LIST END */ }
>> +static const struct i2c_device_id adt7410_id[] = {
>> +	{ "adt7410", 0 },
>> +	{ "adt7420", 0 },
>> +	{}
>>  };
>> -MODULE_DEVICE_TABLE(i2c, adt7410_ids);
>> -
>> -#ifdef CONFIG_PM_SLEEP
>> -static int adt7410_suspend(struct device *dev)
>> -{
>> -	int ret;
>> -	struct i2c_client *client = to_i2c_client(dev);
>> -	struct adt7410_data *data = i2c_get_clientdata(client);
>> -
>> -	ret = i2c_smbus_write_byte_data(client, ADT7410_CONFIG,
>> -					data->config | ADT7410_PD);
>> -	return ret;
>> -}
>> -
>> -static int adt7410_resume(struct device *dev)
>> -{
>> -	int ret;
>> -	struct i2c_client *client = to_i2c_client(dev);
>> -	struct adt7410_data *data = i2c_get_clientdata(client);
>> -
>> -	ret = i2c_smbus_write_byte_data(client, ADT7410_CONFIG, data->config);
>> -	return ret;
>> -}
>> -
>> -static SIMPLE_DEV_PM_OPS(adt7410_dev_pm_ops, adt7410_suspend, adt7410_resume);
>> -
>> -#define ADT7410_DEV_PM_OPS (&adt7410_dev_pm_ops)
>> -#else
>> -#define ADT7410_DEV_PM_OPS NULL
>> -#endif /* CONFIG_PM */
>> +MODULE_DEVICE_TABLE(i2c, adt7410_id);
>>  
>>  static struct i2c_driver adt7410_driver = {
>> -	.class		= I2C_CLASS_HWMON,
>>  	.driver = {
>> -		.name	= "adt7410",
>> +		.name = "adt7410",
>>  		.pm	= ADT7410_DEV_PM_OPS,
>>  	},
>> -	.probe		= adt7410_probe,
>> -	.remove		= adt7410_remove,
>> -	.id_table	= adt7410_ids,
>> -	.address_list	= I2C_ADDRS(0x48, 0x49, 0x4a, 0x4b),
>> +	.probe = adt7410_i2c_probe,
>> +	.remove = adt7410_i2c_remove,
>> +	.id_table = adt7410_id,
>> +	.address_list = I2C_ADDRS(0x48, 0x49, 0x4a, 0x4b),
>> +	.class = I2C_CLASS_HWMON,
>>  };
>> -
>>  module_i2c_driver(adt7410_driver);
>>  
>> -MODULE_AUTHOR("Hartmut Knaack");
>> -MODULE_DESCRIPTION("ADT7410/ADT7420 driver");
>> +MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
>> +MODULE_DESCRIPTION("ADT7410/AD7420 driver");
>>  MODULE_LICENSE("GPL");
>> diff --git a/drivers/hwmon/adt7x10.c b/drivers/hwmon/adt7x10.c
>> new file mode 100644
>> index 0000000..2598aaf
>> --- /dev/null
>> +++ b/drivers/hwmon/adt7x10.c
>> @@ -0,0 +1,476 @@
>> +/*
>> + * adt7410.c - Part of lm_sensors, Linux kernel modules for hardware
>> + *	 monitoring
>> + * This driver handles the ADT7410 and compatible digital temperature sensors.
>> + * Hartmut Knaack <knaack.h@gmx.de> 2012-07-22
>> + * based on lm75.c by Frodo Looijaard <frodol@dds.nl>
>> + * and adt7410.c from iio-staging by Sonic Zhang <sonic.zhang@analog.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/slab.h>
>> +#include <linux/jiffies.h>
>> +#include <linux/hwmon.h>
>> +#include <linux/hwmon-sysfs.h>
>> +#include <linux/err.h>
>> +#include <linux/mutex.h>
>> +#include <linux/delay.h>
>> +
>> +#include "adt7x10.h"
>> +
>> +/*
>> + * ADT7410 status
>> + */
>> +#define ADT7410_STAT_T_LOW		(1 << 4)
>> +#define ADT7410_STAT_T_HIGH		(1 << 5)
>> +#define ADT7410_STAT_T_CRIT		(1 << 6)
>> +#define ADT7410_STAT_NOT_RDY		(1 << 7)
>> +
>> +/*
>> + * ADT7410 config
>> + */
>> +#define ADT7410_FAULT_QUEUE_MASK	(1 << 0 | 1 << 1)
>> +#define ADT7410_CT_POLARITY		(1 << 2)
>> +#define ADT7410_INT_POLARITY		(1 << 3)
>> +#define ADT7410_EVENT_MODE		(1 << 4)
>> +#define ADT7410_MODE_MASK		(1 << 5 | 1 << 6)
>> +#define ADT7410_FULL			(0 << 5 | 0 << 6)
>> +#define ADT7410_PD			(1 << 5 | 1 << 6)
>> +#define ADT7410_RESOLUTION		(1 << 7)
>> +
>> +/*
>> + * ADT7410 masks
>> + */
>> +#define ADT7410_T13_VALUE_MASK			0xFFF8
>> +#define ADT7410_T_HYST_MASK			0xF
>> +
>> +/* straight from the datasheet */
>> +#define ADT7410_TEMP_MIN (-55000)
>> +#define ADT7410_TEMP_MAX 150000
>> +
>> +/* Each client has this additional data */
>> +struct adt7410_data {
>> +	const struct adt7410_ops *ops;
>> +	const char		*name;
>> +	struct device		*hwmon_dev;
>> +	struct mutex		update_lock;
>> +	u8			config;
>> +	u8			oldconfig;
>> +	bool			valid;		/* true if registers valid */
>> +	unsigned long		last_updated;	/* In jiffies */
>> +	s16			temp[4];	/* Register values,
>> +						   0 = input
>> +						   1 = high
>> +						   2 = low
>> +						   3 = critical */
>> +	u8			hyst;		/* hysteresis offset */
>> +};
>> +
>> +static int adt7410_read_word(struct device *dev, u8 reg, u16 *data)
>> +{
>> +	struct adt7410_data *d = dev_get_drvdata(dev);
>> +	return d->ops->read_word(dev, reg, data);
>> +}
>> +
>> +static int adt7410_write_word(struct device *dev, u8 reg, u16 data)
>> +{
>> +	struct adt7410_data *d = dev_get_drvdata(dev);
>> +	return d->ops->write_word(dev, reg, data);
>> +}
>> +
>> +static int adt7410_read_byte(struct device *dev, u8 reg, u8 *data)
>> +{
>> +	struct adt7410_data *d = dev_get_drvdata(dev);
>> +	return d->ops->read_byte(dev, reg, data);
>> +}
>> +
>> +static int adt7410_write_byte(struct device *dev, u8 reg, u8 data)
>> +{
>> +	struct adt7410_data *d = dev_get_drvdata(dev);
>> +	return d->ops->write_byte(dev, reg, data);
>> +}
>> +
>> +static const u8 ADT7410_REG_TEMP[4] = {
>> +	ADT7410_TEMPERATURE,		/* input */
>> +	ADT7410_T_ALARM_HIGH,		/* high */
>> +	ADT7410_T_ALARM_LOW,		/* low */
>> +	ADT7410_T_CRIT,			/* critical */
>> +};
>> +
>> +/*
>> + * adt7410 register access by I2C
>> + */
>> +static int adt7410_temp_ready(struct device *dev)
>> +{
>> +	int i, ret;
>> +	u8 status;
>> +
>> +	for (i = 0; i < 6; i++) {
>> +		ret = adt7410_read_byte(dev, ADT7410_STATUS, &status);
>> +		if (ret)
>> +			return ret;
>> +		if (!(status & ADT7410_STAT_NOT_RDY))
>> +			return 0;
>> +		msleep(60);
>> +	}
>> +	return -ETIMEDOUT;
>> +}
>> +
>> +static int adt7410_update_temp(struct device *dev)
>> +{
>> +	struct adt7410_data *data = dev_get_drvdata(dev);
>> +	int ret = 0;
>> +
>> +	mutex_lock(&data->update_lock);
>> +
>> +	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
>> +	    || !data->valid) {
>> +
>> +		dev_dbg(dev, "Starting update\n");
>> +
>> +		ret = adt7410_temp_ready(dev); /* check for new value */
>> +		if (ret)
>> +			goto abort;
>> +
>> +		ret = adt7410_read_word(dev, ADT7410_REG_TEMP[0],
>> +					&data->temp[0]);
>> +		if (ret) {
>> +			dev_dbg(dev, "Failed to read value: reg %d, error %d\n",
>> +				ADT7410_REG_TEMP[0], ret);
>> +			goto abort;
>> +		}
>> +		data->last_updated = jiffies;
>> +		data->valid = true;
>> +	}
>> +
>> +abort:
>> +	mutex_unlock(&data->update_lock);
>> +	return ret;
>> +}
>> +
>> +static int adt7410_fill_cache(struct device *dev)
>> +{
>> +	struct adt7410_data *data = dev_get_drvdata(dev);
>> +	int ret;
>> +	int i;
>> +
>> +	for (i = 1; i < ARRAY_SIZE(data->temp); i++) {
>> +		ret = adt7410_read_word(dev, ADT7410_REG_TEMP[i],
>> +					&data->temp[i]);
>> +		if (ret) {
>> +			dev_dbg(dev, "Failed to read value: reg %d, error %d\n",
>> +				ADT7410_REG_TEMP[0], ret);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	ret = adt7410_read_byte(dev, ADT7410_T_HYST, &data->hyst);
>> +	if (ret) {
>> +		dev_dbg(dev, "Failed to read value: reg %d, error %d\n",
>> +				ADT7410_T_HYST, ret);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static s16 ADT7410_TEMP_TO_REG(long temp)
>> +{
>> +	return DIV_ROUND_CLOSEST(clamp_val(temp, ADT7410_TEMP_MIN,
>> +					       ADT7410_TEMP_MAX) * 128, 1000);
>> +}
>> +
>> +static int ADT7410_REG_TO_TEMP(struct adt7410_data *data, s16 reg)
>> +{
>> +	/* in 13 bit mode, bits 0-2 are status flags - mask them out */
>> +	if (!(data->config & ADT7410_RESOLUTION))
>> +		reg &= ADT7410_T13_VALUE_MASK;
>> +	/*
>> +	 * temperature is stored in twos complement format, in steps of
>> +	 * 1/128°C
>> +	 */
>> +	return DIV_ROUND_CLOSEST(reg * 1000, 128);
>> +}
>> +
>> +/*-----------------------------------------------------------------------*/
>> +
>> +/* sysfs attributes for hwmon */
>> +
>> +static ssize_t adt7410_show_temp(struct device *dev,
>> +				 struct device_attribute *da, char *buf)
>> +{
>> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
>> +	struct adt7410_data *data = dev_get_drvdata(dev);
>> +
>> +
>> +	if (attr->index == 0) {
>> +		int ret;
>> +
>> +		ret = adt7410_update_temp(dev);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return sprintf(buf, "%d\n", ADT7410_REG_TO_TEMP(data,
>> +		       data->temp[attr->index]));
>> +}
>> +
>> +static ssize_t adt7410_set_temp(struct device *dev,
>> +				struct device_attribute *da,
>> +				const char *buf, size_t count)
>> +{
>> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
>> +	struct adt7410_data *data = dev_get_drvdata(dev);
>> +	int nr = attr->index;
>> +	long temp;
>> +	int ret;
>> +
>> +	ret = kstrtol(buf, 10, &temp);
>> +	if (ret)
>> +		return ret;
>> +
>> +	mutex_lock(&data->update_lock);
>> +	data->temp[nr] = ADT7410_TEMP_TO_REG(temp);
>> +	ret = adt7410_write_word(dev, ADT7410_REG_TEMP[nr], data->temp[nr]);
>> +	if (ret)
>> +		count = ret;
>> +	mutex_unlock(&data->update_lock);
>> +	return count;
>> +}
>> +
>> +static ssize_t adt7410_show_t_hyst(struct device *dev,
>> +				   struct device_attribute *da,
>> +				   char *buf)
>> +{
>> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
>> +	struct adt7410_data *data = dev_get_drvdata(dev);
>> +	int nr = attr->index;
>> +	int hyst;
>> +
>> +	hyst = (data->hyst & ADT7410_T_HYST_MASK) * 1000;
>> +
>> +	/*
>> +	 * hysteresis is stored as a 4 bit offset in the device, convert it
>> +	 * to an absolute value
>> +	 */
>> +	if (nr == 2)	/* min has positive offset, others have negative */
>> +		hyst = -hyst;
>> +	return sprintf(buf, "%d\n",
>> +		       ADT7410_REG_TO_TEMP(data, data->temp[nr]) - hyst);
>> +}
>> +
>> +static ssize_t adt7410_set_t_hyst(struct device *dev,
>> +				  struct device_attribute *da,
>> +				  const char *buf, size_t count)
>> +{
>> +	struct adt7410_data *data = dev_get_drvdata(dev);
>> +	int limit, ret;
>> +	long hyst;
>> +
>> +	ret = kstrtol(buf, 10, &hyst);
>> +	if (ret)
>> +		return ret;
>> +	/* convert absolute hysteresis value to a 4 bit delta value */
>> +	limit = ADT7410_REG_TO_TEMP(data, data->temp[1]);
>> +	hyst = clamp_val(hyst, ADT7410_TEMP_MIN, ADT7410_TEMP_MAX);
>> +	data->hyst = clamp_val(DIV_ROUND_CLOSEST(limit - hyst, 1000),
>> +				   0, ADT7410_T_HYST_MASK);
>> +	ret = adt7410_write_byte(dev, ADT7410_T_HYST, data->hyst);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return count;
>> +}
>> +
>> +static ssize_t adt7410_show_alarm(struct device *dev,
>> +				  struct device_attribute *da,
>> +				  char *buf)
>> +{
>> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
>> +	u8 status;
>> +	int ret;
>> +
>> +	ret = adt7410_read_byte(dev, ADT7410_STATUS, &status);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return sprintf(buf, "%d\n", !!(status & attr->index));
>> +}
>> +
>> +static ssize_t adt7410_show_name(struct device *dev,
>> +				  struct device_attribute *da, char *buf)
>> +{
>> +	struct adt7410_data *data = dev_get_drvdata(dev);
>> +
>> +	return sprintf(buf, "%s\n", data->name);
>> +}
>> +
>> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, adt7410_show_temp, NULL, 0);
>> +static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO,
>> +			  adt7410_show_temp, adt7410_set_temp, 1);
>> +static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO,
>> +			  adt7410_show_temp, adt7410_set_temp, 2);
>> +static SENSOR_DEVICE_ATTR(temp1_crit, S_IWUSR | S_IRUGO,
>> +			  adt7410_show_temp, adt7410_set_temp, 3);
>> +static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO,
>> +			  adt7410_show_t_hyst, adt7410_set_t_hyst, 1);
>> +static SENSOR_DEVICE_ATTR(temp1_min_hyst, S_IRUGO,
>> +			  adt7410_show_t_hyst, NULL, 2);
>> +static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IRUGO,
>> +			  adt7410_show_t_hyst, NULL, 3);
>> +static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, adt7410_show_alarm,
>> +			  NULL, ADT7410_STAT_T_LOW);
>> +static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, adt7410_show_alarm,
>> +			  NULL, ADT7410_STAT_T_HIGH);
>> +static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, adt7410_show_alarm,
>> +			  NULL, ADT7410_STAT_T_CRIT);
>> +static DEVICE_ATTR(name, S_IRUGO, adt7410_show_name, NULL);
>> +
>> +static struct attribute *adt7410_attributes[] = {
>> +	&sensor_dev_attr_temp1_input.dev_attr.attr,
>> +	&sensor_dev_attr_temp1_max.dev_attr.attr,
>> +	&sensor_dev_attr_temp1_min.dev_attr.attr,
>> +	&sensor_dev_attr_temp1_crit.dev_attr.attr,
>> +	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
>> +	&sensor_dev_attr_temp1_min_hyst.dev_attr.attr,
>> +	&sensor_dev_attr_temp1_crit_hyst.dev_attr.attr,
>> +	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
>> +	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
>> +	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
>> +	NULL
>> +};
>> +
>> +static const struct attribute_group adt7410_group = {
>> +	.attrs = adt7410_attributes,
>> +};
>> +
>> +int adt7410_probe(struct device *dev, const char *name,
>> +	const struct adt7410_ops *ops)
>> +{
>> +	struct adt7410_data *data;
>> +	int ret;
>> +
>> +	data = devm_kzalloc(dev, sizeof(struct adt7410_data),
>> +			    GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	data->ops = ops;
>> +	data->name = name;
>> +
>> +	dev_set_drvdata(dev, data);
>> +	mutex_init(&data->update_lock);
>> +
>> +	/* configure as specified */
>> +	ret = adt7410_read_byte(dev, ADT7410_CONFIG, &data->oldconfig);
>> +	if (ret < 0) {
>> +		dev_dbg(dev, "Can't read config? %d\n", ret);
>> +		return ret;
>> +	}
>> +	/*
>> +	 * Set to 16 bit resolution, continous conversion and comparator mode.
>> +	 */
>> +	data->config = data->oldconfig;
>> +	data->config &= ~ADT7410_MODE_MASK;
>> +	data->config |= ADT7410_FULL | ADT7410_RESOLUTION | ADT7410_EVENT_MODE;
>> +	if (data->config != data->oldconfig) {
>> +		ret = adt7410_write_byte(dev, ADT7410_CONFIG, data->config);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +	dev_dbg(dev, "Config %02x\n", data->config);
>> +
>> +	ret = adt7410_fill_cache(dev);
>> +	if (ret)
>> +		goto exit_restore;
>> +
>> +	/* Register sysfs hooks */
>> +	ret = sysfs_create_group(&dev->kobj, &adt7410_group);
>> +	if (ret)
>> +		goto exit_restore;
>> +
>> +	/*
>> +	 * The I2C device will already have it's own 'name' attribute, but for
>> +	 * the SPI device we need to register it. name will only be non NULL if
>> +	 * the device doesn't register the 'name' attribute on its own.
>> +	 */
>> +	if (name) {
>> +		ret = device_create_file(dev, &dev_attr_name);
>> +		if (ret)
>> +			goto exit_remove;
>> +	}
>> +
>> +	data->hwmon_dev = hwmon_device_register(dev);
>> +	if (IS_ERR(data->hwmon_dev)) {
>> +		ret = PTR_ERR(data->hwmon_dev);
>> +		goto exit_remove_name;
>> +	}
>> +
>> +	return 0;
>> +
>> +exit_remove_name:
>> +	if (name)
>> +		device_remove_file(dev, &dev_attr_name);
>> +exit_remove:
>> +	sysfs_remove_group(&dev->kobj, &adt7410_group);
>> +exit_restore:
>> +	adt7410_write_byte(dev, ADT7410_CONFIG, data->oldconfig);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(adt7410_probe);
>> +
>> +int adt7410_remove(struct device *dev)
>> +{
>> +	struct adt7410_data *data = dev_get_drvdata(dev);
>> +
>> +	hwmon_device_unregister(data->hwmon_dev);
>> +	if (data->name)
>> +		device_remove_file(dev, &dev_attr_name);
>> +	sysfs_remove_group(&dev->kobj, &adt7410_group);
>> +	if (data->oldconfig != data->config)
>> +		adt7410_write_byte(dev, ADT7410_CONFIG,
>> +					  data->oldconfig);
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(adt7410_remove);
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +
>> +static int adt7410_suspend(struct device *dev)
>> +{
>> +	struct adt7410_data *data = dev_get_drvdata(dev);
>> +
>> +	return adt7410_write_byte(dev, ADT7410_CONFIG,
>> +		data->config | ADT7410_PD);
>> +}
>> +
>> +static int adt7410_resume(struct device *dev)
>> +{
>> +	struct adt7410_data *data = dev_get_drvdata(dev);
>> +
>> +	return adt7410_write_byte(dev, ADT7410_CONFIG, data->config);
>> +}
>> +
>> +SIMPLE_DEV_PM_OPS(adt7410_dev_pm_ops, adt7410_suspend, adt7410_resume);
>> +EXPORT_SYMBOL_GPL(adt7410_dev_pm_ops);
>> +
>> +#endif /* CONFIG_PM_SLEEP */
>> +
>> +MODULE_AUTHOR("Hartmut Knaack");
>> +MODULE_DESCRIPTION("ADT7410 driver");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/hwmon/adt7x10.h b/drivers/hwmon/adt7x10.h
>> new file mode 100644
>> index 0000000..17c8053
>> --- /dev/null
>> +++ b/drivers/hwmon/adt7x10.h
>> @@ -0,0 +1,47 @@
>> +#ifndef __HWMON_ADT7410_H__
>> +#define __HWMON_ADT7410_H__
>> +
>> +#include <linux/types.h>
>> +
>> +/* ADT7410 registers definition */
>> +#define ADT7410_TEMPERATURE		0
>> +#define ADT7410_STATUS			2
>> +#define ADT7410_CONFIG			3
>> +#define ADT7410_T_ALARM_HIGH		4
>> +#define ADT7410_T_ALARM_LOW		6
>> +#define ADT7410_T_CRIT			8
>> +#define ADT7410_T_HYST			0xA
>> +#define ADT7410_ID			0xB
>> +
>> +/* ADT7310 registers definition */
>> +#define ADT7310_STATUS			0
>> +#define ADT7310_CONFIG			1
>> +#define ADT7310_TEMPERATURE		2
>> +#define ADT7310_ID			3
>> +#define ADT7310_T_CRIT			4
>> +#define ADT7310_T_HYST			5
>> +#define ADT7310_T_ALARM_HIGH		6
>> +#define ADT7310_T_ALARM_LOW		7
>> +
>> +struct device;
>> +
>> +struct adt7410_ops {
>> +	int (*read_word)(struct device *, u8 reg, u16 *data);
>> +	int (*write_word)(struct device *, u8 reg, u16 data);
>> +	int (*read_byte)(struct device *, u8 reg, u8 *data);
>> +	int (*write_byte)(struct device *, u8 reg, u8 data);
>> +};
>> +
>> +int adt7410_probe(struct device *dev, const char *name,
>> +	const struct adt7410_ops *ops);
>> +int adt7410_remove(struct device *dev);
>> +
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +extern const struct dev_pm_ops adt7410_dev_pm_ops;
>> +#define ADT7410_DEV_PM_OPS (&adt7410_dev_pm_ops)
>> +#else
>> +#define ADT7410_DEV_PM_OPS NULL
>> +#endif
>> +
>> +#endif
>> -- 
>> 1.8.0
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

