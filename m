Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:15160 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934046AbaFRGVs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Jun 2014 02:21:48 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N7C00DO5PO9TU00@mailout3.samsung.com> for
 linux-iio@vger.kernel.org; Wed, 18 Jun 2014 15:21:45 +0900 (KST)
From: Beomho Seo <beomho.seo@samsung.com>
To: linux-iio@vger.kernel.org, jic23@kernel.org,
	j.anaszewski@samsung.com, sachin.kamat@linaro.org,
	ch.naveen@samsung.com, ktsai@capellamicro.com,
	srinivas.pandruvada@linux.intel.com, t.figa@samsung.com
Cc: myungjoo.ham@samsung.com, jh80.chung@samsung.com,
	cw00.choi@samsung.com, Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH 1/5] iio: adc: exynos_adc: Use devm_* APIs
Date: Wed, 18 Jun 2014 15:21:39 +0900
Message-id: <1403072503-29246-2-git-send-email-beomho.seo@samsung.com>
In-reply-to: <1403072503-29246-1-git-send-email-beomho.seo@samsung.com>
References: <1403072503-29246-1-git-send-email-beomho.seo@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch changes APIs from request_irq() and iio_device_register()
to devm_* APIs. Using them, make code simpler.

Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
---
 drivers/iio/adc/exynos_adc.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index d325aea..37b6eb5 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -337,7 +337,7 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	else
 		indio_dev->num_channels = MAX_ADC_V2_CHANNELS;
 
-	ret = request_irq(info->irq, exynos_adc_isr,
+	ret = devm_request_irq(&pdev->dev, info->irq, exynos_adc_isr,
 					0, dev_name(&pdev->dev), info);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed requesting irq, irq = %d\n",
@@ -345,9 +345,9 @@ static int exynos_adc_probe(struct platform_device *pdev)
 		goto err_disable_clk;
 	}
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&pdev->dev, indio_dev);
 	if (ret)
-		goto err_irq;
+		goto err_disable_clk;
 
 	exynos_adc_hw_init(info);
 
@@ -362,9 +362,6 @@ static int exynos_adc_probe(struct platform_device *pdev)
 err_of_populate:
 	device_for_each_child(&pdev->dev, NULL,
 				exynos_adc_remove_devices);
-	iio_device_unregister(indio_dev);
-err_irq:
-	free_irq(info->irq, info);
 err_disable_clk:
 	writel(0, info->enable_reg);
 	clk_disable_unprepare(info->clk);
@@ -380,8 +377,6 @@ static int exynos_adc_remove(struct platform_device *pdev)
 
 	device_for_each_child(&pdev->dev, NULL,
 				exynos_adc_remove_devices);
-	iio_device_unregister(indio_dev);
-	free_irq(info->irq, info);
 	writel(0, info->enable_reg);
 	clk_disable_unprepare(info->clk);
 	regulator_disable(info->vdd);
-- 
1.7.9.5

