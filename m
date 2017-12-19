Return-Path: <SRS0=kdEO=DP=infradead.org=peterz@kernel.org>
Date: Tue, 19 Dec 2017 14:25:22 +0100
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
	linux-kernel@vger.kernel.org, Linux Iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v6 1/3] lib: Add strongly typed 64bit int_sqrt
Message-ID: <20171219132522.etacjnltyrc3xjks@hirez.programming.kicks-ass.net>
References: <20171218150544.8000-1-cmo@melexis.com>
 <20171218164449.dtdgk2bvnl4nbjcm@hirez.programming.kicks-ass.net>
 <CAKv63utUMv4H2Ah2sdWNzPrvY9vqHnyco7RkF7DDLY9CgUKGcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKv63utUMv4H2Ah2sdWNzPrvY9vqHnyco7RkF7DDLY9CgUKGcg@mail.gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Dec 19, 2017 at 10:31:18AM +0100, Crt Mori wrote:
> IIO kernel does not have the recent version in, so thanks for heads

IIO?

> up. It does not change much for my function.

The comment says:

 * Computes: floor(sqrt(x))

floor(sqrt(2^64-1)) == 2^32-1
