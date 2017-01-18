Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:36519 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752577AbdARPsJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Jan 2017 10:48:09 -0500
Received: by mail-it0-f47.google.com with SMTP id c7so120262810itd.1
        for <linux-iio@vger.kernel.org>; Wed, 18 Jan 2017 07:48:09 -0800 (PST)
MIME-Version: 1.0
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Wed, 18 Jan 2017 16:48:08 +0100
Message-ID: <CAMpxmJUHfo7FRzzx7MxdADyVMYZiSLEPCtCSDLkq540M1fZTkg@mail.gmail.com>
Subject: libgpiod v0.1: C library and command-line tools for controlling GPIOs
To: Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alexandre Courbot <gnurou@gmail.com>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I'd like to announce the first release of libgpiod. The project
consists of a C library and a set of command-line tools for
controlling GPIOs over the new character device interface.

The tools support reading & setting values, keeping the lines
exported, finding GPIO lines by name, monitoring events etc.

The source code can be found at: https://github.com/brgl/libgpiod

I also submitted a patch for the project to be included in buildroot.

Best regards,
Bartosz Golaszewski
