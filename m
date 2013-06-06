Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:36375 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442Ab3FFJls (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Jun 2013 05:41:48 -0400
Received: by mail-pd0-f172.google.com with SMTP id t10so3124896pdi.17
        for <linux-iio@vger.kernel.org>; Thu, 06 Jun 2013 02:41:48 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: devel@driverdev.osuosl.org
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
	jic23@cam.ac.uk, sachin.kamat@linaro.org, Stefan Roese <sr@denx.de>
Subject: [PATCH 2/3] staging: iio: spear_adc: Remove redundant platform_set_drvdata()
Date: Thu,  6 Jun 2013 14:57:23 +0530
Message-Id: <1370510844-23603-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1370510844-23603-1-git-send-email-sachin.kamat@linaro.org>
References: <1370510844-23603-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Stefan Roese <sr@denx.de>
---
 drivers/staging/iio/adc/spear_adc.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/iio/adc/spear_adc.c b/drivers/staging/iio/adc/spear_adc.c
index f45da42..25a06cb 100644
--- a/drivers/staging/iio/adc/spear_adc.c
+++ b/drivers/staging/iio/adc/spear_adc.c
@@ -407,7 +407,6 @@ static int spear_adc_remove(struct platform_device *pdev)
 	struct spear_adc_info *info = iio_priv(iodev);
 
 	iio_device_unregister(iodev);
-	platform_set_drvdata(pdev, NULL);
 	clk_disable_unprepare(info->clk);
 	clk_put(info->clk);
 	iounmap(info->adc_base_spear6xx);
-- 
1.7.9.5

