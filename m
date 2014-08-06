Return-Path: <balbi@ti.com>
Date: Wed, 6 Aug 2014 17:30:45 -0500
From: Felipe Balbi <balbi@ti.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: Felipe Balbi <balbi@ti.com>, <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [RFC/PATCH] iio: light: add support for TI's opt3001 ligth sensor
Message-ID: <20140806223045.GF3556@saruman.home>
Reply-To: <balbi@ti.com>
References: <1407341409-30284-1-git-send-email-balbi@ti.com>
 <alpine.DEB.2.01.1408061815140.29646@pmeerw.net>
 <20140806214222.GB3556@saruman.home>
 <alpine.DEB.2.01.1408062347350.7595@pmeerw.net>
 <20140806221823.GE3556@saruman.home>
 <alpine.DEB.2.01.1408070021420.7595@pmeerw.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/aVve/J9H4Wl5yVO"
In-Reply-To: <alpine.DEB.2.01.1408070021420.7595@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

--/aVve/J9H4Wl5yVO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 07, 2014 at 12:25:59AM +0200, Peter Meerwald wrote:
> > > > > > +		.scan_type =3D {
> > > > > > +			.sign =3D 'u',
> > > > >=20
> > > > > .realbits / .storagebits missing?
> > > >=20
> > > > yeah, couldn't figure this out. The HW gives me a 16-bit value where
> > > > 12-bits are the mantissa and 4-bits are for the exponent. Should I =
call
> > > > realbits 16 and storagebits 32 ?
> > >=20
> > > so .realbits =3D 16 and .storagebits =3D 16, but there is no way to d=
escribe=20
> > > the mantissa/exponent thing to userspace
> > >=20
> > > you are not using iio_triggered_buffer_setup() yet, so no need for=20
> > > .scan_type (yet)
> >=20
> > ok... but then that brings up a doubt. What would I use triggered buffer
> > for ? I already setup High/Low limits (thresholds) through
> > .write_event_value(). Isn't that, pretty much, a triggered buffer ?
>=20
> a triggered buffer reads data from the device and stores it into a buffer=
=20
> whenever the trigger goes off (you are interested to capture all samples)

Alright, so something like a contious capture starting after a GPIO goes
off, or something ?

> events are created on certain conditions (you are not interested in all=
=20
> samples)

And this would be more like e.g. "tell me once I have 100 lux or more" ?

--=20
balbi

--/aVve/J9H4Wl5yVO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT4qyVAAoJEIaOsuA1yqREHqEQAJyDRgBSKHtPL8tLH4FW/sOZ
3HJs4lylqk28sh4qc47G1bSYh6k9saN569lpgJgcnbgdEf3HMVYmKPsiXPfh/dzf
v1Pv1KrEcNR/3iGuKnyEU6cL/CTkrmdvWmHJTMHXURL+5cU04cwtlsfxFZZY3r3u
cXoCzT2qcrUiK1wiHLE8COP4sVO/IJPrOr2i0G23lx5RdM7LgQVlXg8nU9FvM1hS
waS9DhSy+lBiqJXjW2527t4wc62mzHNl9u0+T2vjbbaH5vWAn0GS98D9ocBWtL0a
51NNwAGI+N3RrXJ+yIYdwXoQxpmQLUJuvvzqZT00mq4NfV6AR6EOAoyoQOl5ASR1
WDlZZJbbifco8gSBVHz/RjO4VFXBCYbE5TxJv2iKgfofD8qB7qhLMpZvtubTS2Go
3+2gi19d7uDSdsvZPycjlTvGOItVl8zCdSxG7i7PjfDwgQMIjv+3Jh6FsgGYw5VI
9w1BqlhnQI7m2pFrkFrb5rdQ2QPU80wbqFLOFDXq6dQAWxn9qI06q7mq8ANX8Mf8
NGeHgYYwFvP3vhrJaC5FzvG18DthxaNAUkFDgO90jACREHrqCW/XIKILjFk1txcH
jqXDvt0UGaRJ6AFgoV4+CRR+sxuFvEKWA+0XbSYqni7p2dQSQl+xEAGuXD7jzd4/
QVZ47gNyNnyg9t+uZmtV
=OLv2
-----END PGP SIGNATURE-----

--/aVve/J9H4Wl5yVO--
