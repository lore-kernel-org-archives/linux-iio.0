Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:34407 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755664AbdDFOnw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Apr 2017 10:43:52 -0400
MIME-Version: 1.0
In-Reply-To: <1491488454-22468-2-git-send-email-jacopo+renesas@jmondi.org>
References: <1491488454-22468-1-git-send-email-jacopo+renesas@jmondi.org> <1491488454-22468-2-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Apr 2017 16:43:50 +0200
Message-ID: <CAMuHMdUNWJ2C9b9Xzod5HRU_ZG3mVamN6a-ZdOywODJqv6TxQw@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] Documentation: dt-bindings: iio: Add max9611 ADC
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

On Thu, Apr 6, 2017 at 4:20 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/max9611.txt
> @@ -0,0 +1,27 @@
> +* Maxim max9611/max9612 current sense amplifier with 12-bits ADC interface
> +
> +Maxim max9611/max9612 is an high-side current sense amplifier with integrated
> +12-bits ADC communicating over I2c bus.
> +The device node for this driver shall be a child of a I2c controller.
> +
> +Required properties
> +  - compatible: Should be "maxim,max9611" or "maxim,max9612"
> +  - reg: The 7-bits long I2c address of the device
> +  - shunt-resistor-micro-homs: Value, in micro Ohms, of the current sense shunt

s/homs/ohms/

> +                               resistor

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
