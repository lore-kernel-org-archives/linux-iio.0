Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:48000 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442Ab3FFJlx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Jun 2013 05:41:53 -0400
Received: by mail-pd0-f176.google.com with SMTP id r11so3110669pdi.35
        for <linux-iio@vger.kernel.org>; Thu, 06 Jun 2013 02:41:53 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: devel@driverdev.osuosl.org
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
	jic23@cam.ac.uk, sachin.kamat@linaro.org,
	Roland Stigge <stigge@antcom.de>
Subject: [PATCH 3/3] staging: iio: lpc32xx_adc: Remove redundant platform_set_drvdata()
Date: Thu,  6 Jun 2013 14:57:24 +0530
Message-Id: <1370510844-23603-3-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1370510844-23603-1-git-send-email-sachin.kamat@linaro.org>
References: <1370510844-23603-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Roland Stigge <stigge@antcom.de>
---
 drivers/staging/iio/adc/lpc32xx_adc.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/iio/adc/lpc32xx_adc.c b/drivers/staging/iio/adc/lpc32xx_adc.c
index 2f2f7fd..9a4bb09 100644
--- a/drivers/staging/iio/adc/lpc32xx_adc.c
+++ b/drivers/staging/iio/adc/lpc32xx_adc.c
@@ -215,7 +215,6 @@ static int lpc32xx_adc_remove(struct platform_device *pdev)
 
 	iio_device_unregister(iodev);
 	free_irq(irq, info);
-	platform_set_drvdata(pdev, NULL);
 	clk_put(info->clk);
 	iounmap(info->adc_base);
 	iio_device_free(iodev);
-- 
1.7.9.5

