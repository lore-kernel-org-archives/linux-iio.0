Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:40844 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbbAVDnE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 21 Jan 2015 22:43:04 -0500
Received: by mail-pd0-f176.google.com with SMTP id y10so14264328pdj.7
        for <linux-iio@vger.kernel.org>; Wed, 21 Jan 2015 19:43:03 -0800 (PST)
From: Varka Bhadram <varkabhadram@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, Varka Bhadram <varkab@cdac.in>
Subject: [PATCH iio v2 1/3] imu: inv_mpu6050: use devm_iio_trigger_alloc
Date: Thu, 22 Jan 2015 09:08:02 +0530
Message-Id: <1421897884-32663-2-git-send-email-varkab@cdac.in>
In-Reply-To: <1421897884-32663-1-git-send-email-varkab@cdac.in>
References: <1421897884-32663-1-git-send-email-varkab@cdac.in>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index 926fcce..c827d21 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -116,9 +116,10 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev)
 	int ret;
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
 
-	st->trig = iio_trigger_alloc("%s-dev%d",
-					indio_dev->name,
-					indio_dev->id);
+	st->trig = devm_iio_trigger_alloc(&indio_dev->dev,
+					  "%s-dev%d",
+					  indio_dev->name,
+					  indio_dev->id);
 	if (st->trig == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -128,7 +129,7 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev)
 				"inv_mpu",
 				st->trig);
 	if (ret)
-		goto error_free_trig;
+		goto error_ret;
 	st->trig->dev.parent = &st->client->dev;
 	st->trig->ops = &inv_mpu_trigger_ops;
 	iio_trigger_set_drvdata(st->trig, indio_dev);
@@ -141,8 +142,6 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev)
 
 error_free_irq:
 	free_irq(st->client->irq, st->trig);
-error_free_trig:
-	iio_trigger_free(st->trig);
 error_ret:
 	return ret;
 }
@@ -151,5 +150,4 @@ void inv_mpu6050_remove_trigger(struct inv_mpu6050_state *st)
 {
 	iio_trigger_unregister(st->trig);
 	free_irq(st->client->irq, st->trig);
-	iio_trigger_free(st->trig);
 }
-- 
1.7.9.5

