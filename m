Return-Path: <SRS0=LA0V=EE=melexis.com=cmo@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKv63uuLKNZ5yJLp2LahDqE6NSi3UMRGaMsBrj2e03joU_cC1w@mail.gmail.com>
References: <20171220142001.18161-1-cmo@melexis.com> <1c1d0ffa8ee140bf9adbc78f1559b1e8@AcuMS.aculab.com>
 <20171220160001.manjff26gfbjccsw@hirez.programming.kicks-ass.net>
 <CAKv63uuL9+xzF7KruhYwSY68-M0=aJSvJOr5Y0vVBiX8ebqfeg@mail.gmail.com>
 <c3462afd27d14c8684ee33ef6623a31a@AcuMS.aculab.com> <CAKv63utKNW2--ZnkoJ0z++68764cX_S9xS9Gst_vj7eDsFAZrg@mail.gmail.com>
 <95b9b2b52554410a85a9f10c7f5e8b13@AcuMS.aculab.com> <CAKv63usT8GU-51AmMLJb3hD3CHxf1M5KTQvYhK+0UVMT13Nbag@mail.gmail.com>
 <b743750a1bd64ed2bf800cec9da9afff@AcuMS.aculab.com> <20171221141130.cdng2mysnjj6j4i6@hirez.programming.kicks-ass.net>
 <79658484b99a4f65bb3a1937b3d156ad@AcuMS.aculab.com> <CAKv63uuLKNZ5yJLp2LahDqE6NSi3UMRGaMsBrj2e03joU_cC1w@mail.gmail.com>
From: Crt Mori <cmo@melexis.com>
Date: Tue, 9 Jan 2018 16:18:01 +0100
Message-ID: <CAKv63usmDy7LdF6Lbc_CnuSCzYWtrhtBHgasvTYbT8wL2uuC8A@mail.gmail.com>
Subject: Re: [PATCH v10 1/3] lib: Add strongly typed 64bit int_sqrt
To: David Laight <David.Laight@aculab.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Jonathan Cameron <jic23@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>, Rusty Russell <rusty@rustcorp.com.au>,
	Ian Abbott <abbotti@mev.co.uk>, Larry Finger <Larry.Finger@lwfinger.net>,
	Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>,
	Thomas Gleixner <tglx@linutronix.de>, Krzysztof Kozlowski <krzk@kernel.org>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

It has been some time now since this moved. I have decided not to use
David's implementation because I want to maintain also range above
2^62

Are there any additional objections for this not to go in as it is?

On 22 December 2017 at 14:44, Crt Mori <cmo@melexis.com> wrote:
>
> From simple strong typing of existing int_sqrt we came to something a
> bit more complex or better. Can we decide now which we want in, or I
> submit v12 and we decide then (although it is not a v12, but whole new
> thing)?
>
> On 21 December 2017 at 15:48, David Laight <David.Laight@aculab.com> wrote:
> > From: Peter Zijlstra
> >> Sent: 21 December 2017 14:12
> > ...
> >> > > This part above looks like FLS
> >> > It also does the rest of the required shifts.
> >>
> >> Still, fls() + shift is way faster on hardware that has an fls
> >> instruction.
> >>
> >> Writing out that binary search doesn't make sense.
> >
> > If the hardware doesn't have an appropriate fls instruction
> > the soft fls()will be worse.
> >
> > If you used fls() you'd still need quite a bit of code
> > to generate the correct shift and loop count adjustment.
> > Given the cost of the loop iterations the 3 tests are noise.
> > The open coded version is obviously correct...
> >
> > I didn't add the 4th one because the code always does 2 iterations.
> >
> > If you were really worried about performance there are faster
> > algorithms (even doing 2 or 4 bits a time is faster).
> >
> >         David
> >
