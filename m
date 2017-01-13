Return-Path: <SRS0=Ovnb=Y3=gmail.com=geert.uytterhoeven@kernel.org>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1484261499-7729-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1484261499-7729-1-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 13 Jan 2017 09:27:50 +0100
Message-ID: <CAMuHMdWLkDzdvTpbse2vN++XQtgjs_QzrRZCxG7PKuFR2C2ccA@mail.gmail.com>
Subject: Re: [PATCH v3] iio: adc: Add Maxim MAX11100 driver
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, Marek Vasut <marek.vasut@gmail.com>, linux-iio@vger.kernel.org,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi Jacopo,

On Thu, Jan 12, 2017 at 11:51 PM, Jacopo Mondi
<jacopo+renesas@jmondi.org> wrote:
> From: Jacopo Mondi <jacopo@jmondi.org>
>
> Add IIO driver for Maxim MAX11100 single-channel ADC.
> Add DT bindings documentation.
>
> Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
> Tested-by: Marek Vasut <marek.vasut@gmail.com>

>  .../devicetree/bindings/iio/adc/max11100.txt       |  17 ++
>  drivers/iio/adc/Kconfig                            |   9 +
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/max11100.c                         | 187 +++++++++++++++++++++
>  4 files changed, 214 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/max11100.txt
>  create mode 100644 drivers/iio/adc/max11100.c

When submitting a new driver with DT bindings, please split off the
DT binding docs in a separate patch, and CC devicetree@vger.kernel.org,
Rob Herring, and Mark Rutland.

scripts/get_maintainer.pl is your friend ;-)

Reviewing DT binding docs only...

> new file mode 100644
> index 0000000..6877c11
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/max11100.txt
> @@ -0,0 +1,17 @@
> +* Maxim max11100 Analog to Digital Converter (ADC)
> +
> +Required properties:
> +  - compatible: Should be "maxim,max11100"
> +  - vref-supply: phandle to the regulator that provides reference voltage

As this is an SPI slave device, there should be a "reg" property.

> +
> +Optional properties:
> +  - spi-max-frequency: SPI maximum frequency
> +
> +Example:
> +
> +adc0: max11100@0 {

As per ePAPR Section 2.2.2 "Generic Names Recommendation", node names
should be "somewhat generic, reflecting the function of the device and
not its precise programming model.".
The label property defines a human readable string describing a device.
Hence "max11100: adc@0" is more appropriate.

> +        compatible = "maxim,max11100";

Missing "reg = <0>;" matching the unit-address above.

> +        vref-supply = <&adc0_vref>;
> +        spi-max-frequency = <240000>;
> +};

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
