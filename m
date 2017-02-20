Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36615 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751041AbdBTGmQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Feb 2017 01:42:16 -0500
Date: Mon, 20 Feb 2017 14:41:13 +0800
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, dmitry.torokhov@gmail.com,
        michael.hennerich@analog.com, daniel.baluta@gmail.com,
        amsfield22@gmail.com, florian.vaussard@heig-vd.ch,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: accel: adxl345: Split driver into core and I2C
Message-ID: <20170220064112.GA4124@Socrates-UM>
References: <1487239327-21406-1-git-send-email-eraretuya@gmail.com>
 <1487239327-21406-3-git-send-email-eraretuya@gmail.com>
 <525c10a9-adda-9e5b-7f1c-f77abd6f7cb0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <525c10a9-adda-9e5b-7f1c-f77abd6f7cb0@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Feb 19, 2017 at 01:11:29PM +0000, Jonathan Cameron wrote:
> On 16/02/17 10:02, Eva Rachel Retuya wrote:
> > Move I2C-specific code into its own file and rely on regmap to access
> > registers. The core code provides access to x, y, z and scale readings.
> > 
> > Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
> A few minor comment inline.  This unwound the comment about client->dev
> in the previous patch, but I'd prefer to see it done there as then the
> changes in here will be easier to see (with move detection hopefully working!)
> 
> Jonathan
> > ---
> >  drivers/iio/accel/Kconfig        |   8 +-
> >  drivers/iio/accel/Makefile       |   3 +-
> >  drivers/iio/accel/adxl345.c      | 213 ---------------------------------------
> >  drivers/iio/accel/adxl345.h      |  18 ++++
> >  drivers/iio/accel/adxl345_core.c | 182 +++++++++++++++++++++++++++++++++
> >  drivers/iio/accel/adxl345_i2c.c  |  70 +++++++++++++
> This is a case where allowing git to notice the moves would have lead
> to easier to read patches (unless this was sufficiently complex that git
> couldn't follow it ;)

Hello Jonathan,

Thanks for the feedback. I amended the relevant commits as you say and
git detects the file adxl345.c -> adxl345_core.c as 78% renamed. The
reason for that percentage is that I did some probe/remove renames and
some other deletions here and there. Should I commit them separately in
order to get the move detection to work?

> >  6 files changed, 278 insertions(+), 216 deletions(-)
> >  delete mode 100644 drivers/iio/accel/adxl345.c
> >  create mode 100644 drivers/iio/accel/adxl345.h
> >  create mode 100644 drivers/iio/accel/adxl345_core.c
> >  create mode 100644 drivers/iio/accel/adxl345_i2c.c
> > 
> > diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> > index 26b8614..5bdd87f 100644
> > --- a/drivers/iio/accel/Kconfig
> > +++ b/drivers/iio/accel/Kconfig
> > @@ -6,16 +6,20 @@
> >  menu "Accelerometers"
> >  
> >  config ADXL345
> > -	tristate "Analog Devices ADXL345 3-Axis Digital Accelerometer Driver"
> > +	tristate
> > +
> > +config ADXL345_I2C
> > +	tristate "Analog Devices ADXL345 3-Axis Digital Accelerometer I2C Driver"
> >  	depends on !(INPUT_ADXL34X=y || INPUT_ADXL34X=m)
> >  	depends on I2C
> > +	select ADXL345
> >  	select REGMAP_I2C
> >  	help
> >  	  Say Y here if you want to build support for the Analog Devices
> >  	  ADXL345 3-axis digital accelerometer.
> >  
> >  	  To compile this driver as a module, choose M here: the
> > -	  module will be called adxl345.
> > +	  module will be called adxl345_i2c.
> There are a couple of ways to do this.  I personally kind of prefer the
> way the bmc150 does it as it gives a cleaner set of options in Kconfig.
> 
> Look at the various ways it is done and if you still prefer this one then
> fair enough (it's how we always used to do it ;)

Ack. I've seen it but went this way just to be explicit. I agree with doing
it cleaner and will reflect it on v2.

Eva

> >  
> >  config BMA180
> >  	tristate "Bosch BMA180/BMA250 3-Axis Accelerometer Driver"
> > diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> > index 618488d..3f4a6d6 100644
> > --- a/drivers/iio/accel/Makefile
> > +++ b/drivers/iio/accel/Makefile
> > @@ -3,7 +3,8 @@
> >  #
> >  
> >  # When adding new entries keep the list in alphabetical order
> > -obj-$(CONFIG_ADXL345) += adxl345.o
> > +obj-$(CONFIG_ADXL345) += adxl345_core.o
> > +obj-$(CONFIG_ADXL345_I2C) += adxl345_i2c.o
> >  obj-$(CONFIG_BMA180) += bma180.o
> >  obj-$(CONFIG_BMA220) += bma220_spi.o
> >  obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel-core.o
> > diff --git a/drivers/iio/accel/adxl345.c b/drivers/iio/accel/adxl345.c
> > deleted file mode 100644
> > index a1fdf60..0000000
> > --- a/drivers/iio/accel/adxl345.c
> > +++ /dev/null
> > @@ -1,213 +0,0 @@
> > -/*
> > - * ADXL345 3-Axis Digital Accelerometer
> > - *
> > - * Copyright (c) 2017 Eva Rachel Retuya <eraretuya@gmail.com>
> > - *
> > - * This file is subject to the terms and conditions of version 2 of
> > - * the GNU General Public License. See the file COPYING in the main
> > - * directory of this archive for more details.
> > - *
> > - * IIO driver for ADXL345
> > - * 7-bit I2C slave address: 0x1D (ALT ADDRESS pin tied to VDDIO) or
> > - * 0x53 (ALT ADDRESS pin grounded)
> > - */
> > -
> > -#include <linux/i2c.h>
> > -#include <linux/module.h>
> > -#include <linux/regmap.h>
> > -
> > -#include <linux/iio/iio.h>
> > -
> > -#define ADXL345_REG_DEVID		0x00
> > -#define ADXL345_REG_POWER_CTL		0x2D
> > -#define ADXL345_REG_DATA_FORMAT		0x31
> > -#define ADXL345_REG_DATAX0		0x32
> > -#define ADXL345_REG_DATAY0		0x34
> > -#define ADXL345_REG_DATAZ0		0x36
> > -
> > -#define ADXL345_POWER_CTL_MEASURE	BIT(3)
> > -#define ADXL345_POWER_CTL_STANDBY	0x00
> > -
> > -#define ADXL345_DATA_FORMAT_FULL_RES	BIT(3) /* Up to 13-bits resolution */
> > -#define ADXL345_DATA_FORMAT_2G		0
> > -#define ADXL345_DATA_FORMAT_4G		1
> > -#define ADXL345_DATA_FORMAT_8G		2
> > -#define ADXL345_DATA_FORMAT_16G		3
> > -
> > -#define ADXL345_DEVID			0xE5
> > -
> > -/*
> > - * In full-resolution mode, scale factor is maintained at ~4 mg/LSB
> > - * in all g ranges.
> > - *
> > - * At +/- 16g with 13-bit resolution, scale is computed as:
> > - * (16 + 16) * 9.81 / (2^13 - 1) = 0.0383
> > - */
> > -static const int adxl345_uscale = 38300;
> > -
> > -struct adxl345_data {
> > -	struct i2c_client *client;
> > -	struct regmap *regmap;
> > -	u8 data_range;
> > -};
> > -
> > -static const struct regmap_config adxl345_regmap_config = {
> > -	.reg_bits = 8,
> > -	.val_bits = 8,
> > -};
> > -
> > -#define ADXL345_CHANNEL(reg, axis) {					\
> > -	.type = IIO_ACCEL,						\
> > -	.modified = 1,							\
> > -	.channel2 = IIO_MOD_##axis,					\
> > -	.address = reg,							\
> > -	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
> > -	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
> > -}
> > -
> > -static const struct iio_chan_spec adxl345_channels[] = {
> > -	ADXL345_CHANNEL(ADXL345_REG_DATAX0, X),
> > -	ADXL345_CHANNEL(ADXL345_REG_DATAY0, Y),
> > -	ADXL345_CHANNEL(ADXL345_REG_DATAZ0, Z),
> > -};
> > -
> > -static int adxl345_read_raw(struct iio_dev *indio_dev,
> > -			    struct iio_chan_spec const *chan,
> > -			    int *val, int *val2, long mask)
> > -{
> > -	struct adxl345_data *data = iio_priv(indio_dev);
> > -	int ret;
> > -	__le16 regval;
> > -
> > -	switch (mask) {
> > -	case IIO_CHAN_INFO_RAW:
> > -		/*
> > -		 * Data is stored in adjacent registers:
> > -		 * ADXL345_REG_DATA(X0/Y0/Z0) contain the least significant byte
> > -		 * and ADXL345_REG_DATA(X0/Y0/Z0) + 1 the most significant byte
> > -		 */
> > -		ret = regmap_bulk_read(data->regmap, chan->address, &regval,
> > -				       sizeof(regval));
> > -		if (ret < 0)
> > -			return ret;
> > -
> > -		*val = sign_extend32(le16_to_cpu(regval), 12);
> > -		return IIO_VAL_INT;
> > -	case IIO_CHAN_INFO_SCALE:
> > -		*val = 0;
> > -		*val2 = adxl345_uscale;
> > -
> > -		return IIO_VAL_INT_PLUS_MICRO;
> > -	}
> > -
> > -	return -EINVAL;
> > -}
> > -
> > -static const struct iio_info adxl345_info = {
> > -	.driver_module	= THIS_MODULE,
> > -	.read_raw	= adxl345_read_raw,
> > -};
> > -
> > -static int adxl345_probe(struct i2c_client *client,
> > -			 const struct i2c_device_id *id)
> > -{
> > -	struct adxl345_data *data;
> > -	struct iio_dev *indio_dev;
> > -	struct regmap *regmap;
> > -	int ret;
> > -	u32 regval;
> > -
> > -	regmap = devm_regmap_init_i2c(client, &adxl345_regmap_config);
> > -	if (IS_ERR(regmap)) {
> > -		dev_err(&client->dev, "Error initializing regmap: %d\n",
> > -			(int)PTR_ERR(regmap));
> > -		return PTR_ERR(regmap);
> > -	}
> > -
> > -	ret = regmap_read(regmap, ADXL345_REG_DEVID, &regval);
> > -	if (ret < 0) {
> > -		dev_err(&client->dev, "Error reading device ID: %d\n", ret);
> > -		return ret;
> > -	}
> > -
> > -	if (regval != ADXL345_DEVID) {
> > -		dev_err(&client->dev, "Invalid device ID: %d\n", ret);
> > -		return -ENODEV;
> > -	}
> > -
> > -	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> > -	if (!indio_dev)
> > -		return -ENOMEM;
> > -
> > -	data = iio_priv(indio_dev);
> > -	i2c_set_clientdata(client, indio_dev);
> > -	data->client = client;
> > -	data->regmap = regmap;
> > -	/* Enable full-resolution mode */
> > -	data->data_range = ADXL345_DATA_FORMAT_FULL_RES;
> > -
> > -	ret = regmap_write(data->regmap, ADXL345_REG_DATA_FORMAT,
> > -			   data->data_range);
> > -	if (ret < 0) {
> > -		dev_err(&client->dev, "Failed to set data range: %d\n", ret);
> > -		return ret;
> > -	}
> > -
> > -	indio_dev->dev.parent = &client->dev;
> > -	indio_dev->name = id->name;
> > -	indio_dev->info = &adxl345_info;
> > -	indio_dev->modes = INDIO_DIRECT_MODE;
> > -	indio_dev->channels = adxl345_channels;
> > -	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
> > -
> > -	/* Enable measurement mode */
> > -	ret = regmap_write(data->regmap, ADXL345_REG_POWER_CTL,
> > -			   ADXL345_POWER_CTL_MEASURE);
> > -	if (ret < 0) {
> > -		dev_err(&client->dev, "Failed to enable measurement mode: %d\n",
> > -			ret);
> > -		return ret;
> > -	}
> > -
> > -	ret = iio_device_register(indio_dev);
> > -	if (ret < 0) {
> > -		dev_err(&client->dev, "iio_device_register failed: %d\n", ret);
> > -		regmap_write(data->regmap, ADXL345_REG_POWER_CTL,
> > -			     ADXL345_POWER_CTL_STANDBY);
> > -	}
> > -
> > -	return ret;
> > -}
> > -
> > -static int adxl345_remove(struct i2c_client *client)
> > -{
> > -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> > -	struct adxl345_data *data = iio_priv(indio_dev);
> > -
> > -	iio_device_unregister(indio_dev);
> > -
> > -	return regmap_write(data->regmap, ADXL345_REG_POWER_CTL,
> > -			    ADXL345_POWER_CTL_STANDBY);
> > -}
> > -
> > -static const struct i2c_device_id adxl345_i2c_id[] = {
> > -	{ "adxl345", 0 },
> > -	{ }
> > -};
> > -
> > -MODULE_DEVICE_TABLE(i2c, adxl345_i2c_id);
> > -
> > -static struct i2c_driver adxl345_driver = {
> > -	.driver = {
> > -		.name	= "adxl345",
> > -	},
> > -	.probe		= adxl345_probe,
> > -	.remove		= adxl345_remove,
> > -	.id_table	= adxl345_i2c_id,
> > -};
> > -
> > -module_i2c_driver(adxl345_driver);
> > -
> > -MODULE_AUTHOR("Eva Rachel Retuya <eraretuya@gmail.com>");
> > -MODULE_DESCRIPTION("ADXL345 3-Axis Digital Accelerometer driver");
> > -MODULE_LICENSE("GPL v2");
> > diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> > new file mode 100644
> > index 0000000..fca3e25
> > --- /dev/null
> > +++ b/drivers/iio/accel/adxl345.h
> > @@ -0,0 +1,18 @@
> > +/*
> > + * ADXL345 3-Axis Digital Accelerometer
> > + *
> > + * Copyright (c) 2017 Eva Rachel Retuya <eraretuya@gmail.com>
> > + *
> > + * This file is subject to the terms and conditions of version 2 of
> > + * the GNU General Public License. See the file COPYING in the main
> > + * directory of this archive for more details.
> > + */
> > +
> > +#ifndef _ADXL345_H_
> > +#define _ADXL345_H_
> > +
> > +int adxl345_common_probe(struct device *dev, struct regmap *regmap,
> > +			 const char *name);
> > +int adxl345_common_remove(struct device *dev);
> > +
> > +#endif /* _ADXL345_H_ */
> > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> > new file mode 100644
> > index 0000000..ce09804
> > --- /dev/null
> > +++ b/drivers/iio/accel/adxl345_core.c
> > @@ -0,0 +1,182 @@
> > +/*
> > + * ADXL345 3-Axis Digital Accelerometer
> > + *
> > + * Copyright (c) 2017 Eva Rachel Retuya <eraretuya@gmail.com>
> > + *
> > + * This file is subject to the terms and conditions of version 2 of
> > + * the GNU General Public License. See the file COPYING in the main
> > + * directory of this archive for more details.
> > + *
> > + * IIO core driver for ADXL345
> > + */
> > +
> > +#include <linux/i2c.h>
> > +#include <linux/module.h>
> > +#include <linux/regmap.h>
> > +
> > +#include <linux/iio/iio.h>
> > +
> > +#include "adxl345.h"
> > +
> > +#define ADXL345_REG_DEVID		0x00
> > +#define ADXL345_REG_POWER_CTL		0x2D
> > +#define ADXL345_REG_DATA_FORMAT		0x31
> > +#define ADXL345_REG_DATAX0		0x32
> > +#define ADXL345_REG_DATAY0		0x34
> > +#define ADXL345_REG_DATAZ0		0x36
> > +
> > +#define ADXL345_POWER_CTL_MEASURE	BIT(3)
> > +#define ADXL345_POWER_CTL_STANDBY	0x00
> > +
> > +#define ADXL345_DATA_FORMAT_FULL_RES	BIT(3) /* Up to 13-bits resolution */
> > +#define ADXL345_DATA_FORMAT_2G		0
> > +#define ADXL345_DATA_FORMAT_4G		1
> > +#define ADXL345_DATA_FORMAT_8G		2
> > +#define ADXL345_DATA_FORMAT_16G		3
> > +
> > +#define ADXL345_DEVID			0xE5
> > +
> > +/*
> > + * In full-resolution mode, scale factor is maintained at ~4 mg/LSB
> > + * in all g ranges.
> > + *
> > + * At +/- 16g with 13-bit resolution, scale is computed as:
> > + * (16 + 16) * 9.81 / (2^13 - 1) = 0.0383
> > + */
> > +static const int adxl345_uscale = 38300;
> > +
> > +struct adxl345_data {
> > +	struct regmap *regmap;
> > +	u8 data_range;
> > +};
> > +
> > +#define ADXL345_CHANNEL(reg, axis) {					\
> > +	.type = IIO_ACCEL,						\
> > +	.modified = 1,							\
> > +	.channel2 = IIO_MOD_##axis,					\
> > +	.address = reg,							\
> > +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
> > +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
> > +}
> > +
> > +static const struct iio_chan_spec adxl345_channels[] = {
> > +	ADXL345_CHANNEL(ADXL345_REG_DATAX0, X),
> > +	ADXL345_CHANNEL(ADXL345_REG_DATAY0, Y),
> > +	ADXL345_CHANNEL(ADXL345_REG_DATAZ0, Z),
> > +};
> > +
> > +static int adxl345_read_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan,
> > +			    int *val, int *val2, long mask)
> > +{
> > +	struct adxl345_data *data = iio_priv(indio_dev);
> > +	int ret;
> > +	__le16 regval;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		/*
> > +		 * Data is stored in adjacent registers:
> > +		 * ADXL345_REG_DATA(X0/Y0/Z0) contain the least significant byte
> > +		 * and ADXL345_REG_DATA(X0/Y0/Z0) + 1 the most significant byte
> > +		 */
> > +		ret = regmap_bulk_read(data->regmap, chan->address, &regval,
> > +				       sizeof(regval));
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		*val = sign_extend32(le16_to_cpu(regval), 12);
> > +		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_SCALE:
> > +		*val = 0;
> > +		*val2 = adxl345_uscale;
> > +
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static const struct iio_info adxl345_info = {
> > +	.driver_module	= THIS_MODULE,
> > +	.read_raw	= adxl345_read_raw,
> > +};
> > +
> > +int adxl345_common_probe(struct device *dev, struct regmap *regmap,
> > +			 const char *name)
> > +{
> > +	struct adxl345_data *data;
> > +	struct iio_dev *indio_dev;
> > +	int ret;
> > +	u32 regval;
> > +
> > +	ret = regmap_read(regmap, ADXL345_REG_DEVID, &regval);
> > +	if (ret < 0) {
> > +		dev_err(dev, "Error reading device ID: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	if (regval != ADXL345_DEVID) {
> > +		dev_err(dev, "Invalid device ID: %d\n", ret);
> > +		return -ENODEV;
> > +	}
> > +
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	data = iio_priv(indio_dev);
> > +	dev_set_drvdata(dev, indio_dev);
> > +	data->regmap = regmap;
> > +	/* Enable full-resolution mode */
> > +	data->data_range = ADXL345_DATA_FORMAT_FULL_RES;
> > +
> > +	ret = regmap_write(data->regmap, ADXL345_REG_DATA_FORMAT,
> > +			   data->data_range);
> > +	if (ret < 0) {
> > +		dev_err(dev, "Failed to set data range: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	indio_dev->dev.parent = dev;
> > +	indio_dev->name = name;
> > +	indio_dev->info = &adxl345_info;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->channels = adxl345_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
> > +
> > +	/* Enable measurement mode */
> > +	ret = regmap_write(data->regmap, ADXL345_REG_POWER_CTL,
> > +			   ADXL345_POWER_CTL_MEASURE);
> > +	if (ret < 0) {
> > +		dev_err(dev, "Failed to enable measurement mode: %d\n",
> > +			ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = iio_device_register(indio_dev);
> > +	if (ret < 0) {
> > +		dev_err(dev, "iio_device_register failed: %d\n", ret);
> > +		regmap_write(data->regmap, ADXL345_REG_POWER_CTL,
> > +			     ADXL345_POWER_CTL_STANDBY);
> > +	}
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(adxl345_common_probe);
> > +
> > +int adxl345_common_remove(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > +	struct adxl345_data *data = iio_priv(indio_dev);
> > +
> > +	iio_device_unregister(indio_dev);
> > +
> > +	return regmap_write(data->regmap, ADXL345_REG_POWER_CTL,
> > +			    ADXL345_POWER_CTL_STANDBY);
> > +}
> > +EXPORT_SYMBOL_GPL(adxl345_common_remove);
> > +
> > +MODULE_AUTHOR("Eva Rachel Retuya <eraretuya@gmail.com>");
> > +MODULE_DESCRIPTION("ADXL345 3-Axis Digital Accelerometer core driver");
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
> > new file mode 100644
> > index 0000000..b114eb0
> > --- /dev/null
> > +++ b/drivers/iio/accel/adxl345_i2c.c
> > @@ -0,0 +1,70 @@
> > +/*
> > + * ADXL345 3-Axis Digital Accelerometer
> > + *
> > + * Copyright (c) 2017 Eva Rachel Retuya <eraretuya@gmail.com>
> > + *
> > + * This file is subject to the terms and conditions of version 2 of
> > + * the GNU General Public License. See the file COPYING in the main
> > + * directory of this archive for more details.
> > + *
> > + * I2C driver for ADXL345
> > + * 7-bit I2C slave address: 0x1D (ALT ADDRESS pin tied to VDDIO) or
> > + * 0x53 (ALT ADDRESS pin grounded)
> > + */
> > +
> > +#include <linux/i2c.h>
> > +#include <linux/module.h>
> > +#include <linux/regmap.h>
> > +
> > +#include "adxl345.h"
> > +
> > +static const struct regmap_config adxl345_i2c_regmap_config = {
> > +	.reg_bits = 8,
> > +	.val_bits = 8,
> > +};
> > +
> > +static int adxl345_i2c_probe(struct i2c_client *client,
> > +			     const struct i2c_device_id *id)
> > +{
> > +	struct regmap *regmap;
> > +	const char *name = NULL;
> > +
> > +	regmap = devm_regmap_init_i2c(client, &adxl345_i2c_regmap_config);
> > +	if (IS_ERR(regmap)) {
> > +		dev_err(&client->dev, "Error initializing i2c regmap: %d\n",
> > +			(int)PTR_ERR(regmap));
> Ok, so the client->dev stuff effectively gets unwound here anyway.
> End result is good, but nice to do it cleanly in the first patch as
> then the apparent changes (if move detection works) in here will be more
> minor.
> > +		return PTR_ERR(regmap);
> > +	}
> > +
> > +	if (id)
> > +		name = id->name;
> > +
> > +	return adxl345_common_probe(&client->dev, regmap, name);
> > +}
> > +
> > +static int adxl345_i2c_remove(struct i2c_client *client)
> > +{
> > +	return adxl345_common_remove(&client->dev);
> > +}
> > +
> > +static const struct i2c_device_id adxl345_i2c_id[] = {
> > +	{ "adxl345", 0 },
> > +	{ }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(i2c, adxl345_i2c_id);
> > +
> > +static struct i2c_driver adxl345_i2c_driver = {
> > +	.driver = {
> > +		.name	= "adxl345_i2c",
> > +	},
> > +	.probe		= adxl345_i2c_probe,
> > +	.remove		= adxl345_i2c_remove,
> > +	.id_table	= adxl345_i2c_id,
> > +};
> > +
> > +module_i2c_driver(adxl345_i2c_driver);
> > +
> > +MODULE_AUTHOR("Eva Rachel Retuya <eraretuya@gmail.com>");
> > +MODULE_DESCRIPTION("ADXL345 3-Axis Digital Accelerometer I2C driver");
> > +MODULE_LICENSE("GPL v2");
> > 
> 
