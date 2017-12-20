Return-Path: <SRS0=G/1T=DQ=melexis.com=cmo@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1513763787.1234.102.camel@perches.com>
References: <20171220093315.25311-1-cmo@melexis.com> <1513763787.1234.102.camel@perches.com>
From: Crt Mori <cmo@melexis.com>
Date: Wed, 20 Dec 2017 15:19:38 +0100
Message-ID: <CAKv63utBEnAnRy4nhuWjTpMtauEM3B2CAm6vfC9oP1mM875CNw@mail.gmail.com>
Subject: Re: [PATCH v9 1/3] lib: Add strongly typed 64bit int_sqrt
To: Joe Perches <joe@perches.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>,
	Rusty Russell <rusty@rustcorp.com.au>, Ian Abbott <abbotti@mev.co.uk>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>,
	Thomas Gleixner <tglx@linutronix.de>, Krzysztof Kozlowski <krzk@kernel.org>,
	Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org,
	Linux Iio <linux-iio@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On 20 December 2017 at 10:56, Joe Perches <joe@perches.com> wrote:
> On Wed, 2017-12-20 at 10:33 +0100, Crt Mori wrote:
>> There is no option to perform 64bit integer sqrt on 32bit platform.
>> Added stronger typed int_sqrt64 enables the 64bit calculations to
>> be performed on 32bit platforms. Although int_sqrt() is a rough
>> approximation, the same algorithm is used in int_sqrt64() as good
>> enough on 32bit platform.
> []
>> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> []
>> @@ -459,6 +459,7 @@ extern int kernel_text_address(unsigned long addr);
>>  extern int func_ptr_is_kernel_text(void *ptr);
>>
>>  unsigned long int_sqrt(unsigned long);
>> +u32 int_sqrt64(u64 x);
>
> #ifdef BITS_PER_LONG == 64
> static inline u32 int_sqrt64(u64 x)
> {
>         re
> turn (u32)int_sqrt(x);
> }
> #else
> u32 int_sqrt64(u64 x);
> #endif
>
> []
>

OK, fixing it in v10.

>> +#if BITS_PER_LONG < 64
>> +/**
>> + * int_sqrt64 - strongly typed int_sqrt function when minimum 64 bit input
>> + * is expected.
>> + * @x: 64bit integer of which to calculate the sqrt
>> + */
>> +u32 int_sqrt64(u64 x)
>> +{
>> +     u64 b, m, y = 0;
>> +
>> +     if (x <= 1)
>> +             return x;
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
>> +#else
>> +u32 int_sqrt64(u64 x)
>> +{
>> +     return int_sqrt(x);
>> +}
>> +EXPORT_SYMBOL(int_sqrt64);
>> +#endif
>
> This doesn't need to be EXPORT_SYMBOL for the
> BITS_PER_LONG == 64 case
>
