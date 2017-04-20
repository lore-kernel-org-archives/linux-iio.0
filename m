Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:34396 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S943380AbdDTRas (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Apr 2017 13:30:48 -0400
MIME-Version: 1.0
In-Reply-To: <20170420154310.32759-1-marek.vasut+renesas@gmail.com>
References: <20170420154310.32759-1-marek.vasut+renesas@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 20 Apr 2017 19:30:46 +0200
Message-ID: <CAMuHMdX4MWKBRKPG6OtRycGFRhOGmR556sR_SWBR3D6Sd+tggA@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: Derive interface clock speed from fck clock
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Apr 20, 2017 at 5:43 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> The "if" interface clock speed is actually derived from the "fck"
> block clock, as in the hardware they are the same clock. Drop the
> incorrect second "if" clock and get the clock speed from "fck".
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: linux-renesas-soc@vger.kernel.org

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
