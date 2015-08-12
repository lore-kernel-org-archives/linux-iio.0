Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:40348 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbbHLLvn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 07:51:43 -0400
Date: Wed, 12 Aug 2015 12:51:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Message-ID: <20150812115136.GA10748@sirena.org.uk>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-14-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8teuZUM8bA5gqecl"
In-Reply-To: <1439374365-20623-14-git-send-email-mpa@pengutronix.de>
Subject: Re: [PATCH 13/20] regmap: regmap max_raw_io getter function
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--8teuZUM8bA5gqecl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 12, 2015 at 12:12:38PM +0200, Markus Pargmann wrote:
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

Your changelog doesn't mention why anything would reasonably want to use
this and...

> +size_t regmap_get_raw_io_max(struct regmap *map)
> +{
> +	return map->max_raw_io;
> +}
> +EXPORT_SYMBOL_GPL(regmap_get_raw_io_max);
> +
> +/**
> + * regmap_get_raw_read_max - Get the maximum size we can read
> + *
> + * @map: Map to check.
> + */

...it is adding two functions which don't seem very symmetrically named.

> @@ -441,6 +441,8 @@ int regmap_get_max_register(struct regmap *map);
>  int regmap_get_reg_stride(struct regmap *map);
>  int regmap_async_complete(struct regmap *map);
>  bool regmap_can_raw_write(struct regmap *map);
> +size_t regmap_get_raw_write_max(struct regmap *map);
> +size_t regmap_get_raw_io_max(struct regmap *map);

Do we want stubs here?

--8teuZUM8bA5gqecl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVyzNHAAoJECTWi3JdVIfQyMAH/3m9GjtatZQkzFLMrdYwgzQd
6XZZkxzw2dKNSgmgGCYpqYZhPtZdUSL26d7pLDPQQlauELyLUDfncbBFSXga1aKz
hDncb1ejpcuDIoKRZtTFbCKAZSCKvZW+u/UZik1WxJ13OZAxYZ9wkUpwHaCLMlI3
NOyTuwR0Z3djba5nN4lvCDwH/5byWsBt1SvWaqbslYDPfgs7qZg3Nf4KbfHNKLE3
w+ojQhhy12mh/3HMD0zb0HxKbU9d2NHU/O6PAiEi87UOQYADt34ANl9kHxBWCRO+
vDnP7HnGaDNvGdWXuOUnOJzEXf8A2PwC51nTzlxUkVq5hudkPhISGzTIK0o4N3E=
=MyZN
-----END PGP SIGNATURE-----

--8teuZUM8bA5gqecl--
