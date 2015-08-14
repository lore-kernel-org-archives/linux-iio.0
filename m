Return-Path: <broonie@sirena.org.uk>
Date: Fri, 14 Aug 2015 17:36:25 +0100
From: Mark Brown <broonie@kernel.org>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Message-ID: <20150814163625.GY10748@sirena.org.uk>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-15-git-send-email-mpa@pengutronix.de>
 <20150812115759.GB10748@sirena.org.uk>
 <20150812124706.GI19600@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rVbcdceMkFY6fDyG"
In-Reply-To: <20150812124706.GI19600@pengutronix.de>
Subject: Re: [PATCH 14/20] regmap: Add raw_write/read checks for
 max_raw_write/read sizes
List-ID: <linux-iio@vger.kernel.org>


--rVbcdceMkFY6fDyG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 12, 2015 at 02:47:06PM +0200, Markus Pargmann wrote:
> On Wed, Aug 12, 2015 at 12:57:59PM +0100, Mark Brown wrote:
> > On Wed, Aug 12, 2015 at 12:12:39PM +0200, Markus Pargmann wrote:

> > > Check in regmap_raw_read() and regmap_raw_write() for correct maximum
> > > sizes of the operations. Return -E2BIG if this size is not supported
> > > because it is too big.

> > Why not just split the transaction up like your other changes did?

> My intention was to keep these raw functions as close to the actual
> hardware as possible also reporting proper error values. For
> transactions that are split up you could still use the bulk functions.

That's not what we do otherwise, and not what you yourself have done for
some of the other changes in the series like those around multi write.

--rVbcdceMkFY6fDyG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVzhkIAAoJECTWi3JdVIfQY8UH/jMKMSuTZlYL+L1l640cb04+
x1xq2+Q64bNAHnkdFOCx3mQw2ZZJUxBVg42Ox5pMQqbq24v6RWVkcktO2rbwkomn
80z3fDJE+K/hyAqpr5TiZZXSnne0qm9ESdluHm2YcVVosFO8jXR6G73QiuH9lIdn
HCIYNn6BaG88jbp/suOWD6le0AG5Egb9ZQ48IPN+wyVGug2P1nQIFl4T1KKitT24
RWMCF6zjCuxO4UFyRn0FWPIl9eq8/qLr2J7lfXEnxmt31vIUodyMz8csaBaESxjM
PZgbMRWM6Zzb8pPUngCfjoOtnQtQEHFnnqgueyigTu0XSdOV77mvJTeYdQ/Jja0=
=VJiO
-----END PGP SIGNATURE-----

--rVbcdceMkFY6fDyG--
