Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:58207 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934085AbcLUMUW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Dec 2016 07:20:22 -0500
Date: Wed, 21 Dec 2016 13:20:09 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, lee.jones@linaro.org, linux@armlinux.org.uk,
        stefan.mavrodiev@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@free-electrons.com
Subject: Re: [PATCH 1/7] Documentation: DT: bindings: iio: adc: add
 documentation for Allwinner SoCs' GPADC driver
Message-ID: <20161221122009.2gcidvhnmomsiagc@lukather>
References: <20161220102709.9504-1-quentin.schulz@free-electrons.com>
 <20161220102709.9504-2-quentin.schulz@free-electrons.com>
 <20161220142554.rcocnculfehiwhpn@lukather>
 <61dc140a-5ef1-f55d-e749-cb816a014705@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wkx6ljrqmdcah546"
In-Reply-To: <61dc140a-5ef1-f55d-e749-cb816a014705@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--wkx6ljrqmdcah546
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 20, 2016 at 04:43:58PM +0100, Quentin Schulz wrote:
> >> +
> >> +Optional properties:
> >> +(for use with thermal framework for CPU thermal throttling for exampl=
e, and/or
> >> + IIO consumers)
> >> + - #thermal-sensor-cells =3D <0>; (see
> >> +Documentation/devicetree/bindings/thermal/thermal.txt)
> >> + - #io-channel-cells =3D <0>; (see
> >> +Documentation/devicetree/bindings/iio/iio-bindings.txt)
> >=20
> > I wouldn't list that as optional.
>=20
> In what sense? Do you mean you wouldn't put them here at all or you
> would require them?

I would require them.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--wkx6ljrqmdcah546
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYWnN1AAoJEBx+YmzsjxAgxloP/3SLcMQYmhgpvsPH/8Ec47ry
gc3WnVanuSAdN6Bl/ul9tYFiRivRAOGL5ablSPquMfGXCiLO+L1Euy/mGvDQ1Ryc
RgG+Djl1w5783nQBPFmnywg/w1ah60+LKi5uiJTJ+jFKvHmZTVHhLk92oLAnAItA
ircElhr1Xr0+0R/njW1HRWy3cXHXPOApGghao1lsGcVrUkJTEJqfIhy3ERG/BoQk
dOF+z5QXicaC0lXGd8ginsXGE1/Uo3svPR5F9Aa+55IVk8+r1RcpJPLYR7JstA9d
1o2kgGU2yddWzL0/lQ5U5PESUWRuXhytCcCjM2xO7PznZN5zpB5prro2QvilYWzh
5YHAn7STCZtft1W/F50+zA1DeNSGtbgIPRnILF5Mk2czE/713WBTR7He5u8Q7oYz
jV/jbWiygcq56ISpJFcSnxKF0j9aLgbZB/VY5udcXD0GT0KAo/4sFFipV7rGqLWw
ASUCUyQ/s9JgYiip0dQ+JqknsdZT8/SDfUtHrO+C/1PM3oBeJw8/M8PajKiBxMR6
h3yRPrhlBuMOOmQk0xaVJ57hQO7jsUG+bkRbGXodx2JBcBdSYfz+/SIfrUPAXG+o
yFtdntczufEaiPCFvRhdHqWrP8Ci5Rfqe9/ZgrCv4U3g2DutfgTMUvu3FZDo6YLD
rt5cqfqe5Z+bzUCm6gpQ
=6z6F
-----END PGP SIGNATURE-----

--wkx6ljrqmdcah546--
