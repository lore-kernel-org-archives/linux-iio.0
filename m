Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:34518 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760910AbdDSIkX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Apr 2017 04:40:23 -0400
MIME-Version: 1.0
In-Reply-To: <1491488454-22468-5-git-send-email-jacopo+renesas@jmondi.org>
References: <1491488454-22468-1-git-send-email-jacopo+renesas@jmondi.org> <1491488454-22468-5-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 19 Apr 2017 10:40:21 +0200
Message-ID: <CAMuHMdXkixLn9xdnrhEXW9pCg-4WjOuoPdyxXYeBwRfetMSYsA@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] arm64: dts: salvator-x: Add current sense amplifiers
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

On Thu, Apr 6, 2017 at 4:20 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> [PATCH v5 4/4] arm64: dts: salvator-x: Add current sense amplifiers

This should be "arm64: dts: r8a7796: salvator-x: Add current sense amplifiers".
Perhaps Simon can just fix that himself while applying?

> Add device nodes for two Maxim max961x current sense amplifiers
> sensing VDD_08 and DVFS_08 lines.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
