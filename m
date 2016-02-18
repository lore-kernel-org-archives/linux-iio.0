Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32180 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1426605AbcBRPvY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 18 Feb 2016 10:51:24 -0500
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	wsa@the-dreams.de, linux-i2c@vger.kernel.org,
	lucas.demarchi@intel.com, daniel.baluta@intel.com,
	srinivas.pandruvada@linux.intel.com, ggao@invensense.com,
	adi.reus@gmail.com, cmo@melexis.com, mwelling@ieee.org
Subject: [RFC PATCH 7/9] iio: imu: inv_mpu6050: Fix alignment with open parenthesis
Date: Thu, 18 Feb 2016 17:53:12 +0200
Message-Id: <1455810794-3188-8-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1455810794-3188-1-git-send-email-daniel.baluta@intel.com>
References: <1455810794-3188-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This makes code consistent around inv_mpu6050 driver and
fixes the following checkpatch.pl warning:
CHECK: Alignment should match open parenthesis

Note that there were few cases were it was not possible to
fix this due to making the line too long, but we can live with that.

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 55 +++++++++++++--------------
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     |  2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 17 ++++-----
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 22 +++++------
 4 files changed, 47 insertions(+), 49 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 48ab575..1643cd2 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -121,7 +121,7 @@ int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask)
 			/* switch internal clock to PLL */
 			mgmt_1 |= INV_CLK_PLL;
 			result = regmap_write(st->map,
-					st->reg->pwr_mgmt_1, mgmt_1);
+					      st->reg->pwr_mgmt_1, mgmt_1);
 			if (result)
 				return result;
 		}
@@ -196,14 +196,14 @@ static int inv_mpu6050_init_config(struct iio_dev *indio_dev)
 		return result;
 
 	memcpy(&st->chip_config, hw_info[st->chip_type].config,
-		sizeof(struct inv_mpu6050_chip_config));
+	       sizeof(struct inv_mpu6050_chip_config));
 	result = inv_mpu6050_set_power_itg(st, false);
 
 	return result;
 }
 
 static int inv_mpu6050_sensor_show(struct inv_mpu6050_state  *st, int reg,
-				int axis, int *val)
+				   int axis, int *val)
 {
 	int ind, result;
 	__be16 d;
@@ -217,11 +217,10 @@ static int inv_mpu6050_sensor_show(struct inv_mpu6050_state  *st, int reg,
 	return IIO_VAL_INT;
 }
 
-static int inv_mpu6050_read_raw(struct iio_dev *indio_dev,
-			      struct iio_chan_spec const *chan,
-			      int *val,
-			      int *val2,
-			      long mask) {
+static int
+inv_mpu6050_read_raw(struct iio_dev *indio_dev,
+		     struct iio_chan_spec const *chan,
+		     int *val, int *val2, long mask) {
 	struct inv_mpu6050_state  *st = iio_priv(indio_dev);
 
 	switch (mask) {
@@ -241,16 +240,16 @@ static int inv_mpu6050_read_raw(struct iio_dev *indio_dev,
 		switch (chan->type) {
 		case IIO_ANGL_VEL:
 			if (!st->chip_config.gyro_fifo_enable ||
-					!st->chip_config.enable) {
+			    !st->chip_config.enable) {
 				result = inv_mpu6050_switch_engine(st, true,
 						INV_MPU6050_BIT_PWR_GYRO_STBY);
 				if (result)
 					goto error_read_raw;
 			}
 			ret =  inv_mpu6050_sensor_show(st, st->reg->raw_gyro,
-						chan->channel2, val);
+						       chan->channel2, val);
 			if (!st->chip_config.gyro_fifo_enable ||
-					!st->chip_config.enable) {
+			    !st->chip_config.enable) {
 				result = inv_mpu6050_switch_engine(st, false,
 						INV_MPU6050_BIT_PWR_GYRO_STBY);
 				if (result)
@@ -259,16 +258,16 @@ static int inv_mpu6050_read_raw(struct iio_dev *indio_dev,
 			break;
 		case IIO_ACCEL:
 			if (!st->chip_config.accl_fifo_enable ||
-					!st->chip_config.enable) {
+			    !st->chip_config.enable) {
 				result = inv_mpu6050_switch_engine(st, true,
 						INV_MPU6050_BIT_PWR_ACCL_STBY);
 				if (result)
 					goto error_read_raw;
 			}
 			ret = inv_mpu6050_sensor_show(st, st->reg->raw_accl,
-						chan->channel2, val);
+						      chan->channel2, val);
 			if (!st->chip_config.accl_fifo_enable ||
-					!st->chip_config.enable) {
+			    !st->chip_config.enable) {
 				result = inv_mpu6050_switch_engine(st, false,
 						INV_MPU6050_BIT_PWR_ACCL_STBY);
 				if (result)
@@ -279,7 +278,7 @@ static int inv_mpu6050_read_raw(struct iio_dev *indio_dev,
 			/* wait for stablization */
 			msleep(INV_MPU6050_SENSOR_UP_TIME);
 			inv_mpu6050_sensor_show(st, st->reg->temperature,
-							IIO_MOD_X, val);
+						IIO_MOD_X, val);
 			break;
 		default:
 			ret = -EINVAL;
@@ -387,10 +386,8 @@ static int inv_mpu6050_write_accel_scale(struct inv_mpu6050_state *st, int val)
 }
 
 static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
-			       struct iio_chan_spec const *chan,
-			       int val,
-			       int val2,
-			       long mask) {
+				 struct iio_chan_spec const *chan,
+				 int val, int val2, long mask) {
 	struct inv_mpu6050_state  *st = iio_priv(indio_dev);
 	int result;
 
@@ -467,8 +464,9 @@ static int inv_mpu6050_set_lpf(struct inv_mpu6050_state *st, int rate)
 /**
  * inv_mpu6050_fifo_rate_store() - Set fifo rate.
  */
-static ssize_t inv_mpu6050_fifo_rate_store(struct device *dev,
-	struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t
+inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
 {
 	s32 fifo_rate;
 	u8 d;
@@ -479,7 +477,7 @@ static ssize_t inv_mpu6050_fifo_rate_store(struct device *dev,
 	if (kstrtoint(buf, 10, &fifo_rate))
 		return -EINVAL;
 	if (fifo_rate < INV_MPU6050_MIN_FIFO_RATE ||
-				fifo_rate > INV_MPU6050_MAX_FIFO_RATE)
+	    fifo_rate > INV_MPU6050_MAX_FIFO_RATE)
 		return -EINVAL;
 	if (fifo_rate == st->chip_config.fifo_rate)
 		return count;
@@ -515,8 +513,9 @@ fifo_rate_fail:
 /**
  * inv_fifo_rate_show() - Get the current sampling rate.
  */
-static ssize_t inv_fifo_rate_show(struct device *dev,
-	struct device_attribute *attr, char *buf)
+static ssize_t
+inv_fifo_rate_show(struct device *dev, struct device_attribute *attr,
+		   char *buf)
 {
 	struct inv_mpu6050_state *st = iio_priv(dev_to_iio_dev(dev));
 
@@ -527,8 +526,8 @@ static ssize_t inv_fifo_rate_show(struct device *dev,
  * inv_attr_show() - calling this function will show current
  *                    parameters.
  */
-static ssize_t inv_attr_show(struct device *dev,
-	struct device_attribute *attr, char *buf)
+static ssize_t inv_attr_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
 {
 	struct inv_mpu6050_state *st = iio_priv(dev_to_iio_dev(dev));
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
@@ -676,11 +675,11 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
 		return result;
 
 	result = inv_mpu6050_switch_engine(st, false,
-					INV_MPU6050_BIT_PWR_ACCL_STBY);
+					   INV_MPU6050_BIT_PWR_ACCL_STBY);
 	if (result)
 		return result;
 	result = inv_mpu6050_switch_engine(st, false,
-					INV_MPU6050_BIT_PWR_GYRO_STBY);
+					   INV_MPU6050_BIT_PWR_GYRO_STBY);
 	if (result)
 		return result;
 
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index af400dd..71bdaa3 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -111,7 +111,7 @@ static int inv_mpu6050_deselect_bypass(struct i2c_adapter *adap,
  *  Returns 0 on success, a negative error code otherwise.
  */
 static int inv_mpu_probe(struct i2c_client *client,
-	const struct i2c_device_id *id)
+			 const struct i2c_device_id *id)
 {
 	struct inv_mpu6050_state *st;
 	int result;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 0bc5091..d070062 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -57,7 +57,7 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
 
 	/* reset FIFO*/
 	result = regmap_write(st->map, st->reg->user_ctrl,
-					INV_MPU6050_BIT_FIFO_RST);
+			      INV_MPU6050_BIT_FIFO_RST);
 	if (result)
 		goto reset_fifo_fail;
 
@@ -68,13 +68,13 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
 	if (st->chip_config.accl_fifo_enable ||
 	    st->chip_config.gyro_fifo_enable) {
 		result = regmap_write(st->map, st->reg->int_enable,
-					INV_MPU6050_BIT_DATA_RDY_EN);
+				      INV_MPU6050_BIT_DATA_RDY_EN);
 		if (result)
 			return result;
 	}
 	/* enable FIFO reading and I2C master interface*/
 	result = regmap_write(st->map, st->reg->user_ctrl,
-					INV_MPU6050_BIT_FIFO_EN);
+			      INV_MPU6050_BIT_FIFO_EN);
 	if (result)
 		goto reset_fifo_fail;
 	/* enable sensor output to FIFO */
@@ -92,7 +92,7 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
 reset_fifo_fail:
 	dev_err(regmap_get_device(st->map), "reset fifo failed %d\n", result);
 	result = regmap_write(st->map, st->reg->int_enable,
-					INV_MPU6050_BIT_DATA_RDY_EN);
+			      INV_MPU6050_BIT_DATA_RDY_EN);
 
 	return result;
 }
@@ -109,7 +109,7 @@ irqreturn_t inv_mpu6050_irq_handler(int irq, void *p)
 
 	timestamp = iio_get_time_ns();
 	kfifo_in_spinlocked(&st->timestamps, &timestamp, 1,
-				&st->time_stamp_lock);
+			    &st->time_stamp_lock);
 
 	return IRQ_WAKE_THREAD;
 }
@@ -143,9 +143,8 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	 * read fifo_count register to know how many bytes inside FIFO
 	 * right now
 	 */
-	result = regmap_bulk_read(st->map,
-				       st->reg->fifo_count_h,
-				       data, INV_MPU6050_FIFO_COUNT_BYTE);
+	result = regmap_bulk_read(st->map, st->reg->fifo_count_h, data,
+				  INV_MPU6050_FIFO_COUNT_BYTE);
 	if (result)
 		goto end_session;
 	fifo_count = be16_to_cpup((__be16 *)(&data[0]));
@@ -172,7 +171,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 			timestamp = 0;
 
 		result = iio_push_to_buffers_with_timestamp(indio_dev, data,
-			timestamp);
+							    timestamp);
 		if (result)
 			goto flush_fifo;
 		fifo_count -= bytes_per_datum;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index 72d6aae..e8818d4 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -19,19 +19,19 @@ static void inv_scan_query(struct iio_dev *indio_dev)
 
 	st->chip_config.gyro_fifo_enable =
 		test_bit(INV_MPU6050_SCAN_GYRO_X,
-			indio_dev->active_scan_mask) ||
-			test_bit(INV_MPU6050_SCAN_GYRO_Y,
-			indio_dev->active_scan_mask) ||
-			test_bit(INV_MPU6050_SCAN_GYRO_Z,
-			indio_dev->active_scan_mask);
+			 indio_dev->active_scan_mask) ||
+		test_bit(INV_MPU6050_SCAN_GYRO_Y,
+			 indio_dev->active_scan_mask) ||
+		test_bit(INV_MPU6050_SCAN_GYRO_Z,
+			 indio_dev->active_scan_mask);
 
 	st->chip_config.accl_fifo_enable =
 		test_bit(INV_MPU6050_SCAN_ACCL_X,
-			indio_dev->active_scan_mask) ||
-			test_bit(INV_MPU6050_SCAN_ACCL_Y,
-			indio_dev->active_scan_mask) ||
-			test_bit(INV_MPU6050_SCAN_ACCL_Z,
-			indio_dev->active_scan_mask);
+			 indio_dev->active_scan_mask) ||
+		test_bit(INV_MPU6050_SCAN_ACCL_Y,
+			 indio_dev->active_scan_mask) ||
+		test_bit(INV_MPU6050_SCAN_ACCL_Z,
+			 indio_dev->active_scan_mask);
 }
 
 /**
@@ -101,7 +101,7 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
  * @state: Desired trigger state
  */
 static int inv_mpu_data_rdy_trigger_set_state(struct iio_trigger *trig,
-						bool state)
+					      bool state)
 {
 	return inv_mpu6050_set_enable(iio_trigger_get_drvdata(trig), state);
 }
-- 
2.5.0

