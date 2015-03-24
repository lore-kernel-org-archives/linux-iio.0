Return-Path: <mika.westerberg@linux.intel.com>
Date: Tue, 24 Mar 2015 18:55:50 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Robert Dolca <robert.dolca@gmail.com>,
	Robert Dolca <robert.dolca@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Denis CIOCCA <denis.ciocca@st.com>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH] IIO: Adds ACPI support for ST gyroscopes
Message-ID: <20150324165550.GS1878@lahna.fi.intel.com>
References: <1427118025-4380-1-git-send-email-robert.dolca@intel.com>
 <551155C3.2030403@metafoo.de>
 <CAFPB+YdwrPoob1CPdUfSt2uBJWPi=6_0-d0NChj2agD6-z-8qw@mail.gmail.com>
 <551168F0.1090901@metafoo.de>
 <CACRpkdaOQ-onkgQJSyoVEQNtkZ9nF_4z=9jNdU-tug-TwvAAkQ@mail.gmail.com>
 <20150324150630.GP1878@lahna.fi.intel.com>
 <55118128.10402@metafoo.de>
 <20150324155515.GR1878@lahna.fi.intel.com>
 <55119429.6070806@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55119429.6070806@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Mar 24, 2015 at 05:43:21PM +0100, Lars-Peter Clausen wrote:
> On 03/24/2015 04:55 PM, Mika Westerberg wrote:
> >On Tue, Mar 24, 2015 at 04:22:16PM +0100, Lars-Peter Clausen wrote:
> >>Add Alexandre and linux-gpio to Cc.
> >>
> >>On 03/24/2015 04:06 PM, Mika Westerberg wrote:
> >>>On Tue, Mar 24, 2015 at 02:57:49PM +0100, Linus Walleij wrote:
> >>>>On Tue, Mar 24, 2015 at 2:38 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> >>>>>On 03/24/2015 02:26 PM, Robert Dolca wrote:
> >>>>>>On Tue, Mar 24, 2015 at 2:17 PM, Lars-Peter Clausen <lars@metafoo.de>
> >>>>>>wrote:
> >>>>
> >>>>>>In the ACPI description you specify one or more IRQ GPIO pins. In the
> >>>>>>driver you request the GPIO pin using the index. In the ACPI 5.1
> >>>>>>specification you can use named GPIOs instead of index.
> >>>>>
> >>>>>
> >>>>>But is there a way to distinguish between IRQ GPIOs and non IRQ GPIOs? If it
> >>>>>is clear that a certain GPIO is the IRQ for the device the I2C framework
> >>>>>should take care of assigning the client->irq field, instead of doing it
> >>>>>manually in each and every device driver.
> >>>>
> >>>>In the device tree case we have a mechanism where each
> >>>>GPIO chip implements two API:s, one gpio_chip API and
> >>>>one irqchip API.
> >>>>
> >>>>Then in the tree both the GPIO and IRQs can be assigned as
> >>>>resources to clients, orthogonally. Usually this will only work
> >>>>if there is a 1-to-1 correspondence between the GPIO lines
> >>>>and available IRQ line triggers on the GPIO chip, but that is
> >>>>indeed the most common. They will then usually also have
> >>>>the same line offset numbers. In some odd cases I guess it
> >>>>won't work this way.
> >>>>
> >>>>The I2C subsystem does this for the device tree case in
> >>>>i2c_device_probe() like this:
> >>>>
> >>>>  if (!client->irq && dev->of_node) {
> >>>>                 int irq = of_irq_get(dev->of_node, 0);
> >>>>
> >>>>                 if (irq == -EPROBE_DEFER)
> >>>>                         return irq;
> >>>>                 if (irq < 0)
> >>>>                         irq = 0;
> >>>>
> >>>>                 client->irq = irq;
> >>>>         }
> >>>>
> >>>>This is why the code does not contain any OF/DT
> >>>>IRQ assignment code.
> >>>>
> >>>>However in the ACPI probe path I guess it doesn't
> >>>>happen then?
> >>>
> >>>In ACPI we have two kind of GPIOs: GpioIo and GpioInt. The latter is
> >>>used to describe GPIOs that can be used as interrupts.
> >>>
> >>>In order to translate a GpioInt to an interrupt number we would need to
> >>>request the GPIO first here (in the I2C core), call gpiod_to_irq() to it
> >>>and assign that to the client->irq.
> >>
> >>Maybe the API can be extended to support to translate a GPIO to a IRQ
> >>without actually requesting the GPIO first.
> >
> >We still need to take care the the GPIO is properly requested and locked
> >as IRQ. Otherwise something else (userspace for example) can mess this
> >up.
> >
> >>>
> >>>This has few problems that I have not yet figured out. Maybe someone
> >>>here can suggest what to do:
> >>>
> >>>  1) Who is responsible in releasing the GPIO?
> >>>  2) What if the driver wants to use that pin as a GPIO instead? The GPIO
> >>>     is already requested by the I2C core.
> >>>  3) We may have multiple GpioInts for devices like GPIO button array.
> >>>     Which one we should pick, or should we let the driver to handle this
> >>>     separetely?
> >>
> >>Well, we have the same issue with devicetree already. I'd say use the first
> >>IRQ for client->irq and ignore the other ones for now.
> >
> >For devices like the button array above doing that leaves the driver
> >wondering where the heck is one of my GPIOs :-) Perhaps we could to
> >automatic translation if we find out that there is only one GpioInt for
> >this device.
> 
> Btw. in the ACPI case client->irq is already initialized by
> acpi_dev_resource_interrupt() in the I2C core. Should the GpioInts just map
> onto this API as well?

Yes, that's the place where we could assign the interrupt number. Given
that we can solve the above problems.
