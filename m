Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:61290 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806AbaGaUTz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 31 Jul 2014 16:19:55 -0400
Message-ID: <53DAA3E8.6070302@linux.intel.com>
Date: Thu, 31 Jul 2014 13:15:36 -0700
From: sathyanarayanan kuppuswamy
	<sathyanarayanan.kuppuswamy@linux.intel.com>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: jic23@kernel.org, linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH v1 1/1] iio: jsa1212: Add JSA1212 proximity/ALS sensor
References: <cover.1406773841.git.sathyanarayanan.kuppuswamy@linux.intel.com> <44558fe231ead2edac0ed0bd16750255b1fa2019.1406773841.git.sathyanarayanan.kuppuswamy@linux.intel.com> <alpine.DEB.2.01.1407312125570.27459@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1407312125570.27459@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Peter,

Thanks for your valuable comments. Please see my reply inline.

On 07/31/2014 12:41 PM, Peter Meerwald wrote:
>> This patch adds a new driver for solteam opto JSA1212 proximity and
>> ambient light sensor.
> minor comments inline
>
>> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
>> index c89740d..07d0a76 100644
>> --- a/drivers/iio/light/Kconfig
>> +++ b/drivers/iio/light/Kconfig
>> @@ -87,6 +87,16 @@ config HID_SENSOR_PROX
>>   	  To compile this driver as a module, choose M here: the
>>   	  module will be called hid-sensor-prox.
>>   
>> +config JSA1212
>> +	tristate "JSA1212 ALS and proximity sensor driver"
>> +	depends on I2C
>> +	help
>> +	 Say Y here if you want to build a IIO driver for JSA1212
>> +	 proximity & ALS sensor device.
>> +
>> +	 To compile this driver as a module, choose M here:
>> +	 the module will be called jsa1212.
>> +
>>   config SENSORS_LM3533
>>   	tristate "LM3533 ambient light sensor"
>>   	depends on MFD_LM3533
>> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
>> index 3eb36e5..ce85c86 100644
>> --- a/drivers/iio/light/Makefile
>> +++ b/drivers/iio/light/Makefile
>> @@ -10,6 +10,7 @@ obj-$(CONFIG_CM36651)		+= cm36651.o
>>   obj-$(CONFIG_GP2AP020A00F)	+= gp2ap020a00f.o
>>   obj-$(CONFIG_HID_SENSOR_ALS)	+= hid-sensor-als.o
>>   obj-$(CONFIG_HID_SENSOR_PROX)	+= hid-sensor-prox.o
>> +obj-$(CONFIG_JSA1212)		+= jsa1212.o
>>   obj-$(CONFIG_SENSORS_LM3533)	+= lm3533-als.o
>>   obj-$(CONFIG_LTR501)		+= ltr501.o
>>   obj-$(CONFIG_SENSORS_TSL2563)	+= tsl2563.o
>> diff --git a/drivers/iio/light/jsa1212.c b/drivers/iio/light/jsa1212.c
>> new file mode 100644
>> index 0000000..38b7e1f
>> --- /dev/null
>> +++ b/drivers/iio/light/jsa1212.c
>> @@ -0,0 +1,558 @@
>> +/*
>> + * JSA1212 Ambient Light & Proximity Sensor Driver
>> + *
>> + * Copyright (c) 2014, Intel Corporation.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> + * more details.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/slab.h>
>> +#include <linux/module.h>
>> +#include <linux/moduleparam.h>
>> +#include <linux/delay.h>
>> +#include <linux/i2c.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/irq.h>
>> +#include <linux/mutex.h>
>> +#include <linux/slab.h>
>> +#include <linux/acpi.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
>> +#include <linux/iio/events.h>
>> +
>> +/* JSA1212 reg address */
>> +#define JSA1212_CONF_REG		0x01
>> +#define JSA1212_INT_REG			0x02
>> +#define JSA1212_PXS_LT_REG		0x03
>> +#define JSA1212_PXS_HT_REG		0x04
>> +#define JSA1212_ALS_TH1_REG		0x05
>> +#define JSA1212_ALS_TH2_REG		0x06
>> +#define JSA1212_ALS_TH3_REG		0x07
>> +#define JSA1212_PXS_DATA_REG		0x08
>> +#define JSA1212_ALS_DT1_REG		0x09
>> +#define JSA1212_ALS_DT2_REG		0x0A
>> +#define JSA1212_ALS_RNG_REG		0x0B
>> +#define JSA1212_MAX_REG			0x0C
>> +
>> +/* JSA1212 reg defaults */
>> +#define JSA1212_CONF_REG_DEF		0x58
>> +#define JSA1212_INT_REG_DEF		0x02
>> +#define JSA1212_PXS_LT_REG_DEF		0x00
>> +#define JSA1212_PXS_HT_REG_DEF		0xFF
>> +#define JSA1212_ALS_TH1_REG_DEF		0x00
>> +#define JSA1212_ALS_TH2_REG_DEF		0xF0
>> +#define JSA1212_ALS_TH3_REG_DEF		0xFF
>> +#define JSA1212_ALS_RNG_REG_DEF		0x00
>> +
>> +/* JSA1212 reg masks */
>> +#define JSA1212_CONF_MASK		0xFF
>> +#define JSA1212_INT_MASK		0xFF
>> +#define JSA1212_PXS_LT_MASK		0xFF
>> +#define JSA1212_PXS_HT_MASK		0xFF
>> +#define JSA1212_ALS_TH1_MASK		0xFF
>> +#define JSA1212_ALS_TH2_LT_MASK		0x0F
>> +#define JSA1212_ALS_TH2_HT_MASK		0xF0
>> +#define JSA1212_ALS_TH3_MASK		0xFF
>> +#define JSA1212_PXS_DATA_MASK		0xFF
>> +#define JSA1212_ALS_DATA_MASK		0xFFF
>> +#define JSA1212_ALS_DT1_MASK		0xFF
>> +#define JSA1212_ALS_DT2_MASK		0x0F
>> +#define JSA1212_ALS_RNG_MASK		0x07
>> +#define JSA1212_REG_MASK		0xFF
>> +
>> +/* JSA1212 CONF REG bits */
>> +#define JSA1212_CONF_PXS_MASK		0x80
>> +#define JSA1212_CONF_PXS_ENABLE		0x80
>> +#define JSA1212_CONF_PXS_DISABLE	0x00
>> +#define JSA1212_CONF_ALS_MASK		0x04
>> +#define JSA1212_CONF_ALS_ENABLE		0x04
>> +#define JSA1212_CONF_ALS_DISABLE	0x00
>> +
>> +/* JSA1212 INT REG bits */
>> +#define JSA1212_INT_CTRL_MASK		0x01
>> +#define JSA1212_INT_CTRL_EITHER		0x00
>> +#define JSA1212_INT_CTRL_BOTH		0x01
>> +#define JSA1212_INT_ALS_PRST_MASK	0x06
>> +#define JSA1212_INT_ALS_PRST_1CONV	0x00
>> +#define JSA1212_INT_ALS_PRST_4CONV	0x02
>> +#define JSA1212_INT_ALS_PRST_8CONV	0x04
>> +#define JSA1212_INT_ALS_PRST_16CONV	0x06
>> +#define JSA1212_INT_ALS_FLAG_MASK	0x08
>> +#define JSA1212_INT_ALS_FLAG_CLR	0x00
>> +#define JSA1212_INT_PXS_PRST_MASK	0x60
>> +#define JSA1212_INT_PXS_PRST_1CONV	0x00
>> +#define JSA1212_INT_PXS_PRST_4CONV	0x20
>> +#define JSA1212_INT_PXS_PRST_8CONV	0x40
>> +#define JSA1212_INT_PXS_PRST_16CONV	0x60
>> +#define JSA1212_INT_PXS_FLAG_MASK	0x80
>> +#define JSA1212_INT_PXS_FLAG_CLR	0x00
>> +
>> +/* JSA1212 ALS RNG REG bits */
>> +#define JSA1212_ALS_RNG_0_2048		0x00
>> +#define JSA1212_ALS_RNG_0_1024		0x01
>> +#define JSA1212_ALS_RNG_0_512		0x02
>> +#define JSA1212_ALS_RNG_0_256		0x03
>> +#define JSA1212_ALS_RNG_0_128		0x04
>> +
>> +/* JSA1212 INT threshold range */
>> +#define JSA1212_ALS_TH_MIN	0x0000
>> +#define JSA1212_ALS_TH_MAX	0x0FFF
>> +#define JSA1212_PXS_TH_MIN	0x00
>> +#define JSA1212_PXS_TH_MAX	0xFF
>> +
>> +#define JSA1212_I2C_RETRY	0x05
> i2c_retry is not used

Yes, I will remove it.

>
>> +#define JSA1212_ALS_DELAY_MS	0xC8
>> +#define JSA1212_PXS_DELAY_MS	0x64
>> +
>> +enum jsa1212_op_mode {
>> +	JSA1212_OPMODE_ALS_EN,
>> +	JSA1212_OPMODE_PXS_EN,
>> +};
>> +
>> +struct jsa1212_data {
>> +	struct i2c_client *client;
>> +	struct mutex lock;
>> +	u8 als_rng_idx;
>> +	unsigned long flags;
>> +};
>> +
>> +/* ALS range idx to val mapping */
>> +static const int jsa1212_als_range_val[] = {2048, 1024, 512, 256, 128,
>> +						128, 128, 128};
>> +
>> +static int jsa1212_reg_update(struct jsa1212_data *data, u8 reg, u8 bit_mask,
>> +					u8 new_val)
>> +{
>> +	u8 old_cmd, new_cmd;
>> +	int ret;
>> +
>> +	ret = i2c_smbus_read_byte_data(data->client, reg);
>> +	if (ret < 0) {
>> +		dev_err(&data->client->dev,
>> +			"%s: read reg (0X%02X) cmd failed\n",
>> +			__func__, reg);
>> +		return ret;
>> +	}
>> +
>> +	old_cmd = ret & JSA1212_REG_MASK;
>> +
>> +	new_cmd = old_cmd & ~bit_mask;
>> +
>> +	new_cmd |= new_val & bit_mask;
> save some newlines above
ok.
>
>> +
>> +	if (new_cmd != old_cmd) {
>> +		ret = i2c_smbus_write_byte_data(data->client, reg, new_cmd);
>> +		if (ret < 0) {
>> +			dev_err(&data->client->dev,
>> +				"%s: write reg (0X%02X) cmd (0X%02X) failed\n",
>> +				__func__, reg, new_cmd);
>> +			return ret;
>> +		 }
>> +	}
>> +
>> +	 return 0;
>> +}
>> +
>> +#ifdef DEBUG
>> +static void jsa1212_reg_dump(struct jsa1212_data *data)
>> +{
>> +	u8 reg;
>> +	int value;
>> +
>> +	for (reg = JSA1212_CONF_REG; reg < JSA1212_MAX_REG; reg++) {
>> +		value = i2c_smbus_read_byte_data(data->client, reg);
>> +		if (value < 0) {
>> +			dev_dbg(&data->client->dev,
>> +				"error reading reg: %02x\n", reg);
>> +			continue;
>> +		}
>> +		dev_dbg(&data->client->dev, "reg: %02x value: %02x\n",
>> +				reg, value);
>> +	}
>> +
>> +}
>> +#endif
>> +
>> +static int jsa1212_als_enable(struct jsa1212_data *data)
>> +{
>> +	int ret;
>> +
>> +	ret = jsa1212_reg_update(data, JSA1212_CONF_REG,
>> +			JSA1212_CONF_ALS_MASK,
>> +			JSA1212_CONF_ALS_ENABLE);
>> +	if (ret < 0)
>> +		dev_err(&data->client->dev, "als enable failed\n");
>> +	else
>> +		set_bit(JSA1212_OPMODE_ALS_EN, &data->flags);
>> +
>> +	return ret;
>> +}
>> +
>> +static int jsa1212_als_disable(struct jsa1212_data *data)
>> +{
>> +	int ret;
>> +
>> +	ret = jsa1212_reg_update(data, JSA1212_CONF_REG,
>> +			JSA1212_CONF_ALS_MASK,
>> +			JSA1212_CONF_ALS_DISABLE);
>> +	if (ret < 0)
>> +		dev_err(&data->client->dev, "als disable failed\n");
>> +	else
>> +		clear_bit(JSA1212_OPMODE_ALS_EN, &data->flags);
>> +
>> +	return ret;
>> +}
>> +
>> +static int jsa1212_pxs_enable(struct jsa1212_data *data)
>> +{
>> +	int ret;
>> +
>> +	ret = jsa1212_reg_update(data, JSA1212_CONF_REG,
>> +			JSA1212_CONF_PXS_MASK,
>> +			JSA1212_CONF_PXS_ENABLE);
>> +	if (ret < 0)
>> +		dev_err(&data->client->dev, "pxs enable failed\n");
>> +	else
>> +		set_bit(JSA1212_OPMODE_PXS_EN, &data->flags);
>> +
>> +	return ret;
>> +}
>> +
>> +static int jsa1212_pxs_disable(struct jsa1212_data *data)
>> +{
>> +	int ret;
>> +
>> +	ret = jsa1212_reg_update(data, JSA1212_CONF_REG,
>> +			JSA1212_CONF_PXS_MASK,
>> +			JSA1212_CONF_PXS_DISABLE);
>> +	if (ret < 0)
>> +		dev_err(&data->client->dev, "pxs disable failed\n");
>> +	else
>> +		clear_bit(JSA1212_OPMODE_PXS_EN, &data->flags);
>> +
>> +	return ret;
>> +}
> lot of code for little work
May be we don't need separate function for enable/disable. I can combine 
them into a single routine.
>
>> +
>> +static int jsa1212_read_als_data(struct jsa1212_data *data,
>> +				unsigned int *val)
>> +{
>> +	int ret;
>> +
>> +	/*Read 12 bit data*/
>> +	ret = i2c_smbus_read_word_data(data->client, JSA1212_ALS_DT1_REG);
> use whitespace: /* Read .. data */
ok. I will fix it.
>
>> +	if (ret < 0) {
>> +		dev_err(&data->client->dev, "jsa1212 als data read err\n");
> why mention the driver name here?
I agree. dev_err will print the device name. So we don't need driver 
name. I will fix it.
>
>> +		return ret;
>> +	}
>> +
>> +	*val = ret & JSA1212_ALS_DATA_MASK;
>> +
>> +	return 0;
>> +}
>> +
>> +static int jsa1212_read_pxs_data(struct jsa1212_data *data,
>> +				unsigned int *val)
>> +{
>> +	int ret;
>> +
>> +	/*Read out all data*/
> use whitespace: /* Read .. data */
Same as above.
>
>> +	ret = i2c_smbus_read_byte_data(data->client, JSA1212_PXS_DATA_REG);
>> +	if (ret < 0) {
>> +		dev_err(&data->client->dev, "jsa1212 pxs data read err\n");
> why mention the driver name here?
Same as above.
>
>> +		return ret;
>> +	}
>> +
>> +	*val = ret & JSA1212_PXS_DATA_MASK;
>> +
>> +	return 0;
>> +}
>> +
> extra newline here
I will remove it.
>
>> +
>> +static int jsa1212_read_channel(struct jsa1212_data *data,
>> +				struct iio_chan_spec const *chan, int *val)
>> +{
>> +	int ret;
>> +
>> +	switch (chan->type) {
>> +	case IIO_LIGHT:
> the procedure to read a channel is exactly the same for ALS and proximity;
> you could use a table with parameters for the two channels
>
> struct {
> u8 mask;
> int delay;
> ...
> } channel_op_params[] = {
> [JSA1212_OPMODE_ALS_EN] = { ALS_MASK, ALS_DELAY, ... },
> [JSA1212_OPMODE_PXS_EN] = { PXS_MASKPXS_DELAY, ... },
>
> and then just pass the index
This is more like adding a wrapper. If I need to combine the pxs and als 
data read logic together, I might need to add function pointers to 
enable/disable in that table. Do you think we need such complexity for 
just two channels ?

How about I move the enable/disable code section to jsa1212_read_*_data() ?

>
>> +		ret = jsa1212_als_enable(data);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		/* Delay for data output */
>> +		msleep(JSA1212_ALS_DELAY_MS);
>> +
>> +		ret = jsa1212_read_als_data(data, val);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		ret = jsa1212_als_disable(data);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		break;
>> +	case IIO_PROXIMITY:
>> +		ret = jsa1212_pxs_enable(data);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		/* Delay for data output */
>> +		msleep(JSA1212_PXS_DELAY_MS);
>> +
>> +		ret = jsa1212_read_pxs_data(data, val);
>> +		if (ret < 0)
> maybe call pxs_disable() on error? (unlikely that disable succeeds when
> read_data() fails, though)
I can add that code. But I also think if one read/write fails other also 
will fail.
>
>> +			return ret;
>> +
>> +		ret = jsa1212_pxs_disable(data);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int jsa1212_read_raw(struct iio_dev *indio_dev,
>> +				struct iio_chan_spec const *chan,
>> +				int *val, int *val2, long mask)
>> +{
>> +	int ret;
>> +	struct jsa1212_data *data = iio_priv(indio_dev);
>> +
>> +	mutex_lock(&data->lock);
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		ret = jsa1212_read_channel(data, chan, val);
>> +		ret = ret < 0 ? ret : IIO_VAL_INT;
>> +		break;
>> +	case IIO_CHAN_INFO_SCALE:
>> +		switch (chan->type) {
>> +		case IIO_LIGHT:
>> +			*val = jsa1212_als_range_val[data->als_rng_idx];
> no locking needed for INFO_SCALE;
I agree. Will fix it.
>
> do you plan to implement write_raw()?
> als_rng_idx cannot be changed, so the als_range_val table is not needed
I added it so that range change code can be added in future.
>
>> +			*val2 = BIT(12); /* Max 12 bit value */
>> +			ret = IIO_VAL_FRACTIONAL;
>> +			break;
>> +		default:
>> +			ret = -EINVAL;
>> +			break;
>> +		}
>> +		break;
>> +	default:
>> +		ret = -EINVAL;
>> +		break;
>> +	}
>> +
>> +	mutex_unlock(&data->lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct iio_chan_spec jsa1212_channels[] = {
>> +	{
>> +		.type = IIO_LIGHT,
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> +			BIT(IIO_CHAN_INFO_SCALE),
>> +	},
>> +	{
>> +		.type = IIO_PROXIMITY,
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>> +	}
>> +};
>> +
>> +static const struct iio_info jsa1212_info = {
>> +	.driver_module		= THIS_MODULE,
>> +	.read_raw		= &jsa1212_read_raw,
>> +};
>> +
>> +static int jsa1212_chip_init(struct jsa1212_data *data)
>> +{
>> +	int ret;
>> +
>> +	ret = i2c_smbus_write_byte_data(data->client, JSA1212_CONF_REG,
>> +					JSA1212_CONF_REG_DEF);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = i2c_smbus_write_byte_data(data->client, JSA1212_INT_REG,
>> +					JSA1212_INT_REG_DEF);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	data->als_rng_idx = JSA1212_ALS_RNG_0_2048;
>> +	data->flags = 0x00;
>> +
>> +	return 0;
>> +}
>> +
>> +static int jsa1212_probe(struct i2c_client *client,
>> +			     const struct i2c_device_id *id)
>> +{
>> +	struct jsa1212_data *jsa1212_data;
>> +	struct iio_dev *indio_dev;
>> +	int ret;
>> +
>> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
>> +		return -ENODEV;
>> +
>> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*jsa1212_data));
>> +
> extra newline
ok. I will remove it.
>
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	jsa1212_data = iio_priv(indio_dev);
>> +
>> +	i2c_set_clientdata(client, indio_dev);
>> +
>> +	jsa1212_data->client = client;
>> +	mutex_init(&jsa1212_data->lock);
>> +	indio_dev->dev.parent = &client->dev;
>> +	indio_dev->channels = jsa1212_channels;
>> +	indio_dev->num_channels = ARRAY_SIZE(jsa1212_channels);
>> +	indio_dev->name = id->name;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +
>> +	ret = jsa1212_chip_init(jsa1212_data);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	indio_dev->info = &jsa1212_info;
>> +
>> +	ret = iio_device_register(indio_dev);
>> +	if (ret < 0) {
>> +		dev_err(&client->dev, "%s: regist device failed\n", __func__);
> just return ret?
makes sense. will fix it.
>> +		return -ENODEV;
>> +	}
>> +
>> +#ifdef DEBUG
>> +	jsa1212_reg_dump(jsa1212_data);
>> +#endif
>> +
>> +	return 0;
>> +}
>> +
>> +static int jsa1212_remove(struct i2c_client *client)
>> +{
>> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>> +	struct jsa1212_data *data = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	mutex_lock(&data->lock);
>> +
>> +	ret = jsa1212_reg_update(data, JSA1212_CONF_REG,
>> +			JSA1212_CONF_ALS_MASK |
>> +			JSA1212_CONF_PXS_MASK,
>> +			JSA1212_CONF_ALS_DISABLE |
>> +			JSA1212_CONF_PXS_DISABLE);
>> +
>> +	if (ret < 0)
>> +		dev_err(&client->dev, "power off cmd failed\n");
>> +
>> +	mutex_unlock(&data->lock);
>> +
>> +	iio_device_unregister(indio_dev);
>> +
>> +	return ret;
>> +}
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +static int jsa1212_suspend(struct device *dev)
>> +{
>> +	int ret;
>> +	struct jsa1212_data *data;
>> +
>> +	data = iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
>> +
>> +	mutex_lock(&data->lock);
>> +
>> +	ret = jsa1212_reg_update(data, JSA1212_CONF_REG,
>> +			JSA1212_CONF_ALS_MASK |
>> +			JSA1212_CONF_PXS_MASK,
>> +			JSA1212_CONF_ALS_DISABLE |
>> +			JSA1212_CONF_PXS_DISABLE);
>> +
>> +	if (ret < 0)
>> +		dev_err(dev, "suspend cmd failed\n");
>> +
>> +	mutex_unlock(&data->lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static int jsa1212_resume(struct device *dev)
>> +{
>> +	int ret = 0;
>> +	struct jsa1212_data *data;
>> +
>> +	data = iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
>> +
>> +	mutex_lock(&data->lock);
>> +
>> +	if (test_bit(JSA1212_OPMODE_ALS_EN, &data->flags)) {
>> +		ret = jsa1212_als_enable(data);
>> +		if (ret < 0) {
>> +			dev_err(dev, "jsa1212 als resume failed\n");
> driver name in error msg
ok. I will change it.
>
>> +			mutex_unlock(&data->lock);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	if (test_bit(JSA1212_OPMODE_PXS_EN, &data->flags)) {
>> +		ret = jsa1212_pxs_enable(data);
>> +		if (ret < 0)
>> +			dev_err(dev, "jsa1212 pxs resume failed\n");
>> +	}
>> +
>> +	mutex_unlock(&data->lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static SIMPLE_DEV_PM_OPS(jsa1212_pm_ops, jsa1212_suspend, jsa1212_resume);
>> +
>> +#define JSA1212_PM_OPS (&jsa1212_pm_ops)
>> +#else
>> +#define JSA1212_PM_OPS NULL
>> +#endif
>> +
>> +
>> +static const struct acpi_device_id jsa1212_acpi_match[] = {
>> +	{"JSA1212", 0},
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(acpi, jsa1212_acpi_match);
>> +
>> +static const struct i2c_device_id jsa1212_id[] = {
>> +	{ "jsa1212", 0 },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(i2c, jsa1212_id);
>> +
>> +static struct i2c_driver jsa1212_driver = {
>> +	.driver = {
>> +		.name	= "jsa1212",
>> +		.pm	= JSA1212_PM_OPS,
>> +		.owner	= THIS_MODULE,
>> +		.acpi_match_table = ACPI_PTR(jsa1212_acpi_match),
>> +	},
>> +	.probe		= jsa1212_probe,
>> +	.remove		= jsa1212_remove,
>> +	.id_table	= jsa1212_id,
>> +};
>> +module_i2c_driver(jsa1212_driver);
>> +
>> +MODULE_AUTHOR("Sathya Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>");
>> +MODULE_DESCRIPTION("JSA1212 proximity/ambient light sensor driver");
>> +MODULE_LICENSE("GPL v2");
>>

-- 
Sathyanarayanan Kuppuswamy
Android kernel developer

