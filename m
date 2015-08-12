Return-Path: <broonie@sirena.org.uk>
Date: Wed, 12 Aug 2015 13:03:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Message-ID: <20150812120300.GE10748@sirena.org.uk>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-21-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KMIs29sPfC/9Gbii"
In-Reply-To: <1439374365-20623-21-git-send-email-mpa@pengutronix.de>
Subject: Re: [PATCH 20/20] iio: bmc150: Add SPI driver
List-ID: <linux-iio@vger.kernel.org>


--KMIs29sPfC/9Gbii
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 12, 2015 at 12:12:45PM +0200, Markus Pargmann wrote:

> +	.use_single_rw = false,
> +	.cache_type = REGCACHE_NONE,
> +};

No need to initialise defaults.

--KMIs29sPfC/9Gbii
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVyzXzAAoJECTWi3JdVIfQunAH/iGwZDaec4vcLOSo0kr5DzX4
Zrihrp/O+ApvKFCh9KXlFZy9SPt0MCUQUwdqoopBYX/wcKSdJQiAwcQWXltjeqi6
C8XQ1vg8GPcVR6Xi5ASADBXXqrVcj7qTdy8WAaEHFDr9rNAPiJHnAQr2TBSm2gqx
F/fxhCOw7mR0Zu4Z3xAnRn7xC/FkH29cob1kl1BgHzZoT/jlumJlcQNruXZACQq9
jPcHZMFclzEOeWcZKUoZHwZlnFKQev0A6KiUuuRdK+i+4B0poZfYOFp9EOUWl7/6
L9ysC9lHoM5gpyYFOVOd80FjFBZJZz8iw/GjNr/H5C58ynYeNTkI2KFS1+P5BF8=
=VYy7
-----END PGP SIGNATURE-----

--KMIs29sPfC/9Gbii--
