Return-Path: <SRS0=+n14=J5=gmail.com=arndbergmann@kernel.org>
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <CACRpkdY5oMG0WknSEnG1khTTm_UKwWwdAbAthA54geGhqgyXpQ@mail.gmail.com>
References: <20180710144737.1136856-1-arnd@arndb.de> <CACRpkdY5oMG0WknSEnG1khTTm_UKwWwdAbAthA54geGhqgyXpQ@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 13 Jul 2018 11:16:16 +0200
Message-ID: <CAK8P3a1M78gtJm95eMjrk+N4KdiY3T=dqyksYdNJotd90qV60A@mail.gmail.com>
Subject: Re: [PATCH] [v2] Documentation: document ktime_get_*() APIs
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Gregor Boirie <gregor.boirie@parrot.com>, Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Randy Dunlap <rdunlap@infradead.org>, Dave Chinner <david@fromorbit.com>,
	John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jul 13, 2018 at 9:24 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Jul 10, 2018 at 4:48 PM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> Cc: Dave Chinner <david@fromorbit.com>
>> Cc: John Stultz <john.stultz@linaro.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Stephen Boyd <sboyd@kernel.org>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Tested-by: Randy Dunlap <rdunlap@infradead.org>
>> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>> v2: minor changes suggested by Randy
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks!

> This brings into question commit bc2b7dab629a5
> "iio:core: timestamping clock selection support"
> that has bothered me for some time. Now that is ABI, but
> we might be able to do some recommendations based on the
> time base and have a sensible default moving forward.
>
> As I want to make that clock base parsing similar for GPIO
> I first thought it was a good idea to support the same clocks,
> but now it seems like a bad idea.
>
> IIRC you told me to simply hammer down the clock that
> makes the most sense.

Right, my general recommendation would be to return the
result of ktime_get_ns() in a __u64, since this does not suffer
from the settimeofday or leap second issues that clock_realtime
has, using the coarse clock to save 100 cycles per call probably
won't help.

       Arnd
