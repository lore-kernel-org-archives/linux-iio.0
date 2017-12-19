Return-Path: <SRS0=kdEO=DP=infradead.org=peterz@kernel.org>
Date: Tue, 19 Dec 2017 17:12:45 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Joe Perches <joe@perches.com>
Cc: Crt Mori <cmo@melexis.com>, Jonathan Cameron <jic23@kernel.org>,
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
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v7 1/3] lib: Add strongly typed 64bit int_sqrt
Message-ID: <20171219161245.cbjmod7ak5scio7d@hirez.programming.kicks-ass.net>
References: <20171219155908.29528-1-cmo@melexis.com>
 <1513699793.1234.41.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1513699793.1234.41.camel@perches.com>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Dec 19, 2017 at 08:09:53AM -0800, Joe Perches wrote:
> 
> I suspect you need to define this as:
> 
> #define int_sqrt64(x) ((u32)int_sqrt(x))

What's wrong with using C ?

static inline u32 int_sqrt64(u64 x)
{
	return int_sqrt(x);
}
