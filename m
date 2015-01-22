Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:52926 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbbAVDnH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 21 Jan 2015 22:43:07 -0500
Received: by mail-pa0-f41.google.com with SMTP id kq14so5503302pab.0
        for <linux-iio@vger.kernel.org>; Wed, 21 Jan 2015 19:43:07 -0800 (PST)
From: Varka Bhadram <varkabhadram@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, Varka Bhadram <varkab@cdac.in>
Subject: [PATCH iio v2 2/3] imu: inv_mpu6050: use devm_request_irq
Date: Thu, 22 Jan 2015 09:08:03 +0530
Message-Id: <1421897884-32663-3-git-send-email-varkab@cdac.in>
In-Reply-To: <1421897884-32663-1-git-send-email-varkab@cdac.in>
References: <1421897884-32663-1-git-send-email-varkab@cdac.in>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch use the devres API for requesting an IRQ.

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index c827d21..ab8c85a 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -124,10 +124,11 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev)
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
 		goto error_ret;
 	st->trig->dev.parent = &st->client->dev;
@@ -135,13 +136,11 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev)
 	iio_trigger_set_drvdata(st->trig, indio_dev);
 	ret = iio_trigger_register(st->trig);
 	if (ret)
-		goto error_free_irq;
+		goto error_ret;
 	indio_dev->trig = iio_trigger_get(st->trig);
 
 	return 0;
 
-error_free_irq:
-	free_irq(st->client->irq, st->trig);
 error_ret:
 	return ret;
 }
@@ -149,5 +148,4 @@ error_ret:
 void inv_mpu6050_remove_trigger(struct inv_mpu6050_state *st)
 {
 	iio_trigger_unregister(st->trig);
-	free_irq(st->client->irq, st->trig);
 }
-- 
1.7.9.5

