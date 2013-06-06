Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:57031 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473Ab3FFJlo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Jun 2013 05:41:44 -0400
Received: by mail-pd0-f174.google.com with SMTP id 10so2139619pdc.19
        for <linux-iio@vger.kernel.org>; Thu, 06 Jun 2013 02:41:44 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: devel@driverdev.osuosl.org
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
	jic23@cam.ac.uk, sachin.kamat@linaro.org,
	Michael Hennerich <hennerich@blackfin.uclinux.org>
Subject: [PATCH 1/3] staging: iio: ad7606_par: Remove redundant platform_set_drvdata()
Date: Thu,  6 Jun 2013 14:57:22 +0530
Message-Id: <1370510844-23603-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Michael Hennerich <hennerich@blackfin.uclinux.org>
---
 drivers/staging/iio/adc/ad7606_par.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/staging/iio/adc/ad7606_par.c
index 58cfdde..8a48d18 100644
--- a/drivers/staging/iio/adc/ad7606_par.c
+++ b/drivers/staging/iio/adc/ad7606_par.c
@@ -112,8 +112,6 @@ static int ad7606_par_remove(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(res->start, resource_size(res));
 
-	platform_set_drvdata(pdev, NULL);
-
 	return 0;
 }
 
-- 
1.7.9.5

