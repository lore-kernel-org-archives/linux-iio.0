Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:52094 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142AbaGKJKm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 Jul 2014 05:10:42 -0400
From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
To: linux-iio@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, cw00.choi@samsung.com,
	gregkh@linuxfoundation.org, naveenkrishna.ch@gmail.com,
	lars@metafoo.de, cpgs@samsung.com, grundler@chromium.org
Subject: [PATCH 1/4] iio: exyno-adc: use syscon for PMU register access
Date: Fri, 11 Jul 2014 14:36:26 +0530
Message-id: <1405069589-10388-2-git-send-email-ch.naveen@samsung.com>
In-reply-to: <1405069589-10388-1-git-send-email-ch.naveen@samsung.com>
References: <1405069589-10388-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch updates the IIO based ADC driver to use syscon and regmap
APIs to access and use PMU registers instead of remapping the PMU
registers in the driver.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
To: linux-iio@vger.kernel.org
---
 drivers/iio/adc/exynos_adc.c |   29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index b63e882..60847ef 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -38,6 +38,8 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/machine.h>
 #include <linux/iio/driver.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
 /* EXYNOS4412/5250 ADC_V1 registers definitions */
 #define ADC_V1_CON(x)		((x) + 0x00)
@@ -79,11 +81,14 @@
 
 #define EXYNOS_ADC_TIMEOUT	(msecs_to_jiffies(100))
 
+#define EXYNOS_ADCV1_PHY_OFFSET	0x0718
+#define EXYNOS_ADCV2_PHY_OFFSET	0x0720
+
 struct exynos_adc {
 	struct exynos_adc_data	*data;
 	struct device		*dev;
 	void __iomem		*regs;
-	void __iomem		*enable_reg;
+	struct regmap		*pmu_map;
 	struct clk		*clk;
 	struct clk		*sclk;
 	unsigned int		irq;
@@ -98,6 +103,7 @@ struct exynos_adc {
 struct exynos_adc_data {
 	int num_channels;
 	bool needs_sclk;
+	int phy_offset;
 
 	void (*init_hw)(struct exynos_adc *info);
 	void (*exit_hw)(struct exynos_adc *info);
@@ -169,7 +175,7 @@ static void exynos_adc_v1_init_hw(struct exynos_adc *info)
 {
 	u32 con1;
 
-	writel(1, info->enable_reg);
+	regmap_write(info->pmu_map, info->data->phy_offset, 1);
 
 	/* set default prescaler values and Enable prescaler */
 	con1 =  ADC_V1_CON_PRSCLV(49) | ADC_V1_CON_PRSCEN;
@@ -183,7 +189,7 @@ static void exynos_adc_v1_exit_hw(struct exynos_adc *info)
 {
 	u32 con;
 
-	writel(0, info->enable_reg);
+	regmap_write(info->pmu_map, info->data->phy_offset, 0);
 
 	con = readl(ADC_V1_CON(info->regs));
 	con |= ADC_V1_CON_STANDBY;
@@ -208,6 +214,7 @@ static void exynos_adc_v1_start_conv(struct exynos_adc *info,
 
 static struct exynos_adc_data const exynos_adc_v1_data = {
 	.num_channels	= MAX_ADC_V1_CHANNELS,
+	.phy_offset	= EXYNOS_ADCV1_PHY_OFFSET,
 
 	.init_hw	= exynos_adc_v1_init_hw,
 	.exit_hw	= exynos_adc_v1_exit_hw,
@@ -219,7 +226,7 @@ static void exynos_adc_v2_init_hw(struct exynos_adc *info)
 {
 	u32 con1, con2;
 
-	writel(1, info->enable_reg);
+	regmap_write(info->pmu_map, info->data->phy_offset, 1);
 
 	con1 = ADC_V2_CON1_SOFT_RESET;
 	writel(con1, ADC_V2_CON1(info->regs));
@@ -236,7 +243,7 @@ static void exynos_adc_v2_exit_hw(struct exynos_adc *info)
 {
 	u32 con;
 
-	writel(0, info->enable_reg);
+	regmap_write(info->pmu_map, info->data->phy_offset, 0);
 
 	con = readl(ADC_V2_CON1(info->regs));
 	con &= ~ADC_CON_EN_START;
@@ -271,10 +278,12 @@ static void exynos_adc_v2_start_conv(struct exynos_adc *info,
 
 static struct exynos_adc_data const exynos_adc_v2_data = {
 	__EXYNOS_ADC_V2_DATA
+	.phy_offset = EXYNOS_ADCV2_PHY_OFFSET,
 };
 
 static struct exynos_adc_data const exynos3250_adc_v2_data = {
 	__EXYNOS_ADC_V2_DATA
+	.phy_offset = EXYNOS_ADCV1_PHY_OFFSET,
 	.needs_sclk = true,
 };
 
@@ -437,10 +446,12 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	if (IS_ERR(info->regs))
 		return PTR_ERR(info->regs);
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	info->enable_reg = devm_ioremap_resource(&pdev->dev, mem);
-	if (IS_ERR(info->enable_reg))
-		return PTR_ERR(info->enable_reg);
+	info->pmu_map = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+					"samsung,syscon-phandle");
+	if (IS_ERR(info->pmu_map)) {
+		dev_err(&pdev->dev, "syscon regmap lookup failed.\n");
+		return PTR_ERR(info->pmu_map);
+	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-- 
1.7.9.5

