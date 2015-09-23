Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59960 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753922AbbIWMvy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 23 Sep 2015 08:51:54 -0400
From: "Tirdea, Irina" <irina.tirdea@intel.com>
To: Markus Pargmann <mpa@pengutronix.de>,
	Jonathan Cameron <jic23@kernel.org>
CC: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Lars-Peter Clausen" <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v3 3/4] iio: bmc150: Split the driver into core and i2c
Date: Wed, 23 Sep 2015 12:51:50 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F0E793F@irsmsx105.ger.corp.intel.com>
References: <1442832916-30774-1-git-send-email-mpa@pengutronix.de>
 <1442832916-30774-4-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1442832916-30774-4-git-send-email-mpa@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Markus Pargmann [mailto:mpa@pengutronix.de]
> Sent: 21 September, 2015 13:55
> To: Jonathan Cameron
> Cc: Srinivas Pandruvada; Tirdea, Irina; Lars-Peter Clausen; linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org;
> kernel@pengutronix.de; Markus Pargmann
> Subject: [PATCH v3 3/4] iio: bmc150: Split the driver into core and i2c
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

Tested-by: Irina Tirdea <irina.tirdea@intel.com>

> ---
>  drivers/iio/accel/Kconfig                          |   9 +-
>  drivers/iio/accel/Makefile                         |   3 +-
>  .../accel/{bmc150-accel.c => bmc150-accel-core.c}  |  85 ++++-------------
>  drivers/iio/accel/bmc150-accel-i2c.c               | 102 +++++++++++++++++++++
>  drivers/iio/accel/bmc150-accel.h                   |  20 ++++
>  5 files changed, 145 insertions(+), 74 deletions(-)
>  rename drivers/iio/accel/{bmc150-accel.c => bmc150-accel-core.c} (96%)
>  create mode 100644 drivers/iio/accel/bmc150-accel-i2c.c
>  create mode 100644 drivers/iio/accel/bmc150-accel.h
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 3ff2c83f7492..280635545240 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -19,21 +19,22 @@ config BMA180
> 
>  config BMC150_ACCEL
>  	tristate "Bosch BMC150 Accelerometer Driver"
> -	depends on I2C
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	select REGMAP
> -	select REGMAP_I2C
> +	select BMC150_ACCEL_I2C if I2C
>  	help
>  	  Say yes here to build support for the following Bosch accelerometers:
>  	  BMC150, BMI055, BMA250E, BMA222E, BMA255, BMA280.
> 
> -	  Currently this only supports the device via an i2c interface.
> -
>  	  This is a combo module with both accelerometer and magnetometer.
>  	  This driver is only implementing accelerometer part, which has
>  	  its own address and register map.
> 
> +config BMC150_ACCEL_I2C
> +	tristate
> +	select REGMAP_I2C
> +
>  config HID_SENSOR_ACCEL_3D
>  	depends on HID_SENSOR_HUB
>  	select IIO_BUFFER
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index ebd2675b2a02..5ef8bdbad092 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -4,7 +4,8 @@
> 
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_BMA180) += bma180.o
> -obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel.o
> +obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel-core.o
> +obj-$(CONFIG_BMC150_ACCEL_I2C) += bmc150-accel-i2c.o
>  obj-$(CONFIG_HID_SENSOR_ACCEL_3D) += hid-sensor-accel-3d.o
>  obj-$(CONFIG_KXCJK1013) += kxcjk-1013.o
>  obj-$(CONFIG_KXSD9)	+= kxsd9.o
> diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel-core.c
> similarity index 96%
> rename from drivers/iio/accel/bmc150-accel.c
> rename to drivers/iio/accel/bmc150-accel-core.c
> index 425885dc6800..f492d2a4bce5 100644
> --- a/drivers/iio/accel/bmc150-accel.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -37,6 +37,8 @@
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/regmap.h>
> 
> +#include "bmc150-accel.h"
> +
>  #define BMC150_ACCEL_DRV_NAME			"bmc150_accel"
>  #define BMC150_ACCEL_IRQ_NAME			"bmc150_accel_event"
>  #define BMC150_ACCEL_GPIO_NAME			"bmc150_accel_int"
> @@ -1015,15 +1017,6 @@ static const struct iio_chan_spec bmc150_accel_channels[] =
>  static const struct iio_chan_spec bma280_accel_channels[] =
>  	BMC150_ACCEL_CHANNELS(14);
> 
> -enum {
> -	bmc150,
> -	bmi055,
> -	bma255,
> -	bma250e,
> -	bma222e,
> -	bma280,
> -};
> -
>  static const struct bmc150_accel_chip_info bmc150_accel_chip_info_tbl[] = {
>  	[bmc150] = {
>  		.name = "BMC150A",
> @@ -1576,33 +1569,23 @@ static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
>  	return 0;
>  }
> 
> -static int bmc150_accel_probe(struct i2c_client *client,
> -			      const struct i2c_device_id *id)
> +int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
> +			    const char *name, bool block_supported)
>  {
>  	struct bmc150_accel_data *data;
>  	struct iio_dev *indio_dev;
>  	int ret;
> -	const char *name = NULL;
> -	struct device *dev;
> 
> -	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>  	if (!indio_dev)
>  		return -ENOMEM;
> 
>  	data = iio_priv(indio_dev);
> -	i2c_set_clientdata(client, indio_dev);
> -	data->dev = &client->dev;
> -	dev = &client->dev;
> -	data->irq = client->irq;
> -
> -	data->regmap = devm_regmap_init_i2c(client, &bmc150_i2c_regmap_conf);
> -	if (IS_ERR(data->regmap)) {
> -		dev_err(dev, "Failed to initialize i2c regmap\n");
> -		return PTR_ERR(data->regmap);
> -	}
> +	dev_set_drvdata(dev, indio_dev);
> +	data->dev = dev;
> +	data->irq = irq;
> 
> -	if (id)
> -		name = id->name;
> +	data->regmap = regmap;
> 
>  	ret = bmc150_accel_chip_init(data);
>  	if (ret < 0)
> @@ -1659,9 +1642,7 @@ static int bmc150_accel_probe(struct i2c_client *client,
>  		if (ret)
>  			goto err_buffer_cleanup;
> 
> -		if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C) ||
> -		    i2c_check_functionality(client->adapter,
> -					    I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
> +		if (block_supported) {
>  			indio_dev->modes |= INDIO_BUFFER_SOFTWARE;
>  			indio_dev->info = &bmc150_accel_info_fifo;
>  			indio_dev->buffer->attrs = bmc150_accel_fifo_attributes;
> @@ -1670,7 +1651,7 @@ static int bmc150_accel_probe(struct i2c_client *client,
> 
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0) {
> -		dev_err(data->dev, "Unable to register iio device\n");
> +		dev_err(dev, "Unable to register iio device\n");
>  		goto err_trigger_unregister;
>  	}
> 
> @@ -1693,10 +1674,11 @@ err_buffer_cleanup:
> 
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(bmc150_accel_core_probe);
> 
> -static int bmc150_accel_remove(struct i2c_client *client)
> +int bmc150_accel_core_remove(struct device *dev)
>  {
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct bmc150_accel_data *data = iio_priv(indio_dev);
> 
>  	pm_runtime_disable(data->dev);
> @@ -1715,6 +1697,7 @@ static int bmc150_accel_remove(struct i2c_client *client)
> 
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(bmc150_accel_core_remove);
> 
>  #ifdef CONFIG_PM_SLEEP
>  static int bmc150_accel_suspend(struct device *dev)
> @@ -1785,48 +1768,12 @@ static int bmc150_accel_runtime_resume(struct device *dev)
>  }
>  #endif
> 
> -static const struct dev_pm_ops bmc150_accel_pm_ops = {
> +const struct dev_pm_ops bmc150_accel_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(bmc150_accel_suspend, bmc150_accel_resume)
>  	SET_RUNTIME_PM_OPS(bmc150_accel_runtime_suspend,
>  			   bmc150_accel_runtime_resume, NULL)
>  };
> 
> -static const struct acpi_device_id bmc150_accel_acpi_match[] = {
> -	{"BSBA0150",	bmc150},
> -	{"BMC150A",	bmc150},
> -	{"BMI055A",	bmi055},
> -	{"BMA0255",	bma255},
> -	{"BMA250E",	bma250e},
> -	{"BMA222E",	bma222e},
> -	{"BMA0280",	bma280},
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(acpi, bmc150_accel_acpi_match);
> -
> -static const struct i2c_device_id bmc150_accel_id[] = {
> -	{"bmc150_accel",	bmc150},
> -	{"bmi055_accel",	bmi055},
> -	{"bma255",		bma255},
> -	{"bma250e",		bma250e},
> -	{"bma222e",		bma222e},
> -	{"bma280",		bma280},
> -	{}
> -};
> -
> -MODULE_DEVICE_TABLE(i2c, bmc150_accel_id);
> -
> -static struct i2c_driver bmc150_accel_driver = {
> -	.driver = {
> -		.name	= BMC150_ACCEL_DRV_NAME,
> -		.acpi_match_table = ACPI_PTR(bmc150_accel_acpi_match),
> -		.pm	= &bmc150_accel_pm_ops,
> -	},
> -	.probe		= bmc150_accel_probe,
> -	.remove		= bmc150_accel_remove,
> -	.id_table	= bmc150_accel_id,
> -};
> -module_i2c_driver(bmc150_accel_driver);
> -
>  MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("BMC150 accelerometer driver");
> diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
> new file mode 100644
> index 000000000000..b41404ba32fc
> --- /dev/null
> +++ b/drivers/iio/accel/bmc150-accel-i2c.c
> @@ -0,0 +1,102 @@
> +/*
> + * 3-axis accelerometer driver supporting following I2C Bosch-Sensortec chips:
> + *  - BMC150
> + *  - BMI055
> + *  - BMA255
> + *  - BMA250E
> + *  - BMA222E
> + *  - BMA280
> + *
> + * Copyright (c) 2014, Intel Corporation.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/acpi.h>
> +#include <linux/regmap.h>
> +
> +#include "bmc150-accel.h"
> +
> +static const struct regmap_config bmc150_i2c_regmap_conf = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +};

Just one minor comment here. You forgot to remove the definition
for bmc150_i2c_regmap_conf from bmc150-accel-core.c. The
definition from bmc150-accel-core.c also sets max_register, so
you might want to add it here as well.

You can keep my Tested-by tag if you only make this change.

Thanks,
Irina

> +
> +static int bmc150_accel_probe(struct i2c_client *client,
> +			      const struct i2c_device_id *id)
> +{
> +	struct regmap *regmap;
> +	const char *name = NULL;
> +	bool block_supported =
> +		i2c_check_functionality(client->adapter, I2C_FUNC_I2C) ||
> +		i2c_check_functionality(client->adapter,
> +					I2C_FUNC_SMBUS_READ_I2C_BLOCK);
> +
> +	regmap = devm_regmap_init_i2c(client, &bmc150_i2c_regmap_conf);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "Failed to initialize i2c regmap\n");
> +		return PTR_ERR(regmap);
> +	}
> +
> +	if (id)
> +		name = id->name;
> +
> +	return bmc150_accel_core_probe(&client->dev, regmap, client->irq, name,
> +				       block_supported);
> +}
> +
> +static int bmc150_accel_remove(struct i2c_client *client)
> +{
> +	return bmc150_accel_core_remove(&client->dev);
> +}
> +
> +static const struct acpi_device_id bmc150_accel_acpi_match[] = {
> +	{"BSBA0150",	bmc150},
> +	{"BMC150A",	bmc150},
> +	{"BMI055A",	bmi055},
> +	{"BMA0255",	bma255},
> +	{"BMA250E",	bma250e},
> +	{"BMA222E",	bma222e},
> +	{"BMA0280",	bma280},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, bmc150_accel_acpi_match);
> +
> +static const struct i2c_device_id bmc150_accel_id[] = {
> +	{"bmc150_accel",	bmc150},
> +	{"bmi055_accel",	bmi055},
> +	{"bma255",		bma255},
> +	{"bma250e",		bma250e},
> +	{"bma222e",		bma222e},
> +	{"bma280",		bma280},
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, bmc150_accel_id);
> +
> +static struct i2c_driver bmc150_accel_driver = {
> +	.driver = {
> +		.name	= "bmc150_accel_i2c",
> +		.acpi_match_table = ACPI_PTR(bmc150_accel_acpi_match),
> +		.pm	= &bmc150_accel_pm_ops,
> +	},
> +	.probe		= bmc150_accel_probe,
> +	.remove		= bmc150_accel_remove,
> +	.id_table	= bmc150_accel_id,
> +};
> +module_i2c_driver(bmc150_accel_driver);
> +
> +MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("BMC150 I2C accelerometer driver");
> diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
> new file mode 100644
> index 000000000000..ba0335987f94
> --- /dev/null
> +++ b/drivers/iio/accel/bmc150-accel.h
> @@ -0,0 +1,20 @@
> +#ifndef _BMC150_ACCEL_H_
> +#define _BMC150_ACCEL_H_
> +
> +struct regmap;
> +
> +enum {
> +	bmc150,
> +	bmi055,
> +	bma255,
> +	bma250e,
> +	bma222e,
> +	bma280,
> +};
> +
> +int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
> +			    const char *name, bool block_supported);
> +int bmc150_accel_core_remove(struct device *dev);
> +extern const struct dev_pm_ops bmc150_accel_pm_ops;
> +
> +#endif  /* _BMC150_ACCEL_H_ */
> --
> 2.5.1

