Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:63762 "EHLO
	mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757440AbcGKDKI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 10 Jul 2016 23:10:08 -0400
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
	Zhiyong Tao <zhiyong.tao@mediatek.com>
Subject: [PATCH v3 2/2] iio: adc: mt2701: Add Mediatek auxadc driver for mt2701.
Date: Mon, 11 Jul 2016 11:09:56 +0800
Message-ID: <1468206596-13792-3-git-send-email-zhiyong.tao@mediatek.com>
In-Reply-To: <1468206596-13792-1-git-send-email-zhiyong.tao@mediatek.com>
References: <1468206596-13792-1-git-send-email-zhiyong.tao@mediatek.com>
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
 drivers/iio/adc/Kconfig         |   26 +++---
 drivers/iio/adc/Makefile        |    2 +-
 drivers/iio/adc/mt6577_auxadc.c |  186 +++++++++++++++++++--------------------
 3 files changed, 104 insertions(+), 110 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 66e9b44..14929fc 100644
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
@@ -315,19 +328,6 @@ config MEN_Z188_ADC
 	  This driver can also be built as a module. If so, the module will be
 	  called men_z188_adc.
 
-config MEDIATEK_MT65XX_AUXADC
-	tristate "MediaTek AUXADC driver"
-	depends on ARCH_MEDIATEK || COMPILE_TEST
-	depends on HAS_IOMEM
-	help
-	  Say yes here to enable support for MediaTek mt65xx AUXADC.
-
-	  The driver supports immediate mode operation to read from one of sixteen
-	  channels (external or internal).
-
-	  This driver can also be built as a module. If so, the module will be
-	  called mt6577_auxadc.
-
 config MXS_LRADC
         tristate "Freescale i.MX23/i.MX28 LRADC"
         depends on (ARCH_MXS || COMPILE_TEST) && HAS_IOMEM
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 14a630f..8306347 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -30,8 +30,8 @@ obj-$(CONFIG_MAX1027) += max1027.o
 obj-$(CONFIG_MAX1363) += max1363.o
 obj-$(CONFIG_MCP320X) += mcp320x.o
 obj-$(CONFIG_MCP3422) += mcp3422.o
+obj-$(CONFIG_MEDIATEK_MT6577_AUXADC) += mt6577_auxadc.o
 obj-$(CONFIG_MEN_Z188_ADC) += men_z188_adc.o
-obj-$(CONFIG_MEDIATEK_MT65XX_AUXADC) += mt6577_auxadc.o
 obj-$(CONFIG_MXS_LRADC) += mxs-lradc.o
 obj-$(CONFIG_NAU7802) += nau7802.o
 obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
index a56531a..a853ae8 100644
--- a/drivers/iio/adc/mt6577_auxadc.c
+++ b/drivers/iio/adc/mt6577_auxadc.c
@@ -24,80 +24,78 @@
 #include <linux/io.h>
 #include <linux/iio/iio.h>
 
-/* Registers definitions */
-#define MT65XX_AUXADC_CON0                    0x00
-#define MT65XX_AUXADC_CON1                    0x04
-#define MT65XX_AUXADC_CON2                    0x10
-#define MT65XX_AUXADC_STA                     BIT(0)
+/* Register definitions */
+#define MT6577_AUXADC_CON0                    0x00
+#define MT6577_AUXADC_CON1                    0x04
+#define MT6577_AUXADC_CON2                    0x10
+#define MT6577_AUXADC_STA                     BIT(0)
 
-#define MT65XX_AUXADC_DAT0                    0x14
-#define MT65XX_AUXADC_RDY0                    BIT(12)
+#define MT6577_AUXADC_DAT0                    0x14
+#define MT6577_AUXADC_RDY0                    BIT(12)
 
-#define MT65XX_AUXADC_MISC                    0x94
-#define MT65XX_AUXADC_PDN_EN                  BIT(14)
+#define MT6577_AUXADC_MISC                    0x94
+#define MT6577_AUXADC_PDN_EN                  BIT(14)
 
-#define MT65XX_AUXADC_DAT_MASK                0xfff
-#define MT65XX_AUXADC_SLEEP_US                1000
-#define MT65XX_AUXADC_TIMEOUT_US              10000
-#define MT65XX_AUXADC_POWER_READY_MS          1
-#define MT65XX_AUXADC_SAMPLE_READY_US         25
+#define MT6577_AUXADC_DAT_MASK                0xfff
+#define MT6577_AUXADC_SLEEP_US                1000
+#define MT6577_AUXADC_TIMEOUT_US              10000
+#define MT6577_AUXADC_POWER_READY_MS          1
+#define MT6577_AUXADC_SAMPLE_READY_US         25
 
-struct mt65xx_auxadc_device {
+struct mt6577_auxadc_device {
 	void __iomem *reg_base;
 	struct clk *adc_clk;
 	struct mutex lock;
-	unsigned int power_ready_ms;
-	unsigned int sample_ready_us;
 };
 
-#define MT65XX_AUXADC_CHANNEL(idx) {				    \
+#define MT6577_AUXADC_CHANNEL(idx) {				    \
 		.type = IIO_VOLTAGE,				    \
 		.indexed = 1,					    \
 		.channel = (idx),				    \
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED), \
 }
 
-static const struct iio_chan_spec mt65xx_auxadc_iio_channels[] = {
-	MT65XX_AUXADC_CHANNEL(0),
-	MT65XX_AUXADC_CHANNEL(1),
-	MT65XX_AUXADC_CHANNEL(2),
-	MT65XX_AUXADC_CHANNEL(3),
-	MT65XX_AUXADC_CHANNEL(4),
-	MT65XX_AUXADC_CHANNEL(5),
-	MT65XX_AUXADC_CHANNEL(6),
-	MT65XX_AUXADC_CHANNEL(7),
-	MT65XX_AUXADC_CHANNEL(8),
-	MT65XX_AUXADC_CHANNEL(9),
-	MT65XX_AUXADC_CHANNEL(10),
-	MT65XX_AUXADC_CHANNEL(11),
-	MT65XX_AUXADC_CHANNEL(12),
-	MT65XX_AUXADC_CHANNEL(13),
-	MT65XX_AUXADC_CHANNEL(14),
-	MT65XX_AUXADC_CHANNEL(15),
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
 };
 
-static int mt65xx_auxadc_read(struct iio_dev *indio_dev,
+static int mt6577_auxadc_read(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan)
 {
 	u32 rawdata, val;
 	void __iomem *reg_channel;
 	int ret;
-	struct mt65xx_auxadc_device *adc_dev = iio_priv(indio_dev);
+	struct mt6577_auxadc_device *adc_dev = iio_priv(indio_dev);
 
-	reg_channel = adc_dev->reg_base + MT65XX_AUXADC_DAT0 +
+	reg_channel = adc_dev->reg_base + MT6577_AUXADC_DAT0 +
 		      chan->channel * 0x04;
 
 	mutex_lock(&adc_dev->lock);
 
-	val = readl(adc_dev->reg_base + MT65XX_AUXADC_CON1);
+	val = readl(adc_dev->reg_base + MT6577_AUXADC_CON1);
 	val &= ~(1 << chan->channel);
-	writel(val, adc_dev->reg_base + MT65XX_AUXADC_CON1);
+	writel(val, adc_dev->reg_base + MT6577_AUXADC_CON1);
 
 	/* read channel and make sure old ready bit == 0 */
 	ret = readl_poll_timeout(reg_channel, val,
-				 ((val & MT65XX_AUXADC_RDY0) == 0),
-				 MT65XX_AUXADC_SLEEP_US,
-				 MT65XX_AUXADC_TIMEOUT_US);
+				 ((val & MT6577_AUXADC_RDY0) == 0),
+				 MT6577_AUXADC_SLEEP_US,
+				 MT6577_AUXADC_TIMEOUT_US);
 	if (ret < 0) {
 		dev_err(indio_dev->dev.parent,
 			"wait for channel[%d] ready bit clear time out\n",
@@ -105,36 +103,36 @@ static int mt65xx_auxadc_read(struct iio_dev *indio_dev,
 
 		mutex_unlock(&adc_dev->lock);
 
-		return -EINVAL;
+		return -ETIMEDOUT;
 	}
 
 	/* set bit to trigger sample */
-	val = readl(adc_dev->reg_base + MT65XX_AUXADC_CON1);
+	val = readl(adc_dev->reg_base + MT6577_AUXADC_CON1);
 	val |= 1 << chan->channel;
-	writel(val, adc_dev->reg_base + MT65XX_AUXADC_CON1);
+	writel(val, adc_dev->reg_base + MT6577_AUXADC_CON1);
 
 	/* we must delay here for hardware sample channel data */
-	udelay(adc_dev->sample_ready_us);
+	udelay(MT6577_AUXADC_SAMPLE_READY_US);
 
 	/* check MTK_AUXADC_CON2 if auxadc is idle */
-	ret = readl_poll_timeout(adc_dev->reg_base + MT65XX_AUXADC_CON2, val,
-				 ((val & MT65XX_AUXADC_STA) == 0),
-				 MT65XX_AUXADC_SLEEP_US,
-				 MT65XX_AUXADC_TIMEOUT_US);
+	ret = readl_poll_timeout(adc_dev->reg_base + MT6577_AUXADC_CON2, val,
+				 ((val & MT6577_AUXADC_STA) == 0),
+				 MT6577_AUXADC_SLEEP_US,
+				 MT6577_AUXADC_TIMEOUT_US);
 	if (ret < 0) {
 		dev_err(indio_dev->dev.parent,
 			"wait for auxadc idle time out\n");
 
 		mutex_unlock(&adc_dev->lock);
 
-		return -EINVAL;
+		return -ETIMEDOUT;
 	}
 
 	/* read channel and make sure ready bit == 1 */
 	ret = readl_poll_timeout(reg_channel, val,
-				 ((val & MT65XX_AUXADC_RDY0) != 0),
-				 MT65XX_AUXADC_SLEEP_US,
-				 MT65XX_AUXADC_TIMEOUT_US);
+				 ((val & MT6577_AUXADC_RDY0) != 0),
+				 MT6577_AUXADC_SLEEP_US,
+				 MT6577_AUXADC_TIMEOUT_US);
 	if (ret < 0) {
 		dev_err(indio_dev->dev.parent,
 			"wait for channel[%d] data ready time out\n",
@@ -142,52 +140,48 @@ static int mt65xx_auxadc_read(struct iio_dev *indio_dev,
 
 		mutex_unlock(&adc_dev->lock);
 
-		return -EINVAL;
+		return -ETIMEDOUT;
 	}
 
 	/* read data */
-	rawdata = readl(reg_channel) & MT65XX_AUXADC_DAT_MASK;
+	rawdata = readl(reg_channel) & MT6577_AUXADC_DAT_MASK;
 
 	mutex_unlock(&adc_dev->lock);
 
 	return rawdata;
 }
 
-static int mt65xx_auxadc_read_raw(struct iio_dev *indio_dev,
+static int mt6577_auxadc_read_raw(struct iio_dev *indio_dev,
 				  struct iio_chan_spec const *chan,
 				  int *val,
 				  int *val2,
 				  long info)
 {
-	int ret;
-
 	switch (info) {
 	case IIO_CHAN_INFO_PROCESSED:
-		*val = mt65xx_auxadc_read(indio_dev, chan);
+		*val = mt6577_auxadc_read(indio_dev, chan);
 		if (*val < 0) {
 			dev_err(indio_dev->dev.parent,
 				"failed to sample data on channel[%d]\n",
 				chan->channel);
-			return -EIO;
+			return *val;
 		}
-		ret = IIO_VAL_INT;
+		return IIO_VAL_INT;
 		break;
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 		break;
 	}
-
-	return ret;
 }
 
-static const struct iio_info mt65xx_auxadc_info = {
+static const struct iio_info mt6577_auxadc_info = {
 	.driver_module = THIS_MODULE,
-	.read_raw = &mt65xx_auxadc_read_raw,
+	.read_raw = &mt6577_auxadc_read_raw,
 };
 
-static int mt65xx_auxadc_probe(struct platform_device *pdev)
+static int mt6577_auxadc_probe(struct platform_device *pdev)
 {
-	struct mt65xx_auxadc_device *adc_dev;
+	struct mt6577_auxadc_device *adc_dev;
 	unsigned long adc_clk_rate;
 	struct resource *res;
 	struct iio_dev *indio_dev;
@@ -201,10 +195,10 @@ static int mt65xx_auxadc_probe(struct platform_device *pdev)
 	adc_dev = iio_priv(indio_dev);
 	indio_dev->dev.parent = &pdev->dev;
 	indio_dev->name = dev_name(&pdev->dev);
-	indio_dev->info = &mt65xx_auxadc_info;
+	indio_dev->info = &mt6577_auxadc_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = mt65xx_auxadc_iio_channels;
-	indio_dev->num_channels = ARRAY_SIZE(mt65xx_auxadc_iio_channels);
+	indio_dev->channels = mt6577_auxadc_iio_channels;
+	indio_dev->num_channels = ARRAY_SIZE(mt6577_auxadc_iio_channels);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	adc_dev->reg_base = devm_ioremap_resource(&pdev->dev, res);
@@ -231,18 +225,15 @@ static int mt65xx_auxadc_probe(struct platform_device *pdev)
 		goto err_disable_clk;
 	}
 
-	adc_dev->power_ready_ms = MT65XX_AUXADC_POWER_READY_MS;
-	adc_dev->sample_ready_us = MT65XX_AUXADC_SAMPLE_READY_US;
-
 	mutex_init(&adc_dev->lock);
 
-	val = readl(adc_dev->reg_base + MT65XX_AUXADC_MISC);
-	val |= MT65XX_AUXADC_PDN_EN;
-	writel(val, adc_dev->reg_base + MT65XX_AUXADC_MISC);
-	mdelay(adc_dev->power_ready_ms);
+	val = readl(adc_dev->reg_base + MT6577_AUXADC_MISC);
+	val |= MT6577_AUXADC_PDN_EN;
+	writel(val, adc_dev->reg_base + MT6577_AUXADC_MISC);
+	mdelay(MT6577_AUXADC_POWER_READY_MS);
 
-	val = readl(adc_dev->reg_base + MT65XX_AUXADC_MISC);
-	if ((val & MT65XX_AUXADC_PDN_EN) == 0) {
+	val = readl(adc_dev->reg_base + MT6577_AUXADC_MISC);
+	if ((val & MT6577_AUXADC_PDN_EN) == 0) {
 		dev_err(&pdev->dev, "failed to enable auxadc power!\n");
 		goto err_disable_clk;
 	}
@@ -252,7 +243,10 @@ static int mt65xx_auxadc_probe(struct platform_device *pdev)
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to register iio device!\n");
-		return ret;
+		val = readl(adc_dev->reg_base + MT6577_AUXADC_MISC);
+		val &= ~MT6577_AUXADC_PDN_EN;
+		writel(val, adc_dev->reg_base + MT6577_AUXADC_MISC);
+		goto err_disable_clk;
 	}
 
 	return 0;
@@ -262,39 +256,39 @@ err_disable_clk:
 	return -EINVAL;
 }
 
-static int mt65xx_auxadc_remove(struct platform_device *pdev)
+static int mt6577_auxadc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct mt65xx_auxadc_device *adc_dev = iio_priv(indio_dev);
+	struct mt6577_auxadc_device *adc_dev = iio_priv(indio_dev);
 	u32 val;
 
 	iio_device_unregister(indio_dev);
 
-	val = readl(adc_dev->reg_base + MT65XX_AUXADC_MISC);
-	val &= ~MT65XX_AUXADC_PDN_EN;
-	writel(val, adc_dev->reg_base + MT65XX_AUXADC_MISC);
+	val = readl(adc_dev->reg_base + MT6577_AUXADC_MISC);
+	val &= ~MT6577_AUXADC_PDN_EN;
+	writel(val, adc_dev->reg_base + MT6577_AUXADC_MISC);
 
 	clk_disable_unprepare(adc_dev->adc_clk);
 
 	return 0;
 }
 
-static const struct of_device_id mt65xx_auxadc_of_match[] = {
+static const struct of_device_id mt6577_auxadc_of_match[] = {
 	{ .compatible = "mediatek,mt2701-auxadc", },
 	{ .compatible = "mediatek,mt8173-auxadc", },
 	{ }
 };
-MODULE_DEVICE_TABLE(of, mt65xx_auxadc_of_match);
+MODULE_DEVICE_TABLE(of, mt6577_auxadc_of_match);
 
-static struct platform_driver mt65xx_auxadc_driver = {
+static struct platform_driver mt6577_auxadc_driver = {
 	.driver = {
-		.name   = "mt65xx-auxadc",
-		.of_match_table = mt65xx_auxadc_of_match,
+		.name   = "mt6577-auxadc",
+		.of_match_table = mt6577_auxadc_of_match,
 	},
-	.probe	= mt65xx_auxadc_probe,
-	.remove	= mt65xx_auxadc_remove,
+	.probe	= mt6577_auxadc_probe,
+	.remove	= mt6577_auxadc_remove,
 };
-module_platform_driver(mt65xx_auxadc_driver);
+module_platform_driver(mt6577_auxadc_driver);
 
 MODULE_AUTHOR("Zhiyong Tao <zhiyong.tao@mediatek.com>");
 MODULE_DESCRIPTION("MTK AUXADC Device Driver");
-- 
1.7.9.5

