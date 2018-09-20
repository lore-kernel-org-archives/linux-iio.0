Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:38256 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387424AbeITXwt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Sep 2018 19:52:49 -0400
Date: Thu, 20 Sep 2018 21:05:29 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-doc@vger.kernel.org, linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Peter Rosin <peda@axentia.se>, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devel@driverdev.osuosl.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Lukas Wunner <lukas@wunner.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>, linux-gpio@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        "'Linux Samsung SOC'" <linux-samsung-soc@vger.kernel.org>,
        Rojhalat Ibrahim <imr@rtschenk.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v7 4/4] gpiolib: Implement fast processing path in
 get/set array
Message-ID: <20180920180529.hjc54yoqmvnpvvt7@mwanda>
References: <20180831225616.29221-1-jmkrzyszt@gmail.com>
 <CGME20180920101151eucas1p221f5a1715b8556bb9d99bf08fe09ce6f@eucas1p2.samsung.com>
 <20180920101151eucas1p221f5a1715b8556bb9d99bf08fe09ce6f~WE-_cEf4l0754207542eucas1p27@eucas1p2.samsung.com>
 <9860023.SlBYqtbjDV@z50>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9860023.SlBYqtbjDV@z50>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Sep 20, 2018 at 05:48:22PM +0200, Janusz Krzysztofik wrote:
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index a53d17745d21..5bc3447949c9 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2880,7 +2880,7 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
>  			__set_bit(hwgpio, mask);
>  
>  			if (array_info)
> -				find_next_zero_bit(array_info->get_mask,
> +				i = find_next_zero_bit(array_info->get_mask,
>  						   array_size, i);

We could mark find_next_zero_bit() and friends as a __must_check
functions so we avoid this bug in the future.  I have a more complicated
idea how to detect these bugs in a generic way using Smatch but it will
take longer to implement.

regards,
dan carpenter
