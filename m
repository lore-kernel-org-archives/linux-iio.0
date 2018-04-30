Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-sn1nam01on0056.outbound.protection.outlook.com ([104.47.32.56]:18131
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752473AbeD3KPA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Apr 2018 06:15:00 -0400
From: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To: linux-iio@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 3/4] iio: imu: inv_mpu6050: skip first sample when gyro is on
Date: Mon, 30 Apr 2018 12:14:10 +0200
Message-Id: <1525083251-8368-3-git-send-email-jmaneyrol@invensense.com>
In-Reply-To: <1525083251-8368-1-git-send-email-jmaneyrol@invensense.com>
References: <1525083251-8368-1-git-send-email-jmaneyrol@invensense.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Implement generic skip first samples mechanism and use it to
filter out first sample when gyro is on.

The problem for these chips is that the first sample of the gyro
is out of specs, because gyro is not completely stabilized. To
ensure all data are within sensor specs, we just skip the first
sample when turning gyro on.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     | 1 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 7 ++++++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 3 +++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index 142a835..dfb9e4e 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -148,6 +148,7 @@ struct inv_mpu6050_state {
 	struct regmap *map;
 	int irq;
 	u8 irq_mask;
+	unsigned skip_samples;
 };
 
 /*register and associated bit definition*/
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index e51404f..1b57354 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -185,7 +185,12 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 		if (result == 0)
 			timestamp = 0;
 
-		iio_push_to_buffers_with_timestamp(indio_dev, data, timestamp);
+		/* skip first samples if needed */
+		if (st->skip_samples)
+			st->skip_samples--;
+		else
+			iio_push_to_buffers_with_timestamp(indio_dev, data,
+							   timestamp);
 
 		fifo_count -= bytes_per_datum;
 	}
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index 8a9f869..0d7db27 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -49,11 +49,14 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
 		if (result)
 			return result;
 		inv_scan_query(indio_dev);
+		st->skip_samples = 0;
 		if (st->chip_config.gyro_fifo_enable) {
 			result = inv_mpu6050_switch_engine(st, true,
 					INV_MPU6050_BIT_PWR_GYRO_STBY);
 			if (result)
 				goto error_power_off;
+			/* gyro first sample is out of specs, skip it */
+			st->skip_samples = 1;
 		}
 		if (st->chip_config.accl_fifo_enable) {
 			result = inv_mpu6050_switch_engine(st, true,
-- 
2.7.4

