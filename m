Return-Path: <maxime.ripard@free-electrons.com>
Date: Tue, 3 Dec 2013 22:29:14 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Denis CIOCCA <denis.ciocca@st.com>,
	Shawn Guo <shawn.guo@linaro.org>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Brian Lilly <brian@crystalfontz.com>,
	Brent-Crosby <brent@crystalfontz.com>, Jim Wall <jimwall@q.com>,
	devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] DT support for ST micro accelerometers and
 gyroscopes
Message-ID: <20131203212914.GC31496@lukather>
References: <1384876234-1211-1-git-send-email-maxime.ripard@free-electrons.com>
 <528DF164.8060009@st.com>
 <20131121131402.GF1029@lukather>
 <52926901.9080004@kernel.org>
 <20131125094044.GE3176@lukather>
 <5299D3BA.8080700@kernel.org>
 <20131130140402.21abae28@endymion.delvare>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
In-Reply-To: <20131130140402.21abae28@endymion.delvare>
List-ID: <linux-iio@vger.kernel.org>


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jean,

On Sat, Nov 30, 2013 at 02:04:02PM +0100, Jean Delvare wrote:
> > i2c has a generic binding that matches to the name bit of the
> > i2c_device_id array.  That is then exported in sysfs.  There are
> > quite a lot of instances of underscores out there in these names.
> > Thus unforutnately they can't be changed without possibly breaking
> > userspace.  Typically those same names are also output by IIO
> > though obviously we could keep that the same whilst changing the
> > dt binding.
> >=20
> > Also the i2c binding allows binding after dropping the vendor
> > prefix which is even more 'interesting'. See of_modialias_node in
> > drivers/of/base.c
> >=20
> > I'd therefore argue in favour of just leaving the underscores in
> > existing drivers as a nasty bit of legacy and doing our best to
> > not introduce any new ones!
>=20
> I don't know what is the problem with underscores, but please note
> that hwmon i2c devices are NOT allowed to have dashes in their name
> because that would break libsensors.

As far as I remember, hwmon doesn't handle the accelerometers or
gyroscopes, does it?

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSnk0qAAoJEBx+YmzsjxAgUMQP/RXdP2Eg8gOKv6h0AOya8bVz
SayyVZTFXVa1un/ZmtSydJimsrzogcy97TntJGUmJmO5QKqM6v2AWwHXapqU3M0p
QDwMMNfGlS0LSq5QFBk7rPQdxi0FxB6QbSuaMXu5pzrWz6iHwfHk5ITPI71e1Cya
3gkKkSgJ6ruFkAcRcef+zARlrB1l+ACBT5jQzODvhFQ1/fx+KaQMXjxcn3z1Ru7s
LpCWV+rwpEFEmqeX6dW5Mb31ISxLQO/VpEqHDS5nlqQwPb3So5FKYDsL1oph0iQ8
Ws6ZUc6AJ8kA1fBR35hluiiHKGaBC7D2AqDqxmTf4TIdhH0YgxBiYKDRITW7MxJa
kQh1qWAf6heVm2BuqGmMfDrKUpTY+qItGewBS2dI+P0JRQpXuO3U1qNB7XWkLUCz
8QS9BfIUA6bXLbEeREWAVA8Skkp9JAguNNvvgaBfviDkTCzewrR+2591AnDi6Uz/
BRofXikBU4jzmFc1ekMZfrTZFzh0EpmueJPzzTkVj+d362EVA0rIf1/80Ikci2xf
tSaFwVGa2FJ3MXqzcsaSJkEMEh2RRvkYiMOF2aHyXWzkWmkMg+chNC7m7t3syLHs
qQlVBA+gF8FtAMUZkhrLzMVhpHWPBrflY4If5V7bUprMzRuYd1+xIo8CM1VLrjwf
Mxi4AZSWShe5+cUSyny+
=jdUk
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--
