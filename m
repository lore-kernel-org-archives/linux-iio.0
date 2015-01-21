Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:63467 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbbAUGEZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 21 Jan 2015 01:04:25 -0500
Received: by mail-pa0-f49.google.com with SMTP id hz1so20119914pad.8
        for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2015 22:04:24 -0800 (PST)
From: varkabhadram@gmail.com
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Varka Bhadram <varkab@cdac.in>
Subject: [PATCH iio 1/3] imu: inv_mpu6050: use devm_request_irq
Date: Wed, 21 Jan 2015 11:29:35 +0530
Message-Id: <1421819977-32232-1-git-send-email-varkabhadram@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Varka Bhadram <varkab@cdac.in>

This patch use the devres API for requesting an IRQ.

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index 926fcce..97f54fb 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -123,10 +123,11 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev)
 		ret = -ENOMEM;
 		goto error_ret;
 	}
-	ret = request_irq(st->client->irq, &iio_trigger_generic_data_rdy_poll,
-				IRQF_TRIGGER_RISING,
-				"inv_mpu",
-				st->trig);
+	ret = devm_request_irq(&indio_dev->dev, st->client->irq,
+			       &iio_trigger_generic_data_rdy_poll,
+			       IRQF_TRIGGER_RISING,
+			       "inv_mpu",
+			       st->trig);
 	if (ret)
 		goto error_free_trig;
 	st->trig->dev.parent = &st->client->dev;
@@ -134,13 +135,11 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev)
 	iio_trigger_set_drvdata(st->trig, indio_dev);
 	ret = iio_trigger_register(st->trig);
 	if (ret)
-		goto error_free_irq;
+		goto error_free_trig;
 	indio_dev->trig = iio_trigger_get(st->trig);
 
 	return 0;
 
-error_free_irq:
-	free_irq(st->client->irq, st->trig);
 error_free_trig:
 	iio_trigger_free(st->trig);
 error_ret:
@@ -150,6 +149,5 @@ error_ret:
 void inv_mpu6050_remove_trigger(struct inv_mpu6050_state *st)
 {
 	iio_trigger_unregister(st->trig);
-	free_irq(st->client->irq, st->trig);
 	iio_trigger_free(st->trig);
 }
-- 
1.7.9.5

