Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50754 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753703AbcL3Ld1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Dec 2016 06:33:27 -0500
Subject: Re: [PATCH 1/2] iio: st_pressure: Fix data sign
To: Linus Walleij <linus.walleij@linaro.org>,
        Marcin Niestroj <m.niestroj@grinn-global.com>
References: <20161212165843.32322-1-m.niestroj@grinn-global.com>
 <CACRpkdYa5+SzgbJTqWiffnu-dwXWmDnBAv6e_G9piJ=8f4GGqg@mail.gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <2122e227-20f8-df7a-c166-c135053c95cb@kernel.org>
Date: Fri, 30 Dec 2016 11:33:25 +0000
MIME-Version: 1.0
In-Reply-To: <CACRpkdYa5+SzgbJTqWiffnu-dwXWmDnBAv6e_G9piJ=8f4GGqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/12/16 08:51, Linus Walleij wrote:
> On Mon, Dec 12, 2016 at 5:58 PM, Marcin Niestroj
> <m.niestroj@grinn-global.com> wrote:
> 
>> Datasheet of each device (lps331ap, lps25h, lps001wp, lps22hb) says that
>> the pressure and temperature data is a 2's complement.
>>
>> Fixes: 217494e5b780 ("iio:pressure: Add STMicroelectronics pressures driver")
>> Fixes: 2f5effcbd097 ("iio: pressure-core: st: Expand and rename LPS331AP's channel descriptor")
>> Fixes: 7885a8ce6800 ("iio: pressure: st: Add support for new LPS001WP pressure sensor")
>> Fixes: e039e2f5b4da ("iio:st_pressure:initial lps22hb sensor support")
>> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
> 
> Looks correct. I guess noone thought of testing negative pressures :/
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
I've applied to the togreg branch of iio.git - initially pushed out as testing
because the very nature of a fix for multiple previous patches will make it tricky
to apply to older kernels.

If you want to do backports after it has gone into mainline, they'll be most
welcome.

Thanks,

Jonathan
> 
> Yours,
> Linus Walleij
> 

