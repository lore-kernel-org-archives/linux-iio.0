Return-Path: <SRS0=H4uv=A3=free-electrons.com=maxime.ripard@kernel.org>
Date: Tue, 26 Sep 2017 15:20:55 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	wens@csie.org, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-sunxi@googlegroups.com, thomas.petazzoni@free-electrons.com,
	icenowy@aosc.io
Subject: Re: [PATCH 2/2] iio: adc: sun4i-gpadc-iio: do not fail probing when
 no thermal DT node
Message-ID: <20170926132055.6wcrbxem3fxwhojh@flea>
References: <f7b1b9c493c563a2f5b5f5f44596d45d3d719d26.1506430136.git-series.quentin.schulz@free-electrons.com>
 <160cf183a167ef841c96c5626f42e23b7195effa.1506430136.git-series.quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4dtllxwrioyt6rcr"
In-Reply-To: <160cf183a167ef841c96c5626f42e23b7195effa.1506430136.git-series.quentin.schulz@free-electrons.com>
List-ID: <linux-iio@vger.kernel.org>


--4dtllxwrioyt6rcr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2017 at 12:52:19PM +0000, Quentin Schulz wrote:
> Before this patch, forgetting to put a thermal-zones DT node would
> result in the driver failing to probe.
>=20
> It should be perfectly acceptable to have the driver probe even if no
> thermal-zones DT is found. However, it shouldn't want to fail if the
> thermal registering fail for any other reason (waiting for other drivers
> for example) so check on ENODEV only.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

For both patches:
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--4dtllxwrioyt6rcr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZylQ3AAoJEBx+YmzsjxAgUpoP/1gWWo46fcA7iHngAHGddBEt
UcaeChYNX68nNLA6I8ckpjXR3+9e1ggPyE+qf67X68DPwBEhzzrh1IqF9Paq2apc
sx/hNIN6Q5RU5dWJFX5IeqL/axmUw+N5JEHIy4W3Eg6pk+lTFeN8qn9kHvjVp7lG
GIlVlHyo8kD52CIJWKP52E2mnsK4uaDWLA3d7QSvaDQ+BMHg27YjGnUYWJkYip5e
+kzYzj0P69A24oGEFvuZq5YDoH3P/wHIWvkWhrm7at2BclLrOSBIHwuCOL4GQ4dY
AaaIWY2H+6QjN9IoircFFdmfeKD+gXcPJ7kU6BdRfTqRA7fN7x2amFmL9Cqm6QdG
dslPGcJme31kHY99v3jcAcFfEpXsrh7m8CNv9NFOX2/Dk25FiL7uBU5mx9wH5z2o
KPd1NPuABSGg6VrFcd/YdStGip2D2EsCwlnaQmiPm7fsr91fXp1PTu3q+JaIcoRo
5vIcQq1cKW74qoYASE3oAYcbSSzM7zm399CaLbmfBzOFC1fXAcKb4MRCfUZLXoyr
qnC1yXz60epy0/BbXTmLU86o0tWWi6YjZlGSgmtS9m3NYVicR7Jiifz+3f6Cz09I
8kBMwdqhahjpE26Sdy9WuK4HSfFq56YCDLcJMmnfrEn8u1WXDh7rYnlOofajXf/L
QyfMEa61dhqqNNKR9Yf8
=ujm5
-----END PGP SIGNATURE-----

--4dtllxwrioyt6rcr--
