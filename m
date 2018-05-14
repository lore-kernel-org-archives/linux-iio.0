Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-cys01nam02on0069.outbound.protection.outlook.com ([104.47.37.69]:21440
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752136AbeENVG1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 14 May 2018 17:06:27 -0400
From: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To: linux-iio@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 3/5] iio: imu: inv_mpu6050: fix fifo count reading
Date: Mon, 14 May 2018 23:05:53 +0200
Message-Id: <1526331955-11869-3-git-send-email-jmaneyrol@invensense.com>
In-Reply-To: <1526331955-11869-1-git-send-email-jmaneyrol@invensense.com>
References: <1526331955-11869-1-git-send-email-jmaneyrol@invensense.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use unaligned access since buffer is a bytes table. Truncate fifo
count to read only complete datum.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 5436d18..7724888 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -20,6 +20,7 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/poll.h>
+#include <asm/unaligned.h>
 #include "inv_mpu_iio.h"
 
 int inv_reset_fifo(struct iio_dev *indio_dev)
@@ -98,6 +99,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	u16 fifo_count;
 	s64 timestamp = pf->timestamp;
 	int int_status;
+	size_t i, nb;
 
 	mutex_lock(&st->lock);
 
@@ -132,27 +134,23 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 				  INV_MPU6050_FIFO_COUNT_BYTE);
 	if (result)
 		goto end_session;
-	fifo_count = be16_to_cpup((__be16 *)(&data[0]));
-	if (fifo_count < bytes_per_datum)
-		goto end_session;
-	/* fifo count can't be an odd number. If it is odd, reset the FIFO. */
-	if (fifo_count & 1)
-		goto flush_fifo;
+	fifo_count = get_unaligned_be16(&data[0]);
 	if (fifo_count >  INV_MPU6050_FIFO_THRESHOLD)
 		goto flush_fifo;
-	do {
+	/* compute and process all complete datum */
+	nb = fifo_count / bytes_per_datum;
+	for (i = 0; i < nb; ++i) {
 		result = regmap_bulk_read(st->map, st->reg->fifo_r_w,
 					  data, bytes_per_datum);
 		if (result)
 			goto flush_fifo;
 		/* skip first samples if needed */
-		if (st->skip_samples)
+		if (st->skip_samples) {
 			st->skip_samples--;
-		else
-			iio_push_to_buffers_with_timestamp(indio_dev, data,
-							   timestamp);
-		fifo_count -= bytes_per_datum;
-	} while (fifo_count >= bytes_per_datum);
+			continue;
+		}
+		iio_push_to_buffers_with_timestamp(indio_dev, data, timestamp);
+	}
 
 end_session:
 	mutex_unlock(&st->lock);
-- 
2.7.4

