Return-Path: <SRS0=CYYs=63=free-electrons.com=maxime.ripard@kernel.org>
Date: Mon, 24 Jul 2017 10:29:38 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>, Jonathan Cameron <jic23@kernel.org>,
	Quentin Schulz <quentin.schulz@free-electrons.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 3/5] iio: adc: sun4i-gpadc-iio: add support for H3
 thermal sensor
Message-ID: <20170724082938.vsq3zd22vb6lqvu3@flea>
References: <20170723141354.42646-1-icenowy@aosc.io>
 <20170723141354.42646-4-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w7qg7zijr6l4yjzz"
In-Reply-To: <20170723141354.42646-4-icenowy@aosc.io>
List-ID: <linux-iio@vger.kernel.org>


--w7qg7zijr6l4yjzz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 23, 2017 at 10:13:52PM +0800, Icenowy Zheng wrote:
> This adds support for the Allwinner H3 thermal sensor.
>=20
> Allwinner H3 has a thermal sensor like the one in A33, but have its
> registers nearly all re-arranged, sample clock moved to CCU and a pair
> of bus clock and reset added. It's also the base of newer SoCs' thermal
> sensors.
>=20
> Some new options is added to gpadc_data struct, to mark the difference
> between the old GPADCs and THS's and the new THS's.
>=20
> Thermal sampling via interrupts are still not supported, and polling
> is used instead.
>=20
> The thermal sensors on A64 and H5 is like the one on H3, but with of
> course different formula factors.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Could you split it in half? One patch that would rework the existing
code, the other one adding the H3 support?

That's going to be much easier to review, bisect and revert if need be
that way.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--w7qg7zijr6l4yjzz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZda/yAAoJEBx+YmzsjxAg/6QP/ApIELNPFnrdWqaedOyTJ0/e
vvyBpxgyPaEzlrd4vzS9GAuGBfoKCwgfyn+in/MTVwygTPb2vZJqXywSKMJGkJAY
g85iIT4Oz6cARBMU+p8ZF6Xxu1rkxvTtP030fLIfR8cJfYVxvhuh1Yh6v6XvRZGd
KSsZ3pWAoPtMyrA7al2aSpA9zkfCJ1wnb5G7FQPEacyqqbyhXEK3ig2Ch7fXP1YN
hqIQ8fACmgr6v+JCjTNSRKV70WYqt7T0APsTTen5JkdttREMlGtO2eDY11Ur8ePP
DQ5jU+AM/9kiiVVCPxCHGBaaTuqprrMoh+AX3gl9VQi9QFoA5guGFgj6t4eJcMJv
lqHEJSiTRZgtQI7QCX7PcpAoDC+HPcVHoQB7yvg+00HKtEyYS2W7jVzJTMwZs9T6
XSNFoNOrrggqc+FpOHBDPD21iQPyC7UihKf2uOZXIcDVzwzCqqzPvafg5YSUDwW6
XgitrYQB3nwAMjAuGUYoUqD5679YREv/7LalMs65xQ2m52fkhPnfbbX50asJVbdf
nC2etuhMj5j9CJgLBR3koGnJFkDy1POvxWkEOc+FUorQBhHeX6/ORlI5249VnTi7
JNew4dDMBJwBlJlAo7HhFtl6vYxMkPFl6COdP9yFzoai2myvEc/MOeIA+k5VXoD5
YdlDck/VK6y1T7Oaw0Z9
=Oj44
-----END PGP SIGNATURE-----

--w7qg7zijr6l4yjzz--
