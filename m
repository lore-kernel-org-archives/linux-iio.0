Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:32961 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753121AbcLMNVC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Dec 2016 08:21:02 -0500
MIME-Version: 1.0
In-Reply-To: <1481632629-18826-1-git-send-email-jacopo@jmondi.org>
References: <1481041823-18382-1-git-send-email-jacopo@jmondi.org> <1481632629-18826-1-git-send-email-jacopo@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 13 Dec 2016 14:21:00 +0100
Message-ID: <CAMuHMdUCuBs9Fm+YvsqEc1J_a_2sgg104DDBf39oUD2JQRxXtg@mail.gmail.com>
Subject: Re: [PATCHv2] iio: adc: Add Maxim MAX11100 driver
To: Jacopo Mondi <jacopo@jmondi.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jacopo,

On Tue, Dec 13, 2016 at 1:37 PM, Jacopo Mondi <jacopo@jmondi.org> wrote:
> Add IIO driver for Maxim MAX11100 single-channel ADC.
> Add DT bindings documentation.
>
> Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>

> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -29,6 +29,7 @@ obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
>  obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
>  obj-$(CONFIG_LTC2485) += ltc2485.o
>  obj-$(CONFIG_MAX1027) += max1027.o
> +obj-$(CONFIG_MAX11100) += max11100.o
>  obj-$(CONFIG_MAX1363) += max1363.o
>  obj-$(CONFIG_MCP320X) += mcp320x.o
>  obj-$(CONFIG_MCP3422) += mcp3422.o
> diff --git a/drivers/iio/adc/max11100.c b/drivers/iio/adc/max11100.c
> new file mode 100644
> index 0000000..f372ad8
> --- /dev/null
> +++ b/drivers/iio/adc/max11100.c

> +/*
> + * LSB is the ADC single digital step
> + * 1 LSB = (vref / 2 ^ 16)
> + * AIN = (DIN * LSB)
> + */
> +#define MAX11100_LSB_DIV               (1 << 16)
> +#define MAX11100_LSB(vref)             (vref / MAX11100_LSB_DIV)

DIV_ROUND_CLOSEST()?

> +struct max11100_state {
> +       const struct max11100_chip_desc *desc;
> +       struct spi_device *spi;
> +       int vref_uv;

unsi
It's good practice to move the smaller members to the end of the structure,
to avoid gaps due to alignment rules (struct mutex needs to be 64-bit aligned
on 64-bit platforms).

> +       struct mutex lock;
> +};

> +static struct max11100_chip_desc {
> +       unsigned int num_chan;
> +       const struct iio_chan_spec *channels;

Same here (but it won't have any effect for now).

> +} max11100_desc = {
> +       .num_chan = ARRAY_SIZE(max11100_channels),
> +       .channels = max11100_channels,
> +};

> +static int max11100_read_raw(struct iio_dev *indio_dev,
> +                            struct iio_chan_spec const *chan,
> +                            int *val, int *val2, long mask)
> +{
> +       int ret;
> +       struct max11100_state *state = iio_priv(indio_dev);
> +       uint8_t buffer[3];

> +       *val = be16_to_cpu(*(uint16_t *)&buffer[1]);

Reading the uint16_t will be an unaligned load, which is not supported on all
platforms. So you either have to use get_unaligned_le16(), or assemble the
value yourself, like you did in v1.

> +       *val = *val * MAX11100_LSB(state->vref_uv) / 1000;

DIV_ROUND_CLOSEST()?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
