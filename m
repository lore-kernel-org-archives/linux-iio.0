Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:18601 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753262AbcEZM2L (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 26 May 2016 08:28:11 -0400
From: Doru Gucea <doru.gucea@intel.com>
To: jic23@kernel.org, leonard.crestez@intel.com
Cc: daniel.baluta@intel.com, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, lucas.demarchi@intel.com, cmo@melexis.com,
	linux-iio@vger.kernel.org, Doru Gucea <doru.gucea@intel.com>
Subject: [PATCH] iio: imu: inv_mpu6050: Support software triggers
Date: Thu, 26 May 2016 15:23:34 +0300
Message-Id: <1464265414-8395-1-git-send-email-doru.gucea@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

In order to support software triggers (e.g.: hr-based trigger) the
operations from trigger enable/disable are moved to buffer enable/
disable.

This also allows us to remove the mutex from inv_mpu6050_read_fifo:
inv_reset_fifo can't access in parallel shared fields because the
buffers must be enabled prior to reading data.

A benefit of removing the mutex is that we avoid a deadlock at
buffer wqdisable time. The scenario was the following:
(1) at buffer disable time the indio_dev->mlock is acquired
(2) free_irq is called and waits for IRQs completion
(3) inv_mpu6050_read_fifo tries to acquire the indio_dev->mlock

Signed-off-by: Doru Gucea <doru.gucea@intel.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 63 ++++++++++++++++-----------
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  1 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 20 ---------
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 16 ++++---
 4 files changed, 48 insertions(+), 52 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 2258600..3ce877b 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -542,26 +542,6 @@ static ssize_t inv_attr_show(struct device *dev,
 	}
 }
 
-/**
- * inv_mpu6050_validate_trigger() - validate_trigger callback for invensense
- *                                  MPU6050 device.
- * @indio_dev: The IIO device
- * @trig: The new trigger
- *
- * Returns: 0 if the 'trig' matches the trigger registered by the MPU6050
- * device, -EINVAL otherwise.
- */
-static int inv_mpu6050_validate_trigger(struct iio_dev *indio_dev,
-					struct iio_trigger *trig)
-{
-	struct inv_mpu6050_state *st = iio_priv(indio_dev);
-
-	if (st->trig != trig)
-		return -EINVAL;
-
-	return 0;
-}
-
 #define INV_MPU6050_CHAN(_type, _channel2, _index)                    \
 	{                                                             \
 		.type = _type,                                        \
@@ -634,7 +614,35 @@ static const struct iio_info mpu_info = {
 	.write_raw = &inv_mpu6050_write_raw,
 	.write_raw_get_fmt = &inv_write_raw_get_fmt,
 	.attrs = &inv_attribute_group,
-	.validate_trigger = inv_mpu6050_validate_trigger,
+};
+
+static int mpu6050_buffer_postenable(struct iio_dev *indio_dev)
+{
+	int result;
+
+	result = inv_mpu6050_set_enable(indio_dev, true);
+
+	if (result)
+		return result;
+
+	return iio_triggered_buffer_postenable(indio_dev);
+}
+
+static int mpu6050_buffer_predisable(struct iio_dev *indio_dev)
+{
+	int result;
+
+	result = inv_mpu6050_set_enable(indio_dev, false);
+
+	if (result)
+		return result;
+
+	return iio_triggered_buffer_predisable(indio_dev);
+}
+
+const struct iio_buffer_setup_ops mpu6050_buffer_ops = {
+	.postenable = &mpu6050_buffer_postenable,
+	.predisable = &mpu6050_buffer_predisable,
 };
 
 /**
@@ -727,15 +735,18 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 	result = iio_triggered_buffer_setup(indio_dev,
 					    inv_mpu6050_irq_handler,
 					    inv_mpu6050_read_fifo,
-					    NULL);
+					    &mpu6050_buffer_ops);
 	if (result) {
 		dev_err(dev, "configure buffer fail %d\n", result);
 		return result;
 	}
-	result = inv_mpu6050_probe_trigger(indio_dev);
-	if (result) {
-		dev_err(dev, "trigger probe fail %d\n", result);
-		goto out_unreg_ring;
+
+	if (st->irq > 0) {
+		result = inv_mpu6050_probe_trigger(indio_dev);
+		if (result) {
+			dev_err(dev, "trigger probe fail %d\n", result);
+			goto out_unreg_ring;
+		}
 	}
 
 	INIT_KFIFO(st->timestamps);
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index fcc2f3d..e9055f9 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -250,6 +250,7 @@ enum inv_mpu6050_clock_sel_e {
 	NUM_CLK
 };
 
+int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable);
 irqreturn_t inv_mpu6050_irq_handler(int irq, void *p);
 irqreturn_t inv_mpu6050_read_fifo(int irq, void *p);
 int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev);
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 1fc5fd9..3ab0033 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -39,13 +39,6 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
 	u8 d;
 	struct inv_mpu6050_state  *st = iio_priv(indio_dev);
 
-	/* disable interrupt */
-	result = regmap_write(st->map, st->reg->int_enable, 0);
-	if (result) {
-		dev_err(regmap_get_device(st->map), "int_enable failed %d\n",
-			result);
-		return result;
-	}
 	/* disable the sensor output to FIFO */
 	result = regmap_write(st->map, st->reg->fifo_en, 0);
 	if (result)
@@ -64,14 +57,6 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
 	/* clear timestamps fifo */
 	inv_clear_kfifo(st);
 
-	/* enable interrupt */
-	if (st->chip_config.accl_fifo_enable ||
-	    st->chip_config.gyro_fifo_enable) {
-		result = regmap_write(st->map, st->reg->int_enable,
-					INV_MPU6050_BIT_DATA_RDY_EN);
-		if (result)
-			return result;
-	}
 	/* enable FIFO reading and I2C master interface*/
 	result = regmap_write(st->map, st->reg->user_ctrl,
 					INV_MPU6050_BIT_FIFO_EN);
@@ -91,8 +76,6 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
 
 reset_fifo_fail:
 	dev_err(regmap_get_device(st->map), "reset fifo failed %d\n", result);
-	result = regmap_write(st->map, st->reg->int_enable,
-					INV_MPU6050_BIT_DATA_RDY_EN);
 
 	return result;
 }
@@ -128,7 +111,6 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	u16 fifo_count;
 	s64 timestamp;
 
-	mutex_lock(&indio_dev->mlock);
 	if (!(st->chip_config.accl_fifo_enable |
 		st->chip_config.gyro_fifo_enable))
 		goto end_session;
@@ -179,7 +161,6 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	}
 
 end_session:
-	mutex_unlock(&indio_dev->mlock);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
@@ -187,7 +168,6 @@ end_session:
 flush_fifo:
 	/* Flush HW and SW FIFOs. */
 	inv_reset_fifo(indio_dev);
-	mutex_unlock(&indio_dev->mlock);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index 72d6aae..57f6623 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -39,7 +39,7 @@ static void inv_scan_query(struct iio_dev *indio_dev)
  *  @indio_dev:	Device driver instance.
  *  @enable: enable/disable
  */
-static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
+int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
 {
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
 	int result;
@@ -69,10 +69,6 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
 		if (result)
 			return result;
 
-		result = regmap_write(st->map, st->reg->int_enable, 0);
-		if (result)
-			return result;
-
 		result = regmap_write(st->map, st->reg->user_ctrl, 0);
 		if (result)
 			return result;
@@ -103,7 +99,15 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
 static int inv_mpu_data_rdy_trigger_set_state(struct iio_trigger *trig,
 						bool state)
 {
-	return inv_mpu6050_set_enable(iio_trigger_get_drvdata(trig), state);
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+
+	if (state && (st->chip_config.accl_fifo_enable ||
+	    st->chip_config.gyro_fifo_enable))
+		return regmap_write(st->map, st->reg->int_enable,
+				    INV_MPU6050_BIT_DATA_RDY_EN);
+	else
+		return regmap_write(st->map, st->reg->int_enable, 0);
 }
 
 static const struct iio_trigger_ops inv_mpu_trigger_ops = {
-- 
1.9.1

