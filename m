Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-sn1nam01on0050.outbound.protection.outlook.com ([104.47.32.50]:36862
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750955AbdFBQVe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 2 Jun 2017 12:21:34 -0400
From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To: linux-iio <linux-iio@vger.kernel.org>
Subject: [PATCH 1/2] iio: imu: inv_mpu6050: fix lock and error path multiple
  issues
Date: Fri, 2 Jun 2017 16:21:31 +0000
Message-ID: <CY1PR12MB06661CC158DECAFDE14B1597C4F70@CY1PR12MB0666.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

There are several locks issues when using buffer and direct polling
data at the same time. Use our own mutex for managing locking and
block simultaneous use of buffer and direct polling by using
iio_device_{claim/release}_direct_mode. This makes chip_config
enable bit obsolete, so delete it.
Replace sprint by more correct scnprintf.
Fix error code paths, this solves the bug that chaning the sampling
frequency while buffer is on is returning -EBUSY but power off the
chip and block all incoming data.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 152 ++++++++++++++--------=
----
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     |   8 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |   5 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |   6 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  34 ++++--
 5 files changed, 118 insertions(+), 87 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c
index 96dabbd..5a0db5a 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -187,7 +187,6 @@ int inv_mpu6050_set_power_itg(struct inv_mpu6050_state =
*st, bool power_on)
 	int result =3D 0;
=20
 	if (power_on) {
-		/* Already under indio-dev->mlock mutex */
 		if (!st->powerup_count)
 			result =3D regmap_write(st->map, st->reg->pwr_mgmt_1, 0);
 		if (!result)
@@ -289,7 +288,7 @@ static int inv_mpu6050_sensor_show(struct inv_mpu6050_s=
tate  *st, int reg,
 		     struct iio_chan_spec const *chan,
 		     int *val, int *val2, long mask)
 {
-	struct inv_mpu6050_state  *st =3D iio_priv(indio_dev);
+	struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
 	int ret =3D 0;
=20
 	switch (mask) {
@@ -298,50 +297,37 @@ static int inv_mpu6050_sensor_show(struct inv_mpu6050=
_state  *st, int reg,
 		int result;
=20
 		ret =3D IIO_VAL_INT;
-		result =3D 0;
-		mutex_lock(&indio_dev->mlock);
-		if (!st->chip_config.enable) {
-			result =3D inv_mpu6050_set_power_itg(st, true);
-			if (result)
-				goto error_read_raw;
-		}
-		/* when enable is on, power is already on */
+		mutex_lock(&st->lock);
+		result =3D iio_device_claim_direct_mode(indio_dev);
+		if (result)
+			goto error_read_raw_unlock;
+		result =3D inv_mpu6050_set_power_itg(st, true);
+		if (result)
+			goto error_read_raw_release;
 		switch (chan->type) {
 		case IIO_ANGL_VEL:
-			if (!st->chip_config.gyro_fifo_enable ||
-			    !st->chip_config.enable) {
-				result =3D inv_mpu6050_switch_engine(st, true,
+			result =3D inv_mpu6050_switch_engine(st, true,
 						INV_MPU6050_BIT_PWR_GYRO_STBY);
-				if (result)
-					goto error_read_raw;
-			}
+			if (result)
+				goto error_read_raw_power_off;
 			ret =3D inv_mpu6050_sensor_show(st, st->reg->raw_gyro,
 						      chan->channel2, val);
-			if (!st->chip_config.gyro_fifo_enable ||
-			    !st->chip_config.enable) {
-				result =3D inv_mpu6050_switch_engine(st, false,
+			result =3D inv_mpu6050_switch_engine(st, false,
 						INV_MPU6050_BIT_PWR_GYRO_STBY);
-				if (result)
-					goto error_read_raw;
-			}
+			if (result)
+				goto error_read_raw_power_off;
 			break;
 		case IIO_ACCEL:
-			if (!st->chip_config.accl_fifo_enable ||
-			    !st->chip_config.enable) {
-				result =3D inv_mpu6050_switch_engine(st, true,
+			result =3D inv_mpu6050_switch_engine(st, true,
 						INV_MPU6050_BIT_PWR_ACCL_STBY);
-				if (result)
-					goto error_read_raw;
-			}
+			if (result)
+				goto error_read_raw_power_off;
 			ret =3D inv_mpu6050_sensor_show(st, st->reg->raw_accl,
 						      chan->channel2, val);
-			if (!st->chip_config.accl_fifo_enable ||
-			    !st->chip_config.enable) {
-				result =3D inv_mpu6050_switch_engine(st, false,
+			result =3D inv_mpu6050_switch_engine(st, false,
 						INV_MPU6050_BIT_PWR_ACCL_STBY);
-				if (result)
-					goto error_read_raw;
-			}
+			if (result)
+				goto error_read_raw_power_off;
 			break;
 		case IIO_TEMP:
 			/* wait for stablization */
@@ -353,10 +339,12 @@ static int inv_mpu6050_sensor_show(struct inv_mpu6050=
_state  *st, int reg,
 			ret =3D -EINVAL;
 			break;
 		}
-error_read_raw:
-		if (!st->chip_config.enable)
-			result |=3D inv_mpu6050_set_power_itg(st, false);
-		mutex_unlock(&indio_dev->mlock);
+error_read_raw_power_off:
+		result |=3D inv_mpu6050_set_power_itg(st, false);
+error_read_raw_release:
+		iio_device_release_direct_mode(indio_dev);
+error_read_raw_unlock:
+		mutex_unlock(&st->lock);
 		if (result)
 			return result;
=20
@@ -367,17 +355,14 @@ static int inv_mpu6050_sensor_show(struct inv_mpu6050=
_state  *st, int reg,
 		case IIO_ANGL_VEL:
 			*val  =3D 0;
 			*val2 =3D gyro_scale_6050[st->chip_config.fsr];
-
 			return IIO_VAL_INT_PLUS_NANO;
 		case IIO_ACCEL:
 			*val =3D 0;
 			*val2 =3D accel_scale[st->chip_config.accl_fs];
-
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_TEMP:
 			*val =3D 0;
 			*val2 =3D INV_MPU6050_TEMP_SCALE;
-
 			return IIO_VAL_INT_PLUS_MICRO;
 		default:
 			return -EINVAL;
@@ -386,7 +371,6 @@ static int inv_mpu6050_sensor_show(struct inv_mpu6050_s=
tate  *st, int reg,
 		switch (chan->type) {
 		case IIO_TEMP:
 			*val =3D INV_MPU6050_TEMP_OFFSET;
-
 			return IIO_VAL_INT;
 		default:
 			return -EINVAL;
@@ -394,14 +378,17 @@ static int inv_mpu6050_sensor_show(struct inv_mpu6050=
_state  *st, int reg,
 	case IIO_CHAN_INFO_CALIBBIAS:
 		switch (chan->type) {
 		case IIO_ANGL_VEL:
+			mutex_lock(&st->lock);
 			ret =3D inv_mpu6050_sensor_show(st, st->reg->gyro_offset,
 						chan->channel2, val);
+			mutex_unlock(&st->lock);
 			return IIO_VAL_INT;
 		case IIO_ACCEL:
+			mutex_lock(&st->lock);
 			ret =3D inv_mpu6050_sensor_show(st, st->reg->accl_offset,
 						chan->channel2, val);
+			mutex_unlock(&st->lock);
 			return IIO_VAL_INT;
-
 		default:
 			return -EINVAL;
 		}
@@ -475,18 +462,18 @@ static int inv_mpu6050_write_raw(struct iio_dev *indi=
o_dev,
 	struct inv_mpu6050_state  *st =3D iio_priv(indio_dev);
 	int result;
=20
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	/*
 	 * we should only update scale when the chip is disabled, i.e.
 	 * not running
 	 */
-	if (st->chip_config.enable) {
-		result =3D -EBUSY;
-		goto error_write_raw;
-	}
+	result =3D iio_device_claim_direct_mode(indio_dev);
+	if (result)
+		goto error_write_raw_unlock;
+
 	result =3D inv_mpu6050_set_power_itg(st, true);
 	if (result)
-		goto error_write_raw;
+		goto error_write_raw_release;
=20
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
@@ -522,9 +509,11 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio=
_dev,
 		break;
 	}
=20
-error_write_raw:
 	result |=3D inv_mpu6050_set_power_itg(st, false);
-	mutex_unlock(&indio_dev->mlock);
+error_write_raw_release:
+	iio_device_release_direct_mode(indio_dev);
+error_write_raw_unlock:
+	mutex_unlock(&st->lock);
=20
 	return result;
 }
@@ -578,31 +567,37 @@ static int inv_mpu6050_set_lpf(struct inv_mpu6050_sta=
te *st, int rate)
 	if (fifo_rate < INV_MPU6050_MIN_FIFO_RATE ||
 	    fifo_rate > INV_MPU6050_MAX_FIFO_RATE)
 		return -EINVAL;
-	if (fifo_rate =3D=3D st->chip_config.fifo_rate)
-		return count;
=20
-	mutex_lock(&indio_dev->mlock);
-	if (st->chip_config.enable) {
-		result =3D -EBUSY;
-		goto fifo_rate_fail;
+	mutex_lock(&st->lock);
+
+	if (fifo_rate =3D=3D st->chip_config.fifo_rate) {
+		result =3D 0;
+		goto fifo_rate_unlock;
 	}
+	result =3D iio_device_claim_direct_mode(indio_dev);
+	if (result)
+		goto fifo_rate_unlock;
+
 	result =3D inv_mpu6050_set_power_itg(st, true);
 	if (result)
-		goto fifo_rate_fail;
+		goto fifo_rate_release;
=20
 	d =3D INV_MPU6050_ONE_K_HZ / fifo_rate - 1;
 	result =3D regmap_write(st->map, st->reg->sample_rate_div, d);
 	if (result)
-		goto fifo_rate_fail;
+		goto fifo_rate_power_off;
 	st->chip_config.fifo_rate =3D fifo_rate;
=20
 	result =3D inv_mpu6050_set_lpf(st, fifo_rate);
 	if (result)
-		goto fifo_rate_fail;
+		goto fifo_rate_power_off;
=20
-fifo_rate_fail:
+fifo_rate_power_off:
 	result |=3D inv_mpu6050_set_power_itg(st, false);
-	mutex_unlock(&indio_dev->mlock);
+fifo_rate_release:
+	iio_device_release_direct_mode(indio_dev);
+fifo_rate_unlock:
+	mutex_unlock(&st->lock);
 	if (result)
 		return result;
=20
@@ -617,8 +612,13 @@ static int inv_mpu6050_set_lpf(struct inv_mpu6050_stat=
e *st, int rate)
 		   char *buf)
 {
 	struct inv_mpu6050_state *st =3D iio_priv(dev_to_iio_dev(dev));
+	unsigned fifo_rate;
=20
-	return sprintf(buf, "%d\n", st->chip_config.fifo_rate);
+	mutex_lock(&st->lock);
+	fifo_rate =3D st->chip_config.fifo_rate;
+	mutex_unlock(&st->lock);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n", fifo_rate);
 }
=20
 /**
@@ -644,8 +644,8 @@ static ssize_t inv_attr_show(struct device *dev, struct=
 device_attribute *attr,
 	case ATTR_GYRO_MATRIX:
 	case ATTR_ACCL_MATRIX:
 		m =3D st->plat_data.orientation;
-
-		return sprintf(buf, "%d, %d, %d; %d, %d, %d; %d, %d, %d\n",
+		return scnprintf(buf, PAGE_SIZE,
+			"%d, %d, %d; %d, %d, %d; %d, %d, %d\n",
 			m[0], m[1], m[2], m[3], m[4], m[5], m[6], m[7], m[8]);
 	default:
 		return -EINVAL;
@@ -836,6 +836,7 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, =
const char *name,
 		return -ENODEV;
 	}
 	st =3D iio_priv(indio_dev);
+	mutex_init(&st->lock);
 	st->chip_type =3D chip_type;
 	st->powerup_count =3D 0;
 	st->irq =3D irq;
@@ -926,15 +927,30 @@ int inv_mpu_core_remove(struct device  *dev)
 EXPORT_SYMBOL_GPL(inv_mpu_core_remove);
=20
 #ifdef CONFIG_PM_SLEEP
-
 static int inv_mpu_resume(struct device *dev)
 {
-	return inv_mpu6050_set_power_itg(iio_priv(dev_get_drvdata(dev)), true);
+	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+	struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
+	int result;
+
+	mutex_lock(&st->lock);
+	result =3D inv_mpu6050_set_power_itg(st, true);
+	mutex_unlock(&st->lock);
+
+	return result;
 }
=20
 static int inv_mpu_suspend(struct device *dev)
 {
-	return inv_mpu6050_set_power_itg(iio_priv(dev_get_drvdata(dev)), false);
+	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+	struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
+	int result;
+
+	mutex_lock(&st->lock);
+	result =3D inv_mpu6050_set_power_itg(st, false);
+	mutex_unlock(&st->lock);
+
+	return result;
 }
 #endif /* CONFIG_PM_SLEEP */
=20
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_i2c.c
index 64b5f5b..fcd7a92 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -32,7 +32,7 @@ static int inv_mpu6050_select_bypass(struct i2c_mux_core =
*muxc, u32 chan_id)
 	int ret =3D 0;
=20
 	/* Use the same mutex which was used everywhere to protect power-op */
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	if (!st->powerup_count) {
 		ret =3D regmap_write(st->map, st->reg->pwr_mgmt_1, 0);
 		if (ret)
@@ -48,7 +48,7 @@ static int inv_mpu6050_select_bypass(struct i2c_mux_core =
*muxc, u32 chan_id)
 				   INV_MPU6050_BIT_BYPASS_EN);
 	}
 write_error:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
=20
 	return ret;
 }
@@ -58,14 +58,14 @@ static int inv_mpu6050_deselect_bypass(struct i2c_mux_c=
ore *muxc, u32 chan_id)
 	struct iio_dev *indio_dev =3D i2c_mux_priv(muxc);
 	struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
=20
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	/* It doesn't really mattter, if any of the calls fails */
 	regmap_write(st->map, st->reg->int_pin_cfg, INV_MPU6050_INT_PIN_CFG);
 	st->powerup_count--;
 	if (!st->powerup_count)
 		regmap_write(st->map, st->reg->pwr_mgmt_1,
 			     INV_MPU6050_BIT_SLEEP);
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
=20
 	return 0;
 }
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_iio.h
index ef13de7..713fa7b 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -14,6 +14,7 @@
 #include <linux/i2c-mux.h>
 #include <linux/kfifo.h>
 #include <linux/spinlock.h>
+#include <linux/mutex.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
 #include <linux/regmap.h>
@@ -80,7 +81,6 @@ enum inv_devices {
  *  @fsr:		Full scale range.
  *  @lpf:		Digital low pass filter frequency.
  *  @accl_fs:		accel full scale range.
- *  @enable:		master enable state.
  *  @accl_fifo_enable:	enable accel data output
  *  @gyro_fifo_enable:	enable gyro data output
  *  @fifo_rate:		FIFO update rate.
@@ -89,7 +89,6 @@ struct inv_mpu6050_chip_config {
 	unsigned int fsr:2;
 	unsigned int lpf:3;
 	unsigned int accl_fs:2;
-	unsigned int enable:1;
 	unsigned int accl_fifo_enable:1;
 	unsigned int gyro_fifo_enable:1;
 	u16 fifo_rate;
@@ -112,6 +111,7 @@ struct inv_mpu6050_hw {
 /*
  *  struct inv_mpu6050_state - Driver state variables.
  *  @TIMESTAMP_FIFO_SIZE: fifo size for timestamp.
+ *  @lock:              Chip access lock.
  *  @trig:              IIO trigger.
  *  @chip_config:	Cached attribute information.
  *  @reg:		Map of important registers.
@@ -126,6 +126,7 @@ struct inv_mpu6050_hw {
  */
 struct inv_mpu6050_state {
 #define TIMESTAMP_FIFO_SIZE 16
+	struct mutex lock;
 	struct iio_trigger  *trig;
 	struct inv_mpu6050_chip_config chip_config;
 	const struct inv_mpu6050_reg_map *reg;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_ring.c
index 3a9f3ea..ff81c6a 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -128,7 +128,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	u16 fifo_count;
 	s64 timestamp;
=20
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	if (!(st->chip_config.accl_fifo_enable |
 		st->chip_config.gyro_fifo_enable))
 		goto end_session;
@@ -178,7 +178,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	}
=20
 end_session:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 	iio_trigger_notify_done(indio_dev->trig);
=20
 	return IRQ_HANDLED;
@@ -186,7 +186,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 flush_fifo:
 	/* Flush HW and SW FIFOs. */
 	inv_reset_fifo(indio_dev);
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 	iio_trigger_notify_done(indio_dev->trig);
=20
 	return IRQ_HANDLED;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/im=
u/inv_mpu6050/inv_mpu_trigger.c
index e8818d4..85c2732 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -53,46 +53,52 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio=
_dev, bool enable)
 			result =3D inv_mpu6050_switch_engine(st, true,
 					INV_MPU6050_BIT_PWR_GYRO_STBY);
 			if (result)
-				return result;
+				goto error_power_off;
 		}
 		if (st->chip_config.accl_fifo_enable) {
 			result =3D inv_mpu6050_switch_engine(st, true,
 					INV_MPU6050_BIT_PWR_ACCL_STBY);
 			if (result)
-				return result;
+				goto error_power_off;
 		}
 		result =3D inv_reset_fifo(indio_dev);
 		if (result)
-			return result;
+			goto error_power_off;
 	} else {
 		result =3D regmap_write(st->map, st->reg->fifo_en, 0);
 		if (result)
-			return result;
+			goto error_power_off;
=20
 		result =3D regmap_write(st->map, st->reg->int_enable, 0);
 		if (result)
-			return result;
+			goto error_power_off;
=20
 		result =3D regmap_write(st->map, st->reg->user_ctrl, 0);
 		if (result)
-			return result;
+			goto error_power_off;
=20
 		result =3D inv_mpu6050_switch_engine(st, false,
 					INV_MPU6050_BIT_PWR_GYRO_STBY);
 		if (result)
-			return result;
+			goto error_power_off;
+		st->chip_config.gyro_fifo_enable =3D false;
=20
 		result =3D inv_mpu6050_switch_engine(st, false,
 					INV_MPU6050_BIT_PWR_ACCL_STBY);
 		if (result)
-			return result;
+			goto error_power_off;
+		st->chip_config.accl_fifo_enable =3D false;
+
 		result =3D inv_mpu6050_set_power_itg(st, false);
 		if (result)
 			return result;
 	}
-	st->chip_config.enable =3D enable;
=20
 	return 0;
+
+error_power_off:
+	inv_mpu6050_set_power_itg(st, false);
+	return result;
 }
=20
 /**
@@ -103,7 +109,15 @@ static int inv_mpu6050_set_enable(struct iio_dev *indi=
o_dev, bool enable)
 static int inv_mpu_data_rdy_trigger_set_state(struct iio_trigger *trig,
 					      bool state)
 {
-	return inv_mpu6050_set_enable(iio_trigger_get_drvdata(trig), state);
+	struct iio_dev *indio_dev =3D iio_trigger_get_drvdata(trig);
+	struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
+	int result;
+
+	mutex_lock(&st->lock);
+	result =3D inv_mpu6050_set_enable(indio_dev, state);
+	mutex_unlock(&st->lock);
+
+	return result;
 }
=20
 static const struct iio_trigger_ops inv_mpu_trigger_ops =3D {
--=20
1.9.1
