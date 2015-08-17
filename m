Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38907 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbbHQGlk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 17 Aug 2015 02:41:40 -0400
Date: Mon, 17 Aug 2015 08:41:36 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Paul Bolle <pebolle@tiscali.nl>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v3 6/6] iio: bmg160: Add SPI driver
Message-ID: <20150817064136.GG19600@pengutronix.de>
References: <1439391009-6051-1-git-send-email-mpa@pengutronix.de>
 <1439391009-6051-7-git-send-email-mpa@pengutronix.de>
 <alpine.DEB.2.02.1508121716430.13952@pmeerw.net>
 <55CF54BC.5030602@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mmKKm/GJ6Xc4oob8"
In-Reply-To: <55CF54BC.5030602@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--mmKKm/GJ6Xc4oob8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Aug 15, 2015 at 04:03:24PM +0100, Jonathan Cameron wrote:
> On 12/08/15 16:19, Peter Meerwald wrote:
> > On Wed, 12 Aug 2015, Markus Pargmann wrote:
> >=20
> >> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> >=20
> > the spelling of Bosch is inconsistent, sometimes it is BOSCH, I'd prefe=
r=20
> > the former
> >=20
> > please find a slightly more relevant comment below :)
> Another comment on the break up of modules you have here
> which is a bit odd and leads to two large modules instead
> of 1 large and 2 small (which I think would be preferable).

Thanks, I will fix that.

Best Regards,

Markus

>=20
> Jonathan
> >=20
> >> ---
> >>  drivers/iio/gyro/Kconfig      | 11 +++++++++
> >>  drivers/iio/gyro/Makefile     |  1 +
> >>  drivers/iio/gyro/bmg160_spi.c | 57 ++++++++++++++++++++++++++++++++++=
+++++++++
> >>  3 files changed, 69 insertions(+)
> >>  create mode 100644 drivers/iio/gyro/bmg160_spi.c
> >>
> >> diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
> >> index 13f8e0051615..a77dbb0062fe 100644
> >> --- a/drivers/iio/gyro/Kconfig
> >> +++ b/drivers/iio/gyro/Kconfig
> >> @@ -71,6 +71,17 @@ config BMG160_I2C
> >>  	  This driver can also be built as a module.  If so, the module
> >>  	  will be called bmg160_i2c.
> >> =20
> >> +config BMG160_SPI
> >> +	tristate "Driver for connection via SPI"
> >> +	depends on SPI
> >> +	select REGMAP_SPI
> >> +	help
> >> +	  Say yes here to build support for Bosch BMG160 Tri-axis Gyro Sensor
> >> +	  driver connected via SPI. This driver also supports BMI055 gyrosco=
pe.
> >> +
> >> +	  This driver can also be built as a module.  If so, the module
> >> +	  will be called bmg160_spi.
> >> +
> >>  endif
> >> =20
> >>  config HID_SENSOR_GYRO_3D
> >> diff --git a/drivers/iio/gyro/Makefile b/drivers/iio/gyro/Makefile
> >> index 73b41e43a974..848e55c605c0 100644
> >> --- a/drivers/iio/gyro/Makefile
> >> +++ b/drivers/iio/gyro/Makefile
> >> @@ -9,6 +9,7 @@ obj-$(CONFIG_ADIS16136) +=3D adis16136.o
> >>  obj-$(CONFIG_ADIS16260) +=3D adis16260.o
> >>  obj-$(CONFIG_ADXRS450) +=3D adxrs450.o
> >>  obj-$(CONFIG_BMG160_I2C) +=3D bmg160_core.o bmg160_i2c.o
> >> +obj-$(CONFIG_BMG160_I2C) +=3D bmg160_core.o bmg160_spi.o
> So if both are present (and most distros will build both) we will have
> the core stuff built twice?  I'd rather that was a separate module
> as is usually done for this sort of case.  See how the ST accelerometer
> driver does it (slightly more complex case)
> >> =20
> >>  obj-$(CONFIG_HID_SENSOR_GYRO_3D) +=3D hid-sensor-gyro-3d.o
> >> =20
> >> diff --git a/drivers/iio/gyro/bmg160_spi.c b/drivers/iio/gyro/bmg160_s=
pi.c
> >> new file mode 100644
> >> index 000000000000..8a358571b702
> >> --- /dev/null
> >> +++ b/drivers/iio/gyro/bmg160_spi.c
> >> @@ -0,0 +1,57 @@
> >> +#include <linux/spi/spi.h>
> >> +#include <linux/regmap.h>
> >> +#include <linux/iio/iio.h>
> >> +#include <linux/module.h>
> >> +
> >> +#include <bmg160.h>
> >=20
> > I think this should be
> > #include "bmg160.h"
> > as in the _i2c part of the driver
> >=20
> >> +
> >> +static const struct regmap_config bmg160_regmap_spi_conf =3D {
> >> +	.reg_bits =3D 8,
> >> +	.val_bits =3D 8,
> >> +	.max_register =3D 0x3f,
> >> +};
> >> +
> >> +static int bmg160_spi_probe(struct spi_device *spi)
> >> +{
> >> +	struct regmap *regmap;
> >> +	const struct spi_device_id *id =3D spi_get_device_id(spi);
> >> +
> >> +	regmap =3D devm_regmap_init_spi(spi, &bmg160_regmap_spi_conf);
> >> +	if (IS_ERR(regmap)) {
> >> +		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
> >> +			(int)PTR_ERR(regmap));
> >> +		return PTR_ERR(regmap);
> >> +	}
> >> +
> >> +	return bmg160_core_probe(&spi->dev, regmap, spi->irq, id->name);
> >> +}
> >> +
> >> +static int bmg160_spi_remove(struct spi_device *spi)
> >> +{
> >> +	bmg160_core_remove(&spi->dev);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static const struct spi_device_id bmg160_spi_id[] =3D {
> >> +	{"bmg160", 0},
> >> +	{"bmi055_gyro", 0},
> >> +	{}
> >> +};
> >> +
> >> +MODULE_DEVICE_TABLE(spi, bmg160_spi_id);
> >> +
> >> +static struct spi_driver bmg160_spi_driver =3D {
> >> +	.driver =3D {
> >> +		.name	=3D "bmg160_spi",
> >> +		.pm	=3D &bmg160_pm_ops,
> >> +	},
> >> +	.probe		=3D bmg160_spi_probe,
> >> +	.remove		=3D bmg160_spi_remove,
> >> +	.id_table	=3D bmg160_spi_id,
> >> +};
> >> +module_spi_driver(bmg160_spi_driver);
> >> +
> >> +MODULE_AUTHOR("Markus Pargmann <mpa@pengutronix.de>");
> >> +MODULE_LICENSE("GPL v2");
> >> +MODULE_DESCRIPTION("BMG160 SPI Gyro driver");
> >>
> >=20
>=20
>=20

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--mmKKm/GJ6Xc4oob8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV0YIfAAoJEEpcgKtcEGQQZMoQAJpCwvW0t7rHeu6t6aXeG3Ev
mQcX10Yu9Z2ZuhdK98JmrKRG0ZutuIWN2xRKWOCFXf7LuBiytfSJzu/N7Em+Txeo
lV3eejBgZdFWxvmp96pNuXehLDmeEkCMlIBUlHbKS7dRvP1QvSRMY95Jwv1EFnQF
zrUc9AnxT/ICrCW5Mhm/ZJrviQT7uVkG8nv/qx24nlVJEfhkw7Xc2BE+khmx8Lnm
vTE4rd531eakcf+jSjeIhSlrdaKAqeShch43chEv2Ng6RN26psnArmwT2LmyrHoE
z1Ua50ZQt0dK7GvI41WyvythJCKpT1Bqe+njCvNedu4OQXBmFW2/ZPwbXrNCsTk7
VQBNWX1/B0WupiMa+RKUjFnocsgFcc6omqY6s318kim9jsczqj2VJjZRkqgKLDdZ
eSEAejoV8rXy4Ckwd8PEJmcV8CQ+coct6Rm1c5fOxK4xxDB+bI1fLQxBZsEoc62j
Sjp5Xtk8DqMneBPOPzPTGK/r5El47ruh/DM8LDYXCd4MPMFUknqw6G+TKJHD2VtM
dl/HJUkUCwSnNfcLZhLPYpQvEq6rD2tDciXVpYTKckL8XMowqiQ7BsYktBZFCucz
3Iar+3TtPK35Adwzs8Iap1CQj2T7CyH975o//bTwij9KZmR2ijns4PMzoeX7a6l8
oSk0rdRFC6O1B2jg2hPm
=0Can
-----END PGP SIGNATURE-----

--mmKKm/GJ6Xc4oob8--
