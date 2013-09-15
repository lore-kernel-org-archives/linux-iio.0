Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-015.synserver.de ([212.40.185.15]:1089 "EHLO
	smtp-out-015.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757143Ab3IOQuW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2013 12:50:22 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Ge Gao <ggao@invensense.com>
Subject: [PATCH 18/27] iio:mpu6050: Use iio_push_to_buffers_with_timestamp()
Date: Sun, 15 Sep 2013 18:51:11 +0200
Message-Id: <1379263880-18405-18-git-send-email-lars@metafoo.de>
In-Reply-To: <1379263880-18405-1-git-send-email-lars@metafoo.de>
References: <1379263880-18405-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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

