Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:40340 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbbHLLti (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 07:49:38 -0400
Date: Wed, 12 Aug 2015 12:49:31 +0100
From: Mark Brown <broonie@kernel.org>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Message-ID: <20150812114931.GZ10748@sirena.org.uk>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-13-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b/1sb/HZzV9blKCG"
In-Reply-To: <1439374365-20623-13-git-send-email-mpa@pengutronix.de>
Subject: Re: [PATCH 12/20] regmap: Introduce max_raw_io for
 regmap_bulk_read/write
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--b/1sb/HZzV9blKCG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 12, 2015 at 12:12:37PM +0200, Markus Pargmann wrote:

> +	/* if set, raw reads/writes are limited to this size */
> +	size_t max_raw_io;
> +

Do this separately for read and write, there's doubtless going to be
something that has asymmetry.

> +		if (!map->use_single_rw) {
> +			write_count = total_bytes / map->max_raw_io;
> +			write_bytes = map->max_raw_io;

We may not be able to fit a whole number of values into whatever the
constraint that the bus has is and partial values don't seem like a good
idea.

> +			reg_stride *= write_bytes / val_bytes;
> +		}

This is very confusing, regmap already has a concept of stride and this
isn't the same thing.

--b/1sb/HZzV9blKCG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVyzLKAAoJECTWi3JdVIfQkV4H/iiOg0r1+bH7xQZK/1gBJbOh
ms3OshP5JIO1Se0dg19HklVcBIaeTpzm0HtIREWP15oKHvUiqHSWs3uzSoNXUKk4
st1xKWMhOMI9/ZOVB9tDn5bCDRIu2uS4ABkDmmR+kcodHVKqn1bYCdbcwjLExOLJ
PpVGB+wVoliEx6fhy3IQHScA2sl8BPySUqEeesz+uBqvcsTb9dQ6yFUGVexN4s3M
rRCCqg18oMLsgk1WAtZHbVv4XtirXORFth7y1nTlwUMz/mWpKVOoBkeaMWguIVgP
5s/RscAupdc91+6hA3N3KRGB2mg6+JaMToW+NPHY0vIf7oZ5GTxGzBoqqIUy2FI=
=XPwt
-----END PGP SIGNATURE-----

--b/1sb/HZzV9blKCG--
