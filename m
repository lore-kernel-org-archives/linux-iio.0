Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: jbrenner@taosinc.com,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 3/3] staging:iio:light:tsl2583 switch to kstrto and strtobool
Date: Sun,  6 Jan 2013 16:23:03 +0000
Message-Id: <1357489383-30811-4-git-send-email-jic23@kernel.org>
In-Reply-To: <1357489383-30811-1-git-send-email-jic23@kernel.org>
References: <1357489383-30811-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Doing this results in cleaner code and better error handling.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/light/tsl2583.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 944db26..f45114f 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -493,15 +493,17 @@ static ssize_t taos_power_state_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	unsigned long value;
+	bool state;
+	int ret;
 
-	if (strict_strtoul(buf, 0, &value))
-		return -EINVAL;
+	ret = strtobool(buf, &state);
+	if (ret < 0)
+		return ret;
 
-	if (value == 0)
-		taos_chip_off(indio_dev);
-	else
+	if (state)
 		taos_chip_on(indio_dev);
+	else
+		taos_chip_off(indio_dev);		
 
 	return len;
 }
@@ -527,9 +529,11 @@ static ssize_t taos_als_time_store(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	unsigned long value;
+	int ret;
 
-	if (strict_strtoul(buf, 0, &value))
-		return -EINVAL;
+	ret = kstrtoul(buf, 0, &value);
+	if (ret < 0)
+		return ret;
 
 	if ((value < 50) || (value > 650))
 		return -EINVAL;
@@ -564,9 +568,11 @@ static ssize_t taos_als_cal_target_store(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	unsigned long value;
+	int ret;
 
-	if (strict_strtoul(buf, 0, &value))
-		return -EINVAL;
+	ret = kstrotoul(buf, 0, &value);
+	if (ret < 0)
+		return ret;
 
 	if (value)
 		chip->taos_settings.als_cal_target = value;
@@ -578,12 +584,14 @@ static ssize_t taos_do_calibrate(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	unsigned long value;
+	bool cal;
+	int ret;
 
-	if (strict_strtoul(buf, 0, &value))
-		return -EINVAL;
+	ret = strtobool(buf, &cal);
+	if (ret < 0)
+		return ret;
 
-	if (value == 1)
+	if (cal)
 		taos_als_calibrate(indio_dev);
 
 	return len;
-- 
1.8.1
