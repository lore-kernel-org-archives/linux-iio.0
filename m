Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:60243 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727462AbeHaMzU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 31 Aug 2018 08:55:20 -0400
Date: Fri, 31 Aug 2018 10:48:54 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Philipp Rossak <embed3d@gmail.com>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, linux@armlinux.org.uk, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        eugen.hristev@microchip.com, rdunlap@infradead.org,
        vilhelm.gray@gmail.com, clabbe.montjoie@gmail.com,
        quentin.schulz@bootlin.com, geert+renesas@glider.be,
        lukas@wunner.de, icenowy@aosc.io, arnd@arndb.de,
        broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 14/30] dt-bindings: update the Allwinner GPADC device
 tree binding for H3 & A83T
Message-ID: <20180831084854.q2uh63pw5vprqlzt@flea>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-15-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7p3qpoccm5swps5w"
In-Reply-To: <20180830154518.29507-15-embed3d@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--7p3qpoccm5swps5w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 30, 2018 at 05:45:02PM +0200, Philipp Rossak wrote:
> Allwinner H3 features a thermal sensor like the one in A33, but has its
> register re-arranged, the clock divider moved to CCU (originally the
> clock divider is in ADC) and added a pair of bus clock and reset.
>=20
> Allwinner A83T features a thermal sensor similar to the H3, the ths clock,
> the bus clock and the reset was removed from the CCU. The THS in A83T
> has a clock that is directly connected and runs with 24 MHz.
>=20
> Update the binding document to cover H3 and A83T.
>=20
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>

You probably want to have a look at:
https://www.spinics.net/lists/arm-kernel/msg670167.html

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--7p3qpoccm5swps5w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluJAPUACgkQ0rTAlCFN
r3QNVw//eHYUhx9SLtNW2JVmjst5COBAbdzR6Iqc3V1oI6FYaVLwN/OITksb/EZ7
VAb+x74dB6ujavO4KEAdCN7CVANtGQvp8tYqRkNstVcwhhI8ZM6NpvcNXJ2BoH8C
4s4NhhBm7+CYeT4TT/80Qx5CO+IE4X4JjamCR+YbaJIG6XgyZW4cXXMKz4MagcS7
FU3go/vanGt7lsCJfZUF1+n5LMkrr6FyWqcL+a/kX45Ymr//JmCFqr6lWVR3XDt6
PYQjhboK5CQ4Mvb3XWFRSOmC8TDb8A6tFCxmVgLDmo5YjqsPER/F+yxn0tHFIRL0
l0xXk+enbzMAB7JXj+ahZX+UPF2N4qptOyS9qicxgQiOtqJCMDpgvu1nI2LgGFD1
0Ar6bhpA1SipMPMxUj8injhT4c8rfmbLm34pNtfV82tLDoIj2+IaqrrO2O1jIT3W
/9mIcwoG/r5wbRN53qAfgnMlOhX+kXJrObuwTkKeg4M3CxaVj4Gci46HldXU3763
ujmCRpbiwViIOtK8qlTEOVtGJM3MPobnyg1dwrM6An5dEhAasK0buf3uuNDP7JOe
5W5lGpeZUKlFfpTOGj6xmuzoMDrKdrC+/KNMcf//VEiCAEW09zDjtXmgPr4ztr09
mW4rINcDKXbvUNW9L1dB7UtfKLuTJ6fM7u73NnmideYnYAbSaS4=
=VDef
-----END PGP SIGNATURE-----

--7p3qpoccm5swps5w--
