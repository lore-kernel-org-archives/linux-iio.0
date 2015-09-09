Return-Path: <irina.tirdea@intel.com>
From: "Tirdea, Irina" <irina.tirdea@intel.com>
To: Markus Pargmann <mpa@pengutronix.de>, Jonathan Cameron <jic23@kernel.org>
CC: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Lars-Peter
 Clausen" <lars@metafoo.de>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>
Subject: RE: [PATCH v2 0/4] iio: bmc150 regmap and SPI
Date: Wed, 9 Sep 2015 14:30:30 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F0C833A@irsmsx105.ger.corp.intel.com>
References: <1440074986-28716-1-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1440074986-28716-1-git-send-email-mpa@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>



> -----Original Message-----
> From: Markus Pargmann [mailto:mpa@pengutronix.de]
> Sent: 20 August, 2015 15:50
> To: Jonathan Cameron
> Cc: Srinivas Pandruvada; Tirdea, Irina; Lars-Peter Clausen; linux-iio@vge=
r.kernel.org; linux-kernel@vger.kernel.org;
> kernel@pengutronix.de; Markus Pargmann
> Subject: [PATCH v2 0/4] iio: bmc150 regmap and SPI
>=20
> Hi,
>=20

Hi Markus,

I tested your patches with my BMA250E driver connected on the i2c bus .
The code looks good and most of it works. There are a couple of issues I wi=
ll mention
below and in the individual patches.

The patches in this version no longer apply cleanly on the togreg branch of=
 the iio tree.
I did the rebase myself, but since there were many conflicts I will do anot=
her test
when you send the new rebased v3.

> this series converts the bmc150 driver to use regmap and adds an SPI inte=
rface.
>=20
> In v1 this was part of the series "Regmap max_raw_io and bmc150 SPI suppo=
rt".
> It now depends on "regmap: i2c block support".
>=20

I used the patches that were already merged in the regmap tree. This bmc150=
 series should
probably wait until the regmap patches end up in Jonathan's tree, otherwise=
 they will
break the build.

Thanks,
Irina

> Changes in v2:
> - Removed default values for regmap_config fields.
> - Redesigned the fifo_transfer function to avoid running in errors first.
> - Dropped irq checks patch as it is already mainline
> - Core can now be built as module with autoselection of i2c and spi parts
>=20
> As my hardware is missing an interrupt line from the SPI connected bmc150=
 I am
> not able to test the iio buffer code path and the i2c code path. Tests wo=
uld be
> appreciated.
>=20
> Best regards,
>=20
> Markus
>=20
>=20
> Markus Pargmann (4):
>   iio: bmc150: Use i2c regmap
>   iio: bcm150: Remove i2c_client from private data
>   iio: bmc150: Split the driver into core and i2c
>   iio: bmc150: Add SPI driver
>=20
>  drivers/iio/accel/Kconfig                          |  14 +-
>  drivers/iio/accel/Makefile                         |   4 +-
>  .../accel/{bmc150-accel.c =3D> bmc150-accel-core.c}  | 398 ++++++++-----=
--------
>  drivers/iio/accel/bmc150-accel-i2c.c               |  99 +++++
>  drivers/iio/accel/bmc150-accel-spi.c               |  83 +++++
>  drivers/iio/accel/bmc150-accel.h                   |  21 ++
>  6 files changed, 367 insertions(+), 252 deletions(-)
>  rename drivers/iio/accel/{bmc150-accel.c =3D> bmc150-accel-core.c} (81%)
>  create mode 100644 drivers/iio/accel/bmc150-accel-i2c.c
>  create mode 100644 drivers/iio/accel/bmc150-accel-spi.c
>  create mode 100644 drivers/iio/accel/bmc150-accel.h
>=20
> --
> 2.4.6
