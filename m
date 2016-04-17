Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52803 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993AbcDQKEM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Apr 2016 06:04:12 -0400
Subject: Re: [PATCH 2/2] iio: magn: bmc150: Introduce SPI support
To: Daniel Baluta <daniel.baluta@intel.com>, irina.tirdea@intel.com
References: <1460729590-18886-1-git-send-email-daniel.baluta@intel.com>
 <1460729590-18886-3-git-send-email-daniel.baluta@intel.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	geert@linux-m68k.org, vlad.dogaru@intel.com,
	octavian.purdila@intel.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <57135F99.8010100@kernel.org>
Date: Sun, 17 Apr 2016 11:04:09 +0100
MIME-Version: 1.0
In-Reply-To: <1460729590-18886-3-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/04/16 15:13, Daniel Baluta wrote:
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
Looks good.  I like regmap sometimes ;)

Applied to the togreg branch of iio.git - initially pushed out as
testing for the autobuilders to try spotting what we've missed.

Jonathan
> ---
>  drivers/iio/magnetometer/Kconfig           | 16 +++++++
>  drivers/iio/magnetometer/Makefile          |  1 +
>  drivers/iio/magnetometer/bmc150_magn_spi.c | 68 ++++++++++++++++++++++++++++++
>  3 files changed, 85 insertions(+)
>  create mode 100644 drivers/iio/magnetometer/bmc150_magn_spi.c
> 
> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> index e916005..33609c23 100644
> --- a/drivers/iio/magnetometer/Kconfig
> +++ b/drivers/iio/magnetometer/Kconfig
> @@ -45,6 +45,22 @@ config BMC150_MAGN_I2C
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called bmc150_magn_i2c.
>  
> +config BMC150_MAGN_SPI
> +	tristate "Bosch BMC150 SPI Magnetometer Driver"
> +	depends on SPI
> +	select BMC150_MAGN
> +	select REGMAP_SPI
> +	help
> +	  Say yes here to build support for the BMC150 magnetometer with
> +	  SPI interface.
> +
> +	  This is a combo module with both accelerometer and magnetometer.
> +	  This driver is only implementing magnetometer part, which has
> +	  its own address and register map.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called bmc150_magn_spi.
> +
>  config MAG3110
>  	tristate "Freescale MAG3110 3-Axis Magnetometer"
>  	depends on I2C
> diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
> index 5647773..92a745c 100644
> --- a/drivers/iio/magnetometer/Makefile
> +++ b/drivers/iio/magnetometer/Makefile
> @@ -6,6 +6,7 @@
>  obj-$(CONFIG_AK8975)	+= ak8975.o
>  obj-$(CONFIG_BMC150_MAGN) += bmc150_magn.o
>  obj-$(CONFIG_BMC150_MAGN_I2C) += bmc150_magn_i2c.o
> +obj-$(CONFIG_BMC150_MAGN_SPI) += bmc150_magn_spi.o
>  
>  obj-$(CONFIG_MAG3110)	+= mag3110.o
>  obj-$(CONFIG_HID_SENSOR_MAGNETOMETER_3D) += hid-sensor-magn-3d.o
> diff --git a/drivers/iio/magnetometer/bmc150_magn_spi.c b/drivers/iio/magnetometer/bmc150_magn_spi.c
> new file mode 100644
> index 0000000..c4c738a
> --- /dev/null
> +++ b/drivers/iio/magnetometer/bmc150_magn_spi.c
> @@ -0,0 +1,68 @@
> +/*
> + * 3-axis magnetometer driver support following SPI Bosch-Sensortec chips:
> + *  - BMC150
> + *  - BMC156
> + *
> + * Copyright (c) 2016, Intel Corporation.
> + *
> + * This file is subject to the terms and conditions of version 2 of
> + * the GNU General Public License.  See the file COPYING in the main
> + * directory of this archive for more details.
> + */
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/spi/spi.h>
> +#include <linux/acpi.h>
> +#include <linux/regmap.h>
> +
> +#include "bmc150_magn.h"
> +
> +static int bmc150_magn_spi_probe(struct spi_device *spi)
> +{
> +	struct regmap *regmap;
> +	const struct spi_device_id *id = spi_get_device_id(spi);
> +
> +	regmap = devm_regmap_init_spi(spi, &bmc150_magn_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
> +			(int)PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +	return bmc150_magn_probe(&spi->dev, regmap, spi->irq, id->name);
> +}
> +
> +static int bmc150_magn_spi_remove(struct spi_device *spi)
> +{
> +	bmc150_magn_remove(&spi->dev);
> +
> +	return 0;
> +}
> +
> +static const struct spi_device_id bmc150_magn_spi_id[] = {
> +	{"bmc150_magn", 0},
> +	{"bmc156_magn", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, bmc150_magn_spi_id);
> +
> +static const struct acpi_device_id bmc150_magn_acpi_match[] = {
> +	{"BMC150B", 0},
> +	{"BMC156B", 0},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(acpi, bmc150_magn_acpi_match);
> +
> +static struct spi_driver bmc150_magn_spi_driver = {
> +	.probe		= bmc150_magn_spi_probe,
> +	.remove		= bmc150_magn_spi_remove,
> +	.id_table	= bmc150_magn_spi_id,
> +	.driver = {
> +		.acpi_match_table = ACPI_PTR(bmc150_magn_acpi_match),
> +		.name	= "bmc150_magn_spi",
> +	},
> +};
> +module_spi_driver(bmc150_magn_spi_driver);
> +
> +MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com");
> +MODULE_DESCRIPTION("BMC150 magnetometer SPI driver");
> +MODULE_LICENSE("GPL v2");
> 

