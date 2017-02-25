Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47102 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751629AbdBYSU6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Feb 2017 13:20:58 -0500
Subject: Re: [PATCH v3] adc: add adc driver for Hisilicon BVT SOCs
To: Allen Liu <liurenzhong@hisilicon.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>
References: <1487676119-107752-1-git-send-email-liurenzhong@hisilicon.com>
From: Jonathan Cameron <jic23@kernel.org>
Cc: akinobu.mita@gmail.com, ludovic.desroches@atmel.com,
        krzk@kernel.org, vilhelm.gray@gmail.com,
        ksenija.stanojevic@gmail.com, zhiyong.tao@mediatek.com,
        ray.jui@broadcom.com, raveendra.padasalagi@broadcom.com,
        mranostay@gmail.com, amsfield22@gmail.com,
        xuejiancheng@hisilicon.com, kevin.lixu@hisilicon.com,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Message-ID: <43b5ccac-0833-d89c-c7ab-453208b25f45@kernel.org>
Date: Sat, 25 Feb 2017 18:20:52 +0000
MIME-Version: 1.0
In-Reply-To: <1487676119-107752-1-git-send-email-liurenzhong@hisilicon.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/02/17 11:21, Allen Liu wrote:
> This patch adds new driver to support:
> 1. Support ADC IF found on Hi3516CV300 and future SoCs from Hisilicon BVT
Ah, as this expected on future generations, it is fine to have the
indirection in the driver.

> 2. Add ADC driver under iio/adc framework
> 3. Also adds the documentation for device tree bindings
> 
> Relative to v2, this patch do same correction:
> 1.Drop the data_v1 structure.
> 2.Add some necessary instruction, such as timescan, etc.
> 
> Reviewed-by: Kevin Li <kevin.lixu@hisilicon.com>
> Signed-off-by: Allen Liu <liurenzhong@hisilicon.com>
Hi Allen,

You've managed to cc a lot of relevant people, but drop the mailing list.
If nothing else that meant I nearly missed this entirely as I tend to be
more on top of stuff via the list than my own email :)

Anyhow, added linux-iio back in.

Even though the devicetree binding is simple, I think it has enough
complexity that I need to give the devicetree maintainers time to
review it.
You have addressed all of Rob's comments though so it should just be
a case of him having time to take one last look.

A few minor stylistic comments inline that I missed on previous reviews.
Sorry about that!

Please clean those up and post a v4. It won't matter if Rob gets back
on this version in the meantime as the device tree bindings will be
unaffected.

Jonathan
> ---
>  .../devicetree/bindings/iio/adc/hibvt-lsadc.txt    |  24 ++
>  drivers/iio/adc/Kconfig                            |  10 +
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/hibvt_lsadc.c                      | 344 +++++++++++++++++++++
>  4 files changed, 379 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/hibvt-lsadc.txt
>  create mode 100644 drivers/iio/adc/hibvt_lsadc.c
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/hibvt-lsadc.txt b/Documentation/devicetree/bindings/iio/adc/hibvt-lsadc.txt
> new file mode 100644
> index 0000000..5c7f859
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/hibvt-lsadc.txt
> @@ -0,0 +1,24 @@
> +Hisilicon BVT Low Speed (LS) A/D Converter bindings
> +
> +Required properties:
> +- compatible: should be "hisilicon,<name>-lsadc"
> +   - "hisilicon,hi3516cv300-lsadc": for hi3516cv300
> +
> +- reg: physical base address of the controller and length of memory mapped
> +	   region.
> +- interrupts: The interrupt number for the ADC device.
> +			  see .../interrupt-controller/interrupts.txt for details.
> +
> +Optional properties:
> +- resets: Must contain an entry for each entry in reset-names if need support
> +		  this option. See .../reset/reset.txt for details.
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
> index 0000000..abf9724
> --- /dev/null
> +++ b/drivers/iio/adc/hibvt_lsadc.c
> @@ -0,0 +1,344 @@
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
> +/* Default sample precision is 10 bit */
> +#define HIBVT_LSADC_NUM_BITS	10
> +
> +#define HIBVT_LSADC_CHN_MASK	0x7
> +
> +/*
> + * The time scan is the time interval when hisilicon bvt adc work
> + * in continuous scanning mode, see hi35xx soc doc for more detail.
> + * fix clk:3000000, default tscan set 10ms
> + */
> +#define HIBVT_LSADC_TSCAN_MS	(10*3000)
> +
> +#define HIBVT_LSADC_TIMEOUT		msecs_to_jiffies(100)
> +
> +/*
> + * An internal regulator for the voltage scale is 3.3v or 1.8v.
> + * default voltage scale for every channel <mv>
> + */
> +static int g_hibvt_lsadc_voltage[] = {
> +	3300, 3300, 3300
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
> +		/* select the channel to be used */
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
> +	if ((mask & HIBVT_LSADC_CHN_MASK) == 0)
> +		return IRQ_NONE;
> +
> +	/* clear irq */
> +	mask &= HIBVT_LSADC_CHN_MASK;
> +	if (info->data->clear_irq)
> +		info->data->clear_irq(info, mask);
> +
> +	/* read value */
> +	info->value = readl(info->regs +
> +		HIBVT_LSADC_CHNDATA + (info->cur_chn << 2));
> +	info->value &= GENMASK(info->data->num_bits - 1, 0);
> +
> +	/* A single cycle of continuous mode capture is used for polled
Please keep to the standard kernel multiline comment syntax. That is:
/*
 * A single cycle...
 */

See https://www.kernel.org/doc/html/latest/process/coding-style.html#commenting
for more info.

> +	 * operation. This stops continuous mode after the cycle is complete.
> +	 */
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
> +static void hibvt_lsadc_clear_irq(struct hibvt_lsadc *info, int mask)
> +{
> +	writel(mask, info->regs + HIBVT_LSADC_INTCLR);
> +}
> +
> +static void hibvt_lsadc_start_conv(struct hibvt_lsadc *info)
> +{
> +	unsigned int con;
> +
> +	/* set sample precision */
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
Please drop the unecessary brackets from all of these calls
writel(HIBVT_LSADC_TSCAN_MS, info->regs + HIBVT_LSADC_TIMESCAN);
They don't add an clarity and will get picked up on by the various
static analysers leading to follow up patches. 

> +
> +	/* clear interrupt */
> +	writel(HIBVT_LSADC_CHN_MASK, info->regs + HIBVT_LSADC_INTCLR);
> +
> +	/* enable interrupt */
> +	writel(HIBVT_LSADC_CON_EN, (info->regs + HIBVT_LSADC_INTEN));
> +
> +	/* start scan */
> +	writel(HIBVT_LSADC_CON_EN, (info->regs + HIBVT_LSADC_START));
> +}
> +
> +static void hibvt_lsadc_stop_conv(struct hibvt_lsadc *info)
> +{
> +	/* restore timescan*/
> +	writel(HIBVT_LSADC_CON_DEN, (info->regs + HIBVT_LSADC_TIMESCAN));
> +
> +	/* disable interrupt */
> +	writel(HIBVT_LSADC_CON_DEN, (info->regs + HIBVT_LSADC_INTEN));
> +
> +	/* stop scan */
> +	writel(HIBVT_LSADC_CON_EN, (info->regs + HIBVT_LSADC_STOP));
> +}
> +
> +static const struct hibvt_lsadc_data hibvt_lsadc_data = {
> +	.num_bits = HIBVT_LSADC_NUM_BITS,
> +	.channels = hibvt_lsadc_iio_channels,
> +	.num_channels = ARRAY_SIZE(hibvt_lsadc_iio_channels),
> +
> +	.clear_irq = hibvt_lsadc_clear_irq,
> +	.start_conv = hibvt_lsadc_start_conv,
> +	.stop_conv = hibvt_lsadc_stop_conv,
> +};
> +
> +static const struct of_device_id hibvt_lsadc_match[] = {
> +	{
> +		.compatible = "hisilicon,hi3516cv300-lsadc",
> +		.data = &hibvt_lsadc_data,
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, hibvt_lsadc_match);
> +
> +/* reset LSADC controller */
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
> +	if (ret < 0)
> +		dev_err(&pdev->dev, "failed register iio device\n");
> +
> +	return ret;
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

