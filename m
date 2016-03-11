Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <56D1E1CB.6070704@kernel.org>
References: <1456407412-16218-1-git-send-email-michael.hennerich@analog.com>
	<56D1E1CB.6070704@kernel.org>
Date: Fri, 11 Mar 2016 23:28:32 +0700
Message-ID: <CACRpkdap_8YGCAvNeK7_0H2MDDnwQ9QDJH4O2SzEkDmczPGtLg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: dac: Add support for the AD5592R/AD5593R ADCs/DACs
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>, Paul Cercueil <paul.cercueil@analog.com>,
	Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun, Feb 28, 2016 at 12:50 AM, Jonathan Cameron <jic23@kernel.org> wrote:

>> +Analog Devices AD5592R/AD5593R DAC/ADC device driver
>> +
>> +Required properties for the AD5592R:
>> +     - compatible: Must be "adi,ad5592r"
>> +     - reg: SPI chip select number for the device
>> +     - spi-max-frequency: Max SPI frequency to use (< 30000000)
>> +     - spi-cpol: The AD5592R requires inverse clock polarity (CPOL) mode

If this should be a gpiochip, this shall also be reflected in the
device tree bindings and the example in the bindings by
stating gpio-controller; and #gpio-cells, referring to
the binding in gpio/gpio.txt so consumers can pick a GPIO
from this device.

I haven't seen the original patch, please mail the next version
to me so I can take a look.

>> +config AD5592R_BASE
>> +     tristate
>> +
>> +config AD5592R
>> +     tristate "Analog Devices AD5592R ADC/DAC driver"
>> +     depends on SPI_MASTER
>> +     depends on OF
>> +     select AD5592R_BASE
>> +     help
>> +       Say yes here to build support for Analog Devices AD5592R
>> +       Digital to Analog / Analog to Digital Converter.
>> +
>> +       To compile this driver as a module, choose M here: the
>> +       module will be called ad5592r.
>> +
>> +config AD5593R
>> +     tristate "Analog Devices AD5593R ADC/DAC driver"
>> +     depends on I2C
>> +     depends on OF
>> +     select AD5592R_BASE
>> +     help
>> +       Say yes here to build support for Analog Devices AD5593R
>> +       Digital to Analog / Analog to Digital Converter.
>> +
>> +       To compile this driver as a module, choose M here: the
>> +       module will be called ad5593r.
>> +

I guess something here should select GPIOLIB
and depend of OF_GPIO

>> +#ifdef CONFIG_GPIOLIB

Naaaaah really? Just select GPIOLIB and get rid of ifdeffery.
It's cool to have gpios available.

>> +static int ad5592r_gpio_request(struct gpio_chip *chip, unsigned offset)
>> +{
>> +     struct ad5592r_state *st = gpiochip_get_data(chip);
>> +
>> +     if (!(st->gpio_map & BIT(offset))) {
>> +             dev_err(st->dev, "GPIO %d is reserved by alternate function\n",
>> +                     offset);

This gpio_map looks a bit like pin control.

It might be overkill to use all of the pinctrl subsystem,
we have circumvented it in other places.

>> +             return -ENODEV;
>> +     }
>> +
>> +     if (offset >= chip->ngpio)
>> +             return -EINVAL;

gpiolib already guards against this I think.

>> +static int ad5592r_gpio_init(struct ad5592r_state *st)
>> +{
>> +     st->gpiochip.label = dev_name(st->dev);
>> +     st->gpiochip.base = -1;
>> +     st->gpiochip.ngpio = 8;
>> +     st->gpiochip.parent = st->dev;
>> +     st->gpiochip.can_sleep = true;
>> +     st->gpiochip.direction_input = ad5592r_gpio_direction_input;
>> +     st->gpiochip.direction_output = ad5592r_gpio_direction_output;
>> +     st->gpiochip.get = ad5592r_gpio_get;
>> +     st->gpiochip.set = ad5592r_gpio_set;
>> +     st->gpiochip.request = ad5592r_gpio_request;
>> +     st->gpiochip.owner = THIS_MODULE;
>> +
>> +     mutex_init(&st->gpio_lock);
>> +
>> +     return gpiochip_add_data(&st->gpiochip, st);

The gpiolib should be fine with the of_node from the parent so
looks fine.

>> +             mutex_lock(&iio_dev->mlock);
>> +             st->ops->reg_write(st, AD5592R_REG_RESET, 0xdac);
>> +             mutex_unlock(&iio_dev->mlock);

What's that? (0xdac)? Clever magic?

>> +             case CH_MODE_DAC_AND_ADC:
>> +                     dac |= BIT(i);
>> +                     adc |= BIT(i);
>> +                     break;
>> +
>> +             case CH_MODE_UNUSED_PULL_DOWN:
>> +                     pulldown |= BIT(i);
>> +                     break;
>> +
>> +             case CH_MODE_UNUSED_OUT_TRISTATE:
>> +                     tristate |= BIT(i);
>> +                     break;
>> +
>> +             case CH_MODE_UNUSED_OUT_LOW:
>> +                     st->gpio_out |= BIT(i);
>> +                     break;
>> +
>> +             case CH_MODE_UNUSED_OUT_HIGH:
>> +                     st->gpio_out |= BIT(i);
>> +                     st->gpio_val |= BIT(i);
>> +                     break;
>> +
>> +             case CH_MODE_GPIO_OPEN_DRAIN:
>> +                     open_drain |= BIT(i);

Deja-vu with include/linux/pinctrl/pinconf-generic.h

We call tristate "bias high impedance".

Yours,
Linus Walleij
