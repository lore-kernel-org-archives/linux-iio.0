Return-Path: <ggao@invensense.com>
From: Ge GAO <ggao@invensense.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Ge Gao <ggao@invensense.com>
Subject: [PATCH] using kfifo_in_spinlocked instead of separate code.
Date: Mon,  4 Mar 2013 15:27:37 -0800
Message-Id: <1362439657-8691-1-git-send-email-ggao@invensense.com>
List-ID: <linux-iio@vger.kernel.org>

From: Ge Gao <ggao@invensense.com>

---
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 331781f..7da0832 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -105,9 +105,8 @@ irqreturn_t inv_mpu6050_irq_handler(int irq, void *p)
 	s64 timestamp;
 
 	timestamp = iio_get_time_ns();
-	spin_lock(&st->time_stamp_lock);
-	kfifo_in(&st->timestamps, &timestamp, 1);
-	spin_unlock(&st->time_stamp_lock);
+	kfifo_in_spinlocked(&st->timestamps, &timestamp, 1,
+				&st->time_stamp_lock);
 
 	return IRQ_WAKE_THREAD;
 }
-- 
1.7.0.4
