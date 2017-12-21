Return-Path: <SRS0=rQYu=DR=melexis.com=cmo@kernel.org>
MIME-Version: 1.0
In-Reply-To: <95b9b2b52554410a85a9f10c7f5e8b13@AcuMS.aculab.com>
References: <20171220142001.18161-1-cmo@melexis.com> <1c1d0ffa8ee140bf9adbc78f1559b1e8@AcuMS.aculab.com>
 <20171220160001.manjff26gfbjccsw@hirez.programming.kicks-ass.net>
 <CAKv63uuL9+xzF7KruhYwSY68-M0=aJSvJOr5Y0vVBiX8ebqfeg@mail.gmail.com>
 <c3462afd27d14c8684ee33ef6623a31a@AcuMS.aculab.com> <CAKv63utKNW2--ZnkoJ0z++68764cX_S9xS9Gst_vj7eDsFAZrg@mail.gmail.com>
 <95b9b2b52554410a85a9f10c7f5e8b13@AcuMS.aculab.com>
From: Crt Mori <cmo@melexis.com>
Date: Thu, 21 Dec 2017 14:17:43 +0100
Message-ID: <CAKv63usT8GU-51AmMLJb3hD3CHxf1M5KTQvYhK+0UVMT13Nbag@mail.gmail.com>
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

On 21 December 2017 at 12:43, David Laight <David.Laight@aculab.com> wrote:
> From: Crt Mori
>> Sent: 20 December 2017 17:30
>> I did a quick run through unit tests for the sensor and the results
>> are way off
>> ...
>
> Try this version instead:
> unsigned int sqrt64(unsigned long long x_in)
> {
>         unsigned int x = x_in >> 32;
>
>         unsigned int b = 0;
>         unsigned int y = 0;
>         unsigned int i;

i can be u8. And I will still use explicit typing.

>
>         i = 31;
>         if (!x) {
>                 x = x_in;
>                 i = 15;
>         }
>         if (!(x & 0xffff0000)) {
>                 x <<= 16;
>                 i -= 8;
>         }
>         if (!(x & 0xff000000)) {
>                 x <<= 8;
>                 i -= 4;
>         }
>         if (!(x & 0xf0000000)) {
>                 x <<= 4;
>                 i -= 2;
>         }
>

This part above looks like FLS

>         do {
>                 b <<= 2;
>                 b |= x >> 30;
>                 x <<= 2;
>                 if (i == 16)
>                         x = x_in;
>                 y <<= 1;
>                 if (b > y) {
>                         b -= ++y;
>                         y++;
>                 }
>         } while (--i);
>
>         /* 'b' becomes 33 bits if the input is greater than 2^62 */
>         b <<= 1;
>         b |= x >> 31;
>         if (b > y || (b == y && x & (1u << 30)))
>                 y |= 1;
>
>         return y;
> }
>
> I've tested that one with more values.
>
>         David
>

This one indeed works. I did some more testing this morning and I am
fine with either.

So question is: Do I make change as per David's suggestion with his
sign-off, or leave the version it was before the change?
