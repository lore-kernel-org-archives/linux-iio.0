Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:40174 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408AbbHLKhn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 06:37:43 -0400
Date: Wed, 12 Aug 2015 11:37:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Message-ID: <20150812103736.GR10748@sirena.org.uk>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mjrw6G9AoRBv8oQK"
In-Reply-To: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
Subject: Re: [PATCH 00/20] Regmap max_raw_io and bmc150 SPI support
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--mjrw6G9AoRBv8oQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2015 at 12:12:25PM +0200, Markus Pargmann wrote:
> Hi,
>=20
> this series was created to add SPI support to the bmc150 accelerometer dr=
iver.
> To not add any regressions, I had to add some infrastructure that allows =
to use
> regmap with busses that do limit the size of transfers (block smbus). I h=
ope
> this is sufficient to not break anything.

This is a really big series but looking at at least the initial patches
there's a lot of unrelated cleanups mixed in with it.  Please don't do
this, send things like cleanups separately so that your series is
focused on the relevant topic.  This makes things much easier to work
with.

--mjrw6G9AoRBv8oQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVyyHvAAoJECTWi3JdVIfQSQEH/jy/pn+j9mtQeSK1N1hCb4Pd
ZIyWdySREEEc0e+dAFmmnwr7/CoHq8b6jcGqKmDC60hhpn/o/zx0tB2JDgbJBdmB
RRTAFyWcFeAgSXqwZfAmOYmEKdE2jvbjtGwQPQbalYTuD6B9JBOu4iLsIT5dENcU
35vC0eZktXukT20bVjCjG6k5SKwvcpxtbRd4FZGRRc4bKbEAULgK+kLC/GbX6+ig
0cEPYSxpoUU0gbi20BANcyzSNZPMcRcKt+5TGTtbaVOO+tHTN/EZwIwyd/3V/Edj
oVBDUmZ/ogzz9/NvCSx/mDOJczq3zLamsaVB+39WADB7vffqEwdpYc4Eu20Hafc=
=XiDC
-----END PGP SIGNATURE-----

--mjrw6G9AoRBv8oQK--
