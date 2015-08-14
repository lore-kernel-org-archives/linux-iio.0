Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:44289 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754413AbbHOCML (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 14 Aug 2015 22:12:11 -0400
Date: Fri, 14 Aug 2015 17:34:19 +0100
From: Mark Brown <broonie@kernel.org>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Message-ID: <20150814163419.GW10748@sirena.org.uk>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <20150812103736.GR10748@sirena.org.uk>
 <20150812104739.GC19600@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/eSpIzx5LyAe5lwl"
In-Reply-To: <20150812104739.GC19600@pengutronix.de>
Subject: Re: [PATCH 00/20] Regmap max_raw_io and bmc150 SPI support
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--/eSpIzx5LyAe5lwl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 12, 2015 at 12:47:39PM +0200, Markus Pargmann wrote:

> Ok. I can try to separate them but there are lots of dependencies
> between the patches and most of them touch regmap.c so I thought it may
> be better to put it in one series.

No, just the opposite - it means there's much less structure to the
series as it just becomes a sequence of unrelated changes without
overall aim or common theme.

--/eSpIzx5LyAe5lwl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVzhiLAAoJECTWi3JdVIfQzDQH/2NV9ExZRdqMjJroJSmVoDmi
9bE7x8w9esjRsEl+nClseC2cHmzAJQz2xWDU6vltNsroxye4TF1e9+OzIqUQkByj
wU1kg3bbRrcMY28BDsJUejqVMyWFuXMZ1+rousBOO9yjFo5VwMhgTEIQwa4a+1LI
p9EBI2bJ4zcrx6VAjI7smFpZVKZKa39OVcAfcOCvBIgmxGZd4sgUSrooyB8E4VCN
HPRN79ZmOpypx8asL2dbtnx8WU/hPoxMbagLAQeGIbl7XANFg3ALFRZgBWlKhqUr
jB3JiUbXgYOQG+hIkNd/t1p9oktLoobraNWNa5ty0VmfPMuKX0Ni0zWk9Q39E2Q=
=hBiS
-----END PGP SIGNATURE-----

--/eSpIzx5LyAe5lwl--
