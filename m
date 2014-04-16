Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:9716 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755340AbaDPKL6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Apr 2014 06:11:58 -0400
From: Chanwoo Choi <cw00.choi@samsung.com>
To: jic23@kernel.org, ch.naveen@samsung.com, kgene.kim@samsung.com
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	rdunlap@infradead.org, t.figa@samsung.com, sachin.kamat@linaro.org,
	linux-iio@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCHv3 1/2] iio: adc: exynos_adc: Control special clock of ADC to
 support Exynos3250 ADC
Date: Wed, 16 Apr 2014 19:11:57 +0900
Message-id: <1397643118-6934-2-git-send-email-cw00.choi@samsung.com>
In-reply-to: <1397643118-6934-1-git-send-email-cw00.choi@samsung.com>
References: <1397643118-6934-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch control special clock for ADC in Exynos series's FSYS block.
If special clock of ADC is registerd on clock list of common clk framework,
Exynos ADC drvier have to control this clock.

Exynos3250/Exynos4/Exynos5 has 'adc' clock as following:
- 'adc' clock: bus clock for ADC

Exynos3250 has additional 'sclk_tsadc' clock as following:
- 'sclk_tsadc' clock: special clock for ADC which provide clock to internal ADC

Exynos 4210/4212/4412 and Exynos5250/5420 has not included 'sclk_tsadc' clock
in FSYS_BLK. But, Exynos3250 based on Cortex-A7 has only included 'sclk_tsadc'
clock in FSYS_BLK.

Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Naveen Krishna Chatradhi
Cc: linux-iio@vger.kernel.org
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/iio/adc/exynos_adc.c | 86 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 73 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index d25b262..486771e 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -40,8 +40,9 @@
 #include <linux/iio/driver.h>
 
 enum adc_version {
-	ADC_V1,
-	ADC_V2
+	ADC_V1 = 0x1,
+	ADC_V2 = 0x2,
+	ADC_V3 = (ADC_V1 | ADC_V2),
 };
 
 /* EXYNOS4412/5250 ADC_V1 registers definitions */
@@ -85,9 +86,11 @@ enum adc_version {
 #define EXYNOS_ADC_TIMEOUT	(msecs_to_jiffies(1000))
 
 struct exynos_adc {
+	struct device		*dev;
 	void __iomem		*regs;
 	void __iomem		*enable_reg;
 	struct clk		*clk;
+	struct clk		*sclk;
 	unsigned int		irq;
 	struct regulator	*vdd;
 
@@ -100,6 +103,7 @@ struct exynos_adc {
 static const struct of_device_id exynos_adc_match[] = {
 	{ .compatible = "samsung,exynos-adc-v1", .data = (void *)ADC_V1 },
 	{ .compatible = "samsung,exynos-adc-v2", .data = (void *)ADC_V2 },
+	{ .compatible = "samsung,exynos-adc-v3", .data = (void *)ADC_V3 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, exynos_adc_match);
@@ -128,7 +132,7 @@ static int exynos_read_raw(struct iio_dev *indio_dev,
 	mutex_lock(&indio_dev->mlock);
 
 	/* Select the channel to be used and Trigger conversion */
-	if (info->version == ADC_V2) {
+	if (info->version >= ADC_V2) {
 		con2 = readl(ADC_V2_CON2(info->regs));
 		con2 &= ~ADC_V2_CON2_ACH_MASK;
 		con2 |= ADC_V2_CON2_ACH_SEL(chan->address);
@@ -165,7 +169,7 @@ static irqreturn_t exynos_adc_isr(int irq, void *dev_id)
 	info->value = readl(ADC_V1_DATX(info->regs)) &
 						ADC_DATX_MASK;
 	/* clear irq */
-	if (info->version == ADC_V2)
+	if (info->version >= ADC_V2)
 		writel(1, ADC_V2_INT_ST(info->regs));
 	else
 		writel(1, ADC_V1_INTCLR(info->regs));
@@ -226,11 +230,43 @@ static int exynos_adc_remove_devices(struct device *dev, void *c)
 	return 0;
 }
 
+static int exynos_adc_enable_clock(struct exynos_adc *info, bool enable)
+{
+	int ret;
+
+	if (enable) {
+		ret = clk_prepare_enable(info->clk);
+		if (ret) {
+			dev_err(info->dev, "failed to enable adc clock\n");
+			return ret;
+		}
+		if (info->version == ADC_V3) {
+			ret = clk_prepare_enable(info->sclk);
+			if (ret) {
+				dev_err(info->dev,
+					"failed to enable sclk_tsadc clock\n");
+				goto err;
+			}
+		}
+
+	} else {
+		if (info->version == ADC_V3)
+			clk_disable_unprepare(info->sclk);
+		clk_disable_unprepare(info->clk);
+	}
+
+	return 0;
+err:
+	clk_disable_unprepare(info->clk);
+
+	return ret;
+}
+
 static void exynos_adc_hw_init(struct exynos_adc *info)
 {
 	u32 con1, con2;
 
-	if (info->version == ADC_V2) {
+	if (info->version >= ADC_V2) {
 		con1 = ADC_V2_CON1_SOFT_RESET;
 		writel(con1, ADC_V2_CON1(info->regs));
 
@@ -287,6 +323,7 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	}
 
 	info->irq = irq;
+	info->dev = &pdev->dev;
 
 	init_completion(&info->completion);
 
@@ -300,6 +337,8 @@ static int exynos_adc_probe(struct platform_device *pdev)
 
 	writel(1, info->enable_reg);
 
+	info->version = exynos_adc_get_version(pdev);
+
 	info->clk = devm_clk_get(&pdev->dev, "adc");
 	if (IS_ERR(info->clk)) {
 		dev_err(&pdev->dev, "failed getting clock, err = %ld\n",
@@ -308,6 +347,16 @@ static int exynos_adc_probe(struct platform_device *pdev)
 		goto err_irq;
 	}
 
+	if (info->version == ADC_V3) {
+		info->sclk = devm_clk_get(&pdev->dev, "sclk_tsadc");
+		if (IS_ERR(info->sclk)) {
+			ret = PTR_ERR(info->sclk);
+			dev_warn(&pdev->dev,
+				"failed getting sclk clock, err = %d\n", ret);
+			goto err_irq;
+		}
+	}
+
 	info->vdd = devm_regulator_get(&pdev->dev, "vdd");
 	if (IS_ERR(info->vdd)) {
 		dev_err(&pdev->dev, "failed getting regulator, err = %ld\n",
@@ -316,8 +365,6 @@ static int exynos_adc_probe(struct platform_device *pdev)
 		goto err_irq;
 	}
 
-	info->version = exynos_adc_get_version(pdev);
-
 	platform_set_drvdata(pdev, indio_dev);
 
 	indio_dev->name = dev_name(&pdev->dev);
@@ -340,7 +387,11 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_iio_dev;
 
-	clk_prepare_enable(info->clk);
+	ret = exynos_adc_enable_clock(info, true);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable clock\n");
+		goto err_regulator;
+	}
 
 	exynos_adc_hw_init(info);
 
@@ -355,8 +406,9 @@ static int exynos_adc_probe(struct platform_device *pdev)
 err_of_populate:
 	device_for_each_child(&pdev->dev, NULL,
 				exynos_adc_remove_devices);
+	exynos_adc_enable_clock(info, false);
+err_regulator:
 	regulator_disable(info->vdd);
-	clk_disable_unprepare(info->clk);
 err_iio_dev:
 	iio_device_unregister(indio_dev);
 err_irq:
@@ -372,7 +424,7 @@ static int exynos_adc_remove(struct platform_device *pdev)
 	device_for_each_child(&pdev->dev, NULL,
 				exynos_adc_remove_devices);
 	regulator_disable(info->vdd);
-	clk_disable_unprepare(info->clk);
+	exynos_adc_enable_clock(info, false);
 	writel(0, info->enable_reg);
 	iio_device_unregister(indio_dev);
 	free_irq(info->irq, info);
@@ -387,7 +439,7 @@ static int exynos_adc_suspend(struct device *dev)
 	struct exynos_adc *info = iio_priv(indio_dev);
 	u32 con;
 
-	if (info->version == ADC_V2) {
+	if (info->version >= ADC_V2) {
 		con = readl(ADC_V2_CON1(info->regs));
 		con &= ~ADC_CON_EN_START;
 		writel(con, ADC_V2_CON1(info->regs));
@@ -397,7 +449,7 @@ static int exynos_adc_suspend(struct device *dev)
 		writel(con, ADC_V1_CON(info->regs));
 	}
 
-	clk_disable_unprepare(info->clk);
+	exynos_adc_enable_clock(info, false);
 	writel(0, info->enable_reg);
 	regulator_disable(info->vdd);
 
@@ -415,11 +467,19 @@ static int exynos_adc_resume(struct device *dev)
 		return ret;
 
 	writel(1, info->enable_reg);
-	clk_prepare_enable(info->clk);
+	ret = exynos_adc_enable_clock(info, true);
+	if (ret) {
+		dev_err(dev, "failed to enable clock\n");
+		goto err;
+	}
 
 	exynos_adc_hw_init(info);
 
 	return 0;
+err:
+	regulator_disable(info->vdd);
+
+	return ret;
 }
 #endif
 
-- 
1.8.0

