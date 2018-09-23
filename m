Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41956 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbeIXFwC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Sep 2018 01:52:02 -0400
From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Rojhalat Ibrahim <imr@rtschenk.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
Subject: [PATCH 0/2] gpiolib: Fix issues introduced by fast bitmap processing path
Date: Mon, 24 Sep 2018 01:53:34 +0200
Message-Id: <20180923235336.22148-1-jmkrzyszt@gmail.com>
In-Reply-To: <2785169.v6aIfS3K2k@z50>
References: <2785169.v6aIfS3K2k@z50>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


While investigating possible reasons of GPIO fast bitmap processing
related boot hang on Samsung Snow Chromebook, reported by Marek
Szyprowski (thanks!), I've discovered one coding bug, addressed by
PATCH 1/2 of this series, and one potential regression introduced at
design level of the solution, hopefully fixed by PATCH 2/2.  See
commit messages for details.

Janusz Krzysztofik (2):
      gpiolib: Fix missing updates of bitmap index
      gpiolib: Fix array members of same chip processed separately

The fixes should resolve the boot hang observed by Marek, however the
second change excludes that particular case from fast bitmap processing
and restores the old behaviour.  Hence, it is possible still another
issue which have had an influence on that boot hang exists in the code.
In order to fully verify the fix, it would have to be tested on a
platform where an array of GPIO descriptors is used which starts from
at least two consecutive pins of one GPIO chip in hardware order,
starting ftom 0, followed by one or more pins belonging to other
chip(s).

In order to verify if separate calls to .set() chip callback for each
pin instead of one call to .set_multiple() is actually the reason of
boot hang on Samsung Snow Chromebook, the affected driver -
drivers/mmc/core/pwrseq_simple.c - would have to be temporarily
modified for testing purposes so it calls gpiod_set_value() for each
pin instead of gpiod_set_array_value() for all of them.  If that would
also result in boot hang, we could be sure the issue was really the
one addressed by the second fix.  Marek, could you please try to
perform such test?

Thanks,
Janusz


diffstat:
 Documentation/driver-api/gpio/board.rst |   19 +++++++++----
 drivers/gpio/gpiolib.c                  |   46 +++++++++++++++++++++-----------
 2 files changed, 45 insertions(+), 20 deletions(-)
