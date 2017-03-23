Return-Path: <SRS0=EWyR=3A=gmail.com=geert.uytterhoeven@kernel.org>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1490272873-2532-2-git-send-email-jacopo+renesas@jmondi.org>
References: <1490272873-2532-1-git-send-email-jacopo+renesas@jmondi.org> <1490272873-2532-2-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 23 Mar 2017 13:47:54 +0100
Message-ID: <CAMuHMdW2Eb41nuNAS0j7fYhWCDD2xAuSVK=j2o5JZw3QdW=8kQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] Documentation: dt-bindings: iio: Add max9611 ADC
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, Mar 23, 2017 at 1:41 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> Add device tree bindings documentation for Maxim max9611/max9612 current
> sense amplifier.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

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
> +  - maxim,shunt-resistor-uohm: Resistor value, in uOhm, of the current sense
> +                               shunt resistor.

Isn't this sufficiently generic to drop the "maxim," prefix?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
