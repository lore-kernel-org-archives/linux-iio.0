Return-Path: <SRS0=OiQd=CC=huawei.com=jonathan.cameron@kernel.org>
Date: Sat, 4 Nov 2017 03:11:19 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        "Hartmut Knaack" <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        <linux-acpi@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        Mika Westerberg
	<mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3 1/5] iio: proximity: sx9500: Assign interrupt from
 GpioIo()
Message-ID: <20171104031119.00006e56@huawei.com>
In-Reply-To: <20171103130340.42459-1-andriy.shevchenko@linux.intel.com>
References: <20171103130340.42459-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-ID: <linux-iio@vger.kernel.org>

On Fri, 3 Nov 2017 15:03:36 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> The commit 0f0796509c07
> 
> ("iio: remove gpio interrupt probing from drivers that use a single
> interrupt")
> 
> removed custom IRQ assignment for the drivers which are enumerated via
> ACPI or OF. Unfortunately, some ACPI tables have IRQ line defined as
> GpioIo() resource and thus automatic IRQ allocation will fail.

I'll ask the obvious question - is this allowed under the ACPI spec?

> 
> Partially revert the commit 0f0796509c07 to restore original
> behaviour.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I really don't like scattering fixes for broken ACPI tables through
drivers...  Is there really no better solution to this?

On patches like this best to pull in ACPI and GPIO on the cc list.

Also cc'd Mika who made the original change to support gpioint.



Jonathan

> ---
>  drivers/iio/proximity/sx9500.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iio/proximity/sx9500.c
> b/drivers/iio/proximity/sx9500.c index 53c5d653e780..df23dbcc030a
> 100644 --- a/drivers/iio/proximity/sx9500.c
> +++ b/drivers/iio/proximity/sx9500.c
> @@ -869,6 +869,7 @@ static int sx9500_init_device(struct iio_dev
> *indio_dev) static void sx9500_gpio_probe(struct i2c_client *client,
>  			      struct sx9500_data *data)
>  {
> +	struct gpio_desc *gpiod_int;
>  	struct device *dev;
>  
>  	if (!client)
> @@ -876,6 +877,14 @@ static void sx9500_gpio_probe(struct i2c_client
> *client, 
>  	dev = &client->dev;
>  
> +	if (client->irq <= 0) {
> +		gpiod_int = devm_gpiod_get(dev, SX9500_GPIO_INT,
> GPIOD_IN);
> +		if (IS_ERR(gpiod_int))
> +			dev_err(dev, "gpio get irq failed\n");
> +		else
> +			client->irq = gpiod_to_irq(gpiod_int);
> +	}
> +
>  	data->gpiod_rst = devm_gpiod_get(dev, SX9500_GPIO_RESET,
> GPIOD_OUT_HIGH); if (IS_ERR(data->gpiod_rst)) {
>  		dev_warn(dev, "gpio get reset pin failed\n");
