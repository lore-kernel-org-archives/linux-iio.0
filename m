Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:49999 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286Ab3HaRNL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 31 Aug 2013 13:13:11 -0400
Received: by mail-pb0-f54.google.com with SMTP id ro12so3096605pbb.13
        for <linux-iio@vger.kernel.org>; Sat, 31 Aug 2013 10:13:10 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, sachin.kamat@linaro.org,
	Roland Stigge <stigge@antcom.de>
Subject: [PATCH 8/9] staging: iio: lpc32xx_adc: Use devm_* APIs
Date: Sat, 31 Aug 2013 22:42:38 +0530
Message-Id: <1377969159-2491-8-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1377969159-2491-1-git-send-email-sachin.kamat@linaro.org>
References: <1377969159-2491-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

devm_* APIs are device managed and make code simpler.
This also fixes an error in return type during clk_get
failure.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Roland Stigge <stigge@antcom.de>
---
 drivers/staging/iio/adc/lpc32xx_adc.c |   49 +++++++++-----------------------
 1 files changed, 14 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/iio/adc/lpc32xx_adc.c b/drivers/staging/iio/adc/lpc32xx_adc.c
index 9a4bb09..ce7ff3e 100644
--- a/drivers/staging/iio/adc/lpc32xx_adc.c
+++ b/drivers/staging/iio/adc/lpc32xx_adc.c
@@ -137,43 +137,39 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "failed to get platform I/O memory\n");
-		retval = -EBUSY;
-		goto errout1;
+		return -EBUSY;
 	}
 
-	iodev = iio_device_alloc(sizeof(struct lpc32xx_adc_info));
-	if (!iodev) {
-		dev_err(&pdev->dev, "failed allocating iio device\n");
-		retval = -ENOMEM;
-		goto errout1;
-	}
+	iodev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
+	if (!iodev)
+		return -ENOMEM;
 
 	info = iio_priv(iodev);
 
-	info->adc_base = ioremap(res->start, resource_size(res));
+	info->adc_base = devm_ioremap(&pdev->dev, res->start,
+						resource_size(res));
 	if (!info->adc_base) {
 		dev_err(&pdev->dev, "failed mapping memory\n");
-		retval = -EBUSY;
-		goto errout2;
+		return -EBUSY;
 	}
 
-	info->clk = clk_get(&pdev->dev, NULL);
+	info->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(info->clk)) {
 		dev_err(&pdev->dev, "failed getting clock\n");
-		goto errout3;
+		return PTR_ERR(info->clk);
 	}
 
 	irq = platform_get_irq(pdev, 0);
 	if ((irq < 0) || (irq >= NR_IRQS)) {
 		dev_err(&pdev->dev, "failed getting interrupt resource\n");
-		retval = -EINVAL;
-		goto errout4;
+		return -EINVAL;
 	}
 
-	retval = request_irq(irq, lpc32xx_adc_isr, 0, MOD_NAME, info);
+	retval = devm_request_irq(&pdev->dev, irq, lpc32xx_adc_isr, 0,
+								MOD_NAME, info);
 	if (retval < 0) {
 		dev_err(&pdev->dev, "failed requesting interrupt\n");
-		goto errout4;
+		return retval;
 	}
 
 	platform_set_drvdata(pdev, iodev);
@@ -189,35 +185,18 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
 
 	retval = iio_device_register(iodev);
 	if (retval)
-		goto errout5;
+		return retval;
 
 	dev_info(&pdev->dev, "LPC32XX ADC driver loaded, IRQ %d\n", irq);
 
 	return 0;
-
-errout5:
-	free_irq(irq, info);
-errout4:
-	clk_put(info->clk);
-errout3:
-	iounmap(info->adc_base);
-errout2:
-	iio_device_free(iodev);
-errout1:
-	return retval;
 }
 
 static int lpc32xx_adc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *iodev = platform_get_drvdata(pdev);
-	struct lpc32xx_adc_info *info = iio_priv(iodev);
-	int irq = platform_get_irq(pdev, 0);
 
 	iio_device_unregister(iodev);
-	free_irq(irq, info);
-	clk_put(info->clk);
-	iounmap(info->adc_base);
-	iio_device_free(iodev);
 
 	return 0;
 }
-- 
1.7.4.1

