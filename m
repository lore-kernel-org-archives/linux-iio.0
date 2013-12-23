Return-Path: <pmeerw@pmeerw.net>
Date: Mon, 23 Dec 2013 09:07:39 +0100 (CET)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
cc: Kevin Tsai <ktsai@capellamicro.com>, Lars-Peter Clausen <lars@metafoo.de>,
    Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>,
    linux-iio@vger.kernel.org
Subject: Re: [PATCH V2 1/1] iio: add Capella CM32181 ambient light sensor
 driver.
In-Reply-To: <52B70C92.6000006@kernel.org>
Message-ID: <alpine.DEB.2.01.1312230856400.27138@pmeerw.net>
References: <1387408251-4066-1-git-send-email-ktsai@capellamicro.com> <52B70C92.6000006@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


nitpicking

> On 12/18/13 23:10, Kevin Tsai wrote:
> > Add Capella Microsystem CM32181 Ambient Light Sensor IIO driver.
> > This driver will convert raw data to lux value under open-air
> > condition. Change the calibscale based on the cover material.
> >
> > Signed-off-by: Kevin Tsai <ktsai@capellamicro.com>
> Hi Kevin,
> 
> The device tree binding still needs documenting - probably in
> Documentation/devicetree/bindings/i2c/trivial-devices.txt
> 
> That binding needs to be sent to devicetree@vger.kernel.org.
> The easiest option is probably going to be to do a v3 of this
> patch with that included and send it to both linux-iio and devicetree
> mailing lists.
> 
> There are a few more comments inline.  Mainly little things like putting
> function documentation into kernel-doc style and slight tweaks to code
> ordering / error paths that make things a little bit cleaner.
> 
> Probably just a few minutes work to be ready to go.
> 
> Jonathan
> > ---
> >  drivers/iio/light/Kconfig   |  11 ++
> >  drivers/iio/light/Makefile  |   1 +
> >  drivers/iio/light/cm32181.c | 354 ++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 366 insertions(+)
> >  create mode 100644 drivers/iio/light/cm32181.c
> >
> > diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> > index a022f27..d12b2a0 100644
> > --- a/drivers/iio/light/Kconfig
> > +++ b/drivers/iio/light/Kconfig
> > @@ -27,6 +27,17 @@ config APDS9300
> >  	 To compile this driver as a module, choose M here: the
> >  	 module will be called apds9300.
> >
> > +config CM32181
> > +	depends on I2C
> > +	tristate "CM32181 driver"
> > +	help
> > +	 Say Y here if you use cm32181.
> > +	 This option enables ambient light sensor using
> > +	 Capella cm32181 device driver.
> > +
> > +	 To compile this driver as a module, choose M here:
> > +	 the module will be called cm32181.
> > +
> >  config CM36651
> >  	depends on I2C
> >  	tristate "CM36651 driver"
> > diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> > index daa327f..60e35ac 100644
> > --- a/drivers/iio/light/Makefile
> > +++ b/drivers/iio/light/Makefile
> > @@ -5,6 +5,7 @@
> >  # When adding new entries keep the list in alphabetical order
> >  obj-$(CONFIG_ADJD_S311)		+= adjd_s311.o
> >  obj-$(CONFIG_APDS9300)		+= apds9300.o
> > +obj-$(CONFIG_CM32181)		+= cm32181.o
> >  obj-$(CONFIG_CM36651)		+= cm36651.o
> >  obj-$(CONFIG_GP2AP020A00F)	+= gp2ap020a00f.o
> >  obj-$(CONFIG_HID_SENSOR_ALS)	+= hid-sensor-als.o
> > diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> > new file mode 100644
> > index 0000000..305789b
> > --- /dev/null
> > +++ b/drivers/iio/light/cm32181.c
> > @@ -0,0 +1,354 @@
> > +/*
> > + * Copyright (C) 2013 Capella Microsystems Inc.
> > + * Author: Kevin Tsai <ktsai@capellamicro.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms of the GNU General Public License version 2, as published
> > + * by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/err.h>
> > +#include <linux/i2c.h>
> > +#include <linux/mutex.h>
> > +#include <linux/module.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/iio/events.h>
> > +#include <linux/init.h>
> > +
> > +/* Registers Address */
> > +#define CM32181_REG_ADDR_CMD		0x00
> > +#define CM32181_REG_ADDR_ALS		0x04
> > +#define CM32181_REG_ADDR_STATUS		0x06
> > +#define CM32181_REG_ADDR_ID		0x07
> > +
> > +/* Number of Configurable Registers */
> > +#define CM32181_CONF_REG_NUM		0x01
> > +
> > +/* CMD register */
> > +#define CM32181_CMD_ALS_ENABLE		0x00
> > +#define CM32181_CMD_ALS_DISABLE		0x01
> > +#define CM32181_CMD_ALS_INT_EN		0x02
> > +
> > +#define CM32181_CMD_ALS_IT_SHIFT	6
> > +#define CM32181_CMD_ALS_IT_MASK		(0x0F << CM32181_CMD_ALS_IT_SHIFT)
> > +#define CM32181_CMD_ALS_IT_DEFAULT	(0x00 << CM32181_CMD_ALS_IT_SHIFT)
> > +
> > +#define CM32181_CMD_ALS_SM_SHIFT	11
> > +#define CM32181_CMD_ALS_SM_MASK		(0x03 << CM32181_CMD_ALS_SM_SHIFT)
> > +#define CM32181_CMD_ALS_SM_DEFAULT	(0x01 << CM32181_CMD_ALS_SM_SHIFT)
> > +
> > +#define CM32181_MLUX_PER_BIT		5	/* ALS_SM=01 IT=800ms */
> > +#define CM32181_MLUX_PER_BIT_BASE_IT	800000	/* Based on IT=800ms */
> > +#define CM32181_CALIBSCALE_RESOLUTION	1000
> > +#define MLUX_PER_LUX			1000
> > +
> > +static const u8 cm32181_reg[CM32181_CONF_REG_NUM] = {
> > +	CM32181_REG_ADDR_CMD,
> > +};
> > +
> > +static const int als_it_bits[] = {12, 8, 0, 1, 2, 3};
> > +static int als_it_value[] = {25000, 50000, 100000, 200000, 400000, 800000};

const

> > +
> > +struct cm32181_chip {
> > +	struct i2c_client *client;
> > +	struct mutex lock;
> > +	u16 conf_regs[CM32181_CONF_REG_NUM];
> > +	int calibscale;
> > +};
> > +
> > +static int cm32181_reg_init(struct cm32181_chip *cm32181)
> > +{
> > +	struct i2c_client *client = cm32181->client;
> > +	int i;
> > +	s32 ret;
> > +
> > +	cm32181->conf_regs[CM32181_REG_ADDR_CMD] = CM32181_CMD_ALS_ENABLE |
> > +			CM32181_CMD_ALS_IT_DEFAULT | CM32181_CMD_ALS_SM_DEFAULT;
> > +
> > +	for (i = 0; i < CM32181_CONF_REG_NUM; i++) {
> > +		ret = i2c_smbus_write_word_data(client, cm32181_reg[i],
> > +			cm32181->conf_regs[i]);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> > +
> > +	cm32181->calibscale = 1000;
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + *  Get sensor integration time (ms).
> > + *  Return: IIO_VAL_INT for success, otherwise -EINVAL.
> > + */
> > +static int cm32181_read_als_it(struct cm32181_chip *cm32181, int *val)
> > +{
> > +	u16 als_it;
> > +	int i;
> > +
> > +	als_it = cm32181->conf_regs[CM32181_REG_ADDR_CMD];
> > +	als_it &= CM32181_CMD_ALS_IT_MASK;
> > +	als_it >>= CM32181_CMD_ALS_IT_SHIFT;
> > +	for (i = 0; i < sizeof(als_it_bits)/sizeof(als_it_bits[0]); i++) {

ARRAY_SIZE()

> > +		if (als_it == als_it_bits[i]) {
> > +			*val = als_it_value[i];
> > +			if (*val == 0)

it can never become 0 since there is no 0 in als_it_value

> > +				return -EINVAL;
> > +			return IIO_VAL_INT;
> > +		}
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +/*
> > + * Convert integration time (ms) to sensor value.
> > + * Return: i2c_smbus_write_word_data command return value.
> > + */
> > +static int cm32181_write_als_it(struct cm32181_chip *cm32181, int val)
> > +{
> > +	struct i2c_client *client = cm32181->client;
> > +	u16 als_it;
> > +	int ret, i, n;
> > +
> > +	n = sizeof(als_it_value)/sizeof(als_it_value[0]);

ARRAY_SIZE()

> > +	for (i = 0; i < n; i++)
> > +		if (val <= als_it_value[i])
> > +			break;
> > +	if (i >= n)
> Should be spaces around that -.
> Please make sure to run scripts/checkpatch.pl which I would have
> expected to catch this and any other similar cases..
> > +		i = n-1;
> > +
> > +	als_it = als_it_bits[i];
> > +	als_it <<= CM32181_CMD_ALS_IT_SHIFT;
> > +
> > +	mutex_lock(&cm32181->lock);
> > +	cm32181->conf_regs[CM32181_REG_ADDR_CMD] &=
> > +		~CM32181_CMD_ALS_IT_MASK;
> > +	cm32181->conf_regs[CM32181_REG_ADDR_CMD] |=
> > +		als_it;
> > +	ret = i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
> > +			cm32181->conf_regs[CM32181_REG_ADDR_CMD]);
> > +	mutex_unlock(&cm32181->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +/*
> 
> Ideally any documentation will be in kernel-doc style
> Documentation/kernel-doc-nano-HOWTO.txt
> 
> > + * Convert sensor data to lux.
> > + * Return: Positive value is lux, otherwise is error code.
> > + */
> > +static int cm32181_get_lux(struct cm32181_chip *cm32181)
> > +{
> > +	struct i2c_client *client = cm32181->client;
> > +	int ret;
> > +	int als_it;
> > +	unsigned long lux;
> > +
> > +	ret = cm32181_read_als_it(cm32181, &als_it);
> > +	if (ret < 0)
> > +		return -EINVAL;
> > +
> > +	lux = CM32181_MLUX_PER_BIT;
> > +	lux *= CM32181_MLUX_PER_BIT_BASE_IT;
> > +	lux /= als_it;
> > +
> > +	ret = i2c_smbus_read_word_data(client, CM32181_REG_ADDR_ALS);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	lux *= ret;
> > +	lux *= cm32181->calibscale;
> > +	lux /= CM32181_CALIBSCALE_RESOLUTION;
> > +	lux /= MLUX_PER_LUX;
> > +
> > +	if (lux > 0xFFFF)
> > +		lux = 0xFFFF;
> > +
> > +	return (int)lux;

explicit cast not needed

> > +}
> > +
> > +static int cm32181_read_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan,
> > +			    int *val, int *val2, long mask)
> > +{
> > +	struct cm32181_chip *cm32181 = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_PROCESSED:
> > +		ret = cm32181_get_lux(cm32181);
> > +		if (ret < 0)
> > +			return ret;
> > +		*val = ret;
> Might as well return from here...
> return IIO_VAL_INT;
> instead of bothering with the break.
> > +		ret = IIO_VAL_INT;
> > +		break;
> > +	case IIO_CHAN_INFO_CALIBSCALE:
> > +		*val = cm32181->calibscale;
> > +		ret = IIO_VAL_INT;
> > +		break;
> > +	case IIO_CHAN_INFO_INT_TIME:
> > +		ret = cm32181_read_als_it(cm32181, val);
> > +		if (ret < 0)
> > +			return ret;
> > +		break;
> > +	default:
> > +		ret = -EINVAL;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int cm32181_write_raw(struct iio_dev *indio_dev,
> > +			     struct iio_chan_spec const *chan,
> > +			     int val, int val2, long mask)
> > +{
> > +	struct cm32181_chip *cm32181 = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_CALIBSCALE:
> > +		cm32181->calibscale = val;
> > +		ret = val;
> > +		break;
> > +	case IIO_CHAN_INFO_INT_TIME:
> > +		ret = cm32181_write_als_it(cm32181, val);
> > +		if (ret < 0)
> > +			return ret;
> > +		break;
> > +	default:
> > +		ret = -EINVAL;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> 
> Function should have a prefix. Its just possible someone
> will one day introduce a generic get_it_available
> and hence cause a name clash.
> 
> hence
> cm32181_get_it_available(...)
> > +static ssize_t get_it_available(struct device *dev,
> > +			struct device_attribute *attr, char *buf)
> > +{
> > +	int i, n, len;
> > +
> > +	n = sizeof(als_it_value)/sizeof(als_it_value[0]);

ARRAY_SIZE()

> > +	for (i = 0, len = 0; i < n; i++)
> > +		len += sprintf(buf + len, "%d ", als_it_value[i]);
> > +	return len + sprintf(buf + len, "\n");
> > +}
> > +
> > +static const struct iio_chan_spec cm32181_channels[] = {
> > +	{
> > +		.type = IIO_LIGHT,
> > +		.indexed = 0,
> > +		.channel = 0,

.indexed and .channel not needed, default to zero

> > +		.info_mask_separate =
> > +			BIT(IIO_CHAN_INFO_PROCESSED) |
> > +			BIT(IIO_CHAN_INFO_CALIBSCALE) |
> > +			BIT(IIO_CHAN_INFO_INT_TIME),
> > +	}
> > +};
> > +
> > +
> > +static IIO_DEVICE_ATTR(in_illuminance_integration_time_available,
> > +			S_IRUGO, get_it_available, NULL, 0);
> > +
> > +static struct attribute *cm32181_attributes[] = {
> > +	&iio_dev_attr_in_illuminance_integration_time_available.dev_attr.attr,
> > +	NULL,
> > +};
> > +
> > +static const struct attribute_group cm32181_attribute_group = {
> > +	.attrs = cm32181_attributes
> > +};
> > +
> > +static const struct iio_info cm32181_info = {
> > +	.driver_module		= THIS_MODULE,
> > +	.read_raw		= &cm32181_read_raw,
> > +	.write_raw		= &cm32181_write_raw,
> > +	.attrs			= &cm32181_attribute_group,
> > +};
> > +
> > +static int cm32181_probe(struct i2c_client *client,
> > +			const struct i2c_device_id *id)
> > +{
> > +	struct cm32181_chip *cm32181;
> > +	struct iio_dev *indio_dev;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*cm32181));
> > +	if (!indio_dev) {
> > +		dev_err(&client->dev, "devm_iio_device_alloc failed\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	cm32181 = iio_priv(indio_dev);
> > +	i2c_set_clientdata(client, indio_dev);
> > +	cm32181->client = client;
> > +
> > +	mutex_init(&cm32181->lock);
> > +	indio_dev->dev.parent = &client->dev;
> > +	indio_dev->channels = cm32181_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(cm32181_channels);
> > +	indio_dev->info = &cm32181_info;
> > +	indio_dev->name = id->name;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +
> > +	ret = cm32181_reg_init(cm32181);
> > +	if (ret) {
> > +		dev_err(&client->dev,
> > +			"%s: register init failed\n",
> > +			__func__);
>  return ret;
> > +		goto error_disable_reg;
> > +	}
> > +
> > +	ret = iio_device_register(indio_dev);
> > +	if (ret) {
> > +		dev_err(&client->dev,
> > +			"%s: regist device failed\n",
> > +			__func__);
> return ret
> > +		goto error_disable_reg;
> > +	}
> > +
> > +	return 0;
> > +
> Don't bother with this - just return directly when the errors
> occur. See above.
> > +error_disable_reg:
> > +	return ret;
> > +}
> > +
> 
> As mentioned before, the staging-next tree includes
> devm_iio_device_register and if you use that, then no
> remove funciton will be needed.
> 
> > +static int cm32181_remove(struct i2c_client *client)
> > +{
> > +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> > +
> > +	iio_device_unregister(indio_dev);
> > +	return 0;
> > +}
> > +
> > +static const struct i2c_device_id cm32181_id[] = {
> > +	{ "cm32181", 0 },
> > +	{ }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(i2c, cm32181_id);
> > +
> > +static const struct of_device_id cm32181_of_match[] = {
> > +	{ .compatible = "capella,cm32181" },
> > +	{ }
> > +};
> > +
> > +static struct i2c_driver cm32181_driver = {
> > +	.driver = {
> > +		.name	= "cm32181",
> > +		.of_match_table = of_match_ptr(cm32181_of_match),
> > +		.owner	= THIS_MODULE,
> > +	},
> > +	.id_table       = cm32181_id,
> > +	.probe		= cm32181_probe,
> > +	.remove		= cm32181_remove,
> > +};
> > +
> > +module_i2c_driver(cm32181_driver);
> > +
> > +MODULE_AUTHOR("Kevin Tsai <ktsai@capellamicro.com>");
> > +MODULE_DESCRIPTION("CM32181 ambient light sensor driver");
> > +MODULE_LICENSE("GPL");
> >
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
