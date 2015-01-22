Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:53698 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbbAVDnK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 21 Jan 2015 22:43:10 -0500
Received: by mail-pd0-f169.google.com with SMTP id g10so20744166pdj.0
        for <linux-iio@vger.kernel.org>; Wed, 21 Jan 2015 19:43:10 -0800 (PST)
From: Varka Bhadram <varkabhadram@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, Varka Bhadram <varkab@cdac.in>
Subject: [PATCH iio v2 3/3] imu: inv_mpu6050: cleanup on error check
Date: Thu, 22 Jan 2015 09:08:04 +0530
Message-Id: <1421897884-32663-4-git-send-email-varkab@cdac.in>
In-Reply-To: <1421897884-32663-1-git-send-email-varkab@cdac.in>
References: <1421897884-32663-1-git-send-email-varkab@cdac.in>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index ab8c85a..844610c 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -120,29 +120,28 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev)
 					  "%s-dev%d",
 					  indio_dev->name,
 					  indio_dev->id);
-	if (st->trig == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
+	if (!st->trig)
+		return -ENOMEM;
+
 	ret = devm_request_irq(&indio_dev->dev, st->client->irq,
 			       &iio_trigger_generic_data_rdy_poll,
 			       IRQF_TRIGGER_RISING,
 			       "inv_mpu",
 			       st->trig);
 	if (ret)
-		goto error_ret;
+		return ret;
+
 	st->trig->dev.parent = &st->client->dev;
 	st->trig->ops = &inv_mpu_trigger_ops;
 	iio_trigger_set_drvdata(st->trig, indio_dev);
+
 	ret = iio_trigger_register(st->trig);
 	if (ret)
-		goto error_ret;
+		return ret;
+
 	indio_dev->trig = iio_trigger_get(st->trig);
 
 	return 0;
-
-error_ret:
-	return ret;
 }
 
 void inv_mpu6050_remove_trigger(struct inv_mpu6050_state *st)
-- 
1.7.9.5

