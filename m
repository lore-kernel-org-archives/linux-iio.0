Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:49431 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290AbcGRWiX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 18 Jul 2016 18:38:23 -0400
Date: Tue, 19 Jul 2016 00:38:21 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: stx104: Move the STX104 IIO driver to the ADC
 directory
In-Reply-To: <dfebde6197d42697a6a604556cfe7538918caa34.1468849832.git.vilhelm.gray@gmail.com>
Message-ID: <alpine.DEB.2.02.1607190026540.25263@pmeerw.net>
References: <a96d214483354349996a0dc896eecea121983574.1468849832.git.vilhelm.gray@gmail.com> <dfebde6197d42697a6a604556cfe7538918caa34.1468849832.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 18 Jul 2016, William Breathitt Gray wrote:

> The Apex Embedded Systems STX104 is primarily an analog-to-digital
> converter device. The STX104 IIO driver was initially placed in the DAC
> directory because only the DAC portion of the STX104 was supported at
> the time. Now that ADC support has been added to the STX104 IIO driver,
> the driver should be moved to the more appropriate ADC directory.

minor comments below (the full code is easier to read, so commenting here)
 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  MAINTAINERS              |   2 +-
>  drivers/iio/adc/Kconfig  |   9 ++
>  drivers/iio/adc/Makefile |   1 +
>  drivers/iio/adc/stx104.c | 371 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/iio/dac/Kconfig  |   9 --
>  drivers/iio/dac/Makefile |   1 -
>  drivers/iio/dac/stx104.c | 371 -----------------------------------------------
>  7 files changed, 382 insertions(+), 382 deletions(-)
>  create mode 100644 drivers/iio/adc/stx104.c
>  delete mode 100644 drivers/iio/dac/stx104.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 345e757..95dd91b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -796,7 +796,7 @@ APEX EMBEDDED SYSTEMS STX104 DAC DRIVER
>  M:	William Breathitt Gray <vilhelm.gray@gmail.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
> -F:	drivers/iio/dac/stx104.c
> +F:	drivers/iio/adc/stx104.c
>  
>  APM DRIVER
>  M:	Jiri Kosina <jikos@kernel.org>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 1de31bd..62521f3 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -396,6 +396,15 @@ config ROCKCHIP_SARADC
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called rockchip_saradc.
>  
> +config STX104
> +	tristate "Apex Embedded Systems STX104 driver"
> +	depends on X86 && ISA_BUS_API
> +	select GPIOLIB
> +	help
> +	  Say yes here to build support for the Apex Embedded Systems STX104
> +	  integrated analog PC/104 card. The base port addresses for the devices
> +	  may be configured via the base array module parameter.
> +
>  config TI_ADC081C
>  	tristate "Texas Instruments ADC081C/ADC101C/ADC121C family"
>  	depends on I2C
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 0ba0d50..d7b4a71 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -38,6 +38,7 @@ obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
>  obj-$(CONFIG_QCOM_SPMI_IADC) += qcom-spmi-iadc.o
>  obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-spmi-vadc.o
>  obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
> +obj-$(CONFIG_STX104) += stx104.o
>  obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
>  obj-$(CONFIG_TI_ADC0832) += ti-adc0832.o
>  obj-$(CONFIG_TI_ADC128S052) += ti-adc128s052.o
> diff --git a/drivers/iio/adc/stx104.c b/drivers/iio/adc/stx104.c
> new file mode 100644
> index 0000000..4b59721
> --- /dev/null
> +++ b/drivers/iio/adc/stx104.c
> @@ -0,0 +1,371 @@
> +/*
> + * IIO driver for the Apex Embedded Systems STX104
> + * Copyright (C) 2016 William Breathitt Gray
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + */
> +#include <linux/bitops.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/types.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/isa.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/spinlock.h>
> +
> +#define STX104_EXTENT 16
> +
> +#define STX104_OUT_CHAN(chan) {				\
> +	.type = IIO_VOLTAGE,				\
> +	.channel = chan,				\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> +	.indexed = 1,					\
> +	.output = 1					\
> +}
> +#define STX104_GAIN_CHAN {					\
> +	.type = IIO_VOLTAGE,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_HARDWAREGAIN),	\
> +	.output = 1						\
> +}
> +#define STX104_IN_CHAN(chan) {				\
> +	.type = IIO_VOLTAGE,				\
> +	.channel = chan,				\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE),	\

shouldn't this be _RAW? I'm confused

> +	.indexed = 1					\
> +}
> +
> +#define STX104_NUM_OUT_CHAN 2
> +#define STX104_NUM_GAIN_CHAN 1
> +#define STX104_NUM_IN_CHAN 16
> +#define IN_CHAN_OFFSET (STX104_NUM_OUT_CHAN + STX104_NUM_GAIN_CHAN)

prefix required

> +#define STX104_MAX_NUM_CHAN (IN_CHAN_OFFSET + STX104_NUM_IN_CHAN)

do we really need MAX_NUM_CHAN?

> +
> +static unsigned int base[max_num_isa_dev(STX104_EXTENT)];
> +static unsigned int num_stx104;
> +module_param_array(base, uint, &num_stx104, 0);
> +MODULE_PARM_DESC(base, "Apex Embedded Systems STX104 base addresses");
> +
> +/**
> + * struct stx104_iio - IIO device private data structure
> + * @chan_out_states:	channels' output states
> + * @base:		base port address of the IIO device
> + */
> +struct stx104_iio {
> +	unsigned int chan_out_states[STX104_NUM_OUT_CHAN];
> +	unsigned int base;
> +};
> +
> +/**
> + * struct stx104_gpio - GPIO device private data structure
> + * @chip:	instance of the gpio_chip
> + * @lock:	synchronization lock to prevent I/O race conditions
> + * @base:	base port address of the GPIO device
> + * @out_state:	output bits state
> + */
> +struct stx104_gpio {
> +	struct gpio_chip chip;
> +	spinlock_t lock;
> +	unsigned int base;
> +	unsigned int out_state;
> +};
> +
> +static int stx104_read_raw(struct iio_dev *indio_dev,
> +	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
> +{
> +	struct stx104_iio *const priv = iio_priv(indio_dev);
> +	long adc_sample;
> +	unsigned int adc_config;
> +	long adbu;
> +	unsigned int gain;
> +
> +	/* handle output channels */
> +	if (chan->output) {
> +		switch (mask) {
> +		case IIO_CHAN_INFO_RAW:
> +			*val = priv->chan_out_states[chan->channel];
> +			return IIO_VAL_INT;
> +		case IIO_CHAN_INFO_HARDWAREGAIN:
> +			*val = 1 << (inb(priv->base + 11) & 0x3);
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (mask != IIO_CHAN_INFO_SCALE)
> +		return -EINVAL;
> +
> +	/* select ADC channel */
> +	outb(chan->channel | (chan->channel << 4), priv->base + 2);
> +
> +	/* trigger ADC sample capture and wait for completion*/

add whitespace before */

> +	outb(0, priv->base);
> +	while (inb(priv->base + 8) & BIT(7));
> +
> +	adc_sample = inw(priv->base);
> +
> +	/* get ADC bipolar/unipolar and gain configuration */
> +	adc_config = inb(priv->base + 11);
> +	adbu = !(adc_config & BIT(2));
> +	gain = adc_config & 0x3;
> +
> +	/* Value conversion math:
> +	 * ----------------------
> +	 * scale = adc_sample / 65536
> +	 * range = 10 / (1 << gain)
> +	 * voltage = scale * (range + adbu * range) - adbu * range
> +	 *
> +	 * Simplified:
> +	 * -----------
> +	 * voltage = 5 * (adc_sample * (1 + adbu) - adbu * 65536) /
> +	 *	(1 << (15 + gain))
> +	 *
> +	 * Portability Caution:
> +	 * --------------------
> +	 * *val will be set to a value between -327680 and 327675; in order to
> +	 * prevent integer underflow/overflow, the int data type of the
> +	 * implementation should be capable of representing this value range.
> +	 */
> +	*val = 5 * (adc_sample * (1 + adbu) - adbu * 65536);
> +	*val2 = 15 + gain;
> +
> +	return IIO_VAL_FRACTIONAL_LOG2;
> +}
> +
> +static int stx104_write_raw(struct iio_dev *indio_dev,
> +	struct iio_chan_spec const *chan, int val, int val2, long mask)
> +{
> +	struct stx104_iio *const priv = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		/* DAC can only accept up to a 16-bit value */
> +		if ((unsigned int)val > 65535)
> +			return -EINVAL;
> +
> +		priv->chan_out_states[chan->channel] = val;
> +		outw(val, priv->base + 4 + 2 * chan->channel);
> +

return 0;
here would be clearer IMHO

> +		break;
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		/* Only four gain states (x1, x2, x4, x8) */
> +		switch (val) {
> +		case 1:
> +			outb(0, priv->base + 11);
> +			break;
> +		case 2:
> +			outb(1, priv->base + 11);
> +			break;
> +		case 4:
> +			outb(2, priv->base + 11);
> +			break;
> +		case 8:
> +			outb(3, priv->base + 11);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct iio_info stx104_info = {
> +	.driver_module = THIS_MODULE,
> +	.read_raw = stx104_read_raw,
> +	.write_raw = stx104_write_raw

maybe end with ,

> +};
> +
> +static struct iio_chan_spec stx104_channels[STX104_MAX_NUM_CHAN] = {

I'd put a note stating that chan_spec is modified lateron, hence NOT const

> +	STX104_OUT_CHAN(0), STX104_OUT_CHAN(1),
> +	STX104_GAIN_CHAN,
> +	STX104_IN_CHAN(0), STX104_IN_CHAN(1), STX104_IN_CHAN(2),
> +	STX104_IN_CHAN(3), STX104_IN_CHAN(4), STX104_IN_CHAN(5),
> +	STX104_IN_CHAN(6), STX104_IN_CHAN(7), STX104_IN_CHAN(8),
> +	STX104_IN_CHAN(9), STX104_IN_CHAN(10), STX104_IN_CHAN(11),
> +	STX104_IN_CHAN(12), STX104_IN_CHAN(13), STX104_IN_CHAN(14),
> +	STX104_IN_CHAN(15)
> +};
> +
> +static int stx104_gpio_get_direction(struct gpio_chip *chip,
> +	unsigned int offset)
> +{
> +	if (offset < 4)

what is 4?

> +		return 1;
> +
> +	return 0;
> +}
> +
> +static int stx104_gpio_direction_input(struct gpio_chip *chip,
> +	unsigned int offset)
> +{
> +	if (offset >= 4)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int stx104_gpio_direction_output(struct gpio_chip *chip,
> +	unsigned int offset, int value)
> +{
> +	if (offset < 4)
> +		return -EINVAL;
> +
> +	chip->set(chip, offset, value);
> +	return 0;
> +}
> +
> +static int stx104_gpio_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +	struct stx104_gpio *const stx104gpio = gpiochip_get_data(chip);
> +
> +	if (offset >= 4)
> +		return -EINVAL;
> +
> +	return !!(inb(stx104gpio->base) & BIT(offset));
> +}
> +
> +static void stx104_gpio_set(struct gpio_chip *chip, unsigned int offset,
> +	int value)
> +{
> +	struct stx104_gpio *const stx104gpio = gpiochip_get_data(chip);
> +	const unsigned int mask = BIT(offset) >> 4;
> +	unsigned long flags;
> +
> +	if (offset < 4)
> +		return;
> +
> +	spin_lock_irqsave(&stx104gpio->lock, flags);
> +
> +	if (value)
> +		stx104gpio->out_state |= mask;
> +	else
> +		stx104gpio->out_state &= ~mask;
> +
> +	outb(stx104gpio->out_state, stx104gpio->base);
> +
> +	spin_unlock_irqrestore(&stx104gpio->lock, flags);
> +}
> +
> +static int stx104_probe(struct device *dev, unsigned int id)
> +{
> +	struct iio_dev *indio_dev;
> +	struct stx104_iio *priv;
> +	struct stx104_gpio *stx104gpio;
> +	int i;
> +	int err;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	stx104gpio = devm_kzalloc(dev, sizeof(*stx104gpio), GFP_KERNEL);
> +	if (!stx104gpio)
> +		return -ENOMEM;
> +
> +	if (!devm_request_region(dev, base[id], STX104_EXTENT,
> +		dev_name(dev))) {
> +		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
> +			base[id], base[id] + STX104_EXTENT);
> +		return -EBUSY;
> +	}
> +
> +	indio_dev->info = &stx104_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->num_channels = IN_CHAN_OFFSET + STX104_NUM_IN_CHAN;

ARRAY_SIZE()

> +
> +	/* determine if differential inputs */
> +	if (inb(base[id] + 8) & BIT(5)) {
> +		indio_dev->num_channels -= STX104_NUM_IN_CHAN / 2;
> +
> +		for (i = 0; i < STX104_NUM_IN_CHAN / 2; i++) {
> +			stx104_channels[i + IN_CHAN_OFFSET].differential = 1;
> +			stx104_channels[i + IN_CHAN_OFFSET].channel2 = i;
> +		}
> +	}
> +
> +	indio_dev->channels = stx104_channels;
> +	indio_dev->name = dev_name(dev);
> +
> +	priv = iio_priv(indio_dev);
> +	priv->base = base[id];
> +
> +	/* configure device for software trigger operation */
> +	outb(0, base[id] + 9);
> +
> +	/* initialize gain setting to x1 */
> +	outb(0, base[id] + 11);
> +
> +	/* initialize DAC output to 0V */
> +	outw(0, base[id] + 4);
> +	outw(0, base[id] + 6);
> +
> +	err = devm_iio_device_register(dev, indio_dev);

shouldn't use devm_ if stuff is done in _remove()

> +	if (err) {
> +		dev_err(dev, "IIO device registering failed (%d)\n", err);
> +		return err;
> +	}
> +
> +	stx104gpio->chip.label = dev_name(dev);
> +	stx104gpio->chip.parent = dev;
> +	stx104gpio->chip.owner = THIS_MODULE;
> +	stx104gpio->chip.base = -1;
> +	stx104gpio->chip.ngpio = 8;
> +	stx104gpio->chip.get_direction = stx104_gpio_get_direction;
> +	stx104gpio->chip.direction_input = stx104_gpio_direction_input;
> +	stx104gpio->chip.direction_output = stx104_gpio_direction_output;
> +	stx104gpio->chip.get = stx104_gpio_get;
> +	stx104gpio->chip.set = stx104_gpio_set;
> +	stx104gpio->base = base[id] + 3;
> +	stx104gpio->out_state = 0x0;
> +
> +	spin_lock_init(&stx104gpio->lock);
> +
> +	dev_set_drvdata(dev, stx104gpio);
> +
> +	err = gpiochip_add_data(&stx104gpio->chip, stx104gpio);
> +	if (err) {

need to iio_device_unregister()
I'd move the gpio stuff BEFORE iio_device_register(), to avoid a potential 
race window

> +		dev_err(dev, "GPIO registering failed (%d)\n", err);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int stx104_remove(struct device *dev, unsigned int id)
> +{
> +	struct stx104_gpio *const stx104gpio = dev_get_drvdata(dev);
> +
> +	gpiochip_remove(&stx104gpio->chip);
> +
> +	return 0;
> +}
> +
> +static struct isa_driver stx104_driver = {
> +	.probe = stx104_probe,
> +	.driver = {
> +		.name = "stx104"
> +	},
> +	.remove = stx104_remove
> +};
> +
> +module_isa_driver(stx104_driver, num_stx104);
> +
> +MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
> +MODULE_DESCRIPTION("Apex Embedded Systems STX104 IIO driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index f7f896e..d359fef 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -245,15 +245,6 @@ config MCP4922
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called mcp4922.
>  
> -config STX104
> -	tristate "Apex Embedded Systems STX104 driver"
> -	depends on X86 && ISA_BUS_API
> -	select GPIOLIB
> -	help
> -	  Say yes here to build support for the Apex Embedded Systems STX104
> -	  integrated analog PC/104 card. The base port addresses for the devices
> -	  may be configured via the base array module parameter.
> -
>  config VF610_DAC
>  	tristate "Vybrid vf610 DAC driver"
>  	depends on OF
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index 8b78d5c..7acb05d 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -26,5 +26,4 @@ obj-$(CONFIG_MAX517) += max517.o
>  obj-$(CONFIG_MAX5821) += max5821.o
>  obj-$(CONFIG_MCP4725) += mcp4725.o
>  obj-$(CONFIG_MCP4922) += mcp4922.o
> -obj-$(CONFIG_STX104) += stx104.o
>  obj-$(CONFIG_VF610_DAC) += vf610_dac.o
> diff --git a/drivers/iio/dac/stx104.c b/drivers/iio/dac/stx104.c
> deleted file mode 100644
> index 4986e9a..0000000
> --- a/drivers/iio/dac/stx104.c
> +++ /dev/null
> @@ -1,371 +0,0 @@
> -/*
> - * IIO driver for the Apex Embedded Systems STX104
> - * Copyright (C) 2016 William Breathitt Gray
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License, version 2, as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> -#include <linux/bitops.h>
> -#include <linux/device.h>
> -#include <linux/errno.h>
> -#include <linux/gpio/driver.h>
> -#include <linux/iio/iio.h>
> -#include <linux/iio/types.h>
> -#include <linux/io.h>
> -#include <linux/ioport.h>
> -#include <linux/isa.h>
> -#include <linux/module.h>
> -#include <linux/moduleparam.h>
> -#include <linux/spinlock.h>
> -
> -#define STX104_EXTENT 16
> -
> -#define STX104_OUT_CHAN(chan) {				\
> -	.type = IIO_VOLTAGE,				\
> -	.channel = chan,				\
> -	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> -	.indexed = 1,					\
> -	.output = 1					\
> -}
> -#define STX104_GAIN_CHAN {					\
> -	.type = IIO_VOLTAGE,					\
> -	.info_mask_separate = BIT(IIO_CHAN_INFO_HARDWAREGAIN),	\
> -	.output = 1						\
> -}
> -#define STX104_IN_CHAN(chan) {				\
> -	.type = IIO_VOLTAGE,				\
> -	.channel = chan,				\
> -	.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE),	\
> -	.indexed = 1					\
> -}
> -
> -#define STX104_NUM_OUT_CHAN 2
> -#define STX104_NUM_GAIN_CHAN 1
> -#define STX104_NUM_IN_CHAN 16
> -#define IN_CHAN_OFFSET (STX104_NUM_OUT_CHAN + STX104_NUM_GAIN_CHAN)
> -#define STX104_MAX_NUM_CHAN (IN_CHAN_OFFSET + STX104_NUM_IN_CHAN)
> -
> -static unsigned int base[max_num_isa_dev(STX104_EXTENT)];
> -static unsigned int num_stx104;
> -module_param_array(base, uint, &num_stx104, 0);
> -MODULE_PARM_DESC(base, "Apex Embedded Systems STX104 base addresses");
> -
> -/**
> - * struct stx104_iio - IIO device private data structure
> - * @chan_out_states:	channels' output states
> - * @base:		base port address of the IIO device
> - */
> -struct stx104_iio {
> -	unsigned int chan_out_states[STX104_NUM_OUT_CHAN];
> -	unsigned base;
> -};
> -
> -/**
> - * struct stx104_gpio - GPIO device private data structure
> - * @chip:	instance of the gpio_chip
> - * @lock:	synchronization lock to prevent I/O race conditions
> - * @base:	base port address of the GPIO device
> - * @out_state:	output bits state
> - */
> -struct stx104_gpio {
> -	struct gpio_chip chip;
> -	spinlock_t lock;
> -	unsigned int base;
> -	unsigned int out_state;
> -};
> -
> -static int stx104_read_raw(struct iio_dev *indio_dev,
> -	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
> -{
> -	struct stx104_iio *const priv = iio_priv(indio_dev);
> -	long adc_sample;
> -	unsigned int adc_config;
> -	long adbu;
> -	unsigned int gain;
> -
> -	/* handle output channels */
> -	if (chan->output) {
> -		switch (mask) {
> -		case IIO_CHAN_INFO_RAW:
> -			*val = priv->chan_out_states[chan->channel];
> -			return IIO_VAL_INT;
> -		case IIO_CHAN_INFO_HARDWAREGAIN:
> -			*val = 1 << (inb(priv->base + 11) & 0x3);
> -			return IIO_VAL_INT;
> -		default:
> -			return -EINVAL;
> -		}
> -	}
> -
> -	if (mask != IIO_CHAN_INFO_SCALE)
> -		return -EINVAL;
> -
> -	/* select ADC channel */
> -	outb(chan->channel | (chan->channel << 4), priv->base + 2);
> -
> -	/* trigger ADC sample capture and wait for completion*/
> -	outb(0, priv->base);
> -	while (inb(priv->base + 8) & BIT(7));
> -
> -	adc_sample = inw(priv->base);
> -
> -	/* get ADC bipolar/unipolar and gain configuration */
> -	adc_config = inb(priv->base + 11);
> -	adbu = !(adc_config & BIT(2));
> -	gain = adc_config & 0x3;
> -
> -	/* Value conversion math:
> -	 * ----------------------
> -	 * scale = adc_sample / 65536
> -	 * range = 10 / (1 << gain)
> -	 * voltage = scale * (range + adbu * range) - adbu * range
> -	 *
> -	 * Simplified:
> -	 * -----------
> -	 * voltage = 5 * (adc_sample * (1 + adbu) - adbu * 65536) /
> -	 *	(1 << (15 + gain))
> -	 *
> -	 * Portability Caution:
> -	 * --------------------
> -	 * *val will be set to a value between -327680 and 327675; in order to
> -	 * prevent integer underflow/overflow, the int data type of the
> -	 * implementation should be capable of representing this value range.
> -	 */
> -	*val = 5 * (adc_sample * (1 + adbu) - adbu * 65536);
> -	*val2 = 15 + gain;
> -
> -	return IIO_VAL_FRACTIONAL_LOG2;
> -}
> -
> -static int stx104_write_raw(struct iio_dev *indio_dev,
> -	struct iio_chan_spec const *chan, int val, int val2, long mask)
> -{
> -	struct stx104_iio *const priv = iio_priv(indio_dev);
> -
> -	switch (mask) {
> -	case IIO_CHAN_INFO_RAW:
> -		/* DAC can only accept up to a 16-bit value */
> -		if ((unsigned int)val > 65535)
> -			return -EINVAL;
> -
> -		priv->chan_out_states[chan->channel] = val;
> -		outw(val, priv->base + 4 + 2 * chan->channel);
> -
> -		break;
> -	case IIO_CHAN_INFO_HARDWAREGAIN:
> -		/* Only four gain states (x1, x2, x4, x8) */
> -		switch (val) {
> -		case 1:
> -			outb(0, priv->base + 11);
> -			break;
> -		case 2:
> -			outb(1, priv->base + 11);
> -			break;
> -		case 4:
> -			outb(2, priv->base + 11);
> -			break;
> -		case 8:
> -			outb(3, priv->base + 11);
> -			break;
> -		default:
> -			return -EINVAL;
> -		}
> -
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -static const struct iio_info stx104_info = {
> -	.driver_module = THIS_MODULE,
> -	.read_raw = stx104_read_raw,
> -	.write_raw = stx104_write_raw
> -};
> -
> -static struct iio_chan_spec stx104_channels[STX104_MAX_NUM_CHAN] = {
> -	STX104_OUT_CHAN(0), STX104_OUT_CHAN(1),
> -	STX104_GAIN_CHAN,
> -	STX104_IN_CHAN(0), STX104_IN_CHAN(1), STX104_IN_CHAN(2),
> -	STX104_IN_CHAN(3), STX104_IN_CHAN(4), STX104_IN_CHAN(5),
> -	STX104_IN_CHAN(6), STX104_IN_CHAN(7), STX104_IN_CHAN(8),
> -	STX104_IN_CHAN(9), STX104_IN_CHAN(10), STX104_IN_CHAN(11),
> -	STX104_IN_CHAN(12), STX104_IN_CHAN(13), STX104_IN_CHAN(14),
> -	STX104_IN_CHAN(15)
> -};
> -
> -static int stx104_gpio_get_direction(struct gpio_chip *chip,
> -	unsigned int offset)
> -{
> -	if (offset < 4)
> -		return 1;
> -
> -	return 0;
> -}
> -
> -static int stx104_gpio_direction_input(struct gpio_chip *chip,
> -	unsigned int offset)
> -{
> -	if (offset >= 4)
> -		return -EINVAL;
> -
> -	return 0;
> -}
> -
> -static int stx104_gpio_direction_output(struct gpio_chip *chip,
> -	unsigned int offset, int value)
> -{
> -	if (offset < 4)
> -		return -EINVAL;
> -
> -	chip->set(chip, offset, value);
> -	return 0;
> -}
> -
> -static int stx104_gpio_get(struct gpio_chip *chip, unsigned int offset)
> -{
> -	struct stx104_gpio *const stx104gpio = gpiochip_get_data(chip);
> -
> -	if (offset >= 4)
> -		return -EINVAL;
> -
> -	return !!(inb(stx104gpio->base) & BIT(offset));
> -}
> -
> -static void stx104_gpio_set(struct gpio_chip *chip, unsigned int offset,
> -	int value)
> -{
> -	struct stx104_gpio *const stx104gpio = gpiochip_get_data(chip);
> -	const unsigned int mask = BIT(offset) >> 4;
> -	unsigned long flags;
> -
> -	if (offset < 4)
> -		return;
> -
> -	spin_lock_irqsave(&stx104gpio->lock, flags);
> -
> -	if (value)
> -		stx104gpio->out_state |= mask;
> -	else
> -		stx104gpio->out_state &= ~mask;
> -
> -	outb(stx104gpio->out_state, stx104gpio->base);
> -
> -	spin_unlock_irqrestore(&stx104gpio->lock, flags);
> -}
> -
> -static int stx104_probe(struct device *dev, unsigned int id)
> -{
> -	struct iio_dev *indio_dev;
> -	struct stx104_iio *priv;
> -	struct stx104_gpio *stx104gpio;
> -	int i;
> -	int err;
> -
> -	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
> -	if (!indio_dev)
> -		return -ENOMEM;
> -
> -	stx104gpio = devm_kzalloc(dev, sizeof(*stx104gpio), GFP_KERNEL);
> -	if (!stx104gpio)
> -		return -ENOMEM;
> -
> -	if (!devm_request_region(dev, base[id], STX104_EXTENT,
> -		dev_name(dev))) {
> -		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
> -			base[id], base[id] + STX104_EXTENT);
> -		return -EBUSY;
> -	}
> -
> -	indio_dev->info = &stx104_info;
> -	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->num_channels = IN_CHAN_OFFSET + STX104_NUM_IN_CHAN;
> -
> -	/* determine if differential inputs */
> -	if (inb(base[id] + 8) & BIT(5)) {
> -		indio_dev->num_channels -= STX104_NUM_IN_CHAN / 2;
> -
> -		for (i = 0; i < STX104_NUM_IN_CHAN / 2; i++) {
> -			stx104_channels[i + IN_CHAN_OFFSET].differential = 1;
> -			stx104_channels[i + IN_CHAN_OFFSET].channel2 = i;
> -		}
> -	}
> -
> -	indio_dev->channels = stx104_channels;
> -	indio_dev->name = dev_name(dev);
> -
> -	priv = iio_priv(indio_dev);
> -	priv->base = base[id];
> -
> -	/* configure device for software trigger operation */
> -	outb(0, base[id] + 9);
> -
> -	/* initialize gain setting to x1 */
> -	outb(0, base[id] + 11);
> -
> -	/* initialize DAC output to 0V */
> -	outw(0, base[id] + 4);
> -	outw(0, base[id] + 6);
> -
> -	err = devm_iio_device_register(dev, indio_dev);
> -	if (err) {
> -		dev_err(dev, "IIO device registering failed (%d)\n", err);
> -		return err;
> -	}
> -
> -	stx104gpio->chip.label = dev_name(dev);
> -	stx104gpio->chip.parent = dev;
> -	stx104gpio->chip.owner = THIS_MODULE;
> -	stx104gpio->chip.base = -1;
> -	stx104gpio->chip.ngpio = 8;
> -	stx104gpio->chip.get_direction = stx104_gpio_get_direction;
> -	stx104gpio->chip.direction_input = stx104_gpio_direction_input;
> -	stx104gpio->chip.direction_output = stx104_gpio_direction_output;
> -	stx104gpio->chip.get = stx104_gpio_get;
> -	stx104gpio->chip.set = stx104_gpio_set;
> -	stx104gpio->base = base[id] + 3;
> -	stx104gpio->out_state = 0x0;
> -
> -	spin_lock_init(&stx104gpio->lock);
> -
> -	dev_set_drvdata(dev, stx104gpio);
> -
> -	err = gpiochip_add_data(&stx104gpio->chip, stx104gpio);
> -	if (err) {
> -		dev_err(dev, "GPIO registering failed (%d)\n", err);
> -		return err;
> -	}
> -
> -	return 0;
> -}
> -
> -static int stx104_remove(struct device *dev, unsigned int id)
> -{
> -	struct stx104_gpio *const stx104gpio = dev_get_drvdata(dev);
> -
> -	gpiochip_remove(&stx104gpio->chip);
> -
> -	return 0;
> -}
> -
> -static struct isa_driver stx104_driver = {
> -	.probe = stx104_probe,
> -	.driver = {
> -		.name = "stx104"
> -	},
> -	.remove = stx104_remove
> -};
> -
> -module_isa_driver(stx104_driver, num_stx104);
> -
> -MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
> -MODULE_DESCRIPTION("Apex Embedded Systems STX104 IIO driver");
> -MODULE_LICENSE("GPL v2");
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
