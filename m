Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37225 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084AbbHLMwH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 08:52:07 -0400
Date: Wed, 12 Aug 2015 14:52:02 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH 15/20] regmap-i2c: Add smbus i2c block support
Message-ID: <20150812125202.GK19600@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-16-git-send-email-mpa@pengutronix.de>
 <20150812115936.GC10748@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YPYi+6JBnn8IjLOH"
In-Reply-To: <20150812115936.GC10748@sirena.org.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--YPYi+6JBnn8IjLOH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2015 at 12:59:37PM +0100, Mark Brown wrote:
> On Wed, Aug 12, 2015 at 12:12:40PM +0200, Markus Pargmann wrote:
>=20
> > +	if (count < 1 || count >=3D I2C_SMBUS_BLOCK_MAX)
> > +		return -EINVAL;
>=20
> Elsewhere you added returns of -E2BIG if the transfer was too big, why
> not do that here as well?

Sounds good to use E2BIG here as well.

Best Regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--YPYi+6JBnn8IjLOH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVy0FyAAoJEEpcgKtcEGQQPEoP/i2NKdPfF771y/xUHMNfdVYX
6bQKeK+Tq88Sfn4UCZSEZubMkxRgOyOqrrrQAKK7Add5YrvcF9hxQ5+i2B0jLGaT
l/SC8KFmH0fZNtmbOdoC04ahOEGpVjwPwFBjEf5BsNI5DUUA4ROi03tC8alVeU5E
QFGleqGXw0Ja5ZgvTTPiKnszAO0vOyboHiPFxuckvJA0NJuPvDLSwrFHOBMsQe4A
gz6aUpMtSAi1uNDjioRb1z/lxUYGxmq5AoDyKRJJq/85EMgJQJJmJF3xzu/fpMdL
Fews3P3dBVFM2cE72TLLkKehYAUG13b+NbvIVQFGe90hIKh1aRVQmpYtK0+WyzbM
OYv4oSG4MUoSLWQ5u2WuMFANERSn06jQrYkDHD2g9hMOjMUVQEhxayFtQUySi2z+
R9wd2up3x+V+0E8Z3v6QZqZ1IIwArvPZnfDAbQJcPJxQoV1QVPV+V/eX+wiyeXal
IsGdv9S/jon3hMplFz3yviNpF+ZPjddJD4bdoCffdy1qbMD+fF9mLZkeOCbb0cYl
yODr13ZCRc3Frq00ljZpRFxT3UkgmnIgr0zOxbUrLdDhmcy2tOKgqgp0Uv23W74f
IUQpkuq9weus7bzZZQtl2mjEDx4TFzN07XsgRizGKnylO263wOcJU22BOah5I3xc
Lo5zPYcWgpGfBnD+7cFH
=oXEM
-----END PGP SIGNATURE-----

--YPYi+6JBnn8IjLOH--
