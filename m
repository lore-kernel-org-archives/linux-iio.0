Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:56167 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753862Ab3FGLUY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 7 Jun 2013 07:20:24 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so4724977pdj.28
        for <linux-iio@vger.kernel.org>; Fri, 07 Jun 2013 04:20:23 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: devel@driverdev.osuosl.org
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
	jic23@cam.ac.uk, sachin.kamat@linaro.org, jic23@kernel.org,
	Stefan Roese <sr@denx.de>
Subject: [PATCH 1/1] staging: iio: spear_adc: Add missing CONFIG_OF macro
Date: Fri,  7 Jun 2013 16:36:01 +0530
Message-Id: <1370603161-10992-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The data structure is required only when DT is enabled.
Hence compile it conditionally.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Stefan Roese <sr@denx.de>
---
 drivers/staging/iio/adc/spear_adc.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/iio/adc/spear_adc.c b/drivers/staging/iio/adc/spear_adc.c
index 25a06cb..736219c 100644
--- a/drivers/staging/iio/adc/spear_adc.c
+++ b/drivers/staging/iio/adc/spear_adc.c
@@ -415,11 +415,13 @@ static int spear_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
 static const struct of_device_id spear_adc_dt_ids[] = {
 	{ .compatible = "st,spear600-adc", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, spear_adc_dt_ids);
+#endif
 
 static struct platform_driver spear_adc_driver = {
 	.probe		= spear_adc_probe,
-- 
1.7.9.5

