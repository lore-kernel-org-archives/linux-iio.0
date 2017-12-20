Return-Path: <SRS0=G/1T=DQ=melexis.com=cmo@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1513700059.1234.42.camel@perches.com>
References: <20171219155908.29528-1-cmo@melexis.com> <1513699793.1234.41.camel@perches.com>
 <20171219161245.cbjmod7ak5scio7d@hirez.programming.kicks-ass.net> <1513700059.1234.42.camel@perches.com>
From: Crt Mori <cmo@melexis.com>
Date: Wed, 20 Dec 2017 10:35:11 +0100
Message-ID: <CAKv63us0V8i07FUXHZExuV3h-uV-btaTb5uCkDaCNiPX7GFfMQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] lib: Add strongly typed 64bit int_sqrt
To: Joe Perches <joe@perches.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Jonathan Cameron <jic23@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>, Rusty Russell <rusty@rustcorp.com.au>,
	Ian Abbott <abbotti@mev.co.uk>, Larry Finger <Larry.Finger@lwfinger.net>,
	Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>,
	Thomas Gleixner <tglx@linutronix.de>, Krzysztof Kozlowski <krzk@kernel.org>,
	Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org,
	Linux Iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

Thanks for suggestions and comments. Respinned v9 with them.

On 19 December 2017 at 17:14, Joe Perches <joe@perches.com> wrote:
> On Tue, 2017-12-19 at 17:12 +0100, Peter Zijlstra wrote:
>> On Tue, Dec 19, 2017 at 08:09:53AM -0800, Joe Perches wrote:
>> >
>> > I suspect you need to define this as:
>> >
>> > #define int_sqrt64(x) ((u32)int_sqrt(x))
>>
>> What's wrong with using C ?
>
> Duh.  Nothing at all.
>
>> static inline u32 int_sqrt64(u64 x)
>> {
>>       return int_sqrt(x);
>> }
