Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:55429 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750904AbbJSLA7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 19 Oct 2015 07:00:59 -0400
Date: Mon, 19 Oct 2015 13:00:56 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Joachim Eastwood <manabian@gmail.com>
cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: accel: add Freescale MMA7455L 3-axis accelerometer
 driver
In-Reply-To: <1445120719-29685-1-git-send-email-manabian@gmail.com>
Message-ID: <alpine.DEB.2.02.1510191249580.9654@pmeerw.net>
References: <1445120719-29685-1-git-send-email-manabian@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> Add support for Freescale MMA7455L 3-axis in 10-bit mode with both
> I2C and SPI bus support. This is a rather simple driver that
> currently doesn't support all the hardware features of MMA7455L.

please add a link to the datasheet

comments below
 
> Tested on Embedded Artists' LPC4357 Dev Kit using I2C bus.
> 
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> ---
> 
>  drivers/iio/accel/Kconfig   |  14 ++
>  drivers/iio/accel/Makefile  |   1 +
>  drivers/iio/accel/mma7455.c | 424 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 439 insertions(+)
>  create mode 100644 drivers/iio/accel/mma7455.c
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index a59047d7657e..8ccb3de85484 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -99,6 +99,20 @@ config KXCJK1013
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called kxcjk-1013.
>  
> +config MMA7455
> +	tristate "Freescale MMA7455L Accelerometer Driver"
> +	depends on I2C || SPI_MASTER
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	select REGMAP_I2C if I2C
> +	select REGMAP_SPI if SPI_MASTER
> +	help
> +	  Say yes here to build support for the Freescale MMA7455L 3-axis
> +	  accelerometer.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called mma7455.
> +
>  config MMA8452
>  	tristate "Freescale MMA8452Q Accelerometer Driver"
>  	depends on I2C
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index ebd2675b2a02..6ac9382761f8 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel.o
>  obj-$(CONFIG_HID_SENSOR_ACCEL_3D) += hid-sensor-accel-3d.o
>  obj-$(CONFIG_KXCJK1013) += kxcjk-1013.o
>  obj-$(CONFIG_KXSD9)	+= kxsd9.o
> +obj-$(CONFIG_MMA7455)	+= mma7455.o
>  obj-$(CONFIG_MMA8452)	+= mma8452.o
>  
>  obj-$(CONFIG_MMA9551_CORE)	+= mma9551_core.o
> diff --git a/drivers/iio/accel/mma7455.c b/drivers/iio/accel/mma7455.c
> new file mode 100644
> index 000000000000..fa62f2bcb54a
> --- /dev/null
> +++ b/drivers/iio/accel/mma7455.c
> @@ -0,0 +1,424 @@
> +/*
> + * mma7455.c - Support for Freescale MMA7455L 3-axis 10-bit accelerometer
> + * Copyright 2015 Joachim Eastwood <manabian@gmail.com>
> + *
> + * Based on MMA8452Q IIO driver
> + * Copyright 2014 Peter Meerwald <pmeerw@pmeerw.net>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * UNSUPPORTED hardware features:
> + *  - 8-bit mode with different scales
> + *  - INT1/INT2 interrupts
> + *  - Offset calibration
> + *  - Events
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +
> +#define MMA7455_REG_XOUTL		0x00
> +#define MMA7455_REG_XOUTH		0x01
> +#define MMA7455_REG_YOUTL		0x02
> +#define MMA7455_REG_YOUTH		0x03
> +#define MMA7455_REG_ZOUTL		0x04
> +#define MMA7455_REG_ZOUTH		0x05
> +#define MMA7455_REG_STATUS		0x09
> +#define  MMA7455_STATUS_DRDY		BIT(0)

whitespace inconsistencies

> +#define MMA7455_REG_WHOAMI		0x0f
> +#define  MMA7455_WHOAMI_ID		0x55
> +#define MMA7455_REG_MCTL		0x16
> +#define  MMA7455_MCTL_MODE_STANDBY	0x00
> +#define  MMA7455_MCTL_MODE_MEASURE	0x01
> +#define MMA7455_REG_CTL1		0x18
> +#define  MMA7455_CTL1_DFBW_MASK		BIT(7)
> +#define  MMA7455_CTL1_DFBW_125HZ	BIT(7)
> +#define  MMA7455_CTL1_DFBW_62_5HZ	0
> +#define MMA7455_REG_TW			0x1e
> +
> +/*
> + * When MMA7455 is used in 10-bit it has a fullscale of -8g
> + * corresponding to raw value -512. The userspace interface
> + * uses m/s^2 and we declare micro units.
> + * So scale factor is given by:
> + *       g * 8 * 1e6 / 512 = 153228.90625, with g = 9.80665
> + */
> +#define MMA7455_10BIT_SCALE	153229
> +
> +struct mma7455_data {
> +	struct regmap *regmap;
> +	struct device *dev;
> +};
> +
> +static int mma7455_drdy(struct mma7455_data *mma7455)
> +{
> +	unsigned int reg;
> +	int tries = 10;
> +	int ret;
> +
> +	while (tries-- > 0) {
> +		ret = regmap_read(mma7455->regmap, MMA7455_REG_STATUS, &reg);
> +		if (ret)
> +			return ret;
> +
> +		if (reg & MMA7455_STATUS_DRDY)
> +			return 0;
> +
> +		msleep(20);
> +	}
> +
> +	dev_warn(mma7455->dev, "data not ready\n");
> +
> +	return -EIO;
> +}
> +
> +static irqreturn_t mma7455_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct mma7455_data *mma7455 = iio_priv(indio_dev);
> +	u8 buf[16]; /* 3 x 16-bit channels + padding + ts */
> +	int ret;
> +
> +	ret = mma7455_drdy(mma7455);
> +	if (ret)
> +		goto done;
> +
> +	ret = regmap_bulk_read(mma7455->regmap, MMA7455_REG_XOUTL, buf,
> +			       sizeof(s16) * 3);

use le16 to hint which endianness the device registers have

> +	if (ret)
> +		goto done;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, buf, iio_get_time_ns());
> +
> +done:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int mma7455_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct mma7455_data *mma7455 = iio_priv(indio_dev);
> +	unsigned int reg = 0;

initialization not needed

> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (iio_buffer_enabled(indio_dev))
> +			return -EBUSY;
> +
> +		ret = mma7455_drdy(mma7455);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_bulk_read(mma7455->regmap, chan->scan_index * 2,

it would be clearer to use chan->address instead of computing the register

instead of s16 I suggest to use le16

using regmap_bulk_read(), there is no endianness conversion; the driver 
will only work when chip endianness equals CPU endianness 

> +				       &reg, sizeof(s16));
> +		if (ret)
> +			return ret;
> +
> +		*val = sign_extend32(reg, 9);
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;
> +		*val2 = MMA7455_10BIT_SCALE;
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = regmap_read(mma7455->regmap, MMA7455_REG_CTL1, &reg);
> +		if (ret)
> +			return ret;
> +
> +		if (reg & MMA7455_CTL1_DFBW_MASK)
> +			*val = 250;
> +		else
> +			*val = 125;
> +
> +		return IIO_VAL_INT;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int mma7455_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct mma7455_data *mma7455 = iio_priv(indio_dev);
> +	int i;
> +
> +	if (iio_buffer_enabled(indio_dev))
> +		return -EBUSY;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:

check val2 == 0

> +		if (val == 250)
> +			i = MMA7455_CTL1_DFBW_125HZ;
> +		else if (val == 125)
> +			i = MMA7455_CTL1_DFBW_62_5HZ;
> +		else
> +			return -EINVAL;
> +
> +		return regmap_update_bits(mma7455->regmap, MMA7455_REG_CTL1,
> +					  MMA7455_CTL1_DFBW_MASK, i);
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		/* In 10-bit mode there is only one scale available */
> +		if (val == 0 && val2 == MMA7455_10BIT_SCALE)
> +			return 0;
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static ssize_t mma7455_show_samp_freq_avail(struct device *dev,
> +					    struct device_attribute *attr,
> +					    char *buf)
> +{
> +	return scnprintf(buf, PAGE_SIZE, "125 250\n");
> +}
> +
> +static ssize_t mma7455_show_scale_avail(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	return scnprintf(buf, PAGE_SIZE, "0.%u\n", MMA7455_10BIT_SCALE);
> +}
> +
> +static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(mma7455_show_samp_freq_avail);
> +static IIO_DEVICE_ATTR(in_accel_scale_available, S_IRUGO,
> +		       mma7455_show_scale_avail, NULL, 0);
> +
> +static struct attribute *mma7455_attributes[] = {
> +	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> +	&iio_dev_attr_in_accel_scale_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group mma7455_group = {
> +	.attrs = mma7455_attributes,
> +};
> +
> +static const struct iio_info mma7455_info = {
> +	.attrs = &mma7455_group,
> +	.read_raw = mma7455_read_raw,
> +	.write_raw = mma7455_write_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +#define MMA7455_CHANNEL(axis, idx) { \
> +	.type = IIO_ACCEL, \
> +	.modified = 1, \
> +	.channel2 = IIO_MOD_##axis, \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
> +				    BIT(IIO_CHAN_INFO_SCALE), \
> +	.scan_index = idx, \
> +	.scan_type = { \
> +		.sign = 's', \
> +		.realbits = 10, \
> +		.storagebits = 16, \
> +		.shift = 0, \
> +		.endianness = IIO_LE, \
> +	}, \
> +}
> +
> +static const struct iio_chan_spec mma7455_channels[] = {
> +	MMA7455_CHANNEL(X, 0),
> +	MMA7455_CHANNEL(Y, 1),
> +	MMA7455_CHANNEL(Z, 2),
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
> +};
> +
> +static const unsigned long mma7455_scan_masks[] = {0x7, 0};
> +
> +static int mma7455_probe(struct device *dev, struct regmap *regmap)
> +{
> +	struct mma7455_data *mma7455;
> +	struct iio_dev *indio_dev;
> +	unsigned int reg;
> +	int ret;
> +
> +	ret = regmap_read(regmap, MMA7455_REG_WHOAMI, &reg);
> +	if (ret) {
> +		dev_err(dev, "unable to read reg\n");
> +		return ret;
> +	}
> +
> +	if (reg != MMA7455_WHOAMI_ID) {
> +		dev_err(dev, "device id mismatch\n");
> +		return -ENODEV;
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*mma7455));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, indio_dev);
> +	mma7455 = iio_priv(indio_dev);
> +	mma7455->regmap = regmap;
> +	mma7455->dev = dev;
> +
> +	indio_dev->info = &mma7455_info;
> +	indio_dev->name = "mma7455l";
> +	indio_dev->dev.parent = dev;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = mma7455_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(mma7455_channels);
> +	indio_dev->available_scan_masks = mma7455_scan_masks;
> +
> +	regmap_write(mma7455->regmap, MMA7455_REG_MCTL,
> +		     MMA7455_MCTL_MODE_MEASURE);
> +
> +	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> +					 mma7455_trigger_handler, NULL);
> +	if (ret) {
> +		dev_err(dev, "unable to setup triggered buffer\n");
> +		return ret;
> +	}
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret) {
> +		dev_err(dev, "unable to register device\n");
> +		iio_triggered_buffer_cleanup(indio_dev);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mma7455_remove(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct mma7455_data *mma7455 = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +	iio_triggered_buffer_cleanup(indio_dev);
> +
> +	regmap_write(mma7455->regmap, MMA7455_REG_MCTL,
> +		     MMA7455_MCTL_MODE_STANDBY);
> +
> +	return 0;
> +}
> +
> +static const struct regmap_config mma7455_regmap = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = MMA7455_REG_TW,
> +};
> +
> +#if IS_ENABLED(CONFIG_SPI_MASTER)
> +static int mma7455_spi_probe(struct spi_device *spi)
> +{
> +	struct regmap *regmap;
> +
> +	regmap = devm_regmap_init_spi(spi, &mma7455_regmap);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	return mma7455_probe(&spi->dev, regmap);
> +}
> +
> +static int mma7455_spi_remove(struct spi_device *spi)
> +{
> +	return mma7455_remove(&spi->dev);
> +}
> +
> +static const struct spi_device_id mma7455_spi_id[] = {
> +	{ "mma7455", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, mma7455_spi_id);
> +
> +static struct spi_driver mma7455_spi_driver = {
> +	.probe = mma7455_spi_probe,
> +	.remove = mma7455_spi_remove,
> +	.id_table = mma7455_spi_id,
> +	.driver = {
> +		.name = "mma7455-spi",
> +	},
> +};
> +#endif
> +
> +#if IS_ENABLED(CONFIG_I2C)
> +static int mma7455_i2c_probe(struct i2c_client *i2c,
> +			     const struct i2c_device_id *id)
> +{
> +	struct regmap *regmap;
> +
> +	regmap = devm_regmap_init_i2c(i2c, &mma7455_regmap);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	return mma7455_probe(&i2c->dev, regmap);
> +}
> +
> +static int mma7455_i2c_remove(struct i2c_client *i2c)
> +{
> +	return mma7455_remove(&i2c->dev);
> +}
> +
> +static const struct i2c_device_id mma7455_i2c_id[] = {
> +	{ "mma7455", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, mma7455_i2c_id);
> +
> +static struct i2c_driver mma7455_i2c_driver = {
> +	.probe = mma7455_i2c_probe,
> +	.remove = mma7455_i2c_remove,
> +	.id_table = mma7455_i2c_id,
> +	.driver = {
> +		.name	= "mma7455-i2c",
> +	},
> +};
> +#endif
> +
> +static int __init mma7455_modinit(void)
> +{
> +	int ret;
> +#if IS_ENABLED(CONFIG_I2C)
> +	ret = i2c_add_driver(&mma7455_i2c_driver);
> +	if (ret)
> +		pr_err("failed to register MMA7455L I2C driver: %d\n", ret);
> +#endif
> +#if IS_ENABLED(CONFIG_SPI_MASTER)
> +	ret = spi_register_driver(&mma7455_spi_driver);
> +	if (ret)
> +		pr_err("failed to register MMA7455L SPI driver: %d\n", ret);
> +#endif
> +	return ret;
> +}
> +module_init(mma7455_modinit);
> +
> +static void __exit mma7455_exit(void)
> +{
> +#if IS_ENABLED(CONFIG_I2C)
> +	i2c_del_driver(&mma7455_i2c_driver);
> +#endif
> +#if IS_ENABLED(CONFIG_SPI_MASTER)
> +	spi_unregister_driver(&mma7455_spi_driver);
> +#endif
> +}
> +module_exit(mma7455_exit);
> +
> +MODULE_AUTHOR("Joachim Eastwood <manabian@gmail.com>");
> +MODULE_DESCRIPTION("Freescale MMA7455L I2C/SPI accelerometer driver");
> +MODULE_LICENSE("GPL v2");
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
