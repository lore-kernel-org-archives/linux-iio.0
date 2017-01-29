Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751705AbdA2QZm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Jan 2017 11:25:42 -0500
Date: Sun, 29 Jan 2017 17:25:37 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        linux@armlinux.org.uk, maxime.ripard@free-electrons.com,
        lee.jones@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@free-electrons.com, icenowy@aosc.xyz,
        bonbons@linux-vserver.org
Subject: Re: [PATCH v2 10/25] power: supply: add AC power supply driver for
 AXP20X and AXP22X PMICs
Message-ID: <20170129162537.npe25eklgml3m25s@earth>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
 <20170127085458.18270-11-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xfk4z6zclvyfzk3a"
In-Reply-To: <20170127085458.18270-11-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--xfk4z6zclvyfzk3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 27, 2017 at 09:54:43AM +0100, Quentin Schulz wrote:
> The X-Powers AXP20X and AXP22X PMICs expose the status of AC power
> supply.
>=20
> Moreover, the AXP20X can also expose the current current and voltage
> values of the AC power supply.
>=20
> This adds the driver which exposes the status of the AC power supply of
> the AXP20X and AXP22X PMICs.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Jonathan Cameron <jic23@kernel.org>

Thanks, I queued this into power-supply's for-next branch. I
removed "struct device_node *np" and "int axp20x_id" from
"struct axp20x_ac_power", since they were unused.

-- Sebastian

--xfk4z6zclvyfzk3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliOF4EACgkQ2O7X88g7
+pqPNw/5AYL3oLowRp8S1pdrrlFqlaqMtgeedjtAEUyySpeYIU/mg4KkQtu1Xn/X
tFcI0rV5PMSeoaWyzZUa1XLoMWFavOSdqxIGJ0bvVn4lTTgkiEAo9qmNpP19Ts6y
Ns7V36tVnuen6ro3TNgzwIR6WTwdRAqm8RvhAI/KC425JTEPVj9/Nj3eU2NyYsHf
liKTFbvsiY95eiXd8iGnU2oMXXX/PSS44EyCqu0L++deH+PWcRmvTa9a/XtiJ8fs
Tn2Z8HuuGOSMsFGLNmr8tNeHLerVs38ZrPqIvoaXWnJf5BY/bhvXKjcxwfrPWDcd
87hewSC+r/rMS7rE2hqcp8OMyjLCxVOiWmRaGXdqJ73u/eHc8pUupHrcYqGNrYtQ
p3TZfue/L4MVOLrjDLbDCrjFW1yXIYF+QIMamUg4nXCXW4g6xyVOXQPsHQqFud7O
V+PiG6Fjp1396G1emZQ6d8c185WIIzI2m7XSfjxI34tG8vElsMG7TDmyreWSx1Ne
tJRzSfp+WSEfWA01ohlus0YeuB2lrodjxL+/3DoPpXhhhn+2GiH/VK588XrJJo24
goWg6dtUUtrZfSEatJcz87N+9/Gt9r2FSo2Yevm/8pfYgds3HjmCe2bWJCTimC06
WRMkv9QwQeu1QMseUONElpA1C44yLEWRER4ZNR71hsVWG4mRQV8=
=RK1g
-----END PGP SIGNATURE-----

--xfk4z6zclvyfzk3a--
