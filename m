Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:9952 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750959AbdKDDVd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Nov 2017 23:21:33 -0400
Date: Sat, 4 Nov 2017 03:20:59 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        "Hartmut Knaack" <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 3/5] iio: proximity: sx9500: Set IRQ pin to
 direction-input if necessary
Message-ID: <20171104032059.0000049a@huawei.com>
In-Reply-To: <20171103130340.42459-3-andriy.shevchenko@linux.intel.com>
References: <20171103130340.42459-1-andriy.shevchenko@linux.intel.com>
        <20171103130340.42459-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 3 Nov 2017 15:03:38 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> With the new more strict ACPI gpio code the DSDT's IoRestriction flags
> are honored on gpiod_get(), but in some DSDT's it is wrong, so
> explicitly call gpiod_direction_input() on the IRQ GPIO if necessary.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Again, I really really don't like filling driver code with fixes
for broken firmware.  I appreciate we have to cope with this, but
it does rather seem like this should be moved into the core code
for say gpiod_get_irq.

Otherwise we get to fix this hundreds of times in different drivers
as I doubt this is the only driver effected by wrong tables...

Jonathan

> ---
>  drivers/iio/proximity/sx9500.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/sx9500.c
> b/drivers/iio/proximity/sx9500.c index eb687b3dd442..3cf054155779
> 100644 --- a/drivers/iio/proximity/sx9500.c
> +++ b/drivers/iio/proximity/sx9500.c
> @@ -17,6 +17,7 @@
>  #include <linux/irq.h>
>  #include <linux/acpi.h>
>  #include <linux/gpio/consumer.h>
> +#include <linux/gpio.h>
>  #include <linux/regmap.h>
>  #include <linux/pm.h>
>  #include <linux/delay.h>
> @@ -892,8 +893,13 @@ static void sx9500_gpio_probe(struct i2c_client
> *client, gpiod_int = devm_gpiod_get(dev, "interrupt", GPIOD_IN);
>  		if (IS_ERR(gpiod_int))
>  			dev_err(dev, "gpio get irq failed\n");
> -		else
> +		else {
> +			if (gpiod_get_direction(gpiod_int) !=
> GPIOF_DIR_IN) {
> +				dev_warn(dev, FW_BUG "IRQ GPIO not
> in input mode, fixing\n");
> +				gpiod_direction_input(gpiod_int);
> +			}
>  			client->irq = gpiod_to_irq(gpiod_int);
> +		}
>  	}
>  
>  	data->gpiod_rst = devm_gpiod_get(dev, "reset",
> GPIOD_OUT_HIGH);

