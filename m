Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:51144 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038Ab3BOUF4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 15 Feb 2013 15:05:56 -0500
Received: from mailout-de.gmx.net ([10.1.76.12]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0LoKed-1UZAap2O5J-00gFhs for
 <linux-iio@vger.kernel.org>; Fri, 15 Feb 2013 21:05:54 +0100
Message-ID: <511E951C.6090604@gmx.de>
Date: Fri, 15 Feb 2013 21:05:48 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jean Delvare <khali@linux-fr.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@cam.ac.uk>, lm-sensors@lm-sensors.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 7/9] hwmon: (adt7410) Add support for the adt7310/adt7320
References: <1360947438-2550-1-git-send-email-lars@metafoo.de> <1360947438-2550-7-git-send-email-lars@metafoo.de>
In-Reply-To: <1360947438-2550-7-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I had a quick look over your patches and found some minor typo, see below. I will apply all the patches to see the result.
Also keep in mind to add some changes to Documentation/hwmon/adt7410 (and add an adt7310 as well?).

Lars-Peter Clausen schrieb:
<...>
> diff --git a/drivers/hwmon/adt7310.c b/drivers/hwmon/adt7310.c
> new file mode 100644
> index 0000000..0483e6c
> --- /dev/null
> +++ b/drivers/hwmon/adt7310.c
> @@ -0,0 +1,160 @@
> +/*
> + * ADT7310/ADT7310 digital temperature sensor driver
> + *
> + * Copyright 2010-2013 Analog Devices Inc.
> + *   Author: Lars-Peter Clausen <lars@metafoo.de>
> + *
> + * Licensed under the GPL-2 or later.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/spi/spi.h>
> +
> +#include "adt7x10.h"
> +
> +static const u8 adt7371_reg_table[] = {
> +	[ADT7410_TEMPERATURE]   = ADT7310_TEMPERATURE,
> +	[ADT7410_STATUS]	= ADT7310_STATUS,
> +	[ADT7410_CONFIG]	= ADT7310_CONFIG,
> +	[ADT7410_T_ALARM_HIGH]	= ADT7310_T_ALARM_HIGH,
> +	[ADT7410_T_ALARM_LOW]	= ADT7310_T_ALARM_LOW,
> +	[ADT7410_T_CRIT]	= ADT7310_T_CRIT,
> +	[ADT7410_T_HYST]	= ADT7310_T_HYST,
> +	[ADT7410_ID]		= ADT7310_ID,
> +};
Just out of curiousity, whats the reason for the name adt7371 here?
> +
> +#define ADT7310_CMD_REG_MASK			0x28
> +#define ADT7310_CMD_REG_OFFSET			3
> +#define ADT7310_CMD_READ			0x40
> +#define ADT7310_CMD_CON_READ			0x4
> +
> +#define AD7310_COMMAND(reg) (adt7371_reg_table[(reg)] << ADT7310_CMD_REG_OFFSET)
> +
> +static int adt7310_spi_read_word(struct device *dev,
> +	u8 reg, u16 *data)
> +{
> +	struct spi_device *spi = to_spi_device(dev);
> +	u8 command = AD7310_COMMAND(reg);
> +	int ret = 0;
> +
> +	command |= ADT7310_CMD_READ;
> +	ret = spi_write(spi, &command, sizeof(command));
> +	if (ret < 0) {
> +		dev_err(dev, "SPI write command error\n");
> +		return ret;
> +	}
> +
> +	ret = spi_read(spi, (u8 *)data, sizeof(*data));
> +	if (ret < 0) {
> +		dev_err(dev, "SPI read word error\n");
> +		return ret;
> +	}
> +
> +	*data = be16_to_cpu(*data);
> +
> +	return 0;
> +}
> +
> +static int adt7310_spi_write_word(struct device *dev, u8 reg,
> +	u16 data)
> +{
> +	struct spi_device *spi = to_spi_device(dev);
> +	u8 buf[3];
> +	int ret = 0;
> +
> +	buf[0] = AD7310_COMMAND(reg);
> +	buf[1] = (u8)(data >> 8);
> +	buf[2] = (u8)(data & 0xFF);
> +
> +	ret = spi_write(spi, buf, 3);
> +	if (ret < 0) {
> +		dev_err(dev, "SPI write word error\n");
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int adt7310_spi_read_byte(struct device *dev, u8 reg,
> +	u8 *data)
> +{
> +	struct spi_device *spi = to_spi_device(dev);
> +	u8 command = AD7310_COMMAND(reg);
> +	int ret = 0;
> +
> +	command |= ADT7310_CMD_READ;
> +	ret = spi_write(spi, &command, sizeof(command));
> +	if (ret < 0) {
> +		dev_err(dev, "SPI write command error\n");
> +		return ret;
> +	}
> +
> +	ret = spi_read(spi, data, sizeof(*data));
> +	if (ret < 0) {
> +		dev_err(dev, "SPI read byte error\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int adt7310_spi_write_byte(struct device *dev, u8 reg,
> +	u8 data)
> +{
> +	struct spi_device *spi = to_spi_device(dev);
> +	u8 buf[2];
> +	int ret = 0;
> +
> +	buf[0] = AD7310_COMMAND(reg);
> +	buf[1] = data;
> +
> +	ret = spi_write(spi, buf, 2);
> +	if (ret < 0) {
> +		dev_err(dev, "SPI write byte error\n");
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct adt7410_ops adt7310_spi_ops = {
> +	.read_word = adt7310_spi_read_word,
> +	.write_word = adt7310_spi_write_word,
> +	.read_byte = adt7310_spi_read_byte,
> +	.write_byte = adt7310_spi_write_byte,
> +};
> +
> +static int adt7310_spi_probe(struct spi_device *spi)
> +{
> +	return adt7410_probe(&spi->dev, spi_get_device_id(spi)->name,
> +			&adt7310_spi_ops);
> +}
> +
> +static int adt7310_spi_remove(struct spi_device *spi)
> +{
> +	return adt7410_remove(&spi->dev);
> +}
> +
> +static const struct spi_device_id adt7310_id[] = {
> +	{ "adt7310", 0 },
> +	{ "adt7320", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, adt7310_id);
> +
> +static struct spi_driver adt7310_driver = {
> +	.driver = {
> +		.name = "adt7310",
> +		.owner = THIS_MODULE,
> +		.pm	= ADT7410_DEV_PM_OPS,
> +	},
> +	.probe = adt7310_spi_probe,
> +	.remove = adt7310_spi_remove,
> +	.id_table = adt7310_id,
> +};
> +module_spi_driver(adt7310_driver);
> +
> +MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
> +MODULE_DESCRIPTION("ADT7310/ADT7420 driver");
This should be ADT7310/ADT7320, right?
> +MODULE_LICENSE("GPL");
<...>
> --- /dev/null
> +++ b/drivers/hwmon/adt7x10.c
> @@ -0,0 +1,476 @@
> +/*
> + * adt7410.c - Part of lm_sensors, Linux kernel modules for hardware
> + *	 monitoring
> + * This driver handles the ADT7410 and compatible digital temperature sensors.
> + * Hartmut Knaack <knaack.h@gmx.de> 2012-07-22
> + * based on lm75.c by Frodo Looijaard <frodol@dds.nl>
> + * and adt7410.c from iio-staging by Sonic Zhang <sonic.zhang@analog.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/jiffies.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/err.h>
> +#include <linux/mutex.h>
> +#include <linux/delay.h>
> +
> +#include "adt7x10.h"
> +
> +/*
> + * ADT7410 status
> + */
> +#define ADT7410_STAT_T_LOW		(1 << 4)
> +#define ADT7410_STAT_T_HIGH		(1 << 5)
> +#define ADT7410_STAT_T_CRIT		(1 << 6)
> +#define ADT7410_STAT_NOT_RDY		(1 << 7)
> +
> +/*
> + * ADT7410 config
> + */
> +#define ADT7410_FAULT_QUEUE_MASK	(1 << 0 | 1 << 1)
> +#define ADT7410_CT_POLARITY		(1 << 2)
> +#define ADT7410_INT_POLARITY		(1 << 3)
> +#define ADT7410_EVENT_MODE		(1 << 4)
> +#define ADT7410_MODE_MASK		(1 << 5 | 1 << 6)
> +#define ADT7410_FULL			(0 << 5 | 0 << 6)
> +#define ADT7410_PD			(1 << 5 | 1 << 6)
> +#define ADT7410_RESOLUTION		(1 << 7)
> +
> +/*
> + * ADT7410 masks
> + */
> +#define ADT7410_T13_VALUE_MASK			0xFFF8
> +#define ADT7410_T_HYST_MASK			0xF
> +
> +/* straight from the datasheet */
> +#define ADT7410_TEMP_MIN (-55000)
> +#define ADT7410_TEMP_MAX 150000
> +
> +/* Each client has this additional data */
> +struct adt7410_data {
> +	const struct adt7410_ops *ops;
> +	const char		*name;
> +	struct device		*hwmon_dev;
> +	struct mutex		update_lock;
> +	u8			config;
> +	u8			oldconfig;
> +	bool			valid;		/* true if registers valid */
> +	unsigned long		last_updated;	/* In jiffies */
> +	s16			temp[4];	/* Register values,
> +						   0 = input
> +						   1 = high
> +						   2 = low
> +						   3 = critical */
> +	u8			hyst;		/* hysteresis offset */
> +};
> +
> +static int adt7410_read_word(struct device *dev, u8 reg, u16 *data)
> +{
> +	struct adt7410_data *d = dev_get_drvdata(dev);
> +	return d->ops->read_word(dev, reg, data);
> +}
> +
> +static int adt7410_write_word(struct device *dev, u8 reg, u16 data)
> +{
> +	struct adt7410_data *d = dev_get_drvdata(dev);
> +	return d->ops->write_word(dev, reg, data);
> +}
> +
> +static int adt7410_read_byte(struct device *dev, u8 reg, u8 *data)
> +{
> +	struct adt7410_data *d = dev_get_drvdata(dev);
> +	return d->ops->read_byte(dev, reg, data);
> +}
> +
> +static int adt7410_write_byte(struct device *dev, u8 reg, u8 data)
> +{
> +	struct adt7410_data *d = dev_get_drvdata(dev);
> +	return d->ops->write_byte(dev, reg, data);
> +}
> +
> +static const u8 ADT7410_REG_TEMP[4] = {
> +	ADT7410_TEMPERATURE,		/* input */
> +	ADT7410_T_ALARM_HIGH,		/* high */
> +	ADT7410_T_ALARM_LOW,		/* low */
> +	ADT7410_T_CRIT,			/* critical */
> +};
> +
> +/*
> + * adt7410 register access by I2C
> + */
> +static int adt7410_temp_ready(struct device *dev)
> +{
> +	int i, ret;
> +	u8 status;
> +
> +	for (i = 0; i < 6; i++) {
> +		ret = adt7410_read_byte(dev, ADT7410_STATUS, &status);
> +		if (ret)
> +			return ret;
> +		if (!(status & ADT7410_STAT_NOT_RDY))
> +			return 0;
> +		msleep(60);
> +	}
> +	return -ETIMEDOUT;
> +}
> +
> +static int adt7410_update_temp(struct device *dev)
> +{
> +	struct adt7410_data *data = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	mutex_lock(&data->update_lock);
> +
> +	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
> +	    || !data->valid) {
> +
> +		dev_dbg(dev, "Starting update\n");
> +
> +		ret = adt7410_temp_ready(dev); /* check for new value */
> +		if (ret)
> +			goto abort;
> +
> +		ret = adt7410_read_word(dev, ADT7410_REG_TEMP[0],
> +					&data->temp[0]);
> +		if (ret) {
> +			dev_dbg(dev, "Failed to read value: reg %d, error %d\n",
> +				ADT7410_REG_TEMP[0], ret);
> +			goto abort;
> +		}
> +		data->last_updated = jiffies;
> +		data->valid = true;
> +	}
> +
> +abort:
> +	mutex_unlock(&data->update_lock);
> +	return ret;
> +}
> +
> +static int adt7410_fill_cache(struct device *dev)
> +{
> +	struct adt7410_data *data = dev_get_drvdata(dev);
> +	int ret;
> +	int i;
> +
> +	for (i = 1; i < ARRAY_SIZE(data->temp); i++) {
> +		ret = adt7410_read_word(dev, ADT7410_REG_TEMP[i],
> +					&data->temp[i]);
> +		if (ret) {
> +			dev_dbg(dev, "Failed to read value: reg %d, error %d\n",
> +				ADT7410_REG_TEMP[0], ret);
> +			return ret;
> +		}
> +	}
> +
> +	ret = adt7410_read_byte(dev, ADT7410_T_HYST, &data->hyst);
> +	if (ret) {
> +		dev_dbg(dev, "Failed to read value: reg %d, error %d\n",
> +				ADT7410_T_HYST, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static s16 ADT7410_TEMP_TO_REG(long temp)
> +{
> +	return DIV_ROUND_CLOSEST(clamp_val(temp, ADT7410_TEMP_MIN,
> +					       ADT7410_TEMP_MAX) * 128, 1000);
> +}
> +
> +static int ADT7410_REG_TO_TEMP(struct adt7410_data *data, s16 reg)
> +{
> +	/* in 13 bit mode, bits 0-2 are status flags - mask them out */
> +	if (!(data->config & ADT7410_RESOLUTION))
> +		reg &= ADT7410_T13_VALUE_MASK;
> +	/*
> +	 * temperature is stored in twos complement format, in steps of
> +	 * 1/128°C
> +	 */
> +	return DIV_ROUND_CLOSEST(reg * 1000, 128);
> +}
> +
> +/*-----------------------------------------------------------------------*/
> +
> +/* sysfs attributes for hwmon */
> +
> +static ssize_t adt7410_show_temp(struct device *dev,
> +				 struct device_attribute *da, char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> +	struct adt7410_data *data = dev_get_drvdata(dev);
> +
> +
> +	if (attr->index == 0) {
> +		int ret;
> +
> +		ret = adt7410_update_temp(dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return sprintf(buf, "%d\n", ADT7410_REG_TO_TEMP(data,
> +		       data->temp[attr->index]));
> +}
> +
> +static ssize_t adt7410_set_temp(struct device *dev,
> +				struct device_attribute *da,
> +				const char *buf, size_t count)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> +	struct adt7410_data *data = dev_get_drvdata(dev);
> +	int nr = attr->index;
> +	long temp;
> +	int ret;
> +
> +	ret = kstrtol(buf, 10, &temp);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&data->update_lock);
> +	data->temp[nr] = ADT7410_TEMP_TO_REG(temp);
> +	ret = adt7410_write_word(dev, ADT7410_REG_TEMP[nr], data->temp[nr]);
> +	if (ret)
> +		count = ret;
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
> +
> +static ssize_t adt7410_show_t_hyst(struct device *dev,
> +				   struct device_attribute *da,
> +				   char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> +	struct adt7410_data *data = dev_get_drvdata(dev);
> +	int nr = attr->index;
> +	int hyst;
> +
> +	hyst = (data->hyst & ADT7410_T_HYST_MASK) * 1000;
> +
> +	/*
> +	 * hysteresis is stored as a 4 bit offset in the device, convert it
> +	 * to an absolute value
> +	 */
> +	if (nr == 2)	/* min has positive offset, others have negative */
> +		hyst = -hyst;
> +	return sprintf(buf, "%d\n",
> +		       ADT7410_REG_TO_TEMP(data, data->temp[nr]) - hyst);
> +}
> +
> +static ssize_t adt7410_set_t_hyst(struct device *dev,
> +				  struct device_attribute *da,
> +				  const char *buf, size_t count)
> +{
> +	struct adt7410_data *data = dev_get_drvdata(dev);
> +	int limit, ret;
> +	long hyst;
> +
> +	ret = kstrtol(buf, 10, &hyst);
> +	if (ret)
> +		return ret;
> +	/* convert absolute hysteresis value to a 4 bit delta value */
> +	limit = ADT7410_REG_TO_TEMP(data, data->temp[1]);
> +	hyst = clamp_val(hyst, ADT7410_TEMP_MIN, ADT7410_TEMP_MAX);
> +	data->hyst = clamp_val(DIV_ROUND_CLOSEST(limit - hyst, 1000),
> +				   0, ADT7410_T_HYST_MASK);
> +	ret = adt7410_write_byte(dev, ADT7410_T_HYST, data->hyst);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static ssize_t adt7410_show_alarm(struct device *dev,
> +				  struct device_attribute *da,
> +				  char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> +	u8 status;
> +	int ret;
> +
> +	ret = adt7410_read_byte(dev, ADT7410_STATUS, &status);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buf, "%d\n", !!(status & attr->index));
> +}
> +
> +static ssize_t adt7410_show_name(struct device *dev,
> +				  struct device_attribute *da, char *buf)
> +{
> +	struct adt7410_data *data = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%s\n", data->name);
> +}
> +
> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, adt7410_show_temp, NULL, 0);
> +static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO,
> +			  adt7410_show_temp, adt7410_set_temp, 1);
> +static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO,
> +			  adt7410_show_temp, adt7410_set_temp, 2);
> +static SENSOR_DEVICE_ATTR(temp1_crit, S_IWUSR | S_IRUGO,
> +			  adt7410_show_temp, adt7410_set_temp, 3);
> +static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO,
> +			  adt7410_show_t_hyst, adt7410_set_t_hyst, 1);
> +static SENSOR_DEVICE_ATTR(temp1_min_hyst, S_IRUGO,
> +			  adt7410_show_t_hyst, NULL, 2);
> +static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IRUGO,
> +			  adt7410_show_t_hyst, NULL, 3);
> +static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, adt7410_show_alarm,
> +			  NULL, ADT7410_STAT_T_LOW);
> +static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, adt7410_show_alarm,
> +			  NULL, ADT7410_STAT_T_HIGH);
> +static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, adt7410_show_alarm,
> +			  NULL, ADT7410_STAT_T_CRIT);
> +static DEVICE_ATTR(name, S_IRUGO, adt7410_show_name, NULL);
> +
> +static struct attribute *adt7410_attributes[] = {
> +	&sensor_dev_attr_temp1_input.dev_attr.attr,
> +	&sensor_dev_attr_temp1_max.dev_attr.attr,
> +	&sensor_dev_attr_temp1_min.dev_attr.attr,
> +	&sensor_dev_attr_temp1_crit.dev_attr.attr,
> +	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
> +	&sensor_dev_attr_temp1_min_hyst.dev_attr.attr,
> +	&sensor_dev_attr_temp1_crit_hyst.dev_attr.attr,
> +	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
> +	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
> +	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group adt7410_group = {
> +	.attrs = adt7410_attributes,
> +};
> +
> +int adt7410_probe(struct device *dev, const char *name,
> +	const struct adt7410_ops *ops)
> +{
> +	struct adt7410_data *data;
> +	int ret;
> +
> +	data = devm_kzalloc(dev, sizeof(struct adt7410_data),
> +			    GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->ops = ops;
> +	data->name = name;
> +
> +	dev_set_drvdata(dev, data);
> +	mutex_init(&data->update_lock);
> +
> +	/* configure as specified */
> +	ret = adt7410_read_byte(dev, ADT7410_CONFIG, &data->oldconfig);
> +	if (ret < 0) {
> +		dev_dbg(dev, "Can't read config? %d\n", ret);
> +		return ret;
> +	}
> +	/*
> +	 * Set to 16 bit resolution, continous conversion and comparator mode.
> +	 */
> +	data->config = data->oldconfig;
> +	data->config &= ~ADT7410_MODE_MASK;
> +	data->config |= ADT7410_FULL | ADT7410_RESOLUTION | ADT7410_EVENT_MODE;
> +	if (data->config != data->oldconfig) {
> +		ret = adt7410_write_byte(dev, ADT7410_CONFIG, data->config);
> +		if (ret)
> +			return ret;
> +	}
> +	dev_dbg(dev, "Config %02x\n", data->config);
> +
> +	ret = adt7410_fill_cache(dev);
> +	if (ret)
> +		goto exit_restore;
> +
> +	/* Register sysfs hooks */
> +	ret = sysfs_create_group(&dev->kobj, &adt7410_group);
> +	if (ret)
> +		goto exit_restore;
> +
> +	/*
> +	 * The I2C device will already have it's own 'name' attribute, but for
> +	 * the SPI device we need to register it. name will only be non NULL if
> +	 * the device doesn't register the 'name' attribute on its own.
> +	 */
> +	if (name) {
> +		ret = device_create_file(dev, &dev_attr_name);
> +		if (ret)
> +			goto exit_remove;
> +	}
> +
> +	data->hwmon_dev = hwmon_device_register(dev);
> +	if (IS_ERR(data->hwmon_dev)) {
> +		ret = PTR_ERR(data->hwmon_dev);
> +		goto exit_remove_name;
> +	}
> +
> +	return 0;
> +
> +exit_remove_name:
> +	if (name)
> +		device_remove_file(dev, &dev_attr_name);
> +exit_remove:
> +	sysfs_remove_group(&dev->kobj, &adt7410_group);
> +exit_restore:
> +	adt7410_write_byte(dev, ADT7410_CONFIG, data->oldconfig);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(adt7410_probe);
> +
> +int adt7410_remove(struct device *dev)
> +{
> +	struct adt7410_data *data = dev_get_drvdata(dev);
> +
> +	hwmon_device_unregister(data->hwmon_dev);
> +	if (data->name)
> +		device_remove_file(dev, &dev_attr_name);
> +	sysfs_remove_group(&dev->kobj, &adt7410_group);
> +	if (data->oldconfig != data->config)
> +		adt7410_write_byte(dev, ADT7410_CONFIG,
> +					  data->oldconfig);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(adt7410_remove);
> +
> +#ifdef CONFIG_PM_SLEEP
> +
> +static int adt7410_suspend(struct device *dev)
> +{
> +	struct adt7410_data *data = dev_get_drvdata(dev);
> +
> +	return adt7410_write_byte(dev, ADT7410_CONFIG,
> +		data->config | ADT7410_PD);
> +}
> +
> +static int adt7410_resume(struct device *dev)
> +{
> +	struct adt7410_data *data = dev_get_drvdata(dev);
> +
> +	return adt7410_write_byte(dev, ADT7410_CONFIG, data->config);
> +}
> +
> +SIMPLE_DEV_PM_OPS(adt7410_dev_pm_ops, adt7410_suspend, adt7410_resume);
> +EXPORT_SYMBOL_GPL(adt7410_dev_pm_ops);
> +
> +#endif /* CONFIG_PM_SLEEP */
> +
> +MODULE_AUTHOR("Hartmut Knaack");
> +MODULE_DESCRIPTION("ADT7410 driver");
This description does not seem appropriate any longer.
> +MODULE_LICENSE("GPL");
<...>

