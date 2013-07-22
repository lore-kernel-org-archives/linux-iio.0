Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	jic23@kernel.org,
	sachin.kamat@linaro.org,
	patches@linaro.org,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Subject: [PATCH 2/8] iio: exynos_adc: Use devm_iio_device_alloc
Date: Mon, 22 Jul 2013 16:32:55 +0530
Message-Id: <1374490981-24373-3-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1374490981-24373-1-git-send-email-sachin.kamat@linaro.org>
References: <1374490981-24373-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Using devm_iio_device_alloc makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
---
 drivers/iio/adc/exynos_adc.c |   23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 9809fc9..d25b262 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -33,6 +33,7 @@
 #include <linux/of_irq.h>
 #include <linux/regulator/consumer.h>
 #include <linux/of_platform.h>
+#include <linux/err.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/machine.h>
@@ -261,7 +262,7 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	if (!np)
 		return ret;
 
-	indio_dev = iio_device_alloc(sizeof(struct exynos_adc));
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(struct exynos_adc));
 	if (!indio_dev) {
 		dev_err(&pdev->dev, "failed allocating iio device\n");
 		return -ENOMEM;
@@ -271,23 +272,18 @@ static int exynos_adc_probe(struct platform_device *pdev)
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	info->regs = devm_ioremap_resource(&pdev->dev, mem);
-	if (IS_ERR(info->regs)) {
-		ret = PTR_ERR(info->regs);
-		goto err_iio;
-	}
+	if (IS_ERR(info->regs))
+		return PTR_ERR(info->regs);
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	info->enable_reg = devm_ioremap_resource(&pdev->dev, mem);
-	if (IS_ERR(info->enable_reg)) {
-		ret = PTR_ERR(info->enable_reg);
-		goto err_iio;
-	}
+	if (IS_ERR(info->enable_reg))
+		return PTR_ERR(info->enable_reg);
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "no irq resource?\n");
-		ret = irq;
-		goto err_iio;
+		return irq;
 	}
 
 	info->irq = irq;
@@ -299,7 +295,7 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed requesting irq, irq = %d\n",
 							info->irq);
-		goto err_iio;
+		return ret;
 	}
 
 	writel(1, info->enable_reg);
@@ -365,8 +361,6 @@ err_iio_dev:
 	iio_device_unregister(indio_dev);
 err_irq:
 	free_irq(info->irq, info);
-err_iio:
-	iio_device_free(indio_dev);
 	return ret;
 }
 
@@ -382,7 +376,6 @@ static int exynos_adc_remove(struct platform_device *pdev)
 	writel(0, info->enable_reg);
 	iio_device_unregister(indio_dev);
 	free_irq(info->irq, info);
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.9.5
