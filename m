Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:39877 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751464AbcIIOic (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Sep 2016 10:38:32 -0400
Date: Fri, 9 Sep 2016 16:38:24 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: jdelvare@suse.com, linux@roeck-us.net, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, wens@csie.org,
        lee.jones@linaro.org, thomas.petazzoni@free-electrons.com,
        antoine.tenart@free-electrons.com, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/3] mfd: add support for Allwinner SoCs ADC
Message-ID: <20160909143824.GD8881@lukather>
References: <1473344917-1524-1-git-send-email-quentin.schulz@free-electrons.com>
 <1473344917-1524-3-git-send-email-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZARJHfwaSJQLOEUz"
In-Reply-To: <1473344917-1524-3-git-send-email-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--ZARJHfwaSJQLOEUz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 08, 2016 at 04:28:36PM +0200, Quentin Schulz wrote:
> The Allwinner SoCs all have an ADC that can also act as a touchscreen
> controller and a thermal sensor. For now, only the ADC and the thermal
> sensor drivers are probed by the MFD, the touchscreen controller support
> will be added later.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--ZARJHfwaSJQLOEUz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX0slgAAoJEBx+YmzsjxAgflwQALvx5SPJioKUeDtmjxLHljuB
igHvYG8o7qSTViznlyOfnB4LRk1AekHEwu2UCR+jhzm2Xsku6uhArL9SJICRQwJr
pbtOcGfOPCex0JA9Ud/wWBjlQlRqGmZnUwP8tKFuZNKOJyei1URUCUd0C4YMgomu
XsgVGMzCdO6euBJIRVLnnC2YbAczLDXRuFdSFglfDP1GhddsMoJoDyZNlp8ZG+Yq
AKNHlbJZjWMiJ5rg6xXeLZc45nWYWELjxfeBS0we3KF9NkfzhGMw3/JGkPtT+P6A
IHiAgViGXuZPvO8e31EAft/B45F5GVePC/iFpMzVNYBe0e2WEuKZAUrlhG7p5MSL
7TZdL2sxAiBaBxYE/uNibDbb9kkcMc8horwXewgXaQdB64fSC9uQsDaGl8gN2h3V
8p7/rpj2Df5/whugweSHiMFf6Z5eYFMVlRIrVA2AWNd9vBmpySsv5q85GQJe4+kI
G7IpYBOskKlmH2q/aNJb6kEysQhRD/aLWfrkb6GsHsZrcobRJXKwBwxOn0ESD9gf
Z8zHQuxGiYc5pIUuXTktihTDvlD3AMHU69OZ3UAfYE5in3GWROLPAhLVZDjRcNWX
eJT3hyLXfSsA+QrckX4O9/4xw8cZvWfEN2j4C+ZFMZpf1ZCHM9Yi200R9zvzWYML
Tds+dUB1MUuNnbCqD+nW
=8tRn
-----END PGP SIGNATURE-----

--ZARJHfwaSJQLOEUz--
