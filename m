Return-Path: <maxime.ripard@free-electrons.com>
Date: Mon, 25 Nov 2013 10:40:44 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Denis CIOCCA <denis.ciocca@st.com>, Shawn Guo <shawn.guo@linaro.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Brian Lilly <brian@crystalfontz.com>,
	Brent-Crosby <brent@crystalfontz.com>, Jim Wall <jimwall@q.com>
Subject: Re: [RFC PATCH 0/3] DT support for ST micro accelerometers and
 gyroscopes
Message-ID: <20131125094044.GE3176@lukather>
References: <1384876234-1211-1-git-send-email-maxime.ripard@free-electrons.com>
 <528DF164.8060009@st.com>
 <20131121131402.GF1029@lukather>
 <52926901.9080004@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PPYy/fEw/8QCHSq3"
In-Reply-To: <52926901.9080004@kernel.org>
List-ID: <linux-iio@vger.kernel.org>


--PPYy/fEw/8QCHSq3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Sun, Nov 24, 2013 at 09:00:49PM +0000, Jonathan Cameron wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> On 11/21/13 13:14, Maxime Ripard wrote:
> > Hi Denis,
> >=20
> > On Thu, Nov 21, 2013 at 12:41:24PM +0100, Denis CIOCCA wrote:
> > > only one point: it's possible to use the same names with DT?
> > > (using _ instead of -)
> >=20
> > Yes, it is, but only for i2c as far as I'm aware, and usually the
> > DT compatibles are with - as a separator (I looked into the ePAPR,
> > but couldn't get any explanations or requirements on this, even
> > though it's used in all of their examples)
>=20
> In other discussions, where the defacto i2c device tree bindings have
> been followed, the conclusion has been that to change to a - from _
> would result in userspace ABI changes, so whilst no one wants _
> the discussion has concluded we can't really avoid it.

What kind of userspace ABI changes are we talking about?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--PPYy/fEw/8QCHSq3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSkxscAAoJEBx+YmzsjxAgWiMP/jBdur8xLhAaVG6Niy2roX51
jVau/Fg9mE7aL+N0ICOlATZ80mUhEuldvIvtBa/3IpHbXUyEwyWvhQVUfKzVqn+5
65hU4lezpKb0TOS0I31If2oBO3cvgGX/A0l17FQTtCDyJnYci3SUlsQKiCYA2CqT
+K9KXHyGQ0ngNQaTTEO+KuGHyV3MvNdEeZFX9/LAq5g33frFXKK98CsEL4SsPFEK
1c1VBA27g6/nqVL966FZqTUO9NKOE3AShay2Ohun2RSbT0uI77bCk5Lcm8h+O8Cl
BxBSdiXgWkE1qQOKKitOV53Js9K550XZS/uOI5e7nZD0Vu9BceCg48NZ1biey37K
mxxoalvS4i1Utc68p99P3sHrLZHMYsDT9Fh8t7T7SCK2B0f64zG4w2eRQFgPCubB
YWVev5SEbnkP9icBNbL4SWrUKTY3iOIgaNjMRlI+clHteiw9vPMECyaJ8YK3tnE+
2OnvX8mWMdXnuaMnKg0V00+Hixb0WBP8uHr4A/Iwx1OHFXFD4IrnQz+tyZrYhlKb
Kktlx6g8bXGoAIHAK9RDQjz5vrYSTaNaJNdfKKrJf/b8uSLb3A3zEEAhXfzSfMcF
TalF29MDWe5xnYspdn/7dCNoMqgZ3Nuyn6oqDDGcNmhIgMPgBDivFkyy8Cw9hoiF
4/Y1RaSjXmJASVFeVct4
=ffyF
-----END PGP SIGNATURE-----

--PPYy/fEw/8QCHSq3--
