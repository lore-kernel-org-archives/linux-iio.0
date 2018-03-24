Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bn3nam01on0040.outbound.protection.outlook.com ([104.47.33.40]:55072
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751793AbeCXAC5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 23 Mar 2018 20:02:57 -0400
From: Martin Kelly <mkelly@xevo.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>,
        Martin Kelly <mkelly@xevo.com>
Subject: [PATCH] iio: imu: inv_mpu6050: improve missing timestamp handling
Date: Fri, 23 Mar 2018 17:02:40 -0700
Message-Id: <20180324000240.19519-1-mkelly@xevo.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

When interrupts are generated at a slower rate than the FIFO queue fills
up, we will have fewer timestamps than samples. Currently, we fill in 0
for any unmatched timestamps. However, this is very confusing for
userspace, which does not expect discontinuities in timestamps and
must somehow work around the issue.

Improve the situation by using the most recent timestamp when a
timestamp is missing. Although this guess is not perfectly accurate, it
is still close to the correct timestamp and won't result in the
confusion caused by using 0.

Signed-off-by: Martin Kelly <mkelly@xevo.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index ff81c6aa009d..a982037d5dad 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -126,6 +126,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	int result;
 	u8 data[INV_MPU6050_OUTPUT_DATA_SIZE];
 	u16 fifo_count;
+	s64 last_timestamp;
 	s64 timestamp;
 
 	mutex_lock(&st->lock);
@@ -159,6 +160,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	if (kfifo_len(&st->timestamps) >
 	    fifo_count / bytes_per_datum + INV_MPU6050_TIME_STAMP_TOR)
 		goto flush_fifo;
+	last_timestamp = 0;
 	while (fifo_count >= bytes_per_datum) {
 		result = regmap_bulk_read(st->map, st->reg->fifo_r_w,
 					  data, bytes_per_datum);
@@ -166,9 +168,11 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 			goto flush_fifo;
 
 		result = kfifo_out(&st->timestamps, &timestamp, 1);
-		/* when there is no timestamp, put timestamp as 0 */
+		/* when there is no timestamp, just use the last one we saw */
 		if (result == 0)
-			timestamp = 0;
+			timestamp = last_timestamp;
+		else
+			last_timestamp = timestamp;
 
 		result = iio_push_to_buffers_with_timestamp(indio_dev, data,
 							    timestamp);
-- 
2.11.0

