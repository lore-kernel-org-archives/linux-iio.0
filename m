Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ua1-f67.google.com ([209.85.222.67]:39715 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbeICSmK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Sep 2018 14:42:10 -0400
MIME-Version: 1.0
References: <20180831225616.29221-1-jmkrzyszt@gmail.com> <20180902120144.6855-1-jmkrzyszt@gmail.com>
 <20180902120144.6855-4-jmkrzyszt@gmail.com>
In-Reply-To: <20180902120144.6855-4-jmkrzyszt@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 3 Sep 2018 16:21:33 +0200
Message-ID: <CAMuHMdV66N_YAvvZjk7kEf_aLNNFo6HA8S4JjzkM2d3QC-ZS5A@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] gpiolib: Pass array info to get/set array functions
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        peter.korsgaard@barco.com, Peter Rosin <peda@axentia.se>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, linux-iio@vger.kernel.org,
        driverdevel <devel@driverdev.osuosl.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sebastien.bourdelin@savoirfairelinux.com,
        Lukas Wunner <lukas@wunner.de>,
        Rojhalat Ibrahim <imr@rtschenk.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        ext Tony Lindgren <tony@atomide.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Sep 2, 2018 at 2:01 PM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> In order to make use of array info obtained from gpiod_get_array() and
> speed up processing of arrays matching single GPIO chip layout, that
> information must be passed to get/set array functions.  Extend the
> functions' API with that additional parameter and update all users.
> Pass NULL if a user bulids an array itself from single GPIOs.

builds

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
