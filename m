Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:5930 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750843AbbCZKQ1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 26 Mar 2015 06:16:27 -0400
Date: Thu, 26 Mar 2015 12:16:16 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Octavian Purdila <octavian.purdila@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Robert Dolca <robert.dolca@gmail.com>,
	Robert Dolca <robert.dolca@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Denis CIOCCA <denis.ciocca@st.com>
Subject: Re: [PATCH] IIO: Adds ACPI support for ST gyroscopes
Message-ID: <20150326101616.GD1878@lahna.fi.intel.com>
References: <551155C3.2030403@metafoo.de>
 <CAFPB+YdwrPoob1CPdUfSt2uBJWPi=6_0-d0NChj2agD6-z-8qw@mail.gmail.com>
 <551168F0.1090901@metafoo.de>
 <CACRpkdaOQ-onkgQJSyoVEQNtkZ9nF_4z=9jNdU-tug-TwvAAkQ@mail.gmail.com>
 <20150324150630.GP1878@lahna.fi.intel.com>
 <CACRpkdYmN5YnH5rcA13NerPKdx62TpQVi5Hwr1vchu13QUcaOw@mail.gmail.com>
 <20150325094327.GW1878@lahna.fi.intel.com>
 <20150325122505.GX1878@lahna.fi.intel.com>
 <20150325132116.GY1878@lahna.fi.intel.com>
 <CAE1zotJas26oRGdext7V69mNNyaYT3Ds7+Ruhg_kNKBf-Ewoew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE1zotJas26oRGdext7V69mNNyaYT3Ds7+Ruhg_kNKBf-Ewoew@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Mar 25, 2015 at 11:12:16PM +0200, Octavian Purdila wrote:
> On Wed, Mar 25, 2015 at 3:21 PM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > On Wed, Mar 25, 2015 at 02:25:05PM +0200, Mika Westerberg wrote:
> >> I think we can do the same for ACPI GpioInts so that we introduce
> >> acpi_gpio_irq_get() that translates from GpioInt to Linux IRQ
> >> numberspace. Then we can do something like below in I2C core:
> >>
> >>       if (client->irq <= 0) {
> >>               int irq = -ENOENT;
> >>
> >>                 if (dev->of_node)
> >>                         irq = of_irq_get(dev->of_node, 0);
> >>                 else if (ACPI_COMPANION(dev))
> >>                         irq = acpi_gpio_irq_get(ACPI_COMPANION(dev), 0);
> >>
> >>               if (irq == -EPROBE_DEFER)
> >>                         return irq;
> >>                 if (irq < 0)
> >>                         irq = 0;
> >>
> >>                 client->irq = irq;
> >>       }
> >>
> >> Now it has the drawback that the first GpioInt will not be available to
> >> the driver anymore (as a GPIO since it is locked) but if DT already does
> >> the same we should be fine.
> >
> > Below patch should take care of this.
> >
> 
> One issue we noticed is that now the gpio request and set input
> directions operations are not called anymore. Some gpio controller
> drivers (dln2, adnp, lynx_point from quickly browsing the code) do not
> explicitly enable the GPIO pin nor set direction to input when the
> interrupt is enabled. Depending on hardware this may be an issue - it
> is on dln2 for example.
> 
> Should the gpio controllers enable and set to input in irq_enable,
> irq_bus_sync_unlock, etc.? Or should this be done in gpiolib?

Good question.

In general I think that it is assumed that the boot firmware configures
the pin upfront. However, we have seen too many times that it actually
doesn't happen or it is configured wrong.

Perhaps we could do this in GPIO core, for example in
gpiochip_irq_reqres/gpiochip_irq_map or so.

Linus?
