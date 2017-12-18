Return-Path: <SRS0=Fb7F=DO=perches.com=joe@kernel.org>
Message-ID: <1513614245.31581.98.camel@perches.com>
Subject: Re: [PATCH v6 1/3] lib: Add strongly typed 64bit int_sqrt
From: Joe Perches <joe@perches.com>
To: Crt Mori <cmo@melexis.com>, Jonathan Cameron <jic23@kernel.org>, Peter
	Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>,  Kees Cook <keescook@chromium.org>, Rusty
 Russell <rusty@rustcorp.com.au>, Ian Abbott <abbotti@mev.co.uk>,  Larry
 Finger <Larry.Finger@lwfinger.net>, Niklas Soderlund
 <niklas.soderlund+renesas@ragnatech.se>,  Thomas Gleixner
 <tglx@linutronix.de>, Krzysztof Kozlowski <krzk@kernel.org>, Masahiro
 Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org,
 linux-iio <linux-iio@vger.kernel.org>
Date: Mon, 18 Dec 2017 08:24:05 -0800
In-Reply-To: <20171218150544.8000-1-cmo@melexis.com>
References: <20171218150544.8000-1-cmo@melexis.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Mon, 2017-12-18 at 16:05 +0100, Crt Mori wrote:
> There is no option to perform 64bit integer sqrt on 32bit platform.
> Added stronger typed int_sqrt64 enables the 64bit calculations to
> be performed on 32bit platforms. Although int_sqrt() is a rough
> approximation, the same algorithm is used in int_sqrt64() as good
> enough on 32bit platform.
[]
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
[]
> @@ -459,6 +459,7 @@ extern int kernel_text_address(unsigned long addr);
>  extern int func_ptr_is_kernel_text(void *ptr);
>  
>  unsigned long int_sqrt(unsigned long);
> +u64 int_sqrt64(u64 x);
>  
>  extern void bust_spinlocks(int yes);
>  extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
> diff --git a/lib/int_sqrt.c b/lib/int_sqrt.c
[]
> @@ -36,3 +36,29 @@ unsigned long int_sqrt(unsigned long x)
>  	return y;
>  }
>  EXPORT_SYMBOL(int_sqrt);
> +
> +/**
> + * int_sqrt64 - strongly typed int_sqrt function
> + * @x: 64bit integer of which to calculate the sqrt
> + */
> +u64 int_sqrt64(u64 x)
> +{
> +	u64 b, m, y = 0;
> +
> +	if (x <= 1)
> +		return x;
> +
> +	m = 1ULL << (64 - 2);
> +	while (m != 0) {
> +		b = y + m;
> +		y >>= 1;
> +
> +		if (x >= b) {
> +			x -= b;
> +			y += m;
> +		}
> +		m >>= 2;
> +	}
> +	return y;
> +}
> +EXPORT_SYMBOL(int_sqrt64);

int_sqrt is now optimized with __fls

Because u64 is unsigned long on 64 bit arches, this
could probably be optimized for 64 bit distributions
with something like:

#if BITS_PER_LONG != 64
#define int_sqrt64 _int_sqrt64
u64 _int_sqrt64(u64 x);
#else
#define int_sqrt64(x) int_sqrt
#endif

...

#if BITS_PER_LONG != 64
u64 _int_sqrt64(u64 x)
{ etc.. }
#endif
