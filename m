Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:44315 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754527AbbHOCMU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 14 Aug 2015 22:12:20 -0400
Date: Fri, 14 Aug 2015 17:34:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Message-ID: <20150814163451.GX10748@sirena.org.uk>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-12-git-send-email-mpa@pengutronix.de>
 <20150812112707.GY10748@sirena.org.uk>
 <20150812123412.GG19600@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8QANErTbuLtKTfKg"
In-Reply-To: <20150812123412.GG19600@pengutronix.de>
Subject: Re: [PATCH 11/20] regmap: _regmap_raw_read: Add handling of busses
 without bus->read()
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--8QANErTbuLtKTfKg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 12, 2015 at 02:34:12PM +0200, Markus Pargmann wrote:

> Is -EINVAL the right thing to return or would you prefer -ENOTSUPP?

-ENOTSUPP is going to be better.

--8QANErTbuLtKTfKg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVzhirAAoJECTWi3JdVIfQgUsH/iCKVKEJ65MlXmdEbm4pRx7h
/dZA/C+s9Uzm+RsH7bLYYqWOv7R80mS+v4LWW5M3DNSgJoXXyyo5rBApUonkdKS0
O31xzOfVyn/aKWXNRjqyq4ay0h+gYFh2h6GC50FbUuHLwcXYbvujafiS8zKdVCT0
WiH1x79uCyFIkIc1GbCaExDArgWpY4zdRKS4DXb1sFN7lmLxgSB9V0VuAyPTusWi
FK6HwfrB7wdPz8assF0t5l3WQyYHdWBAQYgN9vplXy0ez3aTIputZ5nIyJgss6mR
22PGN7Q8sVC2tFcXvm2KgFz03FxO5RdJX4avwcez+RLkRLy+QbTe3ub5Hv9Qde8=
=/7s+
-----END PGP SIGNATURE-----

--8QANErTbuLtKTfKg--
