Return-Path: <SRS0=YtUh=AT=free-electrons.com=maxime.ripard@kernel.org>
Date: Mon, 18 Sep 2017 10:24:02 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: icenowy@aosc.io
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
	Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>, Jonathan Cameron <jic23@kernel.org>,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 4/6] iio: adc: sun4i-gpadc-iio: add support for H3
 thermal sensor
Message-ID: <20170918082402.fa5mg2ucqouh3ti5@flea.lan>
References: <20170914145251.21784-1-icenowy@aosc.io>
 <20170914145251.21784-5-icenowy@aosc.io>
 <445ea236-35e9-8d5a-e580-b2bdcf5f7776@free-electrons.com>
 <0b395ea1743a14a62855fc2a2dc74411@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yc6aqu6lsph33767"
In-Reply-To: <0b395ea1743a14a62855fc2a2dc74411@aosc.io>
List-ID: <linux-iio@vger.kernel.org>


--yc6aqu6lsph33767
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 16, 2017 at 06:14:08PM +0800, icenowy@aosc.io wrote:
> > The H3 apparently supports IRQs, why do you not support them for the
> > temperature? They might be broken as it is on A33 but then it might be a
> > good idea to write it down in a comment in the driver (and not adding
> > the unused registers in the header file) or at least in the commit log.
> >=20
> > 3) Now that you have support for clocks, wouldn't it be a good idea to
> > disable them during suspend?
>=20
> Interesting... It's meaningful to disable the mod clock during suspend.

All clocks, actually. And put the device back into reset.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--yc6aqu6lsph33767
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZv4KiAAoJEBx+YmzsjxAgdikP/0KxZ+INwqjDM/FD8k8XZ2KB
FuhzlsdsPIj7ix80LtDCdQ+SGrTSeALo48Aze2mPcvN7cmUQ7nQYJfrquLXtggy3
oQGXR0FwSkSzlxnFyO24OrjDm8qp+6hG0sm2XZ1UT5zOylHBm0uHZ44xRuc1MGrP
/cBQG4XmoR7i3iycImift5vZFMuoOR2c8Eh0l3IrCFKc6797db8fqExlEH8gWcUM
iRyaRE8WDe4oIEBRoWKCcIPOo0NpsLb26CIMm7H9sv8Kgi9xqsE8qlQaYGHs4X2N
ol8wax+2PXVnRJkKn4zvIreb+oZjpwqijwl0QMXfrsJZOzcnZx0E9Ef/X0aQLcBg
FwhAsjGw8xSuzZuwULKyOsT7lpaemDMkTgsGkdELs3fugZVEUqMNTmET4njPrDFc
klKzsZ0bAv8NGez2ZFMeMd0jztxUm+ZA/Mqma9HOixCkKK/kGtdMeMvzOifbN7GB
gzREJclq/OVnHhiG1Y4axHJ0gGOszDNHNnO3QO0DHSrwxpdgoHspOPd6b/X5Y66D
+sV9AscN52MfukViePQE8HQ8aGDb2D72RprSbYAsmUOcUsghW98bNQRgcp7e7hBj
gFe6pRNFt7rS9C68zQjApmf7xN21p3LZYbk1qvvHSIAUkLfLgZiYiszCNvezfG6P
mLyLFYUo9k1PNoAd+W4S
=WM/2
-----END PGP SIGNATURE-----

--yc6aqu6lsph33767--
