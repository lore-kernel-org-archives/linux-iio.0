Return-Path: <SRS0=z42r=ZQ=linaro.org=linus.walleij@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1485786840-4557-5-git-send-email-fabrice.gasnier@st.com>
References: <1485786840-4557-1-git-send-email-fabrice.gasnier@st.com> <1485786840-4557-5-git-send-email-fabrice.gasnier@st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 3 Feb 2017 20:40:57 +0100
Message-ID: <CACRpkdZeiFYFdRWCEgYWDWh4Wn2gT29KAFao9mgj7sTi768kFQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] iio: trigger: add support for STM32 EXTI triggers
To: Fabrice Gasnier <fabrice.gasnier@st.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>,
	Lars-Peter Clausen <lars@metafoo.de>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	Benjamin Gaignard <benjamin.gaignard@linaro.org>, Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Jan 30, 2017 at 3:33 PM, Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> EXTi[0..15] gpio signal can be routed internally as trigger source for
> ADC or DAC conversions. Configure them as interrupts to configure
> trigger path in HW.
>
> Note: interrupt handler isn't required here, and corresponding interrupt
> can be kept masked at exti controller level.
>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>

But I see nothing STM32-specific about this driver?

I think we should do everone a service and just create
drivers/iio/trigger/gpio-trigger.c

I wondered before why we don't have a generic GPIO IIO trigger,
it seems like such an intuitive and useful thing to have.

Let's see what Jonathan says.

> +config IIO_STM32_EXTI_TRIGGER
> +       tristate "STM32 EXTI Trigger"
> +       depends on (ARCH_STM32 && OF) || COMPILE_TEST

config IIO_GPIO_TRIGGER
    depends on GPIOLIB

> +       select STM32_EXTI

Isn't the dependency actually the other way around?

default STM32_EXTI makes more sense, or just put it into the
defconfig.

> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +/* STM32 has up to 16 EXTI triggers on GPIOs */
> +#define STM32_MAX_EXTI_TRIGGER 16

Just don't put any restrictions like this so it can be widely
reused.

> +static irqreturn_t stm32_exti_trigger_handler(int irq, void *data)
> +{
> +       /* Exti handler shouldn't be invoked, and isn't used */
> +       return IRQ_HANDLED;
> +}

It could be a good idea to capture the timestamp here if we were
actually using this IRQ.

> +static int stm32_exti_trigger_probe(struct platform_device *pdev)
> +{
> +       int irq, ret;
> +       char name[8];
> +       struct gpio_desc *gpio;
> +       struct iio_trigger *trig;
> +       unsigned int i;
> +
> +       for (i = 0; i < STM32_MAX_EXTI_TRIGGER; i++) {

Why not just run this until devm_gpiod_get() returns -ERRNO
or something?

> +               snprintf(name, sizeof(name), "exti%d", i);
> +
> +               gpio = devm_gpiod_get_optional(&pdev->dev, name, GPIOD_IN);

Why would it be optional?

Either it is there in the device tree or we get -EINVAL or something
if there is no
such index in the device tree. We can get -EPROBE_DEEER too, and then
we should exit silently or just print that deferring is happening.

> +               if (IS_ERR_OR_NULL(gpio)) {
> +                       if (IS_ERR(gpio)) {
> +                               dev_err(&pdev->dev, "gpio %s get error %ld\n",
> +                                       name, PTR_ERR(gpio));
> +                               return PTR_ERR(gpio);
> +                       }
> +                       dev_dbg(&pdev->dev, "No %s gpio\n", name);
> +                       continue;
> +               }

Good

> +               irq = gpiod_to_irq(gpio);
> +               if (irq < 0) {
> +                       dev_err(&pdev->dev, "gpio %d to irq failed\n", i);
> +                       return irq;
> +               }
> +
> +               ret = devm_request_irq(&pdev->dev, irq,
> +                                      stm32_exti_trigger_handler,
> +                                      0, dev_name(&pdev->dev), pdev);
> +               if (ret) {
> +                       dev_err(&pdev->dev, "request IRQ %d failed\n", irq);
> +                       return ret;
> +               }

Here you need some elaborate trigger edge handling.

The flags that you define as "0" here, how do we say that we
want to handle rising or falling edges, for example?

I think you might want to establish these DT properties for
GPIO triggers:

gpio-trigger-rising-edge;
gpio-trigger-falling-edge;

Then:

int irq_flags = 0;

if (of_property_read_bool(np, "gpio-trigger-rising-edge")
   irq_flags |= IRQF_TRIGGER_RISING;
else if (of_property_read_bool(np, "gpio-trigger-falling-edge")
   irq_flags |= IRQF_TRIGGER_FALLING;

To pass along to the devm_request_irq() function as flags.

I find it weird that it even works without. Most GPIO interrupts
should require you to set a trigger type. But I guess it is because
of the other weirdness you describe below.

> +               /*
> +                * gpios are configured as interrupts, so exti trigger path is
> +                * configured in HW, and can now be used as external trigger
> +                * source by other IPs. But getting interrupts when trigger
> +                * occurs is unused here, so mask irq on exti controller by
> +                * default.
> +                */
> +               disable_irq(irq);

Aha. That is not generic. But what about just adding:

if (of_property_read_bool(np, "gpio-trigger-numb-irq")
    disable_irq();

(Plus add the binding for that something like "this makes the
GPIO mentioned get requested, translated to an IRQ, get the
IRQ requested, and then immediately just disabled as other
hardware will actually hande the IRQ line".)

I understand that this is kind of weird: we're making a whole generic
GPIO trigger driver just to use it with hardware that grabs and disabled
the irq immediately.

But I think that in the long run it makes for more reusable code.

> +static const struct of_device_id stm32_exti_trigger_of_match[] = {
> +       { .compatible = "st,stm32-exti-trigger" },
> +       {},

"iio-gpio-trigger"

Should fit anyone, given the above amendments.

> +#if IS_ENABLED(CONFIG_IIO_STM32_EXTI_TRIGGER)
> +bool is_stm32_exti_trigger(struct iio_trigger *trig);
> +#else
> +static inline bool is_stm32_exti_trigger(struct iio_trigger *trig)
> +{
> +       return false;
> +}
> +#endif

This seems unnecessary to broadcast to the entire kernel.

Why? (Maybe I can find explanations in later patches.

Yours,
Linus Walleij
