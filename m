Return-Path: <broonie@sirena.org.uk>
Date: Wed, 12 Aug 2015 13:01:46 +0100
From: Mark Brown <broonie@kernel.org>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Message-ID: <20150812120146.GD10748@sirena.org.uk>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-18-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xFHWmGwbilGjB8dh"
In-Reply-To: <1439374365-20623-18-git-send-email-mpa@pengutronix.de>
Subject: Re: [PATCH 17/20] iio: bmc150: Use i2c regmap
List-ID: <linux-iio@vger.kernel.org>


--xFHWmGwbilGjB8dh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 12, 2015 at 12:12:42PM +0200, Markus Pargmann wrote:

> +	select REGMAP
> +	select REGMAP_I2C

You don't need to select regmap, only REGMAP_I2C.

--xFHWmGwbilGjB8dh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVyzWpAAoJECTWi3JdVIfQI6UH/1cdX7STM24Nba5Rus7jL5gq
VJWEOu+tv6r5MJMf/nfpG8fePAeHRAYQ+4XnRynqKhSMW2HyNIR8tdQ8lHj8MjIc
1QH0usmHp5dQ7mRyCfAEOjH104c8YNA1tTLqfEfFZxuRb8nS3IEtK44G4KmMgb5E
zAtbjb4sKvyZhtJhSIw5/EUNE3u0g2nddmv3AjIE7+uCRnuqzI+sTmQ5MbKzpNI4
v0m59h8efu6SE1gccXb2I5cNMlvBospZlwLFJZHzoWhdKvCt5kMLEjdZHEb9AQAg
e5oBqi0KQs0p/KkXEGBrZP47156QUCAWrjVEk0aauuD/kpmzwzTmZXs4TiEp3c4=
=U0z1
-----END PGP SIGNATURE-----

--xFHWmGwbilGjB8dh--
