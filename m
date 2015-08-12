Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60933 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbbHLNRw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 09:17:52 -0400
Date: Wed, 12 Aug 2015 15:17:50 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>, kernel@pengutronix.de,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 10/20] regmap: _regmap_raw_multi_reg_write: Add
 reg_write() support
Message-ID: <20150812131750.GO19600@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-11-git-send-email-mpa@pengutronix.de>
 <20150812123923.GI10748@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5OY1VMnxNaoJKAjw"
In-Reply-To: <20150812123923.GI10748@sirena.org.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--5OY1VMnxNaoJKAjw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2015 at 01:39:23PM +0100, Mark Brown wrote:
> On Wed, Aug 12, 2015 at 12:12:35PM +0200, Markus Pargmann wrote:
> > Define a fallback for busses which do not define a write() function.
> > Instead we write one register at a time using reg_write().
> >=20
> > Without this patch, _regmap_raw_multi_reg_write would break as it tries
> > to call bus->write() without checking if it exists before.
>=20
> Why are we trying to use multi write APIs in the first place if we can't
> do raw I/O?

Because we may not know if the bus supports raw IO and I would prefer
if it is not necessary to know in the driver that just uses the regmap
API if the underlying bus supports it.

Sorry this patch is wrong, instead it should set can_multi_write
properly depending on the availability of map->bus->write(). The code
would already handle multi writes then.

Thanks,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--5OY1VMnxNaoJKAjw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVy0d+AAoJEEpcgKtcEGQQYkUP+QHzGbUE2Mr2jHSuwA2R9aiJ
jl0iFTsspn6be0S55d0wBkImkpLj/Rag8i05+TRIsoSXGFR+9IOomW5B+oe52+6K
L/4HvelJgIg+ST0qpAojDqbqVhVBaByUCHrM7A3FOShAt3YfRO40hmUEwYU89qe7
q4p6e/Nem5mEnIiFyIm2tO5BfWU8mfKkX41eHV/0OlacUBmuQyCikHyxfqmX4tXm
QsCK1XBU3JSUK5Q1Pyz/hVXIBepT96Oaf4N5E1ak9dIQrXQcxEiGelapwtr2IcUr
hINZFm5n0MiQcJMhx9MMVGbmR9GUSjLiTu7wj9j8iwbHsoZKwoh5I7ylv7gcMZJq
m+1a3H9ZeZV23HwlkM2dplE8y+JHHAJUL3EjwHVlENviAq74fPUIpmBq7yhIM9PL
Nr8glEa5M+xL4Zl/1PX2e69V8g+tTUW1/Bo8Iu9odNHHjnLa6FyPlY6mwfUAHkRz
63XKdzHvy/dp3Nd8oJpI5ea6rZt9X5q6RFRfKJ9eAezlAQAqedjqpaFK0wTSB5/t
T/JyDdxooL0ZpTgJ1uai0GUdy+9BOoPPD10r6KjZZWfGJiuztEMIoMMivGpJpO+H
kGHoRVCvBoQn7VOdIjpabEYEPonlrMCbSedWar4vIrSGxVxp/UQZYSN942pQAdWv
BQqXEh2OgICYlqFmE/NG
=ttgo
-----END PGP SIGNATURE-----

--5OY1VMnxNaoJKAjw--
