Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60359 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbbHCKIF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 3 Aug 2015 06:08:05 -0400
Date: Mon, 3 Aug 2015 12:07:56 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 7/7] iio: bmg160: Add SPI driver
Message-ID: <20150803100756.GF19600@pengutronix.de>
References: <1438177569-18772-1-git-send-email-mpa@pengutronix.de>
 <1438177569-18772-8-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lIrNkN/7tmsD/ALM"
In-Reply-To: <1438177569-18772-8-git-send-email-mpa@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--lIrNkN/7tmsD/ALM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2015 at 03:46:09PM +0200, Markus Pargmann wrote:
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  drivers/iio/gyro/Kconfig      | 11 ++++++++
>  drivers/iio/gyro/Makefile     |  1 +
>  drivers/iio/gyro/bmg160_spi.c | 59 +++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 71 insertions(+)
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
> index 000000000000..e189abd78bc6
> --- /dev/null
> +++ b/drivers/iio/gyro/bmg160_spi.c
> @@ -0,0 +1,59 @@
> +#include <linux/spi/spi.h>
> +#include <linux/regmap.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +
> +#include <bmg160.h>
> +
> +struct regmap_config bmg160_regmap_conf =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.read_flag_mask =3D 0x80,
> +
> +	.use_single_rw =3D true,
> +	.cache_type =3D REGCACHE_NONE,
> +};
> +
> +static int bmg160_spi_probe(struct spi_device *spi)
> +{
> +	struct regmap *regmap;
> +
> +	regmap =3D devm_regmap_init_spi(spi, &bmg160_regmap_conf);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
> +			(int)PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +
> +	return bmg160_core_probe(&spi->dev, regmap, spi->irq, NULL);

This call should use spi_id->name instead of NULL. Will fix it.

Best regards,

Markus

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

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--lIrNkN/7tmsD/ALM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVvz18AAoJEEpcgKtcEGQQXXMQAKNGvj0iRjUZXeUlmLUieC6n
BErVMJA/eMMq7Ih/RLXinoMBHnV6hGLBsy4/aAMJmETfAEsFSSx5YttUnMjtw+Ns
ly+AmTeGuqtR4QbRvmFegsoJF7cIcymWqPhVHc0mAISdc9HgRs3wH/+VBv69M+GD
iKOlbEmJxPnJpnghytfyxyOZx6xdnkx9+CdZck3x430zIRTwa4ConnABebWr90GC
Sj5rBf3E4+Ds7H+KUWqNJsHtM/eItS+rchtP2UB82ENq1YN56SAjiB2qeXKMwX7T
bRD/pxTex75ItLg4YizR5s2t4BrQsTTZ2eTdh2h80rDHJYlFKk/Hxf7szLRnpm45
okboV7RlHeUDOqZ6URmb6+QFZQkmfPnke6fos1tsE4qfhv8u9NuODmfqLzrrk0KK
9kVG6mnNJA6RXVAb+g4DyAGlvC30Li04lhgkTVauldg5ZyO6QYnTv+gJPLARQ9Wh
k7JMQ7tW4O78IyzlfgwOOrw9OWx8cJCd3VIvyuwY563aeM5ubFVofr2/x46MfLnB
pW3VmJ1cVOUg+OB8EesVjxZ37D6LVei4uuEbmUXVWEVBuEYEB3inUOQVOrmJrcgm
7mrYM1f7xPArDbj0l3OmuFzU5XhWv17R45XXU1H3bYC+razdpC3TuS/NhOr9m8ub
2UxsYNGy7rLExMssTsD7
=7s9v
-----END PGP SIGNATURE-----

--lIrNkN/7tmsD/ALM--
