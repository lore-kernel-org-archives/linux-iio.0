Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36987 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbbHQH7u (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 17 Aug 2015 03:59:50 -0400
Date: Mon, 17 Aug 2015 09:59:44 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH 19/20] iio: bmc150: Split the driver into core and i2c
Message-ID: <20150817075944.GL19600@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-20-git-send-email-mpa@pengutronix.de>
 <55CF4189.6050402@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cmxQ2a0XYZsSJXeB"
In-Reply-To: <55CF4189.6050402@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--cmxQ2a0XYZsSJXeB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2015 at 02:41:29PM +0100, Jonathan Cameron wrote:
> On 12/08/15 11:12, Markus Pargmann wrote:
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> There are a few bits in here following through from earlier
> patches that I haven't bothered mentioning as you'll have fixed
> them already before this split patch).
>=20
> Two more bits inline.  Nothing major though.
>=20
> Jonathan
> > ---
> >  drivers/iio/accel/Kconfig                          |  22 +++--
> >  drivers/iio/accel/Makefile                         |   3 +-
> >  .../accel/{bmc150-accel.c =3D> bmc150-accel-core.c}  |  95 ++++-------=
--------
> >  drivers/iio/accel/bmc150-accel-i2c.c               | 101 +++++++++++++=
++++++++
> >  drivers/iio/accel/bmc150-accel.h                   |  21 +++++
> >  5 files changed, 156 insertions(+), 86 deletions(-)
> >  rename drivers/iio/accel/{bmc150-accel.c =3D> bmc150-accel-core.c} (95=
%)
> >  create mode 100644 drivers/iio/accel/bmc150-accel-i2c.c
> >  create mode 100644 drivers/iio/accel/bmc150-accel.h
> >=20
> > diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> > index 01dd03d194d1..c63e981c38ff 100644
> > --- a/drivers/iio/accel/Kconfig
> > +++ b/drivers/iio/accel/Kconfig
> > @@ -18,22 +18,30 @@ config BMA180
> >  	  module will be called bma180.
> > =20
> >  config BMC150_ACCEL
> > -	tristate "Bosch BMC150 Accelerometer Driver"
> > -	depends on I2C
> > -	select IIO_BUFFER
> > -	select IIO_TRIGGERED_BUFFER
> > +	bool "Bosch BMC150 Accelerometer Driver"
> >  	select REGMAP
> > -	select REGMAP_I2C
> >  	help
> >  	  Say yes here to build support for the following Bosch accelerometer=
s:
> >  	  BMC150, BMI055, BMA250E, BMA222E, BMA255, BMA280.
> > =20
> > -	  Currently this only supports the device via an i2c interface.
> > -
> >  	  This is a combo module with both accelerometer and magnetometer.
> >  	  This driver is only implementing accelerometer part, which has
> >  	  its own address and register map.
> This approach does lead to a proliferation of complexity (to the
> person configuring the kernel build).  I prefer the approach the
> ST accel driver for example takes, in which the SPI or I2C drivers
> are built depending on whether the relevant dependencies are present
> and the core driver is selected.

Yes. I will fix this the same way as the other series (bmg160).

> > =20
> > +if BMC150_ACCEL
> > +
> > +config BMC150_ACCEL_I2C
> > +	tristate "I2C support"
> > +	depends on I2C
> > +	select IIO_BUFFER
> > +	select IIO_TRIGGERED_BUFFER
> > +	select REGMAP_I2C
> > +	help
> > +	  Say yes here to build support for I2C communication with the
> > +	  mentioned accelerometer.
> > +
> > +endif
> > +
> >  config HID_SENSOR_ACCEL_3D
> >  	depends on HID_SENSOR_HUB
> >  	select IIO_BUFFER
> > diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> > index ebd2675b2a02..5ef8bdbad092 100644
> > --- a/drivers/iio/accel/Makefile
> > +++ b/drivers/iio/accel/Makefile
> > @@ -4,7 +4,8 @@
> > =20
> >  # When adding new entries keep the list in alphabetical order
> >  obj-$(CONFIG_BMA180) +=3D bma180.o
> > -obj-$(CONFIG_BMC150_ACCEL) +=3D bmc150-accel.o
> > +obj-$(CONFIG_BMC150_ACCEL) +=3D bmc150-accel-core.o
> > +obj-$(CONFIG_BMC150_ACCEL_I2C) +=3D bmc150-accel-i2c.o
> >  obj-$(CONFIG_HID_SENSOR_ACCEL_3D) +=3D hid-sensor-accel-3d.o
> >  obj-$(CONFIG_KXCJK1013) +=3D kxcjk-1013.o
> >  obj-$(CONFIG_KXSD9)	+=3D kxsd9.o
> > diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc15=
0-accel-core.c
> > similarity index 95%
> > rename from drivers/iio/accel/bmc150-accel.c
> > rename to drivers/iio/accel/bmc150-accel-core.c
> > index d75e1b0aa7e9..8cf2786dd433 100644
> > --- a/drivers/iio/accel/bmc150-accel.c
> > +++ b/drivers/iio/accel/bmc150-accel-core.c
> > @@ -37,6 +37,8 @@
> >  #include <linux/iio/triggered_buffer.h>
> >  #include <linux/regmap.h>
> > =20
> > +#include "bmc150-accel.h"
> > +
> >  #define BMC150_ACCEL_DRV_NAME			"bmc150_accel"
> >  #define BMC150_ACCEL_IRQ_NAME			"bmc150_accel_event"
> >  #define BMC150_ACCEL_GPIO_NAME			"bmc150_accel_int"
> > @@ -187,7 +189,6 @@ enum bmc150_accel_trigger_id {
> >  struct bmc150_accel_data {
> >  	struct regmap *regmap;
> >  	struct device *dev;
> At least from how diff is listing it, looks like you've just
> moved this down the struct?  Why?

No reason, will fix it.

Thanks,

Markus

> > -	int irq;
> >  	struct bmc150_accel_interrupt interrupts[BMC150_ACCEL_INTERRUPTS];
> >  	atomic_t active_intr;
> >  	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
> > @@ -201,6 +202,7 @@ struct bmc150_accel_data {
> >  	int ev_enable_state;
> >  	int64_t timestamp, old_timestamp; /* Only used in hw fifo mode. */
> >  	const struct bmc150_accel_chip_info *chip_info;
> > +	int irq;
> >  };
> > =20
> >  static const struct {
> > @@ -1076,15 +1078,6 @@ static const struct iio_chan_spec bmc150_accel_c=
hannels[] =3D
> >  static const struct iio_chan_spec bma280_accel_channels[] =3D
> >  	BMC150_ACCEL_CHANNELS(14);
> > =20
> > -enum {
> > -	bmc150,
> > -	bmi055,
> > -	bma255,
> > -	bma250e,
> > -	bma222e,
> > -	bma280,
> > -};
> > -
> >  static const struct bmc150_accel_chip_info bmc150_accel_chip_info_tbl[=
] =3D {
> >  	[bmc150] =3D {
> >  		.chip_id =3D 0xFA,
> > @@ -1573,36 +1566,22 @@ static const struct iio_buffer_setup_ops bmc150=
_accel_buffer_ops =3D {
> >  	.postdisable =3D bmc150_accel_buffer_postdisable,
> >  };
> > =20
> > -static int bmc150_accel_probe(struct i2c_client *client,
> > -			      const struct i2c_device_id *id)
> > +int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap,=
 int irq,
> > +			    const char *name, int chip_id, bool block_supported)
> >  {
> >  	struct bmc150_accel_data *data;
> >  	struct iio_dev *indio_dev;
> >  	int ret;
> > -	const char *name =3D NULL;
> > -	int chip_id =3D 0;
> > -	struct device *dev;
> > =20
> > -	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
> > +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> >  	if (!indio_dev)
> >  		return -ENOMEM;
> > =20
> >  	data =3D iio_priv(indio_dev);
> > -	i2c_set_clientdata(client, indio_dev);
> > -	data->dev =3D &client->dev;
> > -	dev =3D &client->dev;
> > -	data->irq =3D client->irq;
> > -
> > -	data->regmap =3D devm_regmap_init_i2c(client, &bmc150_i2c_regmap_conf=
);
> > -	if (IS_ERR(data->regmap)) {
> > -		dev_err(dev, "Failed to initialize i2c regmap\n");
> > -		return PTR_ERR(data->regmap);
> > -	}
> > -
> > -	if (id) {
> > -		name =3D id->name;
> > -		chip_id =3D id->driver_data;
> > -	}
> > +	dev_set_drvdata(dev, indio_dev);
> > +	data->dev =3D dev;
> > +	data->irq =3D irq;
> > +	data->regmap =3D regmap;
> > =20
> >  	if (ACPI_HANDLE(dev))
> >  		name =3D bmc150_accel_match_acpi_device(dev, &chip_id);
> > @@ -1664,9 +1643,7 @@ static int bmc150_accel_probe(struct i2c_client *=
client,
> >  		if (ret)
> >  			goto err_buffer_cleanup;
> > =20
> > -		if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C) ||
> > -		    i2c_check_functionality(client->adapter,
> > -					    I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
> > +		if (block_supported) {
> >  			indio_dev->modes |=3D INDIO_BUFFER_SOFTWARE;
> >  			indio_dev->info =3D &bmc150_accel_info_fifo;
> >  			indio_dev->buffer->attrs =3D bmc150_accel_fifo_attributes;
> > @@ -1675,7 +1652,7 @@ static int bmc150_accel_probe(struct i2c_client *=
client,
> > =20
> >  	ret =3D iio_device_register(indio_dev);
> >  	if (ret < 0) {
> > -		dev_err(data->dev, "Unable to register iio device\n");
> > +		dev_err(dev, "Unable to register iio device\n");
> >  		goto err_trigger_unregister;
> >  	}
> > =20
> > @@ -1698,10 +1675,11 @@ err_buffer_cleanup:
> > =20
> >  	return ret;
> >  }
> > +EXPORT_SYMBOL_GPL(bmc150_accel_core_probe);
> > =20
> > -static int bmc150_accel_remove(struct i2c_client *client)
> > +int bmc150_accel_core_remove(struct device *dev)
> >  {
> > -	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
> > +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> >  	struct bmc150_accel_data *data =3D iio_priv(indio_dev);
> > =20
> >  	pm_runtime_disable(data->dev);
> > @@ -1720,6 +1698,7 @@ static int bmc150_accel_remove(struct i2c_client =
*client)
> > =20
> >  	return 0;
> >  }
> > +EXPORT_SYMBOL_GPL(bmc150_accel_core_remove);
> > =20
> >  #ifdef CONFIG_PM_SLEEP
> >  static int bmc150_accel_suspend(struct device *dev)
> > @@ -1790,48 +1769,8 @@ static int bmc150_accel_runtime_resume(struct de=
vice *dev)
> >  }
> >  #endif
> > =20
> > -static const struct dev_pm_ops bmc150_accel_pm_ops =3D {
> > +const struct dev_pm_ops bmc150_accel_pm_ops =3D {
> >  	SET_SYSTEM_SLEEP_PM_OPS(bmc150_accel_suspend, bmc150_accel_resume)
> >  	SET_RUNTIME_PM_OPS(bmc150_accel_runtime_suspend,
> >  			   bmc150_accel_runtime_resume, NULL)
> >  };
> > -
> > -static const struct acpi_device_id bmc150_accel_acpi_match[] =3D {
> > -	{"BSBA0150",	bmc150},
> > -	{"BMC150A",	bmc150},
> > -	{"BMI055A",	bmi055},
> > -	{"BMA0255",	bma255},
> > -	{"BMA250E",	bma250e},
> > -	{"BMA222E",	bma222e},
> > -	{"BMA0280",	bma280},
> > -	{ },
> > -};
> > -MODULE_DEVICE_TABLE(acpi, bmc150_accel_acpi_match);
> > -
> > -static const struct i2c_device_id bmc150_accel_id[] =3D {
> > -	{"bmc150_accel",	bmc150},
> > -	{"bmi055_accel",	bmi055},
> > -	{"bma255",		bma255},
> > -	{"bma250e",		bma250e},
> > -	{"bma222e",		bma222e},
> > -	{"bma280",		bma280},
> > -	{}
> > -};
> > -
> > -MODULE_DEVICE_TABLE(i2c, bmc150_accel_id);
> > -
> > -static struct i2c_driver bmc150_accel_driver =3D {
> > -	.driver =3D {
> > -		.name	=3D BMC150_ACCEL_DRV_NAME,
> > -		.acpi_match_table =3D ACPI_PTR(bmc150_accel_acpi_match),
> > -		.pm	=3D &bmc150_accel_pm_ops,
> > -	},
> > -	.probe		=3D bmc150_accel_probe,
> > -	.remove		=3D bmc150_accel_remove,
> > -	.id_table	=3D bmc150_accel_id,
> > -};
> > -module_i2c_driver(bmc150_accel_driver);
> > -
> > -MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.co=
m>");
> > -MODULE_LICENSE("GPL v2");
> > -MODULE_DESCRIPTION("BMC150 accelerometer driver");
> > diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/b=
mc150-accel-i2c.c
> > new file mode 100644
> > index 000000000000..7e036e2eb077
> > --- /dev/null
> > +++ b/drivers/iio/accel/bmc150-accel-i2c.c
> > @@ -0,0 +1,101 @@
> > +/*
> > + * 3-axis accelerometer driver supporting following I2C Bosch-Sensorte=
c chips:
> > + *  - BMC150
> > + *  - BMI055
> > + *  - BMA255
> > + *  - BMA250E
> > + *  - BMA222E
> > + *  - BMA280
> > + *
> > + * Copyright (c) 2014, Intel Corporation.
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y it
> > + * under the terms and conditions of the GNU General Public License,
> > + * version 2, as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope it will be useful, but WITH=
OUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Licen=
se for
> > + * more details.
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/i2c.h>
> > +#include <linux/module.h>
> > +#include <linux/acpi.h>
> > +#include <linux/regmap.h>
> > +
> > +#include "bmc150-accel.h"
> > +
> > +static const struct regmap_config bmc150_i2c_regmap_conf =3D {
> > +	.reg_bits =3D 8,
> > +	.val_bits =3D 8,
> > +
> > +	.use_single_rw =3D true,
> > +	.cache_type =3D REGCACHE_NONE,
> > +};
> > +
> > +static int bmc150_accel_probe(struct i2c_client *client,
> > +			      const struct i2c_device_id *id)
> > +{
> > +	struct regmap *regmap;
> > +	bool block_supported =3D
> > +		i2c_check_functionality(client->adapter, I2C_FUNC_I2C) ||
> > +		i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_I2C_BLO=
CK);
> > +
> > +	regmap =3D devm_regmap_init_i2c(client, &bmc150_i2c_regmap_conf);
> > +	if (IS_ERR(regmap)) {
> > +		dev_err(&client->dev, "Failed to initialize i2c regmap\n");
> > +		return PTR_ERR(regmap);
> > +	}
> > +
> > +	return bmc150_accel_core_probe(&client->dev, regmap, client->irq,
> > +				       id->name, id->driver_data,
> > +				       block_supported);
> > +}
> > +
> > +static int bmc150_accel_remove(struct i2c_client *client)
> > +{
> > +	return bmc150_accel_core_remove(&client->dev);
> > +}
> > +
> > +static const struct acpi_device_id bmc150_accel_acpi_match[] =3D {
> > +	{"BSBA0150",	bmc150},
> > +	{"BMC150A",	bmc150},
> > +	{"BMI055A",	bmi055},
> > +	{"BMA0255",	bma255},
> > +	{"BMA250E",	bma250e},
> > +	{"BMA222E",	bma222e},
> > +	{"BMA0280",	bma280},
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(acpi, bmc150_accel_acpi_match);
> > +
> > +static const struct i2c_device_id bmc150_accel_id[] =3D {
> > +	{"bmc150_accel",	bmc150},
> > +	{"bmi055_accel",	bmi055},
> > +	{"bma255",		bma255},
> > +	{"bma250e",		bma250e},
> > +	{"bma222e",		bma222e},
> > +	{"bma280",		bma280},
> > +	{}
> > +};
> > +
> > +MODULE_DEVICE_TABLE(i2c, bmc150_accel_id);
> > +
> > +static struct i2c_driver bmc150_accel_driver =3D {
> > +	.driver =3D {
> > +		.name	=3D "bmc150_accel_i2c",
> > +		.acpi_match_table =3D ACPI_PTR(bmc150_accel_acpi_match),
> > +		.pm	=3D &bmc150_accel_pm_ops,
> > +	},
> > +	.probe		=3D bmc150_accel_probe,
> > +	.remove		=3D bmc150_accel_remove,
> > +	.id_table	=3D bmc150_accel_id,
> > +};
> > +module_i2c_driver(bmc150_accel_driver);
> > +
> > +MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.co=
m>");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_DESCRIPTION("BMC150 I2C accelerometer driver");
> > diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc15=
0-accel.h
> > new file mode 100644
> > index 000000000000..988b57573d0c
> > --- /dev/null
> > +++ b/drivers/iio/accel/bmc150-accel.h
> > @@ -0,0 +1,21 @@
> > +#ifndef _BMC150_ACCEL_H_
> > +#define _BMC150_ACCEL_H_
> > +
> > +struct regmap;
> > +
> > +enum {
> > +	bmc150,
> > +	bmi055,
> > +	bma255,
> > +	bma250e,
> > +	bma222e,
> > +	bma280,
> > +};
> > +
> > +int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap,=
 int irq,
> > +			    const char *name, int chip_id,
> > +			    bool block_supported);
> > +int bmc150_accel_core_remove(struct device *dev);
> > +extern const struct dev_pm_ops bmc150_accel_pm_ops;
> > +
> > +#endif  /* _BMC150_ACCEL_H_ */
> >=20
>=20
>=20

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--cmxQ2a0XYZsSJXeB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV0ZRwAAoJEEpcgKtcEGQQYgMP/A7MytuXA3xQ+ml9mVwpGElh
rb6dQQyEtCCMI7ZOk80hsbxxMB/AGgEv3FLY+rEPoYPE1E9X3+F8NAs7XebGJHe2
zCeYnDUvUOHvO1qHxQugeDuSkMV7gduvtSzBbgboEbkj3Sr8R6YRV/1NKLESonft
JN+loYaI0p3l1vjck12Xd62yU9XPivDhxJ/QBgunSlAVqR3R1/yqF0ukXtq0lpwY
RbcAbggdbnoj0SuERti2QMHfyS5eP8ochtfMdoMhAzyUPI4nyKo+jlvEqUGLr8ij
oIwztGZh16jMtymYsYSXkMvBVDWu23ssfSmJrV4ci+fMId/mnOGvRPAVCihuqj32
Ar7oh1FnDniB6meAJIDIFX0MXLkb0MLvucgqHzzM7jotxbHzKxN8wnd8Wu4TfjNv
pTGx9S5g466zch7yMhBeoTbJ8PmBN5Z1psbFODXYUR9TM9h6G5wrGWjpXWlq+1nT
6LXdVCv6NjVkzVxS1MOuGfh7VakYtgjyZ7V4VeAIq20QXwYegPIx5dRibU0rtr9e
UNEmKXcG0RgKFfY/iC/ltWXs5fYSZ4BAa0+AOEP+w5qX7mBv1RuyQmrmN43bhWjN
3LSGqdrM9xR5XcY34/9npKZDZ91b1T51O97P5ebd7mcGyWVynjV3LJlLghZHNHNJ
WN/gFYWM5S/BzK4cg0VN
=SZQL
-----END PGP SIGNATURE-----

--cmxQ2a0XYZsSJXeB--
