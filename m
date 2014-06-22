Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:43089 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752315AbaFVT6S (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 22 Jun 2014 15:58:18 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: kristina.martsenko@gmail.com, Jonathan Cameron <jic23@kernel.org>,
	Ge Gao <ggao@invensense.com>
Subject: [PATCH 3/7] iio: imu: mpu6050 switch sampling frequency attr to core support.
Date: Sun, 22 Jun 2014 20:59:42 +0100
Message-Id: <1403467186-26639-4-git-send-email-jic23@kernel.org>
In-Reply-To: <1403467186-26639-1-git-send-email-jic23@kernel.org>
References: <1403467186-26639-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

By using the info_mask_shared_by_all element of the channel spec, acce
to the sampling frequency becomes available to in kernel users of the
driver.  It also shortens and simplifies the code a little.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Cc: Ge Gao <ggao@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 149 +++++++++++------------------
 1 file changed, 58 insertions(+), 91 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index af287bf..088ad87 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -316,6 +316,9 @@ error_read_raw:
 		default:
 			return -EINVAL;
 		}
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = st->chip_config.fifo_rate;
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -359,51 +362,6 @@ static int inv_mpu6050_write_accel_fs(struct inv_mpu6050_state *st, int fs)
 	return 0;
 }
 
-static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
-			       struct iio_chan_spec const *chan,
-			       int val,
-			       int val2,
-			       long mask) {
-	struct inv_mpu6050_state  *st = iio_priv(indio_dev);
-	int result;
-
-	mutex_lock(&indio_dev->mlock);
-	/* we should only update scale when the chip is disabled, i.e.,
-		not running */
-	if (st->chip_config.enable) {
-		result = -EBUSY;
-		goto error_write_raw;
-	}
-	result = inv_mpu6050_set_power_itg(st, true);
-	if (result)
-		goto error_write_raw;
-
-	switch (mask) {
-	case IIO_CHAN_INFO_SCALE:
-		switch (chan->type) {
-		case IIO_ANGL_VEL:
-			result = inv_mpu6050_write_fsr(st, val);
-			break;
-		case IIO_ACCEL:
-			result = inv_mpu6050_write_accel_fs(st, val);
-			break;
-		default:
-			result = -EINVAL;
-			break;
-		}
-		break;
-	default:
-		result = -EINVAL;
-		break;
-	}
-
-error_write_raw:
-	result |= inv_mpu6050_set_power_itg(st, false);
-	mutex_unlock(&indio_dev->mlock);
-
-	return result;
-}
-
 /**
  *  inv_mpu6050_set_lpf() - set low pass filer based on fifo rate.
  *
@@ -435,63 +393,74 @@ static int inv_mpu6050_set_lpf(struct inv_mpu6050_state *st, int rate)
 	return 0;
 }
 
-/**
- * inv_mpu6050_fifo_rate_store() - Set fifo rate.
- */
-static ssize_t inv_mpu6050_fifo_rate_store(struct device *dev,
-	struct device_attribute *attr, const char *buf, size_t count)
-{
-	s32 fifo_rate;
-	u8 d;
+static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int val,
+			       int val2,
+			       long mask) {
+	struct inv_mpu6050_state  *st = iio_priv(indio_dev);
 	int result;
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct inv_mpu6050_state *st = iio_priv(indio_dev);
-
-	if (kstrtoint(buf, 10, &fifo_rate))
-		return -EINVAL;
-	if (fifo_rate < INV_MPU6050_MIN_FIFO_RATE ||
-				fifo_rate > INV_MPU6050_MAX_FIFO_RATE)
-		return -EINVAL;
-	if (fifo_rate == st->chip_config.fifo_rate)
-		return count;
+	u8 d;
 
 	mutex_lock(&indio_dev->mlock);
+	/* we should only update scale when the chip is disabled, i.e.,
+		not running */
 	if (st->chip_config.enable) {
 		result = -EBUSY;
-		goto fifo_rate_fail;
+		goto error_write_raw;
 	}
 	result = inv_mpu6050_set_power_itg(st, true);
 	if (result)
-		goto fifo_rate_fail;
+		goto error_write_raw;
 
-	d = INV_MPU6050_ONE_K_HZ / fifo_rate - 1;
-	result = inv_mpu6050_write_reg(st, st->reg->sample_rate_div, d);
-	if (result)
-		goto fifo_rate_fail;
-	st->chip_config.fifo_rate = fifo_rate;
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_ANGL_VEL:
+			result = inv_mpu6050_write_fsr(st, val);
+			break;
+		case IIO_ACCEL:
+			result = inv_mpu6050_write_accel_fs(st, val);
+			break;
+		default:
+			result = -EINVAL;
+			break;
+		}
+		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val < INV_MPU6050_MIN_FIFO_RATE ||
+		    val > INV_MPU6050_MAX_FIFO_RATE ||
+		    val2 != 0) {
+			result = -EINVAL;
+			break;
+		}
+		if (val == st->chip_config.fifo_rate) {
+			result = 0;
+			break;
+		}
 
-	result = inv_mpu6050_set_lpf(st, fifo_rate);
-	if (result)
-		goto fifo_rate_fail;
+		result = inv_mpu6050_set_power_itg(st, true);
+		if (result)
+			break;
 
-fifo_rate_fail:
-	result |= inv_mpu6050_set_power_itg(st, false);
-	mutex_unlock(&indio_dev->mlock);
-	if (result)
-		return result;
+		d = INV_MPU6050_ONE_K_HZ / val - 1;
+		result = inv_mpu6050_write_reg(st, st->reg->sample_rate_div, d);
+		if (result)
+			break;
+		st->chip_config.fifo_rate = val;
 
-	return count;
-}
+		result = inv_mpu6050_set_lpf(st, val);
+		break;
+	default:
+		result = -EINVAL;
+		break;
+	}
 
-/**
- * inv_fifo_rate_show() - Get the current sampling rate.
- */
-static ssize_t inv_fifo_rate_show(struct device *dev,
-	struct device_attribute *attr, char *buf)
-{
-	struct inv_mpu6050_state *st = iio_priv(dev_to_iio_dev(dev));
+error_write_raw:
+	result |= inv_mpu6050_set_power_itg(st, false);
+	mutex_unlock(&indio_dev->mlock);
 
-	return sprintf(buf, "%d\n", st->chip_config.fifo_rate);
+	return result;
 }
 
 /**
@@ -546,6 +515,7 @@ static int inv_mpu6050_validate_trigger(struct iio_dev *indio_dev,
 		.channel2 = _channel2,                                \
 		.info_mask_shared_by_type =  BIT(IIO_CHAN_INFO_SCALE), \
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),         \
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
 		.scan_index = _index,                                 \
 		.scan_type = {                                        \
 				.sign = 's',                          \
@@ -580,8 +550,6 @@ static const struct iio_chan_spec inv_mpu_channels[] = {
 
 /* constant IIO attribute */
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("10 20 50 100 200 500");
-static IIO_DEV_ATTR_SAMP_FREQ(S_IRUGO | S_IWUSR, inv_fifo_rate_show,
-	inv_mpu6050_fifo_rate_store);
 static IIO_DEVICE_ATTR(in_gyro_matrix, S_IRUGO, inv_attr_show, NULL,
 	ATTR_GYRO_MATRIX);
 static IIO_DEVICE_ATTR(in_accel_matrix, S_IRUGO, inv_attr_show, NULL,
@@ -590,7 +558,6 @@ static IIO_DEVICE_ATTR(in_accel_matrix, S_IRUGO, inv_attr_show, NULL,
 static struct attribute *inv_attributes[] = {
 	&iio_dev_attr_in_gyro_matrix.dev_attr.attr,
 	&iio_dev_attr_in_accel_matrix.dev_attr.attr,
-	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	NULL,
 };
-- 
2.0.0

