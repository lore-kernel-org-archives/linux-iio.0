Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:64260 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbbAUGE2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 21 Jan 2015 01:04:28 -0500
Received: by mail-pd0-f173.google.com with SMTP id fp1so22877455pdb.4
        for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2015 22:04:28 -0800 (PST)
From: varkabhadram@gmail.com
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Varka Bhadram <varkab@cdac.in>
Subject: [PATCH iio 2/3] imu: inv_mpu6050: use devm_iio_trigger_alloc
Date: Wed, 21 Jan 2015 11:29:36 +0530
Message-Id: <1421819977-32232-2-git-send-email-varkabhadram@gmail.com>
In-Reply-To: <1421819977-32232-1-git-send-email-varkabhadram@gmail.com>
References: <1421819977-32232-1-git-send-email-varkabhadram@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Varka Bhadram <varkab@cdac.in>


Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index 97f54fb..ab8c85a 100644
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
@@ -129,19 +130,17 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev)
 			       "inv_mpu",
 			       st->trig);
 	if (ret)
-		goto error_free_trig;
+		goto error_ret;
 	st->trig->dev.parent = &st->client->dev;
 	st->trig->ops = &inv_mpu_trigger_ops;
 	iio_trigger_set_drvdata(st->trig, indio_dev);
 	ret = iio_trigger_register(st->trig);
 	if (ret)
-		goto error_free_trig;
+		goto error_ret;
 	indio_dev->trig = iio_trigger_get(st->trig);
 
 	return 0;
 
-error_free_trig:
-	iio_trigger_free(st->trig);
 error_ret:
 	return ret;
 }
@@ -149,5 +148,4 @@ error_ret:
 void inv_mpu6050_remove_trigger(struct inv_mpu6050_state *st)
 {
 	iio_trigger_unregister(st->trig);
-	iio_trigger_free(st->trig);
 }
-- 
1.7.9.5

