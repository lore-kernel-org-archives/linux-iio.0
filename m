Return-Path: <SRS0=50oW=CI=linux.intel.com=andriy.shevchenko@kernel.org>
Message-ID: <1510337603.25007.139.camel@linux.intel.com>
Subject: Re: [PATCH v3 3/5] iio: proximity: sx9500: Set IRQ pin to
 direction-input if necessary
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Walleij <linus.walleij@linaro.org>, Mika Westerberg
	 <mika.westerberg@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Jonathan Cameron
 <jic23@kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>,  Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter
 Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Date: Fri, 10 Nov 2017 20:13:23 +0200
In-Reply-To: <CACRpkdZkopuQ2KwNxQyj-KfDawjrhgFVt_2L0-EjJMrMHCXdDw@mail.gmail.com>
References: <20171103130340.42459-1-andriy.shevchenko@linux.intel.com>
	 <20171103130340.42459-3-andriy.shevchenko@linux.intel.com>
	 <20171104032059.0000049a@huawei.com>
	 <1510158946.25007.112.camel@linux.intel.com>
	 <20171108170357.GN18997@lahna.fi.intel.com>
	 <CACRpkdZkopuQ2KwNxQyj-KfDawjrhgFVt_2L0-EjJMrMHCXdDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Wed, 2017-11-08 at 21:45 +0100, Linus Walleij wrote:
> On Wed, Nov 8, 2017 at 6:03 PM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > On Wed, Nov 08, 2017 at 06:35:46PM +0200, Andy Shevchenko wrote:
> > > +Cc: Mika

> > One idea is to allow this strict mode to be relaxed by drivers
> > perhaps
> > by passing quirks through struct acpi_gpio_mapping:
> > 
> > static const struct acpi_gpio_mapping acpi_foo_gpios[] = {
> >         /*
> >          * This platform has a bug in ACPI GPIO description making
> > IRQ
> >          * GPIO to be output only. Ask the GPIO core to ignore this
> >          * limit.
> >          */
> >         { "foobar-gpios", &foobar_gpios, 1,
> > ACPI_QUIRK_IGNORE_IO_RESTRICTION },
> >         {},
> > };
> > 
> > or something like that. Not sure if I missed something obvious,
> > though.
> 
> This looks like an elegant solution to me.
> 
> Can it be done?

I have sent today a series against GPIO ACPI library to support quirks
in general.

P.S. Just realized I forgot to put Suggested-by tag there.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
