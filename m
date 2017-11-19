Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750831AbdKSP3j (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Nov 2017 10:29:39 -0500
Date: Sun, 19 Nov 2017 15:29:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-iio@vger.kernel.org>, "Hartmut Knaack" <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-acpi@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3 2/5] iio: proximity: sx9500: Add GPIO ACPI mapping
 table
Message-ID: <20171119152934.66a481c0@archlinux>
In-Reply-To: <20171104031403.000073b0@huawei.com>
References: <20171103130340.42459-1-andriy.shevchenko@linux.intel.com>
        <20171103130340.42459-2-andriy.shevchenko@linux.intel.com>
        <20171104031403.000073b0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 4 Nov 2017 03:14:27 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Fri, 3 Nov 2017 15:03:37 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > In order to satisfy GPIO ACPI library requirements convert users of
> > gpiod_get_index() to correctly behave when there no mapping is
> > provided by firmware.
> > 
> > Here we add explicit mapping between _CRS GpioIo() resources and
> > their names used in the driver.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> 
> Added cc's as for previous patch.  I guess this makes sense if we
> accept that fixes like the previous one should be in drivers at all.
> 
> If not the reset part still makes sense I suppose.
So, what this description is missing:
* Is this a fix for known problem?
* If so please add a fixes tag.
* If it is because we now have platforms that need this then say that.

I have no idea on the urgency of this patch from the description.

Jonathan
> 
> > ---
> >  drivers/iio/proximity/sx9500.c | 21 ++++++++++++++++-----
> >  1 file changed, 16 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iio/proximity/sx9500.c
> > b/drivers/iio/proximity/sx9500.c index df23dbcc030a..eb687b3dd442
> > 100644 --- a/drivers/iio/proximity/sx9500.c
> > +++ b/drivers/iio/proximity/sx9500.c
> > @@ -32,9 +32,6 @@
> >  #define SX9500_DRIVER_NAME		"sx9500"
> >  #define SX9500_IRQ_NAME			"sx9500_event"
> >  
> > -#define SX9500_GPIO_INT			"interrupt"
> > -#define SX9500_GPIO_RESET		"reset"
> > -
> >  /* Register definitions. */
> >  #define SX9500_REG_IRQ_SRC		0x00
> >  #define SX9500_REG_STAT			0x01
> > @@ -866,26 +863,40 @@ static int sx9500_init_device(struct iio_dev
> > *indio_dev) return sx9500_init_compensation(indio_dev);
> >  }
> >  
> > +static const struct acpi_gpio_params reset_gpios = { 0, 0, false };
> > +static const struct acpi_gpio_params interrupt_gpios = { 2, 0,
> > false }; +
> > +static const struct acpi_gpio_mapping acpi_sx9500_gpios[] = {
> > +	{ "reset-gpios", &reset_gpios, 1 },
> > +	{ "interrupt-gpios", &interrupt_gpios, 1 },
> > +	{ },
> > +};
> > +
> >  static void sx9500_gpio_probe(struct i2c_client *client,
> >  			      struct sx9500_data *data)
> >  {
> >  	struct gpio_desc *gpiod_int;
> >  	struct device *dev;
> > +	int ret;
> >  
> >  	if (!client)
> >  		return;
> >  
> >  	dev = &client->dev;
> >  
> > +	ret = devm_acpi_dev_add_driver_gpios(dev, acpi_sx9500_gpios);
> > +	if (ret)
> > +		dev_dbg(dev, "Unable to add GPIO mapping table\n");
> > +
> >  	if (client->irq <= 0) {
> > -		gpiod_int = devm_gpiod_get(dev, SX9500_GPIO_INT,
> > GPIOD_IN);
> > +		gpiod_int = devm_gpiod_get(dev, "interrupt",
> > GPIOD_IN); if (IS_ERR(gpiod_int))
> >  			dev_err(dev, "gpio get irq failed\n");
> >  		else
> >  			client->irq = gpiod_to_irq(gpiod_int);
> >  	}
> >  
> > -	data->gpiod_rst = devm_gpiod_get(dev, SX9500_GPIO_RESET,
> > GPIOD_OUT_HIGH);
> > +	data->gpiod_rst = devm_gpiod_get(dev, "reset",
> > GPIOD_OUT_HIGH); if (IS_ERR(data->gpiod_rst)) {
> >  		dev_warn(dev, "gpio get reset pin failed\n");
> >  		data->gpiod_rst = NULL;  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

