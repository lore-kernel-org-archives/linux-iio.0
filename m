Return-Path: <SRS0=G/1T=DQ=melexis.com=cmo@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171220160001.manjff26gfbjccsw@hirez.programming.kicks-ass.net>
References: <20171220142001.18161-1-cmo@melexis.com> <1c1d0ffa8ee140bf9adbc78f1559b1e8@AcuMS.aculab.com>
 <20171220160001.manjff26gfbjccsw@hirez.programming.kicks-ass.net>
From: Crt Mori <cmo@melexis.com>
Date: Wed, 20 Dec 2017 17:17:29 +0100
Message-ID: <CAKv63uuL9+xzF7KruhYwSY68-M0=aJSvJOr5Y0vVBiX8ebqfeg@mail.gmail.com>
Subject: Re: [PATCH v10 1/3] lib: Add strongly typed 64bit int_sqrt
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Laight <David.Laight@aculab.com>, Jonathan Cameron <jic23@kernel.org>,
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

On 20 December 2017 at 17:00, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Dec 20, 2017 at 02:39:26PM +0000, David Laight wrote:
>
>> With minor changes it ought to be possible to remove most of the
>> 64bit arithmetic and shifts.
>>
>> If you care about performance then using 32 bit maths will be much faster.
>
> Some, u64 add/sub/shift isn't exactly expensive, but yes, I also
> indicated that improvement is possible. At the very least y can be made
> a u32 I suppose.

OK, is there any more easy optimizations you see?
