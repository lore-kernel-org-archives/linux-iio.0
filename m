Return-Path: <SRS0=Hyu5=EK=perches.com=joe@kernel.org>
Message-ID: <1516012575.3045.37.camel@perches.com>
Subject: Re: [PATCH v12 1/3] lib: Add strongly typed 64bit int_sqrt
From: Joe Perches <joe@perches.com>
To: Crt Mori <cmo@melexis.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Kees Cook
 <keescook@chromium.org>, Rusty Russell <rusty@rustcorp.com.au>, Ian Abbott
 <abbotti@mev.co.uk>, Larry Finger <Larry.Finger@lwfinger.net>, Niklas
 Soderlund <niklas.soderlund+renesas@ragnatech.se>, Thomas Gleixner
 <tglx@linutronix.de>,  Krzysztof Kozlowski <krzk@kernel.org>, Masahiro
 Yamada <yamada.masahiro@socionext.com>,  linux-kernel@vger.kernel.org,
 Linux Iio <linux-iio@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, David Laight <David.Laight@aculab.com>
Date: Mon, 15 Jan 2018 02:36:15 -0800
In-Reply-To: <CAKv63uvq5Eq9f9VNSufUmJCOsd4vebbSu2V0Jzbmgth3vbJ9Dw@mail.gmail.com>
References: <20180109151847.30258-1-cmo@melexis.com>
	 <1515525824.9619.103.camel@perches.com>
	 <CAKv63usChMeCNYJ6qshFcBCOLgEX9Q-mSv6miLG7YJkUKJ1gEA@mail.gmail.com>
	 <CAKv63uuDya8LU-WHtKiqnEJCtg855aYduhowu0dv5qBd1r284Q@mail.gmail.com>
	 <CAKv63uvq5Eq9f9VNSufUmJCOsd4vebbSu2V0Jzbmgth3vbJ9Dw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Wed, 2018-01-10 at 09:37 +0100, Crt Mori wrote:
> Shouldn't I rather make it
> 
>          if (x <= ULONG_MAX)
>                  return int_sqrt((unsigned long) x);

With this change: (I believe done in v13) and
as requested by Crt Mori in a private email:

Acked-by: Joe Perches <joe@perches.com>
