Return-Path: <SRS0=Zktn=YX=gmail.com=manivannanece23@kernel.org>
Date: Mon, 9 Jan 2017 07:36:13 +0530
From: Mani Sadhasivam <manivannanece23@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3] iio:temperature: Add support for TI TMP007 sensor
Message-ID: <20170109020613.GA5069@gmail.com>
References: <20170106025006.GA9832@gmail.com>
 <9efdb51f-1b15-d8b7-8c3d-777cae4c382b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9efdb51f-1b15-d8b7-8c3d-777cae4c382b@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Jan 08, 2017 at 10:56:14AM +0000, Jonathan Cameron wrote:
> On 06/01/17 02:50, Mani Sadhasivam wrote:
> > This patch adds support for TI TMP007 - 16 bit IR thermopile sensor with integrated Math engine.
> > Sensor takes care of calculating the object temperature with the help of calibrated constants stored in non-volatile memory,
> > thereby reducing the calculation overhead.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannanece23@gmail.com>
> Pretty good.  A few minor comments inline.  It 'might' be worth using
> regmap for this part to avoid hand rolling masked partial register writes
> and caching of register values.  Perhaps it's not worth it for such a
> simple interface however.
> 
> Jonathan
Thanks Jonathan for your review.
> > ---
> > 
> > Changes in v3 (based on suggestions from Peter):
> > 
> > 1. Added data validity check for TObj
> > 2. Modified the comment style
> > 3. Added powerdown function
> > 4. Some code cleanups
> > 
> >  .../devicetree/bindings/iio/temperature/tmp007.txt |  16 +
> >  drivers/iio/temperature/Kconfig                    |  10 +
> >  drivers/iio/temperature/Makefile                   |   1 +
> >  drivers/iio/temperature/tmp007.c                   | 345 +++++++++++++++++++++
> >  4 files changed, 372 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/temperature/tmp007.txt
> >  create mode 100644 drivers/iio/temperature/tmp007.c
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/temperature/tmp007.txt b/Documentation/devicetree/bindings/iio/temperature/tmp007.txt
> > new file mode 100644
> > index 0000000..9ae0519
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/temperature/tmp007.txt
> > @@ -0,0 +1,16 @@
> > +* TI TMP007 - IR thermopile sensor with integrated math engine
> > +
> > +Link to datasheet: http://www.ti.com/lit/ds/symlink/tmp007.pdf
> > +
> > +Required properties:
> > +
> > +  - compatible: should be "ti,tmp007"
> > +  - reg: the I2C address of the sensor (changeable via ADR pins)
> Perhaps list the options that are possible?
ACK.
> > +
> > +Example:
> > +
> > +tmp007@40 {
> > +        compatible = "ti,tmp007";
> > +        reg = <0x40>;
> > +};
> > +
> > diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
> > index c4664e5..538ce9e 100644
> > --- a/drivers/iio/temperature/Kconfig
> > +++ b/drivers/iio/temperature/Kconfig
> > @@ -23,6 +23,16 @@ config TMP006
> >  	  This driver can also be built as a module. If so, the module will
> >  	  be called tmp006.
> >  
> > +config TMP007
> > +        tristate "TMP007 infrared thermopile sensor with Integrated Math Engine"
> > +        depends on I2C
> > +        help
> > +          If you say yes here you get support for the Texas Instruments
> > +          TMP007 infrared thermopile sensor with Integrated Math Engine.
> > +
> > +          This driver can also be built as a module. If so, the module will
> > +          be called tmp007.
> > +
> >  config TSYS01
> >  	tristate "Measurement Specialties TSYS01 temperature sensor using I2C bus connection"
> >  	depends on I2C
> > diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
> > index 02bc79d..f0cf5c5 100644
> > --- a/drivers/iio/temperature/Makefile
> > +++ b/drivers/iio/temperature/Makefile
> > @@ -4,5 +4,6 @@
> >  
> >  obj-$(CONFIG_MLX90614) += mlx90614.o
> >  obj-$(CONFIG_TMP006) += tmp006.o
> > +obj-$(CONFIG_TMP007) += tmp007.o
> >  obj-$(CONFIG_TSYS01) += tsys01.o
> >  obj-$(CONFIG_TSYS02D) += tsys02d.o
> > diff --git a/drivers/iio/temperature/tmp007.c b/drivers/iio/temperature/tmp007.c
> > new file mode 100644
> > index 0000000..a385ef5
> > --- /dev/null
> > +++ b/drivers/iio/temperature/tmp007.c
> > @@ -0,0 +1,345 @@
> > +/*
> > + * tmp007.c - Support for TI TMP007 IR thermopile sensor with integrated math engine
> > + *
> > + * Copyright (c) 2017 Manivannan Sadhasivam <manivannanece23@gmail.com>
> > + *
> > + * This file is subject to the terms and conditions of version 2 of
> > + * the GNU General Public License.  See the file COPYING in the main
> > + * directory of this archive for more details.
> > + *
> > + * Driver for the Texas Instruments I2C 16-bit IR thermopile sensor
> > + *
> > + * (7-bit I2C slave address (0x40 - 0x47), changeable via ADR pins)
> > + *
> > + * Note: This driver assumes that the sensor has been calibrated beforehand
> > + *
> > + * TODO: ALERT irq, limit threshold events
> > + *
> > + */
> > +
> > +#include <linux/err.h>
> > +#include <linux/i2c.h>
> > +#include <linux/delay.h>
> > +#include <linux/module.h>
> > +#include <linux/pm.h>
> > +#include <linux/bitops.h>
> > +#include <linux/of.h>
> > +
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +
> > +#define TMP007_TDIE 0x01
> > +#define TMP007_CONFIG 0x02
> > +#define TMP007_TOBJECT 0x03
> > +#define TMP007_STATUS 0x04
> > +#define TMP007_STATUS_MASK 0x05
> > +#define TMP007_MANUFACTURER_ID 0x1e
> > +#define TMP007_DEVICE_ID 0x1f
> > +
> > +#define TMP007_CONFIG_CONV_EN BIT(12)
> > +#define TMP007_CONFIG_COMP_EN BIT(5)
> > +#define TMP007_CONFIG_TC_EN BIT(6)
> > +#define TMP007_CONFIG_CR_MASK GENMASK(11, 9)
> > +#define TMP007_CONFIG_CR_SHIFT 9
> > +
> > +#define TMP007_STATUS_CONV_READY BIT(14)
> > +#define TMP007_STATUS_DATA_VALID BIT(9)
> > +
> > +#define TMP007_MANUFACTURER_MAGIC 0x5449
> > +#define TMP007_DEVICE_MAGIC 0x0078
> > +
> > +#define TMP007_TEMP_SHIFT 2
> > +
> > +struct tmp007_data {
> > +	struct i2c_client *client;
> 
> The fact you are caching values here and that everything is register
> based suggests to me that it might make sense to use regmap and take
> advantage of it's built in caching and masked write functions.
> 
> If you pefer to stick to direct smbus calls that is fine.
I'd prefer to use smbus calls over regmap here. As the usage is quite less and I don't think it'll be needed for such
simple interface.
> 
> > +	u16 config;
> 
> > +	u16 status_mask;
> Why cache this register?  It is directly read then written
> whenever used.
ACK.
> 
> > +};
> > +
> > +static const int tmp007_avgs[5][2] = { {4, 0}, {2, 0}, {1, 0},
> > +					{0, 500000}, {0, 250000} };
> > +
> > +static int tmp007_read_temperature(struct tmp007_data *data, u8 reg)
> > +{
> > +	s32 ret;
> > +	int tries = 50;
> > +
> > +	while (tries-- > 0) {
> > +		ret = i2c_smbus_read_word_swapped(data->client,
> > +			TMP007_STATUS);
> > +		if (ret < 0)
> > +			return ret;
> > +		if ((ret & TMP007_STATUS_CONV_READY) &&
> > +			!(ret & TMP007_STATUS_DATA_VALID))
> > +				break;
> > +		msleep(100);
> > +	}
> > +
> > +	if (tries < 0)
> > +		return -EIO;
> > +
> > +	return i2c_smbus_read_word_swapped(data->client, reg);
> > +}
> > +
> > +static int tmp007_powerdown(struct tmp007_data *data)
> > +{
> > +	return i2c_smbus_write_word_swapped(data->client, TMP007_CONFIG,
> > +			data->config & ~TMP007_CONFIG_CONV_EN);
> > +}
> > +
> > +static int tmp007_read_raw(struct iio_dev *indio_dev,
> > +		struct iio_chan_spec const *channel, int *val,
> > +		int *val2, long mask)
> > +{
> > +	struct tmp007_data *data = iio_priv(indio_dev);
> > +	s32 ret;
> > +	int conv_rate;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		switch (channel->channel2) {
> > +		case IIO_MOD_TEMP_AMBIENT: /* LSB: 0.03125 degree Celsius */
> > +			ret = i2c_smbus_read_word_swapped(data->client, TMP007_TDIE);
> > +			if (ret < 0)
> > +				return ret;
> > +			break;
> > +		case IIO_MOD_TEMP_OBJECT:
> > +			ret = tmp007_read_temperature(data, TMP007_TOBJECT);
> > +			if (ret < 0)
> > +				return ret;
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +
> > +		*val = sign_extend32(ret, 15) >> TMP007_TEMP_SHIFT;
> > +
> > +		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_SCALE:
> > +		*val = 31;
> > +		*val2 = 250000;
> > +
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		conv_rate = (data->config & TMP007_CONFIG_CR_MASK)
> > +				>> TMP007_CONFIG_CR_SHIFT;
> > +		*val = tmp007_avgs[conv_rate][0];
> > +		*val2 = tmp007_avgs[conv_rate][1];
> > +
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int tmp007_write_raw(struct iio_dev *indio_dev,
> > +		struct iio_chan_spec const *channel, int val,
> > +		int val2, long mask)
> > +{
> > +	struct tmp007_data *data = iio_priv(indio_dev);
> > +	int i;
> > +	u16 tmp;
> > +
> > +	if (mask == IIO_CHAN_INFO_SAMP_FREQ) {
> > +		for (i = 0; i < ARRAY_SIZE(tmp007_avgs); i++) {
> > +			if ((val == tmp007_avgs[i][0]) &&
> > +			(val2 == tmp007_avgs[i][1])) {
> > +				tmp = data->config & ~TMP007_CONFIG_CR_MASK;
> > +				tmp |= (i << TMP007_CONFIG_CR_SHIFT);
> > +
> > +				return i2c_smbus_write_word_swapped(data->client,
> > +								TMP007_CONFIG,
> > +								data->config = tmp);
> > +			}
> > +		}
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static IIO_CONST_ATTR(sampling_frequency_available, "4 2 1 0.5 0.25");
> > +
> > +static struct attribute *tmp007_attributes[] = {
> > +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> > +	NULL
> > +};
> > +
> > +static const struct attribute_group tmp007_attribute_group = {
> > +	.attrs = tmp007_attributes,
> > +};
> > +
> > +static const struct iio_chan_spec tmp007_channels[] = {
> > +	{
> > +		.type = IIO_TEMP,
> > +		.modified = 1,
> > +		.channel2 = IIO_MOD_TEMP_AMBIENT,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +				BIT(IIO_CHAN_INFO_SCALE),
> > +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> > +	},
> > +	{
> > +		.type = IIO_TEMP,
> > +		.modified = 1,
> > +		.channel2 = IIO_MOD_TEMP_OBJECT,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +				BIT(IIO_CHAN_INFO_SCALE),
> > +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> > +	}
> > +};
> > +
> > +static const struct iio_info tmp007_info = {
> > +	.read_raw = tmp007_read_raw,
> > +	.write_raw = tmp007_write_raw,
> > +	.attrs = &tmp007_attribute_group,
> > +	.driver_module = THIS_MODULE,
> > +};
> > +
> > +static bool tmp007_identify(struct i2c_client *client)
> > +{
> > +	int manf_id, dev_id;
> > +
> > +	manf_id = i2c_smbus_read_word_swapped(client, TMP007_MANUFACTURER_ID);
> > +	if (manf_id < 0)
> > +		return false;
> > +
> > +	dev_id = i2c_smbus_read_word_swapped(client, TMP007_DEVICE_ID);
> > +	if (dev_id < 0)
> > +		return false;
> > +
> > +	return (manf_id == TMP007_MANUFACTURER_MAGIC && dev_id == TMP007_DEVICE_MAGIC);
> > +}
> > +
> > +static int tmp007_probe(struct i2c_client *client,
> > +			const struct i2c_device_id *tmp007_id)
> > +{
> > +	struct tmp007_data *data;
> > +	struct iio_dev *indio_dev;
> > +	int ret;
> > +
> > +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
> > +		return -EOPNOTSUPP;
> > +
> > +	if (!tmp007_identify(client)) {
> > +		dev_err(&client->dev, "TMP007 not found\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	data = iio_priv(indio_dev);
> > +	i2c_set_clientdata(client, indio_dev);
> > +	data->client = client;
> > +
> > +	indio_dev->dev.parent = &client->dev;
> > +	indio_dev->name = dev_name(&client->dev);
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->info = &tmp007_info;
> > +
> > +	indio_dev->channels = tmp007_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(tmp007_channels);
> > +
> > +	/*
> > +	 * Set Configuration register:
> > +	 * 1. Conversion ON
> > +	 * 2. Comparator mode
> > +	 * 3. Transient correction enable
> > +	 */
> > +
> > +	ret = i2c_smbus_read_word_swapped(data->client, TMP007_CONFIG);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	data->config = ret;
> > +	data->config |= (TMP007_CONFIG_CONV_EN | TMP007_CONFIG_COMP_EN | TMP007_CONFIG_TC_EN);
> > +
> > +	ret = i2c_smbus_write_word_swapped(data->client, TMP007_CONFIG,
> > +					data->config);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/*
> > +	 * Set Status Mask register:
> > +	 * 1. Conversion ready enable
> 2. Data valid?
ACK.
> > +	 */
> > +
> > +	ret = i2c_smbus_read_word_swapped(data->client, TMP007_STATUS_MASK);
> > +	if (ret < 0)
> > +		goto error_powerdown;
> > +
> > +	data->status_mask = ret;
> > +	data->status_mask |= (TMP007_STATUS_CONV_READY | TMP007_STATUS_DATA_VALID);
> > +
> > +	ret = i2c_smbus_write_word_swapped(data->client, TMP007_STATUS_MASK,
> > +					data->status_mask);
> > +	if (ret < 0)
> > +		goto error_powerdown;
> > +
> > +	return iio_device_register(indio_dev);
> > +
> > +error_powerdown:
> > +	tmp007_powerdown(data);
> > +
> > +	return ret;
> > +}
> > +
> > +static int tmp007_remove(struct i2c_client *client)
> > +{
> > +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> > +	struct tmp007_data *data = iio_priv(indio_dev);
> > +
> > +	iio_device_unregister(indio_dev);
> > +	tmp007_powerdown(data);
> > +
> > +	return 0;
> > +}
> > +
> > +#ifdef CONFIG_PM_SLEEP
> > +static int tmp007_suspend(struct device *dev)
> > +{
> > +	struct tmp007_data *data = iio_priv(i2c_get_clientdata(
> > +			to_i2c_client(dev)));
> > +
> > +	return tmp007_powerdown(data);
> > +}
> > +
> > +static int tmp007_resume(struct device *dev)
> > +{
> > +	struct tmp007_data *data = iio_priv(i2c_get_clientdata(
> > +			to_i2c_client(dev)));
> > +
> > +	return i2c_smbus_write_word_swapped(data->client, TMP007_CONFIG,
> > +			data->config | TMP007_CONFIG_CONV_EN);
> > +}
> > +#endif
> > +
> > +static SIMPLE_DEV_PM_OPS(tmp007_pm_ops, tmp007_suspend, tmp007_resume);
> > +
> > +static const struct of_device_id tmp007_of_match[] = {
> > +	{ .compatible = "ti,tmp007", },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(of, tmp007_of_match);
> > +
> > +static const struct i2c_device_id tmp007_id[] = {
> > +	{ "tmp007", 0 },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, tmp007_id);
> > +
> > +static struct i2c_driver tmp007_driver = {
> > +	.driver = {
> > +		.name	= "tmp007",
> > +		.of_match_table = of_match_ptr(tmp007_of_match),
> > +		.pm	= &tmp007_pm_ops,
> > +	},
> > +	.probe		= tmp007_probe,
> > +	.remove		= tmp007_remove,
> > +	.id_table	= tmp007_id,
> > +};
> > +module_i2c_driver(tmp007_driver);
> > +
> > +MODULE_AUTHOR("Manivannan Sadhasivam <manivannanece23@gmail.com>");
> > +MODULE_DESCRIPTION("TI TMP007 IR thermopile sensor driver");
> > +MODULE_LICENSE("GPL");
> > 
> 
