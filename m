Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bl2nam02on0050.outbound.protection.outlook.com ([104.47.38.50]:38077
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751196AbeEVOSq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 22 May 2018 10:18:46 -0400
From: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To: linux-iio@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v2 1/5] iio: imu: inv_mpu6050: replace timestamp fifo by generic timestamp
Date: Tue, 22 May 2018 16:18:18 +0200
Message-Id: <20180522141822.11598-1-jmaneyrol@invensense.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Using a fifo for storing timestamps is useless since the interrupt
is in one-shot mode, preventing the hard irq handler to be called
when the irq thread is running. Instead use the generic timestamp
function iio_pollfunc_store_time.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |  6 +--
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  | 10 -----
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 44 +---------------------
 3 files changed, 2 insertions(+), 58 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 43fba5f7532b..1e7e750294fc 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -20,8 +20,6 @@
 #include <linux/jiffies.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
-#include <linux/kfifo.h>
-#include <linux/spinlock.h>
 #include <linux/iio/iio.h>
 #include <linux/acpi.h>
 #include <linux/platform_device.h>
@@ -996,7 +994,7 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 	indio_dev->modes = INDIO_BUFFER_TRIGGERED;
 
 	result = devm_iio_triggered_buffer_setup(dev, indio_dev,
-						 inv_mpu6050_irq_handler,
+						 iio_pollfunc_store_time,
 						 inv_mpu6050_read_fifo,
 						 NULL);
 	if (result) {
@@ -1009,8 +1007,6 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		return result;
 	}
 
-	INIT_KFIFO(st->timestamps);
-	spin_lock_init(&st->time_stamp_lock);
 	result = devm_iio_device_register(dev, indio_dev);
 	if (result) {
 		dev_err(dev, "IIO register fail %d\n", result);
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index c54da777945d..a92ddd45586c 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -12,8 +12,6 @@
 */
 #include <linux/i2c.h>
 #include <linux/i2c-mux.h>
-#include <linux/kfifo.h>
-#include <linux/spinlock.h>
 #include <linux/mutex.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
@@ -116,36 +114,30 @@ struct inv_mpu6050_hw {
 
 /*
  *  struct inv_mpu6050_state - Driver state variables.
- *  @TIMESTAMP_FIFO_SIZE: fifo size for timestamp.
  *  @lock:              Chip access lock.
  *  @trig:              IIO trigger.
  *  @chip_config:	Cached attribute information.
  *  @reg:		Map of important registers.
  *  @hw:		Other hardware-specific information.
  *  @chip_type:		chip type.
- *  @time_stamp_lock:	spin lock to time stamp.
  *  @plat_data:		platform data (deprecated in favor of @orientation).
  *  @orientation:	sensor chip orientation relative to main hardware.
- *  @timestamps:        kfifo queue to store time stamp.
  *  @map		regmap pointer.
  *  @irq		interrupt number.
  *  @irq_mask		the int_pin_cfg mask to configure interrupt type.
  */
 struct inv_mpu6050_state {
-#define TIMESTAMP_FIFO_SIZE 16
 	struct mutex lock;
 	struct iio_trigger  *trig;
 	struct inv_mpu6050_chip_config chip_config;
 	const struct inv_mpu6050_reg_map *reg;
 	const struct inv_mpu6050_hw *hw;
 	enum   inv_devices chip_type;
-	spinlock_t time_stamp_lock;
 	struct i2c_mux_core *muxc;
 	struct i2c_client *mux_client;
 	unsigned int powerup_count;
 	struct inv_mpu6050_platform_data plat_data;
 	struct iio_mount_matrix orientation;
-	DECLARE_KFIFO(timestamps, long long, TIMESTAMP_FIFO_SIZE);
 	struct regmap *map;
 	int irq;
 	u8 irq_mask;
@@ -234,7 +226,6 @@ struct inv_mpu6050_state {
 
 /* init parameters */
 #define INV_MPU6050_INIT_FIFO_RATE           50
-#define INV_MPU6050_TIME_STAMP_TOR           5
 #define INV_MPU6050_MAX_FIFO_RATE            1000
 #define INV_MPU6050_MIN_FIFO_RATE            4
 #define INV_MPU6050_ONE_K_HZ                 1000
@@ -300,7 +291,6 @@ enum inv_mpu6050_clock_sel_e {
 	NUM_CLK
 };
 
-irqreturn_t inv_mpu6050_irq_handler(int irq, void *p);
 irqreturn_t inv_mpu6050_read_fifo(int irq, void *p);
 int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev, int irq_type);
 int inv_reset_fifo(struct iio_dev *indio_dev);
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 1795418438e4..5436d181f2dc 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -19,20 +19,9 @@
 #include <linux/jiffies.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
-#include <linux/kfifo.h>
 #include <linux/poll.h>
 #include "inv_mpu_iio.h"
 
-static void inv_clear_kfifo(struct inv_mpu6050_state *st)
-{
-	unsigned long flags;
-
-	/* take the spin lock sem to avoid interrupt kick in */
-	spin_lock_irqsave(&st->time_stamp_lock, flags);
-	kfifo_reset(&st->timestamps);
-	spin_unlock_irqrestore(&st->time_stamp_lock, flags);
-}
-
 int inv_reset_fifo(struct iio_dev *indio_dev)
 {
 	int result;
@@ -62,9 +51,6 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
 	if (result)
 		goto reset_fifo_fail;
 
-	/* clear timestamps fifo */
-	inv_clear_kfifo(st);
-
 	/* enable interrupt */
 	if (st->chip_config.accl_fifo_enable ||
 	    st->chip_config.gyro_fifo_enable) {
@@ -98,23 +84,6 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
 	return result;
 }
 
-/**
- * inv_mpu6050_irq_handler() - Cache a timestamp at each data ready interrupt.
- */
-irqreturn_t inv_mpu6050_irq_handler(int irq, void *p)
-{
-	struct iio_poll_func *pf = p;
-	struct iio_dev *indio_dev = pf->indio_dev;
-	struct inv_mpu6050_state *st = iio_priv(indio_dev);
-	s64 timestamp;
-
-	timestamp = iio_get_time_ns(indio_dev);
-	kfifo_in_spinlocked(&st->timestamps, &timestamp, 1,
-			    &st->time_stamp_lock);
-
-	return IRQ_WAKE_THREAD;
-}
-
 /**
  * inv_mpu6050_read_fifo() - Transfer data from hardware FIFO to KFIFO.
  */
@@ -127,7 +96,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	int result;
 	u8 data[INV_MPU6050_OUTPUT_DATA_SIZE];
 	u16 fifo_count;
-	s64 timestamp;
+	s64 timestamp = pf->timestamp;
 	int int_status;
 
 	mutex_lock(&st->lock);
@@ -171,28 +140,17 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 		goto flush_fifo;
 	if (fifo_count >  INV_MPU6050_FIFO_THRESHOLD)
 		goto flush_fifo;
-	/* Timestamp mismatch. */
-	if (kfifo_len(&st->timestamps) >
-	    fifo_count / bytes_per_datum + INV_MPU6050_TIME_STAMP_TOR)
-		goto flush_fifo;
 	do {
 		result = regmap_bulk_read(st->map, st->reg->fifo_r_w,
 					  data, bytes_per_datum);
 		if (result)
 			goto flush_fifo;
-
-		result = kfifo_out(&st->timestamps, &timestamp, 1);
-		/* when there is no timestamp, put timestamp as 0 */
-		if (result == 0)
-			timestamp = 0;
-
 		/* skip first samples if needed */
 		if (st->skip_samples)
 			st->skip_samples--;
 		else
 			iio_push_to_buffers_with_timestamp(indio_dev, data,
 							   timestamp);
-
 		fifo_count -= bytes_per_datum;
 	} while (fifo_count >= bytes_per_datum);
 
-- 
2.17.0

