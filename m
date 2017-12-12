Return-Path: <SRS0=2XFX=DI=rwth-aachen.de=Stefan.Bruens@kernel.org>
From: Stefan =?ISO-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>
To: Jonathan Cameron <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Maciej Purski <m.purski@samsung.com>, <linux-kernel@vger.kernel.org>, "Andrew
 F . Davis" <afd@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Hartmut Knaack
	<knaack.h@gmx.de>
Subject: Re: [PATCH v1 3/7] iio: adc: ina2xx: Remove unneeded dummy read to clear CNVR flag
Date: Wed, 13 Dec 2017 00:48:40 +0100
Message-ID: <2569854.02uJhrbl9B@pebbles>
In-Reply-To: <20171212201530.3c64d47e@archlinux>
References: <20171208174152.30341-1-stefan.bruens@rwth-aachen.de> <1575331.Q2WhDFQurN@pebbles> <20171212201530.3c64d47e@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3923781.Ejxvntlrnk";
	micalg=pgp-sha1; protocol="application/pgp-signature"
List-ID: <linux-iio@vger.kernel.org>

--nextPart3923781.Ejxvntlrnk
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday, December 12, 2017 9:15:30 PM CET Jonathan Cameron wrote:
> On Sun, 10 Dec 2017 21:53:42 +0100
>=20
> Stefan Br=FCns <stefan.bruens@rwth-aachen.de> wrote:
> > On Sunday, December 10, 2017 6:27:33 PM CET Jonathan Cameron wrote:
> > > On Fri, 8 Dec 2017 18:41:48 +0100
> > >=20
> > > Stefan Br=FCns <stefan.bruens@rwth-aachen.de> wrote:
> > > > Although the datasheet states the CNVR flag is cleared by reading t=
he
> > > > BUS_VOLTAGE register, it is actually cleared by reading any of the
> > > > voltage/current/power registers.
> > > >=20
> > > > The behaviour has been confirmed by TI support:
> > > > http://e2e.ti.com/support/amplifiers/current-shunt-monitors/f/931/p=
/64
> > > > 7053
> > > > /2378282
> > > >=20
> > > > Signed-off-by: Stefan Br=FCns <stefan.bruens@rwth-aachen.de>
> > >=20
> > > I haven't checked the code thoroughly so there may well be something
> > > stopping it but have you checked the case where the only channel enab=
led
> > > is
> > > the timestamp?
> > >=20
> > > Obviously it makes little sense, but IIRC there is nothing in the core
> > > preventing that happening.
> >=20
> > The timestamp is completely unrelated to the status register, so I fail=
 to
> > understand your question. Can you please clarify?
>=20
> If you only have a timestamp, the trigger will still fire (I think)
> but you'll do no reading at all from the device.  If configured in this,
> admittedly odd, way you should just get a stream of timestamps with no
> data.

If there are reads depends on the mode - if running asynchronously, it will=
=20
just stream out 64 bits of timestamp each interval. In synchronous mode, th=
e=20
driver will read the status register (low bits of bus voltage register for=
=20
INA219, msk register for INA226), which implicitly clears the CNVR flag.
=20
> > This only removes a redundant read.
>=20
> The question is whether it is redundant if we have no non timestamp
> registers enabled.

According to the documentation, INA219 and 226 had to be treated differentl=
y.=20
As it turned out, both actually behave the same way regarding the CNVR flag=
,=20
so we just poll the status register, which for both devices clears the flag.

Regards,

Stefan


=2D-=20
Stefan Br=FCns  /  Bergstra=DFe 21  /  52062 Aachen
home: +49 241 53809034     mobile: +49 151 50412019
--nextPart3923781.Ejxvntlrnk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSwWRWIpJbl0W4DemNvf0o9jP6qUwUCWjBq2AAKCRBvf0o9jP6q
U7+JAJ0fm0sEFiSPeoMF6xtS4jc9dqjZpwCeKUPrqr/bi8KHv5Y6m7tqHxGQXP4=
=B+35
-----END PGP SIGNATURE-----

--nextPart3923781.Ejxvntlrnk--
