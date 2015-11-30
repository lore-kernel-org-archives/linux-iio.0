Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34265 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752311AbbK3RaS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 30 Nov 2015 12:30:18 -0500
Date: Mon, 30 Nov 2015 18:30:10 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Nicola Corna <nicola@corna.info>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>,
	Eric Anholt <eric@anholt.net>,
	Jonathan Cameron <jic23@kernel.org>, linux-i2c@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH 4/5] i2c: add i2c_check_quirks helper function
Message-ID: <20151130173010.GF9554@katana>
References: <1445976718-7449-1-git-send-email-nicola@corna.info>
 <1446118467-26453-1-git-send-email-nicola@corna.info>
 <1446118467-26453-4-git-send-email-nicola@corna.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fwqqG+mf3f7vyBCB"
In-Reply-To: <1446118467-26453-4-git-send-email-nicola@corna.info>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--fwqqG+mf3f7vyBCB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2015 at 12:34:26PM +0100, Nicola Corna wrote:
> This patch adds a i2c_check_quirks helper function to check the quirk fla=
gs
> of an i2c adapter, in a similar way to i2c_check_functionality.
>=20
> Signed-off-by: Nicola Corna <nicola@corna.info>

Applied to for-next, thanks!


--fwqqG+mf3f7vyBCB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWXIeiAAoJEBQN5MwUoCm2g6cP/3XU7YdtJOWLUeX0UwFBuAnh
KSHnjV60jYwhGYroyr1J9NmPzWrKKXhal9P5UYb4aBgxjm1/Lu6vIoHc9bQLbn90
Nv5wsJOsQsqyIgtu7tRuPj/Qd1PbjJVpbHpohhdUrVvd/gkRmMLGLZbuUIpO6SKt
tbokNnWu1w46W44YRGoLlFDcJW9H4I0m6vZGmMuNfbIs70aWYWRONRCsUsINBq+v
rJLHz3+pi4GKVEhhSAyqLGx+n1pw0ECboCfPjtKhF8v3TDpEJrmzX3fvaHB4j0a1
H9cNRl+sziJuSSVq0GFGZMviZFRLaKwSzICBX8fT05sCmlxPXCIrSMvjCa4qKL3d
ihBc5qLTh0twA6FBAGTViHc0bPGDtCqMiz8JPpIKHeA8rRCtMdzNJ1saZwk/Znpb
bVQ28oK3B2CYW5lcCZABayfsokiMWoPNP3rGpj26Mgjcngd5Q8Kw5eqmkpuzfzMo
f+V6+fAUjHt4C/Qrrf75887JKtoYR8RpLsr5OvlW8E2Aem+cYrxf4AFJdNMYbMUx
u0gVufnq+/o5GO9fk/cDJYdnHEOWu8dGR38F/u5s6qXFdO3RGSHNaGnqLonn0v7Q
Kt5VBrOvfDTPCIDp9aZGzLZkXsMciYzGJQIVnZeEP1LrucccjAIgDJv4m8rP0/DO
QtoHdMsiY1UmiLZ780WU
=e7Hd
-----END PGP SIGNATURE-----

--fwqqG+mf3f7vyBCB--
