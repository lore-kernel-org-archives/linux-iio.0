Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57764 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752972AbdEALvx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 May 2017 07:51:53 -0400
Date: Mon, 1 May 2017 13:51:49 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc: J Keerthy <j-keerthy@ti.com>, linux-iio@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] power: supply: avoid unused twl4030-madc.h
Message-ID: <20170501115149.e4ho4lmyiqiumtd5@earth>
References: <20170427153012.32310-1-sebastian.reichel@collabora.co.uk>
 <20170427153012.32310-3-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z4gzvzip7gpm6mxy"
In-Reply-To: <20170427153012.32310-3-sebastian.reichel@collabora.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--z4gzvzip7gpm6mxy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 27, 2017 at 05:30:07PM +0200, Sebastian Reichel wrote:
> Avoid inclusion of unused twl4030-madc.h. This
> will allow twl4030-madc.h to be merged into the
> iio driver.
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

Queued into power-supply's for-next. I plan to
send a second pull-request for power-supply.

-- Sebastian

--z4gzvzip7gpm6mxy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHIVUACgkQ2O7X88g7
+ppdEg//YVAFw3adGY3AeUWCBMHqizCx4dwtER7f+8osw8NPVXkZZ/awUNi830pR
XlpNaje44DfBzhy7O+aWcFsNjU6oGgmbRVPvYl12qJehXkbDeiRQLWWTAGZshHZy
3JpQUVwjnj0hzsIRHriS40U5k3LwfTnZ0ennv30OeljgEuic4X5n41myrUUwc7e8
6kKHyfXghd5PxaE/Obl8inPppDPGG1Z+eo7r7/FKOo+LSs4w+ifkhKVUf0Gq/Piu
u7vw5DBznJ5QNQknXLFFZu3ZRa3J+dzoKbiEHDoheEm7w1jZqIKGUJKrV18Uqmsp
pLxy0ufGqLd+yhlmNac1d4nmT8gIJo0ltNag+A8kdJ08p+iTn3FbMsF5XseFK42b
jnyUlHkbIkPP38Z/7iiT4Nw4G7SMT4p63A62i1KPLPfQsgcPGPZWjyGn/BZ6Cviz
u6TboXHlUFJ/DDnGe+1g+bjJdfOvteAhVfCub9pFcLJXGuSVC8L/R3JcXNPR5+18
zVZ2gkV5XgUJoUTXykY8hezpbpavExAIP6uN2uiem1O1F+maC5gf+N9+biRyeCrV
eOBtdUSYhZ+ik/CIfz3/x9EeWemAupiLDhtDWGB5ZLq8V7nEIsjUZittX7971czp
45OSJtAlbwCEqllBEssnXlpORnOrbAiIADcPOMgpn1wRB35Qacg=
=nJBW
-----END PGP SIGNATURE-----

--z4gzvzip7gpm6mxy--
