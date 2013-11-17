Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50310 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689Ab3KQOOL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Nov 2013 09:14:11 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 05/11] iio:st sensors: remove custom sampling frequence attribute in favour of core support.
Date: Sun, 17 Nov 2013 15:14:56 +0000
Message-Id: <1384701302-26564-6-git-send-email-jic23@kernel.org>
In-Reply-To: <1384701302-26564-1-git-send-email-jic23@kernel.org>
References: <1384701302-26564-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This allows in kernel client drivers to access this

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/accel/st_accel_core.c               | 12 ++++++++--
 drivers/iio/common/st_sensors/st_sensors_core.c | 29 -------------------------
 drivers/iio/gyro/st_gyro_core.c                 | 12 ++++++++--
 drivers/iio/magnetometer/st_magn_core.c         | 12 ++++++++--
 drivers/iio/pressure/st_pressure_core.c         | 27 +++++++++++++++++++++--
 include/linux/iio/common/st_sensors.h           | 15 +++++--------
 6 files changed, 61 insertions(+), 46 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 38caedc76b98..237d85142ad8 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -393,6 +393,9 @@ static int st_accel_read_raw(struct iio_dev *indio_dev,
 		*val = 0;
 		*val2 = adata->current_fullscale->gain;
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = adata->odr;
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -410,6 +413,13 @@ static int st_accel_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		err = st_sensors_set_fullscale_by_gain(indio_dev, val2);
 		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val2)
+			return -EINVAL;
+		mutex_lock(&indio_dev->mlock);
+		err = st_sensors_set_odr(indio_dev, val);
+		mutex_unlock(&indio_dev->mlock);
+		return err;
 	default:
 		return -EINVAL;
 	}
@@ -417,14 +427,12 @@ static int st_accel_write_raw(struct iio_dev *indio_dev,
 	return err;
 }
 
-static ST_SENSOR_DEV_ATTR_SAMP_FREQ();
 static ST_SENSORS_DEV_ATTR_SAMP_FREQ_AVAIL();
 static ST_SENSORS_DEV_ATTR_SCALE_AVAIL(in_accel_scale_available);
 
 static struct attribute *st_accel_attributes[] = {
 	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_in_accel_scale_available.dev_attr.attr,
-	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	NULL,
 };
 
diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 7ba1ef270213..890bdc83cafb 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -426,35 +426,6 @@ read_wai_error:
 }
 EXPORT_SYMBOL(st_sensors_check_device_support);
 
-ssize_t st_sensors_sysfs_get_sampling_frequency(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct st_sensor_data *adata = iio_priv(dev_get_drvdata(dev));
-
-	return sprintf(buf, "%d\n", adata->odr);
-}
-EXPORT_SYMBOL(st_sensors_sysfs_get_sampling_frequency);
-
-ssize_t st_sensors_sysfs_set_sampling_frequency(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t size)
-{
-	int err;
-	unsigned int odr;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-
-	err = kstrtoint(buf, 10, &odr);
-	if (err < 0)
-		goto conversion_error;
-
-	mutex_lock(&indio_dev->mlock);
-	err = st_sensors_set_odr(indio_dev, odr);
-	mutex_unlock(&indio_dev->mlock);
-
-conversion_error:
-	return err < 0 ? err : size;
-}
-EXPORT_SYMBOL(st_sensors_sysfs_set_sampling_frequency);
-
 ssize_t st_sensors_sysfs_sampling_frequency_avail(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index d53d91adfb55..fc9f449a342a 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -246,6 +246,9 @@ static int st_gyro_read_raw(struct iio_dev *indio_dev,
 		*val = 0;
 		*val2 = gdata->current_fullscale->gain;
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = gdata->odr;
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -263,6 +266,13 @@ static int st_gyro_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		err = st_sensors_set_fullscale_by_gain(indio_dev, val2);
 		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val2)
+			return -EINVAL;
+		mutex_lock(&indio_dev->mlock);
+		err = st_sensors_set_odr(indio_dev, val);
+		mutex_unlock(&indio_dev->mlock);
+		return err;
 	default:
 		err = -EINVAL;
 	}
@@ -270,14 +280,12 @@ static int st_gyro_write_raw(struct iio_dev *indio_dev,
 	return err;
 }
 
-static ST_SENSOR_DEV_ATTR_SAMP_FREQ();
 static ST_SENSORS_DEV_ATTR_SAMP_FREQ_AVAIL();
 static ST_SENSORS_DEV_ATTR_SCALE_AVAIL(in_anglvel_scale_available);
 
 static struct attribute *st_gyro_attributes[] = {
 	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_in_anglvel_scale_available.dev_attr.attr,
-	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	NULL,
 };
 
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 52bbcfa1e077..34fc1a70a974 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -299,6 +299,9 @@ static int st_magn_read_raw(struct iio_dev *indio_dev,
 		else
 			*val2 = mdata->current_fullscale->gain;
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = mdata->odr;
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -316,6 +319,13 @@ static int st_magn_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		err = st_sensors_set_fullscale_by_gain(indio_dev, val2);
 		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val2)
+			return -EINVAL;
+		mutex_lock(&indio_dev->mlock);
+		err = st_sensors_set_odr(indio_dev, val);
+		mutex_unlock(&indio_dev->mlock);
+		return err;
 	default:
 		err = -EINVAL;
 	}
@@ -323,14 +333,12 @@ static int st_magn_write_raw(struct iio_dev *indio_dev,
 	return err;
 }
 
-static ST_SENSOR_DEV_ATTR_SAMP_FREQ();
 static ST_SENSORS_DEV_ATTR_SAMP_FREQ_AVAIL();
 static ST_SENSORS_DEV_ATTR_SCALE_AVAIL(in_magn_scale_available);
 
 static struct attribute *st_magn_attributes[] = {
 	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_in_magn_scale_available.dev_attr.attr,
-	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	NULL,
 };
 
diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index 58083f9d51c5..a6d2855cefb0 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -235,6 +235,27 @@ static const struct st_sensors st_press_sensors[] = {
 	},
 };
 
+static int st_press_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *ch,
+			      int val,
+			      int val2,
+			      long mask)
+{
+	int err;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val2)
+			return -EINVAL;
+		mutex_lock(&indio_dev->mlock);
+		err = st_sensors_set_odr(indio_dev, val);
+		mutex_unlock(&indio_dev->mlock);
+		return err;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int st_press_read_raw(struct iio_dev *indio_dev,
 			struct iio_chan_spec const *ch, int *val,
 							int *val2, long mask)
@@ -277,6 +298,9 @@ static int st_press_read_raw(struct iio_dev *indio_dev,
 		}
 
 		return IIO_VAL_FRACTIONAL;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = pdata->odr;
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -285,12 +309,10 @@ read_error:
 	return err;
 }
 
-static ST_SENSOR_DEV_ATTR_SAMP_FREQ();
 static ST_SENSORS_DEV_ATTR_SAMP_FREQ_AVAIL();
 
 static struct attribute *st_press_attributes[] = {
 	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
-	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	NULL,
 };
 
@@ -302,6 +324,7 @@ static const struct iio_info press_info = {
 	.driver_module = THIS_MODULE,
 	.attrs = &st_press_attribute_group,
 	.read_raw = &st_press_read_raw,
+	.write_raw = &st_press_write_raw,
 };
 
 #ifdef CONFIG_IIO_TRIGGER
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index 3c005eb3a0a4..ffcd1f2b96c9 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -47,6 +47,7 @@
 	.type = device_type, \
 	.modified = mod, \
 	.info_mask_separate = mask, \
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
 	.scan_index = index, \
 	.channel2 = ch2, \
 	.address = addr, \
@@ -59,11 +60,6 @@
 	}, \
 }
 
-#define ST_SENSOR_DEV_ATTR_SAMP_FREQ() \
-		IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO, \
-			st_sensors_sysfs_get_sampling_frequency, \
-			st_sensors_sysfs_set_sampling_frequency)
-
 #define ST_SENSORS_DEV_ATTR_SAMP_FREQ_AVAIL() \
 		IIO_DEV_ATTR_SAMP_FREQ_AVAIL( \
 			st_sensors_sysfs_sampling_frequency_avail)
@@ -281,11 +277,12 @@ int st_sensors_read_info_raw(struct iio_dev *indio_dev,
 int st_sensors_check_device_support(struct iio_dev *indio_dev,
 			int num_sensors_list, const struct st_sensors *sensors);
 
-ssize_t st_sensors_sysfs_get_sampling_frequency(struct device *dev,
-				struct device_attribute *attr, char *buf);
+int st_sensors_get_sampling_frequency(struct iio_dev *indio_dev,
+				      int *val,
+				      int *val2);
 
-ssize_t st_sensors_sysfs_set_sampling_frequency(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t size);
+int st_sensors_set_sampling_frequency(struct iio_dev *indio_dev, int *val,
+				      int *val2);
 
 ssize_t st_sensors_sysfs_sampling_frequency_avail(struct device *dev,
 				struct device_attribute *attr, char *buf);
-- 
1.8.4.2

