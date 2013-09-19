Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Ge Gao <ggao@invensense.com>
Subject: [PATCH 15/24] iio:mpu6050: Use iio_push_to_buffers_with_timestamp()
Date: Thu, 19 Sep 2013 14:59:52 +0200
Message-Id: <1379595601-26448-15-git-send-email-lars@metafoo.de>
In-Reply-To: <1379595601-26448-1-git-send-email-lars@metafoo.de>
References: <1379595601-26448-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Makes the code a bit shorter and less ugly.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Ge Gao <ggao@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 7da0832..4295171 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -124,7 +124,6 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	u8 data[INV_MPU6050_OUTPUT_DATA_SIZE];
 	u16 fifo_count;
 	s64 timestamp;
-	u64 *tmp;
 
 	mutex_lock(&indio_dev->mlock);
 	if (!(st->chip_config.accl_fifo_enable |
@@ -170,9 +169,8 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 		if (0 == result)
 			timestamp = 0;
 
-		tmp = (u64 *)data;
-		tmp[DIV_ROUND_UP(bytes_per_datum, 8)] = timestamp;
-		result = iio_push_to_buffers(indio_dev, data);
+		result = iio_push_to_buffers_with_timestamp(indio_dev, data,
+			timestamp);
 		if (result)
 			goto flush_fifo;
 		fifo_count -= bytes_per_datum;
-- 
1.8.0
