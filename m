Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:45208 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785Ab3IKKNl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Sep 2013 06:13:41 -0400
Received: by mail-pd0-f179.google.com with SMTP id v10so8936082pde.38
        for <linux-iio@vger.kernel.org>; Wed, 11 Sep 2013 03:13:40 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, sachin.kamat@linaro.org,
	Shubhrajyoti Datta <shubhrajyoti@ti.com>
Subject: [PATCH 01/10] staging: iio: hmc5843: Use devm_iio_device_alloc
Date: Wed, 11 Sep 2013 15:25:16 +0530
Message-Id: <1378893325-31764-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

devm_iio_device_alloc makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Shubhrajyoti Datta <shubhrajyoti@ti.com>
---
Series compile tested.
---
 drivers/staging/iio/magnetometer/hmc5843.c |   16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index 67c1ce7..790f456 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -643,11 +643,9 @@ static int hmc5843_probe(struct i2c_client *client,
 	struct iio_dev *indio_dev;
 	int err = 0;
 
-	indio_dev = iio_device_alloc(sizeof(*data));
-	if (indio_dev == NULL) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
 
 	/* default settings at probe */
 	data = iio_priv(indio_dev);
@@ -665,14 +663,9 @@ static int hmc5843_probe(struct i2c_client *client,
 
 	err = iio_device_register(indio_dev);
 	if (err)
-		goto exit_free2;
+		return err;
 
 	return 0;
-
-exit_free2:
-	iio_device_free(indio_dev);
-exit:
-	return err;
 }
 
 static int hmc5843_remove(struct i2c_client *client)
@@ -682,7 +675,6 @@ static int hmc5843_remove(struct i2c_client *client)
 	iio_device_unregister(indio_dev);
 	 /*  sleep mode to save power */
 	hmc5843_configure(client, HMC5843_MODE_SLEEP);
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.9.5

