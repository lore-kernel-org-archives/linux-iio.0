Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35250 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767AbbHQIDu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 17 Aug 2015 04:03:50 -0400
Date: Mon, 17 Aug 2015 10:03:44 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH 20/20] iio: bmc150: Add SPI driver
Message-ID: <20150817080344.GN19600@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-21-git-send-email-mpa@pengutronix.de>
 <55CF42E8.7070508@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u+ysBF3rEsnDrO5H"
In-Reply-To: <55CF42E8.7070508@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--u+ysBF3rEsnDrO5H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2015 at 02:47:20PM +0100, Jonathan Cameron wrote:
> On 12/08/15 11:12, Markus Pargmann wrote:
> > Add a simple SPI driver which initializes the spi regmap for the bmc150
> > core driver.
> >=20
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> 1 thing inline, plus the change of kconfig approach suggested for the
> previous patch.
>=20
> Otherwise, looks fine to me.
>=20
> Srinivas, over to you for the next version :) (unless you are feeling
> enthusiastic and want to take a look at this one)
> > ---
> >  drivers/iio/accel/Kconfig            | 10 +++++
> >  drivers/iio/accel/Makefile           |  1 +
> >  drivers/iio/accel/bmc150-accel-spi.c | 86 ++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 97 insertions(+)
> >  create mode 100644 drivers/iio/accel/bmc150-accel-spi.c
> >=20
> > diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> > index c63e981c38ff..bdb42069a767 100644
> > --- a/drivers/iio/accel/Kconfig
> > +++ b/drivers/iio/accel/Kconfig
> > @@ -40,6 +40,16 @@ config BMC150_ACCEL_I2C
> >  	  Say yes here to build support for I2C communication with the
> >  	  mentioned accelerometer.
> > =20
> > +config BMC150_ACCEL_SPI
> > +	tristate "SPI support"
> > +	depends on SPI
> > +	select IIO_BUFFER
> > +	select IIO_TRIGGERED_BUFFER
> > +	select REGMAP_SPI
> > +	help
> > +	  Say yes here to build support for SPI communication with the
> > +	  mentioned accelerometer.
> If you move to the config approach I suggested earlier, these options
> are hidden away avoiding the need for a help message ;)

Yes.

> > +
> >  endif
> > =20
> >  config HID_SENSOR_ACCEL_3D
> > diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> > index 5ef8bdbad092..e579e93bf022 100644
> > --- a/drivers/iio/accel/Makefile
> > +++ b/drivers/iio/accel/Makefile
> > @@ -6,6 +6,7 @@
> >  obj-$(CONFIG_BMA180) +=3D bma180.o
> >  obj-$(CONFIG_BMC150_ACCEL) +=3D bmc150-accel-core.o
> >  obj-$(CONFIG_BMC150_ACCEL_I2C) +=3D bmc150-accel-i2c.o
> > +obj-$(CONFIG_BMC150_ACCEL_SPI) +=3D bmc150-accel-spi.o
> >  obj-$(CONFIG_HID_SENSOR_ACCEL_3D) +=3D hid-sensor-accel-3d.o
> >  obj-$(CONFIG_KXCJK1013) +=3D kxcjk-1013.o
> >  obj-$(CONFIG_KXSD9)	+=3D kxsd9.o
> > diff --git a/drivers/iio/accel/bmc150-accel-spi.c b/drivers/iio/accel/b=
mc150-accel-spi.c
> > new file mode 100644
> > index 000000000000..c13fd2aa5f34
> > --- /dev/null
> > +++ b/drivers/iio/accel/bmc150-accel-spi.c
> > @@ -0,0 +1,86 @@
> > +/*
> > + * 3-axis accelerometer driver supporting following I2C Bosch-Sensorte=
c chips:
> Umm. Read the line above?  Spot the obvious minor point ;)

Oh yes. Thanks.

Best regards,

Markus

>=20
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
> > +#include <linux/module.h>
> > +#include <linux/acpi.h>
> > +#include <linux/regmap.h>
> > +#include <linux/spi/spi.h>
> > +
> > +#include "bmc150-accel.h"
> > +
> > +static const struct regmap_config bmc150_spi_regmap_conf =3D {
> > +	.reg_bits =3D 8,
> > +	.val_bits =3D 8,
> > +	.max_register =3D 0x3f,
> > +
> > +	.use_single_rw =3D false,
> > +	.cache_type =3D REGCACHE_NONE,
> > +};
> > +
> > +static int bmc150_accel_probe(struct spi_device *spi)
> > +{
> > +	struct regmap *regmap;
> > +	const struct spi_device_id *id =3D spi_get_device_id(spi);
> > +
> > +	regmap =3D devm_regmap_init_spi(spi, &bmc150_spi_regmap_conf);
> > +	if (IS_ERR(regmap)) {
> > +		dev_err(&spi->dev, "Failed to initialize spi regmap\n");
> > +		return PTR_ERR(regmap);
> > +	}
> > +
> > +	return bmc150_accel_core_probe(&spi->dev, regmap, spi->irq,
> > +				       id->name, id->driver_data, true);
> > +}
> > +
> > +static int bmc150_accel_remove(struct spi_device *spi)
> > +{
> > +	return bmc150_accel_core_remove(&spi->dev);
> > +}
> > +
> > +static const struct spi_device_id bmc150_accel_id[] =3D {
> > +	{"bmc150_accel",	bmc150},
> > +	{"bmi055_accel",	bmi055},
> > +	{"bma255",		bma255},
> > +	{"bma250e",		bma250e},
> > +	{"bma222e",		bma222e},
> > +	{"bma280",		bma280},
> > +	{}
> > +};
> > +
> > +MODULE_DEVICE_TABLE(spi, bmc150_accel_id);
> > +
> > +static struct spi_driver bmc150_accel_driver =3D {
> > +	.driver =3D {
> > +		.name	=3D "bmc150_accel_spi",
> > +		.acpi_match_table =3D ACPI_PTR(bmc150_accel_acpi_match),
> > +		.pm	=3D &bmc150_accel_pm_ops,
> > +	},
> > +	.probe		=3D bmc150_accel_probe,
> > +	.remove		=3D bmc150_accel_remove,
> > +	.id_table	=3D bmc150_accel_id,
> > +};
> > +module_spi_driver(bmc150_accel_driver);
> > +
> > +MODULE_AUTHOR("Markus Pargmann <mpa@pengutronix.de>");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_DESCRIPTION("BMC150 SPI accelerometer driver");
> >=20
>=20
>=20

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--u+ysBF3rEsnDrO5H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV0ZVgAAoJEEpcgKtcEGQQqMEP/jT7eq85wrcmELelj1tNbD6t
zH9P8Avd6/v8i2MwayPv3dMNYDn2CIprTu7hLjibNzBup5lg6qFbi2NN+njFmKqQ
TTEEpmgcDwT0hJPBRwa75Wp4D9QEUq8aCxY5tJ5pPXgRRjQa6OZdEp/iW2m5KRPS
KeHpMnOd1RIiIIjML1eT02/vDJnK7VvrOm9rNFa3h2d/WmxdU1zZVVAltKEqe8BS
tfUhi+ODf2xXGgn+X5KBREa6Hcoe9VpJq9hbasjnXqhenfzRZtqb770qAbo2ukck
jPzO5ae7B+ZorT9w00jUFmZ/MKTUskkBSCOPIrMZu6fLZxz1A/4XbXnbsYqRBuVw
DuFWayMsDAy5nqFKNo4gwkd1eFGr/JTmJ28A2whydQjkpUIulALzqrxKZoJG+pO8
ntQFgw4/vlJIT72cePMy+lnOKwjjdV/dsfDEtu9XKuuGBWXUf6WJ17j4BYCi9zcI
7fU2L1d3pN2DchDh5470GHTzOyJPuhvduVGMoMC4lsTAhqOI+UwdFgsjPcRxVEp0
XIuYYLSK3GBwuKbkh9g7jRvY4z22yS0rXlViXUt4hbiVVTSgCN1TshpIoIuCEwaZ
BYoWbnZ3pB6N5euaL81XUW8HcNCQFWSuS5v7EeraiM/zgD9rq3vjpMtcYHZNpA3H
qu8jxymqwjV46QdAt5+Z
=gMxG
-----END PGP SIGNATURE-----

--u+ysBF3rEsnDrO5H--
