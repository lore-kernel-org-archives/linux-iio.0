Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:35031 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752442AbdC0IyD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Mar 2017 04:54:03 -0400
MIME-Version: 1.0
In-Reply-To: <1490369323-13866-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1490369323-13866-1-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 27 Mar 2017 10:53:35 +0200
Message-ID: <CAMuHMdW_tRuVO0wBuvoVCJL62hnBD0CA2e1X3aqJmiZmb8giRA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] iio: adc: Maxim max9611 driver
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jacopo,

On Fri, Mar 24, 2017 at 4:28 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> output reported from iio_info tool:
> iio:device0: max9611_vdd
>                 6 channels found:

>                         temp:  (input)
>                         2 channel-specific attributes found:
>                                 attr 0: scale value: 0.480076812
>                                 attr 1: raw value: 59

According to Documentation/ABI/testing/sysfs-bus-iio, temperature units after
application of scale and offset are milli degrees Celsius, so your scale value
should be 480.076812.

BTW, mine runs 3 degrees cooler, but it's located in the coldest room in my
house ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
