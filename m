Return-Path: <SRS0=YFRY=DQ=ACULAB.COM=David.Laight@kernel.org>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Crt Mori' <cmo@melexis.com>, Jonathan Cameron <jic23@kernel.org>
CC: Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>, Rusty Russell <rusty@rustcorp.com.au>,
	"Ian Abbott" <abbotti@mev.co.uk>, Larry Finger <Larry.Finger@lwfinger.net>,
	"Niklas Soderlund" <niklas.soderlund+renesas@ragnatech.se>, Thomas Gleixner
	<tglx@linutronix.de>, Krzysztof Kozlowski <krzk@kernel.org>, Masahiro Yamada
	<yamada.masahiro@socionext.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Joe
 Perches" <joe@perches.com>
Subject: RE: [PATCH v10 1/3] lib: Add strongly typed 64bit int_sqrt
Date: Wed, 20 Dec 2017 14:39:26 +0000
Message-ID: <1c1d0ffa8ee140bf9adbc78f1559b1e8@AcuMS.aculab.com>
References: <20171220142001.18161-1-cmo@melexis.com>
In-Reply-To: <20171220142001.18161-1-cmo@melexis.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

From: Crt Mori
> Sent: 20 December 2017 14:20
>=20
> There is no option to perform 64bit integer sqrt on 32bit platform.
> Added stronger typed int_sqrt64 enables the 64bit calculations to
> be performed on 32bit platforms. Although int_sqrt() is a rough
> approximation, the same algorithm is used in int_sqrt64() as good
> enough on 32bit platform.

The algorithm used gives an exact (rounded down) square root,
not an approximation.

With minor changes it ought to be possible to remove most of the
64bit arithmetic and shifts.

If you care about performance then using 32 bit maths will be much faster.

	David
