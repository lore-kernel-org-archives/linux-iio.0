Return-Path: <masneyb@onstation.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] iio: light: tsl2583: add locking to sysfs *_store() functions
Date: Wed, 19 Oct 2016 06:32:09 -0400
Message-Id: <1476873130-24926-6-git-send-email-masneyb@onstation.org>
In-Reply-To: <1476873130-24926-1-git-send-email-masneyb@onstation.org>
References: <1476873130-24926-1-git-send-email-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

The sysfs attributes modifies variables that are accessed elsewhere when
a mutex is locked. Add locking to the sysfs *_store() functions to avoid
a possible race condition when measurements are taken.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 60f0ce9..47656ae 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -515,16 +515,21 @@ static ssize_t power_state_store(struct device *dev,
 				 const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	int value, ret;
 
 	if (kstrtoint(buf, 0, &value))
 		return -EINVAL;
 
+	mutex_lock(&chip->als_mutex);
+
 	if (!value)
 		ret = taos_chip_off(indio_dev);
 	else
 		ret = taos_chip_on(indio_dev);
 
+	mutex_unlock(&chip->als_mutex);
+
 	if (ret < 0)
 		return ret;
 
@@ -568,6 +573,8 @@ static ssize_t illuminance0_calibscale_store(struct device *dev,
 	if (kstrtoint(buf, 0, &value))
 		goto gain_store_done;
 
+	mutex_lock(&chip->als_mutex);
+
 	switch (value) {
 	case 1:
 		chip->taos_settings.als_gain = 0;
@@ -583,10 +590,12 @@ static ssize_t illuminance0_calibscale_store(struct device *dev,
 		break;
 	default:
 		dev_err(dev, "Invalid Gain Index (must be 1,8,16,111)\n");
-		goto gain_store_done;
+		goto gain_store_unlock;
 	}
 	ret = len;
 
+gain_store_unlock:
+	mutex_unlock(&chip->als_mutex);
 gain_store_done:
 	return ret;
 }
@@ -625,7 +634,9 @@ static ssize_t illuminance0_integration_time_store(struct device *dev,
 	if (value % 50)
 		goto als_time_store_done;
 
+	mutex_lock(&chip->als_mutex);
 	chip->taos_settings.als_time = value;
+	mutex_unlock(&chip->als_mutex);
 	ret = len;
 
 als_time_store_done:
@@ -663,7 +674,9 @@ static ssize_t illuminance0_calibbias_store(struct device *dev,
 	else if (!value)
 		return -EINVAL;
 
+	mutex_lock(&chip->als_mutex);
 	chip->taos_settings.als_gain_trim = value;
+	mutex_unlock(&chip->als_mutex);
 
 	return len;
 }
@@ -691,7 +704,9 @@ static ssize_t illuminance0_input_target_store(struct device *dev,
 	else if (!value)
 		return -EINVAL;
 
+	mutex_lock(&chip->als_mutex);
 	chip->taos_settings.als_cal_target = value;
+	mutex_unlock(&chip->als_mutex);
 
 	return len;
 }
@@ -714,6 +729,7 @@ static ssize_t illuminance0_calibrate_store(struct device *dev,
 					    const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	int value;
 
 	if (kstrtoint(buf, 0, &value))
@@ -721,7 +737,9 @@ static ssize_t illuminance0_calibrate_store(struct device *dev,
 	else if (value != 1)
 		return -EINVAL;
 
+	mutex_lock(&chip->als_mutex);
 	taos_als_calibrate(indio_dev);
+	mutex_unlock(&chip->als_mutex);
 
 	return len;
 }
@@ -778,6 +796,8 @@ static ssize_t illuminance0_lux_table_store(struct device *dev,
 		goto luxable_store_done;
 	}
 
+	mutex_lock(&chip->als_mutex);
+
 	if (chip->taos_chip_status == TSL258X_CHIP_WORKING) {
 		ret = taos_chip_off(indio_dev);
 		if (ret < 0)
@@ -794,6 +814,8 @@ static ssize_t illuminance0_lux_table_store(struct device *dev,
 
 	ret = len;
 
+	mutex_unlock(&chip->als_mutex);
+
 luxable_store_done:
 	return ret;
 }
-- 
2.7.4
