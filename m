Return-Path: <gregor.boirie@parrot.com>
Date: Sun, 4 Sep 2016 18:11:29 +0200
From: Gregor Boirie <gregor.boirie@parrot.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter
 Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1 1/1] iio:core: fix IIO_VAL_FRACTIONAL sign handling
Message-ID: <20160904161128.GA2016@geburah.sephiroth>
References: <e66c33d8d00c51878039a967f2650f7bc1866e90.1472840709.git.gregor.boirie@parrot.com>
 <e20dc6d8-7bd0-0feb-6464-a8af61b880a9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <e20dc6d8-7bd0-0feb-6464-a8af61b880a9@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Sep 03, 2016 at 04:13:30PM +0100, Jonathan Cameron wrote:
> On 02/09/16 19:27, Gregor Boirie wrote:
> > 7985e7c100 ("iio: Introduce a new fractional value type") introduced a
> > new IIO_VAL_FRACTIONAL value type meant to represent rational type numb=
ers
> > expressed by a numerator and denominator combination.
> >=20
> > Formating of IIO_VAL_FRACTIONAL values relies upon do_div() usage. This
> > fails handling negative values properly since parameters are reevaluated
> > as unsigned values.
> > Fix this by using div_s64_rem() instead. Computed integer part will car=
ry
> > properly signed value. Formatted fractional part will always be positiv=
e.
> >=20
> > Fixes: 7985e7c100 ("iio: Introduce a new fractional value type")
> > Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
>=20
> Hi Gregor,
Hi,

>=20
> While this looks sensible to me, I always gain an almighty headache when
> I hit the various divide functions.
So am I.
>=20
> Lars, the fractional code was yours in the first place.
> If you have time can you sanity check this please.
This patch may break a lot things indeed. I'd feel much more comfortable if
someone else could perform additional testing too.

Gr=C3=A9gor.
>=20
> Jonathan
>=20
> > ---
> >  drivers/iio/industrialio-core.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio=
-core.c
> > index f914d5d..d2b8899 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -613,9 +613,8 @@ ssize_t iio_format_value(char *buf, unsigned int ty=
pe, int size, int *vals)
> >  			return sprintf(buf, "%d.%09u\n", vals[0], vals[1]);
> >  	case IIO_VAL_FRACTIONAL:
> >  		tmp =3D div_s64((s64)vals[0] * 1000000000LL, vals[1]);
> > -		vals[1] =3D do_div(tmp, 1000000000LL);
> > -		vals[0] =3D tmp;
> > -		return sprintf(buf, "%d.%09u\n", vals[0], vals[1]);
> > +		vals[0] =3D (int)div_s64_rem(tmp, 1000000000, &vals[1]);
> > +		return sprintf(buf, "%d.%09u\n", vals[0], abs(vals[1]));
> >  	case IIO_VAL_FRACTIONAL_LOG2:
> >  		tmp =3D (s64)vals[0] * 1000000000LL >> vals[1];
> >  		vals[1] =3D do_div(tmp, 1000000000LL);
> >=20
>=20
