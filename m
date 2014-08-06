Return-Path: <balbi@ti.com>
Date: Wed, 6 Aug 2014 17:18:23 -0500
From: Felipe Balbi <balbi@ti.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: Felipe Balbi <balbi@ti.com>, <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [RFC/PATCH] iio: light: add support for TI's opt3001 ligth sensor
Message-ID: <20140806221823.GE3556@saruman.home>
Reply-To: <balbi@ti.com>
References: <1407341409-30284-1-git-send-email-balbi@ti.com>
 <alpine.DEB.2.01.1408061815140.29646@pmeerw.net>
 <20140806214222.GB3556@saruman.home>
 <alpine.DEB.2.01.1408062347350.7595@pmeerw.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bi5JUZtvcfApsciF"
In-Reply-To: <alpine.DEB.2.01.1408062347350.7595@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

--bi5JUZtvcfApsciF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 07, 2014 at 12:09:36AM +0200, Peter Meerwald wrote:
> > > > +		.scan_type =3D {
> > > > +			.sign =3D 'u',
> > >=20
> > > .realbits / .storagebits missing?
> >=20
> > yeah, couldn't figure this out. The HW gives me a 16-bit value where
> > 12-bits are the mantissa and 4-bits are for the exponent. Should I call
> > realbits 16 and storagebits 32 ?
>=20
> so .realbits =3D 16 and .storagebits =3D 16, but there is no way to descr=
ibe=20
> the mantissa/exponent thing to userspace
>=20
> you are not using iio_triggered_buffer_setup() yet, so no need for=20
> .scan_type (yet)

ok... but then that brings up a doubt. What would I use triggered buffer
for ? I already setup High/Low limits (thresholds) through
=2Ewrite_event_value(). Isn't that, pretty much, a triggered buffer ?

--=20
balbi

--bi5JUZtvcfApsciF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT4qmvAAoJEIaOsuA1yqREsWQP/0gdcS1UjUo43S35jstjOt7E
APYwvrcOlAPKJmJp31+OaU/njj959l+BbbW4MJsv27lTYfTygj4/1Ha7vAdb7aQz
xbvieQ6ktSQQ/1BxXoyv6OBZPRz1k64G3olYkZrz8fUSiNeNCUw6fQ1l3LFm+j/h
/9EO+wRv36gwXE8X57OBTYtTznK+xp+yxnsET5fbWSdwJY5rexqFF0651hD3PHH3
xrhLeh0aDQLPGK8elphAya76df0svF5GNNv1qf9m/dlhT7GG2C8wFNgdUmwBtYmq
l+rhwl3nPUxdZWh27V5w4cUvDATNv6VyU0jF+Wzb8mWwmTNXaYxRLgXeQBtKD/Sk
H6ONyWlrJzFOwCx2w20iwd1rILrmZKTRfrOPvBoC0vLlNBqsfUUiko+drThRubbf
vN+XU/yEMxPOm5NNr/1K371Zu0dCjN3aOqo39Hm6vv+SCRHib0lu2q2xXuEpG4Tm
e1AMvRiJ1IO5DyWDlDfgmLfVxQ7qmnrnNanYrq/EVuAba8n9ITTrAg7snsOqmg8Y
lzNZQpKkzshIXotCs6BnvaNanyACTtrG4qRbJTUrq1xdZexn6Dd1s+oVO6SNb3aR
NXyf/t9YrMkTL3dWj1Fbt9g8QVj3vEn3RNEKLJETfQxJDgtGNtlEXnSysOZ5W5mG
SBPd7t7yNgdAgf7Kg7qk
=ZvYO
-----END PGP SIGNATURE-----

--bi5JUZtvcfApsciF--
