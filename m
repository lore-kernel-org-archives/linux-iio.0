Return-Path: <SRS0=aVgU=DP=melexis.com=cmo@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171218164449.dtdgk2bvnl4nbjcm@hirez.programming.kicks-ass.net>
References: <20171218150544.8000-1-cmo@melexis.com> <20171218164449.dtdgk2bvnl4nbjcm@hirez.programming.kicks-ass.net>
From: Crt Mori <cmo@melexis.com>
Date: Tue, 19 Dec 2017 10:31:18 +0100
Message-ID: <CAKv63utUMv4H2Ah2sdWNzPrvY9vqHnyco7RkF7DDLY9CgUKGcg@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] lib: Add strongly typed 64bit int_sqrt
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>,
	Rusty Russell <rusty@rustcorp.com.au>, Ian Abbott <abbotti@mev.co.uk>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>,
	Thomas Gleixner <tglx@linutronix.de>, Krzysztof Kozlowski <krzk@kernel.org>,
	Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org,
	Linux Iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On 18 December 2017 at 17:44, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Dec 18, 2017 at 04:05:44PM +0100, Crt Mori wrote:
>> There is no option to perform 64bit integer sqrt on 32bit platform.
>> Added stronger typed int_sqrt64 enables the 64bit calculations to
>> be performed on 32bit platforms. Although int_sqrt() is a rough
>> approximation, the same algorithm is used in int_sqrt64() as good
>> enough on 32bit platform.
>
> You clearly haven't read a recent version of the file you're patching.
> Please take a moment to do so now.
>

IIO kernel does not have the recent version in, so thanks for heads
up. It does not change much for my function.

>> +/**
>> + * int_sqrt64 - strongly typed int_sqrt function
>> + * @x: 64bit integer of which to calculate the sqrt
>> + */
>> +u64 int_sqrt64(u64 x)
>
> Please explain how the result of sqrt(u64) can be larger than u32.
>

My hand calculator tells me it could be.

ffffffff=C3=97ffffffff =3D FFFFFFFE00000001 which still has some margin whi=
ch
will end up above the 32 bit number. Further more the __fls
optimization automatically casts the inputs to unsigned long (32 bit
on 32 bit machines), so that also makes it out of option.

> Also, I expect that this fact could be exploited to optimize this for
> 32bit archs if one were so inclined.
>
>> +{
>> +     u64 b, m, y =3D 0;
>> +
>> +     if (x <=3D 1)
>> +             return x;
>> +
>> +     m =3D 1ULL << (64 - 2);
>> +     while (m !=3D 0) {
>> +             b =3D y + m;
>> +             y >>=3D 1;
>> +
>> +             if (x >=3D b) {
>> +                     x -=3D b;
>> +                     y +=3D m;
>> +             }
>> +             m >>=3D 2;
>> +     }
>> +     return y;
>> +}
>
> so yeah, no, please try again after reading the current file.
