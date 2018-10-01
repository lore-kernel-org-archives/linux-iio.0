Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io1-f65.google.com ([209.85.166.65]:36093 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729038AbeJAQOO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Oct 2018 12:14:14 -0400
Received: by mail-io1-f65.google.com with SMTP id p4-v6so3035566iom.3
        for <linux-iio@vger.kernel.org>; Mon, 01 Oct 2018 02:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180923235336.22148-2-jmkrzyszt@gmail.com> <20180929122022.6825-1-jmkrzyszt@gmail.com>
In-Reply-To: <20180929122022.6825-1-jmkrzyszt@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 1 Oct 2018 11:37:07 +0200
Message-ID: <CACRpkdbxh3uoVbc1udouxKaN+sc+q_vB7oj_B8PEa4wi=wLedg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Fix incorrect use of find_next_zero_bit()
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg KH <gregkh@linuxfoundation.org>, kishon@ti.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Rojhalat Ibrahim <imr@rtschenk.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        ext Tony Lindgren <tony@atomide.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-i2c@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-serial@vger.kernel.org,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Sep 29, 2018 at 2:19 PM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Commit b17566a6b08b ("gpiolib: Implement fast processing path in
> get/set array"), already fixed to some extent with commit 5d581d7e8cdc
> ("gpiolib: Fix missing updates of bitmap index"), introduced a new mode
> of processing bitmaps where bits applicable for fast bitmap processing
> path are supposed to be skipped while iterating bits which don't apply.
> Unfortunately, find_next_zero_bit() function supposed to skip over
> those fast bits is always called with a 'start' argument equal to an
> index of last zero bit found and returns that index value again an
> again, causing an infinite loop.
>
> Fix it by incrementing the index uncoditionally before
> find_next_zero_bit() is optionally called.
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Patch applied with Marek's Tested-by.

Thanks to both of you for digging in and fixing this up!
Now we are in good shape for the v4.20 cycle :)

Yours,
Linus Walleij
