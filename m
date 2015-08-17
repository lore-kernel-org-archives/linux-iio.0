Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48609 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382AbbHQIAX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 17 Aug 2015 04:00:23 -0400
Date: Mon, 17 Aug 2015 10:00:17 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH 20/20] iio: bmc150: Add SPI driver
Message-ID: <20150817080017.GM19600@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-21-git-send-email-mpa@pengutronix.de>
 <20150812120300.GE10748@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h1yPVEMkimJXSVYB"
In-Reply-To: <20150812120300.GE10748@sirena.org.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--h1yPVEMkimJXSVYB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2015 at 01:03:00PM +0100, Mark Brown wrote:
> On Wed, Aug 12, 2015 at 12:12:45PM +0200, Markus Pargmann wrote:
>=20
> > +	.use_single_rw =3D false,
> > +	.cache_type =3D REGCACHE_NONE,
> > +};
>=20
> No need to initialise defaults.

Thanks, removed those.

Best regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--h1yPVEMkimJXSVYB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV0ZSRAAoJEEpcgKtcEGQQB9IP/34M2qJ224/ovtC5jPm4OWnA
i3+Rw0jcEFwSllUsYAYNGw03aO8xK/MGCXz4d734fnwRKjAqoskjqoj0Mqiyvdy1
mxxAi2Si2DLjV2cUwm0VbjIknpng5QU2X/UQqOGeIh/BoP0zHfF6UbpoXSJqr9MH
/n0fxgYxG6t2hVxv3faOpY6g5f9vrKW0lh6mVoWS4VPoquRsXk0hIRJu1Bynteke
VTHtN5JXkEdifsgQFnN2Sz0VjeZ4xeRCfmrGvoyJZFv9BBNkpjxMZWo2IIWDp148
UEfzHgnRew9FigN8AlY+YeAIw+izy3q/A0xC9379rf9w3P9fiA3p3p63ojCRMWLd
tzPEzO1SdyNx2wj0Spxnp/x6jru0b5HfmVF6n4o6gOSFTOWW0pcCOMCC+0Fu7NeT
BS/DZAT2n53AgaygRpfveGxhvBueKPa96FBLlgPI5wbGKbAGt7slSx+tKaJ4Ic1R
hUjwAFbeW9c+haKrMIqnA2TOTeTOeU6fzrdb6aGL6zr32IkTP3GlseYPEUIPh59S
iSZm0BDX/kKuhC4Rn1OdwVIUXOlAie1MJsFeqSvG2JZNnI7LovY0L159WsOpetfg
7s7nVSO48SAiJaL8FmGZRLrh/HIfAjYyaQF5ea8KLDcU8uyRA4+TzLObK6lmHKEY
ynwfTl49htoBFXRoiDVd
=C95d
-----END PGP SIGNATURE-----

--h1yPVEMkimJXSVYB--
