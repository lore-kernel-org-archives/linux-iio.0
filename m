Return-Path: <maxime.ripard@free-electrons.com>
Date: Thu, 21 Nov 2013 14:14:02 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Denis CIOCCA <denis.ciocca@st.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Brian Lilly <brian@crystalfontz.com>,
	Brent-Crosby <brent@crystalfontz.com>, Jim Wall <jimwall@q.com>
Subject: Re: [RFC PATCH 0/3] DT support for ST micro accelerometers and
 gyroscopes
Message-ID: <20131121131402.GF1029@lukather>
References: <1384876234-1211-1-git-send-email-maxime.ripard@free-electrons.com>
 <528DF164.8060009@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p8PhoBjPxaQXD0vg"
In-Reply-To: <528DF164.8060009@st.com>
List-ID: <linux-iio@vger.kernel.org>


--p8PhoBjPxaQXD0vg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Thu, Nov 21, 2013 at 12:41:24PM +0100, Denis CIOCCA wrote:
> only one point: it's possible to use the same names with DT? (using _=20
> instead of -)

Yes, it is, but only for i2c as far as I'm aware, and usually the DT
compatibles are with - as a separator (I looked into the ePAPR, but
couldn't get any explanations or requirements on this, even though
it's used in all of their examples)

> Why only for i2c?

Because I was only interested in i2c :)

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--p8PhoBjPxaQXD0vg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSjgcaAAoJEBx+YmzsjxAgZfIQALXntqRAwFNqM5N/TZQTxJx/
kWqCPDMdvnjZtDVEpUgrC0NPLZz01ryo9kAmbqcAtUvofBDuPFmY1ZCjZA+dSlXf
UuLdFhTcyY7htohXi2QZHjsGp6n3wd1SbpfnLhAOPD/Mor4o5Y+eEz4u5PHDJ5Jo
rjKXEnX2Lr3mgC7jSvnjdsSxo2CQ2piTKaTQt7HjLqj0zLs4XBMHfV+6Q06lougj
Vfq6j78CsiBEZYK69sGhVwlqgj1lEYqRr0Cj1jFEUgQuAhBs2Bk4KTCG9HyAXOxJ
DJ4MIM7KT5lx7c4hGUynqmIyf+ZHb9SOqFn5MFHQMoCqRDnv73fa7O2KXhMrDRUC
FZlLV1cVvuUlG4eDf5J2GCxDShHdMIHDsjWe6W7phMMxmiKfGAq16ikleRPTjC7T
9NKLCGIQyDOPBi2YaYJbf5L/96aNxS4JffN8j05EBj5ECdv+svhYpI4VCuOKY4n9
KiXEucqYhgZrdQonn0ftQOTwf4g1nzuO8zxuqGXGZ/28h8OFZZhCnaa4r3yy86QY
xUYG8vbap+H4kiVsyJNTrOPtcR7Aw9NL3BENtG/4kQOBWNA8zx6SLcetyqp0hlDp
9cRZdM+a/QD7owLQy0QjJy6BawEkVc89O+V8KVkW0VGQLFE+Lqg4VUEx+zlVDifr
BfM7txK6/5fAk+Q+wFsN
=NeFF
-----END PGP SIGNATURE-----

--p8PhoBjPxaQXD0vg--
