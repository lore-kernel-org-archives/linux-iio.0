Return-Path: <SRS0=wWwz=EW=ucw.cz=pavel@kernel.org>
Date: Sat, 27 Jan 2018 23:09:32 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "jic23@kernel.org" <jic23@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [RFP] iio: Support of gesture sensor as a standard IIO sensor
Message-ID: <20180127220931.GA19668@amd>
References: <1515197240.26317.65.camel@intel.com>
 <20180118224026.GE17196@amd>
 <20180120151908.1d438aaf@archlinux>
 <1516480282.15527.4.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
In-Reply-To: <1516480282.15527.4.camel@intel.com>
List-ID: <linux-iio@vger.kernel.org>


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2018-01-20 20:31:23, Pandruvada, Srinivas wrote:
> On Sat, 2018-01-20 at 15:19 +0000, Jonathan Cameron wrote:
> > On Thu, 18 Jan 2018 23:40:26 +0100
> > Pavel Machek <pavel@ucw.cz> wrote:
> >=20
> > >=20
> > > Hi!
> > >=20
> > > >=20
> > > > From an IIO sensor point of view A Gesture sensor:
> > > > Outputs
> > > > 	A pre defined activity type
> > > > 		WAKE
> > > > 		TILT
> > > > 		GLANCE
> > > > 		PICK_UP
> > > > 		=A0&
> > > > 		=A0more
> > > >=20
> > > > 	A user defined activity type as "string"=A0=A0
> > > Pre-defined activities are easy.
> > >=20
> > > But what about user-defined activities? We'd really like common
> > > interface across different hardware...=A0
> > Nasty to handle indeed.=A0=A0=A0It may be the best we can do initially
> > at least is user_definedN or similar.=A0=A0No way of constraining
> > users from uploading something really odd that we can't define
> > an interface for (hopping whilst holding a phone in
> > their teeth?)
> That's what I think also. We pre define few USER defined activities
> Ids.

Ok, so this is really device for human interaction -- input device.

> > > > Inputs
> > > > 	A raw binary cdev interface to download templates/patterns=A0=A0
> > > ....and "raw binary" will not work across different hardware :-(.
> > Sadly there probably isn't much we can do about the format being
> > custom.
> > Best bet would ultimately be if there was at least a standard tool
> > to generate the files for different devices...
> >=20
> Correct. This will depend on =A0the firmware expected format . I think
> ultimately it will be standardized.

Is it fair to say that "expected" format is some kind of bytecode for
CPU in the gesture sensor?

We have similar problem with smart LED devices...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlps+JsACgkQMOfwapXb+vL0SwCeKA0Ng9x4fp1wF5AipENupu2x
dRgAoK5pJ3zCQj23Hi/gAIR9lVaNIf4x
=TjXy
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
