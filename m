Return-Path: <SRS0=Qdne=JH=huawei.com=jonathan.cameron@kernel.org>
Date: Thu, 21 Jun 2018 14:23:26 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Himanshu Jha <himanshujha199640@gmail.com>
CC: <jic23@kernel.org>, <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
	<pmeerw@pmeerw.net>, <daniel.baluta@gmail.com>
Subject: Re: [RFC 1/3] iio: imu: bme680: Add initial support for Bosch
 BME680
Message-ID: <20180621142326.00002c9f@huawei.com>
In-Reply-To: <1529562877-9357-2-git-send-email-himanshujha199640@gmail.com>
References: <1529562877-9357-1-git-send-email-himanshujha199640@gmail.com>
	<1529562877-9357-2-git-send-email-himanshujha199640@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-ID: <linux-iio@vger.kernel.org>

On Thu, 21 Jun 2018 12:04:35 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Implement a minimal probe function to register the device to the
> kernel. The probe does a simple power on reset and then checks for
> chip id.
> 
> Datasheet:
> https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BME680-DS001-00.pdf
> 
> Cc: Daniel Baluta <daniel.baluta@gmail.com>
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>

Looks very nice.  I put a few minor comments inline, but all in the
'nice' to have category.

I'm traveling this week so will get to the other patches and your
general questions but might not be terribly quick about it!

Jonathan

> ---
>  drivers/iio/imu/Kconfig              |   1 +
>  drivers/iio/imu/Makefile             |   1 +
>  drivers/iio/imu/bme680/Kconfig       |  32 +++++++++++
>  drivers/iio/imu/bme680/Makefile      |   6 +++
>  drivers/iio/imu/bme680/bme680.h      |  11 ++++
>  drivers/iio/imu/bme680/bme680_core.c | 101
> +++++++++++++++++++++++++++++++++++
> drivers/iio/imu/bme680/bme680_i2c.c  |  56 +++++++++++++++++++
> drivers/iio/imu/bme680/bme680_spi.c  |  49 +++++++++++++++++ 8 files
> changed, 257 insertions(+) create mode 100644
> drivers/iio/imu/bme680/Kconfig create mode 100644
> drivers/iio/imu/bme680/Makefile create mode 100644
> drivers/iio/imu/bme680/bme680.h create mode 100644
> drivers/iio/imu/bme680/bme680_core.c create mode 100644
> drivers/iio/imu/bme680/bme680_i2c.c create mode 100644
> drivers/iio/imu/bme680/bme680_spi.c
> 
> diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
> index 156630a..cb7d2c0 100644
> --- a/drivers/iio/imu/Kconfig
> +++ b/drivers/iio/imu/Kconfig
> @@ -26,6 +26,7 @@ config ADIS16480
>  	  ADIS16485, ADIS16488 inertial sensors.
>  
>  source "drivers/iio/imu/bmi160/Kconfig"
> +source "drivers/iio/imu/bme680/Kconfig"
>  
>  config KMX61
>  	tristate "Kionix KMX61 6-axis accelerometer and magnetometer"
> diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
> index 68629c68..6c8c937 100644
> --- a/drivers/iio/imu/Makefile
> +++ b/drivers/iio/imu/Makefile
> @@ -15,6 +15,7 @@ adis_lib-$(CONFIG_IIO_ADIS_LIB_BUFFER) +=
> adis_buffer.o obj-$(CONFIG_IIO_ADIS_LIB) += adis_lib.o
>  
>  obj-y += bmi160/
> +obj-y += bme680/
>  obj-y += inv_mpu6050/
>  
>  obj-$(CONFIG_KMX61) += kmx61.o
> diff --git a/drivers/iio/imu/bme680/Kconfig
> b/drivers/iio/imu/bme680/Kconfig new file mode 100644
> index 0000000..71c392b
> --- /dev/null
> +++ b/drivers/iio/imu/bme680/Kconfig
> @@ -0,0 +1,32 @@
> +#
> +# Bosch BME680 Driver
> +#
> +
> +config BME680
> +	tristate
> +	select IIO_BUFFER
> +
> +config BME680_I2C
> +	tristate "Bosch BME680 I2C Driver"
> +	depends on I2C

Hmm. We started moving a while above to simplifying the various config
options by just building in spi or i2c whenever the requirements were
met.  As you can see here the cost is very low and there are definite
benefits to having only one visible config option rather than 2.

> +	select BME680
> +	select REGMAP_I2C
> +	help
> +	  If you say yes here you get support for BME680 on I2C with
> +	  temperature, pressure, humidity & gas sensing.
> +
> +	  This driver can also be built as a module. If so, the
> module will be
> +	  called bme68_i2c.
> +
> +config BME680_SPI
> +	tristate "Bosch BME680 SPI Driver"
> +	depends on SPI
> +	select BME680
> +	select REGMAP_SPI
> +	help
> +	  If you say yes here you get support for BME680 on SPI with
> +	  temperature, pressure, humidity & gas sensing.
> +
> +	  This driver can also be built as a module. If so, the
> module will be
> +	  called bme68_spi.
> +
> diff --git a/drivers/iio/imu/bme680/Makefile
> b/drivers/iio/imu/bme680/Makefile new file mode 100644
> index 0000000..562a708
> --- /dev/null
> +++ b/drivers/iio/imu/bme680/Makefile
> @@ -0,0 +1,6 @@
> +#
> +# Makefile for Bosch BME680
> +#
> +obj-$(CONFIG_BME680) += bme680_core.o
> +obj-$(CONFIG_BME680_I2C) += bme680_i2c.o
> +obj-$(CONFIG_BME680_SPI) += bme680_spi.o
> diff --git a/drivers/iio/imu/bme680/bme680.h
> b/drivers/iio/imu/bme680/bme680.h new file mode 100644
> index 0000000..9ee0cf5
> --- /dev/null
> +++ b/drivers/iio/imu/bme680/bme680.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

I think the convention everyone is settling on is c++ style comment
for SPDX...  Could be wrong though ;)

> +#ifndef BME680_H_
> +#define BME680_H_
> +
> +extern const struct regmap_config bme680_regmap_config;
> +
> +int bme680_core_probe(struct device *dev, struct regmap *regmap,
> +		      const char *name, bool use_spi);
> +void bme680_core_remove(struct device *dev);
> +
> +#endif  /* BME680_H_ */
> diff --git a/drivers/iio/imu/bme680/bme680_core.c
> b/drivers/iio/imu/bme680/bme680_core.c new file mode 100644
> index 0000000..a6d013d
> --- /dev/null
> +++ b/drivers/iio/imu/bme680/bme680_core.c
> @@ -0,0 +1,101 @@
> +/*
> + * Bosch BME680 - Temperature, Pressure, Humidity & Gas Sensor
> + *
> + * IIO core driver - I2C & SPI bus support
> + */
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +#define BME680_REG_CHIP_I2C_ID	0xD0
> +#define BME680_REG_CHIP_SPI_ID	0x50
> +#define BME680_CHIP_ID_VAL	0x61
> +#define BME680_SOFT_RESET	0xE0
So is this one an address?  Make sure the naming is consistent.

A nice trick from readability point of view is to use different
formatting for the values and fields within a register.  A good choice
is to put a few more spaces after the #define. e.g.

#define BOB_REG        0x1
#define   BOB_FIELD_1  BIT(30)

etc
> +#define BME680_CMD_SOFTRESET	0xB6
> +
> +struct bme680_data {
> +	struct regmap *regmap;
> +};
> +
> +const struct regmap_config bme680_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +};
> +EXPORT_SYMBOL(bme680_regmap_config);
> +
> +static const struct iio_info bme680_info = {

I'll assume this does something useful later, but as below, a comment
to that effect here would be nice from a lazy reviewer point of view.
You then drop the comment in the patch that adds something here.

> +};
> +
> +static int bme680_chip_init(struct bme680_data *data, bool use_spi)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	unsigned int val;
> +	int ret;
> +
> +	/* Power on Soft Reset */
> +	ret = regmap_write(data->regmap, BME680_SOFT_RESET, BME680_CMD_SOFTRESET);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!use_spi) {
> +		ret = regmap_read(data->regmap, BME680_REG_CHIP_I2C_ID, &val);
> +	} else {
> +		ret = regmap_read(data->regmap, BME680_REG_CHIP_SPI_ID, &val);
> +	}

Brackets never needed around a single statement.

It's a bit of a pain that you need to have different code paths in here
for i2c and spi.  Those should really only exist in the individual
drivers.    It is a bit heavy weight but I'd like to see this done
with a callback that is provided to the core probe function.

> +
> +	if (ret < 0) {
> +		dev_err(dev, "Error reading chip ID\n");
> +		return ret;
> +	}
> +
> +	if (val != BME680_CHIP_ID_VAL) {
> +		dev_err(dev, "Wrong chip ID, got %x expected %x\n",
> +				val, BME680_CHIP_ID_VAL);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +int bme680_core_probe(struct device *dev, struct regmap *regmap,
> +		      const char *name, bool use_spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct bme680_data *data;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	dev_set_drvdata(dev, indio_dev);
> +	data->regmap = regmap;
> +
> +	ret = bme680_chip_init(data, use_spi);
> +	if (ret < 0)
> +		return ret;
> +
> +	indio_dev->dev.parent = dev;
> +	indio_dev->name = name;

I think name can end up set to NULL at the moment.  That isn't a good
idea (though I may have missed something)

> +	indio_dev->info = &bme680_info;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0)
> +		return ret;
> +	return 0;

return iio_device_register(indio_dev);

It will never return a positive so no need to worry about that case.

> +}
> +EXPORT_SYMBOL_GPL(bme680_core_probe);
> +
> +void bme680_core_remove(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct bme680_data *data = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);

I'll assume that it becomes necessary later to not do this with the
managed interfaces.  A nice little thing to do in this sort of case
is put a comment in that is remove in the patch that follows and 
causes this requirement.

> +}
> +EXPORT_SYMBOL_GPL(bme680_core_remove);
> +
> +MODULE_AUTHOR("Himanshu Jha <himanshujha199640@gmail.com>");
> +MODULE_DESCRIPTION("Bosch BME680 Driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/imu/bme680/bme680_i2c.c
> b/drivers/iio/imu/bme680/bme680_i2c.c new file mode 100644
> index 0000000..1c8223e
> --- /dev/null
> +++ b/drivers/iio/imu/bme680/bme680_i2c.c
> @@ -0,0 +1,56 @@
> +/*

SPDX license headers needed for all files.

> + * 7-Bit I2C slave address is:
> + *	- 0x76 if SDO is pulled to GND
> + *	- 0x77 if SDO is pulled to VDDIO
> + */
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +#include "bme680.h"
> +
> +static int bme680_i2c_probe(struct i2c_client *client,
> +			    const struct i2c_device_id *id)
> +{
> +	struct regmap *regmap;
> +	const char *name = NULL;
> +
> +	regmap = devm_regmap_init_i2c(client, &bme680_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "Failed to register i2c regmap
> %d\n",
> +				(int)PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +
> +	if (id)
> +		name = id->name;
> +
> +	return bme680_core_probe(&client->dev, regmap, name, false);
> +}
> +
> +static int bme680_i2c_remove(struct i2c_client *client)
> +{
> +	bme680_core_remove(&client->dev);

You could potentially use the devm_add_action inside the
bme680_core_probe to add the remove action to be called on device
removal.  It's basically a one time use devm_* registration function.

That would get rid of the need to explicitly carry remove
functions for both spi and i2c.

https://elixir.bootlin.com/linux/latest/source/drivers/base/devres.c#L710

It is something I only came across myself a few months back so not one
that actually gets used that much 'yet'

> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id bme680_i2c_id[] = {
> +	{"bme680", 0},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, bme680_i2c_id);
> +
> +static struct i2c_driver bme680_i2c_driver = {
> +	.driver = {
> +		.name = "bme680_i2c",
> +	},
> +	.probe = bme680_i2c_probe,
> +	.remove = bme680_i2c_remove,
> +	.id_table = bme680_i2c_id,
> +};
> +module_i2c_driver(bme680_i2c_driver);
> +
> +MODULE_AUTHOR("Himanshu Jha <himanshujha199640@gmail.com>");
> +MODULE_DESCRIPTION("BME680 I2C driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/imu/bme680/bme680_spi.c
> b/drivers/iio/imu/bme680/bme680_spi.c new file mode 100644
> index 0000000..c135924
> --- /dev/null
> +++ b/drivers/iio/imu/bme680/bme680_spi.c
> @@ -0,0 +1,49 @@
> +/*

Needs a license spec //SPDX preferred.

Also, this is a one line comment, even thought it is the top of the
file, please use the standard one line comment syntax.

> + * BME680 - SPI Driver
> + */
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +#include <linux/regmap.h>
> +
> +#include "bme680.h"
> +
> +static int bme680_spi_probe(struct spi_device *spi)
> +{
> +	struct regmap *regmap;
> +	const struct spi_device_id *id = spi_get_device_id(spi);
> +
> +	regmap = devm_regmap_init_spi(spi, &bme680_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&spi->dev, "Failed to register spi regmap
> %d\n",
> +				(int)PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +	return bme680_core_probe(&spi->dev, regmap, id->name, true);
> +}
> +
> +static int bme680_spi_remove(struct spi_device *spi)
> +{
> +	bme680_core_remove(&spi->dev);
> +
> +	return 0;
> +}
> +
> +static const struct spi_device_id bme680_spi_id[] = {
> +	{"bme680", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, bme680_spi_id);
> +
> +static struct spi_driver bme680_spi_driver = {
> +	.driver = {
> +		.name = "bme680_spi",
> +	},
> +	.probe = bme680_spi_probe,
> +	.remove = bme680_spi_remove,
> +	.id_table = bme680_spi_id,
> +};
> +module_spi_driver(bme680_spi_driver);
> +
> +MODULE_AUTHOR("Himanshu Jha <himanshujha199640@gmail.com>");
> +MODULE_DESCRIPTION("Bosch BME680 SPI driver");
> +MODULE_LICENSE("GPL v2");
