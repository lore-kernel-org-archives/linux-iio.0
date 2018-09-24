Return-Path: <SRS0=4hsp=MG=linaro.org=linus.walleij@kernel.org>
MIME-Version: 1.0
References: <2785169.v6aIfS3K2k@z50> <20180923235336.22148-1-jmkrzyszt@gmail.com>
 <20180923235336.22148-3-jmkrzyszt@gmail.com>
In-Reply-To: <20180923235336.22148-3-jmkrzyszt@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 24 Sep 2018 10:13:02 +0200
Message-ID: <CACRpkdbF=Yda3Wqii6dkDjqPzuh43Vb4nvPVrxLet3MYo0qUrw@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpiolib: Fix array members of same chip processed separately
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

> New code introduced by commit bf9346f5d47b ("gpiolib: Identify arrays
> matching GPIO hardware") forcibly tries to find an array member which
> has its array index number equal to its hardware pin number and set
> up an array info for possible fast bitmap processing of all arrray
> pins belonging to that chip which also satisfy that numbering rule.
>
> Depending on array content, it may happen that consecutive array
> members which belong to the same chip but don't have array indexes
> equal to their pin hardware numbers will be split into groups, some of
> them processed together via the fast bitmap path, and rest of them
> separetely.  However, applications may expect all those pins being
> processed together with a single call to .set_multiple() chip callback,
> like that was done before the change.
>
> Limit applicability of fast bitmap processing path to cases where all
> pins of consecutive array members starting from 0 which belong to the
> same chip have their hardware numbers equal to their corresponding
> array indexes.  That should still speed up processing of applications
> using whole GPIO banks as I/O ports, while not breaking simultaneous
> manipulation of consecutive pins of the same chip which don't follow
> the equal numbering rule.
>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Patch applied!

Yours,
Linus Walleij
