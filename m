Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43747 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707AbcDJNMa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 10 Apr 2016 09:12:30 -0400
Subject: Re: [PATCH 1/5] max44000: Initial commit
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
References: <cover.1460045763.git.leonard.crestez@intel.com>
 <5dbbd82290c575f595ae0907aaf8e03117a6d017.1460045763.git.leonard.crestez@intel.com>
 <alpine.DEB.2.02.1604072142510.26969@pmeerw.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Daniel Baluta <daniel.baluta@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <570A513A.4020106@kernel.org>
Date: Sun, 10 Apr 2016 14:12:26 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1604072142510.26969@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/04/16 20:48, Peter Meerwald-Stadler wrote:
> 
>> This just adds support for reporting illuminance with default settings.
>>
>> All default registers are written on probe because the device otherwise
>> lacks a reset function.
> 
> comments below
Mostly fine, but a few corners need cleaning up.

Also, I'm not keep on the brute force write everything.  The driver should
cope with any values in those registers and deal with refreshing the
cache etc so that it can do so.  Writing a bunch of defaults is rather a
brittle approach.

Jonathan
>  
>> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
>> ---
>>  drivers/iio/light/Kconfig    |  11 ++
>>  drivers/iio/light/Makefile   |   1 +
>>  drivers/iio/light/max44000.c | 295 +++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 307 insertions(+)
>>  create mode 100644 drivers/iio/light/max44000.c
>>
>> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
>> index cfd3df8..42c15c1 100644
>> --- a/drivers/iio/light/Kconfig
>> +++ b/drivers/iio/light/Kconfig
>> @@ -320,4 +320,15 @@ config VCNL4000
>>  	 To compile this driver as a module, choose M here: the
>>  	 module will be called vcnl4000.
>>  
>> +config MAX44000
>> +	tristate "MAX44000 Ambient and Infrared Proximity Sensor"
>> +	depends on I2C
>> +	select REGMAP_I2C
>> +	help
>> +	 Say Y here if you want to build support for Maxim Integrated's
>> +	 MAX44000 ambient and infrared proximity sensor device.
>> +
>> +	 To compile this driver as a module, choose M here:
>> +	 the module will be called max44000.
>> +
>>  endmenu
>> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
>> index b2c3105..14b2f36 100644
>> --- a/drivers/iio/light/Makefile
>> +++ b/drivers/iio/light/Makefile
>> @@ -30,3 +30,4 @@ obj-$(CONFIG_TCS3472)		+= tcs3472.o
>>  obj-$(CONFIG_TSL4531)		+= tsl4531.o
>>  obj-$(CONFIG_US5182D)		+= us5182d.o
>>  obj-$(CONFIG_VCNL4000)		+= vcnl4000.o
>> +obj-$(CONFIG_MAX44000)		+= max44000.o
> 
> alphabetical order please
> 
>> diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
>> new file mode 100644
>> index 0000000..7c12153
>> --- /dev/null
>> +++ b/drivers/iio/light/max44000.c
>> @@ -0,0 +1,295 @@
>> +/*
>> + * MAX44000 Ambient and Infrared Proximity Sensor
>> + *
>> + * Copyright (c) 2016, Intel Corporation.
>> + *
>> + * This file is subject to the terms and conditions of version 2 of
>> + * the GNU General Public License.  See the file COPYING in the main
>> + * directory of this archive for more details.
>> + *
>> + * Data sheet: https://datasheets.maximintegrated.com/en/ds/MAX44000.pdf
>> + *
>> + * 7-bit I2C slave address 0x4a
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/i2c.h>
>> +#include <linux/regmap.h>
>> +#include <linux/util_macros.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
>> +#include <linux/acpi.h>
>> +
>> +#define MAX44000_DRV_NAME		"max44000"
>> +
>> +/* Registers in datasheet order */
>> +#define MAX44000_REG_STATUS		0x00
>> +#define MAX44000_REG_CFG_MAIN		0x01
>> +#define MAX44000_REG_CFG_RX		0x02
>> +#define MAX44000_REG_CFG_TX		0x03
>> +#define MAX44000_REG_ALS_DATA_HI	0x04
>> +#define MAX44000_REG_ALS_DATA_LO	0x05
>> +#define MAX44000_REG_PRX_DATA		0x16
>> +#define MAX44000_REG_ALS_UPTHR_HI	0x06
>> +#define MAX44000_REG_ALS_UPTHR_LO	0x07
>> +#define MAX44000_REG_ALS_LOTHR_HI	0x08
>> +#define MAX44000_REG_ALS_LOTHR_LO	0x09
>> +#define MAX44000_REG_PST		0x0a
>> +#define MAX44000_REG_PRX_IND		0x0b
>> +#define MAX44000_REG_PRX_THR		0x0c
>> +#define MAX44000_REG_TRIM_GAIN_GREEN	0x0f
>> +#define MAX44000_REG_TRIM_GAIN_IR	0x10
>> +
>> +#define MAX44000_ALSDATA_OVERFLOW	0x4000
>> +
>> +#define MAX44000_REGMASK_READABLE	0x419fff
>> +#define MAX44000_REGMASK_WRITEABLE	0x019fce
>> +#define MAX44000_REGMASK_VOLATILE	0x400031
These are horrible!  Do it as a switch over the relevant
registers in the functions below...  Much easier to read / debug.
>> +
>> +struct max44000_data {
>> +	struct mutex lock;
>> +	struct i2c_client *client;
This client pointer isn't used outside probe and remove where it is easily
available anyway.  Hence don't keep a copy in here.
>> +	struct regmap *regmap;
>> +};
>> +
>> +/* Default scale is set to the minimum of 0.03125 or 1 / (1 << 5) lux */
>> +#define MAX44000_ALS_TO_LUX_DEFAULT_FRACTION_LOG2 5
>> +
>> +static const struct iio_chan_spec max44000_channels[] = {
>> +	{
>> +		.type = IIO_LIGHT,
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
>> +	},
>> +};
>> +
>> +static inline int max44000_read_alsval(struct max44000_data *data)
> 
> drop inline, let the compiler figure out if inlining is beneficial
> 
>> +{
>> +	u16 regval;
>> +	int ret;
>> +
>> +	regval = 0;
> 
> needed?
> 
>> +	ret = regmap_bulk_read(data->regmap, MAX44000_REG_ALS_DATA_HI, &regval, 2);
> 
> sizeof(regval)
> 
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	regval = be16_to_cpu(regval);
>> +
>> +	/* Overflow is explained on datasheet page 17.
>> +	 *
>> +	 * It's a warning that either the G or IR channel has become saturated
>> +	 * and that the value in the register is likely incorrect.
>> +	 *
>> +	 * The recommendation is to change the scale (ALSPGA).
>> +	 * The driver just returns the max representable value.
>> +	 */
>> +	if (regval & MAX44000_ALSDATA_OVERFLOW)
>> +		return 0x3FFF;
>> +
>> +	return regval;
>> +}
>> +
>> +static int max44000_read_raw(struct iio_dev *indio_dev,
>> +			     struct iio_chan_spec const *chan,
>> +			     int *val, int *val2, long mask)
>> +{
>> +	struct max44000_data *data = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		switch (chan->type) {
>> +		case IIO_LIGHT:
>> +			mutex_lock(&data->lock);
>> +			ret = max44000_read_alsval(data);
>> +			mutex_unlock(&data->lock);
>> +			if (ret < 0)
>> +				return ret;
>> +			*val = ret;
>> +			return IIO_VAL_INT;
>> +
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +
>> +	case IIO_CHAN_INFO_SCALE:
>> +		switch (chan->type) {
>> +		case IIO_LIGHT:
>> +			*val = 1;
>> +			*val2 = MAX44000_ALS_TO_LUX_DEFAULT_FRACTION_LOG2;
>> +			return IIO_VAL_FRACTIONAL_LOG2;
>> +
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static const struct iio_info max44000_info = {
>> +	.driver_module		= THIS_MODULE,
>> +	.read_raw		= max44000_read_raw,
>> +};
>> +
>> +static bool max44000_readable_reg(struct device *dev, unsigned int reg)
>> +{
>> +	return (1 << reg) & MAX44000_REGMASK_READABLE;
See above.  This is a really nasty and hard to review way of doing this.
switch (reg) {
       REG1:
       REG2:
       REG3:
	  return true;
       default:
          return false;

may be more code, but it's easy to tell if it is right.
>> +}
>> +
>> +static bool max44000_writeable_reg(struct device *dev, unsigned int reg)
>> +{
>> +	return (1 << reg) & MAX44000_REGMASK_WRITEABLE;
>> +}
>> +
>> +static bool max44000_volatile_reg(struct device *dev, unsigned int reg)
>> +{
>> +	return (1 << reg) & MAX44000_REGMASK_VOLATILE;
>> +}
>> +
>> +static bool max44000_precious_reg(struct device *dev, unsigned int reg)
>> +{
>> +	return reg == MAX44000_REG_STATUS;
>> +}
>> +
>> +/* Datasheet pages 9-10: */
>> +static const struct reg_default max44000_reg_defaults[] = {
>> +	{ MAX44000_REG_CFG_MAIN,	0x24 },
>> +	/* Upper 4 bits are not documented but start as 1 on powerup
Multiline comment syntax please.
>> +	 * Setting them to 0 causes proximity to misbehave so set them to 1
>> +	 */
>> +	{ MAX44000_REG_CFG_RX,		0xf0 },
>> +	{ MAX44000_REG_CFG_TX,		0x00 },
>> +	{ MAX44000_REG_ALS_UPTHR_HI,	0x00 },
>> +	{ MAX44000_REG_ALS_UPTHR_LO,	0x00 },
>> +	{ MAX44000_REG_ALS_LOTHR_HI,	0x00 },
>> +	{ MAX44000_REG_ALS_LOTHR_LO,	0x00 },
>> +	{ MAX44000_REG_PST,		0x00 },
>> +	{ MAX44000_REG_PRX_IND,		0x00 },
>> +	{ MAX44000_REG_PRX_THR,		0x00 },
>> +	{ MAX44000_REG_TRIM_GAIN_GREEN,	0x80 },
>> +	{ MAX44000_REG_TRIM_GAIN_IR,	0x80 },
>> +};
>> +
>> +static const struct regmap_config max44000_regmap_config = {
>> +	.reg_bits	= 8,
>> +	.val_bits	= 8,
>> +
>> +	.max_register	= MAX44000_REG_PRX_DATA,
>> +	.readable_reg	= max44000_readable_reg,
>> +	.writeable_reg	= max44000_writeable_reg,
>> +	.volatile_reg	= max44000_volatile_reg,
>> +	.precious_reg	= max44000_precious_reg,
>> +
>> +	.use_single_rw	= 1,
>> +	.cache_type	= REGCACHE_FLAT,
This always seems like a good idea, but tends to cause issues.
FLAT is really only meant for very high performance devices, you
are probably better with something else here.  If you are doing this
deliberately to make the below writes actually occur, then please
add a comment here.
>> +
>> +	.reg_defaults		= max44000_reg_defaults,
>> +	.num_reg_defaults	= ARRAY_SIZE(max44000_reg_defaults),
>> +};
>> +
>> +static int max44000_force_write_defaults(struct max44000_data *data)
>> +{
>> +	int i, ret;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(max44000_reg_defaults); ++i) {
>> +		ret = regmap_write(data->regmap,
>> +				   max44000_reg_defaults[i].reg,
>> +				   max44000_reg_defaults[i].def);
Silly question, but if the cached value matches the values you are trying
to write here will this work?

There is a regcache_mark_dirty call that will ensure all registers in the
cache are read..

If you then need any particular values they should be explicitly written
on the assumption you have no idea what the state is.  Brute force writing
all the defaults is nasty and doesn't give any information as to what
is happening.

>> +		if (ret)
>> +			return ret;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int max44000_probe(struct i2c_client *client,
>> +			  const struct i2c_device_id *id)
>> +{
>> +	struct max44000_data *data;
>> +	struct iio_dev *indio_dev;
>> +	int ret, reg;
>> +
>> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +	data = iio_priv(indio_dev);
>> +	data->regmap = devm_regmap_init_i2c(client, &max44000_regmap_config);
>> +	if (IS_ERR(data->regmap)) {
>> +		dev_err(&client->dev, "regmap_init failed!\n");
>> +		return PTR_ERR(data->regmap);
>> +	}
>> +
>> +	i2c_set_clientdata(client, indio_dev);
>> +	data->client = client;
>> +	mutex_init(&data->lock);
>> +	indio_dev->dev.parent = &client->dev;
>> +	indio_dev->info = &max44000_info;
>> +	indio_dev->name = MAX44000_DRV_NAME;
>> +	indio_dev->channels = max44000_channels;
>> +	indio_dev->num_channels = ARRAY_SIZE(max44000_channels);
>> +
>> +	/* Read status at least once to clear the power-on-reset bit. */
>> +	ret = regmap_read(data->regmap, MAX44000_REG_STATUS, &reg);
>> +	if (ret < 0) {
>> +		dev_err(&data->client->dev, "failed to read init status: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* The device has no reset command, write defaults explicitly. */
>> +	ret = max44000_force_write_defaults(data);
>> +	if (ret < 0) {
>> +		dev_err(&data->client->dev, "failed to write defaults: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	return iio_device_register(indio_dev);
> 
> devm_ would work here to make _remove obsolete
> 
>> +}
>> +
>> +static int max44000_remove(struct i2c_client *client)
>> +{
>> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>> +
>> +	iio_device_unregister(indio_dev);
>> +	return 0;
>> +}
>> +
>> +static const struct i2c_device_id max44000_id[] = {
>> +	{"max44000", 0},
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(i2c, max44000_id);
>> +
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id max44000_of_match[] = {
>> +	{ .compatible = "maxim,max44000" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, max44000_of_match);
>> +#endif
>> +
>> +#ifdef CONFIG_ACPI
>> +static const struct acpi_device_id max44000_acpi_match[] = {
>> +	{"MAX44000", 0},
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(acpi, max44000_acpi_match);
>> +#endif
>> +
>> +static struct i2c_driver max44000_driver = {
>> +	.driver = {
>> +		.name	= MAX44000_DRV_NAME,
>> +		.of_match_table = of_match_ptr(max44000_of_match),
>> +		.acpi_match_table = ACPI_PTR(max44000_acpi_match),
>> +	},
>> +	.probe		= max44000_probe,
>> +	.remove		= max44000_remove,
>> +	.id_table	= max44000_id,
>> +};
>> +
>> +module_i2c_driver(max44000_driver);
>> +
>> +MODULE_AUTHOR("Crestez Dan Leonard <leonard.crestez@intel.com>");
>> +MODULE_DESCRIPTION("MAX44000 Ambient and Infrared Proximity Sensor");
>> +MODULE_LICENSE("GPL v2");
>>
> 

