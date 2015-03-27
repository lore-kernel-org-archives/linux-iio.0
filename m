Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:48053 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750819AbbC0KGe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 27 Mar 2015 06:06:34 -0400
Date: Fri, 27 Mar 2015 12:06:27 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Robert Dolca <robert.dolca@gmail.com>,
	Robert Dolca <robert.dolca@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Denis CIOCCA <denis.ciocca@st.com>
Subject: Re: [PATCH] IIO: Adds ACPI support for ST gyroscopes
Message-ID: <20150327100627.GW1878@lahna.fi.intel.com>
References: <20150325122505.GX1878@lahna.fi.intel.com>
 <20150325132116.GY1878@lahna.fi.intel.com>
 <CAE1zotJas26oRGdext7V69mNNyaYT3Ds7+Ruhg_kNKBf-Ewoew@mail.gmail.com>
 <20150326101616.GD1878@lahna.fi.intel.com>
 <CAE1zotKAJBS2_rnYG9K0DxbvVP9-G4iGm_E+b5jQtHVYjiQwVA@mail.gmail.com>
 <20150326140430.GM1878@lahna.fi.intel.com>
 <CAE1zotL0Si3=dGLGPmq0CGhc+tsJwDxY8GYwh8fcHA-1jcBdqA@mail.gmail.com>
 <20150326144753.GO1878@lahna.fi.intel.com>
 <CAE1zot+67M96HbMnorYxEd06r=Aew=x830sCXoovBCCy_YMF7w@mail.gmail.com>
 <CAE1zot+MaycNK91yOMLAfdvo=f21S9hts9ufk4krBMJ7PNYogA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE1zot+MaycNK91yOMLAfdvo=f21S9hts9ufk4krBMJ7PNYogA@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Mar 26, 2015 at 06:28:19PM +0200, Octavian Purdila wrote:
> >>> >> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> >>> >> index 568aa2b..9865627 100644
> >>> >> --- a/drivers/gpio/gpiolib.c
> >>> >> +++ b/drivers/gpio/gpiolib.c
> >>> >> @@ -511,6 +511,19 @@ static const struct irq_domain_ops gpiochip_domain_ops = {
> >>> >>  static int gpiochip_irq_reqres(struct irq_data *d)
> >>> >>  {
> >>> >>         struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
> >>> >> +       int ret;
> >>> >> +
> >>> >> +       ret = gpiod_request(&chip->desc[d->hwirq], "IRQ");
> >>> >> +       if (ret) {
> >>> >> +               chip_err(chip, "unable to request %lu for IRQ\n", d->hwirq);
> >>> >> +               return ret;
> >>> >> +       }
> >>> >
> >>> > What if the driver has already requested the GPIO?
> >>> >
> >>>
> >>> Initially I implemented the above to take that into account, e.g. if
> >>> (test_and_set_bit(FLAG_REQUESTED, &desc->flags) ...
> >>>
> >>> But than I thought that we can't mess up with the GPIO anyway while
> >>> the interrupt is in use.
> >>
> >> That's right but then the above will fail also normal cases. For example
> >> if the driver gets the irq like:
> >>
> >>         desc = devm_gpiod_get(dev, ..);
> >>         gpiod_direction_input(desc);
> >>         irq = gpiod_to_irq(desc);
> >>
> >>         ret = request_irq(irq, ...)
> >>
> >> at this point we end up calling gpiochip_irq_reqres() which cannot
> >> request the GPIO again and fails.
> >>
> >
> > Good point, let me add back that check then :)
> >
> 
> I just realized that there is another issue: gpiochip_irq_reqres() is
> called under a spinlock, so we can call gpiod_request() only if the
> gpio controller does not sleep.

Good point.

> For the sleep case I think the GPIO controller needs to do the pin
> enable and set input direction operation in it's irq_bus_sync_unlock.

I wonder how DT handles all this? Is it the boot firmware that sets up
the pins accordingly or is there something we are missing?
