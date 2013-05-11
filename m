Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ee0-f49.google.com ([74.125.83.49]:35757 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131Ab3EKLGi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 11 May 2013 07:06:38 -0400
From: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sachin Kamat <sachin.kamat@linaro.org>,
	linux-kernel@vger.kernel.org,
	Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
Subject: [PATCH] drivers: iio: adc: convert to devm_ioremap_resource()
Date: Sat, 11 May 2013 14:06:31 +0300
Message-Id: <1368270391-15267-1-git-send-email-silviupopescu1990@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Convert all uses of devm_request_and_ioremap() to the newly introduced
devm_ioremap_resource() which provides more consistent error handling.

Signed-off-by: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
---
 drivers/iio/adc/exynos_adc.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 9f3a8ef..22d034a 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -270,16 +270,16 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	info = iio_priv(indio_dev);
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	info->regs = devm_request_and_ioremap(&pdev->dev, mem);
-	if (!info->regs) {
-		ret = -ENOMEM;
+	info->regs = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(info->regs)) {
+		ret = PTR_ERR(info->regs);
 		goto err_iio;
 	}
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	info->enable_reg = devm_request_and_ioremap(&pdev->dev, mem);
-	if (!info->enable_reg) {
-		ret = -ENOMEM;
+	info->enable_reg = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(info->enable_reg)) {
+		ret = PTR_ERR(info->enable_reg);
 		goto err_iio;
 	}
 
-- 
1.7.9.5

