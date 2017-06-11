Return-Path: <SRS0=o5fX=5Q=linux.intel.com=andriy.shevchenko@kernel.org>
Message-ID: <1497191154.22624.107.camel@linux.intel.com>
Subject: Re: [PATCH v1] iio: accel: mma9551: use NULL for GPIO connection ID
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter
 Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 11 Jun 2017 17:25:54 +0300
In-Reply-To: <20170611114610.62fac902@kernel.org>
References: <20170610185841.49911-1-andriy.shevchenko@linux.intel.com>
	 <20170611114610.62fac902@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Sun, 2017-06-11 at 11:46 +0100, Jonathan Cameron wrote:
> On Sat, 10 Jun 2017 21:58:41 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > While using GPIO library API we might get into troubles in the
> > future,
> > because we can't rely on label name in the driver since vendor
> > firmware
> > might provide any GPIO pin there, e.g. "reset", and even mark it in
> > _DSD
> > (in which case the request will fail).
> > 
> > To avoid inconsistency and potential issues we have two options:
> > a) generate GPIO ACPI mapping table and supply it via
> > acpi_dev_add_driver_gpios(), or
> > b) just pass NULL as connection ID.
> > 
> > The b) approach is much simpler and would work since the driver
> > relies
> > on GPIO indices only. Moreover, the _CRS fallback mechanism, when
> > requesting GPIO, is going to be stricter, and supplying non-NULL
> > connection ID when neither _DSD, nor GPIO ACPI mapping is present,
> > will
> > make request fail.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Hi Andy,
> 
> A bit of googling suggests that this is one of a number of similar
> patches.
> I'd have appreciated some cross references in here as otherwise it
> seems
> to have come out of nowhere. 

I think the best is to read a documentation portion patch from here:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/co
mmit/?h=for-next&id=ed7fcf1ed5ea4ea01243995ae085757a77cf0f3e

> 
> Also, I'd be happier with an Ack from Linus Walleij on a change like
> this to confirm the method (a reference to him saying it was fine
> elsewhere would be fine as well!)
> 
> Anyhow I've cc'd Linus in the meantime.

Sure.

> 
> Thanks,
> 
> Jonathan
> > ---
> >  drivers/iio/accel/mma9551.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/mma9551.c
> > b/drivers/iio/accel/mma9551.c
> > index bf2704435629..1f53f08476f5 100644
> > --- a/drivers/iio/accel/mma9551.c
> > +++ b/drivers/iio/accel/mma9551.c
> > @@ -27,7 +27,6 @@
> >  
> >  #define MMA9551_DRV_NAME		"mma9551"
> >  #define MMA9551_IRQ_NAME		"mma9551_event"
> > -#define MMA9551_GPIO_NAME		"mma9551_int"
> >  #define MMA9551_GPIO_COUNT		4
> >  
> >  /* Tilt application (inclination in IIO terms). */
> > @@ -418,8 +417,7 @@ static int mma9551_gpio_probe(struct iio_dev
> > *indio_dev)
> >  	struct device *dev = &data->client->dev;
> >  
> >  	for (i = 0; i < MMA9551_GPIO_COUNT; i++) {
> > -		gpio = devm_gpiod_get_index(dev, MMA9551_GPIO_NAME,
> > i,
> > -					    GPIOD_IN);
> > +		gpio = devm_gpiod_get_index(dev, NULL, i,
> > GPIOD_IN);
> >  		if (IS_ERR(gpio)) {
> >  			dev_err(dev, "acpi gpio get index
> > failed\n");
> >  			return PTR_ERR(gpio);
> 
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
