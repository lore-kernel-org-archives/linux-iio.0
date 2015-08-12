Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59747 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbbHLNIl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 09:08:41 -0400
Date: Wed, 12 Aug 2015 15:08:38 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
	linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	kernel@pengutronix.de,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 02/20] regmap: Remove regmap_bulk_write 64bit support
Message-ID: <20150812130838.GN19600@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-3-git-send-email-mpa@pengutronix.de>
 <20150812102550.GQ10748@sirena.org.uk>
 <20150812104436.GA19600@pengutronix.de>
 <20150812105758.GU10748@sirena.org.uk>
 <20150812122856.GF19600@pengutronix.de>
 <20150812123537.GH10748@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vTm+q/AqrlpK2neZ"
In-Reply-To: <20150812123537.GH10748@sirena.org.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--vTm+q/AqrlpK2neZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2015 at 01:35:37PM +0100, Mark Brown wrote:
> On Wed, Aug 12, 2015 at 02:28:56PM +0200, Markus Pargmann wrote:
>=20
> > Ok, would work for me as well although sizeof is not a preprocessor
> > macro so I would probably leave it as it is. The whole regmap framework
> > just didn't seem to support 64bit so I thought this was just not
> > working.
>=20
> I'd expect the framework to cope with things when ints are 64 bit.  We
> don't try to support anything else, though.

For all non-busses it probably will. All the format functions are not
working for 64bit at the moment. But that's something different, also I
didn't see a bus device with 64bit yet.

Best Regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--vTm+q/AqrlpK2neZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVy0VWAAoJEEpcgKtcEGQQD7sQAJw8AxlWtCyojY70g2dn4MRw
Lc+CUCK3X6HgJph4Gl+XgWbr+2xHH83KhWdpqo8562oQqy5Jmp+OZ7YMmGc7nA+S
4zmLtnuIbA+R6Aa4uwETheTo6C3mUPr3tYv9uIJOJAcZBm8jhQzVtlsET5+36/LA
6YLjteA5zzT56xkkdHKVz9HoASbMvIZAtqGWQ5leFoqTdbKGnlekFidyTZMekl/V
B6eiXJdYywrgKMxPJmf1y9W9GL9lHi25tCo82tHcxU34UJJnSyay51KK9kFZMhxs
EDgvFwIzf/bIUrjl7zZQewaKIsRaCpgMO7oxPG3DWSrJT+GK/eAbPYFoip8dnU/+
tw8ni/WIcp36Uv2s2gECxFeAreMr4UNkPvtWUzxLmspmPSy1y73AnCuf53WK8HlG
vfAkGQYCMOImxeXH38t8j6qRxrcJwZA1mDkJ50xODNxpZXBG5BSzgCv4Az+L8VVA
pXSFHFFIL/a6xykNi2JnY/cYs+V9ufW0SXi0EK4fBsGuBCiMjWvPduQEmKZrKNX1
zSxmZ49hPOa/AAGPxplJyb+P5zYeZSAviCISq4/b1px1waLF2adg0xeEQ83P+Qcs
vjQbcvEkyZp41H7dao/Z1e7ubRVLtSLiPjsJ76STChW7OFOYSLaRvwmOL256nIN+
5jdqUQSXr2zCFHNf3GEH
=Pdd9
-----END PGP SIGNATURE-----

--vTm+q/AqrlpK2neZ--
