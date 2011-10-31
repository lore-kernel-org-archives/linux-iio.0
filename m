Return-Path: <dan.carpenter@oracle.com>
Date: Mon, 31 Oct 2011 14:38:20 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org
Subject: Re: linux-next: build error from iio_simple_dummy_buffer.c
Message-ID: <20111031113820.GB15494@mwanda>
References: <20111028112910.GB14881@longonot.mountain>
 <4EAE8574.2050900@cam.ac.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
In-Reply-To: <4EAE8574.2050900@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 31, 2011 at 11:24:36AM +0000, Jonathan Cameron wrote:
> On 10/28/11 12:29, Dan Carpenter wrote:
> > I get a compile error in linux-next:
> >=20
> >   CC [M]  drivers/staging/iio/iio_simple_dummy_buffer.o
> >   drivers/staging/iio/iio_simple_dummy_buffer.c: In function =E2=80=98i=
io_simple_dummy_configure_buffer=E2=80=99:
> >   drivers/staging/iio/iio_simple_dummy_buffer.c:154:18: error: =E2=80=
=98THIS_MODULE=E2=80=99 undeclared (first use in this function)
> >   drivers/staging/iio/iio_simple_dummy_buffer.c:154:18: note: each unde=
clared identifier is reported only once for each function it appears in
> >   make[1]: *** [drivers/staging/iio/iio_simple_dummy_buffer.o] Error 1
> >   make: *** [drivers/staging/iio/iio_simple_dummy_buffer.o] Error 2
> >=20
> > We could just include <linux/module.h> I guess?
> Yup, my bad.  Do you want to do the patch, or shall I do it and
> credit it to you?

Do no work and collect a Reported-by is always prefered.  :)

thanks,
dan carpenter



--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOroisAAoJEOnZkXI/YHqRXC8P/iDgFDAmr6/OZUl0hB3vgZBR
1IHMIOQGmtYz3+lg8pvLhtyYx+ixfR1iYStzoppR/pXEfWz/IrXWd+UW3alhRwcJ
TseKa89+cj409Fr0aByb9esiaukEKhSXuGMzZ6mg4bVSYViCFIrQlLnXUaUHx+f7
fCdd7e3AKbjB7WUtcHz3xG11MJL8FxoH726ua7Zxpna1sUq3ziBGk0K41s8vFWNg
Z/orfTO7SnUB/8qgioYljCiB6ZK1HlFrpYNEuaoCEnLCAJexowxHf9yLa9i9hCvN
RNoqIHgCKoFNJnucitIl/pQUtkg/QcZFueBeJOn0/N0JKDS8iY00lqDMbSAixlRA
i8HBeft2b1yFChzxO9aPrenH5nUtaFpOpIeyHV9UV13Lhbg9NH7uHlVS43WZG825
MdaCr4EOeVi7S1BQ+oSupLn5SZtpxypN5CdGwHyod/s5TZ0K6JKQFWBDA/ci2JfO
7HYpaBWREKggeZZvOY9sfzFx9yEzyZt2tDl87aG2uAeKu0szIrAHUKNH7oN3DrKU
ZexUZs02oSSBYfqy/qTuKbdW8IJrku2vF8KUQ6aX2AvAExnn4PRfg7cQ9Mb4Mh3C
FmU//NGnnDPfha6NvBvGfR2QR50zp3ePUqPVbzCYc6a5mHegCPoHMXNZlOOWLsio
W4tbev8zWBKnPwyKt/vY
=O5Sd
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--
