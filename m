Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39419 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752155AbdAGRvk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Jan 2017 12:51:40 -0500
Subject: Re: [PATCH] adc: add adc driver for Hisilicon BVT SOCs
To: Allen Liu <liurenzhong@hisilicon.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com
References: <1483784170-228765-1-git-send-email-liurenzhong@hisilicon.com>
From: Jonathan Cameron <jic23@kernel.org>
Cc: akinobu.mita@gmail.com, ludovic.desroches@atmel.com,
        krzk@kernel.org, vilhelm.gray@gmail.com,
        ksenija.stanojevic@gmail.com, zhiyong.tao@mediatek.com,
        daniel.baluta@intel.com, leonard.crestez@intel.com,
        ray.jui@broadcom.com, raveendra.padasalagi@broadcom.com,
        mranostay@gmail.com, amsfield22@gmail.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuejiancheng@hisilicon.com,
        kevin.lixu@hisilicon.com
Message-ID: <41fbfc45-9f9a-c2cf-9c27-c4d5a39a400a@kernel.org>
Date: Sat, 7 Jan 2017 12:51:31 -0500
MIME-Version: 1.0
In-Reply-To: <1483784170-228765-1-git-send-email-liurenzhong@hisilicon.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/01/17 05:16, Allen Liu wrote:
> Add ADC driver for the ADC controller found on HiSilicon BVT SOCs, like Hi3516CV300, etc.
> The ADC controller is primarily in charge of detecting voltage.
> 
> Reviewed-by: Kevin Li <kevin.lixu@hisilicon.com>
> Signed-off-by: Allen Liu <liurenzhong@hisilicon.com>
Hi Allen,

One quick submission process note first.  It is very important to clearly identify new
versions of a patch and what changes have occurred since the previous posting.

So the email title should have been [PATCH V2] adc...

Also, below the --- please add a brief change log.

The driver is coming together nicely.  A few minor points inline.

Jonathan
> ---
>  .../devicetree/bindings/iio/adc/hibvt-lsadc.txt    |  23 ++
>  drivers/iio/adc/Kconfig                            |  10 +
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/hibvt_lsadc.c                      | 335 +++++++++++++++++++++
>  4 files changed, 369 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/hibvt-lsadc.txt
>  create mode 100644 drivers/iio/adc/hibvt_lsadc.c
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/hibvt-lsadc.txt b/Documentation/devicetree/bindings/iio/adc/hibvt-lsadc.txt
> new file mode 100644
> index 0000000..fce1ff4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/hibvt-lsadc.txt
> @@ -0,0 +1,23 @@
> +Hisilicon BVT Low Speed (LS) A/D Converter bindings
> +
> +Required properties:
> +- compatible: should be "hisilicon,<name>-lsadc"
> +   - "hisilicon,hi3516cv300-lsadc": for hi3516cv300
> +
> +- reg: physical base address of the controller and length of memory mapped 
> +	   region.
> +- interrupts: The interrupt number for the ADC device.
Ideally refer to the standard interrupt binding document.
Documentation/devicetree/bindings/interrupt-controller/interrupts.txt

> +
> +Optional properties:
> +- resets: Must contain an entry for each entry in reset-names if need support
> +		  this option. See ../../reset/reset.txt for details.
Don't use a relative path in a binding document. It's far too likely to
be broken by a reorganization of the docs and cannot be grepped for.
> +- reset-names: Must include the name "lsadc-crg".
> +
> +Example:
> +	adc: adc@120e0000 {
> +			compatible = "hisilicon,hi3516cv300-lsadc";
> +			reg = <0x120e0000 0x1000>;
> +			interrupts = <19>;
> +			resets = <&crg 0x7c 3>;
> +			reset-names = "lsadc-crg";
> +	};
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 99c0514..0443f51 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -225,6 +225,16 @@ config HI8435
>  	  This driver can also be built as a module. If so, the module will be
>  	  called hi8435.
>  
> +config HIBVT_LSADC
> +	tristate "HIBVT LSADC driver"
> +	depends on ARCH_HISI || COMPILE_TEST
> +	help
> +	  Say yes here to build support for the LSADC found in SoCs from
> +	  hisilicon BVT chip.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called hibvt_lsadc.
> +
>  config INA2XX_ADC
>  	tristate "Texas Instruments INA2xx Power Monitors IIO driver"
>  	depends on I2C && !SENSORS_INA2XX
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 7a40c04..6554d92 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -23,6 +23,7 @@ obj-$(CONFIG_DA9150_GPADC) += da9150-gpadc.o
>  obj-$(CONFIG_EXYNOS_ADC) += exynos_adc.o
>  obj-$(CONFIG_FSL_MX25_ADC) += fsl-imx25-gcq.o
>  obj-$(CONFIG_HI8435) += hi8435.o
> +obj-$(CONFIG_HIBVT_LSADC) += hibvt_lsadc.o
>  obj-$(CONFIG_IMX7D_ADC) += imx7d_adc.o
>  obj-$(CONFIG_INA2XX_ADC) += ina2xx-adc.o
>  obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
> diff --git a/drivers/iio/adc/hibvt_lsadc.c b/drivers/iio/adc/hibvt_lsadc.c
> new file mode 100644
> index 0000000..aaf2024
> --- /dev/null
> +++ b/drivers/iio/adc/hibvt_lsadc.c
> @@ -0,0 +1,335 @@
> +/*
> + * Hisilicon BVT Low Speed (LS) A/D Converter
> + * Copyright (C) 2016 HiSilicon Technologies Co., Ltd.
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
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/reset.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/iio/iio.h>
> +
> +/* hisilicon bvt adc registers definitions */
> +#define HIBVT_LSADC_CONFIG		0x00
> +#define HIBVT_CONFIG_DEGLITCH	BIT(17)
> +#define HIBVT_CONFIG_RESET		BIT(15)
> +#define HIBVT_CONFIG_POWERDOWN	BIT(14)
> +#define HIBVT_CONFIG_MODE		BIT(13)
> +#define HIBVT_CONFIG_CHNC		BIT(10)
> +#define HIBVT_CONFIG_CHNB		BIT(9)
> +#define HIBVT_CONFIG_CHNA		BIT(8)
> +
> +#define HIBVT_LSADC_TIMESCAN	0x08
> +#define HIBVT_LSADC_INTEN		0x10
> +#define HIBVT_LSADC_INTSTATUS	0x14
> +#define HIBVT_LSADC_INTCLR		0x18
> +#define HIBVT_LSADC_START		0x1C
> +#define HIBVT_LSADC_STOP		0x20
> +#define HIBVT_LSADC_ACTBIT		0x24
> +#define HIBVT_LSADC_CHNDATA		0x2C
> +
> +#define HIBVT_LSADC_CON_EN		(1u << 0)
> +#define HIBVT_LSADC_CON_DEN		(0u << 0)
> +
> +#define HIBVT_LSADC_NUM_BITS_V1	10
> +#define HIBVT_LSADC_CHN_MASK_v1	0x7
> +
> +/* fix clk:3000000, default tscan set 10ms */
> +#define HIBVT_LSADC_TSCAN_MS	(10*3000)
> +
> +#define HIBVT_LSADC_TIMEOUT		msecs_to_jiffies(100)
> +
> +/* default voltage scale for every channel <mv> */
> +static int g_hibvt_lsadc_voltage[] = {
> +	3300, 3300, 3300
Is default due to an external reference voltage or is there an internal
regulator?  If it is external it should really be described using the
regulator framework.

Const? 
> +};
> +
> +struct hibvt_lsadc {
> +	void __iomem		*regs;
> +	struct completion	completion;
> +	struct reset_control	*reset;
> +	const struct hibvt_lsadc_data	*data;
> +	unsigned int		cur_chn;
> +	unsigned int		value;
> +};
> +
> +struct hibvt_lsadc_data {
> +	int				num_bits;
> +	const struct iio_chan_spec	*channels;
> +	int				num_channels;
> +
> +	void (*clear_irq)(struct hibvt_lsadc *info, int mask);
> +	void (*start_conv)(struct hibvt_lsadc *info);
> +	void (*stop_conv)(struct hibvt_lsadc *info);
> +};
> +
> +static int hibvt_lsadc_read_raw(struct iio_dev *indio_dev,
> +				    struct iio_chan_spec const *chan,
> +				    int *val, int *val2, long mask)
> +{
> +	struct hibvt_lsadc *info = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&indio_dev->mlock);
> +
> +		reinit_completion(&info->completion);
> +
> +		/* Select the channel to be used */
> +		info->cur_chn = chan->channel;
> +
> +		if (info->data->start_conv)
> +			info->data->start_conv(info);
> +
> +		if (!wait_for_completion_timeout(&info->completion,
> +							HIBVT_LSADC_TIMEOUT)) {
> +			if (info->data->stop_conv)
> +				info->data->stop_conv(info);
> +			mutex_unlock(&indio_dev->mlock);
> +			return -ETIMEDOUT;
> +		}
> +
> +		*val = info->value;
> +		mutex_unlock(&indio_dev->mlock);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = g_hibvt_lsadc_voltage[chan->channel];
> +		*val2 = info->data->num_bits;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static irqreturn_t hibvt_lsadc_isr(int irq, void *dev_id)
> +{
> +	struct hibvt_lsadc *info = (struct hibvt_lsadc *)dev_id;
> +	int mask;
> +
> +	mask = readl(info->regs + HIBVT_LSADC_INTSTATUS);
> +	if ((mask & HIBVT_LSADC_CHN_MASK_v1) == 0)
> +		return IRQ_NONE;
> +
> +	/* Clear irq */
> +	mask &= HIBVT_LSADC_CHN_MASK_v1;
> +	if (info->data->clear_irq)
> +		info->data->clear_irq(info, mask);
> +
> +	/* Read value */
> +	info->value = readl(info->regs +
> +		HIBVT_LSADC_CHNDATA + (info->cur_chn << 2));
> +	info->value &= GENMASK(info->data->num_bits - 1, 0);
> +
> +	/* stop adc */
> +	if (info->data->stop_conv)
> +		info->data->stop_conv(info);
> +
> +	complete(&info->completion);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct iio_info hibvt_lsadc_iio_info = {
> +	.read_raw = hibvt_lsadc_read_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +#define HIBVT_LSADC_CHANNEL(_index, _id) {      \
> +	.type = IIO_VOLTAGE,                \
> +	.indexed = 1,						\
> +	.channel = _index,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |  \
> +			BIT(IIO_CHAN_INFO_SCALE),   \
> +	.datasheet_name = _id,              \
> +}
> +
> +static const struct iio_chan_spec hibvt_lsadc_iio_channels[] = {
> +	HIBVT_LSADC_CHANNEL(0, "adc0"),
> +	HIBVT_LSADC_CHANNEL(1, "adc1"),
> +	HIBVT_LSADC_CHANNEL(2, "adc2"),
> +};
> +
> +static void hibvt_lsadc_v1_clear_irq(struct hibvt_lsadc *info, int mask)
> +{
> +	writel(mask, info->regs + HIBVT_LSADC_INTCLR);
> +}
> +
> +static void hibvt_lsadc_v1_start_conv(struct hibvt_lsadc *info)
> +{
> +	unsigned int con;
> +
> +	/* set number bit */
set number of bits?
> +	con = GENMASK(info->data->num_bits - 1, 0);
> +	writel(con, (info->regs + HIBVT_LSADC_ACTBIT));
> +
> +	/* config */
> +	con = readl(info->regs + HIBVT_LSADC_CONFIG);
> +	con &= ~HIBVT_CONFIG_RESET;
> +	con |= (HIBVT_CONFIG_POWERDOWN | HIBVT_CONFIG_DEGLITCH |
> +		HIBVT_CONFIG_MODE);
> +	con &= ~(HIBVT_CONFIG_CHNA | HIBVT_CONFIG_CHNB | HIBVT_CONFIG_CHNC);
> +	con |= (HIBVT_CONFIG_CHNA << info->cur_chn);
> +	writel(con, (info->regs + HIBVT_LSADC_CONFIG));
> +
> +	/* set timescan */
> +	writel(HIBVT_LSADC_TSCAN_MS, (info->regs + HIBVT_LSADC_TIMESCAN));
> +
> +	/* clear interrupt */
> +	writel(HIBVT_LSADC_CHN_MASK_v1, info->regs + HIBVT_LSADC_INTCLR);
> +
> +	/* enable interrupt */
> +	writel(HIBVT_LSADC_CON_EN, (info->regs + HIBVT_LSADC_INTEN));
> +
> +	/* start scan */
> +	writel(HIBVT_LSADC_CON_EN, (info->regs + HIBVT_LSADC_START));
> +}
> +
> +static void hibvt_lsadc_v1_stop_conv(struct hibvt_lsadc *info)
> +{
> +	/* reset the timescan */
This isn't a particularly common pice of terminology, perhaps a short
description here of what timescan is and why we should reset it would
make the code easier to follow.

> +	writel(HIBVT_LSADC_CON_DEN, (info->regs + HIBVT_LSADC_TIMESCAN));
> +
> +	/* disable interrupt */
> +	writel(HIBVT_LSADC_CON_DEN, (info->regs + HIBVT_LSADC_INTEN));
> +
> +	/* stop scan */
> +	writel(HIBVT_LSADC_CON_EN, (info->regs + HIBVT_LSADC_STOP));
> +}
> +
> +static const struct hibvt_lsadc_data lsadc_data_v1 = {
> +	.num_bits = HIBVT_LSADC_NUM_BITS_V1,
> +	.channels = hibvt_lsadc_iio_channels,
> +	.num_channels = ARRAY_SIZE(hibvt_lsadc_iio_channels),
> +
> +	.clear_irq = hibvt_lsadc_v1_clear_irq,
> +	.start_conv = hibvt_lsadc_v1_start_conv,
> +	.stop_conv = hibvt_lsadc_v1_stop_conv,
> +};
> +
> +static const struct of_device_id hibvt_lsadc_match[] = {
> +	{
> +		.compatible = "hisilicon,hi3516cv300-lsadc",
> +		.data = &lsadc_data_v1,
The usual convention is to only introduce 'variant' type data as a
precursor patch to a series including the support of new parts.

It is acceptable to post a version with this in if you are shortly to submit
the follow up that adds other device support.  If you are doing this,
please put a note in the patch description to that effect.  Note that if
the additional support doesn't turn up, the driver may we get 'simplified'
by someone else.

I'd also generally expect to see this match table further down - directly
above where it is used.  Makes for ever so slightly easier reviewing!
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, hibvt_lsadc_match);
> +
> +/* Reset LSADC Controller */
> +static void hibvt_lsadc_reset_controller(struct reset_control *reset)
> +{
> +	reset_control_assert(reset);
> +	usleep_range(10, 20);
> +	reset_control_deassert(reset);
> +}
> +
> +static int hibvt_lsadc_probe(struct platform_device *pdev)
> +{
> +	struct hibvt_lsadc *info = NULL;
> +	struct device_node *np = pdev->dev.of_node;
> +	struct iio_dev *indio_dev = NULL;
> +	struct resource	*mem;
> +	const struct of_device_id *match;
> +	int ret;
> +	int irq;
> +
> +	if (!np)
> +		return -ENODEV;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
> +	if (!indio_dev) {
> +		dev_err(&pdev->dev, "failed allocating iio device\n");
> +		return -ENOMEM;
> +	}
> +	info = iio_priv(indio_dev);
> +
> +	match = of_match_device(hibvt_lsadc_match, &pdev->dev);
> +	info->data = match->data;
> +
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	info->regs = devm_ioremap_resource(&pdev->dev, mem);
> +	if (IS_ERR(info->regs))
> +		return PTR_ERR(info->regs);
> +
> +	/*
> +	 * The reset should be an optional property, as it should work
> +	 * with old devicetrees as well
> +	 */
> +	info->reset = devm_reset_control_get(&pdev->dev, "lsadc-crg");
> +	if (IS_ERR(info->reset)) {
> +		ret = PTR_ERR(info->reset);
> +		if (ret != -ENOENT)
> +			return ret;
> +
> +		dev_dbg(&pdev->dev, "no reset control found\n");
> +		info->reset = NULL;
> +	}
> +
> +	init_completion(&info->completion);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "no irq resource?\n");
> +		return irq;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, irq, hibvt_lsadc_isr,
> +			       0, dev_name(&pdev->dev), info);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed requesting irq %d\n", irq);
> +		return ret;
> +	}
> +
> +	if (info->reset)
> +		hibvt_lsadc_reset_controller(info->reset);
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	indio_dev->name = dev_name(&pdev->dev);
> +	indio_dev->dev.parent = &pdev->dev;
> +	indio_dev->dev.of_node = pdev->dev.of_node;
> +	indio_dev->info = &hibvt_lsadc_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	indio_dev->channels = info->data->channels;
> +	indio_dev->num_channels = info->data->num_channels;
> +
> +	ret = devm_iio_device_register(&pdev->dev, indio_dev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed register iio device\n");
> +		return ret;
Drop this return ret and just return ret instead of the return 0 below.
> +	}
> +
> +	return 0;
> +}
> +
> +static struct platform_driver hibvt_lsadc_driver = {
> +	.probe		= hibvt_lsadc_probe,
> +	.driver		= {
> +		.name	= "hibvt-lsadc",
> +		.of_match_table = hibvt_lsadc_match,
> +	},
> +};
> +
> +module_platform_driver(hibvt_lsadc_driver);
> +
> +MODULE_AUTHOR("Allen Liu <liurenzhong@hisilicon.com>");
> +MODULE_DESCRIPTION("hisilicon BVT LSADC driver");
> +MODULE_LICENSE("GPL v2");
> 

