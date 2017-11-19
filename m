Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20171119103122.6b2e9af7@archlinux>
References: <20171113102955.5257-1-linus.walleij@linaro.org>
 <20171118155448.34031532@archlinux> <20171119103122.6b2e9af7@archlinux>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 19 Nov 2017 14:27:26 +0100
Message-ID: <CACRpkdbEvRh-Na6GmQrtdG+u-9YKEr+NJW=Naj_8UR_U3-dxXw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc/accel: Fix up module licenses
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: linux-iio@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Sun, Nov 19, 2017 at 11:31 AM, Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:
> On Sat, 18 Nov 2017 15:54:48 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
>
>> On Mon, 13 Nov 2017 11:29:55 +0100
>> Linus Walleij <linus.walleij@linaro.org> wrote:
>>
>> > The module license checker complains about these two so just fix
>> > it up. They are both GPLv2, both written by me or using code
>> > I extracted while refactoring from the GPLv2 drivers.
>> >
>> > Cc: Randy Dunlap <rdunlap@infradead.org>
>> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
>> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> Applied to the togreg branch of iio.git which will probably be be pushed
>> out as testing for the autobuilders to play with it.
> Actually - this doesn't pass basic x86_64 build testing...
> Needs to include module.h in the qcom driver.
>
> Done...

Ah dammit there is so much stuff that seems obvious in
hindsight.

Thanks for fixing it up.

Yours,
Linus Walleij
