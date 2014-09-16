Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:32615 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752706AbaIPJDj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Sep 2014 05:03:39 -0400
From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
To: linux-iio@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, cw00.choi@samsung.com,
	gregkh@linuxfoundation.org, naveenkrishna.ch@gmail.com,
	lars@metafoo.de, cpgs@samsung.com, grundler@chromium.org,
	jic23@kernel.org
Subject: [PATCH v2 1/3] iio: exyno-adc: use syscon for PMU register access
Date: Tue, 16 Sep 2014 14:28:49 +0530
Message-id: <1410857931-4980-2-git-send-email-ch.naveen@samsung.com>
In-reply-to: <1410857931-4980-1-git-send-email-ch.naveen@samsung.com>
References: <1410857931-4980-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch updates the IIO based ADC driver to use syscon and regmap
APIs to access and use PMU registers instead of remapping the PMU
registers in the driver.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
To: linux-iio@vger.kernel.org
---
Changes since v1:
Rebased on top of togreg branch of IIO git

 drivers/iio/adc/exynos_adc.c |   30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 43620fd..fe03177 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -39,6 +39,8 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/machine.h>
 #include <linux/iio/driver.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
 /* S3C/EXYNOS4412/5250 ADC_V1 registers definitions */
 #define ADC_V1_CON(x)		((x) + 0x00)
@@ -90,11 +92,14 @@
 
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
@@ -110,6 +115,7 @@ struct exynos_adc_data {
 	int num_channels;
 	bool needs_sclk;
 	bool needs_adc_phy;
+	int phy_offset;
 	u32 mask;
 
 	void (*init_hw)(struct exynos_adc *info);
@@ -183,7 +189,7 @@ static void exynos_adc_v1_init_hw(struct exynos_adc *info)
 	u32 con1;
 
 	if (info->data->needs_adc_phy)
-		writel(1, info->enable_reg);
+		regmap_write(info->pmu_map, info->data->phy_offset, 1);
 
 	/* set default prescaler values and Enable prescaler */
 	con1 =  ADC_V1_CON_PRSCLV(49) | ADC_V1_CON_PRSCEN;
@@ -198,7 +204,7 @@ static void exynos_adc_v1_exit_hw(struct exynos_adc *info)
 	u32 con;
 
 	if (info->data->needs_adc_phy)
-		writel(0, info->enable_reg);
+		regmap_write(info->pmu_map, info->data->phy_offset, 0);
 
 	con = readl(ADC_V1_CON(info->regs));
 	con |= ADC_V1_CON_STANDBY;
@@ -225,6 +231,7 @@ static const struct exynos_adc_data exynos_adc_v1_data = {
 	.num_channels	= MAX_ADC_V1_CHANNELS,
 	.mask		= ADC_DATX_MASK,	/* 12 bit ADC resolution */
 	.needs_adc_phy	= true,
+	.phy_offset	= EXYNOS_ADCV1_PHY_OFFSET,
 
 	.init_hw	= exynos_adc_v1_init_hw,
 	.exit_hw	= exynos_adc_v1_exit_hw,
@@ -314,7 +321,7 @@ static void exynos_adc_v2_init_hw(struct exynos_adc *info)
 	u32 con1, con2;
 
 	if (info->data->needs_adc_phy)
-		writel(1, info->enable_reg);
+		regmap_write(info->pmu_map, info->data->phy_offset, 1);
 
 	con1 = ADC_V2_CON1_SOFT_RESET;
 	writel(con1, ADC_V2_CON1(info->regs));
@@ -332,7 +339,7 @@ static void exynos_adc_v2_exit_hw(struct exynos_adc *info)
 	u32 con;
 
 	if (info->data->needs_adc_phy)
-		writel(0, info->enable_reg);
+		regmap_write(info->pmu_map, info->data->phy_offset, 0);
 
 	con = readl(ADC_V2_CON1(info->regs));
 	con &= ~ADC_CON_EN_START;
@@ -362,6 +369,7 @@ static const struct exynos_adc_data exynos_adc_v2_data = {
 	.num_channels	= MAX_ADC_V2_CHANNELS,
 	.mask		= ADC_DATX_MASK, /* 12 bit ADC resolution */
 	.needs_adc_phy	= true,
+	.phy_offset	= EXYNOS_ADCV2_PHY_OFFSET,
 
 	.init_hw	= exynos_adc_v2_init_hw,
 	.exit_hw	= exynos_adc_v2_exit_hw,
@@ -374,6 +382,7 @@ static const struct exynos_adc_data exynos3250_adc_data = {
 	.mask		= ADC_DATX_MASK, /* 12 bit ADC resolution */
 	.needs_sclk	= true,
 	.needs_adc_phy	= true,
+	.phy_offset	= EXYNOS_ADCV1_PHY_OFFSET,
 
 	.init_hw	= exynos_adc_v2_init_hw,
 	.exit_hw	= exynos_adc_v2_exit_hw,
@@ -558,10 +567,13 @@ static int exynos_adc_probe(struct platform_device *pdev)
 
 
 	if (info->data->needs_adc_phy) {
-		mem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-		info->enable_reg = devm_ioremap_resource(&pdev->dev, mem);
-		if (IS_ERR(info->enable_reg))
-			return PTR_ERR(info->enable_reg);
+		info->pmu_map = syscon_regmap_lookup_by_phandle(
+					pdev->dev.of_node,
+					"samsung,syscon-phandle");
+		if (IS_ERR(info->pmu_map)) {
+			dev_err(&pdev->dev, "syscon regmap lookup failed.\n");
+			return PTR_ERR(info->pmu_map);
+		}
 	}
 
 	irq = platform_get_irq(pdev, 0);
-- 
1.7.9.5

