Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57861 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525AbcGSFgR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jul 2016 01:36:17 -0400
Subject: Re: [PATCH v2 2/2] iio: adc: sun4i_lradc: new driver
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1468350252-11405-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1468350252-11405-2-git-send-email-alexandre.belloni@free-electrons.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
	Chen-Yu Tsai <wens@csie.org>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <fe1ff787-7899-b29a-a11d-9a3048ab8b55@kernel.org>
Date: Mon, 18 Jul 2016 14:38:25 +0100
MIME-Version: 1.0
In-Reply-To: <1468350252-11405-2-git-send-email-alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/07/16 20:04, Alexandre Belloni wrote:
> Add an IIO driver for the Allwinner Low Resolution ADC. This ADC is usually
> used for physical buttons connected using a resistor ladder.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
A few small bits and pieces from me...

Jonathan
> ---
> Changes in v2:
>  - prefixed defines with SUN4I_LRADC_
>  - removed sun4i_lradc_write_raw_get_fmt
>  - set indio_dev->dev.of_node
>  - pushed devm_iio_device_register() at the end of the probe function
>  - added a remove function to call regulator_disable()
> 
>  drivers/iio/adc/Kconfig       |  10 ++
>  drivers/iio/adc/Makefile      |   3 +-
>  drivers/iio/adc/sun4i_lradc.c | 323 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 335 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iio/adc/sun4i_lradc.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 25378c5882e2..87aaac6a5f44 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -384,6 +384,16 @@ config ROCKCHIP_SARADC
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called rockchip_saradc.
>  
> +config SUN4I_LRADC
> +	tristate "Allwinner sun4i LRADC driver"
> +	depends on ARCH_SUNXI || COMPILE_TEST
> +	select IIO_TRIGGER
> +	help
> +	  Say yes here to build support for the LRADC found on Allwinner SoCs.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called sun4i_lradc.
> +
>  config TI_ADC081C
>  	tristate "Texas Instruments ADC081C/ADC101C/ADC121C family"
>  	depends on I2C
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 38638d46f972..a3b165af6bde 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -1,4 +1,4 @@
> -#
> +
??
>  # Makefile for IIO ADC drivers
>  #
>  
> @@ -37,6 +37,7 @@ obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
>  obj-$(CONFIG_QCOM_SPMI_IADC) += qcom-spmi-iadc.o
>  obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-spmi-vadc.o
>  obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
> +obj-$(CONFIG_SUN4I_LRADC) += sun4i_lradc.o
>  obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
>  obj-$(CONFIG_TI_ADC0832) += ti-adc0832.o
>  obj-$(CONFIG_TI_ADC128S052) += ti-adc128s052.o
> diff --git a/drivers/iio/adc/sun4i_lradc.c b/drivers/iio/adc/sun4i_lradc.c
> new file mode 100644
> index 000000000000..cd42e1a994b9
> --- /dev/null
> +++ b/drivers/iio/adc/sun4i_lradc.c
> @@ -0,0 +1,323 @@
> +/*
> + * Driver for the LRADC present on the  Allwinner sun4i
> + *
> + * Copyright 2016 Free Electrons
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
> +#include <linux/bitops.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/sched.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/regulator/consumer.h>
> +
> +#define SUN4I_LRADC_CTRL		0x00
> +#define SUN4I_LRADC_INTC		0x04
> +#define SUN4I_LRADC_INTS		0x08
> +#define SUN4I_LRADC_DATA0		0x0c
> +#define SUN4I_LRADC_DATA1		0x10
> +
> +/* LRADC_CTRL bits */
> +#define SUN4I_LRADC_FIRST_CONVERT_DLY(x)	((x) << 24) /* 8 bits */
> +#define SUN4I_LRADC_CHAN_SELECT(x)		((x) << 22) /* 2 bits */
> +#define SUN4I_LRADC_CONTINUE_TIME_SEL(x)	((x) << 16) /* 4 bits */
> +#define SUN4I_LRADC_KEY_MODE_SEL(x)		((x) << 12) /* 2 bits */
> +#define SUN4I_LRADC_LEVELA_B_CNT(x)		((x) << 8)  /* 4 bits */
> +#define SUN4I_LRADC_HOLD_EN			BIT(6)
> +#define SUN4I_LRADC_LEVELB_VOL(x)		((x) << 4)  /* 2 bits */
> +#define SUN4I_LRADC_SAMPLE_RATE(x)		((x) << 2)  /* 2 bits */
> +#define SUN4I_LRADC_EN				BIT(0)
> +
> +/* LRADC_INTC and LRADC_INTS bits */
> +#define SUN4I_LRADC_CHAN1_KEYUP_IRQ		BIT(12)
> +#define SUN4I_LRADC_CHAN1_ALRDY_HOLD_IRQ	BIT(11)
> +#define SUN4I_LRADC_CHAN1_HOLD_IRQ		BIT(10)
> +#define	SUN4I_LRADC_CHAN1_KEYDOWN_IRQ	BIT(9)
> +#define SUN4I_LRADC_CHAN1_DATA_IRQ		BIT(8)
> +#define SUN4I_LRADC_CHAN0_KEYUP_IRQ		BIT(4)
> +#define SUN4I_LRADC_CHAN0_ALRDY_HOLD_IRQ	BIT(3)
> +#define SUN4I_LRADC_CHAN0_HOLD_IRQ		BIT(2)
> +#define	SUN4I_LRADC_CHAN0_KEYDOWN_IRQ	BIT(1)
> +#define SUN4I_LRADC_CHAN0_DATA_IRQ		BIT(0)
> +
> +#define NUM_SUN4I_LRADC_CHANS		2
> +
> +struct sun4i_lradc_state {
> +	void __iomem *base;
> +	struct regulator *vref_supply;
> +	u32 vref_mv;
> +	struct completion data_ok[NUM_SUN4I_LRADC_CHANS];
> +	spinlock_t lock;
> +};
> +
> +#define SUN4I_LRADC_CHANNEL(chan) {				\
> +	.type = IIO_VOLTAGE,					\
> +	.indexed = 1,						\
> +	.channel = (chan),					\
> +	.scan_index = (chan),					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ)	\
> +}
> +
> +static const struct iio_chan_spec sun4i_lradc_chan_array[] = {
> +	SUN4I_LRADC_CHANNEL(0),
> +	SUN4I_LRADC_CHANNEL(1),
> +};
> +
> +static const struct {
> +	int val;
> +	int val2;
> +} sun4i_lradc_sample_freq_avail[] = {
> +	{250, 0},
> +	{125, 0},
> +	{62, 500000},
> +	{32, 250000},
> +};
> +
> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("32.25 62.5 125 250");
> +
> +static struct attribute *sun4i_lradc_attributes[] = {
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group sun4i_lradc_attribute_group = {
> +	.attrs = sun4i_lradc_attributes,
> +};
> +
> +static irqreturn_t sun4i_lradc_irq(int irq, void *dev_id)
> +{
> +	struct iio_dev *indio_dev = dev_id;
> +	struct sun4i_lradc_state *st = iio_priv(indio_dev);
> +	u32 ints, intc;
> +
> +	spin_lock(&st->lock);
> +
> +	ints = readl(st->base + SUN4I_LRADC_INTS);
> +	intc = readl(st->base + SUN4I_LRADC_INTC);
> +
> +	if (ints & SUN4I_LRADC_CHAN0_DATA_IRQ)
> +		complete_all(&st->data_ok[0]);
> +
> +	if (ints & SUN4I_LRADC_CHAN1_DATA_IRQ)
> +		complete_all(&st->data_ok[1]);
> +
> +	intc &= ~ints;
> +	writel(intc, st->base + SUN4I_LRADC_INTC);
> +	writel(ints, st->base + SUN4I_LRADC_INTS);
> +
> +	spin_unlock(&st->lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int sun4i_lradc_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long mask)
> +{
> +	struct sun4i_lradc_state *st = iio_priv(indio_dev);
> +	int ret, tmp, idx;
> +	unsigned long flags;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		reinit_completion(&st->data_ok[chan->channel]);
> +		spin_lock_irqsave(&st->lock, flags);
> +		tmp = readl(st->base + SUN4I_LRADC_INTC);
> +
> +		if (chan->channel)
> +			tmp |= SUN4I_LRADC_CHAN1_DATA_IRQ;
> +		else
> +			tmp |= SUN4I_LRADC_CHAN0_DATA_IRQ;
> +
> +		writel(tmp, st->base + SUN4I_LRADC_INTC);
> +		spin_unlock_irqrestore(&st->lock, flags);
> +
> +		ret = wait_for_completion_interruptible_timeout(
> +			&st->data_ok[chan->channel],
> +			msecs_to_jiffies(1000));
> +		if (ret == 0)
> +			return -ETIMEDOUT;
> +
> +		if (chan->channel)
> +			*val = readl(st->base + SUN4I_LRADC_DATA1);
> +		else
> +			*val = readl(st->base + SUN4I_LRADC_DATA0);
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = st->vref_mv;
> +		*val2 = 6;
> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		tmp = readl(st->base + SUN4I_LRADC_CTRL);
> +		idx = (tmp >> 2) & 0x3;
> +		*val = sun4i_lradc_sample_freq_avail[idx].val;
> +		*val2 = sun4i_lradc_sample_freq_avail[idx].val2;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int sun4i_lradc_write_raw(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec const *chan,
> +				 int val, int val2, long mask)
> +{
> +	struct sun4i_lradc_state *st = iio_priv(indio_dev);
> +	u32 ctrl;
> +	int i;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		for (i = 0; i < ARRAY_SIZE(sun4i_lradc_sample_freq_avail); i++)
> +			if (sun4i_lradc_sample_freq_avail[i].val == val &&
> +			    sun4i_lradc_sample_freq_avail[i].val2 == val2)
> +				break;
> +		if (i == ARRAY_SIZE(sun4i_lradc_sample_freq_avail))
> +			return -EINVAL;
> +
> +		ctrl = readl(st->base + SUN4I_LRADC_CTRL);
> +		ctrl &= ~SUN4I_LRADC_SAMPLE_RATE(0x3);
> +		writel(ctrl | SUN4I_LRADC_SAMPLE_RATE(i),
> +		       st->base + SUN4I_LRADC_CTRL);
> +
> +		return 0;
> +
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info sun4i_lradc_info = {
> +	.driver_module = THIS_MODULE,
> +	.read_raw = sun4i_lradc_read_raw,
> +	.write_raw = sun4i_lradc_write_raw,
> +	.attrs = &sun4i_lradc_attribute_group,
> +};
> +
> +static int sun4i_lradc_probe(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev;
> +	struct device *dev = &pdev->dev;
> +	struct sun4i_lradc_state *st;
> +	int err;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	indio_dev->dev.parent = dev;
> +	indio_dev->dev.of_node = dev->of_node;
> +	indio_dev->name = dev_name(dev);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &sun4i_lradc_info;
> +
> +	st->vref_supply = devm_regulator_get(dev, "vref");
> +	if (IS_ERR(st->vref_supply))
> +		return PTR_ERR(st->vref_supply);
> +
> +	st->base = devm_ioremap_resource(dev,
> +			platform_get_resource(pdev, IORESOURCE_MEM, 0));
> +	if (IS_ERR(st->base))
> +		return PTR_ERR(st->base);
> +
> +	/* Disable then clear all interrupts */
> +	writel(0, st->base + SUN4I_LRADC_INTC);
> +	writel(0xffffffff, st->base + SUN4I_LRADC_INTS);
> +
> +	err = devm_request_irq(dev, platform_get_irq(pdev, 0),
> +			       sun4i_lradc_irq, 0,
> +			       "sun4i-a10-lradc", indio_dev);
> +	if (err)
> +		return err;
> +
> +	/* Setup the ADC channels available on the board */
> +	indio_dev->num_channels = ARRAY_SIZE(sun4i_lradc_chan_array);
> +	indio_dev->channels = sun4i_lradc_chan_array;
> +
> +	err = regulator_enable(st->vref_supply);
> +	if (err)
> +		return err;
> +
> +	/* lradc Vref internally is divided by 2/3 */
> +	st->vref_mv = regulator_get_voltage(st->vref_supply) * 2 / 3000;
> +
> +	init_completion(&st->data_ok[0]);
> +	init_completion(&st->data_ok[1]);
> +	spin_lock_init(&st->lock);
> +
> +	/* Continuous mode on both channels */
> +	writel(SUN4I_LRADC_CHAN_SELECT(0x3) | SUN4I_LRADC_KEY_MODE_SEL(0x2) |
> +	       SUN4I_LRADC_SAMPLE_RATE(0x00) | SUN4I_LRADC_EN,
> +	       st->base + SUN4I_LRADC_CTRL);
> +
> +	err = devm_iio_device_register(dev, indio_dev);
> +	if (err < 0) {
> +		dev_err(dev, "Couldn't register the device.\n");
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sun4i_lradc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct sun4i_lradc_state *st = iio_priv(indio_dev);
> +
Race condition here.  The interfaces this driver provides (both in
kernel and sysfs etc) are visible until iio_device_unregister occurs.
As you are using the devm_iio_device_register call it'll happen after
you've turned the power off.  Probably not the best plan ;)

Yeah, it's a small race, but lets get it right.  Just don't use
the devm_ version and do an explicit unregister before calling
the next line.
> +	regulator_disable(st->vref_supply);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sun4i_lradc_of_match[] = {
> +	{ .compatible = "allwinner,sun4i-a10-lradc", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, sun4i_lradc_of_match);
> +
> +static struct platform_driver sun4i_lradc_driver = {
> +	.probe	= sun4i_lradc_probe,
> +	.remove = sun4i_lradc_remove,
> +	.driver = {
> +		.name	= "sun4i-a10-lradc",
> +		.of_match_table = of_match_ptr(sun4i_lradc_of_match),
> +	},
> +};
> +
> +module_platform_driver(sun4i_lradc_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Allwinner sun4i low resolution ADC driver");
> +MODULE_AUTHOR("Alexandre Belloni <alexandre.belloni@free-electrons.com>");
> 

