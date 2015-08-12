Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:40271 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbbHLLNa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 07:13:30 -0400
Date: Wed, 12 Aug 2015 12:13:24 +0100
From: Mark Brown <broonie@kernel.org>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Message-ID: <20150812111324.GW10748@sirena.org.uk>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-8-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zGa1rFMfQatMxgJk"
In-Reply-To: <1439374365-20623-8-git-send-email-mpa@pengutronix.de>
Subject: Re: [PATCH 07/20] regmap: Without bus read() or write(), force
 use_single_rw
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--zGa1rFMfQatMxgJk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2015 at 12:12:32PM +0200, Markus Pargmann wrote:
> The implementation of regmap bus read() and write() methods are
> optional. Therefore we have to handle busses which do not have these
> functions. If raw read() and write() is not supported we have to use
> reg_read and reg_write always.
>=20
> This patch sets use_single_rw if read() or write() is not set.

> -	map->use_single_rw =3D config->use_single_rw;
> +	map->use_single_rw =3D config->use_single_rw || !bus->read || !bus->wri=
te;

This doesn't follow, we should be able to support write only or read
only buses.  There are some out there.

--zGa1rFMfQatMxgJk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVyypTAAoJECTWi3JdVIfQ8/wH/1VJx3BImA24KVrmbzL4BTTb
VHAahanLe4QUbMmbxCGwAX0dMV8TU00xKyK6oVw6lDKWLMZ3YDmySnIxqaKK2Qnj
x0PG9rj1+ih/UVmP5ulYpaJWPdG/zgeJO0fCGI+JBTko5jGgbqENhTdRkp/b/i9l
3qXr/gALhXkcHDcq8CKMlt+Sxc5cuw1Ay+gtaPzECHj/+iJi2sCuXcXmTPMoBDYt
vhQ2dEOBlzPndq1rw1qC3YvonFFG+/OsPM1k+aLu43lwk3zSMnUErF3lX5EcxqRM
VAQOaKRTvXLhDbyKd688mzu40yjh1AUnsCZOIeZvCaMDvT941TyA9k/AS3ljcSI=
=3vVF
-----END PGP SIGNATURE-----

--zGa1rFMfQatMxgJk--
