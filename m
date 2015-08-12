Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:40192 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbbHLKoB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 06:44:01 -0400
Date: Wed, 12 Aug 2015 11:43:55 +0100
From: Mark Brown <broonie@kernel.org>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Message-ID: <20150812104355.GS10748@sirena.org.uk>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-5-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O3bhLwMadv7h6/J9"
In-Reply-To: <1439374365-20623-5-git-send-email-mpa@pengutronix.de>
Subject: Re: [PATCH 04/20] regmap: Do not skip format initialization
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--O3bhLwMadv7h6/J9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 12, 2015 at 12:12:29PM +0200, Markus Pargmann wrote:

> It is not obvious why format initialization is skipped here. format
> functions are used for example in regmap_bulk_read even if bus is not
> set. So they are used even if skipped here which leads to null pointer
> errors.

> This patch adds format initialization for !bus and !bus->read/write.

Format initialisation is skipped because it is not clear what the wire
format actually is if we're not using the regmap internal marshalling.
Someone needs to do a survey of what the existing users are trying to do
before changing anything here.

--O3bhLwMadv7h6/J9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVyyNqAAoJECTWi3JdVIfQ4LsH/1O1MyF+BG2ei9KHfOYXaihl
zSoavMOGjvVCI8Qz2M7p+bXhhWS2T/5IQRq24pXu5zbXBtztNTZjjaiLknIpiSm5
Aa5F3IphJDhL166Kr9jEjPVVN7i3ufeC2Cs+oc5nICMiryWrFD3LueFrL49eVGdw
ChX7alIU1JYIx5R0tMQhY0R1inWiuvvOFkINmyWGH2aEbyd4+wl1qZxTpwLDe/Tx
ob8JEC275XK7qz4hJw8+Aphh+FjJ1D9RxRUkpbIRH5P04sMd1KkhkM45sA2UcIyr
sI4XD7b0NZzJDDksUjx2/Ln2+nQFijcfu3HfDpH/hGx9Rfon3WKrT4jLcIZZUsQ=
=hTM+
-----END PGP SIGNATURE-----

--O3bhLwMadv7h6/J9--
