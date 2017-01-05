Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:44148 "EHLO pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965899AbdAEJDi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 5 Jan 2017 04:03:38 -0500
Date: Thu, 5 Jan 2017 10:03:03 +0100 (CET)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Mani Sadhasivam <manivannanece23@gmail.com>
cc: jic23@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:temperature: Add support for TI TMP007 sensor
In-Reply-To: <20170105034904.GA21893@gmail.com>
Message-ID: <alpine.DEB.2.02.1701050920460.16779@pmeerw.net>
References: <20170105034904.GA21893@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> This patch adds support for TI TMP007 - 16 bit IR thermopile sensor with integrated Math engine.
> Sensor takes care of calculating the object temperature with the help of calibrated constants stored in non-volatile memory,
> reducing the calculation overhead.

comments below
link to datasheet would be nice

> Signed-off-by: Mani Sadhasivam <manivannanece23@gmail.com>
> ---
>  .../devicetree/bindings/iio/temperature/tmp007.txt |  14 +
>  drivers/iio/temperature/Kconfig                    |  10 +
>  drivers/iio/temperature/Makefile                   |   1 +
>  drivers/iio/temperature/tmp007.c                   | 357 +++++++++++++++++++++
>  4 files changed, 382 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/tmp007.txt
>  create mode 100644 drivers/iio/temperature/tmp007.c
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/tmp007.txt b/Documentation/devicetree/bindings/iio/temperature/tmp007.txt
> new file mode 100644
> index 0000000..f4175c7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/tmp007.txt
> @@ -0,0 +1,14 @@
> +* TI TMP007 - IR thermopile sensor with integrated Math engine

math

add devicetree mail list to Cc:

> +
> +Required properties:
> +
> +  - compatible: should be "ti,tmp007"
> +  - reg: the I2C address of the sensor (changeable via ADR pins)
> +
> +Example:
> +
> +tmp007@40 {
> +        compatible = "ti,tmp007";
> +        reg = <0x40>;
> +};
> +
> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
> index c4664e5..538ce9e 100644
> --- a/drivers/iio/temperature/Kconfig
> +++ b/drivers/iio/temperature/Kconfig
> @@ -23,6 +23,16 @@ config TMP006
>  	  This driver can also be built as a module. If so, the module will
>  	  be called tmp006.
>  
> +config TMP007
> +        tristate "TMP007 infrared thermopile sensor with Integrated Math Engine"
> +        depends on I2C
> +        help
> +          If you say yes here you get support for the Texas Instruments
> +          TMP007 infrared thermopile sensor with Integrated Math Engine.
> +
> +          This driver can also be built as a module. If so, the module will
> +          be called tmp007.
> +
>  config TSYS01
>  	tristate "Measurement Specialties TSYS01 temperature sensor using I2C bus connection"
>  	depends on I2C
> diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
> index 02bc79d..f0cf5c5 100644
> --- a/drivers/iio/temperature/Makefile
> +++ b/drivers/iio/temperature/Makefile
> @@ -4,5 +4,6 @@
>  
>  obj-$(CONFIG_MLX90614) += mlx90614.o
>  obj-$(CONFIG_TMP006) += tmp006.o
> +obj-$(CONFIG_TMP007) += tmp007.o
>  obj-$(CONFIG_TSYS01) += tsys01.o
>  obj-$(CONFIG_TSYS02D) += tsys02d.o
> diff --git a/drivers/iio/temperature/tmp007.c b/drivers/iio/temperature/tmp007.c
> new file mode 100644
> index 0000000..5b549cc
> --- /dev/null
> +++ b/drivers/iio/temperature/tmp007.c
> @@ -0,0 +1,357 @@
> +/*
> + * tmp007.c - Support for TI TMP007 IR thermopile sensor with Integrated Math Engine
> + *
> + * Copyright (c) 2017 Manivannan Sadhasivam <manivannanece23@gmail.com>
> + *
> + * This file is subject to the terms and conditions of version 2 of
> + * the GNU General Public License.  See the file COPYING in the main
> + * directory of this archive for more details.
> + *
> + * Driver for the Texas Instruments I2C 16-bit IR thermopile sensor
> + *
> + * (7-bit I2C slave address (0x40 - 0x47), changeable via ADR pins)
> + *
> + * Note: This driver assumes that the sensor has been calibrated beforehand
> + *
> + * TODO: ALERT irq
> + *
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/pm.h>
> +#include <linux/bitops.h>
> +#include <linux/of.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#define TMP007_VSENSOR 0x00
> +#define TMP007_TDIE 0x01
> +#define TMP007_CONFIG 0x02
> +#define TMP007_TOBJECT 0x03
> +#define TMP007_STATUS 0x04
> +#define TMP007_STATUS_MASK 0x05

maybe remove #defines that are not (yet) in use
since the chip supports limits, one could probably add events lateron

> +#define TMP007_TOBJECT_HIGH_LIMIT 0x06
> +#define TMP007_TOBJECT_LOW_LIMIT 0x07
> +#define TMP007_TDIE_HIGH_LIMIT 0x08
> +#define TMP007_TDIE_LOW_LIMIT 0x09
> +#define TMP007_S0_COEFFICIENT 0x0a
> +#define TMP007_A1_COEFFICIENT 0x0b
> +#define TMP007_A2_COEFFICIENT 0x0c
> +#define TMP007_B0_COEFFICIENT 0x0d
> +#define TMP007_B1_COEFFICIENT 0x0e
> +#define TMP007_B2_COEFFICIENT 0x0f
> +#define TMP007_C2_COEFFICIENT 0x10
> +#define TMP007_TC0_COEFFICIENT 0x11
> +#define TMP007_TC1_COEFFICIENT 0x12
> +#define TMP007_MANUFACTURER_ID 0x1e
> +#define TMP007_DEVICE_ID 0x1f
> +#define TMP007_MEMORY_ACCESS 0x2a
> +
> +#define TMP007_CONFIG_CONV_EN BIT(12)
> +#define TMP007_CONFIG_COMP_EN BIT(5)
> +#define TMP007_CONFIG_TC_EN BIT(6)
> +#define TMP007_CONFIG_CR_MASK GENMASK(11, 9)
> +#define TMP007_CONFIG_CR_SHIFT 9
> +
> +#define TMP007_STATUS_CONV_READY BIT(14)
> +#define TMP007_STATUS_DATA_VALID BIT(9)
> +
> +#define TMP007_MANUFACTURER_MAGIC 0x5449
> +#define TMP007_DEVICE_MAGIC 0x0078
> +
> +#define TMP007_TEMP_VALID BIT(0)

only for TOBJ, make add a check for VALID?

> +#define TMP007_TEMP_SHIFT 2
> +
> +struct tmp007_data {
> +	struct i2c_client *client;
> +	u16 config;
> +	u16 status_mask;
> +};
> +
> +/* Mode 101, 110, 111 are rarely used. Hence not taken into account */

the comment is not very clear, what does mode 101 relate to?

> +static const int tmp007_avgs[5][2] = { {4, 0}, {2, 0}, {1, 0},
> +					{0, 500000}, {0, 250000} };
> +
> +static int tmp007_read_temperature(struct tmp007_data *data, u8 reg)
> +{
> +	s32 ret;
> +	int tries = 50;
> +
> +	while (tries-- > 0) {
> +		ret = i2c_smbus_read_word_swapped(data->client,
> +			TMP007_STATUS);
> +		if (ret < 0)
> +			return ret;
> +		if (ret & TMP007_STATUS_CONV_READY)
> +			break;
> +		msleep(100);
> +	}
> +

this should probably check the DATA_VALID bit?

> +	if (tries < 0)
> +		return -EIO;
> +
> +	return i2c_smbus_read_word_swapped(data->client, reg);
> +}
> +
> +static int tmp007_read_raw(struct iio_dev *indio_dev,
> +		struct iio_chan_spec const *channel, int *val,
> +		int *val2, long mask)
> +{
> +	struct tmp007_data *data = iio_priv(indio_dev);
> +	s32 ret;
> +	int conv_rate;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (channel->channel2) {
> +		case IIO_MOD_TEMP_AMBIENT: /* LSB: 0.03125 degree Celsius */
> +			ret = tmp007_read_temperature(data, TMP007_TDIE);
> +			if (ret < 0)
> +			return ret;

indentation

> +			*val = sign_extend32(ret, 15) >> TMP007_TEMP_SHIFT;

could move the two *val = ... lines before 
return IIO_VAL_INT;

> +			break;
> +		case IIO_MOD_TEMP_OBJECT:
> +			ret = tmp007_read_temperature(data, TMP007_TOBJECT);
> +			if (ret < 0)
> +				return ret;
> +			*val = sign_extend32(ret, 15) >> TMP007_TEMP_SHIFT;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 31;
> +		*val2 = 250000;
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		conv_rate = (data->config & TMP007_CONFIG_CR_MASK)
> +				>> TMP007_CONFIG_CR_SHIFT;
> +		*val = tmp007_avgs[conv_rate][0];
> +		*val2 = tmp007_avgs[conv_rate][1];
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		break;

return -EINVAL;
here and drop it below

> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int tmp007_write_raw(struct iio_dev *indio_dev,
> +		struct iio_chan_spec const *channel, int val,
> +		int val2, long mask)
> +{
> +	struct tmp007_data *data = iio_priv(indio_dev);
> +	int i;
> +
> +	if (mask == IIO_CHAN_INFO_SAMP_FREQ) {
> +		for (i = 0; i < ARRAY_SIZE(tmp007_avgs); i++) {
> +			if ((val == tmp007_avgs[i][0]) &&
> +			(val2 == tmp007_avgs[i][1])) {
> +				data->config &= ~TMP007_CONFIG_CR_MASK;
> +				data->config |= (i << TMP007_CONFIG_CR_SHIFT);

strictly, data->config should be changed after the write;
so, setup a tmp variable
tmp = data->config & ~TMP007_CONFIG_CR_MASK;
tmp |= (i << TMP007_CONFIG_CR_SHIFT);

> +
> +				return i2c_smbus_write_word_swapped(data->client,
> +								TMP007_CONFIG,
> +								data->config);

data->config = tmp;

> +			}
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static IIO_CONST_ATTR(sampling_frequency_available, "4 2 1 0.5 0.25");
> +
> +static struct attribute *tmp007_attributes[] = {
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group tmp007_attribute_group = {
> +	.attrs = tmp007_attributes,
> +};
> +

drop extra newline

> +
> +static const struct iio_chan_spec tmp007_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_TEMP_AMBIENT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +	},
> +	{
> +		.type = IIO_TEMP,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_TEMP_OBJECT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +	}
> +};
> +
> +static const struct iio_info tmp007_info = {
> +	.read_raw = tmp007_read_raw,
> +	.write_raw = tmp007_write_raw,
> +	.attrs = &tmp007_attribute_group,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static bool tmp007_identify(struct i2c_client *client)
> +{
> +	int manf_id, dev_id;
> +
> +	manf_id = i2c_smbus_read_word_swapped(client, TMP007_MANUFACTURER_ID);
> +	if (manf_id < 0)
> +		return false;
> +
> +	dev_id = i2c_smbus_read_word_swapped(client, TMP007_DEVICE_ID);
> +	if (dev_id < 0)
> +		return false;
> +
> +	return (manf_id == TMP007_MANUFACTURER_MAGIC && dev_id == TMP007_DEVICE_MAGIC);
> +}
> +
> +static int tmp007_probe(struct i2c_client *client,
> +			const struct i2c_device_id *tmp007_id)
> +{
> +	struct tmp007_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
> +		return -EOPNOTSUPP;
> +
> +	if (!tmp007_identify(client)) {
> +		dev_err(&client->dev, "TMP007 not found\n");
> +		return -ENODEV;
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->name = dev_name(&client->dev);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &tmp007_info;
> +
> +	indio_dev->channels = tmp007_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(tmp007_channels);
> +
> +	/* Set Configuration register:
> +	 *
> +	 * 1. Conversion ON
> +	 * 2. Comparator mode
> +	 * 3. Transient correction enable
> +	 *

maybe delete empty lines to make to more concise

> +	 */
> +
> +	ret = i2c_smbus_read_word_swapped(data->client, TMP007_CONFIG);
> +	if (ret < 0)
> +		return ret;
> +
> +	data->config = ret;
> +	data->config |= (TMP007_CONFIG_CONV_EN | TMP007_CONFIG_COMP_EN |
> +				TMP007_CONFIG_TC_EN);

could go into one line

> +
> +	ret = i2c_smbus_write_word_swapped(data->client, TMP007_CONFIG,
> +					data->config);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Set Status Mask register:
> +	 *
> +	 * 1. Conversion ready enable
> +	 *

more concise

> +	 */
> +
> +	ret = i2c_smbus_read_word_swapped(data->client, TMP007_STATUS_MASK);
> +	if (ret < 0)

power down if this fails

> +		return ret;
> +
> +	data->status_mask = ret;
> +	data->status_mask |= TMP007_STATUS_CONV_READY;
> +
> +	ret = i2c_smbus_write_word_swapped(data->client, TMP007_STATUS_MASK,
> +					data->status_mask);
> +	if (ret < 0)

power down if this fails, add power function

> +		return ret;
> +
> +	return iio_device_register(indio_dev);
> +}
> +
> +static int tmp007_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct tmp007_data *data = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);

call power function

> +	i2c_smbus_write_word_swapped(data->client, TMP007_CONFIG,
> +			data->config & ~TMP007_CONFIG_CONV_EN);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int tmp007_suspend(struct device *dev)
> +{
> +	struct tmp007_data *data = iio_priv(i2c_get_clientdata(
> +			to_i2c_client(dev)));
> +

call power function

> +	return i2c_smbus_write_word_swapped(data->client, TMP007_CONFIG,
> +			data->config & ~TMP007_CONFIG_CONV_EN);
> +}
> +
> +static int tmp007_resume(struct device *dev)
> +{
> +	struct tmp007_data *data = iio_priv(i2c_get_clientdata(
> +			to_i2c_client(dev)));
> +

call power function

> +	return i2c_smbus_write_word_swapped(data->client, TMP007_CONFIG,
> +			data->config | TMP007_CONFIG_CONV_EN);
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(tmp007_pm_ops, tmp007_suspend, tmp007_resume);
> +
> +static const struct of_device_id tmp007_of_match[] = {
> +	{ .compatible = "ti,tmp007", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, tmp007_of_match);
> +
> +static const struct i2c_device_id tmp007_id[] = {
> +	{ "tmp007", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, tmp007_id);
> +
> +static struct i2c_driver tmp007_driver = {
> +	.driver = {
> +		.name	= "tmp007",
> +		.of_match_table = of_match_ptr(tmp007_of_match),
> +		.pm	= &tmp007_pm_ops,
> +	},
> +	.probe		= tmp007_probe,
> +	.remove		= tmp007_remove,
> +	.id_table	= tmp007_id,
> +};
> +module_i2c_driver(tmp007_driver);
> +
> +MODULE_AUTHOR("Manivannan Sadhasivam <manivannanece23@gmail.com>");
> +MODULE_DESCRIPTION("TI TMP007 IR thermopile sensor driver");
> +MODULE_LICENSE("GPL");
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
