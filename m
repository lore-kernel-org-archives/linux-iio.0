Return-Path: <Michael.Hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
Subject: Re: [PATCH] iio: dac: Add support for the AD5592R/AD5593R ADCs/DACs
References: <1456313796-24654-1-git-send-email-michael.hennerich@analog.com>
 <CAKv63uuKHLmRG6GWZkkBK31HSQpWT60bdcVQspwc=E12903sKg@mail.gmail.com>
To: Crt Mori <cmo@melexis.com>
CC: Johnathan Iain Cameron <jic23@kernel.org>, Lars-Peter Clausen
	<lars@metafoo.de>, Hartmut Knaack <knaack.h@gmx.de>,
	<paul.cercueil@analog.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll
	<pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell
	<ijc+devicetree@hellion.org.uk>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>
From: Michael Hennerich <michael.hennerich@analog.com>
Message-ID: <56CDAA85.5090008@analog.com>
Date: Wed, 24 Feb 2016 14:05:09 +0100
MIME-Version: 1.0
In-Reply-To: <CAKv63uuKHLmRG6GWZkkBK31HSQpWT60bdcVQspwc=E12903sKg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 02/24/2016 01:27 PM, Crt Mori wrote:
> Hi,
> Ideally this could be a regmap driver and it would avoid you a lot of
> endianness, caching, etc. problems.
>
> Some other bits below.

Thanks for reviewing.
The register layout is not uniform between the SPI and I2C version.
Therefore regmap is not an option.


>
> BR
> Crt
>
> On 24 February 2016 at 12:36,  <michael.hennerich@analog.com> wrote:
>> From: Paul Cercueil <paul.cercueil@analog.com>
>>
>> This patch adds support for the AD5592R (spi) and AD5593R (i2c)
>> ADC/DAC devices.
>>
>> Signed-off-by: Paul Cercueil <paul.cercueil@analog.com>
>> ---
>>   .../devicetree/bindings/iio/dac/ad5592r.txt        |  88 +++
>>   drivers/iio/dac/Kconfig                            |  27 +
>>   drivers/iio/dac/Makefile                           |   3 +
>>   drivers/iio/dac/ad5592r-base.c                     | 670 +++++++++++++++++++++
>>   drivers/iio/dac/ad5592r-base.h                     |  77 +++
>>   drivers/iio/dac/ad5592r.c                          | 163 +++++
>>   drivers/iio/dac/ad5593r.c                          | 136 +++++
>>   include/dt-bindings/iio/adi,ad5592r.h              |  16 +
>>   8 files changed, 1180 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/dac/ad5592r.txt
>>   create mode 100644 drivers/iio/dac/ad5592r-base.c
>>   create mode 100644 drivers/iio/dac/ad5592r-base.h
>>   create mode 100644 drivers/iio/dac/ad5592r.c
>>   create mode 100644 drivers/iio/dac/ad5593r.c
>>   create mode 100644 include/dt-bindings/iio/adi,ad5592r.h
>>
>> diff --git a/Documentation/devicetree/bindings/iio/dac/ad5592r.txt b/Documentation/devicetree/bindings/iio/dac/ad5592r.txt
>> new file mode 100644
>> index 0000000..9d7f23a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/dac/ad5592r.txt
>> @@ -0,0 +1,88 @@
>> +Analog Devices AD5592R/AD5593R DAC/ADC device driver
>> +
>> +Required properties for the AD5592R:
>> +       - compatible: Must be "adi,ad5592r"
>> +       - reg: SPI chip select number for the device
>> +       - spi-max-frequency: Max SPI frequency to use (< 30000000)
>> +       - spi-cpol: The AD5592R requires inverse clock polarity (CPOL) mode
>> +
>> +Required properties for the AD5593R:
>> +       - compatible: Must be "adi,ad5593r"
>> +       - reg: I2C address of the device
>> +
>> +Required properties for all supported chips:
>> +       - channel-modes: An array of eight 8-bit values (one per channel)
>> +         describing the mode of each channel. Macros specifying the valid values
>> +         can be found in <dt-bindings/iio/adi,ad5592r.h>.
>> +         The following values are currently supported:
>> +               * CH_MODE_ADC                   (the pin is ADC input)
>> +               * CH_MODE_DAC                   (the pin is DAC output)
>> +               * CH_MODE_DAC_AND_ADC           (the pin is DAC output but can be
>> +                                                monitored by an ADC)
>> +               * CH_MODE_UNUSED_PULL_DOWN      (the pin is pulled down)
>> +               * CH_MODE_UNUSED_OUT_LOW        (the pin is output low)
>> +               * CH_MODE_UNUSED_OUT_HIGH       (the pin is output high)
>> +               * CH_MODE_UNUSED_OUT_TRISTATE   (the pin is tristated output)
>> +               * CH_MODE_GPIO                  (the pin is registered with GPIOLIB)
>> +               * CH_MODE_GPIO_OPEN_DRAIN       (the pin is configured open drain and
>> +                                                registered with GPIOLIB)
>> +
>> +Optional properties:
>> +       - vref-supply: Phandle to the external reference voltage supply. This should
>> +         only be set if there is an external reference voltage connected to the VREF
>> +         pin. If the property is not set the internal 2.5V reference is used.
>> +       - reset-gpios : GPIO spec for the RESET pin. If specified, it will be
>> +         asserted during driver probe.
>> +
>> +AD5592R Example:
>> +
>> +       #include <dt-bindings/iio/adi,ad5592r.h>
>> +
>> +       vref: regulator-vref {
>> +               compatible = "regulator-fixed";
>> +               regulator-name = "vref-ad559x";
>> +               regulator-min-microvolt = <3300000>;
>> +               regulator-max-microvolt = <3300000>;
>> +               regulator-always-on;
>> +       };
>> +
>> +       ad5592r@0 {
>> +               compatible = "adi,ad5592r";
>> +               reg = <0>;
>> +               spi-max-frequency = <1000000>;
>> +               spi-cpol;
>> +
>> +               channel-modes = /bits/ 8 <
>> +                       CH_MODE_DAC
>> +                       CH_MODE_ADC
>> +                       CH_MODE_DAC_AND_ADC
>> +                       CH_MODE_DAC_AND_ADC
>> +                       CH_MODE_UNUSED_PULL_DOWN
>> +                       CH_MODE_GPIO
>> +                       CH_MODE_GPIO
>> +                       CH_MODE_GPIO
>> +               >;
>> +
>> +               vref-supply = <&vref>; /* optional */
>> +               reset-gpios = <&gpio0 86 0>;  /* optional */
>> +       };
>> +
>> +AD5593R Example:
>> +
>> +       #include <dt-bindings/iio/adi,ad5592r.h>
>> +
>> +       ad5593r@10 {
>> +               compatible = "adi,ad5593r";
>> +               reg = <0x10>;
>> +               channel-modes = /bits/ 8 <
>> +                       CH_MODE_DAC
>> +                       CH_MODE_ADC
>> +                       CH_MODE_DAC_AND_ADC
>> +                       CH_MODE_DAC_AND_ADC
>> +                       CH_MODE_UNUSED_PULL_DOWN
>> +                       CH_MODE_GPIO
>> +                       CH_MODE_GPIO
>> +                       CH_MODE_GPIO
>> +               >;
>> +
>> +       };
>> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
>> index 31a1985..e7dd376 100644
>> --- a/drivers/iio/dac/Kconfig
>> +++ b/drivers/iio/dac/Kconfig
>> @@ -74,6 +74,33 @@ config AD5449
>>            To compile this driver as a module, choose M here: the
>>            module will be called ad5449.
>>
>> +config AD5592R_BASE
>> +       tristate
>> +
>> +config AD5592R
>> +       tristate "Analog Devices AD5592R ADC/DAC driver"
>> +       depends on SPI_MASTER
>> +       depends on OF
>> +       select AD5592R_BASE
>> +       help
>> +         Say yes here to build support for Analog Devices AD5592R
>> +         Digital to Analog / Analog to Digital Converter.
>> +
>> +         To compile this driver as a module, choose M here: the
>> +         module will be called ad5592r.
>> +
>> +config AD5593R
>> +       tristate "Analog Devices AD5593R ADC/DAC driver"
>> +       depends on I2C
>> +       depends on OF
>> +       select AD5592R_BASE
>> +       help
>> +         Say yes here to build support for Analog Devices AD5593R
>> +         Digital to Analog / Analog to Digital Converter.
>> +
>> +         To compile this driver as a module, choose M here: the
>> +         module will be called ad5593r.
>> +
>>   config AD5504
>>          tristate "Analog Devices AD5504/AD5501 DAC SPI driver"
>>          depends on SPI
>> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
>> index e2deda9..cf23310 100644
>> --- a/drivers/iio/dac/Makefile
>> +++ b/drivers/iio/dac/Makefile
>> @@ -11,6 +11,9 @@ obj-$(CONFIG_AD5064) += ad5064.o
>>   obj-$(CONFIG_AD5504) += ad5504.o
>>   obj-$(CONFIG_AD5446) += ad5446.o
>>   obj-$(CONFIG_AD5449) += ad5449.o
>> +obj-$(CONFIG_AD5592R_BASE) += ad5592r-base.o
>> +obj-$(CONFIG_AD5592R) += ad5592r.o
>> +obj-$(CONFIG_AD5593R) += ad5593r.o
>>   obj-$(CONFIG_AD5755) += ad5755.o
>>   obj-$(CONFIG_AD5761) += ad5761.o
>>   obj-$(CONFIG_AD5764) += ad5764.o
>> diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
>> new file mode 100644
>> index 0000000..7438636
>> --- /dev/null
>> +++ b/drivers/iio/dac/ad5592r-base.c
>> @@ -0,0 +1,670 @@
>> +/*
>> + * AD5592R Digital <-> Analog converters driver
>> + *
>> + * Copyright 2014-2016 Analog Devices Inc.
>> + * Author: Paul Cercueil <paul.cercueil@analog.com>
>> + *
>> + * Licensed under the GPL-2.
>> + */
>> +
>> +#include <linux/bitops.h>
>> +#include <linux/delay.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/of.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/gpio/driver.h>
>> +#include <linux/gpio.h>
>> +
>> +#include <dt-bindings/iio/adi,ad5592r.h>
>> +
>> +#include "ad5592r-base.h"
>> +
>> +#ifdef CONFIG_GPIOLIB
>> +
>> +static int ad5592r_gpio_get(struct gpio_chip *chip, unsigned offset)
>> +{
>> +       struct ad5592r_state *st = gpiochip_get_data(chip);
>> +       int ret = 0;
>> +       u8 val;
>> +
>> +       mutex_lock(&st->gpio_lock);
>> +
>> +       if (st->gpio_out & BIT(offset))
>> +               val = st->gpio_val;
>> +       else
>> +               ret = st->ops->gpio_read(st, &val);
>> +
>> +       mutex_unlock(&st->gpio_lock);
>> +
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       return !!(val & BIT(offset));
>> +}
>> +
>> +static void ad5592r_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
>> +{
>> +       struct ad5592r_state *st = gpiochip_get_data(chip);
>> +
>> +       mutex_lock(&st->gpio_lock);
>> +
>> +       if (value)
>> +               st->gpio_val |= BIT(offset);
>> +       else
>> +               st->gpio_val &= ~BIT(offset);
>> +
>> +       st->ops->reg_write(st, AD5592R_REG_GPIO_SET, st->gpio_val);
>> +
>> +       mutex_unlock(&st->gpio_lock);
>> +}
>> +
>> +static int ad5592r_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
>> +{
>> +       struct ad5592r_state *st = gpiochip_get_data(chip);
>> +       int ret;
>> +
>> +       mutex_lock(&st->gpio_lock);
>> +
>> +       st->gpio_out &= ~BIT(offset);
>> +       st->gpio_in |= BIT(offset);
>> +
>> +       ret = st->ops->reg_write(st, AD5592R_REG_GPIO_OUT_EN, st->gpio_out);
>> +       if (ret < 0)
>> +               goto err_unlock;
>> +
>> +       ret = st->ops->reg_write(st, AD5592R_REG_GPIO_IN_EN, st->gpio_in);
>> +
>> +err_unlock:
>> +       mutex_unlock(&st->gpio_lock);
>> +
>> +       return ret;
>> +}
>> +
>> +static int ad5592r_gpio_direction_output(struct gpio_chip *chip,
>> +                                        unsigned offset, int value)
>> +{
>> +       struct ad5592r_state *st = gpiochip_get_data(chip);
>> +       int ret;
>> +
>> +       mutex_lock(&st->gpio_lock);
>> +
>> +       if (value)
>> +               st->gpio_val |= BIT(offset);
>> +       else
>> +               st->gpio_val &= ~BIT(offset);
>> +
>> +       st->gpio_in &= ~BIT(offset);
>> +       st->gpio_out |= BIT(offset);
>> +
>> +       ret = st->ops->reg_write(st, AD5592R_REG_GPIO_SET, st->gpio_val);
>> +       if (ret < 0)
>> +               goto err_unlock;
>> +
>> +       ret = st->ops->reg_write(st, AD5592R_REG_GPIO_OUT_EN, st->gpio_out);
>> +       if (ret < 0)
>> +               goto err_unlock;
>> +
>> +       ret = st->ops->reg_write(st, AD5592R_REG_GPIO_IN_EN, st->gpio_in);
>> +
>> +err_unlock:
>> +       mutex_unlock(&st->gpio_lock);
>> +
>> +       return ret;
>> +}
>> +
>> +static int ad5592r_gpio_request(struct gpio_chip *chip, unsigned offset)
>> +{
>> +       struct ad5592r_state *st = gpiochip_get_data(chip);
>> +
>> +       if (!(st->gpio_map & BIT(offset))) {
>> +               dev_err(st->dev, "GPIO %d is reserved by alternate function\n",
>> +                       offset);
>> +               return -ENODEV;
>> +       }
>> +
>> +       if (offset >= chip->ngpio)
>> +               return -EINVAL;
>> +
>> +       return 0;
>> +}
>> +
>> +static int ad5592r_gpio_init(struct ad5592r_state *st)
>> +{
>> +       st->gpiochip.label = dev_name(st->dev);
>> +       st->gpiochip.base = -1;
>> +       st->gpiochip.ngpio = 8;
>> +       st->gpiochip.parent = st->dev;
>> +       st->gpiochip.can_sleep = true;
>> +       st->gpiochip.direction_input = ad5592r_gpio_direction_input;
>> +       st->gpiochip.direction_output = ad5592r_gpio_direction_output;
>> +       st->gpiochip.get = ad5592r_gpio_get;
>> +       st->gpiochip.set = ad5592r_gpio_set;
>> +       st->gpiochip.request = ad5592r_gpio_request;
>> +       st->gpiochip.owner = THIS_MODULE;
>> +
>> +       mutex_init(&st->gpio_lock);
>> +
>> +       return gpiochip_add_data(&st->gpiochip, st);
>> +}
>> +
>> +static void ad5592r_gpio_cleanup(struct ad5592r_state *st)
>> +{
>> +       gpiochip_remove(&st->gpiochip);
>> +}
>> +#else
>> +static int ad5592r_gpio_init(struct ad5592r_state *st) { return 0 };
>> +static void ad5592r_gpio_cleanup(struct ad5592r_state *st) { };
>> +#endif /* CONFIG_GPIOLIB */
>> +
>> +static int ad5592r_reset(struct ad5592r_state *st)
>> +{
>> +       struct gpio_desc *gpio;
>> +       struct iio_dev *iio_dev = iio_priv_to_dev(st);
>> +
>> +       gpio = devm_gpiod_get_optional(st->dev, "reset", GPIOD_OUT_LOW);
>> +       if (IS_ERR(gpio))
>> +               return PTR_ERR(gpio);
>> +
>> +       if (gpio) {
>> +               udelay(1);
>> +               gpiod_set_value(gpio, 1);
>> +       } else {
>> +               mutex_lock(&iio_dev->mlock);
>> +               st->ops->reg_write(st, AD5592R_REG_RESET, 0xdac);
>> +               mutex_unlock(&iio_dev->mlock);
>> +       }
>> +
>> +       udelay(250);
>> +
>> +       return 0;
>> +}
>> +
>> +static int ad5592r_get_vref(struct ad5592r_state *st)
>> +{
>> +       int ret;
>> +
>> +       if (st->reg) {
>> +               ret = regulator_get_voltage(st->reg);
>> +               if (ret < 0)
>> +                       return ret;
>> +
>> +               return ret / 1000;
>> +       } else {
>> +               return 2500;
>> +       }
>> +}
>> +
>> +static int ad5592r_set_channel_modes(struct ad5592r_state *st)
>> +{
>> +       const struct ad5592r_rw_ops *ops = st->ops;
>> +       int ret;
>> +       unsigned i;
>> +       struct iio_dev *iio_dev = iio_priv_to_dev(st);
>> +       u8 pulldown = 0, open_drain = 0, tristate = 0,
>> +          dac = 0, adc = 0;
>> +       u16 read_back;
>> +
>> +       for (i = 0; i < st->num_channels; i++) {
>> +               switch (st->channel_modes[i]) {
>> +               case CH_MODE_DAC:
>> +                       dac |= BIT(i);
>> +                       break;
>> +
>> +               case CH_MODE_ADC:
>> +                       adc |= BIT(i);
>> +                       break;
>> +
>> +               case CH_MODE_DAC_AND_ADC:
>> +                       dac |= BIT(i);
>> +                       adc |= BIT(i);
>> +                       break;
>> +
>> +               case CH_MODE_UNUSED_PULL_DOWN:
>> +                       pulldown |= BIT(i);
>> +                       break;
>> +
>> +               case CH_MODE_UNUSED_OUT_TRISTATE:
>> +                       tristate |= BIT(i);
>> +                       break;
>> +
>> +               case CH_MODE_UNUSED_OUT_LOW:
>> +                       st->gpio_out |= BIT(i);
>> +                       break;
>> +
>> +               case CH_MODE_UNUSED_OUT_HIGH:
>> +                       st->gpio_out |= BIT(i);
>> +                       st->gpio_val |= BIT(i);
>> +                       break;
>> +
>> +               case CH_MODE_GPIO_OPEN_DRAIN:
>> +                       open_drain |= BIT(i);
>> +
>> +                       /* fall-through */
>> +
>> +               case CH_MODE_GPIO:
>> +                       st->gpio_map |= BIT(i);
>> +                       st->gpio_in |= BIT(i); /* Default to input */
>> +                       break;
>> +
>> +               default:
>> +                       pulldown |= BIT(i);
>> +                       break;
>> +               }
>> +       }
>> +
>> +       mutex_lock(&iio_dev->mlock);
>> +
>> +       /* Pull down unused pins to GND */
>> +       ret = ops->reg_write(st, AD5592R_REG_PULLDOWN, pulldown);
>> +       if (ret)
>> +               goto err_unlock;
>> +
>> +       ret = ops->reg_write(st, AD5592R_REG_TRISTATE, tristate);
>> +       if (ret)
>> +               goto err_unlock;
>> +
>> +       /* Configure pins that we use */
>> +       ret = ops->reg_write(st, AD5592R_REG_DAC_EN, dac);
>> +       if (ret)
>> +               goto err_unlock;
>> +
>> +       ret = ops->reg_write(st, AD5592R_REG_ADC_EN, adc);
>> +       if (ret)
>> +               goto err_unlock;
>> +
>> +       ret = ops->reg_write(st, AD5592R_REG_OPEN_DRAIN, open_drain);
>> +       if (ret)
>> +               goto err_unlock;
>> +
>> +       ret = ops->reg_write(st, AD5592R_REG_GPIO_SET, st->gpio_val);
>> +       if (ret)
>> +               goto err_unlock;
>> +
>> +       ret = ops->reg_write(st, AD5592R_REG_GPIO_OUT_EN, st->gpio_out);
>> +       if (ret)
>> +               goto err_unlock;
>> +
>> +       ret = ops->reg_write(st, AD5592R_REG_GPIO_IN_EN, st->gpio_in);
>> +       if (ret)
>> +               goto err_unlock;
>> +
>> +       /* Verify that we can read back at least one register */
>> +       ret = ops->reg_read(st, AD5592R_REG_ADC_EN, &read_back);
>> +       if (!ret && (read_back & 0xff) != adc)
>> +               ret = -EIO;
>> +
>> +err_unlock:
>> +       mutex_unlock(&iio_dev->mlock);
>> +       return ret;
>> +}
>> +
>> +static int ad5592r_write_raw(struct iio_dev *iio_dev,
>> +       struct iio_chan_spec const *chan, int val, int val2, long mask)
>> +{
>> +       struct ad5592r_state *st = iio_priv(iio_dev);
>> +       int ret;
>> +
>> +       switch (mask) {
>> +       case IIO_CHAN_INFO_RAW:
>> +               if (val >= (1 << chan->scan_type.realbits) || val < 0)
>> +                       return -EINVAL;
>> +
>> +               /* Warn if we try to write to a ADC channel */
>> +               WARN_ON(!chan->output);
>> +
>> +               mutex_lock(&iio_dev->mlock);
>> +               ret = st->ops->write_dac(st, chan->channel, val);
>> +               if (!ret)
>> +                       st->cached_dac[chan->channel] = val;
>> +               mutex_unlock(&iio_dev->mlock);
>> +               return ret;
>> +       case IIO_CHAN_INFO_SCALE:
>> +               if (chan->type == IIO_VOLTAGE) {
>> +                       bool gain;
>> +
>> +                       if (val == st->scale_avail[0][0] &&
>> +                               val2 == st->scale_avail[0][1])
>> +                               gain = false;
>> +                       else if (val == st->scale_avail[1][0] &&
>> +                                val2 == st->scale_avail[1][1])
>> +                               gain = true;
>> +                       else
>> +                               return -EINVAL;
>> +
>> +                       ret = st->ops->reg_read(st, AD5592R_REG_CTRL,
>> +                                               &st->cached_gp_ctrl);
>> +                       if (ret < 0)
>> +                               return ret;
>> +
>> +                       if (chan->output) {
>> +                               if (gain)
>> +                                       st->cached_gp_ctrl |=
>> +                                               AD5592R_REG_CTRL_DAC_RANGE;
>> +                               else
>> +                                       st->cached_gp_ctrl &=
>> +                                               ~AD5592R_REG_CTRL_DAC_RANGE;
>> +                       } else {
>> +                               if (gain)
>> +                                       st->cached_gp_ctrl |=
>> +                                               AD5592R_REG_CTRL_ADC_RANGE;
>> +                               else
>> +                                       st->cached_gp_ctrl &=
>> +                                               ~AD5592R_REG_CTRL_ADC_RANGE;
>> +                       }
>> +
>> +                       ret = st->ops->reg_write(st, AD5592R_REG_CTRL,
>> +                                                st->cached_gp_ctrl);
>
> This write does not have mutex lock while above one has. No idea why
>
>> +                       if (ret < 0)
>> +                               return ret;
>> +
>> +                       return ret;
>> +
>> +               }
>> +               break;
>> +       default:
>> +               return -EINVAL;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int ad5592r_read_raw(struct iio_dev *iio_dev,
>> +                          struct iio_chan_spec const *chan,
>> +                          int *val, int *val2, long m)
>> +{
>> +       struct ad5592r_state *st = iio_priv(iio_dev);
>> +       u16 read_val;
>> +       int ret;
>> +
>> +       mutex_lock(&iio_dev->mlock);
>> +
>> +       switch (m) {
>> +       case IIO_CHAN_INFO_RAW:
>> +
>> +               if (!chan->output) {
>> +                       ret = st->ops->read_adc(st, chan->channel, &read_val);
>> +                       if (ret)
>> +                               goto unlock;
>> +
>> +                       if ((read_val >> 12 & 0x7) != (chan->channel & 0x7)) {
>> +                               dev_err(st->dev, "Error while reading channel %u\n",
>> +                                               chan->channel);
>> +                               ret = -EIO;
>> +                               goto unlock;
>> +                       }
>> +
>> +                       read_val &= GENMASK(11, 0);
>> +
>> +               } else {
>> +                       read_val = st->cached_dac[chan->channel];
>> +               }
>> +
>> +               dev_dbg(st->dev, "Channel %u read: 0x%04hX\n",
>> +                               chan->channel, read_val);
>> +
>> +               *val = (int) read_val;
>> +               ret = IIO_VAL_INT;
>> +               break;
>> +       case IIO_CHAN_INFO_SCALE:
>> +
>> +               *val = ad5592r_get_vref(st);
>> +
>> +               if (chan->type == IIO_TEMP) {
>> +                       s64 tmp = *val * (3767897513LL / 25LL);
>> +                       *val = div_s64_rem(tmp, 1000000000LL, val2);
>> +
>> +                       ret = IIO_VAL_INT_PLUS_MICRO;
>> +               } else {
>> +                       int mult;
>> +
>> +                       if (chan->output)
>> +                               mult = !!(st->cached_gp_ctrl &
>> +                                       AD5592R_REG_CTRL_DAC_RANGE);
>> +                       else
>> +                               mult = !!(st->cached_gp_ctrl &
>> +                                       AD5592R_REG_CTRL_ADC_RANGE);
>> +
>> +                       *val *= ++mult;
>> +
>> +                       *val2 = chan->scan_type.realbits;
>> +                       ret = IIO_VAL_FRACTIONAL_LOG2;
>> +               }
>> +               break;
>> +       case IIO_CHAN_INFO_OFFSET:
>> +
>> +               ret = ad5592r_get_vref(st);
>> +
>> +               if (st->cached_gp_ctrl & AD5592R_REG_CTRL_ADC_RANGE)
>> +                       *val = (-34365 * 25) / ret;
>> +               else
>> +                       *val = (-75365 * 25) / ret;
>> +               ret =  IIO_VAL_INT;
>> +               break;
>> +       default:
>> +               return -EINVAL;
>
> mutex unlock missing in this case
> ret -EINVAL;
> goto unlock; (or break;)

Good catch - in theory we should never get there.
I'll fix it.



>
>> +       }
>> +
>> +unlock:
>> +       mutex_unlock(&iio_dev->mlock);
>> +       return ret;
>> +}
>> +
>> +static int ad5592r_write_raw_get_fmt(struct iio_dev *indio_dev,
>> +                                struct iio_chan_spec const *chan, long mask)
>> +{
>> +       switch (mask) {
>> +       case IIO_CHAN_INFO_SCALE:
>> +               return IIO_VAL_INT_PLUS_NANO;
>> +
>> +       default:
>> +               return IIO_VAL_INT_PLUS_MICRO;
>> +       }
>> +
>> +       return -EINVAL;
>> +}
>> +
>> +static const struct iio_info ad5592r_info = {
>> +       .read_raw = ad5592r_read_raw,
>> +       .write_raw = ad5592r_write_raw,
>> +       .write_raw_get_fmt = ad5592r_write_raw_get_fmt,
>> +       .driver_module = THIS_MODULE,
>> +};
>> +
>> +static ssize_t ad5592r_show_scale_available(struct iio_dev *iio_dev,
>> +                                          uintptr_t private,
>> +                                          const struct iio_chan_spec *chan,
>> +                                          char *buf)
>> +{
>> +       struct ad5592r_state *st = iio_priv(iio_dev);
>> +
>> +       return sprintf(buf, "%d.%09u %d.%09u\n",
>> +               st->scale_avail[0][0], st->scale_avail[0][1],
>> +               st->scale_avail[1][0], st->scale_avail[1][1]);
>> +}
>> +
>> +static struct iio_chan_spec_ext_info ad5592r_ext_info[] = {
>> +       {
>> +        .name = "scale_available",
>> +        .read = ad5592r_show_scale_available,
>> +        .shared = true,
>> +        },
>> +       {},
>> +};
>> +
>> +static void ad5592r_setup_channel(struct iio_dev *iio_dev,
>> +               struct iio_chan_spec *chan, bool output, unsigned id)
>> +{
>> +       chan->type = IIO_VOLTAGE;
>> +       chan->indexed = 1;
>> +       chan->output = output;
>> +       chan->channel = id;
>> +       chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
>> +       chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
>> +       chan->scan_type.sign = 'u';
>> +       chan->scan_type.realbits = 12;
>> +       chan->scan_type.storagebits = 16;
>> +       chan->ext_info = ad5592r_ext_info;
>> +}
>> +
>> +static int ad5592r_alloc_channels(struct ad5592r_state *st)
>> +{
>> +       unsigned i, curr_channel = 0,
>> +                num_channels = st->num_channels;
>> +       struct iio_dev *iio_dev = iio_priv_to_dev(st);
>> +       struct iio_chan_spec *channels;
>> +       int ret;
>> +
>> +       ret = device_property_read_u8_array(st->dev, "channel-modes",
>> +                       st->channel_modes, num_channels);
>> +       if (ret)
>> +               return ret;
>> +
>> +       channels = devm_kzalloc(st->dev,
>> +                       (1 + 2 * num_channels) * sizeof(*channels), GFP_KERNEL);
>> +       if (!channels)
>> +               return -ENOMEM;
>> +
>> +       for (i = 0; i < num_channels; i++) {
>> +               switch (st->channel_modes[i]) {
>> +               case CH_MODE_DAC:
>> +                       ad5592r_setup_channel(iio_dev, &channels[curr_channel],
>> +                                       true, i);
>> +                       curr_channel++;
>> +                       break;
>> +
>> +               case CH_MODE_ADC:
>> +                       ad5592r_setup_channel(iio_dev, &channels[curr_channel],
>> +                                       false, i);
>> +                       curr_channel++;
>> +                       break;
>> +
>> +               case CH_MODE_DAC_AND_ADC:
>> +                       ad5592r_setup_channel(iio_dev, &channels[curr_channel],
>> +                                       true, i);
>> +                       curr_channel++;
>> +                       ad5592r_setup_channel(iio_dev, &channels[curr_channel],
>> +                                       false, i);
>> +                       curr_channel++;
>> +                       break;
>> +
>> +               default:
>> +                       continue;
>> +               }
>> +       }
>> +
>> +       channels[curr_channel].type = IIO_TEMP;
>> +       channels[curr_channel].channel = 8;
>> +       channels[curr_channel].info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> +                                  BIT(IIO_CHAN_INFO_SCALE) |
>> +                                  BIT(IIO_CHAN_INFO_OFFSET);
>> +       curr_channel++;
>> +
>> +       iio_dev->num_channels = curr_channel;
>> +       iio_dev->channels = channels;
>> +
>> +       return 0;
>> +}
>> +
>> +static void ad5592r_init_scales(struct ad5592r_state *st, int vref_mV)
>> +{
>> +       s64 tmp = (s64)vref_mV * 1000000000LL >> 12;
>> +
>> +       st->scale_avail[0][0] =
>> +               div_s64_rem(tmp, 1000000000LL, &st->scale_avail[0][1]);
>> +       st->scale_avail[1][0] =
>> +               div_s64_rem(tmp * 2, 1000000000LL, &st->scale_avail[1][1]);
>> +}
>> +
>> +int ad5592r_probe(struct device *dev, const char *name,
>> +               const struct ad5592r_rw_ops *ops)
>> +{
>> +       struct iio_dev *iio_dev;
>> +       struct ad5592r_state *st;
>> +       int ret;
>> +
>> +       iio_dev = devm_iio_device_alloc(dev, sizeof(*st));
>> +       if (!iio_dev)
>> +               return -ENOMEM;
>> +
>> +       st = iio_priv(iio_dev);
>> +       st->dev = dev;
>> +       st->ops = ops;
>> +       st->num_channels = 8;
>> +       dev_set_drvdata(dev, iio_dev);
>> +
>> +       st->reg = devm_regulator_get_optional(dev, "vref");
>> +       if (IS_ERR(st->reg)) {
>> +               if ((PTR_ERR(st->reg) != -ENODEV) && dev->of_node)
>> +                       return PTR_ERR(st->reg);
>> +
>> +               st->reg = NULL;
>
> So in this case with continue without enabled regulator?

Yes - that's how you tell the driver to use the internal reference.

>
>> +       } else {
>> +               ret = regulator_enable(st->reg);
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +
>> +       iio_dev->dev.parent = dev;
>> +       iio_dev->name = name;
>> +       iio_dev->info = &ad5592r_info;
>> +       iio_dev->modes = INDIO_DIRECT_MODE;
>> +
>> +       ad5592r_init_scales(st, ad5592r_get_vref(st));
>> +
>> +       ret = ad5592r_reset(st);
>> +       if (ret)
>> +               goto error_disable_reg;
>> +
>> +       ret = ops->reg_write(st, AD5592R_REG_PD,
>> +                    (st->reg == NULL) ? AD5592R_REG_PD_EN_REF : 0);
>> +       if (ret)
>> +               goto error_disable_reg;
>> +
>> +       ret = ad5592r_alloc_channels(st);
>> +       if (ret)
>> +               goto error_disable_reg;
>> +
>> +       ret = ad5592r_set_channel_modes(st);
>> +       if (ret)
>> +               goto error_disable_reg;
>> +
>> +       ret = devm_iio_device_register(dev, iio_dev);
>> +       if (ret)
>> +               goto error_disable_reg;
>> +
>> +       return ad5592r_gpio_init(st);
>> +
>> +error_disable_reg:
>> +       if (st->reg)
>> +               regulator_disable(st->reg);
>> +
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(ad5592r_probe);
>> +
>> +int ad5592r_remove(struct device *dev)
>> +{
>> +       struct iio_dev *iio_dev = dev_get_drvdata(dev);
>> +       struct ad5592r_state *st = iio_priv(iio_dev);
>> +       unsigned int i;
>> +
>> +       /* Reset all channels */
>> +       for (i = 0; i < ARRAY_SIZE(st->channel_modes); i++)
>> +               st->channel_modes[i] = CH_MODE_UNUSED_PULL_DOWN;
>> +
>> +       if (st->reg)
>> +               regulator_disable(st->reg);
>> +
>> +       if (st->gpio_map)
>> +               ad5592r_gpio_cleanup(st);
>> +
>> +       return ad5592r_set_channel_modes(st);
>> +}
>> +EXPORT_SYMBOL_GPL(ad5592r_remove);
>> +
>> +MODULE_AUTHOR("Paul Cercueil <paul.cercueil@analog.com>");
>> +MODULE_DESCRIPTION("Analog Devices AD5592R multi-channel converters");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/iio/dac/ad5592r-base.h b/drivers/iio/dac/ad5592r-base.h
>> new file mode 100644
>> index 0000000..162e833
>> --- /dev/null
>> +++ b/drivers/iio/dac/ad5592r-base.h
>> @@ -0,0 +1,77 @@
>> +/*
>> + * AD5592R / AD5593R Digital <-> Analog converters driver
>> + *
>> + * Copyright 2015-2016 Analog Devices Inc.
>> + * Author: Paul Cercueil <paul.cercueil@analog.com>
>> + *
>> + * Licensed under the GPL-2.
>> + */
>> +
>> +#ifndef __DRIVERS_IIO_DAC_AD5592R_BASE_H__
>> +#define __DRIVERS_IIO_DAC_AD5592R_BASE_H__
>> +
>> +#include <linux/types.h>
>> +#include <linux/cache.h>
>> +#include <linux/mutex.h>
>> +#include <linux/gpio/driver.h>
>> +
>> +struct device;
>> +struct ad5592r_state;
>> +
>> +enum ad5592r_registers {
>> +       AD5592R_REG_NOOP                = 0x0,
>> +       AD5592R_REG_DAC_READBACK        = 0x1,
>> +       AD5592R_REG_ADC_SEQ             = 0x2,
>> +       AD5592R_REG_CTRL                = 0x3,
>> +       AD5592R_REG_ADC_EN              = 0x4,
>> +       AD5592R_REG_DAC_EN              = 0x5,
>> +       AD5592R_REG_PULLDOWN            = 0x6,
>> +       AD5592R_REG_LDAC                = 0x7,
>> +       AD5592R_REG_GPIO_OUT_EN         = 0x8,
>> +       AD5592R_REG_GPIO_SET            = 0x9,
>> +       AD5592R_REG_GPIO_IN_EN          = 0xA,
>> +       AD5592R_REG_PD                  = 0xB,
>> +       AD5592R_REG_OPEN_DRAIN          = 0xC,
>> +       AD5592R_REG_TRISTATE            = 0xD,
>> +       AD5592R_REG_RESET               = 0xF,
>> +};
>> +
>> +#define AD5592R_REG_PD_EN_REF          BIT(9)
>> +#define AD5592R_REG_CTRL_ADC_RANGE     BIT(5)
>> +#define AD5592R_REG_CTRL_DAC_RANGE     BIT(4)
>> +
>> +struct ad5592r_rw_ops {
>> +       int (*write_dac)(struct ad5592r_state *st, unsigned chan, u16 value);
>> +       int (*read_adc)(struct ad5592r_state *st, unsigned chan, u16 *value);
>> +       int (*reg_write)(struct ad5592r_state *st, u8 reg, u16 value);
>> +       int (*reg_read)(struct ad5592r_state *st, u8 reg, u16 *value);
>> +       int (*gpio_read)(struct ad5592r_state *st, u8 *value);
>> +};
>> +
>> +struct ad5592r_state {
>> +       struct device *dev;
>> +       struct regulator *reg;
>> +#ifdef CONFIG_GPIOLIB
>> +       struct gpio_chip gpiochip;
>> +       struct mutex gpio_lock; /* Protect cached gpio_out, gpio_val, etc. */
>> +#endif
>> +       unsigned int num_channels;
>> +       const struct ad5592r_rw_ops *ops;
>> +       int scale_avail[2][2];
>> +       u16 cached_dac[8];
>> +       u16 cached_gp_ctrl;
>> +       u8 channel_modes[8];
>> +       u8 gpio_map;
>> +       u8 gpio_out;
>> +       u8 gpio_in;
>> +       u8 gpio_val;
>> +
>> +       __be16 spi_msg ____cacheline_aligned;
>> +       __be16 spi_msg_nop;
>> +};
>> +
>> +int ad5592r_probe(struct device *dev, const char *name,
>> +               const struct ad5592r_rw_ops *ops);
>> +int ad5592r_remove(struct device *dev);
>> +
>> +#endif /* __DRIVERS_IIO_DAC_AD5592R_BASE_H__ */
>> diff --git a/drivers/iio/dac/ad5592r.c b/drivers/iio/dac/ad5592r.c
>> new file mode 100644
>> index 0000000..7881160
>> --- /dev/null
>> +++ b/drivers/iio/dac/ad5592r.c
>> @@ -0,0 +1,163 @@
>> +/*
>> + * AD5592R Digital <-> Analog converters driver
>> + *
>> + * Copyright 2015-2016 Analog Devices Inc.
>> + * Author: Paul Cercueil <paul.cercueil@analog.com>
>> + *
>> + * Licensed under the GPL-2.
>> + */
>> +
>> +#include "ad5592r-base.h"
>> +
>> +#include <linux/bitops.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/spi/spi.h>
>> +
>> +#define AD5592R_GPIO_READBACK_EN       BIT(10)
>> +#define AD5592R_LDAC_READBACK_EN       BIT(6)
>> +
>> +static int ad5592r_spi_wnop_r16(struct ad5592r_state *st, u16 *buf)
>> +{
>> +       struct spi_device *spi = container_of(st->dev, struct spi_device, dev);
>> +       struct spi_transfer t = {
>> +                       .tx_buf = &st->spi_msg_nop,
>> +                       .rx_buf = buf,
>> +                       .len = 2
>> +               };
>> +
>> +       st->spi_msg_nop = 0; /* NOP */
>> +
>> +       return spi_sync_transfer(spi, &t, 1);
>> +}
>> +
>> +static int ad5592r_write_dac(struct ad5592r_state *st, unsigned chan, u16 value)
>> +{
>> +       struct spi_device *spi = container_of(st->dev, struct spi_device, dev);
>> +
>> +       st->spi_msg = cpu_to_be16(BIT(15) | (chan << 12) | value);
>> +
>> +       return spi_write(spi, &st->spi_msg, sizeof(st->spi_msg));
>> +}
>> +
>> +static int ad5592r_read_adc(struct ad5592r_state *st, unsigned chan, u16 *value)
>> +{
>> +       struct spi_device *spi = container_of(st->dev, struct spi_device, dev);
>> +       int ret;
>> +
>> +       st->spi_msg = cpu_to_be16((AD5592R_REG_ADC_SEQ << 11) | BIT(chan));
>> +
>> +       ret = spi_write(spi, &st->spi_msg, sizeof(st->spi_msg));
>> +       if (ret)
>> +               return ret;
>> +
>> +       /* Invalid data */
>> +       ret = ad5592r_spi_wnop_r16(st, &st->spi_msg);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = ad5592r_spi_wnop_r16(st, &st->spi_msg);
>> +       if (ret)
>> +               return ret;
>> +
>> +       *value = be16_to_cpu(st->spi_msg);
>> +
>> +       return 0;
>> +}
>> +
>> +static int ad5592r_reg_write(struct ad5592r_state *st, u8 reg, u16 value)
>> +{
>> +       struct spi_device *spi = container_of(st->dev, struct spi_device, dev);
>> +
>> +       st->spi_msg = cpu_to_be16((reg << 11) | value);
>> +
>> +       return spi_write(spi, &st->spi_msg, sizeof(st->spi_msg));
>> +}
>> +
>> +static int ad5592r_reg_read(struct ad5592r_state *st, u8 reg, u16 *value)
>> +{
>> +       struct spi_device *spi = container_of(st->dev, struct spi_device, dev);
>> +       int ret;
>> +
>> +       st->spi_msg = cpu_to_be16((AD5592R_REG_LDAC << 11) |
>> +                                  AD5592R_LDAC_READBACK_EN | (reg << 2));
>> +
>> +       ret = spi_write(spi, &st->spi_msg, sizeof(st->spi_msg));
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = ad5592r_spi_wnop_r16(st, &st->spi_msg);
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (value)
>> +               *value = be16_to_cpu(st->spi_msg);
>> +
>> +       return 0;
>> +}
>> +
>> +static int ad5593r_gpio_read(struct ad5592r_state *st, u8 *value)
>> +{
>> +       int ret;
>> +
>> +       ret = ad5592r_reg_write(st, AD5592R_REG_GPIO_IN_EN,
>> +                               AD5592R_GPIO_READBACK_EN | st->gpio_in);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = ad5592r_spi_wnop_r16(st, &st->spi_msg);
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (value)
>> +               *value = (u8) be16_to_cpu(st->spi_msg);
>
> So if value=0 then we do not error out, but we just leave value intact?

I think we don't need this check at all...


>
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct ad5592r_rw_ops ad5592r_rw_ops = {
>> +       .write_dac = ad5592r_write_dac,
>> +       .read_adc = ad5592r_read_adc,
>> +       .reg_write = ad5592r_reg_write,
>> +       .reg_read = ad5592r_reg_read,
>> +       .gpio_read = ad5593r_gpio_read,
>> +};
>> +
>> +static int ad5592r_spi_probe(struct spi_device *spi)
>> +{
>> +       const struct spi_device_id *id = spi_get_device_id(spi);
>> +
>> +       return ad5592r_probe(&spi->dev, id->name, &ad5592r_rw_ops);
>> +}
>> +
>> +static int ad5592r_spi_remove(struct spi_device *spi)
>> +{
>> +       return ad5592r_remove(&spi->dev);
>> +}
>> +
>> +static const struct spi_device_id ad5592r_spi_ids[] = {
>> +       { .name = "ad5592r", },
>> +       {}
>> +};
>> +MODULE_DEVICE_TABLE(spi, ad5592r_spi_ids);
>> +
>> +static const struct of_device_id ad5592r_of_match[] = {
>> +       { .compatible = "adi,ad5592r", },
>> +       {},
>> +};
>> +MODULE_DEVICE_TABLE(of, ad5592r_of_match);
>> +
>> +static struct spi_driver ad5592r_spi_driver = {
>> +       .driver = {
>> +               .name = "ad5592r",
>> +               .of_match_table = of_match_ptr(ad5592r_of_match),
>> +       },
>> +       .probe = ad5592r_spi_probe,
>> +       .remove = ad5592r_spi_remove,
>> +       .id_table = ad5592r_spi_ids,
>> +};
>> +module_spi_driver(ad5592r_spi_driver);
>> +
>> +MODULE_AUTHOR("Paul Cercueil <paul.cercueil@analog.com>");
>> +MODULE_DESCRIPTION("Analog Devices AD5592R multi-channel converters");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/iio/dac/ad5593r.c b/drivers/iio/dac/ad5593r.c
>> new file mode 100644
>> index 0000000..dd52cab
>> --- /dev/null
>> +++ b/drivers/iio/dac/ad5593r.c
>> @@ -0,0 +1,136 @@
>> +/*
>> + * AD5593R Digital <-> Analog converters driver
>> + *
>> + * Copyright 2015-2016 Analog Devices Inc.
>> + * Author: Paul Cercueil <paul.cercueil@analog.com>
>> + *
>> + * Licensed under the GPL-2.
>> + */
>> +
>> +#include "ad5592r-base.h"
>> +
>> +#include <linux/bitops.h>
>> +#include <linux/i2c.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +
>> +#define AD5593R_MODE_CONF              (0 << 4)
>> +#define AD5593R_MODE_DAC_WRITE         (1 << 4)
>> +#define AD5593R_MODE_ADC_READBACK      (4 << 4)
>> +#define AD5593R_MODE_DAC_READBACK      (5 << 4)
>> +#define AD5593R_MODE_GPIO_READBACK     (6 << 4)
>> +#define AD5593R_MODE_REG_READBACK      (7 << 4)
>> +
>> +static int ad5593r_write_dac(struct ad5592r_state *st, unsigned chan, u16 value)
>> +{
>> +       struct i2c_client *i2c = to_i2c_client(st->dev);
>> +
>> +       return i2c_smbus_write_word_swapped(i2c,
>> +                       AD5593R_MODE_DAC_WRITE | chan, value);
>> +}
>> +
>> +static int ad5593r_read_adc(struct ad5592r_state *st, unsigned chan, u16 *value)
>> +{
>> +       struct i2c_client *i2c = to_i2c_client(st->dev);
>> +       s32 val;
>> +
>> +       val = i2c_smbus_write_word_swapped(i2c,
>> +                       AD5593R_MODE_CONF | AD5592R_REG_ADC_SEQ, BIT(chan));
>> +       if (val < 0)
>> +               return (int) val;
>> +
>> +       /* Invalid data */
>> +       val = i2c_smbus_read_word_swapped(i2c, AD5593R_MODE_ADC_READBACK);
>> +       if (val < 0)
>> +               return (int) val;
>
> This above seems like a nasty hack - for hardware or something else?

The AD5592R SPI version requires this extra read.
It's part of the required sequence.

Figure 40. Single-Channel ADC Conversion Sequence.

But for the I2C version it doesn't seem to be necessary.
I'll double check.


>
>> +
>> +       val = i2c_smbus_read_word_swapped(i2c, AD5593R_MODE_ADC_READBACK);
>> +       if (val < 0)
>> +               return (int) val;
>> +
>> +       *value = (u16) val;
>> +
>> +       return 0;
>> +}
>> +
>> +static int ad5593r_reg_write(struct ad5592r_state *st, u8 reg, u16 value)
>> +{
>> +       struct i2c_client *i2c = to_i2c_client(st->dev);
>> +
>> +       return i2c_smbus_write_word_swapped(i2c,
>> +                       AD5593R_MODE_CONF | reg, value);
>> +}
>> +
>> +static int ad5593r_reg_read(struct ad5592r_state *st, u8 reg, u16 *value)
>> +{
>> +       struct i2c_client *i2c = to_i2c_client(st->dev);
>> +       s32 val;
>> +
>> +       val = i2c_smbus_read_word_swapped(i2c, AD5593R_MODE_REG_READBACK | reg);
>> +       if (val < 0)
>> +               return (int) val;
>> +
>> +       *value = (u16) val;
>> +
>> +       return 0;
>> +}
>> +
>> +static int ad5593r_gpio_read(struct ad5592r_state *st, u8 *value)
>> +{
>> +       struct i2c_client *i2c = to_i2c_client(st->dev);
>> +       s32 val;
>> +
>> +       val = i2c_smbus_read_word_swapped(i2c, AD5593R_MODE_GPIO_READBACK);
>> +       if (val < 0)
>> +               return (int) val;
>> +
>> +       *value = (u8) val;
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct ad5592r_rw_ops ad5593r_rw_ops = {
>> +       .write_dac = ad5593r_write_dac,
>> +       .read_adc = ad5593r_read_adc,
>> +       .reg_write = ad5593r_reg_write,
>> +       .reg_read = ad5593r_reg_read,
>> +       .gpio_read = ad5593r_gpio_read,
>> +};
>> +
>> +static int ad5593r_i2c_probe(struct i2c_client *i2c,
>> +               const struct i2c_device_id *id)
>> +{
>> +       return ad5592r_probe(&i2c->dev, id->name, &ad5593r_rw_ops);
>> +}
>> +
>> +static int ad5593r_i2c_remove(struct i2c_client *i2c)
>> +{
>> +       return ad5592r_remove(&i2c->dev);
>> +}
>> +
>> +static const struct i2c_device_id ad5593r_i2c_ids[] = {
>> +       { .name = "ad5593r", },
>> +       {},
>> +};
>> +MODULE_DEVICE_TABLE(i2c, ad5593r_i2c_ids);
>> +
>> +static const struct of_device_id ad5593r_of_match[] = {
>> +       { .compatible = "adi,ad5593r", },
>> +       {},
>> +};
>> +MODULE_DEVICE_TABLE(of, ad5593r_of_match);
>> +
>> +static struct i2c_driver ad5593r_driver = {
>> +       .driver = {
>> +               .name = "ad5593r",
>> +               .of_match_table = of_match_ptr(ad5593r_of_match),
>> +       },
>> +       .probe = ad5593r_i2c_probe,
>> +       .remove = ad5593r_i2c_remove,
>> +       .id_table = ad5593r_i2c_ids,
>> +};
>> +module_i2c_driver(ad5593r_driver);
>> +
>> +MODULE_AUTHOR("Paul Cercueil <paul.cercueil@analog.com>");
>> +MODULE_DESCRIPTION("Analog Devices AD5592R multi-channel converters");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/include/dt-bindings/iio/adi,ad5592r.h b/include/dt-bindings/iio/adi,ad5592r.h
>> new file mode 100644
>> index 0000000..6bd519b
>> --- /dev/null
>> +++ b/include/dt-bindings/iio/adi,ad5592r.h
>> @@ -0,0 +1,16 @@
>> +
>> +#ifndef _DT_BINDINGS_ADI_AD5592R_H
>> +#define _DT_BINDINGS_ADI_AD5592R_H
>> +
>> +
>> +#define CH_MODE_ADC                    1
>> +#define CH_MODE_DAC                    2
>> +#define CH_MODE_DAC_AND_ADC            3
>> +#define CH_MODE_UNUSED_PULL_DOWN       4
>> +#define CH_MODE_UNUSED_OUT_LOW         5
>> +#define CH_MODE_UNUSED_OUT_HIGH                6
>> +#define CH_MODE_UNUSED_OUT_TRISTATE    7
>> +#define CH_MODE_GPIO                   8
>> +#define CH_MODE_GPIO_OPEN_DRAIN                9
>> +
>> +#endif /* _DT_BINDINGS_ADI_AD5592R_H */
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
