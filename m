Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:41546 "EHLO
	mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755185AbcG0KD1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Jul 2016 06:03:27 -0400
From: Zhiyong Tao <zhiyong.tao@mediatek.com>
To: <robh+dt@kernel.org>, <jic23@kernel.org>, <knaack.h@gmx.de>,
	<lars@metafoo.de>, <pmeerw@pmeerw.net>
CC: <srv_heupstream@mediatek.com>, <liguo.zhang@mediatek.com>,
	<yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
	<erin.lo@mediatek.com>, <dawei.chien@mediatek.com>,
	<matthias.bgg@gmail.com>, <s.hauer@pengutronix.de>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-iio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<robh@kernel.org>, Zhiyong Tao <zhiyong.tao@mediatek.com>
Subject: [PATCH v6 2/3] iio: adc: mt2701: Add Mediatek auxadc driver for mt2701.
Date: Wed, 27 Jul 2016 18:03:00 +0800
Message-ID: <1469613781-1296-3-git-send-email-zhiyong.tao@mediatek.com>
In-Reply-To: <1469613781-1296-1-git-send-email-zhiyong.tao@mediatek.com>
References: <1469613781-1296-1-git-send-email-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add Mediatek auxadc driver based on iio.
It will register a device in iio and support iio.
So thermal can read auxadc channel to sample data by iio device.
It is tested successfully on mt2701 platform.
Mt8173 and mt6577 platforms are not tested.
But the expectation is compatible.

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
---
 drivers/iio/adc/Kconfig         |   13 ++
 drivers/iio/adc/Makefile        |    1 +
 drivers/iio/adc/mt6577_auxadc.c |  291 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 305 insertions(+)
 create mode 100644 drivers/iio/adc/mt6577_auxadc.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 25378c5..14929fc 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -305,6 +305,19 @@ config MCP3422
 	  This driver can also be built as a module. If so, the module will be
 	  called mcp3422.
 
+config MEDIATEK_MT6577_AUXADC
+        tristate "MediaTek AUXADC driver"
+        depends on ARCH_MEDIATEK || COMPILE_TEST
+        depends on HAS_IOMEM
+        help
+          Say yes here to enable support for MediaTek mt65xx AUXADC.
+
+          The driver supports immediate mode operation to read from one of sixteen
+          channels (external or internal).
+
+          This driver can also be built as a module. If so, the module will be
+          called mt6577_auxadc.
+
 config MEN_Z188_ADC
 	tristate "MEN 16z188 ADC IP Core support"
 	depends on MCB
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 38638d4..8306347 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_MAX1027) += max1027.o
 obj-$(CONFIG_MAX1363) += max1363.o
 obj-$(CONFIG_MCP320X) += mcp320x.o
 obj-$(CONFIG_MCP3422) += mcp3422.o
+obj-$(CONFIG_MEDIATEK_MT6577_AUXADC) += mt6577_auxadc.o
 obj-$(CONFIG_MEN_Z188_ADC) += men_z188_adc.o
 obj-$(CONFIG_MXS_LRADC) += mxs-lradc.o
 obj-$(CONFIG_NAU7802) += nau7802.o
diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
new file mode 100644
index 0000000..2d104c8
--- /dev/null
+++ b/drivers/iio/adc/mt6577_auxadc.c
@@ -0,0 +1,291 @@
+/*
+ * Copyright (c) 2016 MediaTek Inc.
+ * Author: Zhiyong Tao <zhiyong.tao@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/iopoll.h>
+#include <linux/io.h>
+#include <linux/iio/iio.h>
+
+/* Register definitions */
+#define MT6577_AUXADC_CON0                    0x00
+#define MT6577_AUXADC_CON1                    0x04
+#define MT6577_AUXADC_CON2                    0x10
+#define MT6577_AUXADC_STA                     BIT(0)
+
+#define MT6577_AUXADC_DAT0                    0x14
+#define MT6577_AUXADC_RDY0                    BIT(12)
+
+#define MT6577_AUXADC_MISC                    0x94
+#define MT6577_AUXADC_PDN_EN                  BIT(14)
+
+#define MT6577_AUXADC_DAT_MASK                0xfff
+#define MT6577_AUXADC_SLEEP_US                1000
+#define MT6577_AUXADC_TIMEOUT_US              10000
+#define MT6577_AUXADC_POWER_READY_MS          1
+#define MT6577_AUXADC_SAMPLE_READY_US         25
+
+struct mt6577_auxadc_device {
+	void __iomem *reg_base;
+	struct clk *adc_clk;
+	struct mutex lock;
+};
+
+#define MT6577_AUXADC_CHANNEL(idx) {				    \
+		.type = IIO_VOLTAGE,				    \
+		.indexed = 1,					    \
+		.channel = (idx),				    \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED), \
+}
+
+static const struct iio_chan_spec mt6577_auxadc_iio_channels[] = {
+	MT6577_AUXADC_CHANNEL(0),
+	MT6577_AUXADC_CHANNEL(1),
+	MT6577_AUXADC_CHANNEL(2),
+	MT6577_AUXADC_CHANNEL(3),
+	MT6577_AUXADC_CHANNEL(4),
+	MT6577_AUXADC_CHANNEL(5),
+	MT6577_AUXADC_CHANNEL(6),
+	MT6577_AUXADC_CHANNEL(7),
+	MT6577_AUXADC_CHANNEL(8),
+	MT6577_AUXADC_CHANNEL(9),
+	MT6577_AUXADC_CHANNEL(10),
+	MT6577_AUXADC_CHANNEL(11),
+	MT6577_AUXADC_CHANNEL(12),
+	MT6577_AUXADC_CHANNEL(13),
+	MT6577_AUXADC_CHANNEL(14),
+	MT6577_AUXADC_CHANNEL(15),
+};
+
+static inline void mt6577_auxadc_mod_reg(void __iomem *reg,
+					 u32 or_mask, u32 and_mask)
+{
+	u32 val;
+
+	val = readl(reg);
+	val |= or_mask;
+	val &= ~and_mask;
+	writel(val, reg);
+}
+
+static int mt6577_auxadc_read(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan)
+{
+	u32 val;
+	void __iomem *reg_channel;
+	int ret;
+	struct mt6577_auxadc_device *adc_dev = iio_priv(indio_dev);
+
+	reg_channel = adc_dev->reg_base + MT6577_AUXADC_DAT0 +
+		      chan->channel * 0x04;
+
+	mutex_lock(&adc_dev->lock);
+
+	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_CON1,
+			      0, 1 << chan->channel);
+
+	/* read channel and make sure old ready bit == 0 */
+	ret = readl_poll_timeout(reg_channel, val,
+				 ((val & MT6577_AUXADC_RDY0) == 0),
+				 MT6577_AUXADC_SLEEP_US,
+				 MT6577_AUXADC_TIMEOUT_US);
+	if (ret < 0) {
+		dev_err(indio_dev->dev.parent,
+			"wait for channel[%d] ready bit clear time out\n",
+			chan->channel);
+		goto err_timeout;
+	}
+
+	/* set bit to trigger sample */
+	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_CON1,
+			      1 << chan->channel, 0);
+
+	/* we must delay here for hardware sample channel data */
+	udelay(MT6577_AUXADC_SAMPLE_READY_US);
+
+	/* check MTK_AUXADC_CON2 if auxadc is idle */
+	ret = readl_poll_timeout(adc_dev->reg_base + MT6577_AUXADC_CON2, val,
+				 ((val & MT6577_AUXADC_STA) == 0),
+				 MT6577_AUXADC_SLEEP_US,
+				 MT6577_AUXADC_TIMEOUT_US);
+	if (ret < 0) {
+		dev_err(indio_dev->dev.parent,
+			"wait for auxadc idle time out\n");
+		goto err_timeout;
+	}
+
+	/* read channel and make sure ready bit == 1 */
+	ret = readl_poll_timeout(reg_channel, val,
+				 ((val & MT6577_AUXADC_RDY0) != 0),
+				 MT6577_AUXADC_SLEEP_US,
+				 MT6577_AUXADC_TIMEOUT_US);
+	if (ret < 0) {
+		dev_err(indio_dev->dev.parent,
+			"wait for channel[%d] data ready time out\n",
+			chan->channel);
+		goto err_timeout;
+	}
+
+	/* read data */
+	val = readl(reg_channel) & MT6577_AUXADC_DAT_MASK;
+
+	mutex_unlock(&adc_dev->lock);
+
+	return val;
+
+err_timeout:
+
+	mutex_unlock(&adc_dev->lock);
+
+	return -ETIMEDOUT;
+}
+
+static int mt6577_auxadc_read_raw(struct iio_dev *indio_dev,
+				  struct iio_chan_spec const *chan,
+				  int *val,
+				  int *val2,
+				  long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_PROCESSED:
+		*val = mt6577_auxadc_read(indio_dev, chan);
+		if (*val < 0) {
+			dev_err(indio_dev->dev.parent,
+				"failed to sample data on channel[%d]\n",
+				chan->channel);
+			return *val;
+		}
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info mt6577_auxadc_info = {
+	.driver_module = THIS_MODULE,
+	.read_raw = &mt6577_auxadc_read_raw,
+};
+
+static int mt6577_auxadc_probe(struct platform_device *pdev)
+{
+	struct mt6577_auxadc_device *adc_dev;
+	unsigned long adc_clk_rate;
+	struct resource *res;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*adc_dev));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	adc_dev = iio_priv(indio_dev);
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->name = dev_name(&pdev->dev);
+	indio_dev->info = &mt6577_auxadc_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = mt6577_auxadc_iio_channels;
+	indio_dev->num_channels = ARRAY_SIZE(mt6577_auxadc_iio_channels);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	adc_dev->reg_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(adc_dev->reg_base)) {
+		dev_err(&pdev->dev, "failed to get auxadc base address\n");
+		return PTR_ERR(adc_dev->reg_base);
+	}
+
+	adc_dev->adc_clk = devm_clk_get(&pdev->dev, "main");
+	if (IS_ERR(adc_dev->adc_clk)) {
+		dev_err(&pdev->dev, "failed to get auxadc clock\n");
+		return PTR_ERR(adc_dev->adc_clk);
+	}
+
+	ret = clk_prepare_enable(adc_dev->adc_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable auxadc clock\n");
+		return ret;
+	}
+
+	adc_clk_rate = clk_get_rate(adc_dev->adc_clk);
+	if (!adc_clk_rate) {
+		ret = -EINVAL;
+		dev_err(&pdev->dev, "null clock rate\n");
+		goto err_disable_clk;
+	}
+
+	mutex_init(&adc_dev->lock);
+
+	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_MISC,
+			      MT6577_AUXADC_PDN_EN, 0);
+	mdelay(MT6577_AUXADC_POWER_READY_MS);
+
+	platform_set_drvdata(pdev, indio_dev);
+
+	ret = iio_device_register(indio_dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to register iio device\n");
+		goto err_power_off;
+	}
+
+	return 0;
+
+err_power_off:
+	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_MISC,
+			      0, MT6577_AUXADC_PDN_EN);
+err_disable_clk:
+	clk_disable_unprepare(adc_dev->adc_clk);
+	return ret;
+}
+
+static int mt6577_auxadc_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct mt6577_auxadc_device *adc_dev = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+
+	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_MISC,
+			      0, MT6577_AUXADC_PDN_EN);
+
+	clk_disable_unprepare(adc_dev->adc_clk);
+
+	return 0;
+}
+
+static const struct of_device_id mt6577_auxadc_of_match[] = {
+	{ .compatible = "mediatek,mt2701-auxadc", },
+	{ .compatible = "mediatek,mt8173-auxadc", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mt6577_auxadc_of_match);
+
+static struct platform_driver mt6577_auxadc_driver = {
+	.driver = {
+		.name   = "mt6577-auxadc",
+		.of_match_table = mt6577_auxadc_of_match,
+	},
+	.probe	= mt6577_auxadc_probe,
+	.remove	= mt6577_auxadc_remove,
+};
+module_platform_driver(mt6577_auxadc_driver);
+
+MODULE_AUTHOR("Zhiyong Tao <zhiyong.tao@mediatek.com>");
+MODULE_DESCRIPTION("MTK AUXADC Device Driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5

