Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:34319 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759205Ab3ICAsZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 2 Sep 2013 20:48:25 -0400
Received: by mail-qc0-f172.google.com with SMTP id e16so506607qcx.31
        for <linux-iio@vger.kernel.org>; Mon, 02 Sep 2013 17:48:24 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: jic23@cam.ac.uk
Cc: marex@denx.de, linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 1/2] iio: mxs-lradc: Fix the order of resources removal
Date: Mon,  2 Sep 2013 21:48:11 -0300
Message-Id: <1378169292-29899-1-git-send-email-festevam@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Fix the order of resources removal in the error path of mxs_lradc_probe()
and also in mxs_lradc_remove().

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/staging/iio/adc/mxs-lradc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index a08c173..75f5aac 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -987,7 +987,7 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 	/* Register the touchscreen input device. */
 	ret = mxs_lradc_ts_register(lradc);
 	if (ret)
-		goto err_dev;
+		goto err_ts_register;
 
 	/* Register IIO device. */
 	ret = iio_device_register(iio);
@@ -1000,6 +1000,8 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 
 err_ts:
 	mxs_lradc_ts_unregister(lradc);
+err_ts_register:
+	mxs_lradc_hw_stop(lradc);
 err_dev:
 	mxs_lradc_trigger_remove(iio);
 err_trig:
@@ -1012,13 +1014,11 @@ static int mxs_lradc_remove(struct platform_device *pdev)
 	struct iio_dev *iio = platform_get_drvdata(pdev);
 	struct mxs_lradc *lradc = iio_priv(iio);
 
+	iio_device_unregister(iio);
 	mxs_lradc_ts_unregister(lradc);
-
 	mxs_lradc_hw_stop(lradc);
-
-	iio_device_unregister(iio);
-	iio_triggered_buffer_cleanup(iio);
 	mxs_lradc_trigger_remove(iio);
+	iio_triggered_buffer_cleanup(iio);
 
 	return 0;
 }
-- 
1.8.1.2

