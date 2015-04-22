Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:34878 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbbDVRlM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 Apr 2015 13:41:12 -0400
Date: Wed, 22 Apr 2015 19:36:00 +0200
From: tduszyns@gmail.com
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Tomasz Duszynski <tduszyns@gmail.com>, jic23@kernel.org,
	knaack.h@gmx.de, lars@metafoo.de, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: light: add support for ROHM
 BH1710/BH1715/BH1721/BH1750/BH1751 ambient light sensors
Message-ID: <20150422173600.GA8715@Arch.lan>
References: <1429641822-2007-1-git-send-email-tduszyns@gmail.com>
 <alpine.DEB.2.02.1504221029470.31638@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <alpine.DEB.2.02.1504221029470.31638@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Apr 22, 2015 at 10:49:21AM +0200, Peter Meerwald wrote:
> On Tue, 21 Apr 2015, Tomasz Duszynski wrote:
>
> > Add support for ROHM BH1710/BH1715/BH1721/BH1750/BH1751 ambient light
> > sensors.
>
> nice, some comments inline
>
> > Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> > ---
> >  drivers/iio/light/Kconfig  |  10 ++
> >  drivers/iio/light/Makefile |   1 +
> >  drivers/iio/light/bh1750.c | 322 +++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 333 insertions(+)
> >  create mode 100644 drivers/iio/light/bh1750.c
> >
> > diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> > index 5a3237b..9fb79ca 100644
> > --- a/drivers/iio/light/Kconfig
> > +++ b/drivers/iio/light/Kconfig
> > @@ -37,6 +37,16 @@ config APDS9300
> >  	 To compile this driver as a module, choose M here: the
> >  	 module will be called apds9300.
> >
> > +config BH1750
> > +	tristate "BH1750 ambient light sensor"
> > +	depends on I2C
> > +	help
> > +	 Say Y here to build support for the BH1710, BH1715, BH1721,
> > +	 BH1750, BH1751 ambient light sensors.
> > +
> > +	 To compile this driver as a module, choose M here: the module will
> > +	 be called bh1750.
> > +
> >  config CM32181
> >  	depends on I2C
> >  	tristate "CM32181 driver"
> > diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> > index 74656c1..1a13184 100644
> > --- a/drivers/iio/light/Makefile
> > +++ b/drivers/iio/light/Makefile
> > @@ -6,6 +6,7 @@
> >  obj-$(CONFIG_ADJD_S311)		+= adjd_s311.o
> >  obj-$(CONFIG_AL3320A)		+= al3320a.o
> >  obj-$(CONFIG_APDS9300)		+= apds9300.o
> > +obj-$(CONFIG_BH1750)		+= bh1750.o
> >  obj-$(CONFIG_CM32181)		+= cm32181.o
> >  obj-$(CONFIG_CM36651)		+= cm36651.o
> >  obj-$(CONFIG_GP2AP020A00F)	+= gp2ap020a00f.o
> > diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
> > new file mode 100644
> > index 0000000..83b5413
> > --- /dev/null
> > +++ b/drivers/iio/light/bh1750.c
> > @@ -0,0 +1,322 @@
> > +/*
> > + * ROHM BH1710/BH1715/BH1721/BH1750/BH1751 ambient light sensor driver
> > + *
> > + * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * Data sheets:
> > + *  http://rohmfs.rohm.com/en/products/databook/datasheet/ic/sensor/light/bh1710fvc-e.pdf
> > + *  http://rohmfs.rohm.com/en/products/databook/datasheet/ic/sensor/light/bh1715fvc-e.pdf
> > + *  http://rohmfs.rohm.com/en/products/databook/datasheet/ic/sensor/light/bh1721fvc-e.pdf
> > + *  http://rohmfs.rohm.com/en/products/databook/datasheet/ic/sensor/light/bh1750fvi-e.pdf
> > + *  http://rohmfs.rohm.com/en/products/databook/datasheet/ic/sensor/light/bh1751fvi-e.pdf
> > + *
> > + * 7-bit I2C slave addresses:
> > + *  0x23 (ADDR pin low)
> > + *  0x5C (ADDR pin high)
> > + *
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/i2c.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/module.h>
> > +
> > +#define BH1750_POWER_DOWN		0x00
> > +#define BH1750_H_RES_MODE		0x10 /* auto-mode for BH1721 */
> > +#define BH1750_CHANGE_INT_TIME_H_BIT	0x40
> > +#define BH1750_CHANGE_INT_TIME_L_BIT	0x60
> > +
> > +enum {
> > +	BH1710,
> > +	BH1715,
> > +	BH1721,
> > +	BH1750,
> > +	BH1751
> > +};
> > +
> > +struct bh1750_chip_info {
> > +	int id;
>
> why is the id stored in chip_info?
> the point of the chip_info table is to avoid switch blocks in the driver;
> I suggest to move remaining chip-dependent values to the table and drop
> the id
>
OK.
> > +	int mtreg_min;
> > +	int mtreg_max;
> > +	int mtreg_default;
>
> u16, these are values stored in an u16 register
>
Right. Will fix that.
> > +	int mtreg_to_usec;
> > +	int mtreg_to_scale;
> > +};
> > +
> > +struct bh1750_data {
> > +	struct i2c_client *client;
> > +	struct mutex lock;
> > +	const struct bh1750_chip_info *chip_info;
> > +	u16 mtreg;
> > +};
> > +
> > +static const struct bh1750_chip_info chip_info_tbl[] = {
> > +	[BH1710] = { BH1710, 140, 1022, 300, 400,  4000 },
> > +	[BH1715] = { BH1715, 31,  254,  69,  1740, 17391 },
> > +	[BH1721] = { BH1721, 140, 1020, 300, 400,  4000 },
> > +	[BH1750] = { BH1750, 31,  254,  69,  1740, 17391 },
> > +	[BH1751] = { BH1751, 31,  254,  69,  1740, 17391 }
> > +};
> > +
> > +static int bh1750_change_int_time(struct bh1750_data *data, int usec)
> > +{
> > +	int ret, val;
> > +	u8 low = 0, high = 0;
>
> initialization not needed, low/high should always be set
>
The idea was to make gcc stop complaining that some values
can be uninitialized. Will change that in next patch.
> > +	const struct bh1750_chip_info *chip_info = data->chip_info;
> > +
> > +	if ((usec % chip_info->mtreg_to_usec) != 0)
> > +		return -EINVAL;
> > +
> > +	val = usec / chip_info->mtreg_to_usec;
> > +	if (val < chip_info->mtreg_min || val > chip_info->mtreg_max)
> > +		return -EINVAL;
> > +
> > +	switch (chip_info->id) {
> > +	case BH1710:
> > +		low = val & 0x001F;
> > +		high = (val & 0x03E0) >> 5;
> > +		break;
> > +	case BH1721:
> > +		low = val & 0x0010;
> > +		high = (val & 0x03E0) >> 5;
>
> break missing?
>
Right.
> > +	case BH1715:
> > +	case BH1750:
> > +	case BH1751:
> > +		low = val & 0x001F;
> > +		high = (val & 0x00E0) >> 5;
> > +		break;
> > +	}
> > +
> > +	ret = i2c_smbus_write_byte(data->client, BH1750_POWER_DOWN);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = i2c_smbus_write_byte(data->client,
> > +				   BH1750_CHANGE_INT_TIME_H_BIT | high);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = i2c_smbus_write_byte(data->client,
> > +				   BH1750_CHANGE_INT_TIME_L_BIT | low);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	data->mtreg = val;
> > +
> > +	return i2c_smbus_write_byte(data->client, BH1750_H_RES_MODE);
> > +}
> > +
> > +static int bh1750_read_raw(struct iio_dev *indio_dev,
> > +			   struct iio_chan_spec const *chan,
> > +			   int *val, int *val2, long mask)
> > +{
> > +	u16 result;
> > +	int ret, tmp;
> > +	unsigned long delay;
> > +	struct bh1750_data *data = iio_priv(indio_dev);
> > +	const struct bh1750_chip_info *chip_info = data->chip_info;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		switch (chan->type) {
> > +		case IIO_INTENSITY:
> > +			delay = chip_info->mtreg_to_usec * data->mtreg;
> > +			mutex_lock(&data->lock);
> > +			usleep_range(delay, delay + 20000);
>
> the driver uses continuous mode and there is no data-ready flag
>
> why not using one time mode?, I think this would better fit in what other
> drivers are doing
>
One time mode is not supported by all chips. It was just easier to use
mode that fits all. Anyway, I will rethink that part.
> > +			ret = i2c_master_recv(data->client,
> > +					      (char *)&result, 2);
>
> almost all drivers use i2c_smbus_read_word_xxx() -- is there a reason not
> to?
>
Yes. In BH17xx case you address device and then read two bytes with
measurement result - no sending additional command in between.
> > +			mutex_unlock(&data->lock);
> > +			if (ret < 0)
> > +				return ret;
> > +
> > +			*val = swab16(result);
> > +			return IIO_VAL_INT;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_SCALE:
> > +		tmp = chip_info->mtreg_to_scale * data->mtreg;
>
> use the variable delay as above; the same computation is done in every
> switch case
>
OK.
> > +		*val = tmp / 1000000;
> > +		*val2 = tmp % 1000000;
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	case IIO_CHAN_INFO_INT_TIME:
> > +		*val = 0;
> > +		*val2 = chip_info->mtreg_to_usec * data->mtreg;
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int bh1750_write_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan,
> > +			    int val, int val2, long mask)
> > +{
> > +	int ret;
> > +	struct bh1750_data *data = iio_priv(indio_dev);
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_INT_TIME:
> > +		if (val != 0)
> > +			return -EINVAL;
> > +
> > +		mutex_lock(&data->lock);
> > +		ret = bh1750_change_int_time(data, val2);
> > +		mutex_unlock(&data->lock);
> > +		return ret;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static ssize_t bh1750_show_int_time_available(struct device *dev,
> > +		struct device_attribute *attr, char *buf)
> > +{
> > +	int i, inc;
> > +	size_t len = 0;
> > +	struct bh1750_data *data = iio_priv(dev_to_iio_dev(dev));
> > +	const struct bh1750_chip_info *chip_info = data->chip_info;
> > +
> > +	switch (chip_info->id) {
> > +	case BH1710:
> > +	case BH1721:
> > +		/* All values won't fit into one page, so display every
> > +		 * second one. By doing so step size is increased
> > +		 * from 0.4ms to 0.8ms.*/
>
> multi-line comment style?;
> missing space before */
>
Right.
> > +		inc = 2;
> > +		break;
> > +	default:
> > +		inc = 1;
> > +		break;
> > +	}
> > +
> > +	for (i = chip_info->mtreg_min; i <= chip_info->mtreg_max; i += inc)
> > +		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%06d ",
> > +				 i * chip_info->mtreg_to_usec);
> > +
> > +	buf[len - 1] = '\n';
> > +
> > +	return len;
> > +}
> > +
> > +static IIO_DEV_ATTR_INT_TIME_AVAIL(bh1750_show_int_time_available);
> > +
> > +static struct attribute *bh1750_attributes[] = {
> > +	&iio_dev_attr_integration_time_available.dev_attr.attr,
> > +	NULL,
> > +};
> > +
> > +static struct attribute_group bh1750_attribute_group = {
> > +	.attrs = bh1750_attributes,
> > +};
> > +
> > +static const struct iio_info bh1750_info = {
> > +	.driver_module = THIS_MODULE,
> > +	.attrs = &bh1750_attribute_group,
> > +	.read_raw = bh1750_read_raw,
> > +	.write_raw = bh1750_write_raw,
> > +};
> > +
> > +static const struct iio_chan_spec bh1750_channels[] = {
> > +	{
> > +		.type = IIO_INTENSITY,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +				      BIT(IIO_CHAN_INFO_SCALE) |
> > +				      BIT(IIO_CHAN_INFO_INT_TIME)
> > +	}
> > +};
> > +
> > +static int bh1750_probe(struct i2c_client *client,
> > +			const struct i2c_device_id *id)
> > +{
> > +	int ret, usec;
> > +	struct bh1750_data *data;
> > +	struct iio_dev *indio_dev;
> > +
> > +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
> > +				I2C_FUNC_SMBUS_WRITE_BYTE))
> > +		return -ENODEV;
> > +
> > +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	data = iio_priv(indio_dev);
> > +	i2c_set_clientdata(client, indio_dev);
> > +	data->client = client;
> > +	data->chip_info = &chip_info_tbl[id->driver_data];
> > +
> > +	usec = data->chip_info->mtreg_to_usec * data->chip_info->mtreg_default;
> > +	ret = bh1750_change_int_time(data, usec);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	mutex_init(&data->lock);
> > +	indio_dev->dev.parent = &client->dev;
> > +	indio_dev->info = &bh1750_info;
> > +	indio_dev->name = id->name;
> > +	indio_dev->channels = bh1750_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(bh1750_channels);
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +
> > +	return devm_iio_device_register(&client->dev, indio_dev);
>
> chip should probably be powered down if this fails; or use one-time mode
>
OK.
> > +}
> > +
> > +#ifdef CONFIG_PM_SLEEP
> > +static int bh1750_suspend(struct device *dev)
> > +{
> > +	int ret;
> > +	struct bh1750_data *data =
> > +		iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
> > +
> > +	mutex_lock(&data->lock);
> > +	ret = i2c_smbus_write_byte(data->client, BH1750_POWER_DOWN);
> > +	mutex_unlock(&data->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int bh1750_resume(struct device *dev)
> > +{
> > +	struct bh1750_data *data =
> > +		iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
> > +
> > +	return i2c_smbus_write_byte(data->client, BH1750_H_RES_MODE);
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(bh1750_pm_ops, bh1750_suspend, bh1750_resume);
> > +#define BH1750_PM_OPS (&bh1750_pm_ops)
> > +#else
> > +#define BH1750_PM_OPS NULL
> > +#endif
> > +
> > +static const struct i2c_device_id bh1750_id[] = {
> > +	{ "bh1710", BH1710 },
> > +	{ "bh1715", BH1715 },
> > +	{ "bh1721", BH1721 },
> > +	{ "bh1750", BH1750 },
> > +	{ "bh1751", BH1751 },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, bh1750_id);
> > +
> > +static struct i2c_driver bh1750_driver = {
> > +	.driver = {
> > +		.name = "bh1750",
> > +		.owner = THIS_MODULE,
> > +		.pm = BH1750_PM_OPS,
> > +	},
>
> .remove to power down
>
OK.
> > +	.probe = bh1750_probe,
> > +	.id_table = bh1750_id,
> > +
> > +};
> > +module_i2c_driver(bh1750_driver);
> > +
> > +MODULE_AUTHOR("Tomasz Duszynski <tduszyns@gmail.com>");
> > +MODULE_DESCRIPTION("ROHM BH1710/BH1715/BH1721/BH1750/BH1751 als driver");
> > +MODULE_LICENSE("GPL v2");
> >
>
> --
>
> Peter Meerwald
> +43-664-2444418 (mobile)

Thanks for review!
