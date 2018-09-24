Return-Path: <SRS0=4hsp=MG=linaro.org=linus.walleij@kernel.org>
MIME-Version: 1.0
References: <2785169.v6aIfS3K2k@z50> <20180923235336.22148-1-jmkrzyszt@gmail.com>
 <20180923235336.22148-2-jmkrzyszt@gmail.com>
In-Reply-To: <20180923235336.22148-2-jmkrzyszt@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 24 Sep 2018 10:11:23 +0200
Message-ID: <CACRpkdZ-pcy=pBKaLUPOZ5jf2bsp2X2u6QCLCWJ1H_XdNY9wtw@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpiolib: Fix missing updates of bitmap index
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
	Peter Korsgaard <peter.korsgaard@barco.com>, Peter Rosin <peda@axentia.se>,
	Ulf Hansson <ulf.hansson@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>,
	Dominik Brodowski <linux@dominikbrodowski.net>, Greg KH <gregkh@linuxfoundation.org>, kishon@ti.com,
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>, Lukas Wunner <lukas@wunner.de>,
	Rojhalat Ibrahim <imr@rtschenk.de>, Russell King <rmk+kernel@armlinux.org.uk>,
	ext Tony Lindgren <tony@atomide.com>, Yegor Yefremov <yegorslists@googlemail.com>,
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-mmc <linux-mmc@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-serial@vger.kernel.org,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Mon, Sep 24, 2018 at 1:52 AM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> In new code introduced by commit b17566a6b08b ("gpiolib: Implement fast
> processing path in get/set array"), bitmap index is not updated with
> next found zero bit position as it should while skipping over pins
> already processed via fast bitmap path, possibly resulting in an
> infinite loop.  Fix it.
>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Patch applied!

Thanks for working on getting this into shape!

Yours,
Linus Walleij
