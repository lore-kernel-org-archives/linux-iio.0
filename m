Return-Path: <SRS0=C0tf=DO=infradead.org=peterz@kernel.org>
Date: Mon, 18 Dec 2017 17:44:49 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Crt Mori <cmo@melexis.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Ian Abbott <abbotti@mev.co.uk>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v6 1/3] lib: Add strongly typed 64bit int_sqrt
Message-ID: <20171218164449.dtdgk2bvnl4nbjcm@hirez.programming.kicks-ass.net>
References: <20171218150544.8000-1-cmo@melexis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171218150544.8000-1-cmo@melexis.com>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Dec 18, 2017 at 04:05:44PM +0100, Crt Mori wrote:
> There is no option to perform 64bit integer sqrt on 32bit platform.
> Added stronger typed int_sqrt64 enables the 64bit calculations to
> be performed on 32bit platforms. Although int_sqrt() is a rough
> approximation, the same algorithm is used in int_sqrt64() as good
> enough on 32bit platform.

You clearly haven't read a recent version of the file you're patching.
Please take a moment to do so now.

> +/**
> + * int_sqrt64 - strongly typed int_sqrt function
> + * @x: 64bit integer of which to calculate the sqrt
> + */
> +u64 int_sqrt64(u64 x)

Please explain how the result of sqrt(u64) can be larger than u32.

Also, I expect that this fact could be exploited to optimize this for
32bit archs if one were so inclined.

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

so yeah, no, please try again after reading the current file.
