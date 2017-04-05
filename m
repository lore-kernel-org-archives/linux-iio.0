Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:42944 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754516AbdDEMRV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Apr 2017 08:17:21 -0400
Date: Wed, 5 Apr 2017 14:17:18 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, wens@csie.org, lee.jones@linaro.org,
        linux@armlinux.org.uk, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net,
        thomas.petazzoni@free-electrons.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-sunxi@googlegroups.com, icenowy@aosc.xyz
Subject: Re: [PATCH v4 8/8] ARM: sun8i: sina33: add highest OPP of CPUs
Message-ID: <20170405121718.4lldpkcnfoxgrsmo@lukather>
References: <20170405090634.4649-1-quentin.schulz@free-electrons.com>
 <20170405090634.4649-9-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="brsv5ugjn376kqsc"
In-Reply-To: <20170405090634.4649-9-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--brsv5ugjn376kqsc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2017 at 11:06:34AM +0200, Quentin Schulz wrote:
> The A33 supports 1.1GHz and 1.2GHz frequencies at 1.32V and the Sinlinx
> SinA33 has its cpu-supply property set in the cpu DT node.
>=20
> Therefore, CPUfreq knows how to handle the regulator in charge of the
> CPU and can adjust its voltage to match the OPP.
>=20
> Add these two CPU frequencies to the CPU OPP table of the Sinlinx
> SinA33.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--brsv5ugjn376kqsc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJY5OBOAAoJEBx+YmzsjxAg2T0P/1c/I30NjdKkxtllALmBts+t
vYiUJdENl2SxI7e6EeJfQATfm5SnuiQok+aZeT0AbI2addIdtuje+HMD0DVuiABJ
LnCop43drIzKO17NdIG8RO4rqMgCtltO2WeKoxw4x8G5TtwwICrRBu/AbfhRO9Bt
DB7wIOufUrsNvUnu4qNuW/se5kFb/tL7Uy8GvOU27vHRtACR3pRIy98cdEbiKIMC
dexi71P1tDUGoec425lTUz08TyvJ1MNs0oHNpDQVRncsvaQm/mfs3yc8Thi4J1f/
tJuYIw3I6dLLwoBdGP2XBE7CHQ79OScedue5dyHE2/p2tAQjVRWlP6kmz8MUUw/Q
0M9JnXdlm6yy3//dmHBVJK0XfwmADNH8V7ghc8T4I+EvCb8jG+LxS85B1eSZ4WWH
M3DKJO9wdNx2LMx2JVxXymS7/nhRaNlfrScEcqO9Vp7G2rfJXEGQ+2SR3zZ8abLQ
zAeMu1MGOT3nGMbE2Aig6dQTExit8vC0EAe3QzYPhvUYHAkSI7UpePoPIm7rEmUR
qd46/wMsAw17ttc/xYruLbW3Ska4MfKTe59G+GriQQdVxacXjb7rI8FZu6F0jdJi
oOHfSDdeq9y785Xfz7/MAytmWo+d0NUEFJyr8jstmIGH9o7A8XSn5S2XFukY6ZBB
iKU5GE2wttvgKUuqdjn/
=YObV
-----END PGP SIGNATURE-----

--brsv5ugjn376kqsc--
