Return-Path: <SRS0=Atuo=MD=samsung.com=m.szyprowski@kernel.org>
Subject: Re: [PATCH v7 4/4] gpiolib: Implement fast processing path in
 get/set array
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet
	<corbet@lwn.net>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
	Peter Korsgaard <peter.korsgaard@barco.com>, Peter Rosin <peda@axentia.se>,
	Ulf Hansson <ulf.hansson@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Florian
	Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>,
	Dominik Brodowski <linux@dominikbrodowski.net>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Kishon Vijay Abraham I <kishon@ti.com>,
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
	<Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut
	Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jiri
	Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>, Geert Uytterhoeven
	<geert@linux-m68k.org>, linux-doc@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org,
	netdev@vger.kernel.org, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-serial@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastien
	Bourdelin <sebastien.bourdelin@savoirfairelinux.com>, Lukas Wunner
	<lukas@wunner.de>, Rojhalat Ibrahim <imr@rtschenk.de>, Russell King
	<rmk+kernel@armlinux.org.uk>, Tony Lindgren <tony@atomide.com>, Yegor
	Yefremov <yegorslists@googlemail.com>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?=
	<u.kleine-koenig@pengutronix.de>, 'Linux Samsung SOC'
	<linux-samsung-soc@vger.kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Date: Fri, 21 Sep 2018 10:18:03 +0200
MIME-Version: 1.0
In-Reply-To: <15226900.TQMLYV7PZ0@z50>
Message-Id: <20180921081806eucas1p182d4646e8510b5f0356214af7edba11e~WXF8Ptw4M0970709707eucas1p1p@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
References: <20180831225616.29221-1-jmkrzyszt@gmail.com>
	<20180920101151eucas1p221f5a1715b8556bb9d99bf08fe09ce6f~WE-_cEf4l0754207542eucas1p27@eucas1p2.samsung.com>
	<9860023.SlBYqtbjDV@z50>
	<CGME20180920161947epcas3p491e6c136fe05d9672c81b7b4b8328f64@epcas3p4.samsung.com>
	<15226900.TQMLYV7PZ0@z50>
List-ID: <linux-iio@vger.kernel.org>

Hi Janusz,

On 2018-09-20 18:21, Janusz Krzysztofik wrote:
> On Thursday, September 20, 2018 5:48:22 PM CEST Janusz Krzysztofik wrote:
>> On Thursday, September 20, 2018 12:11:48 PM CEST Marek Szyprowski wrote:
>>> On 2018-09-02 14:01, Janusz Krzysztofik wrote:
>>>> Certain GPIO descriptor arrays returned by gpio_get_array() may contain
>>>> information on direct mapping of array members to pins of a single GPIO
>>>> chip in hardware order.  In such cases, bitmaps of values can be passed
>>>> directly from/to the chip's .get/set_multiple() callbacks without
>>>> wasting time on iterations.
>>>>
>>>> Add respective code to gpiod_get/set_array_bitmap_complex() functions.
>>>> Pins not applicable for fast path are processed as before, skipping
>>>> over the 'fast' ones.
>>>>
>>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>>> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
>>> I've just noticed that this patch landed in today's linux-next. Sadly it
>>> breaks booting of Exynos5250-based Samsung Snow Chromebook (ARM 32bit,
>>> device-tree source arch/arm/boot/dts/exynos5250-snow.dts).
>>>
>>> Booting hangs after detecting MMC cards. Reverting this patch fixes the
>>> boot. I will try later to add some debugs and investigate it further what
>>> really happens when booting hangs.
>> Hi Marek,
>>
>> Thanks for reporting. Could you please try the following fix?
> Hi again,
>
> I realized the patch was not correct, j, not i, should be updated in second
> hunk. Please try the following one.
>
> Thanks,
> Janusz
>
> >From a919c504850f6cb40e8e81267a3a37537f7c4fd4 Mon Sep 17 00:00:00 2001
> From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> Date: Thu, 20 Sep 2018 17:37:21 +0200
> Subject: [PATCH] gpiolib: Fix bitmap index not updated
> While skipping fast path bits, bitmap index is not updated with next
> found zero bit position. Fix it.
>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

This one also doesn't help. A quick compare of logs with this version and
a working system shows, that with your patch (and fix) there are no calls to
gpx0-2 pin (which are a part of mmc pwrseq), what causes mmc failure. If
you need any more information (what kind of logs will help?), let me know.

> ---
>   drivers/gpio/gpiolib.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index a53d17745d21..369bdd358fcc 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2880,7 +2880,7 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
>   			__set_bit(hwgpio, mask);
>   
>   			if (array_info)
> -				find_next_zero_bit(array_info->get_mask,
> +				i = find_next_zero_bit(array_info->get_mask,
>   						   array_size, i);
>   			else
>   				i++;
> @@ -2905,7 +2905,8 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
>   			trace_gpio_value(desc_to_gpio(desc), 1, value);
>   
>   			if (array_info)
> -				find_next_zero_bit(array_info->get_mask, i, j);
> +				j = find_next_zero_bit(array_info->get_mask, i,
> +						       j);
>   			else
>   				j++;
>   		}
> @@ -3192,7 +3193,7 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
>   			}
>   
>   			if (array_info)
> -				find_next_zero_bit(array_info->set_mask,
> +				i = find_next_zero_bit(array_info->set_mask,
>   						   array_size, i);
>   			else
>   				i++;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
