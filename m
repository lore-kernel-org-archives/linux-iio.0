Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <1464975762-24052-1-git-send-email-vilhelm.gray@gmail.com>
References: <1464975762-24052-1-git-send-email-vilhelm.gray@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 Jun 2016 14:15:43 +0200
Message-ID: <CACRpkda+5LmMSFia=R8P=xqd8Hh6h-gvTqjaxqr0OqJH5pkFuw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: stx104: Add GPIO support for the Apex Embedded
 Systems STX104
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jun 3, 2016 at 7:42 PM, William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:

> The Apex Embedded Systems STX104 device features eight lines of digital
> I/O (four digital inputs and four digital outputs). This patch adds GPIO
> support for these eight lines of digital I/O via GPIOLIB.
>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
> Changes in v2:
>   - Change GPIOLIB Kconfig selection to a dependency for the STX104 Kconfig
>     option; STX104 should only be available to systems configured for GPIOLIB

Are you sure? I just changed the GPIOLIB Kconfig so any arch/thing can
select GPIOLIB, if this driver needs it, it can just select it now.

> +static int stx104_gpio_get_direction(struct gpio_chip *chip,
> +       unsigned int offset)
> +{
> +       if (offset < 4)
> +               return 1;
> +
> +       return 0;
> +}

If this looks so...

> +static int stx104_gpio_direction_input(struct gpio_chip *chip,
> +       unsigned int offset)
> +{
> +       return 0;
> +}
> +
> +static int stx104_gpio_direction_output(struct gpio_chip *chip,
> +       unsigned int offset, int value)
> +{
> +       return 0;
> +}

These should return -EINVAL or -EIO or something if you try to
set the direction to something the line does not support.

Other than that it looks good.

Yours,
Linus Walleij
