Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38255 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106AbbHaQPW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 31 Aug 2015 12:15:22 -0400
Subject: Re: [PATCH v2 3/4] iio: bmc150: Split the driver into core and i2c
To: Markus Pargmann <mpa@pengutronix.de>
References: <1440074986-28716-1-git-send-email-mpa@pengutronix.de>
 <1440074986-28716-4-git-send-email-mpa@pengutronix.de>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55E47D98.4010608@kernel.org>
Date: Mon, 31 Aug 2015 17:15:20 +0100
MIME-Version: 1.0
In-Reply-To: <1440074986-28716-4-git-send-email-mpa@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/08/15 13:49, Markus Pargmann wrote:
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
A couple of little bits inline.  Again would like Srinivas to
take a quick look at this patch as well.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/Kconfig                          |  9 +-
>  drivers/iio/accel/Makefile                         |  3 +-
>  .../accel/{bmc150-accel.c => bmc150-accel-core.c}  | 95 ++++-----------------
>  drivers/iio/accel/bmc150-accel-i2c.c               | 99 ++++++++++++++++++++++
>  drivers/iio/accel/bmc150-accel.h                   | 21 +++++
>  5 files changed, 144 insertions(+), 83 deletions(-)
>  rename drivers/iio/accel/{bmc150-accel.c => bmc150-accel-core.c} (95%)
>  create mode 100644 drivers/iio/accel/bmc150-accel-i2c.c
>  create mode 100644 drivers/iio/accel/bmc150-accel.h
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 01dd03d194d1..6da4eb0db57b 100644
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
Well technically this is true until the next patch ;)  I'll let that one go
though....
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
> similarity index 95%
> rename from drivers/iio/accel/bmc150-accel.c
> rename to drivers/iio/accel/bmc150-accel-core.c
> index e4a0691d9b88..614cf61f0110 100644
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
> @@ -187,7 +189,6 @@ enum bmc150_accel_trigger_id {
>  struct bmc150_accel_data {
>  	struct regmap *regmap;
>  	struct device *dev;
> -	int irq;
>  	struct bmc150_accel_interrupt interrupts[BMC150_ACCEL_INTERRUPTS];
>  	atomic_t active_intr;
>  	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
> @@ -201,6 +202,7 @@ struct bmc150_accel_data {
>  	int ev_enable_state;
>  	int64_t timestamp, old_timestamp; /* Only used in hw fifo mode. */
>  	const struct bmc150_accel_chip_info *chip_info;
> +	int irq;
Why move the location of this element of the structure?

>  };
>  
>  static const struct {
> @@ -1070,15 +1072,6 @@ static const struct iio_chan_spec bmc150_accel_channels[] =
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
>  		.chip_id = 0xFA,
> @@ -1567,36 +1560,22 @@ static const struct iio_buffer_setup_ops bmc150_accel_buffer_ops = {
>  	.postdisable = bmc150_accel_buffer_postdisable,
>  };
>  
> -static int bmc150_accel_probe(struct i2c_client *client,
> -			      const struct i2c_device_id *id)
> +int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
> +			    const char *name, int chip_id, bool block_supported)
>  {
>  	struct bmc150_accel_data *data;
>  	struct iio_dev *indio_dev;
>  	int ret;
> -	const char *name = NULL;
> -	int chip_id = 0;
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
> -
> -	if (id) {
> -		name = id->name;
> -		chip_id = id->driver_data;
> -	}
> +	dev_set_drvdata(dev, indio_dev);
> +	data->dev = dev;
> +	data->irq = irq;
> +	data->regmap = regmap;
>  
>  	if (ACPI_HANDLE(dev))
>  		name = bmc150_accel_match_acpi_device(dev, &chip_id);
> @@ -1658,9 +1637,7 @@ static int bmc150_accel_probe(struct i2c_client *client,
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
> @@ -1669,7 +1646,7 @@ static int bmc150_accel_probe(struct i2c_client *client,
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0) {
> -		dev_err(data->dev, "Unable to register iio device\n");
> +		dev_err(dev, "Unable to register iio device\n");
>  		goto err_trigger_unregister;
>  	}
>  
> @@ -1692,10 +1669,11 @@ err_buffer_cleanup:
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
> @@ -1714,6 +1692,7 @@ static int bmc150_accel_remove(struct i2c_client *client)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(bmc150_accel_core_remove);
>  
>  #ifdef CONFIG_PM_SLEEP
>  static int bmc150_accel_suspend(struct device *dev)
> @@ -1784,48 +1763,8 @@ static int bmc150_accel_runtime_resume(struct device *dev)
>  }
>  #endif
>  
> -static const struct dev_pm_ops bmc150_accel_pm_ops = {
> +const struct dev_pm_ops bmc150_accel_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(bmc150_accel_suspend, bmc150_accel_resume)
>  	SET_RUNTIME_PM_OPS(bmc150_accel_runtime_suspend,
>  			   bmc150_accel_runtime_resume, NULL)
>  };
> -
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
> -MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
> -MODULE_LICENSE("GPL v2");
> -MODULE_DESCRIPTION("BMC150 accelerometer driver");
Note we have a core module now so it wants this stuff to still be there.

> diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
> new file mode 100644
> index 000000000000..e4dd596ba8f2
> --- /dev/null
> +++ b/drivers/iio/accel/bmc150-accel-i2c.c
> @@ -0,0 +1,99 @@
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
> +
> +static int bmc150_accel_probe(struct i2c_client *client,
> +			      const struct i2c_device_id *id)
> +{
> +	struct regmap *regmap;
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
> +	return bmc150_accel_core_probe(&client->dev, regmap, client->irq,
> +				       id->name, id->driver_data,
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
> index 000000000000..988b57573d0c
> --- /dev/null
> +++ b/drivers/iio/accel/bmc150-accel.h
> @@ -0,0 +1,21 @@
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
> +			    const char *name, int chip_id,
> +			    bool block_supported);
> +int bmc150_accel_core_remove(struct device *dev);
> +extern const struct dev_pm_ops bmc150_accel_pm_ops;
> +
> +#endif  /* _BMC150_ACCEL_H_ */
> 

