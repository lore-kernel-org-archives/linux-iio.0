Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:40447 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754155AbbHLMj2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 08:39:28 -0400
Date: Wed, 12 Aug 2015 13:39:23 +0100
From: Mark Brown <broonie@kernel.org>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Message-ID: <20150812123923.GI10748@sirena.org.uk>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-11-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8D3PigL67BfDl295"
In-Reply-To: <1439374365-20623-11-git-send-email-mpa@pengutronix.de>
Subject: Re: [PATCH 10/20] regmap: _regmap_raw_multi_reg_write: Add
 reg_write() support
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--8D3PigL67BfDl295
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2015 at 12:12:35PM +0200, Markus Pargmann wrote:
> Define a fallback for busses which do not define a write() function.
> Instead we write one register at a time using reg_write().
>=20
> Without this patch, _regmap_raw_multi_reg_write would break as it tries
> to call bus->write() without checking if it exists before.

Why are we trying to use multi write APIs in the first place if we can't
do raw I/O?

--8D3PigL67BfDl295
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVyz56AAoJECTWi3JdVIfQ8DcH/1QaD1LZS8pgnzT55iHMC6Nv
cbn3xX8OPilN4NzZPgB5ZoLN/kWXZac+7hGYeuCZWOFLvVMFCAQRQD+GpPsn4n61
epn4c+/F214wfK1MJPmAZVIYW3YiC9cltJwhugvnkgvK7INAw/E8i9q39gb87nJf
bUtKwiXIOimkc0CvkQg96OPrxCyyTAOs2bIwSCcrFCAv7ZTLg9BRDI9cTZOxCjXC
PXnpiCp/mElzmFvDwxwStdpMgDraTMi3MQI2ZtB1b9cJope8bD9BG9CHhuDZEl9F
w6Owknkll6q5+lzKqfP7w8QXgHdjbBjEw02H5WwzkPVKAEanWH6mY1Jls5FYWTw=
=5mcj
-----END PGP SIGNATURE-----

--8D3PigL67BfDl295--
