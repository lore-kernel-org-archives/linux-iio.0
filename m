Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:34537 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751747AbdASJeI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Jan 2017 04:34:08 -0500
Received: by mail-qt0-f178.google.com with SMTP id l7so58674812qtd.1
        for <linux-iio@vger.kernel.org>; Thu, 19 Jan 2017 01:34:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAMpxmJUHfo7FRzzx7MxdADyVMYZiSLEPCtCSDLkq540M1fZTkg@mail.gmail.com>
References: <CAMpxmJUHfo7FRzzx7MxdADyVMYZiSLEPCtCSDLkq540M1fZTkg@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 19 Jan 2017 10:34:07 +0100
Message-ID: <CACRpkdbq5aFZZfNN1UxjrxTzsHQBdkLcz9LCx3BSp-JoirXR6A@mail.gmail.com>
Subject: Re: libgpiod v0.1: C library and command-line tools for controlling GPIOs
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jan 18, 2017 at 4:48 PM, Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:

> I'd like to announce the first release of libgpiod. The project
> consists of a C library and a set of command-line tools for
> controlling GPIOs over the new character device interface.

Nice!

Have you thought about adding bindings for higher order
languages etc that I think can make GPIO programming a bliss?

I created some for Control Groups at a point, using ctypes:
https://sourceforge.net/p/cgfreak/code/ci/master/tree/pylibcgroup.py

The point is not that Python would be so great (some think
so) more that this kind of stuff makes GPIOs so much more
accessible, apart from good old C.

Yours,
Linus Walleij
