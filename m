Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58609 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753928AbdBDLjn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Feb 2017 06:39:43 -0500
Subject: Re: [PATCH v2 4/5] iio: trigger: add support for STM32 EXTI triggers
To: Linus Walleij <linus.walleij@linaro.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
References: <1485786840-4557-1-git-send-email-fabrice.gasnier@st.com>
 <1485786840-4557-5-git-send-email-fabrice.gasnier@st.com>
 <CACRpkdZeiFYFdRWCEgYWDWh4Wn2gT29KAFao9mgj7sTi768kFQ@mail.gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1236cee4-41bf-b3b9-51e4-7e585234b0c7@kernel.org>
Date: Sat, 4 Feb 2017 11:39:36 +0000
MIME-Version: 1.0
In-Reply-To: <CACRpkdZeiFYFdRWCEgYWDWh4Wn2gT29KAFao9mgj7sTi768kFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/02/17 19:40, Linus Walleij wrote:
> On Mon, Jan 30, 2017 at 3:33 PM, Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
> 
>> EXTi[0..15] gpio signal can be routed internally as trigger source for
>> ADC or DAC conversions. Configure them as interrupts to configure
>> trigger path in HW.
>>
>> Note: interrupt handler isn't required here, and corresponding interrupt
>> can be kept masked at exti controller level.
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> 
> But I see nothing STM32-specific about this driver?
> 
> I think we should do everone a service and just create
> drivers/iio/trigger/gpio-trigger.c
> 
> I wondered before why we don't have a generic GPIO IIO trigger,
> it seems like such an intuitive and useful thing to have.
We do, it just got renamed at some point a while back to be
iio-trig-interrupt after it became clear that it didn't need
to be a gpio either - just an interrupt.  Can't remember which
part provided a non gpio interrupt pin and hence drove that
change.  Was quite a while back!
d4fd73bf25c3aafc891ef4443fc744d427ec1df0 specifically in 2013

Handling of the gpio stuff should be handled in the interrupt
description itself.

However, it's a bit different - in that in the below it
would be the equivalent of triggering on the unused exti
interrupt rather than on the end of conversion.

In this case, because of the hardware linkage we can effectively
skip the first interrupt.

Arguably to make this a general purpose trigger we should enable
that interrupt if anything other than the STM devices that can
use it in hardware are hooked on to it.

So this is an interrupt trigger without the interrupt ever
being visible to software.

It might be easy enough to add that support to the generic version
except that linking said trigger requires some register changes
in the STM side. + there is a kicker in the various last bit
of this patch - we need a way to find out if it's the interrupt
we think it is (i.e. an exti interrupt)
> 
> Let's see what Jonathan says.


> 
>> +config IIO_STM32_EXTI_TRIGGER
>> +       tristate "STM32 EXTI Trigger"
>> +       depends on (ARCH_STM32 && OF) || COMPILE_TEST
> 
> config IIO_GPIO_TRIGGER
>     depends on GPIOLIB
> 
>> +       select STM32_EXTI
> 
> Isn't the dependency actually the other way around?
> 
> default STM32_EXTI makes more sense, or just put it into the
> defconfig.
> 
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/trigger.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +
>> +/* STM32 has up to 16 EXTI triggers on GPIOs */
>> +#define STM32_MAX_EXTI_TRIGGER 16
> 
> Just don't put any restrictions like this so it can be widely
> reused.
> 
>> +static irqreturn_t stm32_exti_trigger_handler(int irq, void *data)
>> +{
>> +       /* Exti handler shouldn't be invoked, and isn't used */
>> +       return IRQ_HANDLED;
>> +}
> 
> It could be a good idea to capture the timestamp here if we were
> actually using this IRQ.
> 
>> +static int stm32_exti_trigger_probe(struct platform_device *pdev)
>> +{
>> +       int irq, ret;
>> +       char name[8];
>> +       struct gpio_desc *gpio;
>> +       struct iio_trigger *trig;
>> +       unsigned int i;
>> +
>> +       for (i = 0; i < STM32_MAX_EXTI_TRIGGER; i++) {
> 
> Why not just run this until devm_gpiod_get() returns -ERRNO
> or something?
> 
>> +               snprintf(name, sizeof(name), "exti%d", i);
>> +
>> +               gpio = devm_gpiod_get_optional(&pdev->dev, name, GPIOD_IN);
> 
> Why would it be optional?
> 
> Either it is there in the device tree or we get -EINVAL or something
> if there is no
> such index in the device tree. We can get -EPROBE_DEEER too, and then
> we should exit silently or just print that deferring is happening.
> 
>> +               if (IS_ERR_OR_NULL(gpio)) {
>> +                       if (IS_ERR(gpio)) {
>> +                               dev_err(&pdev->dev, "gpio %s get error %ld\n",
>> +                                       name, PTR_ERR(gpio));
>> +                               return PTR_ERR(gpio);
>> +                       }
>> +                       dev_dbg(&pdev->dev, "No %s gpio\n", name);
>> +                       continue;
>> +               }
> 
> Good
> 
>> +               irq = gpiod_to_irq(gpio);
>> +               if (irq < 0) {
>> +                       dev_err(&pdev->dev, "gpio %d to irq failed\n", i);
>> +                       return irq;
>> +               }
>> +
>> +               ret = devm_request_irq(&pdev->dev, irq,
>> +                                      stm32_exti_trigger_handler,
>> +                                      0, dev_name(&pdev->dev), pdev);
Hmm. So this is a trick to set the interrupt mapping up inside the device.
The whole thing doesn't really exist.

Rather feels like there ought to be some generic interface for
'I want to pretend I want a particular interrupt but not actually get one'.

But that would only work in this weird case where there is also a real interrupt
associated with it - just one we elect not to use.
>> +               if (ret) {
>> +                       dev_err(&pdev->dev, "request IRQ %d failed\n", irq);
>> +                       return ret;
>> +               }
> 
> Here you need some elaborate trigger edge handling.
> 
> The flags that you define as "0" here, how do we say that we
> want to handle rising or falling edges, for example?
> 
> I think you might want to establish these DT properties for
> GPIO triggers:
> 
> gpio-trigger-rising-edge;
> gpio-trigger-falling-edge;
> 
> Then:
> 
> int irq_flags = 0;
> 
> if (of_property_read_bool(np, "gpio-trigger-rising-edge")
>    irq_flags |= IRQF_TRIGGER_RISING;
> else if (of_property_read_bool(np, "gpio-trigger-falling-edge")
>    irq_flags |= IRQF_TRIGGER_FALLING;
Should this not all be part of the interrupt specification rather
than down here in the specific driver?
> 
> To pass along to the devm_request_irq() function as flags.
> 
> I find it weird that it even works without. Most GPIO interrupts
> should require you to set a trigger type. But I guess it is because
> of the other weirdness you describe below.
> 
>> +               /*
>> +                * gpios are configured as interrupts, so exti trigger path is
>> +                * configured in HW, and can now be used as external trigger
>> +                * source by other IPs. But getting interrupts when trigger
>> +                * occurs is unused here, so mask irq on exti controller by
>> +                * default.
>> +                */
>> +               disable_irq(irq);
> 
> Aha. That is not generic. But what about just adding:
> 
> if (of_property_read_bool(np, "gpio-trigger-numb-irq")
>     disable_irq();
> 
> (Plus add the binding for that something like "this makes the
> GPIO mentioned get requested, translated to an IRQ, get the
> IRQ requested, and then immediately just disabled as other
> hardware will actually hande the IRQ line".)
> 
> I understand that this is kind of weird: we're making a whole generic
> GPIO trigger driver just to use it with hardware that grabs and disabled
> the irq immediately.
> 
> But I think that in the long run it makes for more reusable code.
I'd go a step further.  Whether it is numbed or not will depend on what
is downstream.  We should be providing this interrupt like normal if
we have other devices triggering off it.  In that case it becomes a standard
interrupt trigger.

Polling off the back of the dataready interrupt is fine if there is nothing
earlier available. Here there is so we should really be triggering other
devices off this earlier interrupt.
> 
>> +static const struct of_device_id stm32_exti_trigger_of_match[] = {
>> +       { .compatible = "st,stm32-exti-trigger" },
>> +       {},
> 
> "iio-gpio-trigger"
> 
> Should fit anyone, given the above amendments.
> 
>> +#if IS_ENABLED(CONFIG_IIO_STM32_EXTI_TRIGGER)
>> +bool is_stm32_exti_trigger(struct iio_trigger *trig);
>> +#else
>> +static inline bool is_stm32_exti_trigger(struct iio_trigger *trig)
>> +{
>> +       return false;
>> +}
>> +#endif
> 
> This seems unnecessary to broadcast to the entire kernel.
This one section is the only really non generic element that
isn't supported by the existing interrupt trigger.
Mind you that doesn't have device tree bindings yet :(

I wonder if we can add some sort of flag in there to identify hardware
blocks for tricks like this. Or at a push provide the interrupt
to both bits of kit so they can compare and see if they are looking
at the same one?
> 
> Why? (Maybe I can find explanations in later patches.
> 
> Yours,
> Linus Walleij
> 

