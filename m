Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:52686 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680AbbIXHLO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 24 Sep 2015 03:11:14 -0400
Date: Thu, 24 Sep 2015 09:11:07 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: "Tirdea, Irina" <irina.tirdea@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v3 0/4] iio: bmc150 regmap and SPI
Message-ID: <20150924071107.GV32203@pengutronix.de>
References: <1442832916-30774-1-git-send-email-mpa@pengutronix.de>
 <1F3AC3675D538145B1661F571FE1805F2F0E78D7@irsmsx105.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CJCg3p2l15m1juT/"
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F2F0E78D7@irsmsx105.ger.corp.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--CJCg3p2l15m1juT/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Irina,

On Wed, Sep 23, 2015 at 12:46:04PM +0000, Tirdea, Irina wrote:
>=20
>=20
> > -----Original Message-----
> > From: Markus Pargmann [mailto:mpa@pengutronix.de]
> > Sent: 21 September, 2015 13:55
> > To: Jonathan Cameron
> > Cc: Srinivas Pandruvada; Tirdea, Irina; Lars-Peter Clausen; linux-iio@v=
ger.kernel.org; linux-kernel@vger.kernel.org;
> > kernel@pengutronix.de; Markus Pargmann
> > Subject: [PATCH v3 0/4] iio: bmc150 regmap and SPI
> >=20
> > Hi,
> >=20
>=20
> Hi Markus,
>=20
> I tested the new version of you patches and everything works fine.
>=20
> I used a BMA250E chip connected on the i2c bus.
> The tests included the iio buffer code path and the i2c code path
> (including using the fifo and forcing the i2c bus to use
> the regmap_i2c_smbus_i2c_block calls you added to regmap).
>=20
> > this series converts the bmc150 driver to use regmap and adds an SPI in=
terface.
> >=20
> > Thanks for testing and review so far. I rebased the series onto v4.3-rc=
2 now
> > (the togreg branch seems to be on v4.2).
> > It still works for me but there were some differences regarding the chi=
p id.
> >=20
>=20
> I actually used the togreg branch (to get the latest bmc150 driver change=
s) and
> cherry-picked the regmap patches. Everything applied without any conflict=
s.

Thank you.

It is probably best if I rebase this onto togreg then as soon as it is
based on v4.3 to have the necessary regmap dependencies.

Best Regards,

Markus

>=20
> Thanks,
> Irina
>=20
> > Changes in v3:
> > - Fixed type of variable 'step' which lead to compile warnings. Type is=
 now
> >   size_t.
> > - Fixed patch that moved irq variable without reason
> > - Readded MODULE_* to the core driver
> > - Reintroduced check id NULL check
> >=20
> > Changes in v2:
> > - Removed default values for regmap_config fields.
> > - Redesigned the fifo_transfer function to avoid running in errors firs=
t.
> > - Dropped irq checks patch as it is already mainline
> > - Core can now be built as module with autoselection of i2c and spi par=
ts
> >=20
> > As my hardware is missing an interrupt line from the SPI connected bmc1=
50 I am
> > not able to test the iio buffer code path and the i2c code path. Tests =
would be
> > appreciated.
> >=20
> > @Srinivas:
> > As there were some rebase conflicts on the first patch, I removed your
> > reviewed-by tag again for the moment.
> >=20
> > Best regards,
> >=20
> > Markus
> >=20
> >=20
> > Markus Pargmann (4):
> >   iio: bmc150: Use i2c regmap
> >   iio: bcm150: Remove i2c_client from private data
> >   iio: bmc150: Split the driver into core and i2c
> >   iio: bmc150: Add SPI driver
> >=20
> >  drivers/iio/accel/Kconfig                          |  14 +-
> >  drivers/iio/accel/Makefile                         |   4 +-
> >  .../accel/{bmc150-accel.c =3D> bmc150-accel-core.c}  | 388 ++++++++---=
----------
> >  drivers/iio/accel/bmc150-accel-i2c.c               | 102 ++++++
> >  drivers/iio/accel/bmc150-accel-spi.c               |  80 +++++
> >  drivers/iio/accel/bmc150-accel.h                   |  20 ++
> >  6 files changed, 366 insertions(+), 242 deletions(-)
> >  rename drivers/iio/accel/{bmc150-accel.c =3D> bmc150-accel-core.c} (82=
%)
> >  create mode 100644 drivers/iio/accel/bmc150-accel-i2c.c
> >  create mode 100644 drivers/iio/accel/bmc150-accel-spi.c
> >  create mode 100644 drivers/iio/accel/bmc150-accel.h
> >=20
> > --
> > 2.5.1
>=20
>=20

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--CJCg3p2l15m1juT/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWA6ILAAoJEEpcgKtcEGQQBtgP/iSo/TT1IeCWb4oAJK02KQ75
fah5anT0ZcoqpIWscR7YggtiCrw+07SABuLEWAXFHdHCotYxadUC/SK7/CuAD0BS
sVUhqX4YQJTtHMACQj12IsP6sc+m9N1fAz0pnQA1nh2GP/F6OZ7aOyYHAOTGw5JX
UmrcV8T79iju5iqO732GcQzwjHSm/BuTmxhvhXeb0/1OcqLGhcuM+FV4SV986eX5
ttPTfFKFtAb3oCVdxzhgKJjibb2OPxyzV3w0KweCKlqpa4H9ZBhJBBaqn0K2u0x+
6GYQU9pedrjb6+uKyq+ICkTNRrcqL3ExGhDpjkDJL2mCLGXxbQ1rBgCoI9cuhZv3
a8gV4mw4PTqevCzX+49sQzqz/ctoIEO0GsR0NUOXfSgQK8bv6xQloT3/vJAZPS96
EbF2utUyDT0F9xj7R0kdosO1x2+kCR4xI8zdxnyrWQph8ZvCnseLgsy5ra9SeLv5
KVvlBm7GC80kn8kkOzIHZ3ylVi6WWV/t/JJg7B1YlwBjDj4LX32Objss++4vcBdb
GFrD8zJp2vcAORTwy4n/aPkrTQKxDQ8k0MYGWHYla9VQv0h0WfAr2AYeGijjr5Ga
16faRUPdpBro75EpKfwzUlklPctrpE6CbAFAgmyZOv2sqZi2tNx5jS0nlm92UXNg
GKPxmnmuj40HTEFVxo/E
=iXwk
-----END PGP SIGNATURE-----

--CJCg3p2l15m1juT/--
