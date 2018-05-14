Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-cys01nam02on0059.outbound.protection.outlook.com ([104.47.37.59]:42300
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752136AbeENVGa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 14 May 2018 17:06:30 -0400
From: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To: linux-iio@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 4/5] iio: imu: inv_mpu6050: better fifo overflow handling
Date: Mon, 14 May 2018 23:05:54 +0200
Message-Id: <1526331955-11869-4-git-send-email-jmaneyrol@invensense.com>
In-Reply-To: <1526331955-11869-1-git-send-email-jmaneyrol@invensense.com>
References: <1526331955-11869-1-git-send-email-jmaneyrol@invensense.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use fifo overflow bit from int status rather than using an
arbitrary threshold.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  | 2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index 8d9044c..09a7e1c 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -166,6 +166,7 @@ struct inv_mpu6050_state {
 #define INV_MPU6050_REG_RAW_GYRO            0x43
 
 #define INV_MPU6050_REG_INT_STATUS          0x3A
+#define INV_MPU6050_BIT_FIFO_OVERFLOW_INT   0x10
 #define INV_MPU6050_BIT_RAW_DATA_RDY_INT    0x01
 
 #define INV_MPU6050_REG_USER_CTRL           0x6A
@@ -190,7 +191,6 @@ struct inv_mpu6050_state {
 
 #define INV_MPU6050_BYTES_PER_3AXIS_SENSOR   6
 #define INV_MPU6050_FIFO_COUNT_BYTE          2
-#define INV_MPU6050_FIFO_THRESHOLD           500
 
 /* mpu6500 registers */
 #define INV_MPU6500_REG_ACCEL_CONFIG_2      0x1D
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 7724888..7a4aaed 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -110,6 +110,9 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 			"failed to ack interrupt\n");
 		goto flush_fifo;
 	}
+	/* handle fifo overflow by reseting fifo */
+	if (int_status & INV_MPU6050_BIT_FIFO_OVERFLOW_INT)
+		goto flush_fifo;
 	if (!(int_status & INV_MPU6050_BIT_RAW_DATA_RDY_INT)) {
 		dev_warn(regmap_get_device(st->map),
 			"spurious interrupt with status 0x%x\n", int_status);
@@ -135,8 +138,6 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	if (result)
 		goto end_session;
 	fifo_count = get_unaligned_be16(&data[0]);
-	if (fifo_count >  INV_MPU6050_FIFO_THRESHOLD)
-		goto flush_fifo;
 	/* compute and process all complete datum */
 	nb = fifo_count / bytes_per_datum;
 	for (i = 0; i < nb; ++i) {
-- 
2.7.4

