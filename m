Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50014 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750857AbcLXLqW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Dec 2016 06:46:22 -0500
In-Reply-To: <1482544497-136656-1-git-send-email-liurenzhong@hisilicon.com>
References: <1482544497-136656-1-git-send-email-liurenzhong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] adc: add adc driver for Hisilicon BVT SOCs
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Sat, 24 Dec 2016 11:46:13 +0000
To: Allen Liu <liurenzhong@hisilicon.com>, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com
CC: akinobu.mita@gmail.com, ludovic.desroches@atmel.com,
        krzk@kernel.org, vilhelm.gray@gmail.com,
        ksenija.stanojevic@gmail.com, zhiyong.tao@mediatek.com,
        daniel.baluta@intel.com, leonard.crestez@intel.com,
        ray.jui@broadcom.com, raveendra.padasalagi@broadcom.com,
        mranostay@gmail.com, amsfield22@gmail.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuejiancheng@hisilicon.com,
        kevin.lixu@hisilicon.com
Message-ID: <951BC246-0676-4DBF-856B-832E0F977ACB@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 24 December 2016 01:54:57 GMT+00:00, Allen Liu <liurenzhong@hisilicon.com> wrote:
>Add ADC driver for the ADC controller found on HiSilicon BVT SOCs, like
>Hi3516CV300, etc.
>The ADC controller is primarily in charge of detecting voltage.
>
>Reviewed-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
>Signed-off-by: Allen Liu <liurenzhong@hisilicon.com>
Reading on phone so may not be that thorough!

Looks pretty good. The device abstraction makes it slightly more complicated than it needs
to be.  If you aren't going to follow up quickly with other device support please drop the
 abstraction. It can be easily readded when needed. 

Various little things inline.

Thanks

Jonathan
>---
> .../devicetree/bindings/iio/adc/hibvt-lsadc.txt    |  26 ++
> drivers/iio/adc/Kconfig                            |  10 +
> drivers/iio/adc/Makefile                           |   1 +
>drivers/iio/adc/hibvt_lsadc.c                      | 344
>+++++++++++++++++++++
> 4 files changed, 381 insertions(+)
>create mode 100644
>Documentation/devicetree/bindings/iio/adc/hibvt-lsadc.txt
> create mode 100644 drivers/iio/adc/hibvt_lsadc.c
>
>diff --git a/Documentation/devicetree/bindings/iio/adc/hibvt-lsadc.txt
>b/Documentation/devicetree/bindings/iio/adc/hibvt-lsadc.txt
>new file mode 100644
>index 0000000..63de46e
>--- /dev/null
>+++ b/Documentation/devicetree/bindings/iio/adc/hibvt-lsadc.txt
>@@ -0,0 +1,26 @@
>+Hisilicon BVT Low Speed (LS) A/D Converter bindings
>+
>+Required properties:
>+- compatible: should be "hisilicon,<name>-lsadc"
>+   - "hisilicon,hibvt-lsadc": for hi3516cv300
>+
>+- reg: physical base address of the controller and length of memory
>mapped
>+       region.
>+- interrupts: The interrupt number to the cpu. The interrupt specifier
>format
>+              depends on the interrupt controller.
A cross reference to the interrupt bindings doc always good to add.
>+- #io-channel-cells: Should be 1, see ../iio-bindings.txt
>+
>+Optional properties:
>+- resets: Must contain an entry for each entry in reset-names if need
>support
>+	  this option. See ../reset/reset.txt for details.
>+- reset-names: Must include the name "saradc-apb".
>+
>+Example:
>+	lsadc: hibvt-lsadc@120e0000 {
>+			compatible = "hisilicon,hibvt-lsadc";
>+			reg = <0x120e0000 0x1000>;
>+			interrupts = <19>;
>+			resets = <&crg 0x7c 3>;
>+			reset-names = "lsadc-crg";
Doesn't contain saradc-apb which docs say it must...
>+			status = "disabled";
Not documented...
>+	};
>diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>index 99c0514..0443f51 100644
>--- a/drivers/iio/adc/Kconfig
>+++ b/drivers/iio/adc/Kconfig
>@@ -225,6 +225,16 @@ config HI8435
>	  This driver can also be built as a module. If so, the module will be
> 	  called hi8435.
> 
>+config HIBVT_LSADC
>+	tristate "HIBVT LSADC driver"
>+	depends on ARCH_HISI || COMPILE_TEST
>+	help
>+	  Say yes here to build support for the LSADC found in SoCs from
>+	  hisilicon BVT chip.
>+
>+	  To compile this driver as a module, choose M here: the
>+	  module will be called hibvt_lsadc.
>+
> config INA2XX_ADC
> 	tristate "Texas Instruments INA2xx Power Monitors IIO driver"
> 	depends on I2C && !SENSORS_INA2XX
>diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>index 7a40c04..6554d92 100644
>--- a/drivers/iio/adc/Makefile
>+++ b/drivers/iio/adc/Makefile
>@@ -23,6 +23,7 @@ obj-$(CONFIG_DA9150_GPADC) += da9150-gpadc.o
> obj-$(CONFIG_EXYNOS_ADC) += exynos_adc.o
> obj-$(CONFIG_FSL_MX25_ADC) += fsl-imx25-gcq.o
> obj-$(CONFIG_HI8435) += hi8435.o
>+obj-$(CONFIG_HIBVT_LSADC) += hibvt_lsadc.o
> obj-$(CONFIG_IMX7D_ADC) += imx7d_adc.o
> obj-$(CONFIG_INA2XX_ADC) += ina2xx-adc.o
> obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
>diff --git a/drivers/iio/adc/hibvt_lsadc.c
>b/drivers/iio/adc/hibvt_lsadc.c
>new file mode 100644
>index 0000000..a20afe8
>--- /dev/null
>+++ b/drivers/iio/adc/hibvt_lsadc.c
>@@ -0,0 +1,344 @@
>+/*
>+ * Hisilicon BVT Low Speed (LS) A/D Converter
>+ * Copyright (C) 2016 HiSilicon Technologies Co., Ltd.
>+ *
>+ * This program is free software; you can redistribute it and/or
>modify
>+ * it under the terms of the GNU General Public License as published
>by
>+ * the Free Software Foundation; either version 2 of the License, or
>+ * (at your option) any later version.
>+ *
>+ * This program is distributed in the hope that it will be useful,
>+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>+ * GNU General Public License for more details.
>+ */
>+
>+#include <linux/module.h>
>+#include <linux/platform_device.h>
>+#include <linux/interrupt.h>
>+#include <linux/io.h>
>+#include <linux/of.h>
>+#include <linux/of_device.h>
>+#include <linux/clk.h>
>+#include <linux/completion.h>
>+#include <linux/delay.h>
>+#include <linux/reset.h>
>+#include <linux/regulator/consumer.h>
>+#include <linux/iio/iio.h>
>+
>+/* hisilicon bvt adc registers definitions */
>+#define LSADC_CONFIG		0x00
>+#define CONFIG_DEGLITCH		BIT(17)
Please add a driver specific prefix to all defines to keep them in their own namespace.
>+#define CONFIG_RESET		BIT(15)
>+#define CONFIG_POWERDOWN	BIT(14)
>+#define CONFIG_MODE			BIT(13)
>+#define CONFIG_CHC_VALID	BIT(10)
>+#define CONFIG_CHB_VALID	BIT(9)
>+#define CONFIG_CHA_VALID	BIT(8)
>+
>+#define LSADC_TIMESCAN		0x08
Lsadc is perhaps to generic a prefix. Clash chances are a bit high
>+#define LSADC_INTEN			0x10
>+#define LSADC_INTSTATUS		0x14
>+#define LSADC_INTCLR		0x18
>+#define LSADC_START			0x1C
>+#define LSADC_STOP			0x20
>+#define LSADC_ACTBIT		0x24
>+#define LSADC_CHNDATA		0x2C
>+
>+#define ADC_CON_EN			(1u << 0)
>+#define ADC_CON_DEN			(0u << 0)
>+
>+#define ADC_NUM_BITS		10
>+
>+/* fix clk:3000000, default tscan set 10ms */
>+#define DEF_ADC_TSCAN_MS	(10*3000)
>+
>+#define LSADC_CHN_MASK		0x7
>+
>+#define LSADC_TIMEOUT		msecs_to_jiffies(100)
>+
>+/* default voltage scale for every channel <mv> */
>+static int g_voltage[] = {
>+	3300, 3300, 3300
>+};
Prefix these as well.
>+
>+struct hibvt_lsadc {
>+	void __iomem		*regs;
>+	struct completion	completion;
>+	struct reset_control	*reset;
>+	const struct hibvt_lsadc_data	*data;
>+	unsigned int		cur_chn;
>+	unsigned int		value;
>+};
>+
>+struct hibvt_lsadc_data {
>+	int				num_bits;
>+	const struct iio_chan_spec	*channels;
>+	int				num_channels;
>+
>+	void (*clear_irq)(struct hibvt_lsadc *info, int mask);
>+	void (*start_conv)(struct hibvt_lsadc *info);
>+	void (*stop_conv)(struct hibvt_lsadc *info);
>+};
>+
>+static int hibvt_lsadc_read_raw(struct iio_dev *indio_dev,
>+				    struct iio_chan_spec const *chan,
>+				    int *val, int *val2, long mask)
>+{
>+	struct hibvt_lsadc *info = iio_priv(indio_dev);
>+
>+	switch (mask) {
>+	case IIO_CHAN_INFO_RAW:
>+		mutex_lock(&indio_dev->mlock);
>+
>+		reinit_completion(&info->completion);
>+
>+		/* Select the channel to be used */
>+		info->cur_chn = chan->channel;
>+
>+		if (info->data->start_conv)
>+			info->data->start_conv(info);
>+
>+		if (!wait_for_completion_timeout(&info->completion,
>+							LSADC_TIMEOUT)) {
>+			if (info->data->stop_conv)
>+				info->data->stop_conv(info);
>+			mutex_unlock(&indio_dev->mlock);
>+			return -ETIMEDOUT;
>+		}
>+
>+		*val = info->value;
>+		mutex_unlock(&indio_dev->mlock);
>+		return IIO_VAL_INT;
>+	case IIO_CHAN_INFO_SCALE:
>+		*val = g_voltage[chan->channel];
>+		*val2 = info->data->num_bits;
>+		return IIO_VAL_FRACTIONAL_LOG2;
>+	default:
>+		return -EINVAL;
>+	}
>+}
>+
>+static irqreturn_t hibvt_lsadc_isr(int irq, void *dev_id)
>+{
>+	struct hibvt_lsadc *info = (struct hibvt_lsadc *)dev_id;
>+	int mask;
>+
>+	mask = readl(info->regs + LSADC_INTSTATUS);
>+	mask &= LSADC_CHN_MASK;
>+
>+	/* Clear irq */
>+	if (info->data->clear_irq)
>+		info->data->clear_irq(info, mask);
>+
>+	/* Read value */
>+	info->value = readl(info->regs + LSADC_CHNDATA + (info->cur_chn <<
>2));
>+	info->value &= GENMASK(info->data->num_bits - 1, 0);
>+
>+	/* stop adc */
>+	if (info->data->stop_conv)
>+		info->data->stop_conv(info);
>+
>+	complete(&info->completion);
>+
>+	return IRQ_HANDLED;
>+}
>+
>+static const struct iio_info hibvt_lsadc_iio_info = {
>+	.read_raw = hibvt_lsadc_read_raw,
>+	.driver_module = THIS_MODULE,
>+};
>+
>+#define ADC_CHANNEL(_index, _id) {      \
Prefix this define. 
>+	.type = IIO_VOLTAGE,                \
>+	.indexed = 1,						\
>+	.channel = _index,					\
>+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |  \
>+			BIT(IIO_CHAN_INFO_SCALE),   \
>+	.datasheet_name = _id,              \
>+}
>+
>+static const struct iio_chan_spec hibvt_lsadc_iio_channels[] = {
>+	ADC_CHANNEL(0, "adc0"),
>+	ADC_CHANNEL(1, "adc1"),
>+	ADC_CHANNEL(2, "adc2"),
>+};
>+
>+static void hibvt_lsadc_clear_irq(struct hibvt_lsadc *info, int mask)
>+{
>+	writel(mask, info->regs + LSADC_INTCLR);
>+}
>+
>+static void hibvt_lsadc_start_conv(struct hibvt_lsadc *info)
>+{
>+	unsigned int con;
>+
>+	/* set number bit */
>+	con = GENMASK(info->data->num_bits - 1, 0);
>+	writel(con, (info->regs + LSADC_ACTBIT));
>+
>+    /* config */
>+	con = readl(info->regs + LSADC_CONFIG);
>+	con &= ~CONFIG_RESET;
>+	con |= (CONFIG_POWERDOWN | CONFIG_DEGLITCH | CONFIG_MODE);
>+	con &= ~(CONFIG_CHA_VALID | CONFIG_CHB_VALID | CONFIG_CHC_VALID);
>+	con |= (CONFIG_CHA_VALID << info->cur_chn);
>+	writel(con, (info->regs + LSADC_CONFIG));
>+
>+	/* set timescan */
>+	writel(DEF_ADC_TSCAN_MS, (info->regs + LSADC_TIMESCAN));
>+
>+	/* clear interrupt */
>+	writel(LSADC_CHN_MASK, info->regs + LSADC_INTCLR);
>+
>+	/* enable interrupt */
>+	writel(ADC_CON_EN, (info->regs + LSADC_INTEN));
>+
>+	/* start scan */
>+	writel(ADC_CON_EN, (info->regs + LSADC_START));
>+}
>+
>+static void hibvt_lsadc_stop_conv(struct hibvt_lsadc *info)
>+{
>+	/* reset the timescan */
>+	writel(ADC_CON_DEN, (info->regs + LSADC_TIMESCAN));
>+
>+	/* disable interrupt */
>+	writel(ADC_CON_DEN, (info->regs + LSADC_INTEN));
>+
>+	/* stop scan */
>+	writel(ADC_CON_EN, (info->regs + LSADC_STOP));
>+}
>+
>+static const struct hibvt_lsadc_data lsadc_data = {
>+	.num_bits = ADC_NUM_BITS,
>+	.channels = hibvt_lsadc_iio_channels,
>+	.num_channels = ARRAY_SIZE(hibvt_lsadc_iio_channels),
>+
>+	.clear_irq	= hibvt_lsadc_clear_irq,
>+	.start_conv	= hibvt_lsadc_start_conv,
>+	.stop_conv = hibvt_lsadc_stop_conv,
>+};
Usual convention is to only introduce a device type specific structure when more than one device is supported.  If you are going to follow up
 shortly with more device support then leave it but add a note to the patch description. If not please drop this abstraction.
>+
>+static const struct of_device_id hibvt_lsadc_match[] = {
>+	{
>+		.compatible = "hisilicon,hibvt-lsadc",
>+		.data = &lsadc_data,
>+	},
>+	{},
>+};
>+MODULE_DEVICE_TABLE(of, hibvt_lsadc_match);
>+
>+/**
>+ * Reset LSADC Controller.
Single line comment syntax please.
>+ */
>+static void hibvt_lsadc_reset_controller(struct reset_control *reset)
>+{
>+	reset_control_assert(reset);
>+	usleep_range(10, 20);
>+	reset_control_deassert(reset);
>+}
>+
>+static int hibvt_lsadc_probe(struct platform_device *pdev)
>+{
>+	struct hibvt_lsadc *info = NULL;
>+	struct device_node *np = pdev->dev.of_node;
>+	struct iio_dev *indio_dev = NULL;
>+	struct resource	*mem;
>+	const struct of_device_id *match;
>+	int ret;
>+	int irq;
>+
>+	if (!np)
>+		return -ENODEV;
>+
>+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
>+	if (!indio_dev) {
>+		dev_err(&pdev->dev, "failed allocating iio device\n");
>+		return -ENOMEM;
>+	}
>+	info = iio_priv(indio_dev);
>+
>+	match = of_match_device(hibvt_lsadc_match, &pdev->dev);
>+	info->data = match->data;
>+
>+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>+	info->regs = devm_ioremap_resource(&pdev->dev, mem);
>+	if (IS_ERR(info->regs))
>+		return PTR_ERR(info->regs);
>+
>+	/*
>+	 * The reset should be an optional property, as it should work
>+	 * with old devicetrees as well
>+	 */
>+	info->reset = devm_reset_control_get(&pdev->dev, "lsadc-crg");
>+	if (IS_ERR(info->reset)) {
>+		ret = PTR_ERR(info->reset);
>+		if (ret != -ENOENT)
>+			return ret;
>+
>+		dev_dbg(&pdev->dev, "no reset control found\n");
>+		info->reset = NULL;
>+	}
>+
>+	init_completion(&info->completion);
>+
>+	irq = platform_get_irq(pdev, 0);
>+	if (irq < 0) {
>+		dev_err(&pdev->dev, "no irq resource?\n");
>+		return irq;
>+	}
>+
>+	ret = devm_request_irq(&pdev->dev, irq, hibvt_lsadc_isr,
>+			       0, dev_name(&pdev->dev), info);
>+	if (ret < 0) {
>+		dev_err(&pdev->dev, "failed requesting irq %d\n", irq);
>+		return ret;
>+	}
>+
>+	if (info->reset)
>+		hibvt_lsadc_reset_controller(info->reset);
>+
>+	platform_set_drvdata(pdev, indio_dev);
>+
>+	indio_dev->name = dev_name(&pdev->dev);
>+	indio_dev->dev.parent = &pdev->dev;
>+	indio_dev->dev.of_node = pdev->dev.of_node;
>+	indio_dev->info = &hibvt_lsadc_iio_info;
>+	indio_dev->modes = INDIO_DIRECT_MODE;
>+
>+	indio_dev->channels = info->data->channels;
>+	indio_dev->num_channels = info->data->num_channels;
>+
>+	ret = iio_device_register(indio_dev);
>+	if (ret < 0) {
>+		dev_err(&pdev->dev, "failed register iio device\n");
>+		return ret;
>+	}
>+
>+	return 0;
>+}
>+
>+static int hibvt_lsadc_remove(struct platform_device *pdev)
>+{
>+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>+
>+	iio_device_unregister(indio_dev);
As nothing else here can use devm version of register and drop remove entirely.
>+
>+	return 0;
>+}
>+
>+static struct platform_driver hibvt_lsadc_driver = {
>+	.probe		= hibvt_lsadc_probe,
>+	.remove		= hibvt_lsadc_remove,
>+	.driver		= {
>+		.name	= "hibvt-lsadc",
>+		.of_match_table = hibvt_lsadc_match,
>+	},
>+};
>+
>+module_platform_driver(hibvt_lsadc_driver);
>+
>+MODULE_AUTHOR("Allen Liu <liurenzhong@hisilicon.com>");
>+MODULE_DESCRIPTION("hisilicon BVT LSADC driver");
>+MODULE_LICENSE("GPL v2");

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
