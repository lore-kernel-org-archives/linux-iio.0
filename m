Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58912 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752563AbdA3UZ0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2017 15:25:26 -0500
Subject: Re: [PATCH] iio: stx104: Add support for GPIO names
To: William Breathitt Gray <vilhelm.gray@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net
References: <20170130171604.11266-1-vilhelm.gray@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@stericsson.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c96ed0c0-73ee-62ff-99a6-36c92d2d656e@kernel.org>
Date: Mon, 30 Jan 2017 20:24:45 +0000
MIME-Version: 1.0
In-Reply-To: <20170130171604.11266-1-vilhelm.gray@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/01/17 17:16, William Breathitt Gray wrote:
> This patch sets the gpio_chip names option with an array of GPIO line
> names that match the manual documentation for the Apex Embedded Systems
> STX104. This should make it easier for users to identify which GPIO line
> corresponds to a respective GPIO pin on the device.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc'ing Linus Waleij and gpio list just in case there are any conventions on this
I don't know about!

Jonathan
> ---
>  drivers/iio/adc/stx104.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/stx104.c b/drivers/iio/adc/stx104.c
> index c56ff286695d..04b94fcd5acf 100644
> --- a/drivers/iio/adc/stx104.c
> +++ b/drivers/iio/adc/stx104.c
> @@ -266,6 +266,11 @@ static void stx104_gpio_set(struct gpio_chip *chip, unsigned int offset,
>  	spin_unlock_irqrestore(&stx104gpio->lock, flags);
>  }
>  
> +#define STX104_NGPIO 8
> +static const char *stx104_names[STX104_NGPIO] = {
> +	"DIN0", "DIN1", "DIN2", "DIN3", "DOUT0", "DOUT1", "DOUT2", "DOUT3"
> +};
> +
>  static int stx104_probe(struct device *dev, unsigned int id)
>  {
>  	struct iio_dev *indio_dev;
> @@ -324,7 +329,8 @@ static int stx104_probe(struct device *dev, unsigned int id)
>  	stx104gpio->chip.parent = dev;
>  	stx104gpio->chip.owner = THIS_MODULE;
>  	stx104gpio->chip.base = -1;
> -	stx104gpio->chip.ngpio = 8;
> +	stx104gpio->chip.ngpio = STX104_NGPIO;
> +	stx104gpio->chip.names = stx104_names;
>  	stx104gpio->chip.get_direction = stx104_gpio_get_direction;
>  	stx104gpio->chip.direction_input = stx104_gpio_direction_input;
>  	stx104gpio->chip.direction_output = stx104_gpio_direction_output;
> 

