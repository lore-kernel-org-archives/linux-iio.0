Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:57426 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751847AbdHPUeG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 Aug 2017 16:34:06 -0400
Date: Wed, 16 Aug 2017 22:34:04 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Andreas Klinger <ak@it-klinger.de>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] iio: srf08: add support for similar devices and
 triggered buffers
Message-ID: <20170816203404.ff55ct4wgnipgkog@ninjato>
References: <20170816193257.GA24393@arbeit>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jw2usm76pwcqkyta"
In-Reply-To: <20170816193257.GA24393@arbeit>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--jw2usm76pwcqkyta
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> @Wolfram: please let me know, if you want a separate patch for [PATCH 1/5]

I moved that file out of the i2c directory because I don't want to
maintain it. I even wanted to delete it but Rob thought there is value
in keeping it. So, it got moved. If this series had been rebased,
get_maintainer.pl would have pointed you to the right people. I dunno
the IIO workflow very well, and Jonathan didn't answer yet, but this
base is too old IMO. Jonathan?

By the way, is it just me, or are the individual patches not in the same
thread as the cover-letter?


--jw2usm76pwcqkyta
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmUrDEACgkQFA3kzBSg
KbbL8g/+N+WagM1uStfTnAeW6L+ZGtcs5WW23jN5j27DRdX+fMnpMgwkfWnX/Aue
fd15oLaXl41L/W33Wf0JRDlPfjEl8WoTGmR+C49KzGk9tbW6s7Sjy2THGduJSOJD
4oo+XRfQeKBQJKp/XTiJTvCt+c/JfVcm7dxkun0Widb+xNAhJQy6a46JdpMY8MVB
EGdQ7AzJdzMoOLxfIKmoG5oMTy5FMikBzMnqqB5EgBZtxRgQFkBWod7Ik07YL2QF
6kie1QFBc+xPHmtBKthliHM3p/0qSBPbs7rIaKelLTqn1nGyq4G1fMP/jIBUXvlx
Pg0vRapC5ATuPxdjTS/27ckjonKrJhn2JW4794ZHFzmXV37fy5ZYo+BJjfPejjRq
0ZC4TnigTWcaAwdEtIYiwHJVlhJSHyxcquDSSmQtd68d+a0M5/PgEUYNcAhjxqQq
5wp6p2PFW8BChIzbbGvz1D1yO3XqSTnWc7x0rYzg/m06a7Q8H7WAR/dGWqfNdVCL
1sb8FOQcyXpdwixwZpi2n3BH6t4/0V4p2EoIpWVGkmWQJkB7moowZNB2/2lrFQNU
FNZcssH2S99sjXFAhhalS/UIFQ1yD3Ww73ZbnhvvfRmpQAPOLpbLKcfYMU2jL6yv
ICrk/mnVuac4y8c5CXdekJ+4nFJwkncVfbpSHQws16UbVCTf82Q=
=adjE
-----END PGP SIGNATURE-----

--jw2usm76pwcqkyta--
