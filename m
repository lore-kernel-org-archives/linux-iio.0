Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:40435 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbbHLMfm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 08:35:42 -0400
Date: Wed, 12 Aug 2015 13:35:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: linux-iio@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
	linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	kernel@pengutronix.de,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org
Message-ID: <20150812123537.GH10748@sirena.org.uk>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-3-git-send-email-mpa@pengutronix.de>
 <20150812102550.GQ10748@sirena.org.uk>
 <20150812104436.GA19600@pengutronix.de>
 <20150812105758.GU10748@sirena.org.uk>
 <20150812122856.GF19600@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Eb2dXAwtBqAM4EkP"
In-Reply-To: <20150812122856.GF19600@pengutronix.de>
Subject: Re: [PATCH 02/20] regmap: Remove regmap_bulk_write 64bit support
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--Eb2dXAwtBqAM4EkP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 12, 2015 at 02:28:56PM +0200, Markus Pargmann wrote:

> Ok, would work for me as well although sizeof is not a preprocessor
> macro so I would probably leave it as it is. The whole regmap framework
> just didn't seem to support 64bit so I thought this was just not
> working.

I'd expect the framework to cope with things when ints are 64 bit.  We
don't try to support anything else, though.

--Eb2dXAwtBqAM4EkP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVyz2YAAoJECTWi3JdVIfQiZwH/jUdTmgjOUbkZdQ4YjirGJb1
XrbBE1TE+lkthJSnRO8nVXxOp7KbGG8W6rr35mOyowWe7oE1NFfcQvhlR7fugJEi
UTQO3E+vl70BgWvMilAWSqMZTngQAqY0NJ5VzV49y7IWbX5GgOalggQa8gyn7v50
jaWVXbVgM/ZNXaOJEbZH+D1DFxTAU87ucQtk2Bh87d3LewogAjllB3DAioqLDNBj
XDVNCrQB06ZWyesVJMKQqBEck1g3HnWlYYeQM2mpwDHeubpQnp1dt/4bTrNilpth
OIVCmRw0dO/jxqTKxxUiAZUk0e2rbOhB4pi9DICAOsoh0Z1qcn/GVpRCVKnFOWg=
=tAFI
-----END PGP SIGNATURE-----

--Eb2dXAwtBqAM4EkP--
