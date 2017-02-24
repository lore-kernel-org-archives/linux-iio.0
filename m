Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:34023 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751268AbdBXPWT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Feb 2017 10:22:19 -0500
MIME-Version: 1.0
In-Reply-To: <1487948756-25172-2-git-send-email-jacopo+renesas@jmondi.org>
References: <1487948756-25172-1-git-send-email-jacopo+renesas@jmondi.org> <1487948756-25172-2-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Feb 2017 16:22:16 +0100
Message-ID: <CAMuHMdU9UL9ZyiPJqtTTNS=KOScu6M3c7jQgD1vZ+gTiTCAYMA@mail.gmail.com>
Subject: Re: [PATCH 1/4] Documentation: dt-bindings: iio: Add max961x
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>, meerw@pmeerw.net,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Feb 24, 2017 at 4:05 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/max961x.txt
> @@ -0,0 +1,27 @@
> +* Maxim max9611/max9612 current sense amplifier with 12-bits ADC interface
> +
> +Maxim max9611/max9612 is an high-side current sense amplifier with integrated
> +12-bits ADC communicating over I2c bus.
> +The device node for this driver shall be a child of a I2c controller.
> +
> +Required properties
> +  - compatible: Should be "maxim,max961x"
> +  - reg: The 7-bits long I2c address of the device
> +  - shunt-resistor: Resistor value, in uOhm, of the current sense shunt
> +                   resistor.

shunt-resistor-micro-ohms?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
