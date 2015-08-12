Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59348 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752941AbbHLM26 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 08:28:58 -0400
Date: Wed, 12 Aug 2015 14:28:56 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
	linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	kernel@pengutronix.de,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 02/20] regmap: Remove regmap_bulk_write 64bit support
Message-ID: <20150812122856.GF19600@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-3-git-send-email-mpa@pengutronix.de>
 <20150812102550.GQ10748@sirena.org.uk>
 <20150812104436.GA19600@pengutronix.de>
 <20150812105758.GU10748@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82U+nxpba3czjIX9"
In-Reply-To: <20150812105758.GU10748@sirena.org.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--82U+nxpba3czjIX9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2015 at 11:57:58AM +0100, Mark Brown wrote:
> On Wed, Aug 12, 2015 at 12:44:36PM +0200, Markus Pargmann wrote:
>=20
> > I wasn't aware that any 64 bit architecture actually has unsigned ints
> > that are 64 bit in size. So wouldn't at least on x86_64 this would lead
> > to a compiler warning as unsigned int is 4 byte and u64 8 bytes?
>=20
> Nobody complained about warnings yet.  The compiler probably shouldn't
> be complaining given the casts, they're supposed to be an "I know what
> I'm doing" thing.  If you want to change something here it's changing
> the test to be based on sizeof(unsigned int).

Ok, would work for me as well although sizeof is not a preprocessor
macro so I would probably leave it as it is. The whole regmap framework
just didn't seem to support 64bit so I thought this was just not
working.

Thanks,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--82U+nxpba3czjIX9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVyzwIAAoJEEpcgKtcEGQQukUP/jS+Fs9jTP1gWXXikfGd3NFK
iZLqV66RzdyWyCNCX6/zSLKUm9NMYIAr996ek/sUzXDsFKM9IZP6htBKwTftm3e6
+but1sIrxS42gFr3I9LwygpPlN+31uB5HJcwjXG6yZ2NRLoCLBF4lEHUqh9h386O
+urD5rP3tx154OkH7p72hJZUDr8tuEXHSHuEPDqMNkBZ3bKoFzXbRTCCjdKX40BT
w92GLgiIFo7ogA7QeZ9ekczQ+2f3zEZOft20ZauCGIUxu1Aa3NX4mFgCfjYaRmqp
yIe/U3JwXAkTjBFYw3L7HVpqcCSzayBqPL9O2dULGeBjzRPRFTfTMgucseY/2vwj
DqWk/mtYZS8Bjr9k3WQbCPyhG6++dHZGF5qEdwSfWVXy/M9q9t+0tx/uH6x3jsFt
MdriGN4BFeB5YQ6AT6obqoX6rYRB4l16CH/czmzZtXb/SCI9s0kfnhCTImv/u4HA
tPgAZQ68ZcGCUBh6rfSVQeh+qQS2z1KPeeW5IVFhDClzURinKvZM52NYibmR9KE6
lWAnnJCXuF3TyUB4cpC7YpLTEWihphdsn4TfrV2tzqXk8WcH5oNkBvEGaBnlURgQ
TnDhRROSYL2JVzyMwhhjexvr3n44K2NKU33NzZMYivyUdgBkxfTW5LIRCwfMSqR4
zYZ6WFNsKSV7DZP5B9l+
=8r6W
-----END PGP SIGNATURE-----

--82U+nxpba3czjIX9--
