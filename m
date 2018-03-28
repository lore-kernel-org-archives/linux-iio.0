Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bn3nam01on0084.outbound.protection.outlook.com ([104.47.33.84]:10537
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752176AbeC1A1c (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 27 Mar 2018 20:27:32 -0400
From: Martin Kelly <mkelly@xevo.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>,
        Martin Kelly <mkelly@xevo.com>
Subject: [PATCH v2] imu: inv_mpu6050: interpolate missing timestamps
Date: Tue, 27 Mar 2018 17:27:11 -0700
Message-Id: <20180328002711.26896-1-mkelly@xevo.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

When interrupts are generated at a slower rate than the FIFO fills up,
we will have fewer timestamps than samples. Currently, we fill in 0 for
any unmatched timestamps. However, this is very confusing for userspace,
which does not expect discontinuities in timestamps and must somehow
work around the issue.

Improve the situation by interpolating timestamps when we can't map them
1:1 to data. We do this by assuming the timestamps we have are the most
recent and interpolating backwards to fill the older data. This makes
sense because inv_mpu6050_read_fifo gets called right after an interrupt
is generated, presumably when a datum was generated, so the most recent
timestamp matches up with the most recent datum. In addition, this
assumption is borne out by observation, which shows monotonically
increasing timestamps when interpolating this way but discontinuities
when interpolating in the other direction.

Although this method is not perfectly accurate, it is probably the best
we can do if we don't get one interrupt per datum.

Signed-off-by: Martin Kelly <mkelly@xevo.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |  2 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  2 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 40 +++++++++++++++++++++++++++---
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 7d64be353403..4a95ff8df3b9 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -83,6 +83,7 @@ static const struct inv_mpu6050_chip_config chip_config_6050 = {
 	.fsr = INV_MPU6050_FSR_2000DPS,
 	.lpf = INV_MPU6050_FILTER_20HZ,
 	.fifo_rate = INV_MPU6050_INIT_FIFO_RATE,
+	.fifo_period = NSEC_PER_SEC / INV_MPU6050_INIT_FIFO_RATE,
 	.gyro_fifo_enable = false,
 	.accl_fifo_enable = false,
 	.accl_fs = INV_MPU6050_FS_02G,
@@ -630,6 +631,7 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
 	if (result)
 		goto fifo_rate_fail_power_off;
 	st->chip_config.fifo_rate = fifo_rate;
+	st->chip_config.fifo_period = NSEC_PER_SEC / fifo_rate;
 
 	result = inv_mpu6050_set_lpf(st, fifo_rate);
 	if (result)
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index 065794162d65..3bc7d62822ca 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -86,6 +86,7 @@ enum inv_devices {
  *  @accl_fifo_enable:	enable accel data output
  *  @gyro_fifo_enable:	enable gyro data output
  *  @fifo_rate:		FIFO update rate.
+ *  @fifo_period:	FIFO update period, in nanoseconds.
  */
 struct inv_mpu6050_chip_config {
 	unsigned int fsr:2;
@@ -94,6 +95,7 @@ struct inv_mpu6050_chip_config {
 	unsigned int accl_fifo_enable:1;
 	unsigned int gyro_fifo_enable:1;
 	u16 fifo_rate;
+	u32 fifo_period;
 };
 
 /**
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index ff81c6aa009d..759844f9d8e6 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -126,7 +126,11 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	int result;
 	u8 data[INV_MPU6050_OUTPUT_DATA_SIZE];
 	u16 fifo_count;
+	u16 fifo_items;
+	s32 fifo_diff;
 	s64 timestamp;
+	s64 timestamp_interp;
+	s64 offset;
 
 	mutex_lock(&st->lock);
 	if (!(st->chip_config.accl_fifo_enable |
@@ -156,9 +160,25 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	if (fifo_count >  INV_MPU6050_FIFO_THRESHOLD)
 		goto flush_fifo;
 	/* Timestamp mismatch. */
+	fifo_items = fifo_count / bytes_per_datum;
 	if (kfifo_len(&st->timestamps) >
-	    fifo_count / bytes_per_datum + INV_MPU6050_TIME_STAMP_TOR)
+	    fifo_items + INV_MPU6050_TIME_STAMP_TOR)
 		goto flush_fifo;
+
+	/*
+	 * If we have more data than timestamps, the timestamps we have
+	 * correspond to the newest items in the FIFO, since some data was
+	 * generated without a corresponding interrupt and thus timestamp. Since
+	 * we remove FIFO items oldest to newest, we need to interpolate the
+	 * older timestamps based on the number of missing timestamps.
+	 */
+	fifo_diff = fifo_items - kfifo_len(&st->timestamps);
+	if (fifo_diff > 0)
+		offset = st->chip_config.fifo_period * fifo_diff;
+	else
+		offset = 0;
+
+	timestamp_interp = 0;
 	while (fifo_count >= bytes_per_datum) {
 		result = regmap_bulk_read(st->map, st->reg->fifo_r_w,
 					  data, bytes_per_datum);
@@ -166,9 +186,23 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 			goto flush_fifo;
 
 		result = kfifo_out(&st->timestamps, &timestamp, 1);
-		/* when there is no timestamp, put timestamp as 0 */
+		/* When there is no timestamp, interpolate based on period */
 		if (result == 0)
-			timestamp = 0;
+			/*
+			 * We have no more timestamps left, so interpolate the
+			 * rest of them.
+			 */
+			timestamp = timestamp_interp;
+		else {
+			/*
+			 * If we are interpolating, this is an older datum with
+			 * a newer timestamp, so offset it backwards to account
+			 * for the time gap.  Otherwise, offset will be 0.
+			 */
+			timestamp -= offset;
+			timestamp_interp = timestamp;
+		}
+		timestamp_interp += st->chip_config.fifo_period;
 
 		result = iio_push_to_buffers_with_timestamp(indio_dev, data,
 							    timestamp);
-- 
2.11.0

