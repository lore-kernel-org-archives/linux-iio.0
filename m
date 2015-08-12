Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42794 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754263AbbHLKro (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 06:47:44 -0400
Date: Wed, 12 Aug 2015 12:47:39 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH 00/20] Regmap max_raw_io and bmc150 SPI support
Message-ID: <20150812104739.GC19600@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <20150812103736.GR10748@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FYos7FMnk2wAe7eG"
In-Reply-To: <20150812103736.GR10748@sirena.org.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--FYos7FMnk2wAe7eG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2015 at 11:37:36AM +0100, Mark Brown wrote:
> On Wed, Aug 12, 2015 at 12:12:25PM +0200, Markus Pargmann wrote:
> > Hi,
> >=20
> > this series was created to add SPI support to the bmc150 accelerometer =
driver.
> > To not add any regressions, I had to add some infrastructure that allow=
s to use
> > regmap with busses that do limit the size of transfers (block smbus). I=
 hope
> > this is sufficient to not break anything.
>=20
> This is a really big series but looking at at least the initial patches
> there's a lot of unrelated cleanups mixed in with it.  Please don't do
> this, send things like cleanups separately so that your series is
> focused on the relevant topic.  This makes things much easier to work
> with.

Ok. I can try to separate them but there are lots of dependencies
between the patches and most of them touch regmap.c so I thought it may
be better to put it in one series.

I will try my best to separate them for the next version.

Best Regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--FYos7FMnk2wAe7eG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVyyRKAAoJEEpcgKtcEGQQa6gP+QEx3jQkQlEQOd+Q9hUaft17
8h2FHzeLM4VSwVHeOKnJ2czx/1BK4FKyTa05dk+xqpp+9LYv42ey30Q1ANYR9Cym
pCLpSHpv01nKcYB+6Yv0pjPJDAWqlwrySPyMohwjPe6S/Tv5neh09PltrlXCLJbb
U+x1ftcG73GRd/aD31XSN3iklqt5xRY52iTrJVpSWzVXTIXIjBKTN9uGeHjAPRRI
LyGNdmuldEfnuPRlzSAsP3rwpmm6YTaDq8A/HkyR1PCuSJx87Ck+QuvHtjCK9rsH
IFkJp8wwRackJsYhyDFzg/6f3w8VIVIPL29K5StPtHd+pDVlUUOcCfD6dmmLTUgu
lbxfQuC3YXHjRAEeK4I/y7dI3h7tQrfdjTWtLIDN+/UGvFeiq3QY6V0R2aao2UAt
RLzmyzIAYL1dEyzbZXa7ZHC0PnP1uoscxBPQ1OsZeWI0ubDUoYzJHVSnOrumRtXt
VV8SprpF44zgy4LdqD0/v5TBwVoTjMwao748PRBinfNl1nyQmmAkarEDmaJi4uNE
wBrEJUOAFtGxw5IEQYcItChufLJQMjp8Nb/sPPcowuYAuiMDTZB7Fac16uxhK1fY
MhhKC/02SuI/aDjt2Qw1v5f0KFwlg+m+agVUJoogt2IPGMJfZEGPGiFxXmosk5XM
1hM8o6Jza5W432OqBbK1
=LNuH
-----END PGP SIGNATURE-----

--FYos7FMnk2wAe7eG--
