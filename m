Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58700 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbcBMNnf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 13 Feb 2016 08:43:35 -0500
Subject: Re: [PATCH v6 4/4] iio: imu: inv_mpu6050: Add SPI support for MPU6000
To: Adriana Reus <adriana.reus@intel.com>
References: <1455277485-19101-1-git-send-email-adriana.reus@intel.com>
 <1455277485-19101-5-git-send-email-adriana.reus@intel.com>
Cc: linux-iio@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
	ggao@invensense.com, lars@metafoo.de, daniel.baluta@intel.com,
	lucas.de.marchi@gmail.com, adi.reus@gmail.com, cmo@melexis.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56BF3305.1080300@kernel.org>
Date: Sat, 13 Feb 2016 13:43:33 +0000
MIME-Version: 1.0
In-Reply-To: <1455277485-19101-5-git-send-email-adriana.reus@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/02/16 11:44, Adriana Reus wrote:
> The only difference between the MPU6000 and the
> MPU6050 is that the first also supports SPI.
> Add SPI driver for this chip.
> 
> Signed-off-by: Adriana Reus <adriana.reus@intel.com>
Hmm. Fixup in previous meant I had to apply this the slow way with patch.
Anyhow, don't think I messed it up.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks for this one.  Very nice to see the additional support in the
driver.  (I just ordered a breakout board with one of these on to mess
around with when I get a spare afternoon :)

Jonathan
> ---
>  * Changed driver name
>  
>  drivers/iio/imu/inv_mpu6050/Kconfig        | 10 +++
>  drivers/iio/imu/inv_mpu6050/Makefile       |  3 +
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |  7 ++-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  |  2 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  6 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  | 97 ++++++++++++++++++++++++++++++
>  6 files changed, 122 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
> index b664858..a7f557a 100644
> --- a/drivers/iio/imu/inv_mpu6050/Kconfig
> +++ b/drivers/iio/imu/inv_mpu6050/Kconfig
> @@ -21,3 +21,13 @@ config INV_MPU6050_I2C
>  	  This driver can be built as a module. The module will be called
>  	  inv-mpu6050-i2c.
>  
> +config INV_MPU6050_SPI
> +	tristate "Invensense MPU6050 devices (SPI)"
> +	depends on SPI_MASTER
> +	select INV_MPU6050_IIO
> +	select REGMAP_SPI
> +	help
> +	  This driver supports the Invensense MPU6050 devices.
> +	  It is a gyroscope/accelerometer combo device.
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
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 7b46db5..2258600 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -152,6 +152,7 @@ int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(inv_mpu6050_set_power_itg);
>  
>  /**
>   *  inv_mpu6050_init_config() - Initialize hardware, disable FIFO.
> @@ -676,7 +677,8 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
>  	return 0;
>  }
>  
> -int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name)
> +int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
> +		       int (*inv_mpu_bus_setup)(struct iio_dev *))
>  {
>  	struct inv_mpu6050_state *st;
>  	struct iio_dev *indio_dev;
> @@ -700,6 +702,9 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name)
>  	if (result)
>  		return result;
>  
> +	if (inv_mpu_bus_setup)
> +		inv_mpu_bus_setup(indio_dev);
> +
>  	result = inv_mpu6050_init_config(indio_dev);
>  	if (result) {
>  		dev_err(dev, "Could not initialize device.\n");
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> index eeaf969..af400dd 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> @@ -129,7 +129,7 @@ static int inv_mpu_probe(struct i2c_client *client,
>  		return PTR_ERR(regmap);
>  	}
>  
> -	result = inv_mpu_core_probe(regmap, client->irq, name);
> +	result = inv_mpu_core_probe(regmap, client->irq, name, NULL);
>  	if (result < 0)
>  		return result;
>  
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index 1bf65a0..fcc2f3d 100644
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
> @@ -258,6 +260,8 @@ int inv_mpu6050_write_reg(struct inv_mpu6050_state *st, int reg, u8 val);
>  int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on);
>  int inv_mpu_acpi_create_mux_client(struct i2c_client *client);
>  void inv_mpu_acpi_delete_mux_client(struct i2c_client *client);
> -int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name);
> +int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
> +		      int (*inv_mpu_bus_setup)(struct iio_dev *));
>  int inv_mpu_core_remove(struct device *dev);
> +int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on);
>  extern const struct dev_pm_ops inv_mpu_pmops;
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> new file mode 100644
> index 0000000..5b552a6
> --- /dev/null
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> @@ -0,0 +1,97 @@
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
> +static int inv_mpu_i2c_disable(struct iio_dev *indio_dev)
> +{
> +	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> +	int ret = 0;
> +
> +	ret = inv_mpu6050_set_power_itg(st, true);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->map, INV_MPU6050_REG_USER_CTRL,
> +			   INV_MPU6050_BIT_I2C_IF_DIS);
> +	if (ret) {
> +		inv_mpu6050_set_power_itg(st, false);
> +		return ret;
> +	}
> +
> +	return inv_mpu6050_set_power_itg(st, false);
> +}
> +
> +static int inv_mpu_probe(struct spi_device *spi)
> +{
> +	struct regmap *regmap;
> +	const struct spi_device_id *id = spi_get_device_id(spi);
> +	const char *name = id ? id->name : NULL;
> +
> +	regmap = devm_regmap_init_spi(spi, &inv_mpu_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
> +			(int)PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +
> +	return inv_mpu_core_probe(regmap, spi->irq, name, inv_mpu_i2c_disable);
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
> +		.acpi_match_table = ACPI_PTR(inv_acpi_match),
> +		.name	=	"inv-mpu6000-spi",
> +		.pm     =       &inv_mpu_pmops,
> +	},
> +};
> +
> +module_spi_driver(inv_mpu_driver);
> +
> +MODULE_AUTHOR("Adriana Reus <adriana.reus@intel.com>");
> +MODULE_DESCRIPTION("Invensense device MPU6000 driver");
> +MODULE_LICENSE("GPL");
> 

