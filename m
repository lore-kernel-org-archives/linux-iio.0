Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54712 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753725AbbIPKN3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Sep 2015 06:13:29 -0400
Date: Wed, 16 Sep 2015 12:13:22 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: "Tirdea, Irina" <irina.tirdea@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v2 0/4] iio: bmc150 regmap and SPI
Message-ID: <20150916101322.GJ1537@pengutronix.de>
References: <1440074986-28716-1-git-send-email-mpa@pengutronix.de>
 <1F3AC3675D538145B1661F571FE1805F2F0C833A@irsmsx105.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0XhtP95kHFp3KGBe"
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F2F0C833A@irsmsx105.ger.corp.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--0XhtP95kHFp3KGBe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Irina,

On Wed, Sep 09, 2015 at 02:30:30PM +0000, Tirdea, Irina wrote:
>=20
>=20
> > -----Original Message-----
> > From: Markus Pargmann [mailto:mpa@pengutronix.de]
> > Sent: 20 August, 2015 15:50
> > To: Jonathan Cameron
> > Cc: Srinivas Pandruvada; Tirdea, Irina; Lars-Peter Clausen; linux-iio@v=
ger.kernel.org; linux-kernel@vger.kernel.org;
> > kernel@pengutronix.de; Markus Pargmann
> > Subject: [PATCH v2 0/4] iio: bmc150 regmap and SPI
> >=20
> > Hi,
> >=20
>=20
> Hi Markus,
>=20
> I tested your patches with my BMA250E driver connected on the i2c bus .
> The code looks good and most of it works. There are a couple of issues I =
will mention
> below and in the individual patches.
>=20
> The patches in this version no longer apply cleanly on the togreg branch =
of the iio tree.
> I did the rebase myself, but since there were many conflicts I will do an=
other test
> when you send the new rebased v3.

Thank you for review and testing. I will integrate your comments and
send a rebased v3.

>=20
> > this series converts the bmc150 driver to use regmap and adds an SPI in=
terface.
> >=20
> > In v1 this was part of the series "Regmap max_raw_io and bmc150 SPI sup=
port".
> > It now depends on "regmap: i2c block support".
> >=20
>=20
> I used the patches that were already merged in the regmap tree. This bmc1=
50 series should
> probably wait until the regmap patches end up in Jonathan's tree, otherwi=
se they will
> break the build.

It seems the necessary patches are already in v4.3-rc1:
	29332534e2b6 (regmap-i2c: Add smbus i2c block support)

Best Regards,

Markus

>=20
> Thanks,
> Irina
>=20
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
> >  .../accel/{bmc150-accel.c =3D> bmc150-accel-core.c}  | 398 ++++++++---=
----------
> >  drivers/iio/accel/bmc150-accel-i2c.c               |  99 +++++
> >  drivers/iio/accel/bmc150-accel-spi.c               |  83 +++++
> >  drivers/iio/accel/bmc150-accel.h                   |  21 ++
> >  6 files changed, 367 insertions(+), 252 deletions(-)
> >  rename drivers/iio/accel/{bmc150-accel.c =3D> bmc150-accel-core.c} (81=
%)
> >  create mode 100644 drivers/iio/accel/bmc150-accel-i2c.c
> >  create mode 100644 drivers/iio/accel/bmc150-accel-spi.c
> >  create mode 100644 drivers/iio/accel/bmc150-accel.h
> >=20
> > --
> > 2.4.6
>=20
>=20

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--0XhtP95kHFp3KGBe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV+UDCAAoJEEpcgKtcEGQQw28P/AgRG9u0vL+RQ60QivSD+1VX
D8bGlw4zHXwPlka4ZY+ZHoX5VmjQsUDtw0RNeeZU9Zq6aO0Izy6Sl2jy4tWmZvlM
0SO9kxpbEtrMEi0PgMfrHCgleSHfwBapoxdT8hRHdsZrap+KyAjz7be3weuV5p6h
RqUHAUrN7MbFCNSntHFPdumXuMlse0/q0Xn2LmKEYl1GuE9XJ0h0qhpYtHmnN2xA
gwt3XE+7nC5k2ye+a5szDpfNvIGrC6KJqSCu9B37vKrDAfnArieFb6NvDBlx7J4H
c6Pbs7AVyVoEvhy3lzk5dACYISK5f5gGIzbVMm5mtULjyFDT8MDzfVieDlCgaOx5
kymf9a0RWdUnuoeJ0zjOW/ilaGONq2ayrzVcHa5dOwkm0LlX9TvEBjTAK3d/cHXR
ItRgp7LwJA+HS7ZKezBUGKeDKI4Sxqsk0w9h1UkbtUaSHC7c5TMWOHInjXVlF7vA
hVTxE70Am7QWlJy3hlovzkwIEA5WFwWkTnVJeTObzniAHNEnjFl/a38D/BDxe8JX
olDXkwmQI7CYIiOV4sikifvt+TXWANVoWatvQNkwNbM/pvDlKe1QODUQc+3L6M2w
7p2T4rIVXi47lymbDkCpHI56oP7IkuNyoge2CDX0FDN7yihakr9OoHMi3PYg96k/
ChsA8j9pREKsHJOcdB4a
=LzDo
-----END PGP SIGNATURE-----

--0XhtP95kHFp3KGBe--
