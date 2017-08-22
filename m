Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:4538 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932660AbdHVOE0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Aug 2017 10:04:26 -0400
Date: Tue, 22 Aug 2017 15:03:30 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <s.abhisit@gmail.com>
CC: <lee.jones@linaro.org>, <pmeerw@pmeerw.net>, <jacopo@jmondi.org>,
        <linus.walleij@linaro.org>, <linux-kernel@vger.kernel.org>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <fabrice.gasnier@st.com>,
        <robh@kernel.org>, <akinobu.mita@gmail.com>,
        <marek.vasut+renesas@gmail.com>, <jacopo+renesas@jmondi.org>,
        <mike.looijmans@topic.nl>, <peda@axentia.se>,
        <jeff.dagenais@gmail.com>, <linux-iio@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH] mfd: Add support for TI LMP92001
Message-ID: <20170822150330.00007eeb@huawei.com>
In-Reply-To: <1503383171-15515-1-git-send-email-s.abhisit@gmail.com>
References: <1503383171-15515-1-git-send-email-s.abhisit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 22 Aug 2017 13:26:11 +0700
<s.abhisit@gmail.com> wrote:

> From: Abhisit Sangjan <s.abhisit@gmail.com>
> 
> TI LMP92001 Analog System Monitor and Controller
> 
> 8-bit GPIOs.
> 12 DACs with 12-bit resolution.
> The GPIOs and DACs are shared port function with Cy function pin to
> take control the pin suddenly from external hardware.
> DAC's referance voltage selectable for Internal/External.
> 
> 16 + 1 ADCs with 12-bit resolution.
> Built-in internal Temperature Sensor on channel 17.
> Windows Comparator Function is supported on channel 1-3 and 9-11 for
> monitoring with interrupt signal (pending to implement for interrupt).
> ADC's referance voltage selectable for Internal/External.
> 
> Signed-off-by: Abhisit Sangjan <s.abhisit@gmail.com>

As Lee said, break this up.  I've done a quick read through but much easier
to parse in smaller parts!

> ---
>  Documentation/ABI/testing/sysfs-bus-iio-lmp920001  |  92 ++++
>  .../devicetree/bindings/gpio/gpio-lmp92001.txt     |  22 +
>  .../bindings/iio/adc/ti-lmp92001-adc.txt           |  21 +
>  .../bindings/iio/dac/ti-lmp92001-dac.txt           |  35 ++
>  drivers/gpio/Kconfig                               |   7 +
>  drivers/gpio/Makefile                              |   1 +
>  drivers/gpio/gpio-lmp92001.c                       | 209 +++++++++
>  drivers/iio/adc/Kconfig                            |  10 +
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/lmp92001-adc.c                     | 500 +++++++++++++++++++++
>  drivers/iio/dac/Kconfig                            |   9 +
>  drivers/iio/dac/Makefile                           |   1 +
>  drivers/iio/dac/lmp92001-dac.c                     | 390 ++++++++++++++++
>  drivers/mfd/Kconfig                                |  12 +
>  drivers/mfd/Makefile                               |   4 +
>  drivers/mfd/lmp92001-core.c                        | 308 +++++++++++++
>  drivers/mfd/lmp92001-debug.c                       |  67 +++
>  drivers/mfd/lmp92001-i2c.c                         | 215 +++++++++
>  include/linux/mfd/lmp92001/core.h                  | 119 +++++
>  include/linux/mfd/lmp92001/debug.h                 |  28 ++
>  20 files changed, 2051 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-lmp920001
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-lmp92001.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-lmp92001-adc.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/ti-lmp92001-dac.txt
>  create mode 100644 drivers/gpio/gpio-lmp92001.c
>  create mode 100644 drivers/iio/adc/lmp92001-adc.c
>  create mode 100644 drivers/iio/dac/lmp92001-dac.c
>  create mode 100644 drivers/mfd/lmp92001-core.c
>  create mode 100644 drivers/mfd/lmp92001-debug.c
>  create mode 100644 drivers/mfd/lmp92001-i2c.c
>  create mode 100644 include/linux/mfd/lmp92001/core.h
>  create mode 100644 include/linux/mfd/lmp92001/debug.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-lmp920001 b/Documentation/ABI/testing/sysfs-bus-iio-lmp920001
> new file mode 100644
> index 0000000..bd4e733
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-lmp920001
> @@ -0,0 +1,92 @@
> +What:           /sys/bus/iio/devices/iio:deviceX/gang
> +Date:		August 2016
> +KernelVersion:  4.1.15
> +Contact:        Abhisit Sangjan <s.abhisit@gmail.com>
> +Description:
> +		Controls the association of analog output channels OUTx with
> +		asynchronous control inputs Cy for DAC.
> +                Can be either:
> +                - "0"
> +                - "1"
> +
> +			Cy to OUTx Assignment
> +		----------------------------------
> +		| Cy | CDAC:GANG=0 | CDAC:GANG=1 |
> +		----------------------------------
> +		| C1 | OUT[1:4]    | OUT[1:3]    |
> +		----------------------------------
> +		| C2 | OUT[5:6]    | OUT[4:6]    |
> +		----------------------------------
> +		| C3 | OUT[7:8]    | OUT[7:9]    |
> +		----------------------------------
> +		| C4 | OUT[9:12]   | OUT[10:12]  |
> +		----------------------------------

Hmm. I'll want to think about this one.  It probably wants a more
descriptive name.
> +
> +What:           /sys/bus/iio/devices/iio:deviceX/outx
> +Date:		August 2016
> +KernelVersion:  4.1.15
> +Contact:        Abhisit Sangjan <s.abhisit@gmail.com>
> +Description:
> +		The pin output mode for DAC.
> +                Can be either:
> +                - "hiz" = High impedance state.
> +                - "dac" = DAC output.
> +		- "0" = Drive it to low.
> +		- "1" = Drive it to high.
Look at the existing ABI for powerdown modes.  Covers this.

> +
> +What:           /sys/bus/iio/devices/iio:deviceX/vref
> +Date:		August 2016
> +KernelVersion:  4.1.15
> +Contact:        Abhisit Sangjan <s.abhisit@gmail.com>
> +Description:
> +		This is voltage referance source for DACs.
> +                Can be either:
> +                - "external"
> +                - "internal"

Normal assumption is that if an external reference is provided by
the hardware (specified in DT of similar) then we want to use it,
if not fall back to internal.

i.e. I don't think we have ever exposed this to userspace.

> +
> +What:           /sys/devices/socX/soc/XXXXXXX.aips-bus/XXXXXXX.i2c/i2c-X/X-00XX/lmp92001-adc.X.auto/iio:deviceX/en

Why the insanely long path rather than
/sys/bus/iio/device/iio:deviceX/en ?

> +Date:		August 2016
> +KernelVersion:  4.1.15
> +Contact:        Abhisit Sangjan <s.abhisit@gmail.com>
> +Description:
> +		This is ADC Conversion Enable for each channel.
> +                Can be either:
> +                - "enable"
> +                - "disable"

Current form isn't per channel. Should be covered by buffered mode
scan_elements or the driver should be able to figure it out based
on what channel is being read.  Would not expect to see individual
channel enables for an ADC.


> +
> +What:           /sys/devices/socX/soc/XXXXXXX.aips-bus/XXXXXXX.i2c/i2c-X/X-00XX/lmp92001-adc.X.auto/iio:deviceX/mode

Again, short path please.

> +Date:		August 2016
> +KernelVersion:  4.1.15
> +Contact:        Abhisit Sangjan <s.abhisit@gmail.com>
> +Description:
> +		This is conversion mode for all of ADCs.
> +                Can be either:
> +                - "continuous" = Continuously conversion all the time.
> +                - "single-shot" = Once time conversion and stop.

Which of these makes sense is usually possible to figure out from the way the
driver is being used.  This isn't something we want userspace to have to
specify.

> +
> +What:           /sys/devices/socX/soc/XXXXXXX.aips-bus/XXXXXXX.i2c/i2c-X/X-00XX/lmp92001-adc.X.auto/iio:deviceX/vref
> +Date:		August 2016
> +KernelVersion:  4.1.15
> +Contact:        Abhisit Sangjan <s.abhisit@gmail.com>
> +Description:
> +		This is voltage referance source for ADCs.
> +                Can be either:
> +                - "external"
> +                - "internal"

Again, tends to be a hardware platform defined thing rather than
something it makes sense to expose to userspace.

> +
> +What:           /sys/devices/socX/soc/XXXXXXX.aips-bus/XXXXXXX.i2c/i2c-X/X-00XX/lmp92001-adc.X.auto/iio:deviceX/events/in_voltageX_thresh_{falling|rising}_en
> +Date:		August 2016
> +KernelVersion:  4.1.15
> +Contact:        Abhisit Sangjan <s.abhisit@gmail.com>
> +Description:
> +		This is ADC's Windows Comparator Function enable for falling and rising.
> +		Supported channels are 1-3 and 9-11.

This is standard ABI - you don't need to document it.

> +
> +What:           /sys/devices/socX/soc/XXXXXXX.aips-bus/XXXXXXX.i2c/i2c-X/X-00XX/lmp92001-adc.X.auto/iio:deviceX/events/in_voltageX_thresh_{falling|rising}_value
> +Date:		August 2016
> +KernelVersion:  4.1.15
> +Contact:        Abhisit Sangjan <s.abhisit@gmail.com>
> +Description:
> +		This is ADC's Windows Comparator Function value for falling and rising.
> +		Supported channels are 1-3 and 9-11.
> +		The possible range is 0 - 2047.

Standard ABI again, no need to document here.

> diff --git a/Documentation/devicetree/bindings/gpio/gpio-lmp92001.txt b/Documentation/devicetree/bindings/gpio/gpio-lmp92001.txt
> new file mode 100644
> index 0000000..c68784e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/gpio-lmp92001.txt
> @@ -0,0 +1,22 @@
> +* Texas Instruments' LMP92001 GPIOs
> +
> +Required properties:
> + - compatible: Must be set to "ti,lmp92001-gpio".
> + - reg: i2c chip address for the device.
> + - gpio-controller: Marks the device node as a gpio controller.
> + - #gpio-cells : Should be two.  The first cell is the pin number and the
> +  second cell is used to specify the gpio polarity:
> +        0 = Active high
> +        1 = Active low
> +
> +Example:
> +lmp92001@20 {
> +        compatible = "ti,lmp92001";
> +        reg = <0x20>;
> +
> +        lmp92001_gpio: lmp92001-gpio {
> +                compatible = "ti,lmp92001-gpio";
> +                gpio-controller;
> +                #gpio-cells = <2>;
> +        };
> +};
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti-lmp92001-adc.txt b/Documentation/devicetree/bindings/iio/adc/ti-lmp92001-adc.txt
> new file mode 100644
> index 0000000..34d7809
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti-lmp92001-adc.txt
> @@ -0,0 +1,21 @@
> +* Texas Instruments' LMP92001 ADCs
> +
> +Required properties:
> + - compatible: Must be set to "ti,lmp92001-adc".
> + - reg: i2c chip address for the device.
> + - ti,lmp92001-adc-mode: adc operation, either continuous or single-shot.
> + - ti,lmp92001-adc-mask: bit mask for which channel is enable.
> +        0 = Off
> +        1 = On

There is a standard IIO syntax for defining which channels are enabled.
Take a look at other bindings.

There is often some extra stuff to be specified for each channel so a mask
isn't sufficient.  Hence we use a child node to specify each channel.

> +
> +Example:
> +lmp92001@20 {
> +        compatible = "ti,lmp92001";
> +        reg = <0x20>;
> +
> +        lmp92001-adc {
> +                compatible = "ti,lmp92001-adc";
> +                ti,lmp92001-adc-mode = "continuous";
> +                ti,lmp92001-adc-mask = <0x00000079>;

Would definitely expect to see an external reference specified here..

> +        };
> +};
> \ No newline at end of file

Add one please.

> diff --git a/Documentation/devicetree/bindings/iio/dac/ti-lmp92001-dac.txt b/Documentation/devicetree/bindings/iio/dac/ti-lmp92001-dac.txt
> new file mode 100644
> index 0000000..882db9c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/ti-lmp92001-dac.txt
> @@ -0,0 +1,35 @@
> +* Texas Instruments' LMP92001 DACs
> +
> +Required properties:
> + - compatible: Must be set to "ti,lmp92001-dac".
> + - reg: i2c chip address for the device.
> + - ti,lmp92001-dac-hiz: hi-impedance control,
> +        1 = Forces all OUT[1:12] outputs to hi-z, 0 = normal

Leave control of this to userspace unless it is a feature controlled
by the associated circuitry.

> + - ti,lmp92001-dac-outx:
> +        Cy = 0, 1 = will force associated OUTx outputs to VDD
> +        Cy = 0, 0 = will force associated OUTx outputs to GND
> + - ti,lmp92001-dac-gang: What group of Cy is governed to.
> +        -----------------------------------------
> +        |  Cy   | CDAC:GANG = 0 | CDAC:GANG = 1 |
> +        -----------------------------------------
> +        |  C1   |   OUT[1:4]    |    OUT[1:3]   |
> +        -----------------------------------------
> +        |  C2   |   OUT[5:6]    |    OUT[4:6]   |
> +        -----------------------------------------
> +        |  C3   |   OUT[7:8]    |    OUT[7:9]   |
> +        -----------------------------------------
> +        |  C4   |   OUT[9:12]   |    OUT[10:12] |
> +        -----------------------------------------

If this is here, then why are we exposing it to userspace?
Either this is a feature of the hardware or it's not...

> +
> +Example:
> +lmp92001@20 {
> +        compatible = "ti,lmp92001";
> +        reg = <0x20>;
> +
> +        lmp92001-dac {
> +                compatible = "ti,lmp92001-dac";
> +                ti,lmp92001-dac-hiz  = /bits/ 8 <0>;
> +                ti,lmp92001-dac-outx = /bits/ 8 <0>;
> +                ti,lmp92001-dac-gang = /bits/ 8 <0>;
> +        };
> +};
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 461d6fc..5962ea0 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -948,6 +948,13 @@ config GPIO_KEMPLD
>  	  This driver can also be built as a module. If so, the module will be
>  	  called gpio-kempld.
>  
> +config GPIO_LMP92001
> +       tristate "LMP92001 GPIOs"
> +       depends on MFD_LMP92001
> +       help
> +         Say yes here to access the GPIO signals of TI LMP92001 Analog System
> +         Monitor and Controller.
> +
>  config GPIO_LP3943
>  	tristate "TI/National Semiconductor LP3943 GPIO expander"
>  	depends on MFD_LP3943
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index a9fda6c..560d59c 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -62,6 +62,7 @@ obj-$(CONFIG_GPIO_JANZ_TTL)	+= gpio-janz-ttl.o
>  obj-$(CONFIG_GPIO_KEMPLD)	+= gpio-kempld.o
>  obj-$(CONFIG_ARCH_KS8695)	+= gpio-ks8695.o
>  obj-$(CONFIG_GPIO_INTEL_MID)	+= gpio-intel-mid.o
> +obj-$(CONFIG_GPIO_LMP92001)	+= gpio-lmp92001.o
>  obj-$(CONFIG_GPIO_LOONGSON)	+= gpio-loongson.o
>  obj-$(CONFIG_GPIO_LP3943)	+= gpio-lp3943.o
>  obj-$(CONFIG_GPIO_LPC18XX)	+= gpio-lpc18xx.o
> diff --git a/drivers/gpio/gpio-lmp92001.c b/drivers/gpio/gpio-lmp92001.c
> new file mode 100644
> index 0000000..b80ba4e
> --- /dev/null
> +++ b/drivers/gpio/gpio-lmp92001.c
> @@ -0,0 +1,209 @@
> +/*
> + * gpio-lmp92001.c - Support for TI LMP92001 GPIOs
> + *
> + * Copyright 2016-2017 Celestica Ltd.
> + *
> + * Author: Abhisit Sangjan <s.abhisit@gmail.com>
> + *
> + * Inspired by wm831x driver.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *

Drop this blank line.

> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +
> +#include <linux/mfd/lmp92001/core.h>
> +
> +#define SGEN_GPI	(1 << 0) /* 1 - if any bit in SGPI is set. */
> +
> +struct lmp92001_gpio {
> +	struct lmp92001 *lmp92001;
> +	struct gpio_chip gpio_chip;
> +};
> +
> +static int lmp92001_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
> +{
> +	struct lmp92001_gpio *lmp92001_gpio = gpiochip_get_data(chip);
> +	struct lmp92001 *lmp92001 = lmp92001_gpio->lmp92001;
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(lmp92001->regmap, LMP92001_CGPO, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return (val >> offset) & BIT(0);

return !!(val & BIT(offset))?

> +}
> +
> +static int lmp92001_gpio_direction_in(struct gpio_chip *chip, unsigned offset)
> +{
> +	struct lmp92001_gpio *lmp92001_gpio = gpiochip_get_data(chip);
> +	struct lmp92001 *lmp92001 = lmp92001_gpio->lmp92001;
> +
> +	return regmap_update_bits(lmp92001->regmap, LMP92001_CGPO, BIT(offset),
> +					BIT(offset));
> +}
> +
> +static int lmp92001_gpio_get(struct gpio_chip *chip, unsigned offset)
> +{
> +	struct lmp92001_gpio *lmp92001_gpio = gpiochip_get_data(chip);
> +	struct lmp92001 *lmp92001 = lmp92001_gpio->lmp92001;
> +	unsigned int val, sgen;
> +
> +	/*
> +	 * Does the GPIO input mode?
> +	 * Does the GPIO was set?
> +	 * Reading indicated logic level.
> +	 * Clear indicated logic level.
> +	 */
> +	regmap_read(lmp92001->regmap, LMP92001_CGPO, &val);
> +	if ((val >> offset) & BIT(0)) {
> +		regmap_read(lmp92001->regmap, LMP92001_SGEN, &sgen);
> +		if (sgen & SGEN_GPI) {
> +			regmap_read(lmp92001->regmap, LMP92001_SGPI, &val);
> +			regmap_update_bits(lmp92001->regmap, LMP92001_CGPO,
> +						0xFF, val);
> +		}
> +	}
> +
> +	return !!(val & BIT(offset));

Consistency!

> +}
> +
> +static int lmp92001_gpio_direction_out(struct gpio_chip *chip, unsigned offset,
> +	int value)

Fix indenting of parameters to align please.

> +{
> +	struct lmp92001_gpio *lmp92001_gpio = gpiochip_get_data(chip);
> +	struct lmp92001 *lmp92001 = lmp92001_gpio->lmp92001;
> +
> +	return regmap_update_bits(lmp92001->regmap, LMP92001_CGPO, BIT(offset),
> +					0 << offset);

shifting 0 does seem a little odd.

> +}
> +
> +static void lmp92001_gpio_set(struct gpio_chip *chip, unsigned offset,
> +	int value)
> +{
> +	struct lmp92001_gpio *lmp92001_gpio = gpiochip_get_data(chip);
> +	struct lmp92001 *lmp92001 = lmp92001_gpio->lmp92001;
> +
> +	regmap_update_bits(lmp92001->regmap, LMP92001_CGPO, BIT(offset),
> +				value << offset);
> +}
> +
> +#ifdef CONFIG_DEBUG_FS
> +static void lmp92001_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
> +{
> +	struct lmp92001_gpio *lmp92001_gpio = gpiochip_get_data(chip);
> +	struct lmp92001 *lmp92001 = lmp92001_gpio->lmp92001;
> +	int i, gpio;
> +	unsigned int cgpo;
> +	const char *label, *dir, *logic;
> +
> +	for (i = 0; i < chip->ngpio; i++) {
> +		gpio = i + chip->base;
> +
> +		label = gpiochip_is_requested(chip, i);
> +		if (!label)
> +			continue;
> +
> +		regmap_read(lmp92001->regmap, LMP92001_CGPO, &cgpo);
> +		if ((cgpo>>i) & BIT(0))
> +			dir = "in";
> +		else
> +			dir = "out";
> +
> +		if (lmp92001_gpio_get(chip, i))
> +			logic = "hi";
> +		else
> +			logic = "lo";
> +
> +		seq_printf(s, " gpio-%-3d (%-20.20s) %-3.3s %-2.2s\n",
> +				gpio, label, dir, logic);
> +	}
> +}
> +#else
> +#define lmp92001_gpio_dbg_show NULL
> +#endif
> +
> +static struct gpio_chip lmp92001_gpio_chip = {
> +	.label			= "lmp92001",
> +	.owner			= THIS_MODULE,
> +	.get_direction		= lmp92001_gpio_get_direction,
> +	.direction_input	= lmp92001_gpio_direction_in,
> +	.get			= lmp92001_gpio_get,
> +	.direction_output	= lmp92001_gpio_direction_out,
> +	.set			= lmp92001_gpio_set,
> +	.dbg_show		= lmp92001_gpio_dbg_show,
> +};
> +
> +static int lmp92001_gpio_probe(struct platform_device *pdev)
> +{
> +	struct lmp92001 *lmp92001 = dev_get_drvdata(pdev->dev.parent);
> +	struct lmp92001_gpio *lmp92001_gpio;
> +	int ret;
> +
> +	lmp92001_gpio = devm_kzalloc(&pdev->dev, sizeof(*lmp92001_gpio),
> +					GFP_KERNEL);
> +	if (!lmp92001_gpio)
> +		return -ENOMEM;
> +
> +	lmp92001_gpio->lmp92001 = lmp92001;
> +	lmp92001_gpio->gpio_chip = lmp92001_gpio_chip;
> +	lmp92001_gpio->gpio_chip.ngpio = 8;
> +	lmp92001_gpio->gpio_chip.parent = &pdev->dev;
> +	lmp92001_gpio->gpio_chip.base = -1;
> +
> +	ret = devm_gpiochip_add_data(&pdev->dev, &lmp92001_gpio->gpio_chip,
> +					lmp92001_gpio);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "could not register gpiochip, %d\n", ret);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, lmp92001_gpio);
> +
> +	return ret;
> +}
> +
> +static int lmp92001_gpio_remove(struct platform_device *pdev)
> +{
> +	struct lmp92001_gpio *lmp92001_gpio = platform_get_drvdata(pdev);
> +
> +	devm_gpiochip_remove(&pdev->dev, &lmp92001_gpio->gpio_chip);

Look up what devm is all about please.  This is not needed - nor is the
remove at all...

> +
> +	return 0;
> +}
> +
> +static struct platform_driver lmp92001_gpio_driver = {
> +	.driver.name	= "lmp92001-gpio",
> +	.probe		= lmp92001_gpio_probe,
> +	.remove		= lmp92001_gpio_remove,
> +};
> +
> +static int __init lmp92001_gpio_init(void)
> +{
> +	return platform_driver_register(&lmp92001_gpio_driver);
> +}
> +subsys_initcall(lmp92001_gpio_init);

Do we actually need to do this as a subsys_initcall rather than
relying on deferred probing?

> +
> +static void __exit lmp92001_gpio_exit(void)
> +{
> +	platform_driver_unregister(&lmp92001_gpio_driver);
> +}
> +module_exit(lmp92001_gpio_exit);
> +
> +MODULE_AUTHOR("Abhisit Sangjan <s.abhisit@gmail.com>");
> +MODULE_DESCRIPTION("GPIO interface for TI LMP92001");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:lmp92001-gpio");
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 614fa41..2adeba5 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -331,6 +331,16 @@ config IMX7D_ADC
>  	  This driver can also be built as a module. If so, the module will be
>  	  called imx7d_adc.
>  
> +config LMP92001_ADC
> +       tristate "TI LMP92001 ADC Driver"
> +       depends on MFD_LMP92001
> +       help
> +         If you say yes here you get support for TI LMP92001 ADCs
> +         conversion.
> +
> +         This driver can also be built as a module. If so, the module will
> +         be called lmp92001_adc.
> +
>  config LP8788_ADC
>  	tristate "LP8788 ADC driver"
>  	depends on MFD_LP8788
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index b546736a..2ed8986 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -31,6 +31,7 @@ obj-$(CONFIG_HI8435) += hi8435.o
>  obj-$(CONFIG_HX711) += hx711.o
>  obj-$(CONFIG_IMX7D_ADC) += imx7d_adc.o
>  obj-$(CONFIG_INA2XX_ADC) += ina2xx-adc.o
> +obj-$(CONFIG_LMP92001_ADC) += lmp92001-adc.o
>  obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
>  obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
>  obj-$(CONFIG_LPC32XX_ADC) += lpc32xx_adc.o
> diff --git a/drivers/iio/adc/lmp92001-adc.c b/drivers/iio/adc/lmp92001-adc.c
> new file mode 100644
> index 0000000..8e64b51
> --- /dev/null
> +++ b/drivers/iio/adc/lmp92001-adc.c
> @@ -0,0 +1,500 @@
> +/*
> + * lmp92001-adc.c - Support for TI LMP92001 ADCs
> + *
> + * Copyright 2016-2017 Celestica Ltd.
> + *
> + * Author: Abhisit Sangjan <s.abhisit@gmail.com>
> + *
> + * Inspired by wm831x and ad5064 drivers.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/iio/iio.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include <linux/mfd/lmp92001/core.h>
> +
> +#define CGEN_STRT	(1 << 0) /* Is continuous conversion all of ADCs? */
> +#define CGEN_LCK	(1 << 1) /* Is lock the HW register? */

BIT() where appropriate.

> +#define CGEN_RST	(1 << 7) /* Reset all registers. */
> +
> +#define CREF_AEXT	(1 << 1) /* 1 - ADC external reference.
> +				  * 0 - ADC internal reference.
> +				  */

Just move the comments above rather than doing this - also
please use standard multiline comment syntax.

> +
> +static int lmp92001_read_raw(struct iio_dev *indio_dev,
> +	struct iio_chan_spec const *channel,
> +	int *val, int *val2,
> +	long mask)

Align paramaters.

> +{
> +	struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
> +	unsigned int code, cgen, sgen, try;
> +	int ret;
> +
> +	mutex_lock(&lmp92001->adc_lock);
> +
> +	ret = regmap_read(lmp92001->regmap, LMP92001_CGEN, &cgen);
> +	if (ret < 0)
> +		goto exit;
> +
> +	/*
> +	 * Is not continuous conversion?
> +	 * Lock the HW registers (if needed).
> +	 * Triggering single-short conversion.
> +	 * Waiting for conversion successfully.
> +	 */
> +	if (!(cgen & CGEN_STRT)) {
> +		if (!(cgen & CGEN_LCK)) {
> +			ret = regmap_update_bits(lmp92001->regmap,
> +					LMP92001_CGEN, CGEN_LCK, CGEN_LCK);
> +			if (ret < 0)
> +				goto exit;
> +		}
> +
> +		/* Writing any value to triggered Single-Shot conversion. */
> +		ret = regmap_write(lmp92001->regmap, LMP92001_CTRIG, 1);
> +		if (ret < 0)
> +			goto exit;
> +
> +		/* In case of conversion is in-progress, repeat for 10 times. */
> +		try = 10;
> +		do {
> +			ret = regmap_read(lmp92001->regmap,
> +						LMP92001_SGEN, &sgen);
> +			if (ret < 0)
> +				goto exit;
> +		} while ((sgen & CGEN_RST) && (--try > 0));
> +
> +		if (!try) {
> +			ret = -ETIME;
> +			goto exit;
> +		}
> +	}
Move this whole block to be single shot only.  Keep continuous for
triggered buffer usage.

Does this device have a dataready interrupt? Otherwise you'll probably want to
do buffers with out the trigger and use a thread to monitor this complete
signal at 2x the expected frequency (so we don't miss any samples).


> +
> +	ret = regmap_read(lmp92001->regmap, 0x1F + channel->channel, &code);
unlock here.
> +	if (ret < 0)
> +		goto exit;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (channel->type) {
> +		case IIO_VOLTAGE:
> +		case IIO_TEMP:
> +			*val = code;
> +			ret = IIO_VAL_INT;
> +			goto exit;
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	/* In case of no match channel info/type is return here. */
> +	ret = -EINVAL;
Move this into the default and direct return in the switch statement.

You will need an error handling path still to do the unlock of course.


> +
> +exit:
> +	mutex_unlock(&lmp92001->adc_lock);
> +
> +	return ret;
> +}
> +
> +static const struct iio_info lmp92001_info = {
> +	.read_raw = lmp92001_read_raw,
> +	.driver_module = THIS_MODULE,

I'll probably clean this up during a merge, but the need
to set driver_module is going away very soon.

> +};
> +
> +static ssize_t lmp92001_avref_read(struct iio_dev *indio_dev,
> +	uintptr_t private, struct iio_chan_spec const *channel, char *buf)
> +{
> +	struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
> +	unsigned int cref;
> +	int ret;
> +
> +	ret = regmap_read(lmp92001->regmap, LMP92001_CREF, &cref);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buf, "%s\n", cref & CREF_AEXT ? "external" : "internal");
> +}
> +
> +static ssize_t lmp92001_avref_write(struct iio_dev *indio_dev,
> +	uintptr_t private, struct iio_chan_spec const *channel,
> +	const char *buf, size_t len)
> +{
> +	struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
> +	unsigned int cref;
> +	int ret;
> +
> +	if (strncmp("external", buf, 8) == 0)
> +		cref = 2;
> +	else if (strncmp("internal", buf, 8) == 0)
> +		cref = 0;
> +	else
> +		return -EINVAL;
> +
> +	ret = regmap_update_bits(lmp92001->regmap, LMP92001_CREF, CREF_AEXT,
> +					cref);
> +	if (ret < 0)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static ssize_t lmp92001_enable_read(struct iio_dev *indio_dev,
> +	uintptr_t private, struct iio_chan_spec const *channel, char *buf)
> +{
> +	struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
> +	unsigned int reg, cad;
> +	int ret;

As stated below, do this all by supplying triggered  buffer support.
For sysfs reads the overhead is huge anyway so just use oneshot.
It's not a fast path in any sensible userspace code.

> +
> +	switch (channel->channel) {
> +	case 1 ... 8:
> +		reg = LMP92001_CAD1;
> +		break;
> +	case 9 ... 16:
> +		reg = LMP92001_CAD2;
> +		break;
> +	case 17:
> +		reg = LMP92001_CAD3;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_read(lmp92001->regmap, reg, &cad);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (channel->channel <= 8)
> +		cad >>= channel->channel - 1;
> +	else if (channel->channel > 8)
> +		cad >>= channel->channel - 9;
> +	else if (channel->channel > 16)
> +		cad >>= channel->channel - 17;
> +	else
> +		return -EINVAL;
> +
> +	return sprintf(buf, "%s\n", cad & BIT(0) ? "enable" : "disable");
> +}
> +
> +static ssize_t lmp92001_enable_write(struct iio_dev *indio_dev,
> +	uintptr_t private, struct iio_chan_spec const *channel,
> +	const char *buf, size_t len)
> +{
> +	struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
> +	unsigned int reg, enable, shif, mask;
> +	int ret;
> +
> +	switch (channel->channel) {
> +	case 1 ... 8:
> +		reg = LMP92001_CAD1;
> +		shif = (channel->channel - 1);
> +		break;
> +	case 9 ... 16:
> +		reg = LMP92001_CAD2;
> +		shif = (channel->channel - 9);
> +		break;
> +	case 17:
> +		reg = LMP92001_CAD3;
> +		shif = (channel->channel - 17);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (strncmp("enable", buf, 6) == 0)
> +		enable = 1;
> +	else if (strncmp("disable", buf, 7) == 0)
> +		enable = 0;
> +	else
> +		return -EINVAL;
> +
> +	enable <<= shif;
> +	mask = 1 << shif;
> +
> +	ret = regmap_update_bits(lmp92001->regmap, reg, mask, enable);
> +	if (ret < 0)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static ssize_t lmp92001_mode_read(struct iio_dev *indio_dev,
> +	uintptr_t private, struct iio_chan_spec const *channel, char *buf)
> +{
> +	struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
> +	unsigned int cgen;
> +	int ret;
> +
> +	ret = regmap_read(lmp92001->regmap, LMP92001_CGEN, &cgen);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buf, "%s\n",
> +			cgen & BIT(0) ? "continuous" : "single-shot");
> +}
> +
> +static ssize_t lmp92001_mode_write(struct iio_dev *indio_dev,
> +	uintptr_t private, struct iio_chan_spec const *channel,
> +	const char *buf, size_t len)
> +{
> +	struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
iio_priv.
> +	unsigned int cgen;
> +	int ret;
> +
> +	if (strncmp("continuous", buf, 10) == 0)
> +		cgen = 1;
> +	else if (strncmp("single-shot", buf, 11) == 0)
> +		cgen = 0;
> +	else
> +		return -EINVAL;
> +
> +	/*
> +	 * Unlock the HW registers.
> +	 * Set conversion mode.
> +	 * Lock the HW registers.
> +	 */
> +	ret = regmap_update_bits(lmp92001->regmap, LMP92001_CGEN, CGEN_LCK, 0);
> +	if (ret < 0)
> +		return ret;
I'd suggest a utility function for the unlock, update, lock cycle.
> +
> +	ret = regmap_update_bits(lmp92001->regmap, LMP92001_CGEN, CGEN_STRT,
> +					cgen);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_update_bits(lmp92001->regmap, LMP92001_CGEN, CGEN_LCK,
> +					CGEN_LCK);
> +	if (ret < 0)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static const struct iio_chan_spec_ext_info lmp92001_ext_info[] = {
> +	{
> +		.name = "vref",
> +		.read = lmp92001_avref_read,
> +		.write = lmp92001_avref_write,
> +	.shared = IIO_SHARED_BY_ALL,
> +	},
> +	{
}, { preferred.
> +		.name = "en",
> +		.read = lmp92001_enable_read,
> +		.write = lmp92001_enable_write,
> +		.shared = IIO_SEPARATE,
> +	},
> +	{
> +		.name = "mode",
> +		.read = lmp92001_mode_read,
> +		.write = lmp92001_mode_write,
> +		.shared = IIO_SHARED_BY_ALL,
> +	},

As ever with custom ABI, these need a lot of justifying before we'll
take them.  The result of this stuff is that standard userspace code has
no idea what to do with this device to make it work.

> +	{ },
> +};
> +
> +static const struct iio_event_spec lmp92001_events[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
> +			BIT(IIO_EV_INFO_VALUE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
> +			BIT(IIO_EV_INFO_VALUE),
> +	},
> +	{ },
> +};
> +
> +#define LMP92001_CHAN_SPEC(_ch, _type, _event, _nevent) \
> +{ \
> +	.channel = _ch, \
> +	.type = _type, \
> +	.indexed = 1, \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> +	.event_spec = _event, \
> +	.num_event_specs = _nevent, \
> +	.ext_info = lmp92001_ext_info, \
> +}
> +
> +static const struct iio_chan_spec lmp92001_adc_channels[] = {
> +	LMP92001_CHAN_SPEC(1, IIO_VOLTAGE, lmp92001_events,
> +			ARRAY_SIZE(lmp92001_events)),
> +	LMP92001_CHAN_SPEC(2, IIO_VOLTAGE, lmp92001_events,
> +			ARRAY_SIZE(lmp92001_events)),
> +	LMP92001_CHAN_SPEC(3, IIO_VOLTAGE, lmp92001_events,
> +			ARRAY_SIZE(lmp92001_events)),
> +	LMP92001_CHAN_SPEC(4, IIO_VOLTAGE, NULL, 0),
> +	LMP92001_CHAN_SPEC(5, IIO_VOLTAGE, NULL, 0),
> +	LMP92001_CHAN_SPEC(6, IIO_VOLTAGE, NULL, 0),
> +	LMP92001_CHAN_SPEC(7, IIO_VOLTAGE, NULL, 0),
> +	LMP92001_CHAN_SPEC(8, IIO_VOLTAGE, NULL, 0),
> +	LMP92001_CHAN_SPEC(9, IIO_VOLTAGE, lmp92001_events,
> +			ARRAY_SIZE(lmp92001_events)),
> +	LMP92001_CHAN_SPEC(10, IIO_VOLTAGE, lmp92001_events,
> +			ARRAY_SIZE(lmp92001_events)),
> +	LMP92001_CHAN_SPEC(11, IIO_VOLTAGE, lmp92001_events,
> +			ARRAY_SIZE(lmp92001_events)),
> +	LMP92001_CHAN_SPEC(12, IIO_VOLTAGE, NULL, 0),
> +	LMP92001_CHAN_SPEC(13, IIO_VOLTAGE, NULL, 0),
> +	LMP92001_CHAN_SPEC(14, IIO_VOLTAGE, NULL, 0),
> +	LMP92001_CHAN_SPEC(15, IIO_VOLTAGE, NULL, 0),
> +	LMP92001_CHAN_SPEC(16, IIO_VOLTAGE, NULL, 0),
> +	LMP92001_CHAN_SPEC(17,    IIO_TEMP, NULL, 0),
> +};
> +
> +static int lmp92001_adc_probe(struct platform_device *pdev)
> +{
> +	struct lmp92001 *lmp92001 = dev_get_drvdata(pdev->dev.parent);
> +	struct iio_dev *indio_dev;
> +	struct device_node *np = pdev->dev.of_node;
> +	const char *conversion;
> +	unsigned int cgen = 0, cad1, cad2, cad3;
> +	u32 mask;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*lmp92001));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	mutex_init(&lmp92001->adc_lock);
> +
> +	iio_device_set_drvdata(indio_dev, lmp92001);

Why?  You can always get the lmp92001 from iio_priv(indio_dev)

> +
> +	indio_dev->name = pdev->name;
> +	indio_dev->dev.parent = &pdev->dev;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &lmp92001_info;
> +	indio_dev->channels = lmp92001_adc_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(lmp92001_adc_channels);
> +
> +	ret = regmap_update_bits(lmp92001->regmap, LMP92001_CGEN,
> +					CGEN_RST, CGEN_RST);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to self reset all registers\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * Turn on all of them, if you are pretty sure they are must be
> +	 * real-time update or specify which channel is needed to be used to
> +	 * save conversion time for a cycle.
> +	 */
> +	ret = of_property_read_u32(np, "ti,lmp92001-adc-mask", &mask);
> +	if (ret < 0) {
> +		cad1 = cad2 = cad3 = 0xFF;
> +		dev_info(&pdev->dev, "turn on all of channels by default\n");
> +	} else {
> +		cad1 = mask & 0xFF;
> +		cad2 = (mask >> 8) & 0xFF;
> +		cad3 = (mask >> 16) & 0xFF;
> +	}

If you need these efficiencies, use the buffered mode interface of IIO and
switch into continuous mode with just the right channels.  For single reads
use oneshot.

This will then all be handled in the update_scan_mask callback.

> +
> +	ret = regmap_update_bits(lmp92001->regmap, LMP92001_CAD1, 0xFF, cad1);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to enable/disable channels 1-8\n");
> +		return ret;
> +	}
> +
> +	ret = regmap_update_bits(lmp92001->regmap, LMP92001_CAD2, 0xFF, cad2);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to enable/disable channels 9-16\n");
> +		return ret;
> +	}
> +
> +	ret = regmap_update_bits(lmp92001->regmap, LMP92001_CAD3, BIT(0), cad3);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev,
> +			"failed to enable/disable channel 17 (temperature)\n");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_string_index(np, "ti,lmp92001-adc-mode", 0,
> +						&conversion);
> +	if (!ret) {
> +		if (strncmp("continuous", conversion, 10) == 0) {
> +			cgen |= 1;
> +		} else if (strncmp("single-shot", conversion, 11) == 0) {
> +			/* Okay */
> +		} else {
> +			dev_warn(&pdev->dev,
> +			"wrong adc mode! set to single-short conversion\n");
> +		}
> +	} else
> +		dev_info(&pdev->dev,
> +			"single-short conversion was chosen by default\n");
> +
> +	/* Lock the HW registers and set conversion mode. */
> +	ret = regmap_update_bits(lmp92001->regmap,
> +					LMP92001_CGEN, CGEN_LCK | CGEN_STRT,
> +					cgen | CGEN_LCK);
> +	if (ret < 0)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	return devm_iio_device_register(&pdev->dev, indio_dev);

Can't do this as you need to unwind some setup. Do it with iio_device_register
and manually unwind in remove.

> +}
> +
> +static int lmp92001_adc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
> +
> +	/*
> +	 * To stop ADC conversion to save power
> +	 *
> +	 * Unlock the HW registers.
> +	 * Set conversion mode to single-shot.
> +	 * Lock the HW registers.
> +	 */
> +	regmap_update_bits(lmp92001->regmap, LMP92001_CGEN, CGEN_LCK, 0);
> +	regmap_update_bits(lmp92001->regmap, LMP92001_CGEN, CGEN_STRT, 0);
> +	regmap_update_bits(lmp92001->regmap, LMP92001_CGEN, CGEN_LCK, CGEN_LCK);
> +
> +	devm_iio_device_unregister(&pdev->dev, indio_dev);

Again, look up what devm does.   You can't use it here though as when used
correctly it will result in remove not being the reverse order of probe.

> +
> +	return 0;
> +}
> +
> +static struct platform_driver lmp92001_adc_driver = {
> +	.driver.name	= "lmp92001-adc",
> +	.probe		= lmp92001_adc_probe,
> +	.remove		= lmp92001_adc_remove,
> +};
> +
> +static int __init lmp92001_adc_init(void)
> +{
> +	return platform_driver_register(&lmp92001_adc_driver);
> +}
> +subsys_initcall(lmp92001_adc_init);
Why?  
> +
> +static void __exit lmp92001_adc_exit(void)
> +{
> +	platform_driver_unregister(&lmp92001_adc_driver);
> +}
> +module_exit(lmp92001_adc_exit);

use the magic platform macros to drop this boiler plate unless
you have a good reason for the subsys_initcall.
> +
> +MODULE_AUTHOR("Abhisit Sangjan <s.abhisit@gmail.com>");
> +MODULE_DESCRIPTION("IIO ADC interface for TI LMP92001");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:lmp92001-adc");
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 25bed2d..3e0d816 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -221,6 +221,15 @@ config DPOT_DAC
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called dpot-dac.
>  
> +config LMP92001_DAC
> +        tristate "TI LMP92001 DAC Driver"
> +        depends on MFD_LMP92001
> +        help
> +          If you say yes here you get support for TI LMP92001 DACs.
> +
> +          This driver can also be built as a module. If so, the module will
> +          be called lmp92001_dac.
> +
>  config LPC18XX_DAC
>  	tristate "NXP LPC18xx DAC driver"
>  	depends on ARCH_LPC18XX || COMPILE_TEST
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index 603587c..516d2be 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -23,6 +23,7 @@ obj-$(CONFIG_AD7303) += ad7303.o
>  obj-$(CONFIG_AD8801) += ad8801.o
>  obj-$(CONFIG_CIO_DAC) += cio-dac.o
>  obj-$(CONFIG_DPOT_DAC) += dpot-dac.o
> +obj-$(CONFIG_LMP92001_DAC) += lmp92001-dac.o
>  obj-$(CONFIG_LPC18XX_DAC) += lpc18xx_dac.o
>  obj-$(CONFIG_LTC2632) += ltc2632.o
>  obj-$(CONFIG_M62332) += m62332.o
> diff --git a/drivers/iio/dac/lmp92001-dac.c b/drivers/iio/dac/lmp92001-dac.c
> new file mode 100644
> index 0000000..8ea981b
> --- /dev/null
> +++ b/drivers/iio/dac/lmp92001-dac.c
> @@ -0,0 +1,390 @@
> +/*
> + * lmp92001-dac.c - Support for TI LMP92001 DACs
> + *
> + * Copyright 2016-2017 Celestica Ltd.
> + *
> + * Author: Abhisit Sangjan <s.abhisit@gmail.com>
> + *
> + * Inspired by wm831x driver.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */

Lots of comments would be about the ABI but we've already covered that above.

> +
> +#include <linux/iio/iio.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include <linux/mfd/lmp92001/core.h>
> +
> +#define CREF_DEXT	(1 << 0) /* 1 - DAC external reference.
> +				  * 0 - DAC internal reference.
> +				  */
> +#define CDAC_OFF	(1 << 0) /* 1 - Forces all outputs to high impedance. */
> +#define CDAC_OLVL	(1 << 1) /* 1 - Cy=0 will force associated OUTx outputs
> +				  *     to VDD.
> +				  * 0 - Cy=0 will force associated OUTx outputs
> +				  *     to GND.
> +				  */
> +#define CDAC_GANG	(1 << 2) /* Controls the association of analog output
> +				  * channels OUTx with asynchronous control
> +				  * inputs Cy.
> +				  *
> +				  *         Cy to OUTx Assignment
> +				  * --------------------------------------
> +				  * | Cy | CDAC:GANG = 0 | CDAC:GANG = 1 |
> +				  * --------------------------------------
> +				  * | C1 | OUT[1:4]      | OUT[1:3]      |
> +				  * --------------------------------------
> +				  * | C2 | OUT[5:6]      | OUT[4:6]      |
> +				  * --------------------------------------
> +				  * | C3 | OUT[7:8]      | OUT[7:9]      |
> +				  * --------------------------------------
> +				  * | C4 | OUT[9:12]     | OUT[10:12]    |
> +				  * --------------------------------------
> +				  */
> +
> +static int lmp92001_read_raw(struct iio_dev *indio_dev,
> +	struct iio_chan_spec const *channel,
> +	int *val, int *val2,
> +	long mask)
> +{
> +	struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&lmp92001->dac_lock);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (channel->type) {
> +		case IIO_VOLTAGE:
> +			ret = regmap_read(lmp92001->regmap,
> +					0x7F + channel->channel, val);
Again, move the lock in here.
> +			if (ret < 0)
> +				goto exit;
> +
> +			ret = IIO_VAL_INT;
> +			goto exit;
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	/* In case of no match channel info/type is return here. */
> +	ret = -EINVAL;
> +
> +exit:
> +	mutex_unlock(&lmp92001->dac_lock);
> +
> +	return ret;
> +}
> +
> +int lmp92001_write_raw(struct iio_dev *indio_dev,
> +	struct iio_chan_spec const *channel,
> +	int val, int val2,
> +	long mask)
> +{
> +	struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&lmp92001->dac_lock);
> +
> +	if (val < 0 || val > 4095) {
> +		ret = -EINVAL;
> +		goto exit;
> +	}
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (channel->type) {
> +		case IIO_VOLTAGE:
Move lock in here... Will simplify code flow by allowing direct returns.
> +			ret = regmap_write(lmp92001->regmap,
> +					0x7F + channel->channel, val);
> +			if (ret < 0)
> +				goto exit;
> +
> +			ret = 0;
> +			goto exit;
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}

> +
> +	/* In case of no match channel info/type is return here. */
> +	ret = -EINVAL;
> +
> +exit:
> +	mutex_unlock(&lmp92001->dac_lock);
> +
> +	return ret;
> +}
> +
> +static const struct iio_info lmp92001_info = {
> +	.read_raw = lmp92001_read_raw,
> +	.write_raw = lmp92001_write_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +ssize_t lmp92001_dvref_read(struct iio_dev *indio_dev, uintptr_t private,
> +	struct iio_chan_spec const *channel, char *buf)
> +{
> +	struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
> +	unsigned int cref;
> +	int ret;
> +
> +	ret = regmap_read(lmp92001->regmap, LMP92001_CREF, &cref);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buf, "%s\n", cref & CREF_DEXT ? "external" : "internal");
> +}
> +
> +ssize_t lmp92001_dvref_write(struct iio_dev *indio_dev, uintptr_t private,
> +	struct iio_chan_spec const *channel, const char *buf, size_t len)
> +{
> +	struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
> +	unsigned int cref;
> +	int ret;
> +
> +	if (strncmp("external", buf, 8) == 0)
> +		cref = 1;
> +	else if (strncmp("internal", buf, 8) == 0)
> +		cref = 0;
> +	else
> +		return -EINVAL;
> +
> +	ret = regmap_update_bits(lmp92001->regmap, LMP92001_CREF, CREF_DEXT,
> +					cref);
> +	if (ret < 0)
> +		return ret;
> +
> +	return len;
> +}
> +
> +ssize_t lmp92001_outx_read(struct iio_dev *indio_dev, uintptr_t private,
> +	struct iio_chan_spec const *channel, char *buf)
> +{
> +	struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
> +	unsigned int cdac;
> +	const char *outx;
> +	int ret;
> +
> +	ret = regmap_read(lmp92001->regmap, LMP92001_CDAC, &cdac);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (cdac & CDAC_OFF)
> +		outx = "hiz";
> +	else {
> +		if (cdac & CDAC_OLVL)
> +			outx = "1 or dac";
> +		else
> +			outx = "0 or dac";
> +	}
> +
> +	return sprintf(buf, "%s\n", outx);
> +}
> +
> +ssize_t lmp92001_outx_write(struct iio_dev *indio_dev, uintptr_t private,
> +	struct iio_chan_spec const *channel, const char *buf, size_t len)
> +{
> +	struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
> +	unsigned int cdac, mask;
> +	int ret;
> +
> +	if (strncmp("hiz", buf, 3) == 0) {
> +		cdac = CDAC_OFF;
> +		mask = CDAC_OFF;
> +	} else if (strncmp("dac", buf, 3) == 0) {
> +		cdac = ~CDAC_OFF;
> +		mask = CDAC_OFF;
> +	} else if (strncmp("0", buf, 1) == 0) {
> +		cdac = ~(CDAC_OLVL | CDAC_OFF);
> +		mask = CDAC_OLVL | CDAC_OFF;
> +	} else if (strncmp("1", buf, 1) == 0) {
> +		cdac = CDAC_OLVL;
> +		mask = CDAC_OLVL | CDAC_OFF;
> +	} else
> +		return -EINVAL;
> +
> +	ret = regmap_update_bits(lmp92001->regmap, LMP92001_CDAC, mask, cdac);
> +	if (ret < 0)
> +		return ret;
> +
> +	return len;
> +}
> +
> +ssize_t lmp92001_gang_read(struct iio_dev *indio_dev, uintptr_t private,
> +	struct iio_chan_spec const *channel, char *buf)
> +{
> +	struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
> +	unsigned int cdac;
> +	int ret;
> +
> +	ret = regmap_read(lmp92001->regmap, LMP92001_CDAC, &cdac);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buf, "%s\n", cdac & CDAC_GANG ? "1" : "0");
> +}
> +
> +ssize_t lmp92001_gang_write(struct iio_dev *indio_dev, uintptr_t private,
> +	struct iio_chan_spec const *channel, const char *buf, size_t len)
> +{
> +	struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
> +	unsigned int cdac = 0;
> +	int ret;
> +
> +	if (strncmp("0", buf, 1) == 0)
> +		cdac = ~CDAC_GANG;
> +	else if (strncmp("1", buf, 1) == 0)
> +		cdac = CDAC_GANG;
> +	else
> +		return -EINVAL;
> +
> +	ret = regmap_update_bits(lmp92001->regmap, LMP92001_CDAC, CDAC_GANG,
> +					cdac);
> +	if (ret < 0)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static const struct iio_chan_spec_ext_info lmp92001_ext_info[] = {
> +	{
> +		.name = "vref",
> +		.read = lmp92001_dvref_read,
> +		.write = lmp92001_dvref_write,
> +		.shared = IIO_SHARED_BY_ALL,
> +	},
> +	{
> +		.name = "outx",
> +		.read = lmp92001_outx_read,
> +		.write = lmp92001_outx_write,
> +		.shared = IIO_SHARED_BY_ALL,
> +	},
> +	{
> +		.name = "gang",
> +		.read = lmp92001_gang_read,
> +		.write = lmp92001_gang_write,
> +		.shared = IIO_SHARED_BY_ALL,
> +	},
> +	{ },
> +};
> +
> +#define LMP92001_CHAN_SPEC(_ch) \
> +{ \
> +	.channel = _ch, \
> +	.type = IIO_VOLTAGE, \
> +	.indexed = 1, \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> +	.ext_info = lmp92001_ext_info, \
> +	.output = 1, \
> +}
> +
> +static const struct iio_chan_spec lmp92001_dac_channels[] = {
> +	LMP92001_CHAN_SPEC(1),
> +	LMP92001_CHAN_SPEC(2),
> +	LMP92001_CHAN_SPEC(3),
> +	LMP92001_CHAN_SPEC(4),
> +	LMP92001_CHAN_SPEC(5),
> +	LMP92001_CHAN_SPEC(6),
> +	LMP92001_CHAN_SPEC(7),
> +	LMP92001_CHAN_SPEC(8),
> +	LMP92001_CHAN_SPEC(9),
> +	LMP92001_CHAN_SPEC(10),
> +	LMP92001_CHAN_SPEC(11),
> +	LMP92001_CHAN_SPEC(12),
> +};
> +
> +static int lmp92001_dac_probe(struct platform_device *pdev)
> +{
> +	struct lmp92001 *lmp92001 = dev_get_drvdata(pdev->dev.parent);
> +	struct iio_dev *indio_dev;
> +	struct device_node *np = pdev->dev.of_node;
> +	u8 gang = 0, outx = 0, hiz = 0;
> +	unsigned int cdac = 0;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*lmp92001));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	mutex_init(&lmp92001->dac_lock);
> +
> +	iio_device_set_drvdata(indio_dev, lmp92001);
again, why? Use iio_priv(indio_dev) where ever you have been using
drvdata.
> +
> +	indio_dev->name = pdev->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &lmp92001_info;
> +	indio_dev->channels = lmp92001_dac_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(lmp92001_dac_channels);
> +
> +	of_property_read_u8(np, "ti,lmp92001-dac-hiz", &hiz);
> +	cdac |= hiz;
cdac = hiz and drop the = 0 above.  Also handle errors.
> +
> +	of_property_read_u8(np, "ti,lmp92001-dac-outx", &outx);
> +	cdac |= outx << 1;
> +
> +	of_property_read_u8(np, "ti,lmp92001-dac-gang", &gang);
> +	cdac |= gang << 2;
> +
> +	ret = regmap_update_bits(lmp92001->regmap, LMP92001_CDAC,
> +					CDAC_GANG | CDAC_OLVL | CDAC_OFF, cdac);
> +	if (ret < 0)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	return devm_iio_device_register(&pdev->dev, indio_dev);
> +}
> +
> +static int lmp92001_dac_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +
> +	devm_iio_device_unregister(&pdev->dev, indio_dev);
Same as for the ADC.
> +
> +	return 0;
> +}
> +
> +static struct platform_driver lmp92001_dac_driver = {
> +	.driver.name	= "lmp92001-dac",
> +	.probe		= lmp92001_dac_probe,
> +	.remove		= lmp92001_dac_remove,
> +};
> +
> +static int __init lmp92001_dac_init(void)
> +{
> +	return platform_driver_register(&lmp92001_dac_driver);
> +}
> +subsys_initcall(lmp92001_dac_init);
Why subsys_initcall?

> +
> +static void __exit lmp92001_dac_exit(void)
> +{
> +	platform_driver_unregister(&lmp92001_dac_driver);
> +}
> +module_exit(lmp92001_dac_exit);

Standard boilerplate remove macro once you have gotten rid
of the subsys initcall.
> +
> +MODULE_AUTHOR("Abhisit Sangjan <s.abhisit@gmail.com>");
> +MODULE_DESCRIPTION("IIO DAC interface for TI LMP92001");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:lmp92001-dac");
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 94ad2c1..a20389a 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1528,6 +1528,18 @@ config MFD_LM3533
>  	  additional drivers must be enabled in order to use the LED,
>  	  backlight or ambient-light-sensor functionality of the device.
>  
> +config MFD_LMP92001
> +       tristate "TI LMP92001 Analog System Monitor and Controller"
> +       depends on I2C
> +       select MFD_CORE
> +       select REGMAP_I2C
> +       help
> +         Say yes here to enable support for TI LMP92001 Analog System
> +         Monitor and Controller
> +
> +         This driver provide support for 16 ADC, 12 DAC, Voltage Reference,
> +         Analog Temperature Sensor and 8-bit GPIO Port.
> +
>  config MFD_TIMBERDALE
>  	tristate "Timberdale FPGA"
>  	select MFD_CORE
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 080793b..20d2e65 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -199,6 +199,10 @@ obj-$(CONFIG_MFD_RN5T618)	+= rn5t618.o
>  obj-$(CONFIG_MFD_SEC_CORE)	+= sec-core.o sec-irq.o
>  obj-$(CONFIG_MFD_SYSCON)	+= syscon.o
>  obj-$(CONFIG_MFD_LM3533)	+= lm3533-core.o lm3533-ctrlbank.o
> +
> +lmp92001-objs			:= lmp92001-core.o lmp92001-i2c.o lmp92001-debug.o
> +obj-$(CONFIG_MFD_LMP92001)	+= lmp92001.o
> +
>  obj-$(CONFIG_MFD_VEXPRESS_SYSREG)	+= vexpress-sysreg.o
>  obj-$(CONFIG_MFD_RETU)		+= retu-mfd.o
>  obj-$(CONFIG_MFD_AS3711)	+= as3711.o
> diff --git a/drivers/mfd/lmp92001-core.c b/drivers/mfd/lmp92001-core.c
> new file mode 100644
> index 0000000..55bc9ab
> --- /dev/null
> +++ b/drivers/mfd/lmp92001-core.c
> @@ -0,0 +1,308 @@
> +/*
> + * lmp92001-core.c - Device access for TI LMP92001
> + *
> + * Copyright 2016-2017 Celestica Ltd.
> + *
> + * Author: Abhisit Sangjan <s.abhisit@gmail.com>
> + *
> + * Inspired by wm831x driver.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/mfd/lmp92001/core.h>
> +#include <linux/mfd/lmp92001/debug.h>
> +
> +static const struct mfd_cell lmp92001_devs[] = {
> +	{
> +		.name = "lmp92001-gpio",
> +		.of_compatible = "ti,lmp92001-gpio",
> +	},
> +	{
> +		.name = "lmp92001-adc",
> +		.of_compatible = "ti,lmp92001-adc",
> +	},
> +	{
> +		.name = "lmp92001-dac",
> +		.of_compatible = "ti,lmp92001-dac",
> +	},
> +};
> +
> +static struct reg_default lmp92001_defaults[] = {
> +	{ LMP92001_SGEN,  0x40   },
> +	{ LMP92001_SHIL,  0x00   },
> +	{ LMP92001_SLOL,  0x00   },
> +	{ LMP92001_CGEN,  0x00   },
> +	{ LMP92001_CDAC,  0x03   },
> +	{ LMP92001_CGPO,  0xFF   },
> +	{ LMP92001_CINH,  0x00   },
> +	{ LMP92001_CINL,  0x00   },
> +	{ LMP92001_CAD1,  0x00   },
> +	{ LMP92001_CAD2,  0x00   },
> +	{ LMP92001_CAD3,  0x00   },
> +	{ LMP92001_CTRIG, 0x00   },
> +	{ LMP92001_CREF,  0x07   },
> +	{ LMP92001_ADC1,  0x0000 },
> +	{ LMP92001_ADC2,  0x0000 },
> +	{ LMP92001_ADC3,  0x0000 },
> +	{ LMP92001_ADC4,  0x0000 },
> +	{ LMP92001_ADC5,  0x0000 },
> +	{ LMP92001_ADC6,  0x0000 },
> +	{ LMP92001_ADC7,  0x0000 },
> +	{ LMP92001_ADC8,  0x0000 },
> +	{ LMP92001_ADC9,  0x0000 },
> +	{ LMP92001_ADC10, 0x0000 },
> +	{ LMP92001_ADC11, 0x0000 },
> +	{ LMP92001_ADC12, 0x0000 },
> +	{ LMP92001_ADC13, 0x0000 },
> +	{ LMP92001_ADC14, 0x0000 },
> +	{ LMP92001_ADC15, 0x0000 },
> +	{ LMP92001_ADC16, 0x0000 },
> +	{ LMP92001_LIH1,  0x0FFF },
> +	{ LMP92001_LIH2,  0x0FFF },
> +	{ LMP92001_LIH3,  0x0FFF },
> +	{ LMP92001_LIH9,  0x0FFF },
> +	{ LMP92001_LIH10, 0x0FFF },
> +	{ LMP92001_LIH11, 0x0FFF },
> +	{ LMP92001_LIL1,  0x0000 },
> +	{ LMP92001_LIL2,  0x0000 },
> +	{ LMP92001_LIL3,  0x0000 },
> +	{ LMP92001_LIL9,  0x0000 },
> +	{ LMP92001_LIL10, 0x0000 },
> +	{ LMP92001_LIL11, 0x0000 },
> +	{ LMP92001_DAC1,  0x0000 },
> +	{ LMP92001_DAC2,  0x0000 },
> +	{ LMP92001_DAC3,  0x0000 },
> +	{ LMP92001_DAC4,  0x0000 },
> +	{ LMP92001_DAC5,  0x0000 },
> +	{ LMP92001_DAC6,  0x0000 },
> +	{ LMP92001_DAC7,  0x0000 },
> +	{ LMP92001_DAC8,  0x0000 },
> +	{ LMP92001_DAC9,  0x0000 },
> +	{ LMP92001_DAC10, 0x0000 },
> +	{ LMP92001_DAC11, 0x0000 },
> +	{ LMP92001_DAC12, 0x0000 },
> +	{ LMP92001_DALL,  0x0000 },
> +};
> +
> +static bool lmp92001_reg_readable(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case LMP92001_ID:
> +	case LMP92001_VER:
> +	case LMP92001_SGEN:
> +	case LMP92001_SGPI:
> +	case LMP92001_SHIL:
> +	case LMP92001_SLOL:
> +	case LMP92001_CGEN:
> +	case LMP92001_CDAC:
> +	case LMP92001_CGPO:
> +	case LMP92001_CINH:
> +	case LMP92001_CINL:
> +	case LMP92001_CAD1:
> +	case LMP92001_CAD2:
> +	case LMP92001_CAD3:
> +	case LMP92001_ADC1:
> +	case LMP92001_ADC2:
> +	case LMP92001_ADC3:
> +	case LMP92001_ADC4:
> +	case LMP92001_ADC5:
> +	case LMP92001_ADC6:
> +	case LMP92001_ADC7:
> +	case LMP92001_ADC8:
> +	case LMP92001_ADC9:
> +	case LMP92001_ADC10:
> +	case LMP92001_ADC11:
> +	case LMP92001_ADC12:
> +	case LMP92001_ADC13:
> +	case LMP92001_ADC14:
> +	case LMP92001_ADC15:
> +	case LMP92001_ADC16:
> +	case LMP92001_ADC17:
> +	case LMP92001_LIH1:
> +	case LMP92001_LIH2:
> +	case LMP92001_LIH3:
> +	case LMP92001_LIH9:
> +	case LMP92001_LIH10:
> +	case LMP92001_LIH11:
> +	case LMP92001_LIL1:
> +	case LMP92001_LIL2:
> +	case LMP92001_LIL3:
> +	case LMP92001_LIL9:
> +	case LMP92001_LIL10:
> +	case LMP92001_LIL11:
> +	case LMP92001_CREF:
> +	case LMP92001_DAC1:
> +	case LMP92001_DAC2:
> +	case LMP92001_DAC3:
> +	case LMP92001_DAC4:
> +	case LMP92001_DAC5:
> +	case LMP92001_DAC6:
> +	case LMP92001_DAC7:
> +	case LMP92001_DAC8:
> +	case LMP92001_DAC9:
> +	case LMP92001_DAC10:
> +	case LMP92001_DAC11:
> +	case LMP92001_DAC12:
> +	case LMP92001_BLK0:
> +	case LMP92001_BLK1:
> +	case LMP92001_BLK2:
> +	case LMP92001_BLK3:
> +	case LMP92001_BLK4:
> +	case LMP92001_BLK5:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool lmp92001_reg_writeable(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case LMP92001_CGEN:
> +	case LMP92001_CDAC:
> +	case LMP92001_CGPO:
> +	case LMP92001_CINH:
> +	case LMP92001_CINL:
> +	case LMP92001_CAD1:
> +	case LMP92001_CAD2:
> +	case LMP92001_CAD3:
> +	case LMP92001_CTRIG:
> +	case LMP92001_LIH1:
> +	case LMP92001_LIH2:
> +	case LMP92001_LIH3:
> +	case LMP92001_LIH9:
> +	case LMP92001_LIH10:
> +	case LMP92001_LIH11:
> +	case LMP92001_LIL1:
> +	case LMP92001_LIL2:
> +	case LMP92001_LIL3:
> +	case LMP92001_LIL9:
> +	case LMP92001_LIL10:
> +	case LMP92001_LIL11:
> +	case LMP92001_CREF:
> +	case LMP92001_DAC1:
> +	case LMP92001_DAC2:
> +	case LMP92001_DAC3:
> +	case LMP92001_DAC4:
> +	case LMP92001_DAC5:
> +	case LMP92001_DAC6:
> +	case LMP92001_DAC7:
> +	case LMP92001_DAC8:
> +	case LMP92001_DAC9:
> +	case LMP92001_DAC10:
> +	case LMP92001_DAC11:
> +	case LMP92001_DAC12:
> +	case LMP92001_DALL:
> +	case LMP92001_BLK0:
> +	case LMP92001_BLK1:
> +	case LMP92001_BLK4:
> +	case LMP92001_BLK5:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool lmp92001_reg_volatile(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case LMP92001_SGEN:
> +	case LMP92001_SGPI:
> +	case LMP92001_SHIL:
> +	case LMP92001_SLOL:
> +	case LMP92001_CGEN:
> +	case LMP92001_ADC1:
> +	case LMP92001_ADC2:
> +	case LMP92001_ADC3:
> +	case LMP92001_ADC4:
> +	case LMP92001_ADC5:
> +	case LMP92001_ADC6:
> +	case LMP92001_ADC7:
> +	case LMP92001_ADC8:
> +	case LMP92001_ADC9:
> +	case LMP92001_ADC10:
> +	case LMP92001_ADC11:
> +	case LMP92001_ADC12:
> +	case LMP92001_ADC13:
> +	case LMP92001_ADC14:
> +	case LMP92001_ADC15:
> +	case LMP92001_ADC16:
> +	case LMP92001_ADC17:
> +	case LMP92001_BLK2:
> +	case LMP92001_BLK3:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +struct regmap_config lmp92001_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +
> +	.cache_type = REGCACHE_RBTREE,
> +
> +	.reg_defaults = lmp92001_defaults,
> +	.num_reg_defaults = ARRAY_SIZE(lmp92001_defaults),
> +
> +	.max_register = LMP92001_BLK5,
> +	.readable_reg = lmp92001_reg_readable,
> +	.writeable_reg = lmp92001_reg_writeable,
> +	.volatile_reg = lmp92001_reg_volatile,
> +};
> +
> +int lmp92001_device_init(struct lmp92001 *lmp92001, unsigned long id, int irq)
> +{
> +	int ret;
> +	unsigned int comid, ver;
> +
> +	dev_set_drvdata(lmp92001->dev, lmp92001);
> +
> +	ret  = regmap_read(lmp92001->regmap, LMP92001_ID, &comid);

Why the two spaces after ret...

> +	if (ret < 0) {
> +		dev_err(lmp92001->dev, "failed to read Company ID: %d\n", ret);
> +		goto exit;
> +	}
> +
> +	ret  = regmap_read(lmp92001->regmap, LMP92001_VER, &ver);
> +	if (ret < 0) {
> +		dev_err(lmp92001->dev, "failed to read Version: %d\n", ret);
> +		goto exit;
> +	}
> +
> +	dev_info(lmp92001->dev, "Company ID 0x%.2x, Version 0x%.2x\n",
> +			comid, ver);
> +
> +	ret = mfd_add_devices(lmp92001->dev, PLATFORM_DEVID_AUTO,
> +				lmp92001_devs, ARRAY_SIZE(lmp92001_devs),
> +				NULL, 0, NULL);
> +	if (ret != 0) {
> +		dev_err(lmp92001->dev, "failed to add children\n");
> +		goto exit;
> +	}
> +
> +	ret = lmp92001_debug_init(lmp92001);
> +	if (ret < 0) {
> +		dev_err(lmp92001->dev, "failed to initial debug fs.\n");
> +		goto exit;
> +	}
> +
> +exit:
> +	return ret;
> +}
> +
> +void lmp92001_device_exit(struct lmp92001 *lmp92001)
> +{
> +	lmp92001_debug_exit(lmp92001);
> +	mfd_remove_devices(lmp92001->dev);
> +}

I'm not convinced there is any benefit in breaking this up into lots of files...

> diff --git a/drivers/mfd/lmp92001-debug.c b/drivers/mfd/lmp92001-debug.c
> new file mode 100644
> index 0000000..d733e67
> --- /dev/null
> +++ b/drivers/mfd/lmp92001-debug.c
> @@ -0,0 +1,67 @@
> +/*
> + * lmp92001-debug.c - Debug file system for TI LMP92001
> + *
> + * Copyright 2016-2017 Celestica Ltd.
> + *
> + * Author: Abhisit Sangjan <s.abhisit@gmail.com>
> + *
> + * Inspired by wm831x driver.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +
> +#include <linux/mfd/lmp92001/core.h>
> +
> +static ssize_t lmp92001_id_ver_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct lmp92001 *lmp92001 = dev_get_drvdata(dev);
> +	int ret;
> +	unsigned int comid, ver;
> +
> +	ret = regmap_read(lmp92001->regmap, LMP92001_ID, &comid);
> +	if (ret < 0) {
> +		dev_err(lmp92001->dev, "failed to read Company ID: %d\n", ret);
> +		return 0;
return ret... everywhere you've done this please.
> +	}
> +
> +	ret = regmap_read(lmp92001->regmap, LMP92001_VER, &ver);
> +	if (ret < 0) {
> +		dev_err(lmp92001->dev, "failed to read Version: %d\n", ret);
> +		return 0;
> +	}
> +
> +	ret = sprintf(buf, "Company ID 0x%02x (%d), Version 0x%02x (%d)\n",
> +			comid, comid, ver, ver);
> +
> +	return ret;
return sprintf(...
> +}
> +static DEVICE_ATTR(lmp92001_id_ver, 0444, lmp92001_id_ver_show, NULL);
> +
> +int lmp92001_debug_init(struct lmp92001 *lmp92001)
> +{
> +	int ret;
> +
> +	ret = device_create_file(lmp92001->dev, &dev_attr_lmp92001_id_ver);
> +	if (ret != 0)
> +		dev_err(lmp92001->dev,
> +			"unique ID attribute is not created: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +void lmp92001_debug_exit(struct lmp92001 *lmp92001)
> +{
> +	device_remove_file(lmp92001->dev, &dev_attr_lmp92001_id_ver);
> +}
> diff --git a/drivers/mfd/lmp92001-i2c.c b/drivers/mfd/lmp92001-i2c.c
> new file mode 100644
> index 0000000..bbb1dad
> --- /dev/null
> +++ b/drivers/mfd/lmp92001-i2c.c
> @@ -0,0 +1,215 @@
> +/*
> + * lmp92001-i2c.c - I2C access for TI LMP92001
> + *
> + * Copyright 2016-2017 Celestica Ltd.
> + *
> + * Author: Abhisit Sangjan <s.abhisit@gmail.com>
> + *
> + * Inspired by wm831x driver.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_gpio.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include <linux/mfd/lmp92001/core.h>
> +
> +static const unsigned short lmp92001_i2c_addresses[] = {
> +	0x40, 0x42, 0x44, 0x46, 0x48, 0x4A, 0x4C, 0x4E, 0x50, I2C_CLIENT_END
> +};
> +
> +/* TODO: To read/write block access, it may need to re-ordering endianness! */
> +static int lmp92001_reg_read(void *context, unsigned int reg, unsigned int *val)
> +{
> +	struct device *dev = context;
> +	struct i2c_client *i2c = to_i2c_client(dev);
> +	int ret;
> +
> +	if (reg > 0xff)
> +		return -EINVAL;
> +
> +	switch (reg) {
> +	case LMP92001_ID ... LMP92001_CTRIG:
> +	case LMP92001_CREF:
> +		ret = i2c_smbus_read_byte_data(i2c, reg);
> +		break;
> +	case LMP92001_ADC1 ... LMP92001_LIL11:
> +	case LMP92001_DAC1 ... LMP92001_DALL:
> +		ret = i2c_smbus_read_word_swapped(i2c, reg);
> +		break;
> +	case LMP92001_BLK0 ... LMP92001_BLK5:
> +		ret = i2c_smbus_read_block_data(i2c, reg,
> +						(u8 *)((uintptr_t)*val));
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	if (reg <= LMP92001_DALL)
> +		*val = ret;
Cleaner to push this up into the case statements perhaps? Or at least
return ret for the BLK one up there.
> +
> +	return 0;
> +}
> +
> +static int lmp92001_reg_write(void *context, unsigned int reg, unsigned int val)
> +{
> +	struct device *dev = context;
> +	struct i2c_client *i2c = to_i2c_client(dev);
> +	int ret;
> +
> +	if (reg > 0xff)
> +		return -EINVAL;
> +
> +	switch (reg) {
> +	case LMP92001_ID ... LMP92001_CTRIG:
> +	case LMP92001_CREF:
> +		ret = i2c_smbus_write_byte_data(i2c, reg, val);
> +		break;
> +	case LMP92001_ADC1 ... LMP92001_LIL11:
> +	case LMP92001_DAC1 ... LMP92001_DALL:
> +		ret = i2c_smbus_write_word_swapped(i2c, reg, val);
> +		break;
> +	/* To call this function/case, must be passed val as pointer */
> +	case LMP92001_BLK0:
> +	case LMP92001_BLK4:
> +		ret = i2c_smbus_write_block_data(i2c, reg, 24,
> +						(u8 *)((uintptr_t)val));
> +		break;
> +	case LMP92001_BLK1:
> +	case LMP92001_BLK5:
> +		ret = i2c_smbus_write_block_data(i2c, reg, 12,
> +						(u8 *)((uintptr_t)val));
> +		break;
> +	case LMP92001_BLK2:
> +		ret = i2c_smbus_write_block_data(i2c, reg, 34,
> +						(u8 *)((uintptr_t)val));
> +		break;
> +	case LMP92001_BLK3:
> +		ret = i2c_smbus_write_block_data(i2c, reg, 18,
> +						(u8 *)((uintptr_t)val));
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int lmp92001_i2c_probe(struct i2c_client *i2c,
> +	const struct i2c_device_id *id)
> +{
> +	struct lmp92001 *lmp92001;
> +	int ret;
> +
> +	lmp92001 = devm_kzalloc(&i2c->dev, sizeof(struct lmp92001), GFP_KERNEL);
> +	if (!lmp92001)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(i2c, lmp92001);
> +	lmp92001->dev = &i2c->dev;
> +
> +	lmp92001_regmap_config.reg_read = lmp92001_reg_read;
> +	lmp92001_regmap_config.reg_write = lmp92001_reg_write;
> +
> +	lmp92001->regmap = devm_regmap_init(&i2c->dev, NULL, &i2c->dev,
> +						&lmp92001_regmap_config);
> +	if (IS_ERR(lmp92001->regmap)) {
> +		ret = PTR_ERR(lmp92001->regmap);
> +		dev_err(lmp92001->dev, "failed to allocate register map: %d\n",
> +				ret);
> +		return ret;
> +	}
> +
> +	return lmp92001_device_init(lmp92001, id->driver_data, i2c->irq);
> +}
> +
> +static int lmp92001_i2c_remove(struct i2c_client *i2c)
> +{
> +	struct lmp92001 *lmp92001 = i2c_get_clientdata(i2c);
> +
> +	lmp92001_device_exit(lmp92001);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id lmp92001_dt_ids[] = {
> +	{ .compatible = "ti,lmp92001", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, lmp92001_dt_ids);
> +#endif
> +
> +static const struct i2c_device_id lmp92001_i2c_ids[] = {
> +	{ "lmp92001" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(i2c, lmp92001_i2c_ids);
> +
> +static int lmp92001_i2c_detect(struct i2c_client *i2c,
> +	struct i2c_board_info *info)
> +{
> +	struct i2c_adapter *adapter = i2c->adapter;
> +	s32 comid, ver;
> +
> +	if (!i2c_check_functionality(adapter,
> +					I2C_FUNC_SMBUS_BYTE_DATA |
> +					I2C_FUNC_SMBUS_WORD_DATA |
> +					I2C_FUNC_SMBUS_BLOCK_DATA))
> +		return -ENODEV;
> +
> +	comid = i2c_smbus_read_byte_data(i2c, LMP92001_ID);
> +	ver = i2c_smbus_read_byte_data(i2c, LMP92001_VER);
> +
> +	if (comid != 0x01 || ver != 0x10)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static struct i2c_driver lmp92001_i2c_driver = {
> +	.driver = {
> +		.name = "lmp92001",
> +		.of_match_table = of_match_ptr(lmp92001_dt_ids),
> +	},
> +	.probe		= lmp92001_i2c_probe,
> +	.remove		= lmp92001_i2c_remove,
> +	.id_table	= lmp92001_i2c_ids,
> +	.detect		= lmp92001_i2c_detect,
> +	.address_list	= lmp92001_i2c_addresses,
> +};
> +
> +static int __init lmp92001_i2c_init(void)
> +{
> +	return i2c_add_driver(&lmp92001_i2c_driver);
> +}
> +subsys_initcall(lmp92001_i2c_init);
> +
> +static void __exit lmp92001_i2c_exit(void)
> +{
> +	i2c_del_driver(&lmp92001_i2c_driver);
> +}
> +module_exit(lmp92001_i2c_exit);
> +
> +MODULE_DESCRIPTION("i2c driver for TI LMP92001");
> +MODULE_AUTHOR("Abhisit Sangjan <s.abhisit@gmail.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/lmp92001/core.h b/include/linux/mfd/lmp92001/core.h
> new file mode 100644
> index 0000000..9039000
> --- /dev/null
> +++ b/include/linux/mfd/lmp92001/core.h
> @@ -0,0 +1,119 @@
> +/*
> + * include/linux/mfd/lmp92001/core.h - Core interface for TI LMP92001
> + *
> + * Copyright 2016-2017 Celestica Ltd.
> + *
> + * Author: Abhisit Sangjan <s.abhisit@gmail.com>
> + *
> + * Inspired by wm831x driver.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#ifndef __MFD_LMP92001_CORE_H__
> +#define __MFD_LMP92001_CORE_H__
> +
> +#include <linux/device.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +
> +/*
> + * Register values.
> + */
> +/* ID */
> +#define LMP92001_ID	0x0E
> +#define LMP92001_VER	0x0F
> +/* STATUS */
> +#define LMP92001_SGEN	0x10
> +#define LMP92001_SGPI	0x11
> +#define LMP92001_SHIL	0x12
> +#define LMP92001_SLOL	0x13
> +/* CONTROL */
> +#define LMP92001_CGEN	0x14
> +#define LMP92001_CDAC	0x15
> +#define LMP92001_CGPO	0x16
> +#define LMP92001_CINH	0x17
> +#define LMP92001_CINL	0x18
> +#define LMP92001_CAD1	0x19
> +#define LMP92001_CAD2	0x1A
> +#define LMP92001_CAD3	0x1B
> +#define LMP92001_CTRIG	0x1C
> +/* ADC OUTPUT DATA */
> +#define LMP92001_ADC1	0x20
> +#define LMP92001_ADC2	0x21
> +#define LMP92001_ADC3	0x22
> +#define LMP92001_ADC4	0x23
> +#define LMP92001_ADC5	0x24
> +#define LMP92001_ADC6	0x25
> +#define LMP92001_ADC7	0x26
> +#define LMP92001_ADC8	0x27
> +#define LMP92001_ADC9	0x28
> +#define LMP92001_ADC10	0x29
> +#define LMP92001_ADC11	0x2A
> +#define LMP92001_ADC12	0x2B
> +#define LMP92001_ADC13	0x2C
> +#define LMP92001_ADC14	0x2D
> +#define LMP92001_ADC15	0x2E
> +#define LMP92001_ADC16	0x2F
> +#define LMP92001_ADC17	0x30
> +/* ADC WINDOW COMPARATOR LIMITS */
> +#define LMP92001_LIH1	0x40
> +#define LMP92001_LIH2	0x41
> +#define LMP92001_LIH3	0x42
> +#define LMP92001_LIH9	0x43
> +#define LMP92001_LIH10	0x44
> +#define LMP92001_LIH11	0x45
> +#define LMP92001_LIL1	0x46
> +#define LMP92001_LIL2	0x47
> +#define LMP92001_LIL3	0x48
> +#define LMP92001_LIL9	0x49
> +#define LMP92001_LIL10	0x4A
> +#define LMP92001_LIL11	0x4B
> +/* INTERNAL REFERENCE CONTROL */
> +#define LMP92001_CREF	0x66
> +/* DAC INPUT DATA */
> +#define LMP92001_DAC1	0x80
> +#define LMP92001_DAC2	0x81
> +#define LMP92001_DAC3	0x82
> +#define LMP92001_DAC4	0x83
> +#define LMP92001_DAC5	0x84
> +#define LMP92001_DAC6	0x85
> +#define LMP92001_DAC7	0x86
> +#define LMP92001_DAC8	0x87
> +#define LMP92001_DAC9	0x88
> +#define LMP92001_DAC10	0x89
> +#define LMP92001_DAC11	0x8A
> +#define LMP92001_DAC12	0x8B
> +#define LMP92001_DALL	0x90
> +/* MEMORY MAPPED BLOCK COMMANDS */
> +#define LMP92001_BLK0	0xF0
> +#define LMP92001_BLK1	0xF1
> +#define LMP92001_BLK2	0xF2
> +#define LMP92001_BLK3	0xF3
> +#define LMP92001_BLK4	0xF4
> +#define LMP92001_BLK5	0xF5
> +
> +struct lmp92001 {
> +	struct device *dev;
> +	struct regmap *regmap;
> +
> +	struct mutex adc_lock;
> +	struct mutex dac_lock;
> +};
> +
> +extern struct regmap_config lmp92001_regmap_config;
> +
> +int lmp92001_device_init(struct lmp92001 *lmp92001, unsigned long id, int irq);
> +void lmp92001_device_exit(struct lmp92001 *lmp92001);
> +
> +#endif /* __MFD_LMP92001_CORE_H__ */
> diff --git a/include/linux/mfd/lmp92001/debug.h b/include/linux/mfd/lmp92001/debug.h
> new file mode 100644
> index 0000000..efef95f
> --- /dev/null
> +++ b/include/linux/mfd/lmp92001/debug.h
> @@ -0,0 +1,28 @@
> +/*
> + * include/linux/mfd/lmp92001/debug.h - Debug interface for TI 92001
> + *
> + * Copyright 2016-2017 Celestica Ltd.
> + *
> + * Author: Abhisit Sangjan <s.abhisit@gmail.com>
> + *
> + * Inspired by wm831x driver.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#ifndef __MFD_LMP92001_DEBUG_H__
> +#define __MFD_LMP92001_DEBUG_H__
> +
> +int lmp92001_debug_init(struct lmp92001 *lmp92001);
> +void lmp92001_debug_exit(struct lmp92001 *lmp92001);
> +
> +#endif /* __MFD_LMP92001_DEBUG_H__ */

Ran out of time towards the end of this so review was rather less detailed!

Will take a look at the next version after you've broken this up.

Jonathan


