Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:57310 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbbAUGEb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 21 Jan 2015 01:04:31 -0500
Received: by mail-pd0-f173.google.com with SMTP id fp1so22877742pdb.4
        for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2015 22:04:31 -0800 (PST)
From: varkabhadram@gmail.com
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Varka Bhadram <varkab@cdac.in>
Subject: [PATCH iio 3/3] imu: inv_mpu6050: cleanup on error check
Date: Wed, 21 Jan 2015 11:29:37 +0530
Message-Id: <1421819977-32232-3-git-send-email-varkabhadram@gmail.com>
In-Reply-To: <1421819977-32232-1-git-send-email-varkabhadram@gmail.com>
References: <1421819977-32232-1-git-send-email-varkabhadram@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Varka Bhadram <varkab@cdac.in>


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

