Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751258AbdA2QWA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Jan 2017 11:22:00 -0500
Date: Sun, 29 Jan 2017 17:21:54 +0100
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
Subject: Re: [PATCH v2 03/25] power: supply: axp20x_usb_power: use IIO
 channels when available
Message-ID: <20170129162154.pyqi4m5eo6jpaint@earth>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
 <20170127085458.18270-4-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="unb4xmhllg2lctj4"
In-Reply-To: <20170127085458.18270-4-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--unb4xmhllg2lctj4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 27, 2017 at 09:54:36AM +0100, Quentin Schulz wrote:
> The X-Powers AXP20X PMIC exposes the current current and voltage
> measures via an internal ADC.
>=20
> This adds the possibility to read IIO channels directly for processed
> values rather than reading the registers and computing the value.
>=20
> For backward compatibility purpose, if the IIO driver is not compiled,
> this driver will fall back on previous behaviour which is direct
> register readings.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

I queued this into power-supply's for next branch.

-- Sebastian

--unb4xmhllg2lctj4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliOFqAACgkQ2O7X88g7
+pobWxAAm46VrSJV6LZAqux5L155hg+cZ5IGRagN3rgggnBksNyFb24aeFnLtP/o
fx7inQJuS9cf7WCwTfHXcOvfuvLWd0C5t9d6irK3sNiXqrCIeTvnkijYq6o1BwoN
uEy3v1o9nX0Tt0hfweOPok2cRIQdFq49sSoJffDEThA6tZQjBIXU6mijFchbvIOq
ZJURShwsz/liNgc9pBO/GThOy7zNwY453+6emA8/VRAcnTt5gqlDCX6PyE/nBMZd
3R1e0fJPZbsa41QjFcF6Y6FwjkF87kb8503hTt5lzObBzAcn7tWWKY9lcZj8iJlW
Y37UvLRjHvKZbQpZIl+cdvedRfJGRSpXS+6wAynH++CeKVtDdAUEVz/ICaW++EkX
GY3pau/u5/t5HTwQdi3FZ5wdo9yYPYd56wIIRFYTQ/z7xKvo+9BBKG592ILkjdXH
h8rjnMV7ZhTYIhNrBbsFiX+LNnKKZcQqlPJsgQ/m9BTW0U4qHwxF8DFjN9rtpn3H
o52RNipbTkXIkpIVRE1qDAIenOj6vv2WzdKOl8GFAzkM7h9fxwNdYReyeCs4Rbgd
oq7PZSITulQJRj0Z211dZZa8keBB2AJyuYps+dPXwSeO4WilB/YSYadbLqv+X+4b
Dt6wBJT2Zq93QQERsx0hr1AA5B0k3+uRmZxWPwsDx0ddpNegoFE=
=FvYD
-----END PGP SIGNATURE-----

--unb4xmhllg2lctj4--
