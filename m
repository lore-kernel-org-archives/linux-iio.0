Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Milo Kim <Milo.Kim@ti.com>,
	anish kumar <anish198519851985@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 3/3] staging:iio:hwmon bridge: Use iio_read_channel_processed
Date: Mon, 17 Sep 2012 14:17:35 +0200
Message-Id: <1347884255-24870-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1347884255-24870-1-git-send-email-lars@metafoo.de>
References: <1347884255-24870-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Use the iio_read_channel_processed function to read the sample value in the
proper unit instead of using iio_read_channel_raw and iio_read_channel_scale and
doing the unit conversion manually.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Changes since v1:
	* Fix mixed up patch fragements between patch 2 and patch 3
---
 drivers/staging/iio/iio_hwmon.c |   33 +++++----------------------------
 1 file changed, 5 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/iio/iio_hwmon.c b/drivers/staging/iio/iio_hwmon.c
index 69d4a3b..5d49122 100644
--- a/drivers/staging/iio/iio_hwmon.c
+++ b/drivers/staging/iio/iio_hwmon.c
@@ -42,40 +42,17 @@ static ssize_t iio_hwmon_read_val(struct device *dev,
 				  struct device_attribute *attr,
 				  char *buf)
 {
-	long result;
-	int val, ret, scaleint, scalepart;
+	int result;
+	int ret;
 	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
 	struct iio_hwmon_state *state = dev_get_drvdata(dev);
 
-	/*
-	 * No locking between this pair, so theoretically possible
-	 * the scale has changed.
-	 */
-	ret = iio_read_channel_raw(&state->channels[sattr->index],
-				      &val);
+	ret = iio_read_channel_processed(&state->channels[sattr->index],
+					&result);
 	if (ret < 0)
 		return ret;
 
-	ret = iio_read_channel_scale(&state->channels[sattr->index],
-					&scaleint, &scalepart);
-	if (ret < 0)
-		return ret;
-	switch (ret) {
-	case IIO_VAL_INT:
-		result = val * scaleint;
-		break;
-	case IIO_VAL_INT_PLUS_MICRO:
-		result = (s64)val * (s64)scaleint +
-			div_s64((s64)val * (s64)scalepart, 1000000LL);
-		break;
-	case IIO_VAL_INT_PLUS_NANO:
-		result = (s64)val * (s64)scaleint +
-			div_s64((s64)val * (s64)scalepart, 1000000000LL);
-		break;
-	default:
-		return -EINVAL;
-	}
-	return sprintf(buf, "%ld\n", result);
+	return sprintf(buf, "%d\n", result);
 }
 
 static void iio_hwmon_free_attrs(struct iio_hwmon_state *st)
-- 
1.7.10.4
