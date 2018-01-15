Return-Path: <SRS0=7P4u=EK=melexis.com=cmo@kernel.org>
MIME-Version: 1.0
In-Reply-To: <7a331e1dbd634af7974b157bddf1a9c5@AcuMS.aculab.com>
References: <20171220142001.18161-1-cmo@melexis.com> <1c1d0ffa8ee140bf9adbc78f1559b1e8@AcuMS.aculab.com>
 <20171220160001.manjff26gfbjccsw@hirez.programming.kicks-ass.net>
 <CAKv63uuL9+xzF7KruhYwSY68-M0=aJSvJOr5Y0vVBiX8ebqfeg@mail.gmail.com>
 <c3462afd27d14c8684ee33ef6623a31a@AcuMS.aculab.com> <CAKv63utKNW2--ZnkoJ0z++68764cX_S9xS9Gst_vj7eDsFAZrg@mail.gmail.com>
 <95b9b2b52554410a85a9f10c7f5e8b13@AcuMS.aculab.com> <CAKv63usT8GU-51AmMLJb3hD3CHxf1M5KTQvYhK+0UVMT13Nbag@mail.gmail.com>
 <b743750a1bd64ed2bf800cec9da9afff@AcuMS.aculab.com> <20171221141130.cdng2mysnjj6j4i6@hirez.programming.kicks-ass.net>
 <79658484b99a4f65bb3a1937b3d156ad@AcuMS.aculab.com> <CAKv63uuLKNZ5yJLp2LahDqE6NSi3UMRGaMsBrj2e03joU_cC1w@mail.gmail.com>
 <CAKv63usmDy7LdF6Lbc_CnuSCzYWtrhtBHgasvTYbT8wL2uuC8A@mail.gmail.com> <7a331e1dbd634af7974b157bddf1a9c5@AcuMS.aculab.com>
From: Crt Mori <cmo@melexis.com>
Date: Mon, 15 Jan 2018 09:17:40 +0100
Message-ID: <CAKv63uvTSLM8Q_u-wZJHceM7FtwNLC40oKDo1aBdWHxjeU-zbA@mail.gmail.com>
Subject: Re: [PATCH v10 1/3] lib: Add strongly typed 64bit int_sqrt
To: David Laight <David.Laight@aculab.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Jonathan Cameron <jic23@kernel.org>,
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

On 12 January 2018 at 10:41, David Laight <David.Laight@aculab.com> wrote:
> From: Crt Mori [mailto:cmo@melexis.com]
>> Sent: 09 January 2018 15:18
>>
>> It has been some time now since this moved. I have decided not to use
>> David's implementation because I want to maintain also range above
>> 2^62
>
> The last version I did supported the full range.

Nothing changed below that comment, so I was assuming it is not
supported (or did I miss a mail?).

Also fls discussion had opposite opinions or it just seems inconclusive to me?

>
>         David
>

So you all agree David Laight version is much better and should be
used instead of currently proposed version?
