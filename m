Return-Path: <SRS0=YBbj=KZ=gmail.com=marcus.folkesson@kernel.org>
Date: Fri, 10 Aug 2018 21:25:05 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Stefan Popa <stefan.popa@analog.com>
Cc: jic23@kernel.org, broonie@kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
	mark.rutland@arm.com, davem@davemloft.net,
	mchehab+samsung@kernel.org, gregkh@linuxfoundation.org,
	akpm@linux-foundation.org, robh+dt@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] iio: adxl372: New driver for Analog Devices
 ADXL372 Accelerometer
Message-ID: <20180810192505.GA2723@gmail.com>
References: <1533557087-10401-1-git-send-email-stefan.popa@analog.com>
 <1533557087-10401-2-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
In-Reply-To: <1533557087-10401-2-git-send-email-stefan.popa@analog.com>
List-ID: <linux-iio@vger.kernel.org>


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stefan,


On Mon, Aug 06, 2018 at 03:04:42PM +0300, Stefan Popa wrote:
> This patch adds basic support for Analog Devices ADXL372 SPI-Bus
> Three-Axis Digital Accelerometer.
>=20
> The device is probed and configured the with some initial default
> values. With this basic driver, it is possible to read raw acceleration
> data.
>=20
> Datasheet:
> http://www.analog.com/media/en/technical-documentation/data-sheets/ADXL37=
2.pdf
>=20
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
>  MAINTAINERS                 |   6 +
>  drivers/iio/accel/Kconfig   |  11 +
>  drivers/iio/accel/Makefile  |   1 +
>  drivers/iio/accel/adxl372.c | 525 ++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 543 insertions(+)
>  create mode 100644 drivers/iio/accel/adxl372.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 60b1028..2ba47bb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -543,6 +543,12 @@ W:	http://ez.analog.com/community/linux-device-drive=
rs
>  S:	Supported
>  F:	drivers/input/misc/adxl34x.c
> =20
> +ADXL372 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
> +M:	Stefan Popa <stefan.popa@analog.com>
> +W:	http://ez.analog.com/community/linux-device-drivers
> +S:	Supported
> +F:	drivers/iio/accel/adxl372.c
> +
>  AF9013 MEDIA DRIVER
>  M:	Antti Palosaari <crope@iki.fi>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 62ae7e5..1b496ef 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -60,6 +60,17 @@ config ADXL345_SPI
>  	  will be called adxl345_spi and you will also get adxl345_core
>  	  for the core module.
> =20
> +config ADXL372
> +	tristate "Analog Devices ADXL372 3-Axis Accelerometer Driver"
> +	depends on SPI
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say yes here to add support for the Analog Devices ADXL372 triaxial
> +	  acceleration sensor.
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called adxl372.
> +
>  config BMA180
>  	tristate "Bosch BMA180/BMA250 3-Axis Accelerometer Driver"
>  	depends on I2C
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index 636d4d1..5758ffc 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_ADIS16209) +=3D adis16209.o
>  obj-$(CONFIG_ADXL345) +=3D adxl345_core.o
>  obj-$(CONFIG_ADXL345_I2C) +=3D adxl345_i2c.o
>  obj-$(CONFIG_ADXL345_SPI) +=3D adxl345_spi.o
> +obj-$(CONFIG_ADXL372) +=3D adxl372.o
>  obj-$(CONFIG_BMA180) +=3D bma180.o
>  obj-$(CONFIG_BMA220) +=3D bma220_spi.o
>  obj-$(CONFIG_BMC150_ACCEL) +=3D bmc150-accel-core.o
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> new file mode 100644
> index 0000000..db9ecd2
> --- /dev/null
> +++ b/drivers/iio/accel/adxl372.c
> @@ -0,0 +1,525 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * ADXL372 3-Axis Digital Accelerometer SPI driver
> + *
> + * Copyright 2018 Analog Devices Inc.
> + */

Please make the SPDX-identifier and MODULE_LICENCE match here as well.

Either=20
SPDX-License-Identifier: GPL-2.0+
MODULE_LICENSE("GPL")

or

SPDX-License-Identifier: GPL-2.0
MODULE_LICENSE("GPL v2")

Thanks!
Marcus Folkesson

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAltt5o0ACgkQiIBOb1ld
UjKQHQ/+Pgab6MAe9FBMzZA0daGigs/5JetMKzizYOtpj2vhtntcJ5LlgMG6V/Rd
TfYjIiKPEfc8FVqtPua3DPBcvUL/iuVU7LqQYx8LaIkwT1Fp4dg2OQovOeUEUZ0E
nmAFwp3QDMPnZgAvDr5WnrFMua7a24ZhaEcDUXStoXPDndSfXkbvsCfovpAnMGk5
S/fmMoa5gPunEhOWGZR4F8q+LnmlcBUoLeTcNNqHGBpx07TQiXCybtWFKaQ8VtaO
CEznh2nEc040k4yuk2xubBh5XItJSON5fAuuHirP8gEvkmQzMwNuwO/QLkODNfuh
JYRmjBoeVm43b+hfazzQu1ZtvC9cmyj5G8SUZsI1PzI9WRFGZKb/oRMHGKaTYFO0
JtOgTLsmUTnpiP3ArRjoC6Bap5r5mlN8+rC7iELY5prpHHxw5QMiX0SsHnAlR250
msaRMAWMhiCvQ/fVLlP9YLPro4WqK4rTKQnq2zHv4VrFofxp6g/59nMnpUdPeGpS
IzByC+01dwqe8D+ZrvtrlYlELUNec6Ba0WaSUFDqu4QSmi3CaZ+UIJQNPZIa82Y5
0ZPBr7mKqWgN8DRjtB+QABKCWFuFioOWlvHywLAY/wN384etjobzxZfI0XpSY2VX
9G6KfwVHEqMIlqk+PkCjJhzjbsNf2rsEauqUK99P3UIYd0FU2Dw=
=R3xe
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
