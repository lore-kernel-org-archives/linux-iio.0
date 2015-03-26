Return-Path: <jic23@jic23.retrosnub.co.uk>
In-Reply-To: <CAE1zot+67M96HbMnorYxEd06r=Aew=x830sCXoovBCCy_YMF7w@mail.gmail.com>
References: <20150324150630.GP1878@lahna.fi.intel.com> <CACRpkdYmN5YnH5rcA13NerPKdx62TpQVi5Hwr1vchu13QUcaOw@mail.gmail.com> <20150325094327.GW1878@lahna.fi.intel.com> <20150325122505.GX1878@lahna.fi.intel.com> <20150325132116.GY1878@lahna.fi.intel.com> <CAE1zotJas26oRGdext7V69mNNyaYT3Ds7+Ruhg_kNKBf-Ewoew@mail.gmail.com> <20150326101616.GD1878@lahna.fi.intel.com> <CAE1zotKAJBS2_rnYG9K0DxbvVP9-G4iGm_E+b5jQtHVYjiQwVA@mail.gmail.com> <20150326140430.GM1878@lahna.fi.intel.com> <CAE1zotL0Si3=dGLGPmq0CGhc+tsJwDxY8GYwh8fcHA-1jcBdqA@mail.gmail.com> <20150326144753.GO1878@lahna.fi.intel.com> <CAE1zot+67M96HbMnorYxEd06r=Aew=x830sCXoovBCCy_YMF7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] IIO: Adds ACPI support for ST gyroscopes
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Thu, 26 Mar 2015 18:32:21 +0000
To: Octavian Purdila <octavian.purdila@intel.com>,Mika Westerberg <mika.westerberg@linux.intel.com>
CC: Linus Walleij <linus.walleij@linaro.org>,Lars-Peter Clausen <lars@metafoo.de>,Robert Dolca <robert.dolca@gmail.com>,Robert Dolca <robert.dolca@intel.com>,"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,Jonathan Cameron <jic23@kernel.org>,"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,Hartmut Knaack <knaack.h@gmx.de>,Peter Meerwald <pmeerw@pmeerw.net>,Denis CIOCCA <denis.ciocca@st.com>
Message-ID: <1ACB9AC2-A2CF-4FC9-86BA-B0571D3978A1@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 26 March 2015 15:00:43 GMT+00:00, Octavian Purdila <octavian.purdila@intel.com> wrote:
>On Thu, Mar 26, 2015 at 4:47 PM, Mika Westerberg
><mika.westerberg@linux.intel.com> wrote:
>> On Thu, Mar 26, 2015 at 04:37:39PM +0200, Octavian Purdila wrote:
>>> On Thu, Mar 26, 2015 at 4:04 PM, Mika Westerberg
>>> <mika.westerberg@linux.intel.com> wrote:
>>> > On Thu, Mar 26, 2015 at 02:04:35PM +0200, Octavian Purdila wrote:
>>> >> On Thu, Mar 26, 2015 at 12:16 PM, Mika Westerberg
>>> >> <mika.westerberg@linux.intel.com> wrote:
>>> >> > On Wed, Mar 25, 2015 at 11:12:16PM +0200, Octavian Purdila
>wrote:
>>> >> >> On Wed, Mar 25, 2015 at 3:21 PM, Mika Westerberg
>>> >> >> <mika.westerberg@linux.intel.com> wrote:
>>> >> >> > On Wed, Mar 25, 2015 at 02:25:05PM +0200, Mika Westerberg
>wrote:
>>> >> >> >> I think we can do the same for ACPI GpioInts so that we
>introduce
>>> >> >> >> acpi_gpio_irq_get() that translates from GpioInt to Linux
>IRQ
>>> >> >> >> numberspace. Then we can do something like below in I2C
>core:
>>> >> >> >>
>>> >> >> >>       if (client->irq <= 0) {
>>> >> >> >>               int irq = -ENOENT;
>>> >> >> >>
>>> >> >> >>                 if (dev->of_node)
>>> >> >> >>                         irq = of_irq_get(dev->of_node, 0);
>>> >> >> >>                 else if (ACPI_COMPANION(dev))
>>> >> >> >>                         irq =
>acpi_gpio_irq_get(ACPI_COMPANION(dev), 0);
>>> >> >> >>
>>> >> >> >>               if (irq == -EPROBE_DEFER)
>>> >> >> >>                         return irq;
>>> >> >> >>                 if (irq < 0)
>>> >> >> >>                         irq = 0;
>>> >> >> >>
>>> >> >> >>                 client->irq = irq;
>>> >> >> >>       }
>>> >> >> >>
>>> >> >> >> Now it has the drawback that the first GpioInt will not be
>available to
>>> >> >> >> the driver anymore (as a GPIO since it is locked) but if DT
>already does
>>> >> >> >> the same we should be fine.
>>> >> >> >
>>> >> >> > Below patch should take care of this.
>>> >> >> >
>>> >> >>
>>> >> >> One issue we noticed is that now the gpio request and set
>input
>>> >> >> directions operations are not called anymore. Some gpio
>controller
>>> >> >> drivers (dln2, adnp, lynx_point from quickly browsing the
>code) do not
>>> >> >> explicitly enable the GPIO pin nor set direction to input when
>the
>>> >> >> interrupt is enabled. Depending on hardware this may be an
>issue - it
>>> >> >> is on dln2 for example.
>>> >> >>
>>> >> >> Should the gpio controllers enable and set to input in
>irq_enable,
>>> >> >> irq_bus_sync_unlock, etc.? Or should this be done in gpiolib?
>>> >> >
>>> >> > Good question.
>>> >> >
>>> >> > In general I think that it is assumed that the boot firmware
>configures
>>> >> > the pin upfront. However, we have seen too many times that it
>actually
>>> >> > doesn't happen or it is configured wrong.
>>> >> >
>>> >> > Perhaps we could do this in GPIO core, for example in
>>> >> > gpiochip_irq_reqres/gpiochip_irq_map or so.
>>> >> >
>>> >>
>>> >> That sounds good to me. We tested your patch with the patch below
>and
>>> >> we can now directly use client->irq:
>>> >>
>>> >> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
>>> >> index 568aa2b..9865627 100644
>>> >> --- a/drivers/gpio/gpiolib.c
>>> >> +++ b/drivers/gpio/gpiolib.c
>>> >> @@ -511,6 +511,19 @@ static const struct irq_domain_ops
>gpiochip_domain_ops = {
>>> >>  static int gpiochip_irq_reqres(struct irq_data *d)
>>> >>  {
>>> >>         struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
>>> >> +       int ret;
>>> >> +
>>> >> +       ret = gpiod_request(&chip->desc[d->hwirq], "IRQ");
>>> >> +       if (ret) {
>>> >> +               chip_err(chip, "unable to request %lu for IRQ\n",
>d->hwirq);
>>> >> +               return ret;
>>> >> +       }
>>> >
>>> > What if the driver has already requested the GPIO?
>>> >
>>>
>>> Initially I implemented the above to take that into account, e.g. if
>>> (test_and_set_bit(FLAG_REQUESTED, &desc->flags) ...
>>>
>>> But than I thought that we can't mess up with the GPIO anyway while
>>> the interrupt is in use.
>>
>> That's right but then the above will fail also normal cases. For
>example
>> if the driver gets the irq like:
>>
>>         desc = devm_gpiod_get(dev, ..);
>>         gpiod_direction_input(desc);
>>         irq = gpiod_to_irq(desc);
>>
>>         ret = request_irq(irq, ...)
>>
>> at this point we end up calling gpiochip_irq_reqres() which cannot
>> request the GPIO again and fails.
>>
>
>Good point, let me add back that check then :)
>
>>> One case I missed was if the user wants to read the GPIO while using
>>> it as an interrupt which seems to be possible...
>>
>> While the GPIO is locked as IRQ it cannot be done as far as I can
>tell
>> but you can work it around by calling free_irq() first.
>>
>
>AFAICS you can not set the direction to output but you can still read
>values while the interrupt is active.

That's right. We have recently run into fun with this with some of the weirder buses.
On those we care about tight timing so need interrupts but the pin is used to
 send as well so we go through an elaborate dance of disabling interrupts,
 flipping direction setting the output and then flipping back again.
We used to get away with setting a pin to output with the interrupt enabled :) no longer...
>
>>>
>>> >> +
>>> >> +       ret = gpiod_direction_input(&chip->desc[d->hwirq]);
>>> >> +       if (ret) {
>>> >> +               chip_err(chip, "unable to set HW IRQ %lu as
>input\n", d->hwirq);
>>> >> +               return ret;
>>> >> +       }
>>> >>
>>> >>         if (gpiochip_lock_as_irq(chip, d->hwirq)) {
>>> >>                 chip_err(chip,

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
