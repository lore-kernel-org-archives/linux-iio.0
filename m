Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35726 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbdAWNOX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Jan 2017 08:14:23 -0500
Received: by mail-wm0-f46.google.com with SMTP id r126so132272162wmr.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Jan 2017 05:14:23 -0800 (PST)
From: Anthony Brandon <anthony@amarulasolutions.com>
To: lars@metafoo.de, linux-iio@vger.kernel.org
Cc: Anthony Brandon <anthony@amarulasolutions.com>
Subject: [PATCH] drivers:staging:iio:cdc: Style fix.
Date: Mon, 23 Jan 2017 14:14:12 +0100
Message-Id: <1485177252-22447-1-git-send-email-anthony@amarulasolutions.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Align parameters to parentheses.

Signed-off-by: Anthony Brandon <anthony@amarulasolutions.com>
---
 drivers/staging/iio/cdc/ad7150.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index c886751..ca72af3 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -610,27 +610,27 @@ static int ad7150_probe(struct i2c_client *client,
 
 	if (client->irq) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
-					   NULL,
-					   &ad7150_event_handler,
-					   IRQF_TRIGGER_RISING |
-					   IRQF_TRIGGER_FALLING |
-					   IRQF_ONESHOT,
-					   "ad7150_irq1",
-					   indio_dev);
+						NULL,
+						&ad7150_event_handler,
+						IRQF_TRIGGER_RISING |
+						IRQF_TRIGGER_FALLING |
+						IRQF_ONESHOT,
+						"ad7150_irq1",
+						indio_dev);
 		if (ret)
 			return ret;
 	}
 
 	if (client->dev.platform_data) {
 		ret = devm_request_threaded_irq(&client->dev, *(unsigned int *)
-					   client->dev.platform_data,
-					   NULL,
-					   &ad7150_event_handler,
-					   IRQF_TRIGGER_RISING |
-					   IRQF_TRIGGER_FALLING |
-					   IRQF_ONESHOT,
-					   "ad7150_irq2",
-					   indio_dev);
+						client->dev.platform_data,
+						NULL,
+						&ad7150_event_handler,
+						IRQF_TRIGGER_RISING |
+						IRQF_TRIGGER_FALLING |
+						IRQF_ONESHOT,
+						"ad7150_irq2",
+						indio_dev);
 		if (ret)
 			return ret;
 	}
-- 
2.7.4

