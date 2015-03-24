Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <551168F0.1090901@metafoo.de>
References: <1427118025-4380-1-git-send-email-robert.dolca@intel.com>
	<551155C3.2030403@metafoo.de>
	<CAFPB+YdwrPoob1CPdUfSt2uBJWPi=6_0-d0NChj2agD6-z-8qw@mail.gmail.com>
	<551168F0.1090901@metafoo.de>
Date: Tue, 24 Mar 2015 14:57:49 +0100
Message-ID: <CACRpkdaOQ-onkgQJSyoVEQNtkZ9nF_4z=9jNdU-tug-TwvAAkQ@mail.gmail.com>
Subject: Re: [PATCH] IIO: Adds ACPI support for ST gyroscopes
From: Linus Walleij <linus.walleij@linaro.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Robert Dolca <robert.dolca@gmail.com>, Robert Dolca <robert.dolca@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, Denis CIOCCA <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Mar 24, 2015 at 2:38 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 03/24/2015 02:26 PM, Robert Dolca wrote:
>> On Tue, Mar 24, 2015 at 2:17 PM, Lars-Peter Clausen <lars@metafoo.de>
>> wrote:

>> In the ACPI description you specify one or more IRQ GPIO pins. In the
>> driver you request the GPIO pin using the index. In the ACPI 5.1
>> specification you can use named GPIOs instead of index.
>
>
> But is there a way to distinguish between IRQ GPIOs and non IRQ GPIOs? If it
> is clear that a certain GPIO is the IRQ for the device the I2C framework
> should take care of assigning the client->irq field, instead of doing it
> manually in each and every device driver.

In the device tree case we have a mechanism where each
GPIO chip implements two API:s, one gpio_chip API and
one irqchip API.

Then in the tree both the GPIO and IRQs can be assigned as
resources to clients, orthogonally. Usually this will only work
if there is a 1-to-1 correspondence between the GPIO lines
and available IRQ line triggers on the GPIO chip, but that is
indeed the most common. They will then usually also have
the same line offset numbers. In some odd cases I guess it
won't work this way.

The I2C subsystem does this for the device tree case in
i2c_device_probe() like this:

 if (!client->irq && dev->of_node) {
                int irq = of_irq_get(dev->of_node, 0);

                if (irq == -EPROBE_DEFER)
                        return irq;
                if (irq < 0)
                        irq = 0;

                client->irq = irq;
        }

This is why the code does not contain any OF/DT
IRQ assignment code.

However in the ACPI probe path I guess it doesn't
happen then?

Yours,
Linus Walleij
