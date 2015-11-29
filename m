Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44498 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbbK2QMr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 Nov 2015 11:12:47 -0500
Subject: Re: [PATCH 5/5] iio: adc: New driver for Cirrus Logic EP93xx ADC
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Hartley Sweeten <hsweeten@visionengravers.com>,
	Ryan Mallon <rmallon@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
References: <56558B23.4080506@gmail.com> <5655A0A5.20908@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <565B23FB.9040405@kernel.org>
Date: Sun, 29 Nov 2015 16:12:43 +0000
MIME-Version: 1.0
In-Reply-To: <5655A0A5.20908@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/11/15 11:51, Alexander Sverdlin wrote:
> New driver adding support for ADC found on Cirrus Logic EP93xx series of SoCs.
> Board specific code must take care to create platform device with all necessary
> resources.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Datasheet links always appreciated if available.

Right now Cirrus' website is fighting back so I can't get to any
of their docs - hence bare with me!

A few bits inline.  Primary question which is hard to answer without the
datasheets is what meaning the channel names actually have?  THe brief
says they are general purpose.  If so then it's not really valid
to given them extended names suggesting anything more.

Jonathan
> ---
>  drivers/iio/adc/Kconfig      |  11 ++
>  drivers/iio/adc/Makefile     |   1 +
>  drivers/iio/adc/ep93xx_adc.c | 253 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 265 insertions(+)
>  create mode 100644 drivers/iio/adc/ep93xx_adc.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 7868c74..2ee8b8b 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -172,6 +172,17 @@ config DA9150_GPADC
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called berlin2-adc.
> 
> +config EP93XX_ADC
> +	tristate "Cirrus Logic EP93XX ADC driver"
> +	depends on ARCH_EP93XX
> +	help
> +	  Driver for the ADC module on the EP93XX series of SoC from Cirrus Logic.
> +	  It's recommended to switch on CONFIG_HIGH_RES_TIMERS option, in this
> +	  case driver will reduce its CPU usage by 70% in some use cases.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called ep93xx_adc.
> +
>  config EXYNOS_ADC
>  	tristate "Exynos ADC driver support"
>  	depends on ARCH_EXYNOS || ARCH_S3C24XX || ARCH_S3C64XX || (OF && COMPILE_TEST)
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 99b37a9..5481b42 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_AXP288_ADC) += axp288_adc.o
>  obj-$(CONFIG_BERLIN2_ADC) += berlin2-adc.o
>  obj-$(CONFIG_CC10001_ADC) += cc10001_adc.o
>  obj-$(CONFIG_DA9150_GPADC) += da9150-gpadc.o
> +obj-$(CONFIG_EP93XX_ADC) += ep93xx_adc.o
>  obj-$(CONFIG_EXYNOS_ADC) += exynos_adc.o
>  obj-$(CONFIG_HI8435) += hi8435.o
>  obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
> diff --git a/drivers/iio/adc/ep93xx_adc.c b/drivers/iio/adc/ep93xx_adc.c
> new file mode 100644
> index 0000000..ebaacb9
> --- /dev/null
> +++ b/drivers/iio/adc/ep93xx_adc.c
> @@ -0,0 +1,253 @@
> +/*
> + * Driver for ADC module on the Cirrus Logic EP93xx series of SoCs
> + *
> + * Copyright (C) 2015 Alexander Sverdlin
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * The driver uses polling to get the conversion status. According to EP93xx
> + * datasheets, reading ADCResult register starts the conversion, but user also
> + * responsible for ensuring that delay between adjacent conversion triggers is
> + * long enough so that maximum allowed conversion rate is not exceeded. This
> + * basically renders IRQ mode unusable.
Genius!
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/iio/iio.h>
> +#include <linux/io.h>
> +#include <linux/irqflags.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +
> +#define EP93XX_NUM_CHANNELS 8
> +
> +#define ep93xx_adc_reg_read(reg)	__raw_readl(reg)
> +#define ep93xx_adc_reg_write(val, reg)	__raw_writel(val, reg)
> +
> +/*
> + * This code could benefit from real HR Timers, but jiffy granularity would
> + * lower ADC conversion rate down to CONFIG_HZ, so we fallback to busy wait
> + * in such case.
> + *
> + * HR Timers-based version loads CPU only up to 30% during back to back ADC
> + * conversion, while busy wait-based version consumes whole CPU power.
> + */
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +#define ep93xx_adc_delay(usmin, usmax) usleep_range(usmin, usmax)
> +#else
> +#define ep93xx_adc_delay(usmin, usmax) udelay(usmin)
> +#endif
> +
> +#define EP93XX_ADC_RESULT	0x08
> +#define   EP93XX_ADC_SDR	BIT(31)
> +#define EP93XX_ADC_SWITCH	0x18
> +#define EP93XX_ADC_SW_LOCK	0x20
> +#define EP93XX_ADC_INT_EN	0x24
> +#define   EP93XX_ADC_RINTEN	BIT(11)
> +
> +struct ep93xx_adc_priv {
> +	struct clk *clk;
> +	void __iomem *base;
> +	int lastch;
> +	struct mutex lock;
> +};
> +
> +#define EP93XX_ADC_CH(index, dname, ename, swcfg) {		\
> +	.type = IIO_VOLTAGE,					\
> +	.indexed = 1,						\
> +	.channel = index,					\
> +	.address = swcfg,					\
> +	.datasheet_name = dname,				\
> +	.extend_name = ename,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE) |	\
> +				   BIT(IIO_CHAN_INFO_OFFSET),	\
> +}
> +
> +/*
> + * Numbering scheme for channels 0..4 is defined in EP9301 and EP9302 datasheets.
> + * EP9307, EP9312 and EP9312 have 3 channels more (total 8), but the numering is
> + * not defined. So the last three are numbered randomly, let's say.
> + */
> +static const struct iio_chan_spec ep93xx_adc_channels[EP93XX_NUM_CHANNELS] = {
> +	EP93XX_ADC_CH(0, "YM",	"ym",	0x608),
> +	EP93XX_ADC_CH(1, "SXP",	"sxp",	0x680),
> +	EP93XX_ADC_CH(2, "SXM",	"sxm",	0x640),
> +	EP93XX_ADC_CH(3, "SYP",	"syp",	0x620),
> +	EP93XX_ADC_CH(4, "SYM",	"sym",	0x610),
> +	EP93XX_ADC_CH(5, "XP",	"xp",	0x601),
> +	EP93XX_ADC_CH(6, "XM",	"xm",	0x602),
> +	EP93XX_ADC_CH(7, "YP",	"yp",	0x604),
> +};
Hmm.  I'm a little dubious about the extended names.  What in the device
acutally restricts them to these uses?  This naming is probably something
to do with touch screens?  If there is no special purpose hardware then
I'd just drop the extended names (datasheet names obviously fine if thats
what they are called on the datasheet!)
> +
> +static int ep93xx_read_raw(struct iio_dev *iiodev,
> +			   struct iio_chan_spec const *channel, int *value,
> +			   int *shift, long mask)
> +{
> +	struct ep93xx_adc_priv *priv = iio_priv(iiodev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&priv->lock);
> +		if (priv->lastch != channel->channel) {
> +			priv->lastch = channel->channel;
> +			/*
> +			 * Switch register is software-locked, unlocking must be
> +			 * immediately followed by write
> +			 */
> +			local_irq_disable();
> +			ep93xx_adc_reg_write(0xAA,
> +					     priv->base + EP93XX_ADC_SW_LOCK);
> +			ep93xx_adc_reg_write(channel->address,
> +					     priv->base + EP93XX_ADC_SWITCH);
> +			local_irq_enable();
> +			/*
> +			 * Settling delay depends on module clock and could be
> +			 * 2ms or 500us
> +			 */
> +			ep93xx_adc_delay(2000, 2000);
> +		}
> +		/* Start the conversion, eventually discarding old result */
> +		ep93xx_adc_reg_read(priv->base + EP93XX_ADC_RESULT);
> +		/* Ensure maximun conversion rate is not exceeded */
> +		ep93xx_adc_delay(DIV_ROUND_UP(1000000, 925),
> +				 DIV_ROUND_UP(1000000, 925));
> +		/* At this point conversion must be completed, but anyway... */
> +		while (1) {
Might be worth a timeout and adding a sleep in here to avoid a tight
spin.  Obviously it should always be fine, but who knows!
> +			u32 t;
> +
> +			t = ep93xx_adc_reg_read(priv->base + EP93XX_ADC_RESULT);
> +			if (t & EP93XX_ADC_SDR) {
> +				/* Sign extend lower 16 bits */
> +				*value = (s16)t;
> +				break;
> +			}
> +		}
> +		mutex_unlock(&priv->lock);
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_OFFSET:
> +		/* According to datasheet, range is -25000..25000 */
> +		*value = 25000;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		/* Typical supply voltage is 3.3v */
> +		*value = (1ULL << 32) * 3300 / 50000;
> +		*shift = 32;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info ep93xx_adc_info = {
> +	.driver_module = THIS_MODULE,
> +	.read_raw = ep93xx_read_raw,
> +};
> +
> +static int ep93xx_adc_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct iio_dev *iiodev;
> +	struct ep93xx_adc_priv *priv;
> +	struct clk *pclk;
> +	struct resource *res;
> +
> +	iiodev = devm_iio_device_alloc(&pdev->dev,
> +				       sizeof(struct ep93xx_adc_priv));
> +	if (!iiodev)
> +		return -ENOMEM;
> +	priv = iio_priv(iiodev);
> +
> +	priv->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(priv->clk)) {
> +		dev_err(&pdev->dev, "Cannot obtain clock");
> +		return PTR_ERR(priv->clk);
> +	}
> +
> +	pclk = clk_get_parent(priv->clk);
> +	if (!pclk) {
> +		dev_warn(&pdev->dev, "Cannot obtain parent clock");
> +	} else {
> +		/*
> +		 * This is actually a place for improvement:
> +		 * EP93xx ADC supports two clock divisors -- 4 and 16,
> +		 * resulting in conversion rates 3750 and 925 samples per second
> +		 * respectively with 500uS or 2ms settling time respectively.
> +		 * One might find this interesting enough to be configurable.
> +		 */
> +		ret = clk_set_rate(priv->clk, clk_get_rate(pclk) / 16);
> +		if (ret)
> +			dev_warn(&pdev->dev, "Cannot set clock rate");
> +		/*
> +		 * We can tolerate rate setting failure because the module should
> +		 * work in any case.
> +		 */
> +	}
> +
> +	ret = clk_enable(priv->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Cannot enable clock");
> +		return ret;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "Cannot obtain memory resource");
> +		return -ENXIO;
> +	}
> +	priv->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv->base)) {
> +		dev_err(&pdev->dev, "Cannot map memory resource");
> +		return PTR_ERR(priv->base);
> +	}
> +
> +	iiodev->dev.parent = &pdev->dev;
> +	iiodev->name = dev_name(&pdev->dev);
> +	iiodev->modes = INDIO_DIRECT_MODE;
> +	iiodev->info = &ep93xx_adc_info;
> +	iiodev->num_channels = ARRAY_SIZE(ep93xx_adc_channels);
> +	iiodev->channels = ep93xx_adc_channels;
> +
> +	priv->lastch = -1;
> +	mutex_init(&priv->lock);
> +
> +	ret = devm_iio_device_register(&pdev->dev, iiodev);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, iiodev);
I'd reorder as Peter suggested - it doesn't mater obviously but
you could then do return devm_iio_device_register and save
a few lines of code without a lost of functionality.

However, this is racey as the userspace interface will be removed
'after' the clk_disable below.  Basic rule of thumb is that if
you do anything at all in the remove, you can't use devm_iio_device_register
as if it makes sense to do it it must effect device functionality of a
device still exposed to userspace.

> +
> +	return 0;
> +}
> +
> +static int ep93xx_adc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *iiodev = platform_get_drvdata(pdev);
> +	struct ep93xx_adc_priv *priv = iio_priv(iiodev);
Personal taste, but I'd roll the above into one call as we never
use the iio_dev in this function..

> +
> +	clk_disable(priv->clk);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver ep93xx_adc_driver = {
> +	.driver = {
> +		.name = "ep93xx-adc",
> +	},
> +	.probe = ep93xx_adc_probe,
> +	.remove = ep93xx_adc_remove,
> +};
> +module_platform_driver(ep93xx_adc_driver);
> +
> +MODULE_AUTHOR("Alexander Sverdlin <alexander.sverdlin@gmail.com>");
> +MODULE_DESCRIPTION("Cirrus Logic EP93XX ADC driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:ep93xx-adc");
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

