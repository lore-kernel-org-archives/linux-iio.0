Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:40209 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832AbbHLKyu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 06:54:50 -0400
Date: Wed, 12 Aug 2015 11:54:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Message-ID: <20150812105443.GT10748@sirena.org.uk>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-6-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="G2d+m75Tjo442KmM"
In-Reply-To: <1439374365-20623-6-git-send-email-mpa@pengutronix.de>
Subject: Re: [PATCH 05/20] regmap: Restructure writes in _regmap_raw_write()
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--G2d+m75Tjo442KmM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2015 at 12:12:30PM +0200, Markus Pargmann wrote:
> Currently we try to write the data without copying directly using
> bus->write() or bus->gather_write() if it exists. If one of the previous
> tries to write reported -ENOTSUPP or none of them were usable, we copy
> the data into a buffer and use bus->write().
>=20
> However it does not make sense to try bus->write() a second time with a
> copied buffer if it didn't work the first time.
>=20
> This patch restructures this if/else block to make it clear that this is
> not intended for the case where bus->write() returns -ENOTSUPP.

I'm not entirely convinced that this is an improvement.  The main effect
that I'm seeing is an increase in the indentation level and there are
potential issues with the write operation being unable to work with some
kinds of memory (like restrictions about dmaing from stack or unalinged
memory for example) which mean that copying into a newly allocated
buffer may actually help.  I don't think we detect any such restrictions
at the minute but the defensiveness is nice and I'd really hope that the
failed write case isn't any kind of fast path.

--G2d+m75Tjo442KmM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVyyXyAAoJECTWi3JdVIfQ0FcH/2YuOWz45aftcNb/FTKRDXLK
5fu1dejEXzzvBR45joFGRN1aqbmkKT89EF/ycFThfObQBJ5t7ZJVCyLxZQcYJAoa
8YJQQ+YHkuVWRo0cMf8AIYb74jYgK7Y/WAGBLCMhcHN5L1cB5LTy45+FEmOYOe5k
l4MtNG3G3j+TuFnCUFXylp5ihx1E5pT7qL0w8X1NboeKe7hdFV93XveFfmr6RzdC
fiqt9TXACn1a/XxyWVjwA8OqRzt5q8UpJCUsvstzqgzHUWGd7Q0iUq4Pm1nyzDZZ
iwrA8vc0gU8Gnl2tmYwTMAixebqjB+pEj3aHe3XtXTcU+dGA4WSHHqJ7U632DUQ=
=yjck
-----END PGP SIGNATURE-----

--G2d+m75Tjo442KmM--
