Return-Path: <SRS0=sgBj=EH=ACULAB.COM=David.Laight@kernel.org>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Crt Mori' <cmo@melexis.com>
CC: Peter Zijlstra <peterz@infradead.org>, Jonathan Cameron
	<jic23@kernel.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Rusty Russell
	<rusty@rustcorp.com.au>, Ian Abbott <abbotti@mev.co.uk>, Larry Finger
	<Larry.Finger@lwfinger.net>, Niklas Soderlund
	<niklas.soderlund+renesas@ragnatech.se>, Thomas Gleixner
	<tglx@linutronix.de>, Krzysztof Kozlowski <krzk@kernel.org>, Masahiro Yamada
	<yamada.masahiro@socionext.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, Joe Perches <joe@perches.com>
Subject: RE: [PATCH v10 1/3] lib: Add strongly typed 64bit int_sqrt
Date: Fri, 12 Jan 2018 09:41:40 +0000
Message-ID: <7a331e1dbd634af7974b157bddf1a9c5@AcuMS.aculab.com>
References: <20171220142001.18161-1-cmo@melexis.com>
 <1c1d0ffa8ee140bf9adbc78f1559b1e8@AcuMS.aculab.com>
 <20171220160001.manjff26gfbjccsw@hirez.programming.kicks-ass.net>
 <CAKv63uuL9+xzF7KruhYwSY68-M0=aJSvJOr5Y0vVBiX8ebqfeg@mail.gmail.com>
 <c3462afd27d14c8684ee33ef6623a31a@AcuMS.aculab.com>
 <CAKv63utKNW2--ZnkoJ0z++68764cX_S9xS9Gst_vj7eDsFAZrg@mail.gmail.com>
 <95b9b2b52554410a85a9f10c7f5e8b13@AcuMS.aculab.com>
 <CAKv63usT8GU-51AmMLJb3hD3CHxf1M5KTQvYhK+0UVMT13Nbag@mail.gmail.com>
 <b743750a1bd64ed2bf800cec9da9afff@AcuMS.aculab.com>
 <20171221141130.cdng2mysnjj6j4i6@hirez.programming.kicks-ass.net>
 <79658484b99a4f65bb3a1937b3d156ad@AcuMS.aculab.com>
 <CAKv63uuLKNZ5yJLp2LahDqE6NSi3UMRGaMsBrj2e03joU_cC1w@mail.gmail.com>
 <CAKv63usmDy7LdF6Lbc_CnuSCzYWtrhtBHgasvTYbT8wL2uuC8A@mail.gmail.com>
In-Reply-To: <CAKv63usmDy7LdF6Lbc_CnuSCzYWtrhtBHgasvTYbT8wL2uuC8A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

RnJvbTogQ3J0IE1vcmkgW21haWx0bzpjbW9AbWVsZXhpcy5jb21dDQo+IFNlbnQ6IDA5IEphbnVh
cnkgMjAxOCAxNToxOA0KPiANCj4gSXQgaGFzIGJlZW4gc29tZSB0aW1lIG5vdyBzaW5jZSB0aGlz
IG1vdmVkLiBJIGhhdmUgZGVjaWRlZCBub3QgdG8gdXNlDQo+IERhdmlkJ3MgaW1wbGVtZW50YXRp
b24gYmVjYXVzZSBJIHdhbnQgdG8gbWFpbnRhaW4gYWxzbyByYW5nZSBhYm92ZQ0KPiAyXjYyDQoN
ClRoZSBsYXN0IHZlcnNpb24gSSBkaWQgc3VwcG9ydGVkIHRoZSBmdWxsIHJhbmdlLg0KDQoJRGF2
aWQNCg0K
