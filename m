Return-Path: <SRS0=dcI+=DB=free-electrons.com=maxime.ripard@kernel.org>
Date: Tue, 5 Dec 2017 09:08:55 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
	linux@armlinux.org.uk, jic23@kernel.org, lee.jones@linaro.org,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org, icenowy@aosc.io,
	linux-sunxi@googlegroups.com, thomas.petazzoni@free-electrons.com
Subject: Re: [PATCH 3/8] mfd: axp20x: probe axp20x_adc driver for AXP813
Message-ID: <20171205080855.arr7vlgnxoxmyedd@flea.lan>
References: <cover.4052f8c517c42db26a3cabe078cad333243d371c.1512396054.git-series.quentin.schulz@free-electrons.com>
 <302c93023d8c4a54cafe321d912df484e39727b7.1512396054.git-series.quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mii2azbudvffe6kc"
In-Reply-To: <302c93023d8c4a54cafe321d912df484e39727b7.1512396054.git-series.quentin.schulz@free-electrons.com>
List-ID: <linux-iio@vger.kernel.org>


--mii2azbudvffe6kc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2017 at 03:12:49PM +0100, Quentin Schulz wrote:
> This makes the axp20x_adc driver probe with platform device id
> "axp813-adc".
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  drivers/mfd/axp20x.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 2468b43..42e54d1 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -878,7 +878,9 @@ static struct mfd_cell axp813_cells[] =3D {
>  		.resources		=3D axp803_pek_resources,
>  	}, {
>  		.name			=3D "axp20x-regulator",
> -	}
> +	}, {
> +		.name			=3D "axp813-adc",
> +	},

Any particular reason you're not adding it to the DT?

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--mii2azbudvffe6kc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlomVBMACgkQ0rTAlCFN
r3QbUQ/+ORDevY4F/pUKrtoGcCN4tDfMkpvlaliqqKOyaGvGCYu6jvPvc7p1LXWb
6lU1+f80QOnmzRbUTgmGpBfILAuClzH0Xh5iB8gseoqT0i+AdbusL5/PjjZ9RKGD
O9h2H6vydaojjlEBaaDoTw5Jiv+9cgh9SbbgF+cezefz80XEe+m/r2/Es5XZcQkK
VkhhS18ZYWxNShhS/1FTL8U0Aoy22Nw0a1cqv8JgNFI4lth1adNRGdvEXyBWo+WZ
khfsjzAV1jfHtNI9JNa6VljS94apQh5rtWrrznM5hZU4Ji0q0+i27UAsiNE3JZAl
oB6gh/GI5+NRXd6CWsr6vgXMCTETR2RCBaJGI38LeeIMvEtdY4VS3Ti0SAnyCkNG
SFrOpcLPiVTbi0/rSQ1riEsdKWdniPOiO4oVlFdSzKuZesNjsFZVMcXNNHXJyt14
cFsuv4yEQdxFdND8BLxrSaL4WC6u39+g38pevtM4Qnvi4wMKEGfHlAnJrCBN7AQW
J6cW+J/SLnSjHtVzbYYcnKH7VaSprbHv3NdQwU4BwCL8MdGfs/Wu1SlJlgNsUScO
Qwpw5gjCewQfeaHrIcNaizkBog3R4OJYf8N4eoUl1Ist9FbqszvBDhfXjwGeigVX
IfJl2HabNNm98BUvkjTKgaG6XUFS1AxHOgKzcoCCpWgxm3yuMbo=
=uk7R
-----END PGP SIGNATURE-----

--mii2azbudvffe6kc--
