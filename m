Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36236 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751551AbdIJO2r (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 10 Sep 2017 10:28:47 -0400
Date: Sun, 10 Sep 2017 15:28:27 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: s.abhisit@gmail.com
Cc: Jonathan.Cameron@huawei.com, pmeerw@pmeerw.net, jacopo@jmondi.org,
        knaack.h@gmx.de, lars@metafoo.de, fabrice.gasnier@st.com,
        lee.jones@linaro.org, robh@kernel.org, akinobu.mita@gmail.com,
        marek.vasut+renesas@gmail.com, jacopo+renesas@jmondi.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        lukas@wunner.de, adi.reus@gmail.com
Subject: Re: [PATCH 2/5] lmp92001: mfd: iio: adc: Add support LMP92001
Message-ID: <20170910152807.588a1c86@archlinux>
In-Reply-To: <20170830181409.8903-1-s.abhisit@gmail.com>
References: <20170830181409.8903-1-s.abhisit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 31 Aug 2017 01:14:09 +0700
s.abhisit@gmail.com wrote:

> From: Abhisit Sangjan <s.abhisit@gmail.com>
> 
> TI LMP92001 Analog System Monitor and Controller
> 
> 8-bit GPIOs.
> 12 DACs with 12-bit resolution.
> 
> The GPIOs and DACs are shared port function with Cy function pin to
> take control the pin suddenly from external hardware.
> DAC's referance voltage selectable for Internal/External.
> 
> 16 + 1 ADCs with 12-bit resolution.
> 
> Built-in internal Temperature Sensor on channel 17.
> Window Comparator Function is supported on channel 1-3 and 9-11 for
> monitoring with interrupt signal (pending to implement for interrupt).
> ADC's referance voltage selectable for Internal/External.
> 
> Signed-off-by: Abhisit Sangjan <s.abhisit@gmail.com>

This whole series still needs resending.  I notice that your
forwards of the missing patches didn't make it into marc.info
archives either so I'm guessing the list server rejected them for
some reason.  

I'll take a look at the patches I do have here to give you something
to start with, but will need to review the whole set to pick up
on more things.

Various comments inline.

Jonathan
> ---
>  drivers/iio/adc/Kconfig        |  10 +
>  drivers/iio/adc/Makefile       |   1 +
>  drivers/iio/adc/lmp92001-adc.c | 476 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 487 insertions(+)
>  create mode 100644 drivers/iio/adc/lmp92001-adc.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 614fa41559b1..2adeba543ac7 100644
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
> index b546736a5541..2ed89862090b 100644
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
> index 000000000000..f706a364337d
> --- /dev/null
> +++ b/drivers/iio/adc/lmp92001-adc.c
> @@ -0,0 +1,476 @@
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
> +static int lmp92001_read_raw(struct iio_dev *indio_dev,
> +	struct iio_chan_spec const *channel, int *val, int *val2, long mask)
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
> +	 * Waiting for conversion successful.
> +	 */
> +	if (!(cgen & CGEN_STRT)) {
> +		if (!(cgen & CGEN_LCK)) {
> +			ret = regmap_update_bits(lmp92001->regmap,
> +					LMP92001_CGEN, CGEN_LCK, CGEN_LCK);
> +			if (ret < 0)
> +				goto exit;
> +		}
> +
> +		/* Writing any value to trigger Single-Shot conversion. */
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

Some sleep in here would be good...  

> +		} while ((sgen & CGEN_RST) && (--try > 0));
> +
> +		if (!try) {
> +			ret = -ETIME;
> +			goto exit;
> +		}
> +	}
> +
> +	ret = regmap_read(lmp92001->regmap, 0x1F + channel->channel, &code);
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
> +	return sprintf(buf, "%s\n", (cref & CREF_AEXT) ? "external" : "internal");
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
> +	mutex_lock(&lmp92001->adc_lock);
> +
> +	/*
> +	 * Unlock the HW registers.
> +	 * Set conversion mode.
> +	 * Lock the HW registers.
> +	 */
> +	ret = regmap_update_bits(lmp92001->regmap, LMP92001_CGEN, CGEN_LCK, 0);
> +	if (ret < 0)
> +		goto exit;
> +
> +	ret = regmap_update_bits(lmp92001->regmap, LMP92001_CGEN, CGEN_STRT,
> +					cgen);
> +	if (ret < 0)
> +		goto exit;
> +
> +	ret = regmap_update_bits(lmp92001->regmap, LMP92001_CGEN, CGEN_LCK,
> +					CGEN_LCK);
> +	if (ret < 0)
> +		goto exit;
> +
> +	return len;
> +
> +exit:
> +	mutex_unlock(&lmp92001->adc_lock);
> +
> +	return ret;
> +}
> +
> +static const struct iio_chan_spec_ext_info lmp92001_ext_info[] = {
> +	{
> +		.name = "vref",
> +		.read = lmp92001_avref_read,
> +		.write = lmp92001_avref_write,
> +		.shared = IIO_SHARED_BY_ALL,

Do you actually have a usecase where making this change should be
something done by userspace?  Normally if there is a regulator connected
externally that's enough to indicate the hardware designer thought it
should always be used.

> +	}, {
> +		.name = "en",

If you don't have continuous mode by default then this will map
onto the scan_elements/in*_en elements rather here.

> +		.read = lmp92001_enable_read,
> +		.write = lmp92001_enable_write,
> +		.shared = IIO_SEPARATE,
> +	}, {
> +		.name = "mode",

I don't like this for several reasons.
1) mode is far too generic to have as a sysfs attribute.  Nothing in it's
   name tells userspace what is for.  Wash at 40 degrees and spin slowly?
2) Even if we do provide this control to userspace it is extremely difficult
   for a generic userspace program to know what to do with it.  I would much
   prefer it if you investigated ways to make intelligent decisions on whether
   to enable it or not within the driver.  Lots of hardware support such a
   self clocked, sequencer driver mode, we don't don't expose it explicitly.
	a) If you want quick up to date numbers use the buffered interface not
	   sysfs.  If this in use it would be normal to put the device in
	   continuous mode.  It looks like it is impossible to actually know
	   you have new data on this part which seriously limits it generic
	   usefulness as you can't get a clean stream of data. This is really
	   a hardware monitoring part. You could consider a hwmon driver...
	   If used under IIO you'd need to spin up an hrtimer trigger to drive
	   regular sampling.

        b) If events are enabled that need continuous mode, then put it in
           that mode.

	c) Something clever with runtime pm might be possible in which
	continuous mode is enabled as long as the device is read from
	quicker than some rate (1 a second for example) but falls back
	to one shot if the read rate is slower than that... 



> +		.read = lmp92001_mode_read,
> +		.write = lmp92001_mode_write,
> +		.shared = IIO_SHARED_BY_ALL,
> +	}, { },
> +};
> +
> +static const struct iio_event_spec lmp92001_events[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
> +			BIT(IIO_EV_INFO_VALUE),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
> +			BIT(IIO_EV_INFO_VALUE),
> +	}, { },
> +};
> +
> +#define LMP92001_CHAN_SPEC(_ch, _type, _event, _nevent) \
> +{ \
> +	.channel = _ch, \
> +	.type = _type, \
> +	.indexed = 1, \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> +		BIT(IIO_CHAN_INFO_SCALE), \
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
> +	unsigned int cgen = 0, cad1, cad2, cad3;
> +	u32 mask;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, 0);

I'm a little surprised there is nothing specific to the adc part of
the mfd that it would make sense to store locally.  But fair enough if
not!

> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	iio_device_set_drvdata(indio_dev, lmp92001);
> +
> +	mutex_init(&lmp92001->adc_lock);
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
This is confusing...  Perhaps:

"By default turn all channels on. If you require faster performance and know
only certain channels are to be used, then this may be specified in DT.
"

There is a standard way to specify channels present in DT using subnodes.
Please use that rather than introducing a driver specific binding.

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
> +	cgen |= 1; /* Continuous conversion is default. */

Why?  If is much more common for devices to come up in a one shot
mode and only switch over to a continuous mode if there is a reason to
do so.  Saves power that way if no one cares about the result.

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

Compare the order of what is going on in probe with that of what you
are doing in remove.   They should be exactly reversed wrt to each
other.

Now consider when devm managed elements unwinding are run.  (feel free to check
but the answer to that is after the remove function).

So the upshot here is that you turn off the power in remove whilst
the userspace interfaces are still present (as they are only removed once
devm_iio_device_register is reversed after the remove function has finished.

A quick rule of thumb is you can only use devm functions in probe up to the
point where you first do something else that needs to be reversed in remove
but does not have a devm version.
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

This absolutely needs a comment explaining why a simple
module_init is not sufficient.

> +
> +static void __exit lmp92001_adc_exit(void)
> +{
> +	platform_driver_unregister(&lmp92001_adc_driver);
> +}
> +module_exit(lmp92001_adc_exit);
> +
> +MODULE_AUTHOR("Abhisit Sangjan <s.abhisit@gmail.com>");
> +MODULE_DESCRIPTION("IIO ADC interface for TI LMP92001");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:lmp92001-adc");

