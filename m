Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44424 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbbJCLE5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 Oct 2015 07:04:57 -0400
Subject: Re: [PATCH v3 4/4] iio: bmc150: Add SPI driver
To: Markus Pargmann <mpa@pengutronix.de>
References: <1442832916-30774-1-git-send-email-mpa@pengutronix.de>
 <1442832916-30774-5-git-send-email-mpa@pengutronix.de>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <560FB654.7060009@kernel.org>
Date: Sat, 3 Oct 2015 12:04:52 +0100
MIME-Version: 1.0
In-Reply-To: <1442832916-30774-5-git-send-email-mpa@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/09/15 11:55, Markus Pargmann wrote:
> Add a simple SPI driver which initializes the spi regmap for the bmc150
> core driver.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
After applying this one to latest togreg I get:
drivers/iio/accel/bmc150-accel-spi.c:69:37: error: undefined identifier 'bmc150_accel_acpi_match'
  CC [M]  drivers/iio/accel/bmc150-accel-spi.o
In file included from drivers/iio/accel/bmc150-accel-spi.c:22:0:
drivers/iio/accel/bmc150-accel-spi.c:69:32: error: ‘bmc150_accel_acpi_match’ undeclared here (not in a function)
   .acpi_match_table = ACPI_PTR(bmc150_accel_acpi_match),
                                ^
include/linux/acpi.h:446:25: note: in definition of macro ‘ACPI_PTR’
 #define ACPI_PTR(_ptr) (_ptr)
                         ^
As per the other table I cut and paste it across from the i2c driver and
all now looks good.

It might make sense to do a follow up patch moving both the match tables into
the core driver.  However, we may end up with a divergence in them if ST ever
release an i2c or SPI only part...
Up to you.

Jonathan

> ---
>  drivers/iio/accel/Kconfig            |  5 +++
>  drivers/iio/accel/Makefile           |  1 +
>  drivers/iio/accel/bmc150-accel-spi.c | 80 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 86 insertions(+)
>  create mode 100644 drivers/iio/accel/bmc150-accel-spi.c
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 280635545240..a010329f7d06 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -23,6 +23,7 @@ config BMC150_ACCEL
>  	select IIO_TRIGGERED_BUFFER
>  	select REGMAP
>  	select BMC150_ACCEL_I2C if I2C
> +	select BMC150_ACCEL_SPI if SPI
>  	help
>  	  Say yes here to build support for the following Bosch accelerometers:
>  	  BMC150, BMI055, BMA250E, BMA222E, BMA255, BMA280.
> @@ -35,6 +36,10 @@ config BMC150_ACCEL_I2C
>  	tristate
>  	select REGMAP_I2C
>  
> +config BMC150_ACCEL_SPI
> +	tristate
> +	select REGMAP_SPI
> +
>  config HID_SENSOR_ACCEL_3D
>  	depends on HID_SENSOR_HUB
>  	select IIO_BUFFER
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index 5ef8bdbad092..e579e93bf022 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -6,6 +6,7 @@
>  obj-$(CONFIG_BMA180) += bma180.o
>  obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel-core.o
>  obj-$(CONFIG_BMC150_ACCEL_I2C) += bmc150-accel-i2c.o
> +obj-$(CONFIG_BMC150_ACCEL_SPI) += bmc150-accel-spi.o
>  obj-$(CONFIG_HID_SENSOR_ACCEL_3D) += hid-sensor-accel-3d.o
>  obj-$(CONFIG_KXCJK1013) += kxcjk-1013.o
>  obj-$(CONFIG_KXSD9)	+= kxsd9.o
> diff --git a/drivers/iio/accel/bmc150-accel-spi.c b/drivers/iio/accel/bmc150-accel-spi.c
> new file mode 100644
> index 000000000000..41dd842996b0
> --- /dev/null
> +++ b/drivers/iio/accel/bmc150-accel-spi.c
> @@ -0,0 +1,80 @@
> +/*
> + * 3-axis accelerometer driver supporting SPI Bosch-Sensortec accelerometer chip
> + * Copyright © 2015 Pengutronix, Markus Pargmann <mpa@pengutronix.de>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/acpi.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +
> +#include "bmc150-accel.h"
> +
> +static const struct regmap_config bmc150_spi_regmap_conf = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = 0x3f,
> +};
> +
> +static int bmc150_accel_probe(struct spi_device *spi)
> +{
> +	struct regmap *regmap;
> +	const struct spi_device_id *id = spi_get_device_id(spi);
> +
> +	regmap = devm_regmap_init_spi(spi, &bmc150_spi_regmap_conf);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&spi->dev, "Failed to initialize spi regmap\n");
> +		return PTR_ERR(regmap);
> +	}
> +
> +	return bmc150_accel_core_probe(&spi->dev, regmap, spi->irq, id->name,
> +				       true);
> +}
> +
> +static int bmc150_accel_remove(struct spi_device *spi)
> +{
> +	return bmc150_accel_core_remove(&spi->dev);
> +}
> +
> +static const struct spi_device_id bmc150_accel_id[] = {
> +	{"bmc150_accel",	bmc150},
> +	{"bmi055_accel",	bmi055},
> +	{"bma255",		bma255},
> +	{"bma250e",		bma250e},
> +	{"bma222e",		bma222e},
> +	{"bma280",		bma280},
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(spi, bmc150_accel_id);
> +
> +static struct spi_driver bmc150_accel_driver = {
> +	.driver = {
> +		.name	= "bmc150_accel_spi",
> +		.acpi_match_table = ACPI_PTR(bmc150_accel_acpi_match),
> +		.pm	= &bmc150_accel_pm_ops,
> +	},
> +	.probe		= bmc150_accel_probe,
> +	.remove		= bmc150_accel_remove,
> +	.id_table	= bmc150_accel_id,
> +};
> +module_spi_driver(bmc150_accel_driver);
> +
> +MODULE_AUTHOR("Markus Pargmann <mpa@pengutronix.de>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("BMC150 SPI accelerometer driver");
> 

