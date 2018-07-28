Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727644AbeG1LLE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Jul 2018 07:11:04 -0400
Date: Sat, 28 Jul 2018 10:45:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>
Subject: Re: [PATCH] iio: ad9523: support for external signals via gpios
Message-ID: <20180728104510.08113aa5@archlinux>
In-Reply-To: <20180727064109.6828-1-alexandru.ardelean@analog.com>
References: <20180727064109.6828-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 27 Jul 2018 09:41:09 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> The AD9523 supports external signals for power-down mode, resetting the
> device and sync timing.
> This change add support for specifying values for these signals via the
> gpios and initializing them default values.
> 
> For the reset signal, the GPIO is toggled during probing to re-initialize
> the device to a known state.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

It might be worth putting together a DT binding doc for this device
(and fully dt bindings) as it is getting to be non trivial and presumably
most new users of this part are using DT.

Jonathan

> ---
>  drivers/iio/frequency/ad9523.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
> index 37504739c277..38a8f73bd8d9 100644
> --- a/drivers/iio/frequency/ad9523.c
> +++ b/drivers/iio/frequency/ad9523.c
> @@ -12,6 +12,7 @@
>  #include <linux/sysfs.h>
>  #include <linux/spi/spi.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
>  #include <linux/delay.h>
> @@ -268,6 +269,9 @@ struct ad9523_state {
>  	struct regulator		*reg;
>  	struct ad9523_platform_data	*pdata;
>  	struct iio_chan_spec		ad9523_channels[AD9523_NUM_CHAN];
> +	struct gpio_desc		*pwrdown_gpio;
> +	struct gpio_desc		*reset_gpio;
> +	struct gpio_desc		*sync_gpio;
>  
>  	unsigned long		vcxo_freq;
>  	unsigned long		vco_freq;
> @@ -988,6 +992,32 @@ static int ad9523_probe(struct spi_device *spi)
>  			return ret;
>  	}
>  
> +	st->pwrdown_gpio = devm_gpiod_get_optional(&spi->dev, "powerdown",
> +		GPIOD_OUT_HIGH);
> +	if (IS_ERR(st->pwrdown_gpio)) {
> +		ret = PTR_ERR(st->pwrdown_gpio);
> +		goto error_disable_reg;
> +	}
> +
> +	st->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset",
> +		GPIOD_OUT_LOW);
> +	if (IS_ERR(st->reset_gpio)) {
> +		ret = PTR_ERR(st->reset_gpio);
> +		goto error_disable_reg;
> +	}
> +
> +	if (st->reset_gpio) {
> +		udelay(1);
> +		gpiod_direction_output(st->reset_gpio, 1);
> +	}
> +
> +	st->sync_gpio = devm_gpiod_get_optional(&spi->dev, "sync",
> +		GPIOD_OUT_HIGH);
> +	if (IS_ERR(st->sync_gpio)) {
> +		ret = PTR_ERR(st->sync_gpio);
> +		goto error_disable_reg;
> +	}
> +
>  	spi_set_drvdata(spi, indio_dev);
>  	st->spi = spi;
>  	st->pdata = pdata;

