Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751191AbdIJOjk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Sep 2017 10:39:40 -0400
Date: Sun, 10 Sep 2017 15:39:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: s.abhisit@gmail.com
Cc: pmeerw@pmeerw.net, knaack.h@gmx.de, lars@metafoo.de,
        fabrice.gasnier@st.com, mike.looijmans@topic.nl, peda@axentia.se,
        jeff.dagenais@gmail.com, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/5] lmp92001: mfd: iio: dac: Add support LMP92001
Message-ID: <20170910153933.57a199b1@archlinux>
In-Reply-To: <20170830181715.9092-1-s.abhisit@gmail.com>
References: <20170830181715.9092-1-s.abhisit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 31 Aug 2017 01:17:15 +0700
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

Various comments inline.

Thanks,

Jonathan
> ---
>  drivers/iio/dac/Kconfig        |   9 ++
>  drivers/iio/dac/Makefile       |   1 +
>  drivers/iio/dac/lmp92001-dac.c | 337 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 347 insertions(+)
>  create mode 100644 drivers/iio/dac/lmp92001-dac.c
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 25bed2d7d2b9..3e0d81606927 100644
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
> index 603587cc2f07..516d2beced7b 100644
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
> index 000000000000..072026e9895c
> --- /dev/null
> +++ b/drivers/iio/dac/lmp92001-dac.c
> @@ -0,0 +1,337 @@
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
> + */
> +
> +#include <linux/iio/iio.h>
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
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (channel->type) {
> +		case IIO_VOLTAGE:
> +			mutex_lock(&lmp92001->dac_lock);

Why does it need to be locked?  The regmap locks will protect
against concurrent writes of this (I think!) so I'm not 
sure what dac_lock is for.

> +
> +			ret = regmap_read(lmp92001->regmap,
> +					0x7F + channel->channel, val);
> +
> +			mutex_unlock(&lmp92001->dac_lock);
> +
> +			if (ret < 0)
> +				return ret;
> +
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int lmp92001_write_raw(struct iio_dev *indio_dev,
> +	struct iio_chan_spec const *channel, int val, int val2, long mask)
> +{
> +	struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
> +	int ret;
> +
> +	if (val < 0 || val > 4095)
> +		return -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (channel->type) {
> +		case IIO_VOLTAGE:
> +			mutex_lock(&lmp92001->dac_lock);
> +
> +			ret = regmap_write(lmp92001->regmap,
> +					0x7F + channel->channel, val);
> +
> +			mutex_unlock(&lmp92001->dac_lock);
> +
> +			if (ret < 0)
> +				return ret;
> +
> +			return 0;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info lmp92001_info = {
> +	.read_raw = lmp92001_read_raw,
> +	.write_raw = lmp92001_write_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static ssize_t lmp92001_dvref_read(struct iio_dev *indio_dev,
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
> +	return sprintf(buf, "%s\n", cref & CREF_DEXT ? "external" : "internal");
> +}
> +
> +static ssize_t lmp92001_dvref_write(struct iio_dev *indio_dev,
> +	uintptr_t private, struct iio_chan_spec const *channel, const char *buf,
> +	size_t len)
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
> +static ssize_t lmp92001_outx_read(struct iio_dev *indio_dev,
> +	uintptr_t private, struct iio_chan_spec const *channel, char *buf)
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
> +static ssize_t lmp92001_outx_write(struct iio_dev *indio_dev,
> +	uintptr_t private, struct iio_chan_spec const *channel,
> +	const char *buf, size_t len)
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
> +static ssize_t lmp92001_gang_read(struct iio_dev *indio_dev,
> +	uintptr_t private, struct iio_chan_spec const *channel, char *buf)
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
> +static ssize_t lmp92001_gang_write(struct iio_dev *indio_dev,
> +	uintptr_t private, struct iio_chan_spec const *channel,
> +	const char *buf, size_t len)
> +{
> +	struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
> +	unsigned int cdac = 0;

Doesn't need an init.  All paths fill it or exit before it is used.

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

Similar comments to before.

> +	}, {
> +		.name = "outx",
> +		.read = lmp92001_outx_read,
> +		.write = lmp92001_outx_write,
> +		.shared = IIO_SHARED_BY_ALL,

There are standard interfaces for this around the power_off modes.
Please use those.

> +	}, {
> +		.name = "gang",

Do we have a usecase where having this expose to userspace
makes sense?  Seems likely to be a more hardware related thing to me.

> +		.read = lmp92001_gang_read,
> +		.write = lmp92001_gang_write,
> +		.shared = IIO_SHARED_BY_ALL,
> +	}, { },
> +};
> +
> +#define LMP92001_CHAN_SPEC(_ch) \
> +{ \
> +	.channel = _ch, \
> +	.type = IIO_VOLTAGE, \
> +	.indexed = 1, \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> +		BIT(IIO_CHAN_INFO_SCALE), \
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
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, 0);
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	iio_device_set_drvdata(indio_dev, lmp92001);
> +
> +	mutex_init(&lmp92001->dac_lock);
> +
> +	indio_dev->name = pdev->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &lmp92001_info;
> +	indio_dev->channels = lmp92001_dac_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(lmp92001_dac_channels);
> +
> +	of_property_read_u8(np, "ti,lmp92001-dac-hiz", &hiz);
> +	cdac = hiz;

Previously we have always had this a sysfs controlled rather
than coming from the device tree.  Explain why it should be in
the device tree...

> +
> +	of_property_read_u8(np, "ti,lmp92001-dac-outx", &outx);
> +	cdac |= outx << 1;

This one is just odd.   Not sure what it is supposed to be for.
Is it about making the pin a gpio?  If so should be supported
explicitly through a gpio driver.

> +
> +	of_property_read_u8(np, "ti,lmp92001-dac-gang", &gang);
> +	cdac |= gang << 2;

I'll admit I am having trouble thinking of how else you could describe
this quite nasty bit of hardware logic..  Guess go with this until
someone comes up with something better!

> +
> +	ret = regmap_update_bits(lmp92001->regmap, LMP92001_CDAC,
> +					CDAC_GANG | CDAC_OLVL | CDAC_OFF, cdac);
> +	if (ret < 0)
> +		return ret;
> +
> +	return devm_iio_device_register(&pdev->dev, indio_dev);
> +}
> +
> +static int lmp92001_dac_remove(struct platform_device *pdev)
> +{
> +	return 0;

No need to provide an empty remove.

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

Again, justify this not being module_init.  I'm unconvinced at
the moment.

> +
> +static void __exit lmp92001_dac_exit(void)
> +{
> +	platform_driver_unregister(&lmp92001_dac_driver);
> +}
> +module_exit(lmp92001_dac_exit);
> +
> +MODULE_AUTHOR("Abhisit Sangjan <s.abhisit@gmail.com>");
> +MODULE_DESCRIPTION("IIO DAC interface for TI LMP92001");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:lmp92001-dac");

