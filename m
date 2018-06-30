Return-Path: <SRS0=SqJI=JQ=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1530261516-21118-1-git-send-email-stefan.popa@analog.com>
References: <1530261516-21118-1-git-send-email-stefan.popa@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 1 Jul 2018 00:26:56 +0300
Message-ID: <CAHp75Vfb_b6FPpnhu4Z_=iBNovNubneCD3cRG9SawRmMCNOVjw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] iio: dac: Add AD5758 support
To: Stefan Popa <stefan.popa@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>, Randy Dunlap <rdunlap@infradead.org>,
	Lukas Wunner <lukas@wunner.de>, Ismail.Kose@maximintegrated.com,
	William Breathitt Gray <vilhelm.gray@gmail.com>, sean.nyekjaer@prevas.dk,
	Philippe Ombredanne <pombredanne@nexb.com>, linux-iio@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jun 29, 2018 at 11:38 AM, Stefan Popa <stefan.popa@analog.com> wrote:
> The AD5758 is a single channel DAC with 16-bit precision which uses the
> SPI interface that operates at clock rates up to 50MHz.
>
> The output can be configured as voltage or current and is available on a
> single terminal.
>
> Datasheet:
> http://www.analog.com/media/en/technical-documentation/data-sheets/ad5758.pdf

Thanks for an update.
Few comments below.

> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +#include <linux/property.h>
> +#include <linux/delay.h>
> +#include <linux/bsearch.h>

Perhaps keep them ordered?

> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +

> +#include <asm/div64.h>

ASM? Hmm...

> +static int cmpfunc(const void *a, const void *b)
> +{
> +       return (*(int *)a - *(int *)b);

Surrounding parens are not needed.

> +}
> +

> +static int ad5758_find_closest_match(const int *array,
> +                                    unsigned int size, int val)
> +{
> +       int i;
> +
> +       for (i = 0; i < size; i++) {
> +               if (val <= array[i])
> +                       return i;
> +       }
> +
> +       return size - 1;
> +}

Isn't it what bsearch() covers as well?

> +       do {
> +               ret = ad5758_spi_reg_read(st, reg);
> +               if (ret < 0)
> +                       return ret;
> +
> +               if (!(ret & mask))
> +                       return 0;
> +

> +               udelay(100);

If it's not called from atomic context, perhaps switch to usleep_range() ?

> +       } while (--timeout);


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

> +       /* Perform a software reset and wait 100us */
> +       udelay(100);

Ditto.

> +
> +       return ret;
> +}

> +static int ad5758_find_out_range(struct ad5758_state *st,
> +                                const struct ad5758_range *range,
> +                                unsigned int size,
> +                                int min, int max)
> +{
> +       int i;
> +
> +       for (i = 0; i < size; i++) {
> +               if ((min == range[i].min) && (max == range[i].max)) {
> +                       st->out_range.reg = range[i].reg;
> +                       st->out_range.min = range[i].min;
> +                       st->out_range.max = range[i].max;
> +
> +                       return 0;
> +               }
> +       }

One more candidate to use bsearch().

> +
> +       return -EINVAL;
> +}

> +               index = (int *) bsearch(&tmp, ad5758_dc_dc_ilim,
> +                                       ARRAY_SIZE(ad5758_dc_dc_ilim),
> +                                       sizeof(int), cmpfunc);

I'm not sure you need that casting.

-- 
With Best Regards,
Andy Shevchenko
