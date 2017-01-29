Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751826AbdA2Qhi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Jan 2017 11:37:38 -0500
Date: Sun, 29 Jan 2017 17:35:13 +0100
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
Subject: Re: [PATCH v2 11/25] mfd: axp20x: add AC power supply cells for
 AXP22X PMICs
Message-ID: <20170129163513.m7y4vbjgthh2esg4@earth>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
 <20170127085458.18270-12-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h6fucybx25xk66zu"
In-Reply-To: <20170127085458.18270-12-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--h6fucybx25xk66zu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 27, 2017 at 09:54:44AM +0100, Quentin Schulz wrote:
> The X-Powers AXP20X and AXP22X PMICs expose the status of AC power
> supply.
>=20
> This adds the AC power supply driver to the MFD cells of the AXP22X
> PMICs.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--h6fucybx25xk66zu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliOGcEACgkQ2O7X88g7
+pq+KBAAkiHvlTehr7ZGKWmsEU9V3uChOGDwUz2LFmtXJxv2Vl+E0mDH3ADmYNtp
tdn9UW/ywBkLr+CIUVe9jRTccJQ0+9xgLRaxzl2XPnEG1ALfWTFk0eUG4Aa2SSdf
Dgwh9HspOOGFERVVp75uGsftxmPGWL3SCuwm7m4AyPy07i5iO8cjTr9ixsXO9Bk7
764+VFTMaKttsE0EnzeV/iWwS5/RmK5cHZwUiEi9FJbhwxg6NTbwVw8J60+p5ARn
gSMkzjS0sydnCv/UBrkE5hUh745vG2cfeGGEDXDqkeaxmX+CSsgU5CmSGKX/d9ek
beqnT+9hYTuSWYzWmfIHgCuRED/L/F6q7IS2gyWCzccFQAoZjW0kX67bkHYEFMEd
BzM+5j4rF/qrt04taDknkeuBOxgRvQR/2dwJGFyScfF5PQESEQ4st9/lK6THjtWp
tgGJldkW8OH70Gyh1DnQ7njLYCFaX4KHqV1PrC8+J6IzphSf+y9PcDzxWK+nF/yU
mv4Kk3mULcWGye+PF2il0G3qxR7mjbHBHcYbJI+5m2ty78YcnU2hsfe+SEuykkLp
5ISkELjxmNCU9qlgNcjyV8BfdzNveZhnqdQOPFEwnAm5MVdY6KxqCgXa2QG2WEtQ
Xas9UsSeLOhCCxEpWqJ0MN/eQhnLWUS/7n+DlgYcxRZi3I3u85A=
=o1z+
-----END PGP SIGNATURE-----

--h6fucybx25xk66zu--
