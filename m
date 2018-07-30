Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:34063 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbeG3SnX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jul 2018 14:43:23 -0400
MIME-Version: 1.0
In-Reply-To: <20180730140205.4972-1-mircea.caprioru@analog.com>
References: <20180730140205.4972-1-mircea.caprioru@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 30 Jul 2018 20:07:26 +0300
Message-ID: <CAHp75VdJ95Az=WmUP2Rb7byLs7J_T80FcNJ6zTNwnxDYh4NnJQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: dac: ad5770r: Add AD5770R support
To: Mircea Caprioru <mircea.caprioru@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kuppuswamy Sathyanarayanan
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Ludovic Desroches <ludovic.desroches@o2linux.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Jul 30, 2018 at 5:02 PM, Mircea Caprioru
<mircea.caprioru@analog.com> wrote:
> The AD5770R is a 6-channel, 14-bit resolution, low noise, programmable
> current output digital-to-analog converter (DAC) for photonics control
> applications.
>
> It contains five 14-bit resolution current sourcing DAC channels and one
> 14-bit resolution current sourcing/sinking DAC channel.

Looks nice, though few comments below.

> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +#include <linux/delay.h>
> +#include <linux/property.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/regulator/consumer.h>

Can we keep it sorted?

> +#define AD5770R_LOW_VREF       1250
> +#define AD5770R_HIGH_VREF      2500

_VREF_mV ?

We usually use units as suffixes to the constant to increase
readability of the code.

> +       bool                            internal_ref;
> +       bool                            ch_pwr_down[AD5770R_MAX_CHANNELS];

A nit: I would rather swap them.

> +static int ad5770r_reset(struct ad5770r_state *st)
> +{

> +       if (st->gpio_reset) {
> +               gpiod_set_value(st->gpio_reset, 0);
> +               udelay(100);
> +               gpiod_set_value(st->gpio_reset, 1);

usleep_range() ?

Btw, can it be called from atomic context?

Otherwise I would consider to call gpiod_set_value_cansleep().

> +       } else {
> +               /* Perform a software reset */
> +               return ad5770r_soft_reset(st);
> +       }

Perhaps

/* Perform software reset if no GPIO provided */
if (!st->gpio_reset)
 return ...;

...

?

> +       /* data must not be written during reset timeframe */
> +       mdelay(1); /* TODO update with value from datasheet once available */

Perhaps usleep_range()? mdelay even for 1ms is kinda long time.

> +
> +       return 0;
> +}

> +static int ad5770r_write_raw(struct iio_dev *indio_dev,
> +                            struct iio_chan_spec const *chan,
> +                            int val, int val2, long info)
> +{
> +       struct ad5770r_state *st = iio_priv(indio_dev);

> +       unsigned char buf[2];

Perhaps this kind of buffers better to be defined as u8 ?

> +
> +       switch (info) {
> +       case IIO_CHAN_INFO_RAW:

> +               buf[0] = ((u16)val >> 6) & 0xFF;

Useless & 0xFF.

> +               buf[1] = (val & 0x3F) << 2;
> +               return regmap_bulk_write(st->regmap, chan->address,
> +                                        buf, ARRAY_SIZE(buf));
> +       default:
> +               return -EINVAL;
> +       }
> +}

> +static int ad5770r_store_output_range(struct ad5770r_state *st,
> +                                     int min, int max, int index)
> +{
> +       int i;
> +
> +       for (i = 0; i < AD5770R_MAX_CH_MODES; i++) {
> +               if (ad5770r_rng_tbl[i].ch != index)
> +                       continue;

> +               if (ad5770r_rng_tbl[i].min != min ||
> +                   ad5770r_rng_tbl[i].max != max)

Hmm... If you keep your table sorted you may bail out immediately when
you know that there will not be proper value.

> +                       continue;
> +               st->output_mode[index].out_range_mode = ad5770r_rng_tbl[i].mode;
> +               return 0;
> +       }
> +
> +       return -EINVAL;
> +}

> +static const struct iio_chan_spec_ext_info ad5770r_ext_info[] = {
> +       {
> +               .name = "powerdown",
> +               .read = ad5770r_read_dac_powerdown,
> +               .write = ad5770r_write_dac_powerdown,
> +               .shared = IIO_SEPARATE,
> +       },

> +       { },

Terminator entries are slightly better without comma (guard even at
compile time).

> +};

> +static int ad5770r_channel_config(struct ad5770r_state *st)
> +{
> +       int ret, tmp[2], min, max, i;
> +       unsigned int num;
> +       struct fwnode_handle *child;

> +       bool ch_config[AD5770R_MAX_CHANNELS] = {0};

I'm not sure I understood necessity of this array.

> +       device_for_each_child_node(&st->spi->dev, child) {
> +               ret = fwnode_property_read_u32(child, "num", &num);
> +               if (ret)
> +                       return ret;
> +               if (num > AD5770R_MAX_CHANNELS)
> +                       return -EINVAL;
> +
> +               ret = fwnode_property_read_u32_array(child,
> +                                                    "adi,range-microamp",
> +                                                    tmp, 2);
> +               if (ret)
> +                       return ret;
> +
> +               min = tmp[0] / 1000;
> +               max = tmp[1] / 1000;
> +               ret = ad5770r_store_output_range(st, min, max, num);
> +               if (ret)
> +                       return ret;

> +
> +               ch_config[num] = true;

As far as I can see you will end up this loop if and only if you have
all defined channels initialized. The question left behind is a number
of child properties, thus count them first.

> +       }
> +
> +       for (i = 0; i < AD5770R_MAX_CHANNELS; i++)
> +               if (!ch_config[i])
> +                       return -EINVAL;
> +
> +       return ret;
> +}

> +       for (i = 0; i < AD5770R_MAX_CHANNELS; i++) {

> +               ret = ad5770r_set_output_mode(st,
> +                                             &st->output_mode[i], i);

Can it be one line?

> +               if (ret)
> +                       return ret;
> +       }

-- 
With Best Regards,
Andy Shevchenko
