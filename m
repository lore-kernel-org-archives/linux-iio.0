Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:40358 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbbHLL6H (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 07:58:07 -0400
Date: Wed, 12 Aug 2015 12:57:59 +0100
From: Mark Brown <broonie@kernel.org>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Message-ID: <20150812115759.GB10748@sirena.org.uk>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-15-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hqsgWuDCGoNNiKsj"
In-Reply-To: <1439374365-20623-15-git-send-email-mpa@pengutronix.de>
Subject: Re: [PATCH 14/20] regmap: Add raw_write/read checks for
 max_raw_write/read sizes
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--hqsgWuDCGoNNiKsj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2015 at 12:12:39PM +0200, Markus Pargmann wrote:

> Check in regmap_raw_read() and regmap_raw_write() for correct maximum
> sizes of the operations. Return -E2BIG if this size is not supported
> because it is too big.

Why not just split the transaction up like your other changes did?

> Also this patch causes an uninitialized variable warning so it
> initializes ret (although not necessary).

That's just shutting the warning up without understanding where it came
=66rom or why this is a good way of handling it :(

> @@ -2273,8 +2276,14 @@ int regmap_raw_read(struct regmap *map, unsigned i=
nt reg, void *val,
> =20
>  	map->lock(map->lock_arg);
> =20
> -	if (regmap_volatile_range(map, reg, val_count) || map->cache_bypass ||
> -	    map->cache_type =3D=3D REGCACHE_NONE) {
> +	if (map->bus->read &&

This change doesn't match your commit log...

--hqsgWuDCGoNNiKsj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVyzTGAAoJECTWi3JdVIfQxAcH/2jDLx3J8Xxq13ECm15qOVXY
exAPo2N8NrwENizSRQL+j3EyBCbO3D87y4g3OL7LNbny8m+Pjp7RC3r0Tai45GiC
ezvWidgPwlUsfqnB5heX3vhMhFbTWE7LyVyrpePPuApA75QeHLJTBVHy5sFmX0GU
oJzQQB9w85x8iwsMcvQq8V1lkFuqViAgg273xfuqDENPTRJlLK9tRpkvKZTmzBen
KyFw3Tj2XYDqyaE2f4tsXLSGInTtg1R2yXoD1Jeq/BSnGJpQNp9lmGTGvGPSBkTP
exESwv82h59EUHkU30YYzjEMBLf9zOpkGhpRosKO8/xTdi3RisNVEhYui0YSEgA=
=0QXq
-----END PGP SIGNATURE-----

--hqsgWuDCGoNNiKsj--
