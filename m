Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:50818 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750969AbeBZTvo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Feb 2018 14:51:44 -0500
Message-ID: <1519674701.10722.198.camel@linux.intel.com>
Subject: Re: [PATCH v3 3/5] iio: proximity: sx9500: Set IRQ pin to
 direction-input if necessary
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 26 Feb 2018 21:51:41 +0200
In-Reply-To: <20171108170357.GN18997@lahna.fi.intel.com>
References: <20171103130340.42459-1-andriy.shevchenko@linux.intel.com>
         <20171103130340.42459-3-andriy.shevchenko@linux.intel.com>
         <20171104032059.0000049a@huawei.com>
         <1510158946.25007.112.camel@linux.intel.com>
         <20171108170357.GN18997@lahna.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 2017-11-08 at 19:03 +0200, Mika Westerberg wrote:
> On Wed, Nov 08, 2017 at 06:35:46PM +0200, Andy Shevchenko wrote:
> > +Cc: Mika
> > 
> > On Sat, 2017-11-04 at 03:20 +0000, Jonathan Cameron wrote:
> > > On Fri, 3 Nov 2017 15:03:38 +0200
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > 
> > > > With the new more strict ACPI gpio code the DSDT's IoRestriction
> > > > flags
> > > > are honored on gpiod_get(), but in some DSDT's it is wrong, so
> > > > explicitly call gpiod_direction_input() on the IRQ GPIO if
> > > > necessary.
> > > > 
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.co
> > > > m>
> > > 
> > > Again, I really really don't like filling driver code with fixes
> > > for broken firmware.  I appreciate we have to cope with this, but
> > > it does rather seem like this should be moved into the core code
> > > for say gpiod_get_irq.
> > 
> > I would love to fix in general, though it looks not so trivial:
> > 
> > - gpiod_get() doesn't know if GPIO is going to be used as IRQ
> > - gpiod_to_irq() doesn't know if descriptor in question comes from
> > GpioIo() ACPI resource
> 
> One idea is to allow this strict mode to be relaxed by drivers perhaps
> by passing quirks through struct acpi_gpio_mapping:
> 
> static const struct acpi_gpio_mapping acpi_foo_gpios[] = {
> 	/*
> 	 * This platform has a bug in ACPI GPIO description making IRQ
> 	 * GPIO to be output only. Ask the GPIO core to ignore this
> 	 * limit.
> 	 */
> 	{ "foobar-gpios", &foobar_gpios, 1,
> ACPI_QUIRK_IGNORE_IO_RESTRICTION },
> 	{},
> };
> 
> or something like that. Not sure if I missed something obvious,
> though.

Patch is sent, though I forgot to add you to Cc list.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
