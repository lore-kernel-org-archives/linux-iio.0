Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10936 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261AbbCYMZK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 25 Mar 2015 08:25:10 -0400
Date: Wed, 25 Mar 2015 14:25:05 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
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
Message-ID: <20150325122505.GX1878@lahna.fi.intel.com>
References: <1427118025-4380-1-git-send-email-robert.dolca@intel.com>
 <551155C3.2030403@metafoo.de>
 <CAFPB+YdwrPoob1CPdUfSt2uBJWPi=6_0-d0NChj2agD6-z-8qw@mail.gmail.com>
 <551168F0.1090901@metafoo.de>
 <CACRpkdaOQ-onkgQJSyoVEQNtkZ9nF_4z=9jNdU-tug-TwvAAkQ@mail.gmail.com>
 <20150324150630.GP1878@lahna.fi.intel.com>
 <CACRpkdYmN5YnH5rcA13NerPKdx62TpQVi5Hwr1vchu13QUcaOw@mail.gmail.com>
 <20150325094327.GW1878@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150325094327.GW1878@lahna.fi.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Mar 25, 2015 at 11:43:27AM +0200, Mika Westerberg wrote:
> On Wed, Mar 25, 2015 at 09:44:34AM +0100, Linus Walleij wrote:
> > On Tue, Mar 24, 2015 at 4:06 PM, Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > 
> > > This has few problems that I have not yet figured out. Maybe someone
> > > here can suggest what to do:
> > >
> > >  1) Who is responsible in releasing the GPIO?
> > >  2) What if the driver wants to use that pin as a GPIO instead? The GPIO
> > >     is already requested by the I2C core.
> > 
> > In the DT usecase we actually specify that in the DTS file
> > so we don't have the problem. Either the consumer accesses
> > the irqchip API with:
> > 
> > interrupts = <nn nn>;
> > 
> > or it accesses the GPIO API with:
> > 
> > gpios = <nn nn>;
> 
> OK, I see.
> 
> > so in that sense it is clear what is requested. Then the core
> > of course uses gpiochip_lock/unlock_as_irq() to handle the
> > case where bugs make a collision (like if both were specified
> > and both APIs tries to access the same resource).
> 
> Where in the core code gpiochip_lock/unlock_as_irq() is called for
> these? At least of_irq_get() doesn't seem to be doing that. Maybe I'm
> looking at the wrong place.

Answering my own question: of_irq_get() just translates the IRQ number
to the corresponding Linux IRQ number. Then when a driver calls
request_irq() irqchip callbacks for this GPIO controller (or generic
GPIO irqchip helpers) will lock the GPIO as IRQ.

I think we can do the same for ACPI GpioInts so that we introduce
acpi_gpio_irq_get() that translates from GpioInt to Linux IRQ
numberspace. Then we can do something like below in I2C core:

	if (client->irq <= 0) {
		int irq = -ENOENT;

                if (dev->of_node)
                        irq = of_irq_get(dev->of_node, 0);
                else if (ACPI_COMPANION(dev))
                        irq = acpi_gpio_irq_get(ACPI_COMPANION(dev), 0);

		if (irq == -EPROBE_DEFER)
                        return irq;
                if (irq < 0)
                        irq = 0;

                client->irq = irq;
	}

Now it has the drawback that the first GpioInt will not be available to
the driver anymore (as a GPIO since it is locked) but if DT already does
the same we should be fine.
