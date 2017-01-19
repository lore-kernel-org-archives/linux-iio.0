Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:52094 "EHLO
        webbox1416.server-home.net" rhost-flags-OK-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1752295AbdASOGk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Jan 2017 09:06:40 -0500
From: Alexander Stein <alexander.stein@systec-electronic.com>
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alexandre Courbot <gnurou@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: libgpiod v0.1: C library and command-line tools for controlling GPIOs
Date: Thu, 19 Jan 2017 15:05:23 +0100
Message-ID: <4449310.gRYbpx7f9x@ws-stein>
In-Reply-To: <CAMpxmJUHfo7FRzzx7MxdADyVMYZiSLEPCtCSDLkq540M1fZTkg@mail.gmail.com>
References: <CAMpxmJUHfo7FRzzx7MxdADyVMYZiSLEPCtCSDLkq540M1fZTkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On Wednesday 18 January 2017 16:48:08, Bartosz Golaszewski wrote:
> I'd like to announce the first release of libgpiod. The project
> consists of a C library and a set of command-line tools for
> controlling GPIOs over the new character device interface.
> 
> The tools support reading & setting values, keeping the lines
> exported, finding GPIO lines by name, monitoring events etc.
> 
> The source code can be found at: https://github.com/brgl/libgpiod

Cool thing. thanks! One bug found:
https://github.com/brgl/libgpiod/blob/master/src/tools/gpiomon.c#L31
shortopts is missing 's' so the following occurs:
> gpiomon -l -r -s --num-events=1 gpiochip2 1
> gpiomon: invalid option -- 's'
> gpiomon: try gpiomon --help

> gpiomon -l -r --silent --num-events=1 gpiochip2 1
works as expected

Best regards,
Alexander
-- 
Dipl.-Inf. Alexander Stein
SYS TEC electronic GmbH
alexander.stein@systec-electronic.com

Legal and Commercial Address:
Am Windrad 2
08468 Heinsdorfergrund
Germany

Office: +49 (0) 3765 38600-0
Fax:    +49 (0) 3765 38600-4100
 
Managing Directors:
	Director Technology/CEO: Dipl.-Phys. Siegmar Schmidt;
	Director Commercial Affairs/COO: Dipl. Ing. (FH) Armin von Collrepp
Commercial Registry:
	Amtsgericht Chemnitz, HRB 28082; USt.-Id Nr. DE150534010

