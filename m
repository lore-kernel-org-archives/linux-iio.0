Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38226 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbbHJNiK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 10 Aug 2015 09:38:10 -0400
Date: Mon, 10 Aug 2015 15:38:02 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vlad Dogaru <vlad.dogaru@intel.com>,
	Paul Bolle <pebolle@tiscali.nl>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2 6/6] iio: bmg160: Add SPI driver
Message-ID: <20150810133802.GY19600@pengutronix.de>
References: <1438686179-18635-1-git-send-email-mpa@pengutronix.de>
 <1438686179-18635-7-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Th5JPit8I3Q6/gDv"
In-Reply-To: <1438686179-18635-7-git-send-email-mpa@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--Th5JPit8I3Q6/gDv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 04, 2015 at 01:02:59PM +0200, Markus Pargmann wrote:
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  drivers/iio/gyro/Kconfig      | 11 ++++++++
>  drivers/iio/gyro/Makefile     |  1 +
>  drivers/iio/gyro/bmg160_spi.c | 60 +++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 72 insertions(+)
>  create mode 100644 drivers/iio/gyro/bmg160_spi.c
>=20
> diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
> index 1e6cfff5546f..420aea844216 100644
> --- a/drivers/iio/gyro/Kconfig
> +++ b/drivers/iio/gyro/Kconfig
> @@ -72,6 +72,17 @@ config BMG160_I2C
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called bmg160_i2c.
> =20
> +config BMG160_SPI
> +	tristate "Driver for connection via SPI"
> +	depends on SPI
> +	select REGMAP_SPI
> +	help
> +	  Say yes here to build support for Bosch BMG160 Tri-axis Gyro Sensor
> +	  driver connected via SPI. This driver also supports BMI055 gyroscope.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called bmg160_spi.
> +
>  endif
> =20
>  config HID_SENSOR_GYRO_3D
> diff --git a/drivers/iio/gyro/Makefile b/drivers/iio/gyro/Makefile
> index 608401041550..f866a4be0667 100644
> --- a/drivers/iio/gyro/Makefile
> +++ b/drivers/iio/gyro/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_ADIS16260) +=3D adis16260.o
>  obj-$(CONFIG_ADXRS450) +=3D adxrs450.o
>  obj-$(CONFIG_BMG160) +=3D bmg160_core.o
>  obj-$(CONFIG_BMG160_I2C) +=3D bmg160_i2c.o
> +obj-$(CONFIG_BMG160_SPI) +=3D bmg160_spi.o
> =20
>  obj-$(CONFIG_HID_SENSOR_GYRO_3D) +=3D hid-sensor-gyro-3d.o
> =20
> diff --git a/drivers/iio/gyro/bmg160_spi.c b/drivers/iio/gyro/bmg160_spi.c
> new file mode 100644
> index 000000000000..4dcef65f3476
> --- /dev/null
> +++ b/drivers/iio/gyro/bmg160_spi.c
> @@ -0,0 +1,60 @@
> +#include <linux/spi/spi.h>
> +#include <linux/regmap.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +
> +#include <bmg160.h>
> +
> +static const struct regmap_config bmg160_regmap_spi_conf =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.read_flag_mask =3D 0x80,

This read_flag_mask seems to be the default for spi. The regmap spi bus
driver already defines this so it is not necessary here, will remove it.

Best regards,

Markus

> +
> +	.use_single_rw =3D true,
> +	.cache_type =3D REGCACHE_NONE,
> +};
> +
> +static int bmg160_spi_probe(struct spi_device *spi)
> +{
> +	struct regmap *regmap;
> +	const struct spi_device_id *id =3D spi_get_device_id(spi);
> +
> +	regmap =3D devm_regmap_init_spi(spi, &bmg160_regmap_spi_conf);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
> +			(int)PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +
> +	return bmg160_core_probe(&spi->dev, regmap, spi->irq, id->name);
> +}
> +
> +static int bmg160_spi_remove(struct spi_device *spi)
> +{
> +	bmg160_core_remove(&spi->dev);
> +
> +	return 0;
> +}
> +
> +static const struct spi_device_id bmg160_spi_id[] =3D {
> +	{"bmg160", 0},
> +	{"bmi055_gyro", 0},
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(spi, bmg160_spi_id);
> +
> +static struct spi_driver bmg160_spi_driver =3D {
> +	.driver =3D {
> +		.name	=3D "bmg160_spi",
> +		.pm	=3D &bmg160_pm_ops,
> +	},
> +	.probe		=3D bmg160_spi_probe,
> +	.remove		=3D bmg160_spi_remove,
> +	.id_table	=3D bmg160_spi_id,
> +};
> +module_spi_driver(bmg160_spi_driver);
> +
> +MODULE_AUTHOR("Markus Pargmann <mpa@pengutronix.de>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("BMG160 SPI Gyro driver");
> --=20
> 2.1.4
>=20
>=20
>=20

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--Th5JPit8I3Q6/gDv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVyKk6AAoJEEpcgKtcEGQQXL0P/0r0OCMN7sI0gYqALPaaYMU2
uRzHUbEiDAd5ySEC+hC8usA6VRYTqvvIOZcisKaoI0jA+IQj9HzjifRHyHWuQ3Tj
o3quOd1My00/UANoMkBIEWDpLzied1mmjHszA9aeCOGq6zVPXRI6Cz0hb9bEvrsy
jhiLJ4KF1dw2eanm5oJzDn/3lxaWo/4FHSkjUogFOtJNonFJewDQ1wuGB71dC3dB
7GWMrPVTbQdfpfFJJf2Xmm6qx/XOe9WBRwqA2tB4xmA8ZciDVKSBNnmWogDK5IUk
mznZVLRyVwNDwdlLGH4PsZUU3ICpjE5+2XXJETA1O4k3INzTnKK11x1+h+ICS2lI
R/fnpBrtLj+8SiqKTOo1EXykUJdK8zm/sdfhXG6cKUjb766davNA7dYzObX5sUUS
OX9y39kXRXlKV/btmxLAzxasKjEAt/sbRCZLdMG2G/rrLZhP+j0BVh8Oxkoq8Lo8
yGwCNImNiYP1YaK8TNnYeHv46xvU+/pfZd1WSt9M6j//BONtzfBf0RCbbNZIBDoE
AH5x+WCHFyd14itCzE73rN5ANCq8UblziQqpWZVH15j5N8siwMo8XBVPo9Z9nwXB
4+P8RE61m9Yqv1WXxTUe/MibndDvYiukoSfojZuT4MHt1T2gvu14rAhUHSxMu/Vj
rwI2sXs+4xdaieM+Eg74
=gHt7
-----END PGP SIGNATURE-----

--Th5JPit8I3Q6/gDv--
