Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40030 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbbDSPyL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Apr 2015 11:54:11 -0400
Message-ID: <5533CF9F.5000204@kernel.org>
Date: Sun, 19 Apr 2015 16:54:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Tiberiu Breana <tiberiu.a.breana@intel.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: light: Add support for Sensortek STK3310
References: <1429003962-13922-1-git-send-email-tiberiu.a.breana@intel.com> <1429003962-13922-2-git-send-email-tiberiu.a.breana@intel.com>
In-Reply-To: <1429003962-13922-2-git-send-email-tiberiu.a.breana@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/04/15 10:32, Tiberiu Breana wrote:
> Minimal implementation of an IIO driver for the Sensortek
> STK3310 ambient light and proximity sensor. The STK3311
> model is also supported.
> 
> Includes:
> - ACPI support;
> - read_raw and write_raw;
> - reading and setting configuration parameters for gain/scale
>   and integration time for both ALS and PS.
> 
> Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
Looks good.  One issue with the use of devm_iio_device_register and
a few comments inline.

You are very fond of the switch statement and general purpose
functions that perhaps get stretched too far!  Sill nothing
really wrong with the approach, just a little different from
many.

Jonathan
> ---
>  drivers/iio/light/Kconfig   |  11 +
>  drivers/iio/light/Makefile  |   1 +
>  drivers/iio/light/stk3310.c | 492 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 504 insertions(+)
>  create mode 100644 drivers/iio/light/stk3310.c
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 01a1a16..096129d 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -174,6 +174,17 @@ config LTR501
>  	 This driver can also be built as a module.  If so, the module
>           will be called ltr501.
>  
> +config STK3310
> +	tristate "STK3310 ALS and proximity sensor"
> +	depends on I2C
> +	help
> +	 Say yes here to get support for the Sensortek STK3310 ambient light
> +	 and proximity sensor. The STK3311 model is also supported by this
> +	 driver.
> +
> +	 Choosing M will build the driver as a module. If so, the module
> +	 will be called stk3310.
> +
>  config TCS3414
>  	tristate "TAOS TCS3414 digital color sensor"
>  	depends on I2C
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index ad7c30f..90e7fd2 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_JSA1212)		+= jsa1212.o
>  obj-$(CONFIG_SENSORS_LM3533)	+= lm3533-als.o
>  obj-$(CONFIG_LTR501)		+= ltr501.o
>  obj-$(CONFIG_SENSORS_TSL2563)	+= tsl2563.o
> +obj-$(CONFIG_STK3310)          += stk3310.o
>  obj-$(CONFIG_TCS3414)		+= tcs3414.o
>  obj-$(CONFIG_TCS3472)		+= tcs3472.o
>  obj-$(CONFIG_TSL4531)		+= tsl4531.o
> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
> new file mode 100644
> index 0000000..5bcf5a0
> --- /dev/null
> +++ b/drivers/iio/light/stk3310.c
> @@ -0,0 +1,492 @@
> +/**
> + * Sensortek STK3310/STK3311 Ambient Light and Proximity Sensor
> + *
> + * Copyright (c) 2015, Intel Corporation.
> + *
> + * This file is subject to the terms and conditions of version 2 of
> + * the GNU General Public License. See the file COPYING in the main
> + * directory of this archive for more details.
> + *
> + * IIO driver for STK3310/STK3311. 7-bit I2C address: 0x48.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#define STK3310_REG_STATE			0x00
> +#define STK3310_REG_PSCTRL			0x01
> +#define STK3310_REG_ALSCTRL			0x02
> +#define STK3310_REG_PS_DATA_MSB			0x11
> +#define STK3310_REG_ALS_DATA_MSB		0x13
> +#define STK3310_REG_PDT_ID			0x3E
> +
> +#define STK3310_STATE_EN_PS			0x01
> +#define STK3310_STATE_EN_ALS			0x02
> +#define STK3310_STATE_STANDBY			0x00
> +#define STK3310_STATE_MASK			0x07
> +
> +#define STK3310_GAIN_MASK			0x30
> +#define STK3310_IT_MASK				0x0F
> +#define STK3310_GAIN_SHIFT			4
> +#define STK3310_IT_SHIFT			0
> +
> +#define STK3310_CHIP_ID_VAL			0x13
> +#define STK3311_CHIP_ID_VAL			0x1D
> +
> +#define STK3310_GAIN_MAX			3
> +#define STK3310_IT_MAX				15
> +#define STK3310_PS_MAX_VAL			0xffff
> +
> +#define STK3310_SCALE_AVAILABLE			"6.4 1.6 0.4 0.1"
> +
> +#define STK3310_DRIVER_NAME			"stk3310"
> +
> +/*
> + * Maximum PS values with regard to scale. Used to export the 'inverse'
> + * PS value (high values for far objects, low values for near objects).
> + */
> +static const int stk3310_ps_max[4] = {
> +	STK3310_PS_MAX_VAL / 64,
> +	STK3310_PS_MAX_VAL / 16,
> +	STK3310_PS_MAX_VAL /  4,
> +	STK3310_PS_MAX_VAL,
> +};
> +
> +static const int stk3310_scale_table[][2] = {
> +	{6, 400000}, {1, 600000}, {0, 400000}, {0, 100000}
> +};
> +
> +/* Integration time in seconds, microseconds */
> +static const int stk3310_it_table[][2] = {
> +	{0, 185000}, {0, 370000}, {0, 741000}, {0, 148000},
> +	{0, 296000}, {0, 592000}, {0, 118400}, {0, 236800},
> +	{0, 473600}, {0, 947200}, {0, 189440}, {0, 378880},
> +	{0, 757760}, {1, 515520}, {3, 31040},  {6, 62080},
> +};
> +
> +enum stk3310_data_type {
> +	STK3310_ALS,
> +	STK3310_PS
> +};
> +
> +enum stk3310_config_type {
> +	STK3310_GAIN,
> +	STK3310_IT,
> +	STK3310_TYPE_COUNT
> +};
> +
> +struct stk3310_data {
> +	struct i2c_client *client;
> +	struct mutex lock;
> +	/* Cache table for storing config values */
> +	int cache[2][STK3310_TYPE_COUNT];
> +};
> +
> +static const struct iio_chan_spec stk3310_channels[] = {
> +	{
> +		.channel = 0,
> +		.type = IIO_LIGHT,
> +		.info_mask_separate =
> +			BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SCALE) |
> +			BIT(IIO_CHAN_INFO_INT_TIME),
> +	},
> +	{
> +		.channel = 1,
> +		.type = IIO_PROXIMITY,
> +		.info_mask_separate =
> +			BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SCALE) |
> +			BIT(IIO_CHAN_INFO_INT_TIME),
> +	}
> +};
> +
> +static ssize_t stk3310_get_it_vals(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	int i;
> +	int len;
> +
> +	for (i = 0, len = 0; i < ARRAY_SIZE(stk3310_it_table); i++) {
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%06d ",
> +				stk3310_it_table[i][0],
> +				stk3310_it_table[i][1]);
> +	}
> +	buf[len - 1] = '\n';
> +
> +	return len;
> +}
> +
> +static IIO_CONST_ATTR(in_illuminance_scale_available, STK3310_SCALE_AVAILABLE);
> +
> +static IIO_DEVICE_ATTR(in_illuminance_integration_time_available,
> +		       S_IRUGO, stk3310_get_it_vals, NULL, 0);
> +
> +static IIO_DEVICE_ATTR(in_proximity_integration_time_available,
> +		       S_IRUGO, stk3310_get_it_vals, NULL, 0);
> +
> +static struct attribute *stk3310_attributes[] = {
> +	&iio_const_attr_in_illuminance_scale_available.dev_attr.attr,
> +	&iio_dev_attr_in_illuminance_integration_time_available.dev_attr.attr,
> +	&iio_dev_attr_in_proximity_integration_time_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group stk3310_attribute_group = {
> +	.attrs = stk3310_attributes
> +};
> +
> +static int stk3310_get_index(const int table[][2], int table_size,
> +			     int val, int val2)
> +{
> +	int i;
> +
> +	for (i = 0; i < table_size; i++) {
> +		if (val == table[i][0] && val2 == table[i][1])
> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int stk3310_set_cfg(struct stk3310_data *data,
> +			   enum stk3310_data_type type,
> +			   enum stk3310_config_type cfg,
> +			   u8 val)
> +{
> +	u8 reg;
> +	u8 shift;
> +	u8 masked_reg;
> +	u8 mask;
> +	int ret;
> +
> +	if (val < 0)
> +		return -EINVAL;
> +	switch (type) {
> +	case STK3310_ALS:
> +		reg = STK3310_REG_ALSCTRL;
> +		break;
> +	case STK3310_PS:
> +		reg = STK3310_REG_PSCTRL;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	switch (cfg) {
> +	case STK3310_GAIN:
> +		if (val > STK3310_GAIN_MAX)
> +			return -EINVAL;
> +		shift = STK3310_GAIN_SHIFT;
> +		mask = STK3310_GAIN_MASK;
> +		break;
> +	case STK3310_IT:
> +		if (val > STK3310_IT_MAX)
> +			return -EINVAL;
> +		shift = STK3310_IT_SHIFT;
> +		mask = STK3310_IT_MASK;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = i2c_smbus_read_byte_data(data->client, reg);
Isn't this already in the cache?
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "register read failed\n");
> +		return ret;
> +	}
> +	masked_reg = ret & (~mask);
> +	masked_reg |= (val << shift);
> +
> +	ret = i2c_smbus_write_byte_data(data->client, reg, masked_reg);
> +	if (ret < 0)
> +		dev_err(&data->client->dev, "sensor configuration failed\n");
> +	else
> +		data->cache[type][cfg] = val;
This isn't actually the value written. Would caching masked_reg make more sense?
Also, why cache at all? You often seem to reread it anyway as in this function.
> +
> +	return ret;
> +}
> +
> +static int stk3310_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	int ret;
> +	int index;
> +	u8 reg;
> +	enum stk3310_data_type type;
> +	struct stk3310_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +
> +	switch (chan->type) {
> +	case IIO_LIGHT:
> +		type = STK3310_ALS;
> +		reg = STK3310_REG_ALS_DATA_MSB;
> +		break;
> +	case IIO_PROXIMITY:
> +		type = STK3310_PS;
> +		reg = STK3310_REG_PS_DATA_MSB;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&data->lock);
> +		ret = i2c_smbus_read_word_swapped(client, reg);
> +		if (ret < 0) {
> +			dev_err(&client->dev, "register read failed\n");
> +			mutex_unlock(&data->lock);
> +			return ret;
> +		}
> +		*val = ret;
> +		index = data->cache[STK3310_ALS][STK3310_GAIN];
> +		if (type == STK3310_PS) {
> +			/*
> +			 * Invert the proximity data so we return low values
> +			 * for close objects and high values for far ones.
> +			 */
> +			index = data->cache[STK3310_PS][STK3310_GAIN];
> +			*val = stk3310_ps_max[index] - *val;
> +		}
> +		mutex_unlock(&data->lock);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		index = data->cache[type][STK3310_IT];
> +		*val = stk3310_it_table[index][0];
> +		*val2 = stk3310_it_table[index][1];
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_SCALE:
> +		index = data->cache[type][STK3310_GAIN];
> +		*val = stk3310_scale_table[index][0];
> +		*val2 = stk3310_scale_table[index][1];
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int stk3310_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	int ret;
> +	int index;
> +	enum stk3310_data_type type;
> +	struct stk3310_data *data = iio_priv(indio_dev);
> +
> +	switch (chan->type) {
> +	case IIO_LIGHT:
> +		type = STK3310_ALS;
> +		break;
> +	case IIO_PROXIMITY:
> +		type = STK3310_PS;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
Hmm. You could pass the iio type directly into set_cfg and have only
one switch statement rather than the two current ones...  I guess the
reason you do it like this is for consistency with the rest of the driver.
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		index = stk3310_get_index(stk3310_it_table,
> +					  ARRAY_SIZE(stk3310_it_table),
> +					  val, val2);
> +		if (index < 0)
> +			return -EINVAL;
> +		mutex_lock(&data->lock);
> +		ret = stk3310_set_cfg(data, type, STK3310_IT, index);
> +		mutex_unlock(&data->lock);
> +		return ret;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		index = stk3310_get_index(stk3310_scale_table,
> +					  ARRAY_SIZE(stk3310_scale_table),
> +					  val, val2);
> +		if (index < 0)
> +			return -EINVAL;
> +		mutex_lock(&data->lock);
> +		ret = stk3310_set_cfg(data, type, STK3310_GAIN, index);
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info stk3310_info = {
> +	.driver_module		= THIS_MODULE,
> +	.read_raw		= stk3310_read_raw,
> +	.write_raw		= stk3310_write_raw,
> +	.attrs			= &stk3310_attribute_group,
> +};
> +
> +static int stk3310_cache_store(struct stk3310_data *data)
> +{
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +	ret = i2c_smbus_read_byte_data(data->client, STK3310_REG_ALSCTRL);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "register read failed\n");
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	}
> +
> +	data->cache[STK3310_ALS][STK3310_GAIN] =
> +			(ret & STK3310_GAIN_MASK) >> STK3310_GAIN_SHIFT;
> +	data->cache[STK3310_ALS][STK3310_IT] =
> +			(ret & STK3310_IT_MASK) >> STK3310_IT_SHIFT;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, STK3310_REG_PSCTRL);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "register read failed\n");
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	}
> +
> +	data->cache[STK3310_PS][STK3310_GAIN] =
> +			(ret & STK3310_GAIN_MASK) >> STK3310_GAIN_SHIFT;
> +	data->cache[STK3310_PS][STK3310_IT] =
> +			(ret & STK3310_IT_MASK) >> STK3310_IT_SHIFT;
> +	mutex_unlock(&data->lock);
> +
Hmm. The moment I see caching in a driver I think maybe this would
be cleaner with regmap...  Here there isn't much being cached though
so I don't really mind either way.
> +	return ret;
> +}
> +
> +static int stk3310_set_state(struct stk3310_data *data, u8 state)
> +{
> +	int ret;
> +	int masked_reg;
> +	struct i2c_client *client = data->client;
> +
> +	/* 3-bit state; 0b100 is not supported. */
> +	if (state < 0 || state > 7 || state == 4)
> +		return -EINVAL;
> +
> +	mutex_lock(&data->lock);
> +	ret = i2c_smbus_read_byte_data(data->client, STK3310_REG_STATE);
> +	if (ret < 0) {
> +		mutex_unlock(&data->lock);
> +		dev_err(&client->dev, "register read failed\n");
> +		return ret;
> +	}
> +	masked_reg = ret & (~STK3310_STATE_MASK);
> +	masked_reg |= state;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, STK3310_REG_STATE,
> +					masked_reg);
> +	if (ret < 0)
> +		dev_err(&client->dev, "failed to change sensor state\n");
> +
> +	mutex_unlock(&data->lock);
> +
> +	return ret;
> +}
> +
> +static int stk3310_init(struct iio_dev *indio_dev)
> +{
> +	int ret;
> +	u8 state;
> +	struct stk3310_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +
> +	ret = i2c_smbus_read_byte_data(client, STK3310_REG_PDT_ID);
> +	if (ret != STK3310_CHIP_ID_VAL &&
> +	    ret != STK3311_CHIP_ID_VAL) {
> +		dev_err(&client->dev, "invalid chip id: 0x%x\n", ret);
> +		return -ENODEV;
> +	}
> +
> +	state = STK3310_STATE_EN_ALS | STK3310_STATE_EN_PS;
> +	ret = stk3310_set_state(data, state);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "failed to enable sensor");
> +		return ret;
> +	}
> +
> +	/* Cache the initial configuration values */
> +	return stk3310_cache_store(data);
> +}
> +
> +static int stk3310_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	int ret;
> +	struct iio_dev *indio_dev;
> +	struct stk3310_data *data;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev) {
> +		dev_err(&client->dev, "iio allocation failed!\n");
> +		return -ENOMEM;
> +	}
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +	i2c_set_clientdata(client, indio_dev);
> +	mutex_init(&data->lock);
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->info = &stk3310_info;
> +	indio_dev->name = STK3310_DRIVER_NAME;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = stk3310_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(stk3310_channels);
> +
> +	ret = stk3310_init(indio_dev);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "sensor initialization failed\n");
> +		return ret;
> +	}
> +
> +	ret = devm_iio_device_register(&client->dev, indio_dev);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "device_register failed\n");
> +		stk3310_set_state(data, STK3310_STATE_STANDBY);
> +	}
> +
> +	return ret;
> +}
> +
> +static int stk3310_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct stk3310_data *data = iio_priv(indio_dev);
> +
> +	return stk3310_set_state(data, STK3310_STATE_STANDBY);
Could roll all of this into one line.
        return stk3310_set_state(iio_priv(i2c_get_clientdata(client)));
without loosing significant readabliity.

Howwever you are not quite unrolling your probe in the oposite
order in the remove.  There will be a window in which the userspace
interfaces are present and you have put the device into standby.

Basic rule of thumb: Don't use devm_ version of iio_device_register
if you have anything at all in your remove function.
Use the non devm version and ensure it is unregistered before putting
the device into standby.

> +}
> +
> +static const struct i2c_device_id stk3310_i2c_id[] = {
> +	{"STK3310", 0},
> +	{"STK3311", 0},
> +	{}
> +};
> +
> +static const struct acpi_device_id stk3310_acpi_id[] = {
> +	{"STK3310", 0},
> +	{"STK3311", 0},
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(acpi, stk3310_acpi_id);
> +
> +static struct i2c_driver stk3310_driver = {
> +	.driver = {
> +		.name = "stk3310",
> +		.acpi_match_table = ACPI_PTR(stk3310_acpi_id),
> +	},
> +	.probe =            stk3310_probe,
> +	.remove =           stk3310_remove,
> +	.id_table =         stk3310_i2c_id,
> +};
> +
> +module_i2c_driver(stk3310_driver);
> +
> +MODULE_AUTHOR("Tiberiu Breana <tiberiu.a.breana@intel.com>");
> +MODULE_DESCRIPTION("STK3310 Ambient Light and Proximity Sensor driver");
> +MODULE_LICENSE("GPL v2");
> 

