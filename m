Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out4.electric.net ([192.162.216.181]:63855 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbdLUOr4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Dec 2017 09:47:56 -0500
From: David Laight <David.Laight@ACULAB.COM>
To: 'Peter Zijlstra' <peterz@infradead.org>
CC: 'Crt Mori' <cmo@melexis.com>, Jonathan Cameron <jic23@kernel.org>,
        "Ingo Molnar" <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kees Cook" <keescook@chromium.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        "Ian Abbott" <abbotti@mev.co.uk>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        "Niklas Soderlund" <niklas.soderlund+renesas@ragnatech.se>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Subject: RE: [PATCH v10 1/3] lib: Add strongly typed 64bit int_sqrt
Date: Thu, 21 Dec 2017 14:48:14 +0000
Message-ID: <79658484b99a4f65bb3a1937b3d156ad@AcuMS.aculab.com>
References: <20171220142001.18161-1-cmo@melexis.com>
 <1c1d0ffa8ee140bf9adbc78f1559b1e8@AcuMS.aculab.com>
 <20171220160001.manjff26gfbjccsw@hirez.programming.kicks-ass.net>
 <CAKv63uuL9+xzF7KruhYwSY68-M0=aJSvJOr5Y0vVBiX8ebqfeg@mail.gmail.com>
 <c3462afd27d14c8684ee33ef6623a31a@AcuMS.aculab.com>
 <CAKv63utKNW2--ZnkoJ0z++68764cX_S9xS9Gst_vj7eDsFAZrg@mail.gmail.com>
 <95b9b2b52554410a85a9f10c7f5e8b13@AcuMS.aculab.com>
 <CAKv63usT8GU-51AmMLJb3hD3CHxf1M5KTQvYhK+0UVMT13Nbag@mail.gmail.com>
 <b743750a1bd64ed2bf800cec9da9afff@AcuMS.aculab.com>
 <20171221141130.cdng2mysnjj6j4i6@hirez.programming.kicks-ass.net>
In-Reply-To: <20171221141130.cdng2mysnjj6j4i6@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Peter Zijlstra
> Sent: 21 December 2017 14:12
...
> > > This part above looks like FLS
> > It also does the rest of the required shifts.
> 
> Still, fls() + shift is way faster on hardware that has an fls
> instruction.
> 
> Writing out that binary search doesn't make sense.

If the hardware doesn't have an appropriate fls instruction
the soft fls()will be worse.

If you used fls() you'd still need quite a bit of code
to generate the correct shift and loop count adjustment.
Given the cost of the loop iterations the 3 tests are noise.
The open coded version is obviously correct...

I didn't add the 4th one because the code always does 2 iterations.

If you were really worried about performance there are faster
algorithms (even doing 2 or 4 bits a time is faster).

	David

