Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:40219 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881AbbHLK6F (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 06:58:05 -0400
Date: Wed, 12 Aug 2015 11:57:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
	Stephen Boyd <sboyd@codeaurora.org>
Message-ID: <20150812105758.GU10748@sirena.org.uk>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-3-git-send-email-mpa@pengutronix.de>
 <20150812102550.GQ10748@sirena.org.uk>
 <20150812104436.GA19600@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2F7AbV2suvT8PGoH"
In-Reply-To: <20150812104436.GA19600@pengutronix.de>
Subject: Re: [PATCH 02/20] regmap: Remove regmap_bulk_write 64bit support
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--2F7AbV2suvT8PGoH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 12, 2015 at 12:44:36PM +0200, Markus Pargmann wrote:

> I wasn't aware that any 64 bit architecture actually has unsigned ints
> that are 64 bit in size. So wouldn't at least on x86_64 this would lead
> to a compiler warning as unsigned int is 4 byte and u64 8 bytes?

Nobody complained about warnings yet.  The compiler probably shouldn't
be complaining given the casts, they're supposed to be an "I know what
I'm doing" thing.  If you want to change something here it's changing
the test to be based on sizeof(unsigned int).

--2F7AbV2suvT8PGoH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVyya1AAoJECTWi3JdVIfQ2CMH/RlYfWtPEGQlvjxdiIxX9QNB
E/P4Rq+BxIHC7PE7MpUzeV2jzFeUaishegE+xko7Q6+y3QhDSh1XlCGTTKf9AOKw
fq90Au7C9JUzmvh9OSL5h+ofm+BPiKWvlyYBLhHs1wFhizbceWHAedcCQzc8NT/T
K91ZzNiBMGWYZxVqfu3wQMsQ+DYGRPV9z6H6gRCMsWn/ydw884tkdufxt0CI0jiY
w5hsqEqQBrBG+5hKGMwUra35LsNyMJESCv2HVuya2zU3a5VK6xwtvyFWCui9N/2Z
ajZarTtBeZK+npmw4QM8luvYuhk/UqXZRNu2SUObviMK6N1+aQWTAUSL2zgaCEU=
=NRMu
-----END PGP SIGNATURE-----

--2F7AbV2suvT8PGoH--
