Return-Path: <SRS0=snSt=DQ=perches.com=joe@kernel.org>
Message-ID: <1513790375.1234.121.camel@perches.com>
Subject: Re: [PATCH v10 1/3] lib: Add strongly typed 64bit int_sqrt
From: Joe Perches <joe@perches.com>
To: David Laight <David.Laight@ACULAB.COM>, 'Crt Mori' <cmo@melexis.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Kees Cook
 <keescook@chromium.org>, Rusty Russell <rusty@rustcorp.com.au>, Ian Abbott
 <abbotti@mev.co.uk>, Larry Finger <Larry.Finger@lwfinger.net>, Niklas
 Soderlund <niklas.soderlund+renesas@ragnatech.se>, Thomas Gleixner
 <tglx@linutronix.de>,  Krzysztof Kozlowski <krzk@kernel.org>, Masahiro
 Yamada <yamada.masahiro@socionext.com>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>
Date: Wed, 20 Dec 2017 09:19:35 -0800
In-Reply-To: <c3462afd27d14c8684ee33ef6623a31a@AcuMS.aculab.com>
References: <20171220142001.18161-1-cmo@melexis.com>
	 <1c1d0ffa8ee140bf9adbc78f1559b1e8@AcuMS.aculab.com>
	 <20171220160001.manjff26gfbjccsw@hirez.programming.kicks-ass.net>
	 <CAKv63uuL9+xzF7KruhYwSY68-M0=aJSvJOr5Y0vVBiX8ebqfeg@mail.gmail.com>
	 <c3462afd27d14c8684ee33ef6623a31a@AcuMS.aculab.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Wed, 2017-12-20 at 16:46 +0000, David Laight wrote:
> From: Crt Mori
> > Sent: 20 December 2017 16:17
> > 
> > On 20 December 2017 at 17:00, Peter Zijlstra <peterz@infradead.org> wrote:
> > > On Wed, Dec 20, 2017 at 02:39:26PM +0000, David Laight wrote:
> > > 
> > > > With minor changes it ought to be possible to remove most of the
> > > > 64bit arithmetic and shifts.
> > > > 
> > > > If you care about performance then using 32 bit maths will be much faster.
> > > 
> > > Some, u64 add/sub/shift isn't exactly expensive, but yes, I also
> > > indicated that improvement is possible. At the very least y can be made
> > > a u32 I suppose.
> > 
> > OK, is there any more easy optimizations you see?
> 
> I think this version works.
> It doesn't have the optimisation for small values.
> 
> unsigned int sqrt64(unsigned long long x)
> {
>         unsigned int x_hi = x >> 32;
> 
>         unsigned int b = 0;
>         unsigned int y = 0;
>         unsigned int i;
> 

Perhaps add:

	if (x <= UINT_MAX)
		return int_sqrt((unsigned long)x);

>         for (i = 0; i < 32; i++) {
>                 b <<= 2;
>                 b |= x_hi >> 30;
>                 x_hi <<= 2;
>                 if (i == 15)
>                         x_hi = x;
>                 y <<= 1;
>                 if (b > y)
>                         b -= ++y;
>         }
>         return y;
> }
> 
> Put it through cc -O3 -m32 -c -o sqrt64.o sqrt64.c and then objdump sqrt64.o
> and compare to that of your version.
> 
> 	David
> 
