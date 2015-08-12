Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:40551 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753542AbbHLO4w (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 10:56:52 -0400
Date: Wed, 12 Aug 2015 15:56:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: linux-iio@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
	linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	kernel@pengutronix.de,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org
Message-ID: <20150812145633.GJ10748@sirena.org.uk>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-3-git-send-email-mpa@pengutronix.de>
 <20150812102550.GQ10748@sirena.org.uk>
 <20150812104436.GA19600@pengutronix.de>
 <20150812105758.GU10748@sirena.org.uk>
 <20150812122856.GF19600@pengutronix.de>
 <20150812123537.GH10748@sirena.org.uk>
 <20150812130838.GN19600@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tez2gqrut5pn4jhH"
In-Reply-To: <20150812130838.GN19600@pengutronix.de>
Subject: Re: [PATCH 02/20] regmap: Remove regmap_bulk_write 64bit support
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--tez2gqrut5pn4jhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 12, 2015 at 03:08:38PM +0200, Markus Pargmann wrote:
> On Wed, Aug 12, 2015 at 01:35:37PM +0100, Mark Brown wrote:

> > I'd expect the framework to cope with things when ints are 64 bit.  We
> > don't try to support anything else, though.

> For all non-busses it probably will. All the format functions are not
> working for 64bit at the moment. But that's something different, also I
> didn't see a bus device with 64bit yet.

This is expected to be used by memory mapped devices.

--tez2gqrut5pn4jhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVy16dAAoJECTWi3JdVIfQoDsH/3f572NLjigFPewQPj9s7hGf
fhKYTqTpiWRCxtf9CA72+4Y18VndFgz4gRi+HKluwQHPHAIDEfvjwplXGV1PljpA
0rmUZjKN/dZJz/4sT/+CGiFvEul1Ii8d5qH0ILD3yrIw3YsK41dbesMMLE2c0Lb7
kEyZ/hW4zorngJoHd2AHp5RJ37RCZm8jJnEe+8TVsYMydLa1eFA7jkVJr4zKMyBr
gLFaRpk2Qfu7mFxoTGKvn5X0/8pL6qOJlryIWaGb97/lksxGpcoxUlLnJEEJyMTQ
Jqg/K7FOw3SMuWD+odYu6kguEvrCWlw6saM56NSbnHF2SUjaOQ6Bnb7FhYt0JMw=
=qQ3l
-----END PGP SIGNATURE-----

--tez2gqrut5pn4jhH--
