Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:28099 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636AbaDYKQi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 25 Apr 2014 06:16:38 -0400
From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	dianders@chromium.org, gregkh@linuxfoundation.org,
	naveenkrishna.ch@gmail.com, lars@metafoo.de, cpgs@samsung.com,
	grundler@chromium.org, Naveen Krishna Ch <ch.naveen@samsung.com>
Subject: [PATCH 1/5] iio: exynos_adc: use indio_dev->dev structure to handle
 child nodes
Date: Fri, 25 Apr 2014 15:44:43 +0530
Message-id: <1398420888-5506-2-git-send-email-ch.naveen@samsung.com>
In-reply-to: <1398420888-5506-1-git-send-email-ch.naveen@samsung.com>
References: <1398420888-5506-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Naveen Krishna Ch <ch.naveen@samsung.com>

Using pdev->dev with device_for_each_child() would iterate over all
of the children of the platform device and delete them.
Thus, causing crashes during module unload.

We should be using the indio_dev->dev structure for
registering/unregistering child nodes.

Signed-off-by: Naveen Krishna Ch <ch.naveen@samsung.com>
---
This change was tested on top of 
   https://lkml.org/lkml/2014/4/21/481 from Doug.

 drivers/iio/adc/exynos_adc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index d25b262..affa93f 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -344,7 +344,7 @@ static int exynos_adc_probe(struct platform_device *pdev)
 
 	exynos_adc_hw_init(info);
 
-	ret = of_platform_populate(np, exynos_adc_match, NULL, &pdev->dev);
+	ret = of_platform_populate(np, exynos_adc_match, NULL, &indio_dev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed adding child nodes\n");
 		goto err_of_populate;
@@ -353,7 +353,7 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	return 0;
 
 err_of_populate:
-	device_for_each_child(&pdev->dev, NULL,
+	device_for_each_child(&indio_dev->dev, NULL,
 				exynos_adc_remove_devices);
 	regulator_disable(info->vdd);
 	clk_disable_unprepare(info->clk);
@@ -369,7 +369,7 @@ static int exynos_adc_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct exynos_adc *info = iio_priv(indio_dev);
 
-	device_for_each_child(&pdev->dev, NULL,
+	device_for_each_child(&indio_dev->dev, NULL,
 				exynos_adc_remove_devices);
 	regulator_disable(info->vdd);
 	clk_disable_unprepare(info->clk);
-- 
1.7.9.5

