Return-Path: <SRS0=qENR=X4=linaro.org=linus.walleij@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161212165843.32322-1-m.niestroj@grinn-global.com>
References: <20161212165843.32322-1-m.niestroj@grinn-global.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 13 Dec 2016 09:51:15 +0100
Message-ID: <CACRpkdYa5+SzgbJTqWiffnu-dwXWmDnBAv6e_G9piJ=8f4GGqg@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: st_pressure: Fix data sign
To: Marcin Niestroj <m.niestroj@grinn-global.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Dec 12, 2016 at 5:58 PM, Marcin Niestroj
<m.niestroj@grinn-global.com> wrote:

> Datasheet of each device (lps331ap, lps25h, lps001wp, lps22hb) says that
> the pressure and temperature data is a 2's complement.
>
> Fixes: 217494e5b780 ("iio:pressure: Add STMicroelectronics pressures driver")
> Fixes: 2f5effcbd097 ("iio: pressure-core: st: Expand and rename LPS331AP's channel descriptor")
> Fixes: 7885a8ce6800 ("iio: pressure: st: Add support for new LPS001WP pressure sensor")
> Fixes: e039e2f5b4da ("iio:st_pressure:initial lps22hb sensor support")
> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>

Looks correct. I guess noone thought of testing negative pressures :/

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
