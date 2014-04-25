Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:62989 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752873AbaDYKQj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 25 Apr 2014 06:16:39 -0400
From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	dianders@chromium.org, gregkh@linuxfoundation.org,
	naveenkrishna.ch@gmail.com, lars@metafoo.de, cpgs@samsung.com,
	grundler@chromium.org, Naveen Krishna Ch <ch.naveen@samsung.com>
Subject: [PATCH 2/5] iio: exynos_adc: rearrange clock and regulator
 enable/disable calls
Date: Fri, 25 Apr 2014 15:44:44 +0530
Message-id: <1398420888-5506-3-git-send-email-ch.naveen@samsung.com>
In-reply-to: <1398420888-5506-1-git-send-email-ch.naveen@samsung.com>
References: <1398420888-5506-1-git-send-email-ch.naveen@samsung.com>
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

Change-Id: I764d9d60f72caa7ea6b0609db49a74115574f081
Signed-off-by: Naveen Krishna Ch <ch.naveen@samsung.com>
---
This change fixes the comments given by Jonathan regarding the
order of clock and regulator enable/disable calls.
https://lkml.org/lkml/2014/4/23/644

 drivers/iio/adc/exynos_adc.c |   34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index affa93f..a2b8b1a 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -316,6 +316,14 @@ static int exynos_adc_probe(struct platform_device *pdev)
 		goto err_irq;
 	}
 
+	ret = regulator_enable(info->vdd);
+	if (ret)
+		goto err_irq;
+
+	ret = clk_prepare_enable(info->clk);
+	if (ret)
+		goto err_disable_reg;
+
 	info->version = exynos_adc_get_version(pdev);
 
 	platform_set_drvdata(pdev, indio_dev);
@@ -334,13 +342,7 @@ static int exynos_adc_probe(struct platform_device *pdev)
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto err_irq;
-
-	ret = regulator_enable(info->vdd);
-	if (ret)
-		goto err_iio_dev;
-
-	clk_prepare_enable(info->clk);
+		goto err_disable_clk;
 
 	exynos_adc_hw_init(info);
 
@@ -355,10 +357,11 @@ static int exynos_adc_probe(struct platform_device *pdev)
 err_of_populate:
 	device_for_each_child(&indio_dev->dev, NULL,
 				exynos_adc_remove_devices);
-	regulator_disable(info->vdd);
-	clk_disable_unprepare(info->clk);
-err_iio_dev:
 	iio_device_unregister(indio_dev);
+err_disable_clk:
+	clk_disable_unprepare(info->clk);
+err_disable_reg:
+	regulator_disable(info->vdd);
 err_irq:
 	free_irq(info->irq, info);
 	return ret;
@@ -371,9 +374,10 @@ static int exynos_adc_remove(struct platform_device *pdev)
 
 	device_for_each_child(&indio_dev->dev, NULL,
 				exynos_adc_remove_devices);
-	regulator_disable(info->vdd);
 	clk_disable_unprepare(info->clk);
+	regulator_disable(info->vdd);
 	writel(0, info->enable_reg);
+
 	iio_device_unregister(indio_dev);
 	free_irq(info->irq, info);
 
@@ -398,8 +402,8 @@ static int exynos_adc_suspend(struct device *dev)
 	}
 
 	clk_disable_unprepare(info->clk);
-	writel(0, info->enable_reg);
 	regulator_disable(info->vdd);
+	writel(0, info->enable_reg);
 
 	return 0;
 }
@@ -410,12 +414,14 @@ static int exynos_adc_resume(struct device *dev)
 	struct exynos_adc *info = iio_priv(indio_dev);
 	int ret;
 
+	writel(1, info->enable_reg);
 	ret = regulator_enable(info->vdd);
 	if (ret)
 		return ret;
 
-	writel(1, info->enable_reg);
-	clk_prepare_enable(info->clk);
+	ret = clk_prepare_enable(info->clk);
+	if (ret)
+		return ret;
 
 	exynos_adc_hw_init(info);
 
-- 
1.7.9.5

