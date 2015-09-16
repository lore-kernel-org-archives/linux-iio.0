Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60301 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900AbbIPKB2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Sep 2015 06:01:28 -0400
Date: Wed, 16 Sep 2015 12:01:19 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH v2 4/4] iio: bmc150: Add SPI driver
Message-ID: <20150916100119.GI1537@pengutronix.de>
References: <1440074986-28716-1-git-send-email-mpa@pengutronix.de>
 <1440074986-28716-5-git-send-email-mpa@pengutronix.de>
 <55E47E40.30207@kernel.org>
 <1441116657.3143.6.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S5HS5MvDw4DmbRmb"
In-Reply-To: <1441116657.3143.6.camel@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--S5HS5MvDw4DmbRmb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2015 at 07:10:57AM -0700, Srinivas Pandruvada wrote:
> On Mon, 2015-08-31 at 17:18 +0100, Jonathan Cameron wrote:
> > On 20/08/15 13:49, Markus Pargmann wrote:
> > > Add a simple SPI driver which initializes the spi regmap for the=20
> > > bmc150
> > > core driver.
> > >=20
> > > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > Looks good to me, but clearly will have to wait for the earlier
> > patches in the series.
> >=20
> > Nearly there!
> >=20
> > Jonathan
> > > ---
> > >  drivers/iio/accel/Kconfig            |  5 +++
> > >  drivers/iio/accel/Makefile           |  1 +
> > >  drivers/iio/accel/bmc150-accel-spi.c | 83=20
> > > ++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 89 insertions(+)
> > >  create mode 100644 drivers/iio/accel/bmc150-accel-spi.c
> > >=20
> > > diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> > > index 6da4eb0db57b..56d24fa3d34a 100644
> > > --- a/drivers/iio/accel/Kconfig
> > > +++ b/drivers/iio/accel/Kconfig
> > > @@ -23,6 +23,7 @@ config BMC150_ACCEL
> > >  	select IIO_TRIGGERED_BUFFER
> > >  	select REGMAP
> > >  	select BMC150_ACCEL_I2C if I2C
> > > +	select BMC150_ACCEL_SPI if SPI
> > >  	help
> > >  	  Say yes here to build support for the following Bosch=20
> > > accelerometers:
> > >  	  BMC150, BMI055, BMA250E, BMA222E, BMA255, BMA280.
> > > @@ -35,6 +36,10 @@ config BMC150_ACCEL_I2C
> > >  	tristate
> > >  	select REGMAP_I2C
> > > =20
> > > +config BMC150_ACCEL_SPI
> > > +	tristate
> > > +	select REGMAP_SPI
> > > +
> > >  config HID_SENSOR_ACCEL_3D
> > >  	depends on HID_SENSOR_HUB
> > >  	select IIO_BUFFER
> > > diff --git a/drivers/iio/accel/Makefile=20
> > > b/drivers/iio/accel/Makefile
> > > index 5ef8bdbad092..e579e93bf022 100644
> > > --- a/drivers/iio/accel/Makefile
> > > +++ b/drivers/iio/accel/Makefile
> > > @@ -6,6 +6,7 @@
> > >  obj-$(CONFIG_BMA180) +=3D bma180.o
> > >  obj-$(CONFIG_BMC150_ACCEL) +=3D bmc150-accel-core.o
> > >  obj-$(CONFIG_BMC150_ACCEL_I2C) +=3D bmc150-accel-i2c.o
> > > +obj-$(CONFIG_BMC150_ACCEL_SPI) +=3D bmc150-accel-spi.o
> > >  obj-$(CONFIG_HID_SENSOR_ACCEL_3D) +=3D hid-sensor-accel-3d.o
> > >  obj-$(CONFIG_KXCJK1013) +=3D kxcjk-1013.o
> > >  obj-$(CONFIG_KXSD9)	+=3D kxsd9.o
> > > diff --git a/drivers/iio/accel/bmc150-accel-spi.c=20
> > > b/drivers/iio/accel/bmc150-accel-spi.c
> > > new file mode 100644
> > > index 000000000000..1c2a4f683da4
> > > --- /dev/null
> > > +++ b/drivers/iio/accel/bmc150-accel-spi.c
> > > @@ -0,0 +1,83 @@
> > > +/*
> > > + * 3-axis accelerometer driver supporting following I2C Bosch
> > > -Sensortec chips:
> > > + *  - BMC150
> > > + *  - BMI055
> > > + *  - BMA255
> > > + *  - BMA250E
> > > + *  - BMA222E
> > > + *  - BMA280
> > > + *
> > > + * Copyright (c) 2014, Intel Corporation.
> > > + *
> > > + * This program is free software; you can redistribute it and/or=20
> > > modify it
> > > + * under the terms and conditions of the GNU General Public=20
> > > License,
> > > + * version 2, as published by the Free Software Foundation.
> > > + *
> > > + * This program is distributed in the hope it will be useful, but=20
> > > WITHOUT
> > > + * ANY WARRANTY; without even the implied warranty of=20
> > > MERCHANTABILITY or
> > > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public=20
> > > License for
> > > + * more details.
> > > + */
> Not sure If you want to carry Intel Copyright for SPI driver part. If
> you want to use change the year to 2015.

Thanks, will replace that.

Best Regards,

Markus

> > > +
> > > +#include <linux/device.h>
> > > +#include <linux/mod_devicetable.h>
> > > +#include <linux/module.h>
> > > +#include <linux/acpi.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/spi/spi.h>
> > > +
> > > +#include "bmc150-accel.h"
> > > +
> > > +static const struct regmap_config bmc150_spi_regmap_conf =3D {
> > > +	.reg_bits =3D 8,
> > > +	.val_bits =3D 8,
> > > +	.max_register =3D 0x3f,
> > > +};
> > > +
> > > +static int bmc150_accel_probe(struct spi_device *spi)
> > > +{
> > > +	struct regmap *regmap;
> > > +	const struct spi_device_id *id =3D spi_get_device_id(spi);
> > > +
> > > +	regmap =3D devm_regmap_init_spi(spi,=20
> > > &bmc150_spi_regmap_conf);
> > > +	if (IS_ERR(regmap)) {
> > > +		dev_err(&spi->dev, "Failed to initialize spi=20
> > > regmap\n");
> > > +		return PTR_ERR(regmap);
> > > +	}
> > > +
> > > +	return bmc150_accel_core_probe(&spi->dev, regmap, spi
> > > ->irq,
> > > +				       id->name, id->driver_data,=20
> > > true);
> > > +}
> > > +
> > > +static int bmc150_accel_remove(struct spi_device *spi)
> > > +{
> > > +	return bmc150_accel_core_remove(&spi->dev);
> > > +}
> > > +
> > > +static const struct spi_device_id bmc150_accel_id[] =3D {
> > > +	{"bmc150_accel",	bmc150},
> > > +	{"bmi055_accel",	bmi055},
> > > +	{"bma255",		bma255},
> > > +	{"bma250e",		bma250e},
> > > +	{"bma222e",		bma222e},
> > > +	{"bma280",		bma280},
> > > +	{}
> > > +};
> > > +
> > > +MODULE_DEVICE_TABLE(spi, bmc150_accel_id);
> > > +
> > > +static struct spi_driver bmc150_accel_driver =3D {
> > > +	.driver =3D {
> > > +		.name	=3D "bmc150_accel_spi",
> > > +		.acpi_match_table =3D=20
> > > ACPI_PTR(bmc150_accel_acpi_match),
> > > +		.pm	=3D &bmc150_accel_pm_ops,
> > > +	},
> > > +	.probe		=3D bmc150_accel_probe,
> > > +	.remove		=3D bmc150_accel_remove,
> > > +	.id_table	=3D bmc150_accel_id,
> > > +};
> > > +module_spi_driver(bmc150_accel_driver);
> > > +
> > > +MODULE_AUTHOR("Markus Pargmann <mpa@pengutronix.de>");
> > > +MODULE_LICENSE("GPL v2");
> > > +MODULE_DESCRIPTION("BMC150 SPI accelerometer driver");
> > >=20
> >=20
>=20

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--S5HS5MvDw4DmbRmb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV+T3uAAoJEEpcgKtcEGQQSEkP/itDVOUfASIeokNDRVierhrt
+pAROHhe/MdiW2spYN1/GcBk9NkMkt1SsJTa7cTtEuzdr060hVGI+vuTxYrIZyCC
Ng2H5R4+QoDF9p6Tlpl3wum4YE0/sqtN0c+WH/dX7CafIgVrgoK/NtVZQEd/4xgI
fud+9DYOchBMCacPV6fV3hQcs2dez8g74X2rYOlYLyW+JBHWrddjrAil0kZxtMFT
A66U3XoEJwXsFRERf/fVWCPPA+07XXY9aCZfPD6D1nLgj0OTSZ6v1fnswUtH+0Le
uqicd5lrJiMncUB8VqxV9vnWsypmdR4G5L516tRltrGyYKNMvazJBEAQS6thLx6m
20rbs+9bRmHF/c1C1FouftZuxS46IaIFkUGlVqUyfZGBk3bjWc2MY7h6Jv5AAs/x
Cfzo4j4LHkObHANajwRc9Lgq76wYWva69Git5SPFmFBmI+X4rj3i/vdddAeXbZdz
E12rKxqCKtMJcQw4lYTaezHIQqE7NlJ0LECQLB0UOFHYJdPczh8ckRPff2FtezQb
3dZMbswbQUqrqRAXij6XHCVAl/0DM08TB9QtQqa6/j6nrGm74PbwS60AnOzACl0b
6P9NRIMAM6bqu01k6PGW/XmzCx9ud+ib8iTqLiuCAHl2cad+GpxPCwf8ZYFwDL2N
TzA8S1YuaZSF5huIKvan
=Gwgq
-----END PGP SIGNATURE-----

--S5HS5MvDw4DmbRmb--
