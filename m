Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37239 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182AbbHLMxB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 08:53:01 -0400
Date: Wed, 12 Aug 2015 14:52:56 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH 17/20] iio: bmc150: Use i2c regmap
Message-ID: <20150812125256.GL19600@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-18-git-send-email-mpa@pengutronix.de>
 <20150812120146.GD10748@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2ogddTzD/QdCyZmF"
In-Reply-To: <20150812120146.GD10748@sirena.org.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--2ogddTzD/QdCyZmF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2015 at 01:01:46PM +0100, Mark Brown wrote:
> On Wed, Aug 12, 2015 at 12:12:42PM +0200, Markus Pargmann wrote:
>=20
> > +	select REGMAP
> > +	select REGMAP_I2C
>=20
> You don't need to select regmap, only REGMAP_I2C.

Ok, thanks, will fix.

Best Regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--2ogddTzD/QdCyZmF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVy0GoAAoJEEpcgKtcEGQQc18QAJ/FjclfWpkwhuxuwg71BgHG
9b2imPMp08uLYUa/3E4PkdJF/AspkMgsg0k9dKfVBDhXqkkFGVgxG1bkKsTTVi8G
SQAWDzfnfgTrscbx820eMT2LqALUsRRtfEqkrdevpcZDOWjf8IW4+YRse4RRJq1O
upQbXuk9w506zEF/HiQF2pywDSbSICD1EM6M/Ths6NPYg4rIUqHJEs7DVlAgGReF
aKyHMdGA9FJ0UzOh5kmrMgx5qFS0xDdW/+rMfmTt5LL8DdE2gCGJ0YhkNRWG2ZsE
wNTKQX7mXNVel8lBf1CdzKTk+4qqTPsNMdW2RR35P3t67jaIJrRGjlSfe0Ev+zkX
N+erqXPhyOUn5QDkf+bEYrzg5xzQMZR48mpAzEze3nwAuSrXsmaZXthBmtBsEyyA
WgOahM/pBn2W115NByoMkXPNdcPEHVPoSMJqcgbRUkRp3ZTQTDHsrj+Ne7ebkjr2
wVntvUFENeNTxyH7pT0sWX6jg5btXZVUsreGD+cW1OJkEMT11ahGd4+gMe0EeupC
MzrG2f3mo5s8gYvslOLi40D7ip6eO7AI21oxJY1TP3Y22fG9OdN8lK5gtqJkg8bt
SgD6pPsfIQPn3w1ZnCNfhvhZp+3jYbjJcXVwTDdVYQ3B9EPOBu+OzdVU4SqK68Wu
7JilH7WgZ81dtWh/6tJr
=jQfn
-----END PGP SIGNATURE-----

--2ogddTzD/QdCyZmF--
