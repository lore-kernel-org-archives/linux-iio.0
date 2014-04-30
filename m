Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:19769 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758597AbaD3J2u (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 30 Apr 2014 05:28:50 -0400
From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	dianders@chromium.org, gregkh@linuxfoundation.org,
	naveenkrishna.ch@gmail.com, lars@metafoo.de, cpgs@samsung.com,
	grundler@chromium.org, t.figa@samsung.com,
	Naveen Krishna Ch <ch.naveen@samsung.com>
Subject: [PATCH 2/5 v3] iio: exynos_adc: rearrange clk and regulator
 enable/disable calls
Date: Wed, 30 Apr 2014 14:56:52 +0530
Message-id: <1398850015-17761-3-git-send-email-ch.naveen@samsung.com>
In-reply-to: <1398850015-17761-1-git-send-email-ch.naveen@samsung.com>
References: <1398850015-17761-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Naveen Krishna Ch <ch.naveen@samsung.com>

This patch maintains the following order in
probe(), remove(), resume() and suspend() calls

regulator enable, clk prepare enable
...
clk disable unprepare, regulator disable

While at it,
1. enable the regulator before the iio_device_register()
2. handle the return values for enable/disable calls

Signed-off-by: Naveen Krishna Ch <ch.naveen@samsung.com>
Reviewed-by: Doug Anderson <dianders@chromium.org>
---
Changes since v2:
Remove extra unused line and add Doug's Reviewed-by
Changes since v1:
corrected the register/unregister and enabling/disbaling sequences

 drivers/iio/adc/exynos_adc.c |   62 ++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index affa93f..ff98c5d 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -290,32 +290,30 @@ static int exynos_adc_probe(struct platform_device *pdev)
 
 	init_completion(&info->completion);
 
-	ret = request_irq(info->irq, exynos_adc_isr,
-					0, dev_name(&pdev->dev), info);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed requesting irq, irq = %d\n",
-							info->irq);
-		return ret;
-	}
-
-	writel(1, info->enable_reg);
-
 	info->clk = devm_clk_get(&pdev->dev, "adc");
 	if (IS_ERR(info->clk)) {
 		dev_err(&pdev->dev, "failed getting clock, err = %ld\n",
 							PTR_ERR(info->clk));
-		ret = PTR_ERR(info->clk);
-		goto err_irq;
+		return PTR_ERR(info->clk);
 	}
 
 	info->vdd = devm_regulator_get(&pdev->dev, "vdd");
 	if (IS_ERR(info->vdd)) {
 		dev_err(&pdev->dev, "failed getting regulator, err = %ld\n",
 							PTR_ERR(info->vdd));
-		ret = PTR_ERR(info->vdd);
-		goto err_irq;
+		return PTR_ERR(info->vdd);
 	}
 
+	ret = regulator_enable(info->vdd);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(info->clk);
+	if (ret)
+		goto err_disable_reg;
+
+	writel(1, info->enable_reg);
+
 	info->version = exynos_adc_get_version(pdev);
 
 	platform_set_drvdata(pdev, indio_dev);
@@ -332,16 +330,18 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	else
 		indio_dev->num_channels = MAX_ADC_V2_CHANNELS;
 
+	ret = request_irq(info->irq, exynos_adc_isr,
+					0, dev_name(&pdev->dev), info);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed requesting irq, irq = %d\n",
+							info->irq);
+		goto err_disable_clk;
+	}
+
 	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto err_irq;
 
-	ret = regulator_enable(info->vdd);
-	if (ret)
-		goto err_iio_dev;
-
-	clk_prepare_enable(info->clk);
-
 	exynos_adc_hw_init(info);
 
 	ret = of_platform_populate(np, exynos_adc_match, NULL, &indio_dev->dev);
@@ -355,12 +355,14 @@ static int exynos_adc_probe(struct platform_device *pdev)
 err_of_populate:
 	device_for_each_child(&indio_dev->dev, NULL,
 				exynos_adc_remove_devices);
-	regulator_disable(info->vdd);
-	clk_disable_unprepare(info->clk);
-err_iio_dev:
 	iio_device_unregister(indio_dev);
 err_irq:
 	free_irq(info->irq, info);
+err_disable_clk:
+	writel(0, info->enable_reg);
+	clk_disable_unprepare(info->clk);
+err_disable_reg:
+	regulator_disable(info->vdd);
 	return ret;
 }
 
@@ -371,11 +373,11 @@ static int exynos_adc_remove(struct platform_device *pdev)
 
 	device_for_each_child(&indio_dev->dev, NULL,
 				exynos_adc_remove_devices);
-	regulator_disable(info->vdd);
-	clk_disable_unprepare(info->clk);
-	writel(0, info->enable_reg);
 	iio_device_unregister(indio_dev);
 	free_irq(info->irq, info);
+	writel(0, info->enable_reg);
+	clk_disable_unprepare(info->clk);
+	regulator_disable(info->vdd);
 
 	return 0;
 }
@@ -397,8 +399,8 @@ static int exynos_adc_suspend(struct device *dev)
 		writel(con, ADC_V1_CON(info->regs));
 	}
 
-	clk_disable_unprepare(info->clk);
 	writel(0, info->enable_reg);
+	clk_disable_unprepare(info->clk);
 	regulator_disable(info->vdd);
 
 	return 0;
@@ -414,9 +416,11 @@ static int exynos_adc_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	writel(1, info->enable_reg);
-	clk_prepare_enable(info->clk);
+	ret = clk_prepare_enable(info->clk);
+	if (ret)
+		return ret;
 
+	writel(1, info->enable_reg);
 	exynos_adc_hw_init(info);
 
 	return 0;
-- 
1.7.9.5

