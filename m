Return-Path: <SRS0=EQoT=DR=ACULAB.COM=David.Laight@kernel.org>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Joe Perches' <joe@perches.com>, 'Crt Mori' <cmo@melexis.com>, "Peter
 Zijlstra" <peterz@infradead.org>
CC: Jonathan Cameron <jic23@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>,
	Rusty Russell <rusty@rustcorp.com.au>, Ian Abbott <abbotti@mev.co.uk>, "Larry
 Finger" <Larry.Finger@lwfinger.net>, Niklas Soderlund
	<niklas.soderlund+renesas@ragnatech.se>, Thomas Gleixner
	<tglx@linutronix.de>, Krzysztof Kozlowski <krzk@kernel.org>, Masahiro Yamada
	<yamada.masahiro@socionext.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Subject: RE: [PATCH v10 1/3] lib: Add strongly typed 64bit int_sqrt
Date: Thu, 21 Dec 2017 10:02:32 +0000
Message-ID: <24b40255d28242d7accc0b6a13b5ad1f@AcuMS.aculab.com>
References: <20171220142001.18161-1-cmo@melexis.com>
         <1c1d0ffa8ee140bf9adbc78f1559b1e8@AcuMS.aculab.com>
         <20171220160001.manjff26gfbjccsw@hirez.programming.kicks-ass.net>
         <CAKv63uuL9+xzF7KruhYwSY68-M0=aJSvJOr5Y0vVBiX8ebqfeg@mail.gmail.com>
         <c3462afd27d14c8684ee33ef6623a31a@AcuMS.aculab.com>
 <1513790375.1234.121.camel@perches.com>
In-Reply-To: <1513790375.1234.121.camel@perches.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

From: Joe Perches
> Sent: 20 December 2017 17:20
...
> > I think this version works.
> > It doesn't have the optimisation for small values.
> >
> > unsigned int sqrt64(unsigned long long x)
> > {
> >         unsigned int x_hi =3D x >> 32;
> >
> >         unsigned int b =3D 0;
> >         unsigned int y =3D 0;
> >         unsigned int i;
> >
>=20
> Perhaps add:
>=20
> 	if (x <=3D UINT_MAX)
> 		return int_sqrt((unsigned long)x);

Actually something like:
	i =3D 32;
	if (!x_hi) {
		x_hi =3D x;
		i =3D 16;
	}
=09
	if (!(x_hi & 0xffff0000)) {
		x_hi <<=3D 16;
		i -=3D 8;
	}
Repeat for 0xff000000, 0xf0000000 and 0xc0000000 and adjust loop to count d=
own.

	David

>=20
> >         for (i =3D 0; i < 32; i++) {
> >                 b <<=3D 2;
> >                 b |=3D x_hi >> 30;
> >                 x_hi <<=3D 2;
> >                 if (i =3D=3D 15)
> >                         x_hi =3D x;
> >                 y <<=3D 1;
> >                 if (b > y)
> >                         b -=3D ++y;
> >         }
> >         return y;
> > }
> >
> > Put it through cc -O3 -m32 -c -o sqrt64.o sqrt64.c and then objdump sqr=
t64.o
> > and compare to that of your version.
> >
> > 	David
> >
