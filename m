Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43340 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1437754AbdDZPNJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Apr 2017 11:13:09 -0400
Date: Wed, 26 Apr 2017 08:13:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Joel Stanley <joel@jms.id.au>
Cc: Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        openbmc@lists.ozlabs.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [RFC PATCH] hwmon: Add driver for Infineon DPS310
Message-ID: <20170426151305.GD6411@roeck-us.net>
References: <20170426143321.32000-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170426143321.32000-1-joel@jms.id.au>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Joel,

On Thu, Apr 27, 2017 at 12:03:21AM +0930, Joel Stanley wrote:
> Hi Guenter,
> 
> Below is a work in progress hwmon driver for the DPS310[1]. The device does
> both pressure and temperature monitoring over either I2C or SPI. There's a
> public datasheet available on Infineon's website.
> 
> I require a driver that reads the temperature data over I2C and exposes it to
> userspace as a hwmon device. I wanted your opinion weather this should be an
> IIO driver (and we could then use the IIO HWMON bridge in our application), or
> if it should be a native HWMON driver?
> 

IIO, I think. Pressure isn't really for hardware monitoring, and we would have
a hard time supporting it. IIO already has the necessary infrastructure for it.

Jonathan, any thoughts/comments ?

Thanks,
Guenter

> Once we've agreed on a subsystem I will clean the driver up and submit it
> properly.
> 
> Cheers,
> 
> Joel
> 
> [1] https://www.infineon.com/cms/en/product/sensor/capacitive-pressure-sensor-for-consumer-applications/channel.html
> 
> ---
> 
> The DPS310 is a temperature and pressure sensor. It can be accessed over
> i2c and SPI.
> 
> This driver supports continual measurement of temperature over i2c only.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  drivers/hwmon/Kconfig  |  12 ++
>  drivers/hwmon/Makefile |   1 +
>  drivers/hwmon/dps310.c | 331 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 344 insertions(+)
>  create mode 100644 drivers/hwmon/dps310.c
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 190d270b20a2..8229b2f8c591 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1349,6 +1349,18 @@ config SENSORS_DME1737
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called dme1737.
>  
> +config SENSORS_DPS310
> +	tristate "Infineon DPS310"
> +	depends on I2C
> +	select HWMON_VID
> +	select REGMAP_I2C
> +	help
> +	  If you say yes here you get support for the hardware monitoring
> +	  features of the Infineon DPS310 digital barometric pressure sensor.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called dps310.
> +
>  config SENSORS_EMC1403
>  	tristate "SMSC EMC1403/23 thermal sensor"
>  	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index d2cb7e804a0f..3a5ad06d6d89 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -52,6 +52,7 @@ obj-$(CONFIG_SENSORS_DA9052_ADC)+= da9052-hwmon.o
>  obj-$(CONFIG_SENSORS_DA9055)+= da9055-hwmon.o
>  obj-$(CONFIG_SENSORS_DELL_SMM)	+= dell-smm-hwmon.o
>  obj-$(CONFIG_SENSORS_DME1737)	+= dme1737.o
> +obj-$(CONFIG_SENSORS_DPS310)	+= dps310.o
>  obj-$(CONFIG_SENSORS_DS620)	+= ds620.o
>  obj-$(CONFIG_SENSORS_DS1621)	+= ds1621.o
>  obj-$(CONFIG_SENSORS_EMC1403)	+= emc1403.o
> diff --git a/drivers/hwmon/dps310.c b/drivers/hwmon/dps310.c
> new file mode 100644
> index 000000000000..b014f01d0d3f
> --- /dev/null
> +++ b/drivers/hwmon/dps310.c
> @@ -0,0 +1,331 @@
> +/*
> + * Copyright 2017 IBM Corporation
> + *
> + * Joel Stanley <joel@jms.id.au>
> + *
> + * The DPS310 is a barometric pressure and temperature sensor.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +#include <linux/hwmon.h>
> +#include <linux/module.h>
> +
> +#define PRS_B2		0x00
> +#define PRS_B1		0x01
> +#define PRS_B0		0x02
> +#define TMP_B2		0x03
> +#define TMP_B1		0x04
> +#define TMP_B0		0x05
> +#define PRS_CFG		0x06
> +#define TMP_CFG		0x07
> +#define  TMP_RATE_BITS	GENMASK(6, 4)
> +#define  TMP_EXT	BIT(7)
> +#define MEAS_CFG	0x08
> +#define  MEAS_CTRL_BITS	GENMASK(2, 0)
> +#define   PRESSURE_EN	BIT(0)
> +#define   TEMP_EN	BIT(1)
> +#define   BACKGROUND	BIT(2)
> +#define  PRS_RDY	BIT(4)
> +#define  TMP_RDY	BIT(5)
> +#define  SENSOR_RDY	BIT(6)
> +#define  COEF_RDY	BIT(7)
> +#define RESET		0x0c
> +#define  RESET_MAGIC	(BIT(0) | BIT(3))
> +#define COEF_BASE	0x10
> +
> +#define TMP_BASE	TMP_B2
> +#define PRS_BASE	PRS_B2
> +
> +#define TMP_RATE(_n)	ilog2(_n)
> +#define TMP_PRC(_n)	ilog2(_n)
> +
> +const int scale_factor[] = {
> +	 524288,
> +	1572864,
> +	3670016,
> +	7864320,
> +	 253952,
> +	 516096,
> +	1040384,
> +	2088960,
> +};
> +
> +struct dps310_data {
> +	struct regmap *regmap;
> +	int interval;
> +	s32 c0, c1;
> +};
> +
> +static s32 dps310_twos_compliment(u32 raw, size_t num_bits)
> +{
> +	s32 out = raw;
> +
> +	if (raw & BIT(num_bits - 1))
> +		out = raw - BIT(num_bits);
> +
> +	return out;
> +}
> +
> +static int dps310_get_temp_coef(struct dps310_data *data)
> +{
> +	struct regmap *regmap = data->regmap;
> +	uint8_t coef[3] = {0};
> +	int ready, r;
> +	u32 c0, c1;
> +
> +	r = regmap_read(regmap, MEAS_CFG, &ready);
> +	if (r < 0)
> +		return r;
> +
> +	if (!(ready & COEF_RDY))
> +		return -EAGAIN;
> +
> +	/*
> +	 * Read temperature calibration coefficients c0 and c1 from the
> +	 * COEF register. The numbers are 12-bit 2's compliment numbers
> +	 */
> +	r = regmap_bulk_read(regmap, COEF_BASE, coef, 3);
> +	if (r < 0)
> +		return r;
> +
> +	c0 = (coef[0] << 4) | (coef[1] >> 4);
> +	data->c0 = dps310_twos_compliment(c0, 12);
> +
> +	c1 = ((coef[1] & GENMASK(3, 0)) << 8) | coef[2];
> +	data->c1 = dps310_twos_compliment(c1, 12);
> +
> +	return 0;
> +}
> +
> +static int dps310_get_scale_factor(struct device *dev)
> +{
> +	struct dps310_data *data = dev_get_drvdata(dev);
> +	int val, r;
> +
> +	r = regmap_read(data->regmap, TMP_CFG, &val);
> +	if (r < 0)
> +		return r;
> +
> +	/* Scale factor is bottom 4 bits of the register */
> +	val = val & GENMASK(3, 0);
> +	if (val < 0 || val > ARRAY_SIZE(scale_factor))
> +		return -EINVAL;
> +
> +	return scale_factor[val];
> +}
> +
> +static int dps310_read_temp(struct device *dev, u32 attr, int channel,
> +			     long *temp)
> +{
> +	struct dps310_data *data = dev_get_drvdata(dev);
> +	struct regmap *regmap = data->regmap;
> +	uint8_t val[3] = {0};
> +	int r, ready;
> +	int kT, T_raw;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		r = regmap_read(regmap, MEAS_CFG, &ready);
> +		if (r < 0)
> +			return r;
> +		if (!(ready & TMP_RDY)) {
> +			dev_err(dev, "tmp not ready\n");
> +			return -EAGAIN;
> +		}
> +
> +		/* Choose scaling factor kT based on chosen precision rate */
> +		kT = dps310_get_scale_factor(dev);
> +
> +		r = regmap_bulk_read(regmap, TMP_BASE, val, 3);
> +		if (r < 0)
> +			return r;
> +		T_raw = (val[0] << 16) | (val[1] << 8) | val[2];
> +		T_raw = dps310_twos_compliment(T_raw, 24);
> +
> +		/* (c0 * 0.5 + c1 * T_raw / kT) * 1000 m°C */
> +		*temp = ((data->c0 >> 1) + (data->c1 * T_raw) / kT) * 1000;
> +
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int dps310_read(struct device *dev, enum hwmon_sensor_types type,
> +			u32 attr, int channel, long *val)
> +{
> +	switch (type) {
> +	case hwmon_temp:
> +		return dps310_read_temp(dev, attr, channel, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int dps310_write(struct device *dev, enum hwmon_sensor_types type,
> +			 u32 attr, int channel, long val)
> +{
> +	switch (type) {
> +	case hwmon_temp:
> +		/* Fall through */
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static umode_t dps310_is_visible(const void *data,
> +				  enum hwmon_sensor_types type,
> +				  u32 attr, int channel)
> +{
> +	switch (type) {
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_input:
> +			return 0444;
> +		default:
> +			return 0;
> +		}
> +	default:
> +		return 0;
> +	}
> +}
> +
> +
> +static const u32 dps310_temp_config[] = {
> +	HWMON_T_INPUT,
> +	0
> +};
> +
> +static const struct hwmon_channel_info dps310_temp = {
> +	.type = hwmon_temp,
> +	.config = dps310_temp_config,
> +};
> +
> +static const struct hwmon_channel_info *dps310_info[] = {
> +	&dps310_temp,
> +	NULL
> +};
> +
> +static const struct hwmon_ops dps310_hwmon_ops = {
> +	.is_visible = dps310_is_visible,
> +	.read = dps310_read,
> +	.write = dps310_write,
> +};
> +
> +static const struct hwmon_chip_info dps310_chip_info = {
> +	.ops = &dps310_hwmon_ops,
> +	.info = dps310_info,
> +};
> +
> +static bool dps310_is_writeable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case PRS_CFG:
> +	case TMP_CFG:
> +	case MEAS_CFG:
> +	case RESET:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool dps310_is_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case PRS_B2:
> +	case PRS_B1:
> +	case PRS_B0:
> +	case TMP_B2:
> +	case TMP_B1:
> +	case TMP_B0:
> +	case MEAS_CFG:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static const struct regmap_config dps310_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.writeable_reg = dps310_is_writeable_reg,
> +	.volatile_reg = dps310_is_volatile_reg,
> +	.cache_type = REGCACHE_RBTREE,
> +	.use_single_rw = true,
> +};
> +
> +static int dps310_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct dps310_data *data;
> +	struct device *hwmon_dev;
> +	int r;
> +
> +	data = devm_kzalloc(&client->dev,  sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->regmap = devm_regmap_init_i2c(client, &dps310_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return PTR_ERR(data->regmap);
> +
> +	r = regmap_write(data->regmap, TMP_CFG, TMP_EXT | TMP_PRC(128));
> +	if (r < 0)
> +		return r;
> +
> +	/* Turn on background temperature measurement */
> +	r = regmap_update_bits(data->regmap, MEAS_CFG, MEAS_CTRL_BITS,
> +			TEMP_EN);
> +	if (r < 0)
> +		return r;
> +
> +	/* Get calibration coefficients required for reporting temperature */
> +	r = dps310_get_temp_coef(data);
> +	if (r == -EAGAIN)
> +		return -EPROBE_DEFER;
> +	if (r < 0)
> +		return r;
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(&client->dev,
> +			client->name, data, &dps310_chip_info, NULL);
> +
> +	if (IS_ERR(hwmon_dev))
> +		return PTR_ERR(hwmon_dev);
> +
> +	dev_info(&client->dev, "%s: sensor '%s'\n", dev_name(hwmon_dev),
> +			client->name);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id dps310_id[] = {
> +	{ "dps310", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, dps310_id);
> +
> +static const unsigned short normal_i2c[] = {
> +	0x77, 0x76, I2C_CLIENT_END
> +};
> +
> +static struct i2c_driver dps310_driver = {
> +	.class = I2C_CLASS_HWMON,
> +	.driver = {
> +		.name = "dps310",
> +	},
> +	.probe = dps310_probe,
> +	.address_list = normal_i2c,
> +	.id_table = dps310_id,
> +};
> +module_i2c_driver(dps310_driver);
> +
> +MODULE_AUTHOR("Joel Stanley <joel@jms.id.au>");
> +MODULE_DESCRIPTION("Infineon DPS310 driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.11.0
> 
