Return-Path: <SRS0=gXBR=DR=infradead.org=peterz@kernel.org>
Date: Thu, 21 Dec 2017 15:11:30 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'Crt Mori' <cmo@melexis.com>, Jonathan Cameron <jic23@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Ian Abbott <abbotti@mev.co.uk>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Joe Perches <joe@perches.com>
Subject: Re: [PATCH v10 1/3] lib: Add strongly typed 64bit int_sqrt
Message-ID: <20171221141130.cdng2mysnjj6j4i6@hirez.programming.kicks-ass.net>
References: <20171220142001.18161-1-cmo@melexis.com>
 <1c1d0ffa8ee140bf9adbc78f1559b1e8@AcuMS.aculab.com>
 <20171220160001.manjff26gfbjccsw@hirez.programming.kicks-ass.net>
 <CAKv63uuL9+xzF7KruhYwSY68-M0=aJSvJOr5Y0vVBiX8ebqfeg@mail.gmail.com>
 <c3462afd27d14c8684ee33ef6623a31a@AcuMS.aculab.com>
 <CAKv63utKNW2--ZnkoJ0z++68764cX_S9xS9Gst_vj7eDsFAZrg@mail.gmail.com>
 <95b9b2b52554410a85a9f10c7f5e8b13@AcuMS.aculab.com>
 <CAKv63usT8GU-51AmMLJb3hD3CHxf1M5KTQvYhK+0UVMT13Nbag@mail.gmail.com>
 <b743750a1bd64ed2bf800cec9da9afff@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b743750a1bd64ed2bf800cec9da9afff@AcuMS.aculab.com>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Dec 21, 2017 at 01:56:55PM +0000, David Laight wrote:
> > This part above looks like FLS
> It also does the rest of the required shifts.

Still, fls() + shift is way faster on hardware that has an fls
instruction.

Writing out that binary search doesn't make sense.
