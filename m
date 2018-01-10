Return-Path: <SRS0=IufG=EF=melexis.com=cmo@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1515525824.9619.103.camel@perches.com>
References: <20180109151847.30258-1-cmo@melexis.com> <1515525824.9619.103.camel@perches.com>
From: Crt Mori <cmo@melexis.com>
Date: Wed, 10 Jan 2018 09:15:55 +0100
Message-ID: <CAKv63usChMeCNYJ6qshFcBCOLgEX9Q-mSv6miLG7YJkUKJ1gEA@mail.gmail.com>
Subject: Re: [PATCH v12 1/3] lib: Add strongly typed 64bit int_sqrt
To: Joe Perches <joe@perches.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>,
	Rusty Russell <rusty@rustcorp.com.au>, Ian Abbott <abbotti@mev.co.uk>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>,
	Thomas Gleixner <tglx@linutronix.de>, Krzysztof Kozlowski <krzk@kernel.org>,
	Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org,
	Linux Iio <linux-iio@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On 9 January 2018 at 20:23, Joe Perches <joe@perches.com> wrote:
> On Tue, 2018-01-09 at 16:18 +0100, Crt Mori wrote:
>> There is no option to perform 64bit integer sqrt on 32bit platform.
>> Added stronger typed int_sqrt64 enables the 64bit calculations to
>> be performed on 32bit platforms. Using same algorithm as int_sqrt()
>> with strong typing provides enough precision also on 32bit platforms,
>> but it sacrifices some performance.
> []
>> diff --git a/lib/int_sqrt.c b/lib/int_sqrt.c
> []
>> @@ -36,3 +37,34 @@ unsigned long int_sqrt(unsigned long x)
>>       return y;
>>  }
>>  EXPORT_SYMBOL(int_sqrt);
>> +
>> +#if BITS_PER_LONG < 64
>> +/**
>> + * int_sqrt64 - strongly typed int_sqrt function when minimum 64 bit input
>> + * is expected.
>> + * @x: 64bit integer of which to calculate the sqrt
>> + */
>> +u32 int_sqrt64(u64 x)
>> +{
>> +     u64 b, m;
>> +     u32 y = 0;
>> +
>> +     if (x <= 1)
>> +             return x;
>
> I think this should instead be:
>
>         if (x <= INT_MAX)
>                 return int_sqrt((int)x);
>
> to reduce the loop cost below when the
> value is small enough.
>

In existing int_sqrt its only 1 and I assume that is more to protect
from loop execution with 0 or 1. Since there is no difference (except
fls64) with int_sqrt I assume there is no need to call it to avoid
loop?

>> +
>> +     m = 1ULL << (fls64(x) & ~1ULL);
>> +     while (m != 0) {
>> +             b = y + m;
>> +             y >>= 1;
>> +
>> +             if (x >= b) {
>> +                     x -= b;
>> +                     y += m;
>> +             }
>> +             m >>= 2;
>> +     }
>> +
>> +     return y;
>> +}
>> +EXPORT_SYMBOL(int_sqrt64);
>> +#endif
