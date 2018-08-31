Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:34425 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727712AbeHaNVQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Aug 2018 09:21:16 -0400
Received: by mail-it0-f68.google.com with SMTP id x79-v6so4452393ita.1
        for <linux-iio@vger.kernel.org>; Fri, 31 Aug 2018 02:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180820234341.5271-1-jmkrzyszt@gmail.com> <20180829204900.19390-1-jmkrzyszt@gmail.com>
 <20180829204900.19390-2-jmkrzyszt@gmail.com>
In-Reply-To: <20180829204900.19390-2-jmkrzyszt@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 31 Aug 2018 11:14:31 +0200
Message-ID: <CACRpkdYmd=Efh4-YsTzRAhtKLWHuhJ-9D6iVagkg=+zxU=KLHA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] gpiolib: Pass bitmaps, not integer arrays, to
 get/set array
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
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
        linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-serial@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Aug 29, 2018 at 10:48 PM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

So it's no secret that I strongly fancy this patch set.

What would be great at this point is to have some people test
that the drivers still work as expected, even better if they can do
some benchmarking.

> -               values[PIN_DATA0 + i] = !!(val & BIT(i));
> -       values[PIN_CTRL_RS] = rs;
> +       value_bitmap[0] = val;
> +       __assign_bit(PIN_CTRL_RS, value_bitmap, rs);
>         n = 9;
>         if (hd->pins[PIN_CTRL_RW]) {
> -               values[PIN_CTRL_RW] = 0;
> +               __clear_bit(PIN_CTRL_RW, value_bitmap);

This seems fine to me, but I understand the comment that the
code becomes harder to read.

I think part of it is those __assign_bit() and __clear_bit() with
the double-underscore of unclear meaning. The meaning is
"non atomic" IIRC, so maybe I should move forward
with my plan to send a sed script to Torvalds just renaming all
of those to something sane in the next merge window.

Like __assign_bit() -> assign_bit_nonatomic()

Yours,
Linus Walleij
