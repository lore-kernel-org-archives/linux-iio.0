Return-Path: <SRS0=YtUh=AT=free-electrons.com=maxime.ripard@kernel.org>
Date: Mon, 18 Sep 2017 09:36:01 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>, Jonathan Cameron <jic23@kernel.org>,
	Quentin Schulz <quentin.schulz@free-electrons.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 3/6] iio: adc: sun4i-gpadc-iio: rework code for
 supporting newer THS variants
Message-ID: <20170918073601.oiqshnhhl7yb6fv2@flea.lan>
References: <20170914145251.21784-1-icenowy@aosc.io>
 <20170914145251.21784-4-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k6i73kubcroskaqa"
In-Reply-To: <20170914145251.21784-4-icenowy@aosc.io>
List-ID: <linux-iio@vger.kernel.org>


--k6i73kubcroskaqa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2017 at 10:52:48PM +0800, Icenowy Zheng wrote:
> The SoCs after H3 has newer thermal sensor ADCs, which have two clock
> inputs (bus clock and sampling clock) and a reset. The registers are
> also re-arranged.
>=20
> This commit reworks the code, adds the process of the clocks and
> resets, and allows the sampling start/end code and the position of value
> readout register to be altered.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Please split that into separate commits.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--k6i73kubcroskaqa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZv3dhAAoJEBx+YmzsjxAghGYQAKSCmBG//hWKCq+3bvDpF9o4
Cky+KRpV5SnFUbMO9cOXDcen64zm8mjkPeXGxcDsS6QVSsoqYm+5mxJ6ckR0OPT8
2TNzxEY5qoYlOGEbEcrg38XqjiOhQHAZYYNLQq9iMzl14u8ObKjMya2eTM6nemHR
bAPQ3ZsY3P0wyxMzoYJsylF7pcA4J8tELmbwPa3HDHSY0l0lWloiiXeIt2iev5NR
4nURX8JN+6j9V75ii4YRpeTLox8H8vDbbLsBrg4tb83BGzP1rZH/0o9PqSuw3cw5
i4hGsSGyGIvhMiWjXNb5p+I/16dypTV2n2dBzWpQOpjl9P6Sc0gSNURsHUeN6vIl
IAqja1PScGEs+1qDKQhAr/qo5NJcZaS/6aJzVVpvREewMViqF6YLqfr+SwZ0keBr
6OAFb5iLChFPa/QRBrOd0biHOIhjKKOeEf/nAh4drFkOhQGNqZNFHkgPwCyl+p/L
av0D1C3m8etq3jc05iKw8yJJVacIUJ2iqOQSv5Ees0Ms6XFrXhl7Jn1qs3IGoiDR
SvPl+SCXaPG9V9ohADJ1KWm+BmI6Hf/7WAV03oY1EHHlE8Ww/+/ft6wQ02lG43yS
kTp3YI+r2W7ns891tSNfd5kx8josEs48N1365KWUSCV53tthowEAer8LbtaUDutx
JMPRzaCmQeotldLje2AP
=s+J3
-----END PGP SIGNATURE-----

--k6i73kubcroskaqa--
