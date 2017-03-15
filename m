Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752027AbdCOWYz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 15 Mar 2017 18:24:55 -0400
Date: Wed, 15 Mar 2017 23:24:49 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: icenowy@aosc.xyz, bonbons@linux-vserver.org, robh+dt@kernel.org,
        mark.rutland@arm.com, wens@csie.org, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, liam@networkimprov.net,
        thomas.petazzoni@free-electrons.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 02/18] power: supply: power_supply_core: add
 constant-charge-current optional property
Message-ID: <20170315222449.bvca6r3zoaxoedlb@earth>
References: <20170315105537.22349-1-quentin.schulz@free-electrons.com>
 <20170315105537.22349-3-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mfu3i4m4q7qphzht"
In-Reply-To: <20170315105537.22349-3-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--mfu3i4m4q7qphzht
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 15, 2017 at 11:55:21AM +0100, Quentin Schulz wrote:
> This adds the constant-charge-current property to the list of optional
> properties for the battery.
>=20
> The constant charge current is critical for batteries as they can't
> handle all charge currents.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--mfu3i4m4q7qphzht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljJvzEACgkQ2O7X88g7
+ppz/A/+JW+xIVSH/6yHIF9RILRW/MkrkOCixASpeMcA/Ud1kuVcUYD+0vBCDP9N
BoUmKcXwj8Kn0B25bjjdPh6kGyMQJ2P4sPhl2lvJFv4whaHRInOAhOlIelZ9MqiU
Ib61PzYGQoV1H2vLoCCasAgFLgH2lXDGnfjhvIuvC/k1tx6zoX3oK1jx9Vzcwvdm
G7UysQVyRL2X6XPXKRhg+AgsDJSt4ft3VPKXe7L26rLSuHscApPpqWJUhUUINRg2
v5o/qGrY5wUbw/T39ONGQvv0q+UuHDB7YOJP/5mw8sLYT48OGbM2YMsmUzSACVqr
AYeBHWg8Ir5v7qJyLsfHl2JfnpQZ/ctk6L75IlTccfyqxVhnU3XOL22GvvmY5Xof
DzVxlOnAxKB22d3zBmW+lBG5Xko0CmcWC6Hljtz7uSEBgDyQesmjFYuTRkXPXxR+
MmqMf+BWIWkVAZn/cDyXNh9mr/dYMEpuc6pXudDosWYX3Hv/lJfnzbMyvgciA13R
yvSc/lduSN/LSrSL5zm6p2qqJSGqHz+WUg2ZzB5RhyJx3Xmzn7hspKAFDV8Rh+SO
NMYdv+4XeGy8hD0cYZOQBRY717kdTxSQchBf4FKV9tPj3IYmADlNFnlKI9k+JcLh
6eAxeWYmm4HrQsu76zW7aRGQMqn7j1lumcEmWQfDTM3M7uBDAVs=
=2psX
-----END PGP SIGNATURE-----

--mfu3i4m4q7qphzht--
