Return-Path: <maxime.ripard@free-electrons.com>
Date: Sat, 30 Nov 2013 15:13:15 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Denis CIOCCA <denis.ciocca@st.com>, Shawn Guo <shawn.guo@linaro.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Brian Lilly <brian@crystalfontz.com>,
	Brent-Crosby <brent@crystalfontz.com>, Jim Wall <jimwall@q.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Jean Delvare <khali@linux-fr.org>
Subject: Re: [RFC PATCH 0/3] DT support for ST micro accelerometers and
 gyroscopes
Message-ID: <20131130141315.GC3002@lukather>
References: <1384876234-1211-1-git-send-email-maxime.ripard@free-electrons.com>
 <528DF164.8060009@st.com>
 <20131121131402.GF1029@lukather>
 <52926901.9080004@kernel.org>
 <20131125094044.GE3176@lukather>
 <5299D3BA.8080700@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5G06lTa6Jq83wMTw"
In-Reply-To: <5299D3BA.8080700@kernel.org>
List-ID: <linux-iio@vger.kernel.org>


--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 30, 2013 at 12:02:02PM +0000, Jonathan Cameron wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> On 11/25/13 09:40, Maxime Ripard wrote:
> > Hi Jonathan,
> >=20
> > On Sun, Nov 24, 2013 at 09:00:49PM +0000, Jonathan Cameron wrote:
> >> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
> >>=20
> >> On 11/21/13 13:14, Maxime Ripard wrote:
> >>> Hi Denis,
> >>>=20
> >>> On Thu, Nov 21, 2013 at 12:41:24PM +0100, Denis CIOCCA wrote:
> >>>> only one point: it's possible to use the same names with DT? (using =
_ instead of -)
> >>>=20
> >>> Yes, it is, but only for i2c as far as I'm aware, and usually the DT =
compatibles are with - as a separator (I
> >>> looked into the ePAPR, but couldn't get any explanations or requireme=
nts on this, even though it's used in all
> >>> of their examples)
> >>=20
> >> In other discussions, where the defacto i2c device tree bindings have =
been followed, the conclusion has been that
> >> to change to a - from _ would result in userspace ABI changes, so whil=
st no one wants _ the discussion has
> >> concluded we can't really avoid it.
> >=20
> > What kind of userspace ABI changes are we talking about?
> IIRC:
>=20
> i2c has a generic binding that matches to the name bit of the i2c_device_=
id
> array.  That is then exported in sysfs.  There are quite a lot of instanc=
es
> of underscores out there in these names.  Thus unforutnately they can't
> be changed without possibly breaking userspace.  Typically those same nam=
es
> are also output by IIO though obviously we could keep that the same whilst
> changing the dt binding.
>=20
> Also the i2c binding allows binding after dropping the vendor prefix which
> is even more 'interesting'. See of_modialias_node in drivers/of/base.c
>=20
> I'd therefore argue in favour of just leaving the underscores in existing
> drivers as a nasty bit of legacy and doing our best to not introduce any
> new ones!

Except I'm not removing anything, just adding new stuff. Therefore,
I'm not breaking anything. The existing users of the underscore stuff
in DT will still work, (if some ever exist, last time I checked, it
wasn't the case) just like they used to.

If we have the occasion of having the thing done like it's done
anywhere else, at no cost, I don't get what the issue is.

Especially since these devices are also usable on other buses than
i2c, which make it quite inconsistent from one bus to another.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--5G06lTa6Jq83wMTw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSmfJ7AAoJEBx+YmzsjxAgEdsQAJkMVSCa61l0LlxW8llYA/g/
Moog9lBzwT1UmNDcau8H8+fzRkisXR2rRindwZ1d3qKjQViDm4NhIriz1rgzVTNF
VC9JioXZNOkGnhnL1r4TWFYTHXDY6TblBiw1yGnUWoPn60eeZV/0WjQ5/V+67q4a
ptSlM2LZfbBKdJkzsQS8cmux/wW3QcajYoqMRNQCDeK1T9qUYxmsA7JNNM2uJae7
YTYfg6sjdLjwbLJfSgPyQUjieeAOydtGV8boa+SBFExRMP2bYd2/7WpOr6N2QXZC
n7eRfgYTcf8IbMbVdlJT6SFRFEolJ6VRip7l4Cg4xEljCIMs/iHOk9lyDVT5HuSj
XkC+Ls0Dt86U+SnXmEQEMHsuagTtYt185O3FHWX6Fjm2a1pDCVJukZeXv3laUUv7
DwVuYOoQcKIgRMVJyH1n+38pGHjD/9BoeqJAPW3vcnKGLs/ETZU6rqJoiQ1hzaXF
1jj0WfdJYBVvXFhrgrzsWQm2p7il9wkUxr9vmUtSLrtQ7xuOmqGtxxJH/ybq0mXo
l8C515AhSUO2U5n+piSvqRKyAs/oZ7lp5zIlbYh4AtifzOojjXEvT/TmLrJ6LF8H
Y6hIO1cLafmliWKe2vrCw0s7IvI+sWuZHmzYFtYjyEgt37qZptrom+GDfrqG7Yk4
qXTf2A7IMd6Eoeg8cCvk
=85aa
-----END PGP SIGNATURE-----

--5G06lTa6Jq83wMTw--
