Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	jic23@kernel.org,
	sachin.kamat@linaro.org,
	patches@linaro.org,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 1/8] iio: at91: Use devm_iio_device_alloc
Date: Mon, 22 Jul 2013 16:32:54 +0530
Message-Id: <1374490981-24373-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1374490981-24373-1-git-send-email-sachin.kamat@linaro.org>
References: <1374490981-24373-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Using devm_iio_device_alloc makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/iio/adc/at91_adc.c |   23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index b6db6a0..423e079 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -589,11 +589,9 @@ static int at91_adc_probe(struct platform_device *pdev)
 	struct resource *res;
 	u32 reg;
 
-	idev = iio_device_alloc(sizeof(struct at91_adc_state));
-	if (idev == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
+	idev = devm_iio_device_alloc(&pdev->dev, sizeof(struct at91_adc_state));
+	if (!idev)
+		return -ENOMEM;
 
 	st = iio_priv(idev);
 
@@ -604,8 +602,7 @@ static int at91_adc_probe(struct platform_device *pdev)
 
 	if (ret) {
 		dev_err(&pdev->dev, "No platform data available.\n");
-		ret = -EINVAL;
-		goto error_free_device;
+		return -EINVAL;
 	}
 
 	platform_set_drvdata(pdev, idev);
@@ -618,16 +615,14 @@ static int at91_adc_probe(struct platform_device *pdev)
 	st->irq = platform_get_irq(pdev, 0);
 	if (st->irq < 0) {
 		dev_err(&pdev->dev, "No IRQ ID is designated\n");
-		ret = -ENODEV;
-		goto error_free_device;
+		return -ENODEV;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
 	st->reg_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(st->reg_base)) {
-		ret = PTR_ERR(st->reg_base);
-		goto error_free_device;
+		return PTR_ERR(st->reg_base);
 	}
 
 	/*
@@ -642,7 +637,7 @@ static int at91_adc_probe(struct platform_device *pdev)
 			  idev);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to allocate IRQ.\n");
-		goto error_free_device;
+		return ret;
 	}
 
 	st->clk = devm_clk_get(&pdev->dev, "adc_clk");
@@ -752,9 +747,6 @@ error_disable_clk:
 	clk_disable_unprepare(st->clk);
 error_free_irq:
 	free_irq(st->irq, idev);
-error_free_device:
-	iio_device_free(idev);
-error_ret:
 	return ret;
 }
 
@@ -769,7 +761,6 @@ static int at91_adc_remove(struct platform_device *pdev)
 	clk_disable_unprepare(st->adc_clk);
 	clk_disable_unprepare(st->clk);
 	free_irq(st->irq, idev);
-	iio_device_free(idev);
 
 	return 0;
 }
-- 
1.7.9.5
