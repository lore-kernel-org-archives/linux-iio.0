Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:40262 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbbHLLKp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 07:10:45 -0400
Date: Wed, 12 Aug 2015 12:10:31 +0100
From: Mark Brown <broonie@kernel.org>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
	Stephen Boyd <sboyd@codeaurora.org>
Message-ID: <20150812111031.GV10748@sirena.org.uk>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-7-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ipiAXJWFVZGVDOzf"
In-Reply-To: <1439374365-20623-7-git-send-email-mpa@pengutronix.de>
Subject: Re: [PATCH 06/20] regmap: Fix regmap_bulk_write for bus writes
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--ipiAXJWFVZGVDOzf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 12, 2015 at 12:12:31PM +0200, Markus Pargmann wrote:

> Cc: Stephen Boyd <sboyd@codeaurora.org>

I'm not sure why you're putting this in these commit messages...

>  	if (!map->bus || map->use_single_rw) {
> +		if (val_bytes != 1 && val_bytes != 2 && val_bytes != 4)
> +			return -EINVAL;
> +

switch statement please.  This also looks like a separate change to the
handling of single writes.

> +	} else if (map->use_single_rw) {
> +		/*

How are we ever going to fall into this else case?  The first check has
an || map->use_single_rw it so if this is true then the first check will
be too so we'd never end up in this else case.

--ipiAXJWFVZGVDOzf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVyymnAAoJECTWi3JdVIfQ2y4H/35NKVVviLUZ2GxHvmjkdTt7
NqsqdcxWGZZ8JaJaW/itEijaXZbctFGnod8JX6WTLZELSTEwgtyPiEAESG1mXrGU
vi7GPL2UoDeQ0NeyjouufRVJ02hHdVK4NXsD9REEvUDQJ57l8cBZdKGS4QDHfI77
ZTJIQy6T4oOr9MDE/TIihZJCYRyTLxofom0IcA8fRIAz6sa/wKmNSySVECK39fs4
WyOGKbIXUQ1AbbZDLS4mo9EnJKaIjNtLWoqMBPEKRJmtDWQRjvyAbDRqWC41qqGY
44/gyKagUCqlD7BNZv57LDU8ampSbXuD43Sods1mzRIYZNrFPQr1SBGp1rVnIxk=
=QXZD
-----END PGP SIGNATURE-----

--ipiAXJWFVZGVDOzf--
