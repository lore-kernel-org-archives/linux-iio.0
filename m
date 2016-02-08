Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f194.google.com ([209.85.213.194]:34129 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011AbcBHCFi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 7 Feb 2016 21:05:38 -0500
Received: by mail-ig0-f194.google.com with SMTP id ik10so4088317igb.1
        for <linux-iio@vger.kernel.org>; Sun, 07 Feb 2016 18:05:38 -0800 (PST)
Date: Sun, 7 Feb 2016 20:05:26 -0600
From: Michael Welling <mwelling@ieee.org>
To: Adriana Reus <adriana.reus@intel.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com, ggao@invensense.com,
	lucas.de.marchi@gmail.com
Subject: Re: [PATCH v2 4/4] iio: imu: inv_mpu6050: Add SPI support for MPU6000
Message-ID: <20160208020525.GA2554@deathstar>
References: <1454577628-12708-1-git-send-email-adriana.reus@intel.com>
 <1454577628-12708-5-git-send-email-adriana.reus@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454577628-12708-5-git-send-email-adriana.reus@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Feb 04, 2016 at 11:20:28AM +0200, Adriana Reus wrote:
> The only difference between the MPU6000 and the
> MPU6050 is that the first also supports SPI.
> Add SPI driver for this chip.
> 
> Signed-off-by: Adriana Reus <adriana.reus@intel.com>
> ---
>  Changes since v1:
>  * removed mpu6050 from the device_id list
>  * make sure we disable the I2C interface
> 
>  drivers/iio/imu/inv_mpu6050/Kconfig       |  7 +++
>  drivers/iio/imu/inv_mpu6050/Makefile      |  3 ++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h |  2 +
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c | 87 +++++++++++++++++++++++++++++++
>  4 files changed, 99 insertions(+)
>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
> index 483f52d..6f6a419 100644
> --- a/drivers/iio/imu/inv_mpu6050/Kconfig
> +++ b/drivers/iio/imu/inv_mpu6050/Kconfig
> @@ -25,3 +25,10 @@ config INV_MPU6050_I2C
>  	  This driver can be built as a module. The module will be called
>  	  inv-mpu6050-i2c.
>  
> +config INV_MPU6050_SPI
> +	tristate "Invensense MPU6050 devices"

This should probably be "Invensense MPU6050 devices SPI" or similar.

> +	select INV_MPU6050_IIO
> +	select REGMAP_SPI
> +	help
> +	  This driver can be built as a module. The module will be called
> +	  inv-mpu6050-spi.
> diff --git a/drivers/iio/imu/inv_mpu6050/Makefile b/drivers/iio/imu/inv_mpu6050/Makefile
> index ca4941d..734af5e 100644
> --- a/drivers/iio/imu/inv_mpu6050/Makefile
> +++ b/drivers/iio/imu/inv_mpu6050/Makefile
> @@ -7,3 +7,6 @@ inv-mpu6050-objs := inv_mpu_core.o inv_mpu_ring.o inv_mpu_trigger.o
>  
>  obj-$(CONFIG_INV_MPU6050_I2C) += inv-mpu6050-i2c.o
>  inv-mpu6050-i2c-objs := inv_mpu_i2c.o inv_mpu_acpi.o
> +
> +obj-$(CONFIG_INV_MPU6050_SPI) += inv-mpu6050-spi.o
> +inv-mpu6050-spi-objs := inv_mpu_spi.o
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index 1bf65a0..435e84c 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -62,6 +62,7 @@ struct inv_mpu6050_reg_map {
>  enum inv_devices {
>  	INV_MPU6050,
>  	INV_MPU6500,
> +	INV_MPU6000,
>  	INV_NUM_PARTS
>  };
>  
> @@ -154,6 +155,7 @@ struct inv_mpu6050_state {
>  #define INV_MPU6050_BIT_I2C_MST_EN          0x20
>  #define INV_MPU6050_BIT_FIFO_EN             0x40
>  #define INV_MPU6050_BIT_DMP_EN              0x80
> +#define INV_MPU6050_BIT_I2C_IF_DIS          0x10
>  
>  #define INV_MPU6050_REG_PWR_MGMT_1          0x6B
>  #define INV_MPU6050_BIT_H_RESET             0x80
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> new file mode 100644
> index 0000000..6a1de35
> --- /dev/null
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> @@ -0,0 +1,87 @@
> +/*
> +* Copyright (C) 2015 Intel Corporation Inc.
> +*
> +* This software is licensed under the terms of the GNU General Public
> +* License version 2, as published by the Free Software Foundation, and
> +* may be copied, distributed, and modified under those terms.
> +*
> +* This program is distributed in the hope that it will be useful,
> +* but WITHOUT ANY WARRANTY; without even the implied warranty of
> +* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +* GNU General Public License for more details.
> +*/
> +#include <linux/module.h>
> +#include <linux/acpi.h>
> +#include <linux/spi/spi.h>
> +#include <linux/regmap.h>
> +#include <linux/iio/iio.h>
> +#include "inv_mpu_iio.h"
> +
> +static const struct regmap_config inv_mpu_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +};
> +
> +static int inv_mpu_probe(struct spi_device *spi)
> +{
> +	struct regmap *regmap;
> +	const struct spi_device_id *id = spi_get_device_id(spi);
> +	const char *name = id ? id->name : NULL;
> +	int result;
> +
> +	regmap = devm_regmap_init_spi(spi, &inv_mpu_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
> +			(int)PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +
> +	result = regmap_write(regmap, INV_MPU6050_REG_USER_CTRL,
> +			      INV_MPU6050_BIT_I2C_IF_DIS);
> +	if (result) {
> +		dev_err(&spi->dev, "Failed to disable I2C interface\n");
> +		return result;
> +	}
> +
> +	return inv_mpu_core_probe(regmap, spi->irq, name);
> +}
> +
> +static int inv_mpu_remove(struct spi_device *spi)
> +{
> +	return inv_mpu_core_remove(&spi->dev);
> +}
> +
> +/*
> + * device id table is used to identify what device can be
> + * supported by this driver
> + */
> +static const struct spi_device_id inv_mpu_id[] = {
> +	{"mpu6000", INV_MPU6000},
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(spi, inv_mpu_id);
> +
> +static const struct acpi_device_id inv_acpi_match[] = {
> +	{"INVN6000", 0},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, inv_acpi_match);
> +
> +static struct spi_driver inv_mpu_driver = {
> +	.probe		=	inv_mpu_probe,
> +	.remove		=	inv_mpu_remove,
> +	.id_table	=	inv_mpu_id,
> +	.driver = {
> +		.owner	=	THIS_MODULE,
> +		.acpi_match_table = ACPI_PTR(inv_acpi_match),
> +		.name	=	"inv-mpu6000 spi driver",
> +		.pm     =       &inv_mpu_pmops,
> +	},
> +};
> +
> +module_spi_driver(inv_mpu_driver);
> +
> +MODULE_AUTHOR("Adriana Reus <adriana.reus@intel.com>");
> +MODULE_DESCRIPTION("Invensense device MPU6000 driver");
> +MODULE_LICENSE("GPL");
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
