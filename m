Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ua0-f194.google.com ([209.85.217.194]:34581 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933638AbeFLQ17 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Jun 2018 12:27:59 -0400
MIME-Version: 1.0
In-Reply-To: <1528376980-526-1-git-send-email-stefan.popa@analog.com>
References: <1528376980-526-1-git-send-email-stefan.popa@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 12 Jun 2018 19:27:58 +0300
Message-ID: <CAHp75Vdx3VhS2jcu1j6S65a5mm=Qr5LiT3FuSCeagmoEZPf+Wg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: dac: Add AD5758 support
To: Stefan Popa <stefan.popa@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lukas Wunner <lukas@wunner.de>,
        Ismail.Kose@maximintegrated.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        sean.nyekjaer@prevas.dk,
        Philippe Ombredanne <pombredanne@nexb.com>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Jun 7, 2018 at 4:09 PM, Stefan Popa <stefan.popa@analog.com> wrote:
> The AD5758 is a single channel DAC with 16-bit precision which uses the SPI
> interface that operates at clock rates up to 50MHz.
>
> The output can be configured as voltage or current and is available on a
> single terminal.
>
> Datasheet:
> http://www.analog.com/media/en/technical-documentation/data-sheets/ad5758.pdf

> +#include <linux/fs.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +#include <linux/spi/spi.h>
> +#include <linux/delay.h>

Can you keep the list in order?

> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/property.h>

Same, and property.h more generic if you wish than iio.

> +/* AD5758_DIGITAL_DIAG_RESULTS */
> +#define AD5758_DIG_DIAG_RES_CAL_MEM_UNREFRESHED_MSK    BIT(15)

This name way too long.
Also, check the rest near to this length and try to shorten them.

> +#define AD5758_REG_WRITE(x)    (0x80 | ((x) & 0x1F))

Name of macro is misleading. It rather some value preparations than "write".

> +/* x^8 + x^2 + x^1 + x^0 */
> +#define AD5758_CRC8_POLY       0x07

Where is it used?

> +enum ad5758_output_range {
> +       AD5758_RANGE_0V_5V,
> +       AD5758_RANGE_0V_10V,
> +       AD5758_RANGE_PLUSMINUS_5V,
> +       AD5758_RANGE_PLUSMINUS_10V,
> +       AD5758_RANGE_0mA_20mA = 8,

Hmm... why it starts from 8? Perhaps some explanation on top of enum?

> +       AD5758_RANGE_0mA_24mA,
> +       AD5758_RANGE_4mA_24mA,
> +       AD5758_RANGE_PLUSMINUS_20mA,
> +       AD5758_RANGE_PLUSMINUS_24mA,
> +       AD5758_RANGE_MINUS_1mA_PLUS_22mA,
> +};

> +static int ad5758_get_array_index(const int *array, unsigned int size, int val)
> +{
> +       int i;
> +
> +       for (i = 0; i < size; i++) {
> +               if (val == array[i])
> +                       return i;
> +       }
> +
> +       return -EINVAL;
> +}

bsearch? (lib/bsearch.c)

> +static int ad5758_wait_for_task_complete(struct ad5758_state *st,
> +                                        unsigned int reg,
> +                                        unsigned int mask)
> +{
> +       unsigned int timeout;
> +       int ret;
> +
> +       timeout = 4;
> +       do {
> +               ret = ad5758_spi_reg_read(st, reg);
> +               if (ret < 0)
> +                       return ret;
> +
> +               if (!(ret & mask))
> +                       return 0;
> +

> +               mdelay(1);

No way. CPU would be busy for 1ms at least!

> +       } while (--timeout);
> +
> +       dev_err(&st->spi->dev,
> +               "Error reading bit 0x%x in 0x%x register\n", mask, reg);
> +
> +       return -EIO;
> +}

> +static int ad5758_soft_reset(struct ad5758_state *st)
> +{
> +       int ret;
> +
> +       ret = ad5758_spi_reg_write(st, AD5758_KEY, AD5758_KEY_CODE_RESET_1);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = ad5758_spi_reg_write(st, AD5758_KEY, AD5758_KEY_CODE_RESET_2);
> +

> +       mdelay(1);

Explanation must be given for such a long delay without idling.

> +
> +       return ret;
> +}

> +       if (readval == NULL) {

Why not positive check?

if (readval) {
 ...
} else {
 ...
}

> +               ret =  ad5758_spi_reg_write(st, reg, writeval);
> +       } else {
> +               ret = ad5758_spi_reg_read(st, reg);
> +               if (ret < 0) {
> +                       mutex_unlock(&st->lock);
> +                       return ret;
> +               }
> +
> +               *readval = ret;
> +               ret = 0;
> +       }

> +       ret = strtobool(buf, &pwr_down);
> +       if (ret)
> +               return ret;

kstrtobool(), please.

> +static const struct iio_chan_spec_ext_info ad5758_ext_info[] = {
> +       {
> +               .name = "powerdown",
> +               .read = ad5758_read_powerdown,
> +               .write = ad5758_write_powerdown,
> +               .shared = IIO_SEPARATE,
> +       },
> +       { },

Terminator is better without comma.

> +};

> +       st->data[0].d32 =

> +               cpu_to_be32(
> +               (AD5758_REG_WRITE(AD5758_DIGITAL_DIAG_CONFIG) << 24) | 0x5C3A);

Either do this one line, or introduce a temporary variable for
parameter of cpu_to_be32().

> +       if (!device_property_read_u32(&st->spi->dev, "adi,range", &tmp)) {

Would be better to have
ret = device_property_...();
if (ret) {
 ...
} else {
 ...
}

if it's optional and

if (ret) {
 ...
 return -ERRNO; // goto cleanup; etc
}

> +               for (i = 0; i < ARRAY_SIZE(ad5758_min_max_table); i++) {
> +                       if (tmp == ad5758_min_max_table[i].reg) {
> +                               st->out_range = i;
> +                               break;
> +                       }
> +               }
> +
> +               if (i == ARRAY_SIZE(ad5758_min_max_table))
> +                       dev_warn(&st->spi->dev,
> +                                "range invalid, using 0V to 5V\n");
> +       } else {
> +               dev_dbg(&st->spi->dev,
> +                       "Missing \"range\" property, using 0V to 5V\n");
> +       }

> +       if (!device_property_read_u32_array(&st->spi->dev, "adi,slew",
> +                                           tmparray, 3)) {

...

> +       } else {
> +               dev_dbg(&st->spi->dev,
> +                        "Missing \"slew\" property, using 16kHz and 4 LSB\n");
> +       }

Ditto.

> +       ad5758_parse_dt(st);

No errors? Nothing fatal?

-- 
With Best Regards,
Andy Shevchenko
