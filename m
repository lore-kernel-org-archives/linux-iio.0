Return-Path: <Johannes.Tenschert@informatik.stud.uni-erlangen.de>
From: Johannes Tenschert <Johannes.Tenschert@informatik.stud.uni-erlangen.de>
To: devel@linuxdriverproject.org
Cc: jic23@cam.ac.uk,
	gregkh@suse.de,
	jbrenner@taosinc.com,
	linux-iio@vger.kernel.org,
	Johannes Tenschert <Johannes.Tenschert@informatik.stud.uni-erlangen.de>
Subject: [PATCH v2 2/2] staging: iio: light: tsl2583.c: obsolete use of strict_strtoul
Date: Tue, 13 Dec 2011 00:38:22 +0100
Message-Id: <1323733102-7868-3-git-send-email-Johannes.Tenschert@informatik.stud.uni-erlangen.de>
In-Reply-To: <1323733102-7868-1-git-send-email-Johannes.Tenschert@informatik.stud.uni-erlangen.de>
References: <1323733102-7868-1-git-send-email-Johannes.Tenschert@informatik.stud.uni-erlangen.de>
List-ID: <linux-iio@vger.kernel.org>

The function strict_strtoul is obsolete and replaced by kstrtouint
and kstrtoint.

If kstrto* fails its return code is returned instead of -EINVAL.

Signed-off-by: Johannes Tenschert <Johannes.Tenschert@informatik.stud.uni-erlangen.de>
---
 drivers/staging/iio/light/tsl2583.c |   48 +++++++++++++++++++++-------------
 1 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 5b6455a..8c751e0 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -493,10 +493,12 @@ static ssize_t taos_power_state_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	unsigned long value;
+	unsigned int value;
+	int ret;
 
-	if (strict_strtoul(buf, 0, &value))
-		return -EINVAL;
+	ret = kstrtouint(buf, 0, &value);
+	if (ret)
+		return ret;
 
 	if (value == 0)
 		taos_chip_off(indio_dev);
@@ -536,10 +538,12 @@ static ssize_t taos_gain_store(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
-	unsigned long value;
+	unsigned int value;
+	int ret;
 
-	if (strict_strtoul(buf, 0, &value))
-		return -EINVAL;
+	ret = kstrtouint(buf, 0, &value);
+	if (ret)
+		return ret;
 
 	switch (value) {
 	case 1:
@@ -582,10 +586,12 @@ static ssize_t taos_als_time_store(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
-	unsigned long value;
+	int value;
+	int ret;
 
-	if (strict_strtoul(buf, 0, &value))
-		return -EINVAL;
+	ret = kstrtoint(buf, 0, &value);
+	if (ret)
+		return ret;
 
 	if ((value < 50) || (value > 650))
 		return -EINVAL;
@@ -619,10 +625,12 @@ static ssize_t taos_als_trim_store(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
-	unsigned long value;
+	int value;
+	int ret;
 
-	if (strict_strtoul(buf, 0, &value))
-		return -EINVAL;
+	ret = kstrtoint(buf, 0, &value);
+	if (ret)
+		return ret;
 
 	if (value)
 		chip->taos_settings.als_gain_trim = value;
@@ -644,10 +652,12 @@ static ssize_t taos_als_cal_target_store(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
-	unsigned long value;
+	int value;
+	int ret;
 
-	if (strict_strtoul(buf, 0, &value))
-		return -EINVAL;
+	ret = kstrtoint(buf, 0, &value);
+	if (ret)
+		return ret;
 
 	if (value)
 		chip->taos_settings.als_cal_target = value;
@@ -671,10 +681,12 @@ static ssize_t taos_do_calibrate(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	unsigned long value;
+	unsigned int value;
+	int ret;
 
-	if (strict_strtoul(buf, 0, &value))
-		return -EINVAL;
+	ret = kstrtouint(buf, 0, &value);
+	if (ret)
+		return ret;
 
 	if (value == 1)
 		taos_als_calibrate(indio_dev);
-- 
1.7.5.4
