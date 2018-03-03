Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751923AbeCCPNi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Mar 2018 10:13:38 -0500
Date: Sat, 3 Mar 2018 15:13:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1] iio: proximity: sx9500: Add GPIO ACPI mapping table
Message-ID: <20180303151334.60cc00bd@archlinux>
In-Reply-To: <20180226193735.70308-1-andriy.shevchenko@linux.intel.com>
References: <20180226193735.70308-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 26 Feb 2018 21:37:35 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> In order to satisfy GPIO ACPI library requirements convert users of
> gpiod_get_index() to correctly behave when there no mapping is provided
> by firmware.
> 
> Here we add explicit mapping between _CRS GpioIo() resources and
> their names used in the driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
I've applied this one to the togreg tree for the next merge window
(pushed out as testing for the autobuilders to play with it).

If people want support back ported after the merge window I'm
happy to support a stable request for this.

When making this judgement it might have been useful to know
what platforms are effected and how common they are.

Thanks,

Jonathan

> ---
>  drivers/iio/proximity/sx9500.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
> index b8a2c2c8cac5..ff80409e0c44 100644
> --- a/drivers/iio/proximity/sx9500.c
> +++ b/drivers/iio/proximity/sx9500.c
> @@ -32,9 +32,6 @@
>  #define SX9500_DRIVER_NAME		"sx9500"
>  #define SX9500_IRQ_NAME			"sx9500_event"
>  
> -#define SX9500_GPIO_INT			"interrupt"
> -#define SX9500_GPIO_RESET		"reset"
> -
>  /* Register definitions. */
>  #define SX9500_REG_IRQ_SRC		0x00
>  #define SX9500_REG_STAT			0x01
> @@ -866,26 +863,44 @@ static int sx9500_init_device(struct iio_dev *indio_dev)
>  	return sx9500_init_compensation(indio_dev);
>  }
>  
> +static const struct acpi_gpio_params reset_gpios = { 0, 0, false };
> +static const struct acpi_gpio_params interrupt_gpios = { 2, 0, false };
> +
> +static const struct acpi_gpio_mapping acpi_sx9500_gpios[] = {
> +	{ "reset-gpios", &reset_gpios, 1 },
> +	/*
> +	 * Some platforms have a bug in ACPI GPIO description making IRQ
> +	 * GPIO to be output only. Ask the GPIO core to ignore this limit.
> +	 */
> +	{ "interrupt-gpios", &interrupt_gpios, 1, ACPI_GPIO_QUIRK_NO_IO_RESTRICTION },
> +	{ },
> +};
> +
>  static void sx9500_gpio_probe(struct i2c_client *client,
>  			      struct sx9500_data *data)
>  {
>  	struct gpio_desc *gpiod_int;
>  	struct device *dev;
> +	int ret;
>  
>  	if (!client)
>  		return;
>  
>  	dev = &client->dev;
>  
> +	ret = devm_acpi_dev_add_driver_gpios(dev, acpi_sx9500_gpios);
> +	if (ret)
> +		dev_dbg(dev, "Unable to add GPIO mapping table\n");
> +
>  	if (client->irq <= 0) {
> -		gpiod_int = devm_gpiod_get(dev, SX9500_GPIO_INT, GPIOD_IN);
> +		gpiod_int = devm_gpiod_get(dev, "interrupt", GPIOD_IN);
>  		if (IS_ERR(gpiod_int))
>  			dev_err(dev, "gpio get irq failed\n");
>  		else
>  			client->irq = gpiod_to_irq(gpiod_int);
>  	}
>  
> -	data->gpiod_rst = devm_gpiod_get(dev, SX9500_GPIO_RESET, GPIOD_OUT_HIGH);
> +	data->gpiod_rst = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
>  	if (IS_ERR(data->gpiod_rst)) {
>  		dev_warn(dev, "gpio get reset pin failed\n");
>  		data->gpiod_rst = NULL;

