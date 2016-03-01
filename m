Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:40427 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751056AbcCAUaf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 1 Mar 2016 15:30:35 -0500
Date: Tue, 1 Mar 2016 21:30:23 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
	lucas.demarchi@intel.com, srinivas.pandruvada@linux.intel.com,
	ggao@invensense.com, adi.reus@gmail.com, cmo@melexis.com,
	mwelling@ieee.org
Subject: Re: [RFC PATCH 8/9] i2c: i2c-mux: Allow for NULL select callback
Message-ID: <20160301203015.GC1488@katana>
References: <1455810794-3188-1-git-send-email-daniel.baluta@intel.com>
 <1455810794-3188-9-git-send-email-daniel.baluta@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
In-Reply-To: <1455810794-3188-9-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 18, 2016 at 05:53:13PM +0200, Daniel Baluta wrote:
> From: Adriana Reus <adriana.reus@intel.com>
>=20
> Add a check in i2c_mux_master_xfer before calling the select callback.
> This is necessary so that NULL callbacks can be safely registered.
>=20
> Signed-off-by: Adriana Reus <adriana.reus@intel.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>

Hmm, rather than supporting that in the core, I'd prefer to have the
driver pass an empty function instead. Then, in the driver, we can have
a comment explaining the special situation.


--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW1fvXAAoJEBQN5MwUoCm2UmwQAKXDNlPVbliM5SyNdu8CxLd2
j8G1oyTyvRkDfx8Px7thRAXQ0th45oBSrVXL8Bg1r1NEbDQ2ZzsCesdw7vBkfe9Y
9WXoaVlrt/AKASJ5M0Qj/oO25GQi9zyPx+hBt62zYb99HSGMP9Eh1sQI/u/hH1LF
y79DTs+cm/izdl7m8PGmJfvCPpsjWfbHRKcR0w3yWKnlJyASjGt2A2JxzJ/TnRfr
I4pS+VjjxYWHh/oaU2MYA+cLHkYMioDhc326xsxHyysp6ftKOBYwFFQsKt8zwPgZ
Db6naMpmglO5ZcOV9x4IPoMK2QMxy6k9+Mc4wHalvRSt/qqpC4uM8q4hGvgt2ESg
AfI3UScB3PlQUgc9S5S+IFe0EpOfwfjfhTVMuNuLoIiP//Cj6VaJRZH+cswMf1ZF
aM42R+WMqH5fQ8QECx3AOENt+5wZa/4hKgth5DZE/Sv0Dnxb4RYLyVmqGUWoiwb3
MCpw5gC4egtvS3cWO2lzHB46MEpFDtBlBBzveObZqAaDhn6LDSF1tvV8tF07r63I
XKMYn8UbATD+8BGrQrk7F35HMIaVh0k6xvVBnpqqzj5Nkf43QpEoRJYgM2MfnE40
tV06HhmtDbjWEWug1Nj2RcpRpaUbuRFAKDCwUdkaXixJG4ZLLa1kPybGn01L8f/v
Ky5+l8hcYcn4i20D5a37
=o+WX
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--
