Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37793 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751555AbdBSNMx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Feb 2017 08:12:53 -0500
Subject: Re: [PATCH 3/4] iio: accel: adxl345: Add SPI support
To: Eva Rachel Retuya <eraretuya@gmail.com>, linux-iio@vger.kernel.org
References: <1487239327-21406-1-git-send-email-eraretuya@gmail.com>
 <1487239327-21406-4-git-send-email-eraretuya@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        dmitry.torokhov@gmail.com, michael.hennerich@analog.com,
        daniel.baluta@gmail.com, amsfield22@gmail.com,
        florian.vaussard@heig-vd.ch, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <95aac9d7-57d6-c4ee-4666-83019b525ca6@kernel.org>
Date: Sun, 19 Feb 2017 13:12:50 +0000
MIME-Version: 1.0
In-Reply-To: <1487239327-21406-4-git-send-email-eraretuya@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/02/17 10:02, Eva Rachel Retuya wrote:
> Add SPI driver for initializing spi regmap for the adxl345 core driver.
> The driver supports the same functionality as I2C namely the x, y, z and
> scale readings.
> 
> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
Looks nice.  I didn't know about the readmask stuff in regmap so 
always good to see something new.

Jonathan
> ---
>  drivers/iio/accel/Kconfig       | 13 +++++++
>  drivers/iio/accel/Makefile      |  1 +
>  drivers/iio/accel/adxl345_spi.c | 75 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 89 insertions(+)
>  create mode 100644 drivers/iio/accel/adxl345_spi.c
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 5bdd87f..d474fed 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -21,6 +21,19 @@ config ADXL345_I2C
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called adxl345_i2c.
>  
> +config ADXL345_SPI
> +	tristate "Analog Devices ADXL345 3-Axis Digital Accelerometer SPI Driver"
> +	depends on !(INPUT_ADXL34X=y || INPUT_ADXL34X=m)
> +	depends on SPI
> +	select ADXL345
> +	select REGMAP_SPI
> +	help
> +	  Say Y here if you want to build support for the Analog Devices
> +	  ADXL345 3-axis digital accelerometer.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called adxl345_spi.
> +
>  config BMA180
>  	tristate "Bosch BMA180/BMA250 3-Axis Accelerometer Driver"
>  	depends on I2C
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index 3f4a6d6..31fba19 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -5,6 +5,7 @@
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_ADXL345) += adxl345_core.o
>  obj-$(CONFIG_ADXL345_I2C) += adxl345_i2c.o
> +obj-$(CONFIG_ADXL345_SPI) += adxl345_spi.o
>  obj-$(CONFIG_BMA180) += bma180.o
>  obj-$(CONFIG_BMA220) += bma220_spi.o
>  obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel-core.o
> diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
> new file mode 100644
> index 0000000..5fcd1fa
> --- /dev/null
> +++ b/drivers/iio/accel/adxl345_spi.c
> @@ -0,0 +1,75 @@
> +/*
> + * ADXL345 3-Axis Digital Accelerometer
> + *
> + * Copyright (c) 2017 Eva Rachel Retuya <eraretuya@gmail.com>
> + *
> + * This file is subject to the terms and conditions of version 2 of
> + * the GNU General Public License. See the file COPYING in the main
> + * directory of this archive for more details.
> + *
> + * SPI driver for ADXL345
> + */
> +
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +
> +#include "adxl345.h"
> +
> +#define ADXL345_MAX_SPI_FREQ_HZ		5000000
> +
> +static const struct regmap_config adxl345_spi_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	 /* Setting bits 7 and 6 enables multiple-byte read */
> +	.read_flag_mask = BIT(7) | BIT(6),
Nice. I didn't know about that one ;)
> +};
> +
> +static int adxl345_spi_probe(struct spi_device *spi)
> +{
> +	struct regmap *regmap;
> +	const struct spi_device_id *id = spi_get_device_id(spi);
> +
> +	/* Bail out if max_speed_hz exceeds 5 MHz */
> +	if (spi->max_speed_hz > ADXL345_MAX_SPI_FREQ_HZ) {
> +		dev_err(&spi->dev, "SPI CLK, %d Hz exceeds 5 MHz\n",
> +			spi->max_speed_hz);
> +		return -EINVAL;
> +	}
> +
> +	regmap = devm_regmap_init_spi(spi, &adxl345_spi_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&spi->dev, "Error initializing spi regmap: %d\n",
> +			(int)PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +
> +	return adxl345_common_probe(&spi->dev, regmap, id->name);
> +}
> +
> +static int adxl345_spi_remove(struct spi_device *spi)
> +{
> +	return adxl345_common_remove(&spi->dev);
> +}
> +
> +static const struct spi_device_id adxl345_spi_id[] = {
> +	{ "adxl345", 0 },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(spi, adxl345_spi_id);
> +
> +static struct spi_driver adxl345_spi_driver = {
> +	.driver = {
> +		.name	= "adxl345_spi",
> +	},
> +	.probe		= adxl345_spi_probe,
> +	.remove		= adxl345_spi_remove,
> +	.id_table	= adxl345_spi_id,
> +};
> +
> +module_spi_driver(adxl345_spi_driver);
> +
> +MODULE_AUTHOR("Eva Rachel Retuya <eraretuya@gmail.com>");
> +MODULE_DESCRIPTION("ADXL345 3-Axis Digital Accelerometer SPI driver");
> +MODULE_LICENSE("GPL v2");
> 

