Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40261 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751026AbdAVNXg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Jan 2017 08:23:36 -0500
Subject: Re: [PATCH 5/5] iio: stx104: Add GPIO set_multiple callback function
 support
To: William Breathitt Gray <vilhelm.gray@gmail.com>,
        linus.walleij@linaro.org, gnurou@gmail.com
References: <cover.1484838095.git.vilhelm.gray@gmail.com>
 <53039e49d1421a6f070c691988eb22ef0987eba4.1484838095.git.vilhelm.gray@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1690f497-7b6a-f82d-b0d9-c395c42e9694@kernel.org>
Date: Sun, 22 Jan 2017 13:23:07 +0000
MIME-Version: 1.0
In-Reply-To: <53039e49d1421a6f070c691988eb22ef0987eba4.1484838095.git.vilhelm.gray@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/01/17 15:06, William Breathitt Gray wrote:
> The Apex Embedded Systems STX104 series provides a digital output
> register where 4 lines may be set at a time. This patch add support for
> the set_multiple callback function, thus allowing multiple digital
> output lines to be set more efficiently in groups.
> 
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/iio/adc/stx104.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/iio/adc/stx104.c b/drivers/iio/adc/stx104.c
> index 7e3645749eaf..6971293909f7 100644
> --- a/drivers/iio/adc/stx104.c
> +++ b/drivers/iio/adc/stx104.c
> @@ -266,6 +266,28 @@ static void stx104_gpio_set(struct gpio_chip *chip, unsigned int offset,
>  	spin_unlock_irqrestore(&stx104gpio->lock, flags);
>  }
>  
> +static void stx104_gpio_set_multiple(struct gpio_chip *chip,
> +	unsigned long *mask, unsigned long *bits)
> +{
> +	struct stx104_gpio *const stx104gpio = gpiochip_get_data(chip);
> +	unsigned long flags;
> +
> +	/* verify masked GPIO are output */
> +	if (!(*mask & 0xF0))
> +		return;
> +
> +	*mask >>= 4;
> +	*bits >>= 4;
> +
> +	spin_lock_irqsave(&stx104gpio->lock, flags);
> +
> +	stx104gpio->out_state &= ~*mask;
> +	stx104gpio->out_state |= *mask & *bits;
> +	outb(stx104gpio->out_state, stx104gpio->base);
> +
> +	spin_unlock_irqrestore(&stx104gpio->lock, flags);
> +}
> +
>  static int stx104_probe(struct device *dev, unsigned int id)
>  {
>  	struct iio_dev *indio_dev;
> @@ -330,6 +352,7 @@ static int stx104_probe(struct device *dev, unsigned int id)
>  	stx104gpio->chip.direction_output = stx104_gpio_direction_output;
>  	stx104gpio->chip.get = stx104_gpio_get;
>  	stx104gpio->chip.set = stx104_gpio_set;
> +	stx104gpio->chip.set_multiple = stx104_gpio_set_multiple;
>  	stx104gpio->base = base[id] + 3;
>  	stx104gpio->out_state = 0x0;
>  
> 

