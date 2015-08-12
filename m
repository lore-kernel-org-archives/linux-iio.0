Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36809 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588AbbHLMrM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 08:47:12 -0400
Date: Wed, 12 Aug 2015 14:47:06 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH 14/20] regmap: Add raw_write/read checks for
 max_raw_write/read sizes
Message-ID: <20150812124706.GI19600@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-15-git-send-email-mpa@pengutronix.de>
 <20150812115759.GB10748@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ceI9FlwgjS98XxYT"
In-Reply-To: <20150812115759.GB10748@sirena.org.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--ceI9FlwgjS98XxYT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2015 at 12:57:59PM +0100, Mark Brown wrote:
> On Wed, Aug 12, 2015 at 12:12:39PM +0200, Markus Pargmann wrote:
>=20
> > Check in regmap_raw_read() and regmap_raw_write() for correct maximum
> > sizes of the operations. Return -E2BIG if this size is not supported
> > because it is too big.
>=20
> Why not just split the transaction up like your other changes did?

My intention was to keep these raw functions as close to the actual
hardware as possible also reporting proper error values. For
transactions that are split up you could still use the bulk functions.

The actual use case is the bmc150 driver. This chip has a FIFO behind
one of its registers. At exactly that register there is no autoincrement
of the address or anything, it is just a much larger register. But you
have to read from it in bigger chunks than normal. If you read in
chunks that do not have the correct size samples from the sensor get
discarded.

>=20
> > Also this patch causes an uninitialized variable warning so it
> > initializes ret (although not necessary).
>=20
> That's just shutting the warning up without understanding where it came
> from or why this is a good way of handling it :(

Yes, will have a look if I can find the issue.

>=20
> > @@ -2273,8 +2276,14 @@ int regmap_raw_read(struct regmap *map, unsigned=
 int reg, void *val,
> > =20
> >  	map->lock(map->lock_arg);
> > =20
> > -	if (regmap_volatile_range(map, reg, val_count) || map->cache_bypass ||
> > -	    map->cache_type =3D=3D REGCACHE_NONE) {
> > +	if (map->bus->read &&
>=20
> This change doesn't match your commit log...

Sorry.

Thanks,

Markus



--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--ceI9FlwgjS98XxYT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVy0BKAAoJEEpcgKtcEGQQ12oP/130C8MLeoHfw76MZtR7U2Xk
rQH4YIa2jCKyuIB2C2th1h6c42vMzgTNE4+eTot/h6UJ1xZ0jETaexKzbH+YIX4E
zJTlGlVXSdWJV/sCQMKnL2sutgYWwuc97AG5awIPLNaVwE7Gek9OfboJL6+ZrTkg
Bsx6kjDoALBtMW9FkS8ZLL7eOYyGeDIXzy178TiVPmF7KA70WAkpZYEsAitmiNqG
CdcYCAcnFJu7kDW1OYXWuewxSKbTes3p7SmQAHYjjGuxqXbN57puytJ5/nOxFGEE
HaqMpluZL6YlrGvWOxBjnkqcYgFhi9bGbGyaPi3cEXvVKErFZeJ9OQuNK6U8TQvg
ktM4gxaB1rl4ntCZfIXK7VLsmJkXh1QHM8AwDdO2jOKufLJbuB08tussJ28a3fIc
euCCIkqqeCli4J95LT9Jgf6vWIv7Tsv17IqlLQeZ0r3azz9lMPHoiTORaiYx6aLT
v/bNXkJ3iVi8VW8CKBw5mAc5MUVyu2mGukJdYD9Oe6dJtXUXZz2FM1mMzy0qIBfq
BeZ2ou/Ye3pt5C9rZ/RxSSC5Wyz6JtuwpgV/It7GsBmd4xsJxiR2Ye6xjgDb17Wp
Tm2L6mvUFTDCnm9bJa+HenpxkW3M8v1WgB42gZmIo53FuqNXrcHJaGrllWE2jEIR
9hHyHw6roEwxIz7Ikzar
=zErd
-----END PGP SIGNATURE-----

--ceI9FlwgjS98XxYT--
