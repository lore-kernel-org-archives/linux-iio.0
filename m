Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:36540 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751192AbdBXPcN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Feb 2017 10:32:13 -0500
MIME-Version: 1.0
In-Reply-To: <1487948756-25172-2-git-send-email-jacopo+renesas@jmondi.org>
References: <1487948756-25172-1-git-send-email-jacopo+renesas@jmondi.org> <1487948756-25172-2-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Feb 2017 16:29:11 +0100
Message-ID: <CAMuHMdWjtRZpjGi8BPkDGKGPr5uBr5jsjLi80COUDruZLuTXfQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] Documentation: dt-bindings: iio: Add max961x
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jacopo,

[fixed Peter Meerwald's address]

On Fri, Feb 24, 2017 at 4:05 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> Add device tree bindings documentation for Maxim max961x current sense
> amplifier.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  .../devicetree/bindings/iio/adc/max961x.txt        | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/max961x.txt
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/max961x.txt b/Documentation/devicetree/bindings/iio/adc/max961x.txt
> new file mode 100644
> index 0000000..abbc6c4
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

I'ts not a good idea to use wildcards in compatible values.
Ask yourself: is this valid for any (future) value of "x"?

Hence please use "maxim,max9611" or "maxim,max9612".
The only difference between these two is a noninverting vs. inverting
input-to-output configuration. Does the driver need to care?

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
