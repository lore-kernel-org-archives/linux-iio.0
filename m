Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:28627 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932192AbaFRCVM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 17 Jun 2014 22:21:12 -0400
From: Chanwoo Choi <cw00.choi@samsung.com>
To: jic23@kernel.org, ch.naveen@samsung.com, t.figa@samsung.com,
	kgene.kim@samsung.com
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	rdunlap@infradead.org, sachin.kamat@linaro.org,
	linux-iio@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCHv4 2/4] iio: adc: exynos_adc: Control special clock of ADC to
 support Exynos3250 ADC
Date: Wed, 18 Jun 2014 11:20:59 +0900
Message-id: <1403058061-24271-3-git-send-email-cw00.choi@samsung.com>
In-reply-to: <1403058061-24271-1-git-send-email-cw00.choi@samsung.com>
References: <1403058061-24271-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch control special clock for ADC in Exynos series's FSYS block.
If special clock of ADC is registerd on clock list of common clk framework,
Exynos ADC drvier have to control this clock.

Exynos3250/Exynos4/Exynos5 has 'adc' clock as following:
- 'adc' clock: bus clock for ADC

Exynos3250 has additional 'sclk_adc' clock as following:
- 'sclk_adc' clock: special clock for ADC which provide clock to internal ADC

Exynos 4210/4212/4412 and Exynos5250/5420 has not included 'sclk_adc' clock
in FSYS_BLK. But, Exynos3250 based on Cortex-A7 has only included 'sclk_adc'
clock in FSYS_BLK.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/iio/adc/exynos_adc.c | 93 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 81 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index c30def6..6b026ac 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -41,7 +41,8 @@
 
 enum adc_version {
 	ADC_V1,
-	ADC_V2
+	ADC_V2,
+	ADC_V2_EXYNOS3250,
 };
 
 /* EXYNOS4412/5250 ADC_V1 registers definitions */
@@ -85,9 +86,11 @@ enum adc_version {
 #define EXYNOS_ADC_TIMEOUT	(msecs_to_jiffies(100))
 
 struct exynos_adc {
+	struct device		*dev;
 	void __iomem		*regs;
 	void __iomem		*enable_reg;
 	struct clk		*clk;
+	struct clk		*sclk;
 	unsigned int		irq;
 	struct regulator	*vdd;
 	struct exynos_adc_ops	*ops;
@@ -96,6 +99,7 @@ struct exynos_adc {
 
 	u32			value;
 	unsigned int            version;
+	bool			needs_sclk;
 };
 
 struct exynos_adc_ops {
@@ -103,11 +107,21 @@ struct exynos_adc_ops {
 	void (*clear_irq)(struct exynos_adc *info);
 	void (*start_conv)(struct exynos_adc *info, unsigned long addr);
 	void (*stop_conv)(struct exynos_adc *info);
+	void (*disable_clk)(struct exynos_adc *info);
+	int (*enable_clk)(struct exynos_adc *info);
 };
 
 static const struct of_device_id exynos_adc_match[] = {
-	{ .compatible = "samsung,exynos-adc-v1", .data = (void *)ADC_V1 },
-	{ .compatible = "samsung,exynos-adc-v2", .data = (void *)ADC_V2 },
+	{
+		.compatible = "samsung,exynos-adc-v1",
+		.data = (void *)ADC_V1,
+	}, {
+		.compatible = "samsung,exynos-adc-v2",
+		.data = (void *)ADC_V2,
+	}, {
+		.compatible = "samsung,exynos3250-adc-v2",
+		.data = (void *)ADC_V2_EXYNOS3250,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, exynos_adc_match);
@@ -156,11 +170,42 @@ static void exynos_adc_v1_stop_conv(struct exynos_adc *info)
 	writel(con, ADC_V1_CON(info->regs));
 }
 
+static void exynos_adc_disable_clk(struct exynos_adc *info)
+{
+	if (info->needs_sclk)
+		clk_disable_unprepare(info->sclk);
+	clk_disable_unprepare(info->clk);
+}
+
+static int exynos_adc_enable_clk(struct exynos_adc *info)
+{
+	int ret;
+
+	ret = clk_prepare_enable(info->clk);
+	if (ret) {
+		dev_err(info->dev, "failed enabling adc clock: %d\n", ret);
+		return ret;
+	}
+
+	if (info->needs_sclk) {
+		ret = clk_prepare_enable(info->sclk);
+		if (ret) {
+			clk_disable_unprepare(info->clk);
+			dev_err(info->dev,
+				"failed enabling sclk_tsadc clock: %d\n", ret);
+		}
+	}
+
+	return 0;
+}
+
 static struct exynos_adc_ops exynos_adc_v1_ops = {
 	.init_hw	= exynos_adc_v1_init_hw,
 	.clear_irq	= exynos_adc_v1_clear_irq,
 	.start_conv	= exynos_adc_v1_start_conv,
 	.stop_conv	= exynos_adc_v1_stop_conv,
+	.disable_clk	= exynos_adc_disable_clk,
+	.enable_clk	= exynos_adc_enable_clk,
 };
 
 static void exynos_adc_v2_init_hw(struct exynos_adc *info)
@@ -210,6 +255,8 @@ static struct exynos_adc_ops exynos_adc_v2_ops = {
 	.start_conv	= exynos_adc_v2_start_conv,
 	.clear_irq	= exynos_adc_v2_clear_irq,
 	.stop_conv	= exynos_adc_v2_stop_conv,
+	.disable_clk	= exynos_adc_disable_clk,
+	.enable_clk	= exynos_adc_enable_clk,
 };
 
 static int exynos_read_raw(struct iio_dev *indio_dev,
@@ -345,6 +392,10 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	case ADC_V2:
 		info->ops = &exynos_adc_v2_ops;
 		break;
+	case ADC_V2_EXYNOS3250:
+		info->ops = &exynos_adc_v2_ops;
+		info->needs_sclk = true;
+		break;
 	default:
 		dev_err(&pdev->dev, "failed to identify ADC version\n");
 		return -EINVAL;
@@ -367,6 +418,7 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	}
 
 	info->irq = irq;
+	info->dev = &pdev->dev;
 
 	init_completion(&info->completion);
 
@@ -377,6 +429,16 @@ static int exynos_adc_probe(struct platform_device *pdev)
 		return PTR_ERR(info->clk);
 	}
 
+	if (info->needs_sclk) {
+		info->sclk = devm_clk_get(&pdev->dev, "sclk_adc");
+		if (IS_ERR(info->sclk)) {
+			dev_err(&pdev->dev,
+				"failed getting sclk_tsadc, err = %ld\n",
+				PTR_ERR(info->sclk));
+			return PTR_ERR(info->sclk);
+		}
+	}
+
 	info->vdd = devm_regulator_get(&pdev->dev, "vdd");
 	if (IS_ERR(info->vdd)) {
 		dev_err(&pdev->dev, "failed getting regulator, err = %ld\n",
@@ -388,9 +450,11 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = clk_prepare_enable(info->clk);
-	if (ret)
-		goto err_disable_reg;
+	if (info->ops->enable_clk) {
+		ret = info->ops->enable_clk(info);
+		if (ret)
+			goto err_disable_reg;
+	}
 
 	writel(1, info->enable_reg);
 
@@ -439,7 +503,8 @@ err_irq:
 	free_irq(info->irq, info);
 err_disable_clk:
 	writel(0, info->enable_reg);
-	clk_disable_unprepare(info->clk);
+	if (info->ops->disable_clk)
+		info->ops->disable_clk(info);
 err_disable_reg:
 	regulator_disable(info->vdd);
 	return ret;
@@ -455,7 +520,8 @@ static int exynos_adc_remove(struct platform_device *pdev)
 	iio_device_unregister(indio_dev);
 	free_irq(info->irq, info);
 	writel(0, info->enable_reg);
-	clk_disable_unprepare(info->clk);
+	if (info->ops->disable_clk)
+		info->ops->disable_clk(info);
 	regulator_disable(info->vdd);
 
 	return 0;
@@ -471,7 +537,8 @@ static int exynos_adc_suspend(struct device *dev)
 		info->ops->stop_conv(info);
 
 	writel(0, info->enable_reg);
-	clk_disable_unprepare(info->clk);
+	if (info->ops->disable_clk)
+		info->ops->disable_clk(info);
 	regulator_disable(info->vdd);
 
 	return 0;
@@ -487,9 +554,11 @@ static int exynos_adc_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	ret = clk_prepare_enable(info->clk);
-	if (ret)
-		return ret;
+	if (info->ops->enable_clk) {
+		ret = info->ops->enable_clk(info);
+		if (ret)
+			return ret;
+	}
 
 	writel(1, info->enable_reg);
 
-- 
1.8.0

