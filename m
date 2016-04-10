Return-Path: <linux@roeck-us.net>
Subject: Re: [PATCH 1/1] iio: adc: Add driver for the TI INA3221 Triple
 Current/Voltage Monitor
To: Jonathan Cameron <jic23@kernel.org>, "Andrew F. Davis" <afd@ti.com>,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald <pmeerw@pmeerw.net>, Marc Titinger <mtitinger@baylibre.com>
References: <1460139580-11865-1-git-send-email-afd@ti.com>
 <570A3FB2.7000600@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jean Delvare <jdelvare@suse.de>, linux-hwmon@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <570A6E4A.4010300@roeck-us.net>
Date: Sun, 10 Apr 2016 08:16:26 -0700
MIME-Version: 1.0
In-Reply-To: <570A3FB2.7000600@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 04/10/2016 04:57 AM, Jonathan Cameron wrote:
> On 08/04/16 19:19, Andrew F. Davis wrote:
>> The INA3221 is a three-channel, high-side current and bus voltage monitor
>> with an I2C and SMBUS compatible interface.
>>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
> Hi Andrew,
>
> My immediate thought on this one is whether it would be better off in hwmon.
> I'm not convinced either way from a quick glance at the data sheet, but the
> question needs to be addressed.
>

It looks like a typical hardware monitoring device to me.

> It's not exactly a clean fit for the IIO ABI either at the moment though
> I think some elements of that could be easily sorted out.
> The key think in my mind is to look at what is actually being measured
> rather than assume all the external components will be as the datasheet
> assumes them to be...
>
> + where do the alert lines actually go?
>
In a typical application they would connect to interrupts or to gpio pins.
They could also trigger some direct action, such as turning on a fan,
though that is unlikely nowadays. The 'critical' pin might sometimes
trigger a system reset.

Some more comments inline.

Guenter

> Jonathan
>> ---
>>   .../ABI/testing/sysfs-bus-iio-adc-ina3221          |  23 ++
>>   drivers/iio/adc/Kconfig                            |   7 +
>>   drivers/iio/adc/Makefile                           |   1 +
>>   drivers/iio/adc/ina3221.c                          | 417 +++++++++++++++++++++
>>   4 files changed, 448 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ina3221
>>   create mode 100644 drivers/iio/adc/ina3221.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ina3221 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ina3221
>> new file mode 100644
>> index 0000000..bbe4f8c
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ina3221
>> @@ -0,0 +1,23 @@
>> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_shunt_(raw|scale)
>> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_bus_(raw|scale)
>> +Date:		April 2016
>> +KernelVersion:	4.7
>> +Contact:	Andrew F. Davis <afd@ti.com>
>> +Description:
>> +		Shunt and Bus voltage for each channel.
> Units etc need specifying or at least a reference to the main in_voltageY_raw
> docs etc.  These are really completely separate measurements be it differential measurements where the + on one is the - on the other (second is really a
> unipolar measurement as it's relative to 0).  I wonder if we are
> better off supporting them as such so define this device as having the channels.
> in_voltage1-voltage0_raw (shunt voltage 1)
> in_voltage0_raw (bus voltage 1)
> in_voltage3-voltage2_raw (shunt voltage 2)
> in_voltage2_raw (bus voltage 2)
> in_voltage5-voltage4_raw (shunt voltage 3)
> in_voltage4_raw
>
> That I think reflects the actual measuring options, without applying
> assumptions on what is connected to them.  Yes the datasheet says you should
> put a shunt between the first two connections and the load between the
> second connection and the 0 volt line, but I can't see anything preventing
> this being used differently...

Shunt voltage (or voltage difference) has a LSB of 40uV. Using it for
anything else but current measurement doesn't really make much sense.
I would report it not as voltage but as current, but that is from
my filtered hwmon point of view, so maybe it doesn't really apply here.

>> +
>> +What:		/sys/bus/iio/devices/iio:deviceX/shunt_integration_time[_available]
>> +What:		/sys/bus/iio/devices/iio:deviceX/bus_integration_time[_available]
>> +Date:		April 2016
>> +KernelVersion:	4.7
>> +Contact:	Andrew F. Davis <afd@ti.com>
>> +Description:
>> +		Shunt and Bus integration time for each channel.
> I'd keep these tightly associated with the channels as then they become
> standard abi elements, just for channels with extended names.
>> +
>> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_shunt_critical_(raw|scale)
>> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_shunt_warning_(raw|scale)
>> +Date:		April 2016
>> +KernelVersion:	4.7
>> +Contact:	Andrew F. Davis <afd@ti.com>
>> +Description:
>> +		Shunt voltage critical and warning trigger levels.
> This is why I think this may really belong in hwmon.
> The way you currently have this done is a bodge on the relevant IIO interfaces.
> If there is good reason to look at multiple equivalent event types on a
> given channel in IIO we can look at adding that support to the core.
> This is a lot more common in explicit hardware monitoring chips than in
> more general ADCs.
>
> Also I see nothing in the driver that is actually detecting if these
> conditions have been passed?  If that is assumed to be a problem for external
> hardware then it should be clearly documented as such.
>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index af4aea7..d713c9c 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -232,6 +232,13 @@ config IMX7D_ADC
>>   	  This driver can also be built as a module. If so, the module will be
>>   	  called imx7d_adc.
>>
>> +config INA3221
>> +	tristate "Texas Instruments INA3221 Triple Power Monitor"
>> +	depends on I2C
>> +	select REGMAP_I2C
>> +	help
>> +	  Say yes here to build support for TI INA3221 Triple Power Monitor.
> Need more detail here really.  Something about what it provides and the name
> of the module would be conventional.
>> +
>>   config LP8788_ADC
>>   	tristate "LP8788 ADC driver"
>>   	depends on MFD_LP8788
>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>> index 0cb7921..eebe0c6 100644
>> --- a/drivers/iio/adc/Makefile
>> +++ b/drivers/iio/adc/Makefile
>> @@ -24,6 +24,7 @@ obj-$(CONFIG_FSL_MX25_ADC) += fsl-imx25-gcq.o
>>   obj-$(CONFIG_HI8435) += hi8435.o
>>   obj-$(CONFIG_IMX7D_ADC) += imx7d_adc.o
>>   obj-$(CONFIG_INA2XX_ADC) += ina2xx-adc.o
>> +obj-$(CONFIG_INA3221) += ina3221.o
>>   obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
>>   obj-$(CONFIG_MAX1027) += max1027.o
>>   obj-$(CONFIG_MAX1363) += max1363.o
>> diff --git a/drivers/iio/adc/ina3221.c b/drivers/iio/adc/ina3221.c
>> new file mode 100644
>> index 0000000..e5b9df97
>> --- /dev/null
>> +++ b/drivers/iio/adc/ina3221.c
>> @@ -0,0 +1,417 @@
>> +/*
>> + * INA3221 Triple Current/Voltage Monitor
>> + *
>> + * Copyright (C) 2016 Texas Instruments Incorporated - http://www.ti.com/
>> + *	Andrew F. Davis <afd@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * General Public License for more details.
>> + */
>> +
>> +#include <linux/i2c.h>
>> +#include <linux/module.h>
>> +#include <linux/regmap.h>
>> +
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
>> +
>> +#define INA3221_DRIVER_NAME		"ina3221"
>> +
>> +#define INA3221_CONFIG			0x00
>> +#define INA3221_SHUNT1			0x01
>> +#define INA3221_BUS1			0x02
>> +#define INA3221_SHUNT2			0x03
>> +#define INA3221_BUS2			0x04
>> +#define INA3221_SHUNT3			0x05
>> +#define INA3221_BUS3			0x06
>> +#define INA3221_CRIT1			0x07
>> +#define INA3221_WARN1			0x08
>> +#define INA3221_CRIT2			0x09
>> +#define INA3221_WARN2			0x0a
>> +#define INA3221_CRIT3			0x0b
>> +#define INA3221_WARN3			0x0c
>> +#define INA3221_SHUNT_SUM		0x0d
>> +#define INA3221_SHUNT_SUM_LIMIT		0x0e
>> +#define INA3221_MASK_ENABLE		0x0f
>> +#define INA3221_POWERV_HLIMIT		0x10
>> +#define INA3221_POWERV_LLIMIT		0x11
>> +
>> +#define INA3221_CONFIG_MODE_SHUNT	BIT(1)
>> +#define INA3221_CONFIG_MODE_BUS		BIT(2)
>> +#define INA3221_CONFIG_MODE_CONTINUOUS	BIT(3)
>> +
>> +enum ina3221_fields {
>> +	/* Configuration */
>> +	F_MODE, F_SHUNT_CT, F_BUS_CT, F_AVG,
>> +	F_CHAN3_EN, F_CHAN2_EN, F_CHAN1_EN, F_RST,
>> +
>> +	/* sentinel */
>> +	F_MAX_FIELDS
>> +};
>> +
>> +static const struct reg_field ina3221_reg_fields[] = {
>> +	[F_MODE]	= REG_FIELD(INA3221_CONFIG, 0, 2),
>> +	[F_SHUNT_CT]	= REG_FIELD(INA3221_CONFIG, 3, 5),
>> +	[F_BUS_CT]	= REG_FIELD(INA3221_CONFIG, 6, 8),
>> +	[F_AVG]		= REG_FIELD(INA3221_CONFIG, 9, 11),
>> +	[F_CHAN3_EN]	= REG_FIELD(INA3221_CONFIG, 12, 12),
>> +	[F_CHAN2_EN]	= REG_FIELD(INA3221_CONFIG, 13, 13),
>> +	[F_CHAN1_EN]	= REG_FIELD(INA3221_CONFIG, 14, 14),
>> +	[F_RST]		= REG_FIELD(INA3221_CONFIG, 15, 15),
>> +};
>> +
>> +#define is_bus_reg(_reg) \
>> +	(_reg == INA3221_BUS1 || \
>> +	 _reg == INA3221_BUS2 || \
>> +	 _reg == INA3221_BUS3)
>> +
>> +/**
>> + * struct ina3221_data - device specific information
>> + * @dev: Device structure
>> + * @regmap: Register map of the device
>> + * @fields: Register fields of the device
>> + */
>> +struct ina3221_data {
>> +	struct device *dev;
>> +	struct regmap *regmap;
>> +	struct regmap_field *fields[F_MAX_FIELDS];
>> +};
>> +
>> +/**
>> + * struct ina3221_reg_lookup - value element in iio lookup table map
>> + * @integer: Integer component of value
>> + * @fract: Fractional component of value
>> + */
>> +struct ina3221_reg_lookup {
>> +	int integer;
>> +	int fract;
>> +};
>> +
>> +static const struct ina3221_reg_lookup ina3221_conv_time_table[] = {
>> +	{.fract = 140}, {.fract = 204}, {.fract = 332}, {.fract = 588},
>> +	{.fract = 1100}, {.fract = 2116}, {.fract = 4156}, {.fract = 8244},
>> +};
>> +
>> +static const int ina3221_avg_table[] = { 1, 4, 16, 64, 128, 256, 512, 1024 };
>> +static IIO_CONST_ATTR(oversampling_ratio_available, "1 4 16 64 128 256 512 1024");
>> +
>> +static int ina3221_read_raw(struct iio_dev *indio_dev,
>> +			    struct iio_chan_spec const *chan,
>> +			    int *val, int *val2, long mask)
>> +{
>> +	struct ina3221_data *ina = iio_priv(indio_dev);
>> +	unsigned int regval;
>> +	int ret;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		ret = regmap_read(ina->regmap, chan->address, &regval);
>> +		if (ret)
>> +			return ret;
>> +
>> +		*val = (s16)sign_extend32(regval >> 3, 12);
>> +
>> +		return IIO_VAL_INT;
>> +
>> +	case IIO_CHAN_INFO_SCALE:
>> +		if (is_bus_reg(chan->address)) {
>> +			*val = 8;
>> +			*val2 = 0;
>> +		} else {
>> +			*val = 0;
>> +			*val2 = 40000;
>> +		}
>> +
>> +		return IIO_VAL_INT_PLUS_MICRO;
>> +
>> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>> +		ret = regmap_field_read(ina->fields[F_AVG], &regval);
>> +		if (ret)
>> +			return ret;
>> +
>> +		*val = ina3221_avg_table[regval];
>> +
>> +		return IIO_VAL_INT;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static int ina3221_write_raw(struct iio_dev *indio_dev,
>> +			     struct iio_chan_spec const *chan,
>> +			     int val, int val2, long mask)
>> +{
>> +	struct ina3221_data *ina = iio_priv(indio_dev);
>> +	int i;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		return regmap_write(ina->regmap, chan->address, val << 3);
>> +
>> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>> +		if (val2)
>> +			return -EINVAL;
>> +		for (i = 0; i < ARRAY_SIZE(ina3221_avg_table); i++)
>> +			if (ina3221_avg_table[i] == val)
>> +				break;
>> +		if (i == ARRAY_SIZE(ina3221_avg_table))
>> +			return -EINVAL;
>> +
>> +		return regmap_field_write(ina->fields[F_AVG], i);
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +#define INA3221_CHAN(_channel, _address, _name) { \
>> +	.type = IIO_VOLTAGE, \
>> +	.channel = (_channel), \
>> +	.address = (_address), \
>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
>> +			      BIT(IIO_CHAN_INFO_SCALE), \
>> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
>> +	.extend_name = _name, \
>> +	.indexed = true, \
>> +}
>> +
>> +static const struct iio_chan_spec ina3221_channels[] = {
>> +	INA3221_CHAN(1, INA3221_SHUNT1, "shunt"),
>> +	INA3221_CHAN(1, INA3221_BUS1, "bus"),
>> +	INA3221_CHAN(1, INA3221_CRIT1, "shunt_critical"),
>> +	INA3221_CHAN(1, INA3221_WARN1, "shunt_warning"),
>> +
>> +	INA3221_CHAN(2, INA3221_SHUNT2, "shunt"),
>> +	INA3221_CHAN(2, INA3221_BUS2, "bus"),
>> +	INA3221_CHAN(2, INA3221_CRIT2, "shunt_critical"),
>> +	INA3221_CHAN(2, INA3221_WARN2, "shunt_warning"),
>> +
>> +	INA3221_CHAN(3, INA3221_SHUNT3, "shunt"),
>> +	INA3221_CHAN(3, INA3221_BUS3, "bus"),
>> +	INA3221_CHAN(3, INA3221_CRIT3, "shunt_critical"),
>> +	INA3221_CHAN(3, INA3221_WARN3, "shunt_warning"),
> I'm not really sure how these work at all...  You can set the thresholds
> but how does the driver know if they have been tripped?
> Or are we dealing with the assumption that it is a problem for external
> hardware?
>
'shunt' is really the current reported as voltage. 'bus' is the actual
voltage. Unless I am missing it, the driver won't know if the thresholds
have tripped. It would need an interrupt handler and read the status
register to know that. But that isn't really relevant for an iio driver,
or is it ? What would it do if the limits are tripped ?

>> +};
>> +
>> +struct ina3221_attr {
>> +	struct device_attribute dev_attr;
>> +	struct device_attribute dev_attr_available;
>> +	unsigned int field;
>> +	const struct ina3221_reg_lookup *table;
>> +	unsigned int table_size;
>> +};
>> +
>> +#define to_ina3221_attr(_dev_attr) \
>> +	container_of(_dev_attr, struct ina3221_attr, dev_attr)
>> +
>> +#define to_ina3221_attr_available(_dev_attr) \
>> +	container_of(_dev_attr, struct ina3221_attr, dev_attr_available)
>> +
>> +static ssize_t ina3221_show_register(struct device *dev,
>> +				     struct device_attribute *attr,
>> +				     char *buf)
>> +{
>> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>> +	struct ina3221_data *ina = iio_priv(indio_dev);
>> +	struct ina3221_attr *ina3221_attr = to_ina3221_attr(attr);
>> +	unsigned int reg_val;
>> +	int vals[2];
>> +	int ret;
>> +
>> +	ret = regmap_field_read(ina->fields[ina3221_attr->field], &reg_val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	vals[0] = ina3221_attr->table[reg_val].integer;
>> +	vals[1] = ina3221_attr->table[reg_val].fract;
>> +
>> +	return iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, 2, vals);
>> +}
>> +
>> +static ssize_t ina3221_store_register(struct device *dev,
>> +				      struct device_attribute *attr,
>> +				      const char *buf, size_t count)
>> +{
>> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>> +	struct ina3221_data *ina = iio_priv(indio_dev);
>> +	struct ina3221_attr *ina3221_attr = to_ina3221_attr(attr);
>> +	long val;
>> +	int integer, fract, ret;
>> +
>> +	ret = iio_str_to_fixpoint(buf, 100000, &integer, &fract);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (integer < 0)
>> +		return -EINVAL;
>> +
>> +	for (val = 0; val < ina3221_attr->table_size; val++)
>> +		if (ina3221_attr->table[val].integer == integer &&
>> +		    ina3221_attr->table[val].fract == fract) {
>> +			ret = regmap_field_write(ina->fields[ina3221_attr->field], val);
>> +			if (ret)
>> +				return ret;
>> +
>> +			return count;
>> +		}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static ssize_t ina3221_show_available(struct device *dev,
>> +				      struct device_attribute *attr,
>> +				      char *buf)
>> +{
>> +	struct ina3221_attr *ina3221_attr = to_ina3221_attr_available(attr);
>> +	ssize_t len = 0;
>> +	int i;
>> +
>> +	for (i = 0; i < ina3221_attr->table_size; i++)
>> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%06u ",
>> +				 ina3221_attr->table[i].integer,
>> +				 ina3221_attr->table[i].fract);
>> +
>> +	if (len > 0)
>> +		buf[len - 1] = '\n';
>> +
>> +	return len;
>> +}
>> +
>> +#define INA3221_ATTR(_name, _field, _table) \
>> +	struct ina3221_attr ina3221_attr_##_name = { \
>> +		.dev_attr = __ATTR(_name, (S_IRUGO | S_IWUSR), \
>> +				   ina3221_show_register, \
>> +				   ina3221_store_register), \
>> +		.dev_attr_available = __ATTR(_name##_available, S_IRUGO, \
>> +					     ina3221_show_available, NULL), \
>> +		.field = _field, \
>> +		.table = _table, \
>> +		.table_size = ARRAY_SIZE(_table), \
>> +	}
>> +
>> +static INA3221_ATTR(shunt_integration_time, F_SHUNT_CT, ina3221_conv_time_table);
>> +static INA3221_ATTR(bus_integration_time, F_BUS_CT, ina3221_conv_time_table);
>> +
>> +static struct attribute *ina3221_attributes[] = {
>> +	&ina3221_attr_shunt_integration_time.dev_attr.attr,
>> +	&ina3221_attr_shunt_integration_time.dev_attr_available.attr,
>> +	&ina3221_attr_bus_integration_time.dev_attr.attr,
>> +	&ina3221_attr_bus_integration_time.dev_attr_available.attr,
>> +	&iio_const_attr_oversampling_ratio_available.dev_attr.attr,
>> +	NULL,
>> +};
>> +
>> +static const struct attribute_group ina3221_attribute_group = {
>> +	.attrs = ina3221_attributes,
>> +};
>> +
>> +static const struct iio_info ina3221_iio_info = {
>> +	.driver_module = THIS_MODULE,
>> +	.attrs = &ina3221_attribute_group,
>> +	.read_raw = ina3221_read_raw,
>> +	.write_raw = ina3221_write_raw,
>> +};
>> +
>> +static const struct regmap_range ina3221_yes_ranges[] = {
>> +	regmap_reg_range(INA3221_SHUNT1, INA3221_BUS3),
>> +	regmap_reg_range(INA3221_MASK_ENABLE, INA3221_MASK_ENABLE),
>> +};
>> +
>> +static const struct regmap_access_table ina3221_volatile_table = {
>> +	.yes_ranges = ina3221_yes_ranges,
>> +	.n_yes_ranges = ARRAY_SIZE(ina3221_yes_ranges),
>> +};
>> +
>> +static const struct regmap_config ina3221_regmap_config = {
>> +	.reg_bits = 8,
>> +	.val_bits = 16,
>> +
>> +	.cache_type = REGCACHE_RBTREE,
>> +	.volatile_table = &ina3221_volatile_table,
>> +};
>> +
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id ina3221_of_match[] = {
>> +	{ .compatible = "ti,ina3221", },
>> +	{ /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, ina3221_of_match);
>> +#endif
>> +
>> +static int ina3221_probe(struct i2c_client *client,
>> +			 const struct i2c_device_id *id)
>> +{
>> +	struct iio_dev *indio_dev;
>> +	struct ina3221_data *ina;
>> +	int i, ret;
>> +
>> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*ina));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +	i2c_set_clientdata(client, indio_dev);
>> +
>> +	ina = iio_priv(indio_dev);
>> +
>> +	ina->dev = &client->dev;
>> +
>> +	ina->regmap = devm_regmap_init_i2c(client, &ina3221_regmap_config);
>> +	if (IS_ERR(ina->regmap)) {
>> +		dev_err(ina->dev, "Unable to allocate register map\n");
>> +		return PTR_ERR(ina->regmap);
>> +	}
>> +
>> +	for (i = 0; i < F_MAX_FIELDS; i++) {
>> +		ina->fields[i] = devm_regmap_field_alloc(ina->dev,
>> +							 ina->regmap,
>> +							 ina3221_reg_fields[i]);
>> +		if (IS_ERR(ina->fields[i])) {
>> +			dev_err(ina->dev, "Unable to allocate regmap fields\n");
>> +			return PTR_ERR(ina->fields[i]);
>> +		}
>> +	}
>> +
>> +	ret = regmap_field_write(ina->fields[F_RST], true);
>> +	if (ret) {
>> +		dev_err(ina->dev, "Unable to reset device\n");
>> +		return ret;
>> +	}
>> +
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->dev.parent = ina->dev;
>> +	indio_dev->channels = ina3221_channels;
>> +	indio_dev->num_channels = ARRAY_SIZE(ina3221_channels);
>> +	indio_dev->name = INA3221_DRIVER_NAME;
>> +	indio_dev->info = &ina3221_iio_info;
>> +
>> +	ret = devm_iio_device_register(ina->dev, indio_dev);
>> +	if (ret) {
>> +		dev_err(ina->dev, "Unable to register IIO device\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct i2c_device_id ina3221_ids[] = {
>> +	{ "ina3221", 0 },
>> +	{ /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(i2c, ina3221_ids);
>> +
>> +static struct i2c_driver ina3221_i2c_driver = {
>> +	.driver = {
>> +		.name = INA3221_DRIVER_NAME,
>> +		.of_match_table = of_match_ptr(ina3221_of_match),

Is that really necessary ? I don't see any chip specific properties
Having said that, specifying shunt resistor values might be useful,
but since the driver reports it as voltage it would not really
add any value.

>> +	},
>> +	.probe = ina3221_probe,
>> +	.id_table = ina3221_ids,
>> +};
>> +module_i2c_driver(ina3221_i2c_driver);
>> +
>> +MODULE_AUTHOR("Andrew F. Davis <afd@ti.com>");
>> +MODULE_DESCRIPTION("Texas Instruments INA3221 Driver");
>> +MODULE_LICENSE("GPL v2");
>>
>
>
