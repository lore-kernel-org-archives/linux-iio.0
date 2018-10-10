Return-Path: <SRS0=3HYi=MW=rwth-aachen.de=Stefan.Bruens@kernel.org>
From: Stefan =?ISO-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>
To: Colin King <colin.king@canonical.com>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ina2xx: fix missing break statement
Date: Wed, 10 Oct 2018 12:42:39 +0200
Message-ID: <1884341.stJYpOWv9L@pebbles>
In-Reply-To: <20181008210904.9362-1-colin.king@canonical.com>
References: <20181008210904.9362-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2861461.cQNSvQuZq1";
	micalg=pgp-sha1; protocol="application/pgp-signature"
List-ID: <linux-iio@vger.kernel.org>

--nextPart2861461.cQNSvQuZq1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Montag, 8. Oktober 2018 23:09:04 CEST Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The IIO_CHAN_INFO_SCALE case is missing a break statement and in
> the unlikely event that chan->address is not matched in the nested
> switch statement then the code falls through to the following
> IIO_CHAN_INFO_HARDWAREGAIN case.  Fix this by adding the missing
> break.   While we are fixing this, it's probably a good idea to
> add in a break statement to the IIO_CHAN_INFO_HARDWAREGAIN case
> too (this is a moot point).
>=20
> Detected by CoverityScan, CID#1462408 ("Missing break in switch")

Although it is good for code clarity to add a break statement, the code can=
=20
never return anything but -EINVAL in case chan->address is not handled in=20
IIO_CHAN_INFO_SCALE:

=2D----
switch (mask) {
case IIO_CHAN_INFO_SCALE:
   switch (chan->address) {
       case INA2XX_SHUNT_VOLTAGE:
       ... return IIO_VAL_FRACTIONAL;
      =20
       case INA2XX_BUS_VOLTAGE:
       ... return IIO_VAL_FRACTIONAL;

       case INA2XX_CURRENT:
       ... return IIO_VAL_FRACTIONAL;

       case INA2XX_POWER:
       ... return IIO_VAL_FRACTIONAL;
   }

case IIO_CHAN_INFO_HARDWAREGAIN:
   switch (chan->address) {
       case INA2XX_SHUNT_VOLTAGE:
       ... return IIO_VAL_FRACTIONAL;
      =20
       case INA2XX_BUS_VOLTAGE:
       ... return IIO_VAL_INT;
   }
}
return -EINVAL;
=2D----

The addresses handled in INFO_HARDWAREGAIN is a subset of the ones in=20
INFO_SCALE.

I would prefer an early "return -EINVAL" here, as it matches better with th=
e=20
other "switch (mask)" cases above.

Kind regards,

Stefan

=2D-=20
Stefan Br=FCns  /  Bergstra=DFe 21  /  52062 Aachen
home: +49 241 53809034     mobile: +49 151 50412019
--nextPart2861461.cQNSvQuZq1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSwWRWIpJbl0W4DemNvf0o9jP6qUwUCW73XnwAKCRBvf0o9jP6q
U+v6AJ0fqP/18bNgvBNmMmSjj/o+/TqETwCgjjEq7OPNj2nTtY7xnhYLGS/hkPk=
=jrU5
-----END PGP SIGNATURE-----

--nextPart2861461.cQNSvQuZq1--
