Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:40369 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107AbbHLL7n (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 07:59:43 -0400
Date: Wed, 12 Aug 2015 12:59:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Message-ID: <20150812115936.GC10748@sirena.org.uk>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-16-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wbs6g7essDTrqL3S"
In-Reply-To: <1439374365-20623-16-git-send-email-mpa@pengutronix.de>
Subject: Re: [PATCH 15/20] regmap-i2c: Add smbus i2c block support
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--wbs6g7essDTrqL3S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 12, 2015 at 12:12:40PM +0200, Markus Pargmann wrote:

> +	if (count < 1 || count >= I2C_SMBUS_BLOCK_MAX)
> +		return -EINVAL;

Elsewhere you added returns of -E2BIG if the transfer was too big, why
not do that here as well?

--wbs6g7essDTrqL3S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVyzUoAAoJECTWi3JdVIfQ4HMH+wQraNxvBPCNOPF8ycBcWRzN
aB+A4aaAJUFhNCJCTEQbYNJrhwtw7IKRT89d4cB5M/dVWediizaCuYX5MWPZ8ejP
8tLLgNOT1TpuklfqSIcL6lTU0lzZ/bWwgCe8gyWv1GQDnmcxQgAUJjUax8f9fvi+
N01XMo0iB247asE4FfQF/IJ7SAW/xse+dS7qrsLtPH7phZRg0cBv4DtWylQR0PR9
6HqbPVnewz8AOJPUknCdoNNMRuTDEjVLu4ee58w8rzx1XRhAiTmnHwivYICeqwrZ
G3yaWAAL1R4TH1Hp+c3l0VSoPhjUi3mhS5Xb+zchBoOJlwqBDoAekZekOvMEY2U=
=t4QD
-----END PGP SIGNATURE-----

--wbs6g7essDTrqL3S--
