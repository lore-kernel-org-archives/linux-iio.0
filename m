Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:37144 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932342AbcHXP0A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Aug 2016 11:26:00 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2] misc: retire the old BMP085 driver
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <1472049532-12196-1-git-send-email-linus.walleij@linaro.org>
Date: Wed, 24 Aug 2016 17:25:41 +0200
Cc: LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Cameron <jic23@cam.ac.uk>,
        Marek Belisko <marek@goldelico.com>, linux-iio@vger.kernel.org,
        Christoph Mair <christoph.mair@gmail.com>
Message-Id: <9EB962FC-792D-42F9-8E24-6C94D545CE3E@goldelico.com>
References: <1472049532-12196-1-git-send-email-linus.walleij@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

HI,

> Am 24.08.2016 um 16:38 schrieb Linus Walleij =
<linus.walleij@linaro.org>:
>=20
> Patches merged to the IIO BMP085 driver makes it fully compliant
> with all features found in this old misc driver. Retire this old
> driver in favor of the new one in the proper subsystem.
>=20
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jonathan Cameron <jic23@cam.ac.uk>
> Cc: Marek Belisko <marek@goldelico.com>
> Cc: H. Nikolaus Schaller <hns@goldelico.com>
> Cc: linux-iio@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Also delete the dangling sysfs ABI file.
>=20
> Greg I guess you can merge this unless somebody starts screaming.
> ---
> Documentation/ABI/testing/sysfs-i2c-bmp085 |  31 --
> drivers/iio/pressure/Kconfig               |   2 -
> drivers/misc/Kconfig                       |  28 --
> drivers/misc/Makefile                      |   3 -
> drivers/misc/bmp085-i2c.c                  |  83 -----
> drivers/misc/bmp085-spi.c                  |  79 -----
> drivers/misc/bmp085.c                      | 506 =
-----------------------------
> drivers/misc/bmp085.h                      |  33 --
> 8 files changed, 765 deletions(-)
> delete mode 100644 Documentation/ABI/testing/sysfs-i2c-bmp085
> delete mode 100644 drivers/misc/bmp085-i2c.c
> delete mode 100644 drivers/misc/bmp085-spi.c
> delete mode 100644 drivers/misc/bmp085.c
> delete mode 100644 drivers/misc/bmp085.h
>=20
> diff --git a/Documentation/ABI/testing/sysfs-i2c-bmp085 =
b/Documentation/ABI/testing/sysfs-i2c-bmp085
> deleted file mode 100644
> index 585962ad0465..000000000000
> --- a/Documentation/ABI/testing/sysfs-i2c-bmp085
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -What:		=
/sys/bus/i2c/devices/<busnum>-<devaddr>/pressure0_input
> -Date:		June 2010
> -Contact:	Christoph Mair <christoph.mair@gmail.com>
> -Description:	Start a pressure measurement and read the result. Values
> -		represent the ambient air pressure in pascal (0.01 =
millibar).
> -
> -		Reading: returns the current air pressure.
> -
> -
> -What:		=
/sys/bus/i2c/devices/<busnum>-<devaddr>/temp0_input
> -Date:		June 2010
> -Contact:	Christoph Mair <christoph.mair@gmail.com>
> -Description:	Measure the ambient temperature. The returned value =
represents
> -		the ambient temperature in units of 0.1 degree celsius.
> -
> -		Reading: returns the current temperature.
> -
> -
> -What:		=
/sys/bus/i2c/devices/<busnum>-<devaddr>/oversampling
> -Date:		June 2010
> -Contact:	Christoph Mair <christoph.mair@gmail.com>
> -Description:	Tell the bmp085 to use more samples to calculate a =
pressure
> -		value. When writing to this file the chip will use 2^x =
samples
> -		to calculate the next pressure value with x being the =
value
> -		written. Using this feature will decrease RMS noise and
> -		increase the measurement time.
> -
> -		Reading: returns the current oversampling setting.
> -
> -		Writing: sets a new oversampling setting.
> -		Accepted values: 0..3.
> diff --git a/drivers/iio/pressure/Kconfig =
b/drivers/iio/pressure/Kconfig
> index d130cdc78f43..7fa65ab664fb 100644
> --- a/drivers/iio/pressure/Kconfig
> +++ b/drivers/iio/pressure/Kconfig
> @@ -8,8 +8,6 @@ menu "Pressure sensors"
> config BMP280
> 	tristate "Bosch Sensortec BMP180/BMP280 pressure sensor I2C =
driver"
> 	depends on (I2C || SPI_MASTER)
> -	depends on !(BMP085_I2C=3Dy || BMP085_I2C=3Dm)
> -	depends on !(BMP085_SPI=3Dy || BMP085_SPI=3Dm)
> 	select REGMAP
> 	select BMP280_I2C if (I2C)
> 	select BMP280_SPI if (SPI_MASTER)
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index a216b4667742..09f6f84a6a7f 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -439,34 +439,6 @@ config ARM_CHARLCD
> 	  line and the Linux version on the second line, but that's
> 	  still useful.
>=20
> -config BMP085
> -	tristate
> -	depends on SYSFS
> -
> -config BMP085_I2C
> -	tristate "BMP085 digital pressure sensor on I2C"
> -	select BMP085
> -	select REGMAP_I2C
> -	depends on I2C && SYSFS
> -	help
> -	  Say Y here if you want to support Bosch Sensortec's digital =
pressure
> -	  sensor hooked to an I2C bus.
> -
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called bmp085-i2c.
> -
> -config BMP085_SPI
> -	tristate "BMP085 digital pressure sensor on SPI"
> -	select BMP085
> -	select REGMAP_SPI
> -	depends on SPI_MASTER && SYSFS
> -	help
> -	  Say Y here if you want to support Bosch Sensortec's digital =
pressure
> -	  sensor hooked to an SPI bus.
> -
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called bmp085-spi.
> -
> config PCH_PHUB
> 	tristate "Intel EG20T PCH/LAPIS Semicon =
IOH(ML7213/ML7223/ML7831) PHUB"
> 	select GENERIC_NET_UTILS
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 4387ccb79e64..dc619b5a6b30 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -9,9 +9,6 @@ obj-$(CONFIG_AD525X_DPOT_SPI)	+=3D ad525x_dpot-spi.o
> obj-$(CONFIG_INTEL_MID_PTI)	+=3D pti.o
> obj-$(CONFIG_ATMEL_SSC)		+=3D atmel-ssc.o
> obj-$(CONFIG_ATMEL_TCLIB)	+=3D atmel_tclib.o
> -obj-$(CONFIG_BMP085)		+=3D bmp085.o
> -obj-$(CONFIG_BMP085_I2C)	+=3D bmp085-i2c.o
> -obj-$(CONFIG_BMP085_SPI)	+=3D bmp085-spi.o
> obj-$(CONFIG_DUMMY_IRQ)		+=3D dummy-irq.o
> obj-$(CONFIG_ICS932S401)	+=3D ics932s401.o
> obj-$(CONFIG_LKDTM)		+=3D lkdtm.o
> diff --git a/drivers/misc/bmp085-i2c.c b/drivers/misc/bmp085-i2c.c
> deleted file mode 100644
> index f35c218aaa1a..000000000000
> --- a/drivers/misc/bmp085-i2c.c
> +++ /dev/null
> @@ -1,83 +0,0 @@
> -/*
> - * Copyright (c) 2012  Bosch Sensortec GmbH
> - * Copyright (c) 2012  Unixphere AB
> - *
> - * This program is free software; you can redistribute it and/or =
modify
> - * it under the terms of the GNU General Public License as published =
by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> - */
> -
> -#include <linux/module.h>
> -#include <linux/i2c.h>
> -#include <linux/err.h>
> -#include "bmp085.h"
> -
> -#define BMP085_I2C_ADDRESS	0x77
> -
> -static const unsigned short normal_i2c[] =3D { BMP085_I2C_ADDRESS,
> -							I2C_CLIENT_END =
};
> -
> -static int bmp085_i2c_detect(struct i2c_client *client,
> -			     struct i2c_board_info *info)
> -{
> -	if (client->addr !=3D BMP085_I2C_ADDRESS)
> -		return -ENODEV;
> -
> -	return bmp085_detect(&client->dev);
> -}
> -
> -static int bmp085_i2c_probe(struct i2c_client *client,
> -				      const struct i2c_device_id *id)
> -{
> -	int err;
> -	struct regmap *regmap =3D devm_regmap_init_i2c(client,
> -						     =
&bmp085_regmap_config);
> -
> -	if (IS_ERR(regmap)) {
> -		err =3D PTR_ERR(regmap);
> -		dev_err(&client->dev, "Failed to init regmap: %d\n", =
err);
> -		return err;
> -	}
> -
> -	return bmp085_probe(&client->dev, regmap, client->irq);
> -}
> -
> -static int bmp085_i2c_remove(struct i2c_client *client)
> -{
> -	return bmp085_remove(&client->dev);
> -}
> -
> -static const struct i2c_device_id bmp085_id[] =3D {
> -	{ BMP085_NAME, 0 },
> -	{ "bmp180", 0 },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(i2c, bmp085_id);
> -
> -static struct i2c_driver bmp085_i2c_driver =3D {
> -	.driver =3D {
> -		.name	=3D BMP085_NAME,
> -	},
> -	.id_table	=3D bmp085_id,
> -	.probe		=3D bmp085_i2c_probe,
> -	.remove		=3D bmp085_i2c_remove,
> -
> -	.detect		=3D bmp085_i2c_detect,
> -	.address_list	=3D normal_i2c
> -};
> -
> -module_i2c_driver(bmp085_i2c_driver);
> -
> -MODULE_AUTHOR("Eric Andersson <eric.andersson@unixphere.com>");
> -MODULE_DESCRIPTION("BMP085 I2C bus driver");
> -MODULE_LICENSE("GPL");
> diff --git a/drivers/misc/bmp085-spi.c b/drivers/misc/bmp085-spi.c
> deleted file mode 100644
> index 17ecbf95ff15..000000000000
> --- a/drivers/misc/bmp085-spi.c
> +++ /dev/null
> @@ -1,79 +0,0 @@
> -/*
> - * Copyright (c) 2012  Bosch Sensortec GmbH
> - * Copyright (c) 2012  Unixphere AB
> - *
> - * This program is free software; you can redistribute it and/or =
modify
> - * it under the terms of the GNU General Public License as published =
by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> - */
> -
> -#include <linux/module.h>
> -#include <linux/spi/spi.h>
> -#include <linux/err.h>
> -#include "bmp085.h"
> -
> -static int bmp085_spi_probe(struct spi_device *client)
> -{
> -	int err;
> -	struct regmap *regmap;
> -
> -	client->bits_per_word =3D 8;
> -	err =3D spi_setup(client);
> -	if (err < 0) {
> -		dev_err(&client->dev, "spi_setup failed!\n");
> -		return err;
> -	}
> -
> -	regmap =3D devm_regmap_init_spi(client, &bmp085_regmap_config);
> -	if (IS_ERR(regmap)) {
> -		err =3D PTR_ERR(regmap);
> -		dev_err(&client->dev, "Failed to init regmap: %d\n", =
err);
> -		return err;
> -	}
> -
> -	return bmp085_probe(&client->dev, regmap, client->irq);
> -}
> -
> -static int bmp085_spi_remove(struct spi_device *client)
> -{
> -	return bmp085_remove(&client->dev);
> -}
> -
> -static const struct of_device_id bmp085_of_match[] =3D {
> -	{ .compatible =3D "bosch,bmp085", },
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(of, bmp085_of_match);
> -
> -static const struct spi_device_id bmp085_id[] =3D {
> -	{ "bmp180", 0 },
> -	{ "bmp181", 0 },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(spi, bmp085_id);
> -
> -static struct spi_driver bmp085_spi_driver =3D {
> -	.driver =3D {
> -		.name	=3D BMP085_NAME,
> -		.of_match_table =3D bmp085_of_match
> -	},
> -	.id_table	=3D bmp085_id,
> -	.probe		=3D bmp085_spi_probe,
> -	.remove		=3D bmp085_spi_remove
> -};
> -
> -module_spi_driver(bmp085_spi_driver);
> -
> -MODULE_AUTHOR("Eric Andersson <eric.andersson@unixphere.com>");
> -MODULE_DESCRIPTION("BMP085 SPI bus driver");
> -MODULE_LICENSE("GPL");
> diff --git a/drivers/misc/bmp085.c b/drivers/misc/bmp085.c
> deleted file mode 100644
> index 9b313f7810f5..000000000000
> --- a/drivers/misc/bmp085.c
> +++ /dev/null
> @@ -1,506 +0,0 @@
> -/*  Copyright (c) 2010  Christoph Mair <christoph.mair@gmail.com>
> - *  Copyright (c) 2012  Bosch Sensortec GmbH
> - *  Copyright (c) 2012  Unixphere AB
> - *
> - *  This driver supports the bmp085 and bmp18x digital barometric =
pressure
> - *  and temperature sensors from Bosch Sensortec. The datasheets
> - *  are available from their website:
> - *  =
http://www.bosch-sensortec.com/content/language1/downloads/BST-BMP085-DS00=
0-05.pdf
> - *  =
http://www.bosch-sensortec.com/content/language1/downloads/BST-BMP180-DS00=
0-07.pdf
> - *
> - *  A pressure measurement is issued by reading from pressure0_input.
> - *  The return value ranges from 30000 to 110000 pascal with a =
resulution
> - *  of 1 pascal (0.01 millibar) which enables measurements from 9000m =
above
> - *  to 500m below sea level.
> - *
> - *  The temperature can be read from temp0_input. Values range from
> - *  -400 to 850 representing the ambient temperature in degree =
celsius
> - *  multiplied by 10.The resolution is 0.1 celsius.
> - *
> - *  Because ambient pressure is temperature dependent, a temperature
> - *  measurement will be executed automatically even if the user is =
reading
> - *  from pressure0_input. This happens if the last temperature =
measurement
> - *  has been executed more then one second ago.
> - *
> - *  To decrease RMS noise from pressure measurements, the bmp085 can
> - *  autonomously calculate the average of up to eight samples. This =
is
> - *  set up by writing to the oversampling sysfs file. Accepted values
> - *  are 0, 1, 2 and 3. 2^x when x is the value written to this file
> - *  specifies the number of samples used to calculate the ambient =
pressure.
> - *  RMS noise is specified with six pascal (without averaging) and =
decreases
> - *  down to 3 pascal when using an oversampling setting of 3.
> - *
> - *  This program is free software; you can redistribute it and/or =
modify
> - *  it under the terms of the GNU General Public License as published =
by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, write to the Free Software
> - *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> - */
> -
> -#include <linux/module.h>
> -#include <linux/device.h>
> -#include <linux/slab.h>
> -#include <linux/of.h>
> -#include "bmp085.h"
> -#include <linux/interrupt.h>
> -#include <linux/completion.h>
> -#include <linux/gpio.h>
> -
> -#define BMP085_CHIP_ID			0x55
> -#define BMP085_CALIBRATION_DATA_START	0xAA
> -#define BMP085_CALIBRATION_DATA_LENGTH	11	/* 16 bit values =
*/
> -#define BMP085_CHIP_ID_REG		0xD0
> -#define BMP085_CTRL_REG			0xF4
> -#define BMP085_TEMP_MEASUREMENT		0x2E
> -#define BMP085_PRESSURE_MEASUREMENT	0x34
> -#define BMP085_CONVERSION_REGISTER_MSB	0xF6
> -#define BMP085_CONVERSION_REGISTER_LSB	0xF7
> -#define BMP085_CONVERSION_REGISTER_XLSB	0xF8
> -#define BMP085_TEMP_CONVERSION_TIME	5
> -
> -struct bmp085_calibration_data {
> -	s16 AC1, AC2, AC3;
> -	u16 AC4, AC5, AC6;
> -	s16 B1, B2;
> -	s16 MB, MC, MD;
> -};
> -
> -struct bmp085_data {
> -	struct	device *dev;
> -	struct  regmap *regmap;
> -	struct	mutex lock;
> -	struct	bmp085_calibration_data calibration;
> -	u8	oversampling_setting;
> -	u32	raw_temperature;
> -	u32	raw_pressure;
> -	u32	temp_measurement_period;
> -	unsigned long last_temp_measurement;
> -	u8	chip_id;
> -	s32	b6; /* calculated temperature correction coefficient */
> -	int	irq;
> -	struct	completion done;
> -};
> -
> -static irqreturn_t bmp085_eoc_isr(int irq, void *devid)
> -{
> -	struct bmp085_data *data =3D devid;
> -
> -	complete(&data->done);
> -
> -	return IRQ_HANDLED;
> -}
> -
> -static s32 bmp085_read_calibration_data(struct bmp085_data *data)
> -{
> -	u16 tmp[BMP085_CALIBRATION_DATA_LENGTH];
> -	struct bmp085_calibration_data *cali =3D &(data->calibration);
> -	s32 status =3D regmap_bulk_read(data->regmap,
> -				BMP085_CALIBRATION_DATA_START, (u8 =
*)tmp,
> -				(BMP085_CALIBRATION_DATA_LENGTH << 1));
> -	if (status < 0)
> -		return status;
> -
> -	cali->AC1 =3D  be16_to_cpu(tmp[0]);
> -	cali->AC2 =3D  be16_to_cpu(tmp[1]);
> -	cali->AC3 =3D  be16_to_cpu(tmp[2]);
> -	cali->AC4 =3D  be16_to_cpu(tmp[3]);
> -	cali->AC5 =3D  be16_to_cpu(tmp[4]);
> -	cali->AC6 =3D be16_to_cpu(tmp[5]);
> -	cali->B1 =3D be16_to_cpu(tmp[6]);
> -	cali->B2 =3D be16_to_cpu(tmp[7]);
> -	cali->MB =3D be16_to_cpu(tmp[8]);
> -	cali->MC =3D be16_to_cpu(tmp[9]);
> -	cali->MD =3D be16_to_cpu(tmp[10]);
> -	return 0;
> -}
> -
> -static s32 bmp085_update_raw_temperature(struct bmp085_data *data)
> -{
> -	u16 tmp;
> -	s32 status;
> -
> -	mutex_lock(&data->lock);
> -
> -	init_completion(&data->done);
> -
> -	status =3D regmap_write(data->regmap, BMP085_CTRL_REG,
> -			      BMP085_TEMP_MEASUREMENT);
> -	if (status < 0) {
> -		dev_err(data->dev,
> -			"Error while requesting temperature =
measurement.\n");
> -		goto exit;
> -	}
> -	wait_for_completion_timeout(&data->done, 1 + msecs_to_jiffies(
> -					    =
BMP085_TEMP_CONVERSION_TIME));
> -
> -	status =3D regmap_bulk_read(data->regmap, =
BMP085_CONVERSION_REGISTER_MSB,
> -				 &tmp, sizeof(tmp));
> -	if (status < 0) {
> -		dev_err(data->dev,
> -			"Error while reading temperature measurement =
result\n");
> -		goto exit;
> -	}
> -	data->raw_temperature =3D be16_to_cpu(tmp);
> -	data->last_temp_measurement =3D jiffies;
> -	status =3D 0;	/* everything ok, return 0 */
> -
> -exit:
> -	mutex_unlock(&data->lock);
> -	return status;
> -}
> -
> -static s32 bmp085_update_raw_pressure(struct bmp085_data *data)
> -{
> -	u32 tmp =3D 0;
> -	s32 status;
> -
> -	mutex_lock(&data->lock);
> -
> -	init_completion(&data->done);
> -
> -	status =3D regmap_write(data->regmap, BMP085_CTRL_REG,
> -			BMP085_PRESSURE_MEASUREMENT +
> -			(data->oversampling_setting << 6));
> -	if (status < 0) {
> -		dev_err(data->dev,
> -			"Error while requesting pressure =
measurement.\n");
> -		goto exit;
> -	}
> -
> -	/* wait for the end of conversion */
> -	wait_for_completion_timeout(&data->done, 1 + msecs_to_jiffies(
> -					2+(3 << =
data->oversampling_setting)));
> -	/* copy data into a u32 (4 bytes), but skip the first byte. */
> -	status =3D regmap_bulk_read(data->regmap, =
BMP085_CONVERSION_REGISTER_MSB,
> -				 ((u8 *)&tmp)+1, 3);
> -	if (status < 0) {
> -		dev_err(data->dev,
> -			"Error while reading pressure measurement =
results\n");
> -		goto exit;
> -	}
> -	data->raw_pressure =3D be32_to_cpu((tmp));
> -	data->raw_pressure >>=3D (8-data->oversampling_setting);
> -	status =3D 0;	/* everything ok, return 0 */
> -
> -exit:
> -	mutex_unlock(&data->lock);
> -	return status;
> -}
> -
> -/*
> - * This function starts the temperature measurement and returns the =
value
> - * in tenth of a degree celsius.
> - */
> -static s32 bmp085_get_temperature(struct bmp085_data *data, int =
*temperature)
> -{
> -	struct bmp085_calibration_data *cali =3D &data->calibration;
> -	long x1, x2;
> -	int status;
> -
> -	status =3D bmp085_update_raw_temperature(data);
> -	if (status < 0)
> -		goto exit;
> -
> -	x1 =3D ((data->raw_temperature - cali->AC6) * cali->AC5) >> 15;
> -	x2 =3D (cali->MC << 11) / (x1 + cali->MD);
> -	data->b6 =3D x1 + x2 - 4000;
> -	/* if NULL just update b6. Used for pressure only measurements =
*/
> -	if (temperature !=3D NULL)
> -		*temperature =3D (x1+x2+8) >> 4;
> -
> -exit:
> -	return status;
> -}
> -
> -/*
> - * This function starts the pressure measurement and returns the =
value
> - * in millibar. Since the pressure depends on the ambient =
temperature,
> - * a temperature measurement is executed according to the given =
temperature
> - * measurement period (default is 1 sec boundary). This period could =
vary
> - * and needs to be adjusted according to the sensor environment, i.e. =
if big
> - * temperature variations then the temperature needs to be read out =
often.
> - */
> -static s32 bmp085_get_pressure(struct bmp085_data *data, int =
*pressure)
> -{
> -	struct bmp085_calibration_data *cali =3D &data->calibration;
> -	s32 x1, x2, x3, b3;
> -	u32 b4, b7;
> -	s32 p;
> -	int status;
> -
> -	/* alt least every second force an update of the ambient =
temperature */
> -	if ((data->last_temp_measurement =3D=3D 0) ||
> -	    time_is_before_jiffies(data->last_temp_measurement + 1*HZ)) =
{
> -		status =3D bmp085_get_temperature(data, NULL);
> -		if (status < 0)
> -			return status;
> -	}
> -
> -	status =3D bmp085_update_raw_pressure(data);
> -	if (status < 0)
> -		return status;
> -
> -	x1 =3D (data->b6 * data->b6) >> 12;
> -	x1 *=3D cali->B2;
> -	x1 >>=3D 11;
> -
> -	x2 =3D cali->AC2 * data->b6;
> -	x2 >>=3D 11;
> -
> -	x3 =3D x1 + x2;
> -
> -	b3 =3D (((((s32)cali->AC1) * 4 + x3) << =
data->oversampling_setting) + 2);
> -	b3 >>=3D 2;
> -
> -	x1 =3D (cali->AC3 * data->b6) >> 13;
> -	x2 =3D (cali->B1 * ((data->b6 * data->b6) >> 12)) >> 16;
> -	x3 =3D (x1 + x2 + 2) >> 2;
> -	b4 =3D (cali->AC4 * (u32)(x3 + 32768)) >> 15;
> -
> -	b7 =3D ((u32)data->raw_pressure - b3) *
> -					(50000 >> =
data->oversampling_setting);
> -	p =3D ((b7 < 0x80000000) ? ((b7 << 1) / b4) : ((b7 / b4) * 2));
> -
> -	x1 =3D p >> 8;
> -	x1 *=3D x1;
> -	x1 =3D (x1 * 3038) >> 16;
> -	x2 =3D (-7357 * p) >> 16;
> -	p +=3D (x1 + x2 + 3791) >> 4;
> -
> -	*pressure =3D p;
> -
> -	return 0;
> -}
> -
> -/*
> - * This function sets the chip-internal oversampling. Valid values =
are 0..3.
> - * The chip will use 2^oversampling samples for internal averaging.
> - * This influences the measurement time and the accuracy; larger =
values
> - * increase both. The datasheet gives an overview on how measurement =
time,
> - * accuracy and noise correlate.
> - */
> -static void bmp085_set_oversampling(struct bmp085_data *data,
> -						unsigned char =
oversampling)
> -{
> -	if (oversampling > 3)
> -		oversampling =3D 3;
> -	data->oversampling_setting =3D oversampling;
> -}
> -
> -/*
> - * Returns the currently selected oversampling. Range: 0..3
> - */
> -static unsigned char bmp085_get_oversampling(struct bmp085_data =
*data)
> -{
> -	return data->oversampling_setting;
> -}
> -
> -/* sysfs callbacks */
> -static ssize_t set_oversampling(struct device *dev,
> -				struct device_attribute *attr,
> -				const char *buf, size_t count)
> -{
> -	struct bmp085_data *data =3D dev_get_drvdata(dev);
> -	unsigned long oversampling;
> -	int err =3D kstrtoul(buf, 10, &oversampling);
> -
> -	if (err =3D=3D 0) {
> -		mutex_lock(&data->lock);
> -		bmp085_set_oversampling(data, oversampling);
> -		mutex_unlock(&data->lock);
> -		return count;
> -	}
> -
> -	return err;
> -}
> -
> -static ssize_t show_oversampling(struct device *dev,
> -				 struct device_attribute *attr, char =
*buf)
> -{
> -	struct bmp085_data *data =3D dev_get_drvdata(dev);
> -
> -	return sprintf(buf, "%u\n", bmp085_get_oversampling(data));
> -}
> -static DEVICE_ATTR(oversampling, S_IWUSR | S_IRUGO,
> -					show_oversampling, =
set_oversampling);
> -
> -
> -static ssize_t show_temperature(struct device *dev,
> -				struct device_attribute *attr, char =
*buf)
> -{
> -	int temperature;
> -	int status;
> -	struct bmp085_data *data =3D dev_get_drvdata(dev);
> -
> -	status =3D bmp085_get_temperature(data, &temperature);
> -	if (status < 0)
> -		return status;
> -	else
> -		return sprintf(buf, "%d\n", temperature);
> -}
> -static DEVICE_ATTR(temp0_input, S_IRUGO, show_temperature, NULL);
> -
> -
> -static ssize_t show_pressure(struct device *dev,
> -			     struct device_attribute *attr, char *buf)
> -{
> -	int pressure;
> -	int status;
> -	struct bmp085_data *data =3D dev_get_drvdata(dev);
> -
> -	status =3D bmp085_get_pressure(data, &pressure);
> -	if (status < 0)
> -		return status;
> -	else
> -		return sprintf(buf, "%d\n", pressure);
> -}
> -static DEVICE_ATTR(pressure0_input, S_IRUGO, show_pressure, NULL);
> -
> -
> -static struct attribute *bmp085_attributes[] =3D {
> -	&dev_attr_temp0_input.attr,
> -	&dev_attr_pressure0_input.attr,
> -	&dev_attr_oversampling.attr,
> -	NULL
> -};
> -
> -static const struct attribute_group bmp085_attr_group =3D {
> -	.attrs =3D bmp085_attributes,
> -};
> -
> -int bmp085_detect(struct device *dev)
> -{
> -	struct bmp085_data *data =3D dev_get_drvdata(dev);
> -	unsigned int id;
> -	int ret;
> -
> -	ret =3D regmap_read(data->regmap, BMP085_CHIP_ID_REG, &id);
> -	if (ret < 0)
> -		return ret;
> -
> -	if (id !=3D data->chip_id)
> -		return -ENODEV;
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(bmp085_detect);
> -
> -static void bmp085_get_of_properties(struct bmp085_data *data)
> -{
> -#ifdef CONFIG_OF
> -	struct device_node *np =3D data->dev->of_node;
> -	u32 prop;
> -
> -	if (!np)
> -		return;
> -
> -	if (!of_property_read_u32(np, "chip-id", &prop))
> -		data->chip_id =3D prop & 0xff;
> -
> -	if (!of_property_read_u32(np, "temp-measurement-period", &prop))
> -		data->temp_measurement_period =3D (prop/100)*HZ;
> -
> -	if (!of_property_read_u32(np, "default-oversampling", &prop))
> -		data->oversampling_setting =3D prop & 0xff;
> -#endif
> -}
> -
> -static int bmp085_init_client(struct bmp085_data *data)
> -{
> -	int status =3D bmp085_read_calibration_data(data);
> -
> -	if (status < 0)
> -		return status;
> -
> -	/* default settings */
> -	data->chip_id =3D BMP085_CHIP_ID;
> -	data->last_temp_measurement =3D 0;
> -	data->temp_measurement_period =3D 1*HZ;
> -	data->oversampling_setting =3D 3;
> -
> -	bmp085_get_of_properties(data);
> -
> -	mutex_init(&data->lock);
> -
> -	return 0;
> -}
> -
> -struct regmap_config bmp085_regmap_config =3D {
> -	.reg_bits =3D 8,
> -	.val_bits =3D 8
> -};
> -EXPORT_SYMBOL_GPL(bmp085_regmap_config);
> -
> -int bmp085_probe(struct device *dev, struct regmap *regmap, int irq)
> -{
> -	struct bmp085_data *data;
> -	int err =3D 0;
> -
> -	data =3D kzalloc(sizeof(struct bmp085_data), GFP_KERNEL);
> -	if (!data) {
> -		err =3D -ENOMEM;
> -		goto exit;
> -	}
> -
> -	dev_set_drvdata(dev, data);
> -	data->dev =3D dev;
> -	data->regmap =3D regmap;
> -	data->irq =3D irq;
> -
> -	if (data->irq > 0) {
> -		err =3D devm_request_irq(dev, data->irq, bmp085_eoc_isr,
> -					      IRQF_TRIGGER_RISING, =
"bmp085",
> -					      data);
> -		if (err < 0)
> -			goto exit_free;
> -	}
> -
> -	/* Initialize the BMP085 chip */
> -	err =3D bmp085_init_client(data);
> -	if (err < 0)
> -		goto exit_free;
> -
> -	err =3D bmp085_detect(dev);
> -	if (err < 0) {
> -		dev_err(dev, "%s: chip_id failed!\n", BMP085_NAME);
> -		goto exit_free;
> -	}
> -
> -	/* Register sysfs hooks */
> -	err =3D sysfs_create_group(&dev->kobj, &bmp085_attr_group);
> -	if (err)
> -		goto exit_free;
> -
> -	dev_info(dev, "Successfully initialized %s!\n", BMP085_NAME);
> -
> -	return 0;
> -
> -exit_free:
> -	kfree(data);
> -exit:
> -	return err;
> -}
> -EXPORT_SYMBOL_GPL(bmp085_probe);
> -
> -int bmp085_remove(struct device *dev)
> -{
> -	struct bmp085_data *data =3D dev_get_drvdata(dev);
> -
> -	sysfs_remove_group(&data->dev->kobj, &bmp085_attr_group);
> -	kfree(data);
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(bmp085_remove);
> -
> -MODULE_AUTHOR("Christoph Mair <christoph.mair@gmail.com>");
> -MODULE_DESCRIPTION("BMP085 driver");
> -MODULE_LICENSE("GPL");
> diff --git a/drivers/misc/bmp085.h b/drivers/misc/bmp085.h
> deleted file mode 100644
> index 8b8e3b1f5ca5..000000000000
> --- a/drivers/misc/bmp085.h
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -/*
> - * Copyright (c) 2012  Bosch Sensortec GmbH
> - * Copyright (c) 2012  Unixphere AB
> - *
> - * This program is free software; you can redistribute it and/or =
modify
> - * it under the terms of the GNU General Public License as published =
by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> - */
> -
> -#ifndef _BMP085_H
> -#define _BMP085_H
> -
> -#include <linux/regmap.h>
> -
> -#define BMP085_NAME		"bmp085"
> -
> -extern struct regmap_config bmp085_regmap_config;
> -
> -int bmp085_probe(struct device *dev, struct regmap *regmap, int irq);
> -int bmp085_remove(struct device *dev);
> -int bmp085_detect(struct device *dev);
> -
> -#endif
> --=20
> 2.7.4
>=20

I am fine with it. We no longer config the driver.

BR and thanks,
Nikolaus=
