Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46580 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753421AbdENOgw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 May 2017 10:36:52 -0400
Subject: Re: [PATCH v3 5/5] iio: adc: New driver for Cirrus Logic EP93xx ADC
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Ryan Mallon <rmallon@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20170514092954.12790-1-alexander.sverdlin@gmail.com>
 <20170514092954.12790-6-alexander.sverdlin@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <402b1dce-9028-6844-eef4-d12fb9340679@kernel.org>
Date: Sun, 14 May 2017 15:36:49 +0100
MIME-Version: 1.0
In-Reply-To: <20170514092954.12790-6-alexander.sverdlin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/05/17 10:29, Alexander Sverdlin wrote:
> New driver adding support for ADC found on Cirrus Logic EP93xx series of SoCs.
> Board specific code must take care to create plaform device with all necessary
> resources.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Acked-by: Jonathan Cameron <jic23@kernel.org>Obviously clean up the bits Peter picked up on (thanks Peter!)
but otherwise the delay on this one is going to be picking up the
necessary acks for the early patches or persuading them to
take this patch through the path to the arm-soc tree.

I don't have anything much to add from the review front. I'd sort
of assumed this was working it's way into the kernel already!

Thanks,

Jonathan
> ---
>   Documentation/iio/ep93xx_adc.txt |  29 +++++
>   drivers/iio/adc/Kconfig          |  11 ++
>   drivers/iio/adc/Makefile         |   1 +
>   drivers/iio/adc/ep93xx_adc.c     | 260 +++++++++++++++++++++++++++++++++++++++
>   4 files changed, 301 insertions(+)
>   create mode 100644 Documentation/iio/ep93xx_adc.txt
>   create mode 100644 drivers/iio/adc/ep93xx_adc.c
> 
> diff --git a/Documentation/iio/ep93xx_adc.txt b/Documentation/iio/ep93xx_adc.txt
> new file mode 100644
> index 000000000000..321e59f61f3e
> --- /dev/null
> +++ b/Documentation/iio/ep93xx_adc.txt
> @@ -0,0 +1,29 @@
> +Cirrus Logic EP93xx ADC driver.
> +
> +1. Overview
> +
> +The driver is intended to work on both low-end (EP9301, EP9302) devices with
> +5-channel ADC and high-end (EP9307, EP9312, EP9315) devices with 10-channel
> +touchscreen/ADC module.
> +
> +2. Channel numbering
> +
> +Numbering scheme for channels 0..4 is defined in EP9301 and EP9302 datasheets.
> +EP9307, EP9312 and EP9312 have 3 channels more (total 8), but the numbering is
> +not defined. So the last three are numbered randomly, let's say.
> +
> +Assuming ep93xx_adc is IIO device0, you'd find following entries under
> +/sys/bus/iio/devices/iio:device0/:
> +
> +  +-----------------+---------------+
> +  | sysfs entry     | ball/pin name |
> +  +-----------------+---------------+
> +  | in_voltage0_raw | YM            |
> +  | in_voltage1_raw | SXP           |
> +  | in_voltage2_raw | SXM           |
> +  | in_voltage3_raw | SYP           |
> +  | in_voltage4_raw | SYM           |
> +  | in_voltage5_raw | XP            |
> +  | in_voltage6_raw | XM            |
> +  | in_voltage7_raw | YP            |
> +  +-----------------+---------------+
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 401f47b51d83..a3eba810292a 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -249,6 +249,17 @@ config ENVELOPE_DETECTOR
>   	  To compile this driver as a module, choose M here: the module will be
>   	  called envelope-detector.
>   
> +config EP93XX_ADC
> +	tristate "Cirrus Logic EP93XX ADC driver"
> +	depends on ARCH_EP93XX
> +	help
> +	  Driver for the ADC module on the EP93XX series of SoC from Cirrus Logic.
> +	  It's recommended to switch on CONFIG_HIGH_RES_TIMERS option, in this
> +	  case driver will reduce its CPU usage by 90% in some use cases.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called ep93xx_adc.
> +
>   config EXYNOS_ADC
>   	tristate "Exynos ADC driver support"
>   	depends on ARCH_EXYNOS || ARCH_S3C24XX || ARCH_S3C64XX || (OF && COMPILE_TEST)
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 9339bec4babe..d1a036d38486 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_CC10001_ADC) += cc10001_adc.o
>   obj-$(CONFIG_CPCAP_ADC) += cpcap-adc.o
>   obj-$(CONFIG_DA9150_GPADC) += da9150-gpadc.o
>   obj-$(CONFIG_ENVELOPE_DETECTOR) += envelope-detector.o
> +obj-$(CONFIG_EP93XX_ADC) += ep93xx_adc.o
>   obj-$(CONFIG_EXYNOS_ADC) += exynos_adc.o
>   obj-$(CONFIG_FSL_MX25_ADC) += fsl-imx25-gcq.o
>   obj-$(CONFIG_HI8435) += hi8435.o
> diff --git a/drivers/iio/adc/ep93xx_adc.c b/drivers/iio/adc/ep93xx_adc.c
> new file mode 100644
> index 000000000000..7b5b35ef6d1b
> --- /dev/null
> +++ b/drivers/iio/adc/ep93xx_adc.c
> @@ -0,0 +1,260 @@
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
> + * datasheets, reading ADCResult register starts the conversion, but user is also
> + * responsible for ensuring that delay between adjacent conversion triggers is
> + * long enough so that maximum allowed conversion rate is not exceeded. This
> + * basically renders IRQ mode unusable.
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
> +/*
> + * This code could benefit from real HR Timers, but jiffy granularity would
> + * lower ADC conversion rate down to CONFIG_HZ, so we fallback to busy wait
> + * in such case.
> + *
> + * HR Timers-based version loads CPU only up to 10% during back to back ADC
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
> +#define EP93XX_ADC_CH(index, dname, swcfg) {			\
> +	.type = IIO_VOLTAGE,					\
> +	.indexed = 1,						\
> +	.channel = index,					\
> +	.address = swcfg,					\
> +	.datasheet_name = dname,				\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE) |	\
> +				   BIT(IIO_CHAN_INFO_OFFSET),	\
> +}
> +
> +/*
> + * Numbering scheme for channels 0..4 is defined in EP9301 and EP9302 datasheets.
> + * EP9307, EP9312 and EP9312 have 3 channels more (total 8), but the numbering is
> + * not defined. So the last three are numbered randomly, let's say.
> + */
> +static const struct iio_chan_spec ep93xx_adc_channels[EP93XX_NUM_CHANNELS] = {
> +	EP93XX_ADC_CH(0, "YM",	0x608),
> +	EP93XX_ADC_CH(1, "SXP",	0x680),
> +	EP93XX_ADC_CH(2, "SXM",	0x640),
> +	EP93XX_ADC_CH(3, "SYP",	0x620),
> +	EP93XX_ADC_CH(4, "SYM",	0x610),
> +	EP93XX_ADC_CH(5, "XP",	0x601),
> +	EP93XX_ADC_CH(6, "XM",	0x602),
> +	EP93XX_ADC_CH(7, "YP",	0x604),
> +};
> +
> +static int ep93xx_read_raw(struct iio_dev *iiodev,
> +			   struct iio_chan_spec const *channel, int *value,
> +			   int *shift, long mask)
> +{
> +	struct ep93xx_adc_priv *priv = iio_priv(iiodev);
> +	unsigned long timeout;
> +	int ret;
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
> +			writel_relaxed(0xAA, priv->base + EP93XX_ADC_SW_LOCK);
> +			writel_relaxed(channel->address,
> +				       priv->base + EP93XX_ADC_SWITCH);
> +			local_irq_enable();
> +			/*
> +			 * Settling delay depends on module clock and could be
> +			 * 2ms or 500us
> +			 */
> +			ep93xx_adc_delay(2000, 2000);
> +		}
> +		/* Start the conversion, eventually discarding old result */
> +		readl_relaxed(priv->base + EP93XX_ADC_RESULT);
> +		/* Ensure maximun conversion rate is not exceeded */
> +		ep93xx_adc_delay(DIV_ROUND_UP(1000000, 925),
> +				 DIV_ROUND_UP(1000000, 925));
> +		/* At this point conversion must be completed, but anyway... */
> +		ret = IIO_VAL_INT;
> +		timeout = jiffies + msecs_to_jiffies(1) + 1;
> +		while (1) {
> +			u32 t;
> +
> +			t = readl_relaxed(priv->base + EP93XX_ADC_RESULT);
> +			if (t & EP93XX_ADC_SDR) {
> +				/* Sign extend lower 16 bits */
> +				*value = (s16)t;
> +				break;
> +			}
> +
> +			if (time_after(jiffies, timeout)) {
> +				dev_err(&iiodev->dev, "Conversion timeout\n");
> +				ret = -ETIMEDOUT;
> +				break;
> +			}
> +
> +			cpu_relax();
> +		}
> +		mutex_unlock(&priv->lock);
> +		return ret;
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
> +	iiodev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
> +	if (!iiodev)
> +		return -ENOMEM;
> +	priv = iio_priv(iiodev);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "Cannot obtain memory resource\n");
> +		return -ENXIO;
> +	}
> +	priv->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv->base)) {
> +		dev_err(&pdev->dev, "Cannot map memory resource\n");
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
> +	platform_set_drvdata(pdev, iiodev);
> +
> +	priv->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(priv->clk)) {
> +		dev_err(&pdev->dev, "Cannot obtain clock\n");
> +		return PTR_ERR(priv->clk);
> +	}
> +
> +	pclk = clk_get_parent(priv->clk);
> +	if (!pclk) {
> +		dev_warn(&pdev->dev, "Cannot obtain parent clock\n");
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
> +			dev_warn(&pdev->dev, "Cannot set clock rate\n");
> +		/*
> +		 * We can tolerate rate setting failure because the module should
> +		 * work in any case.
> +		 */
> +	}
> +
> +	ret = clk_enable(priv->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Cannot enable clock\n");
> +		return ret;
> +	}
> +
> +	ret = iio_device_register(iiodev);
> +	if (ret)
> +		clk_disable(priv->clk);
> +
> +	return ret;
> +}
> +
> +static int ep93xx_adc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *iiodev = platform_get_drvdata(pdev);
> +	struct ep93xx_adc_priv *priv = iio_priv(iiodev);
> +
> +	iio_device_unregister(iiodev);
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
> 

