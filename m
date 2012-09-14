Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-029.synserver.de ([212.40.185.29]:1321 "EHLO
	smtp-out-029.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757327Ab2INPWa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 14 Sep 2012 11:22:30 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Milo Kim <Milo.Kim@ti.com>,
	anish kumar <anish198519851985@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/4] staging:iio:hwmon bridge: Use iio_read_channel_processed
Date: Fri, 14 Sep 2012 17:21:44 +0200
Message-Id: <1347636104-3419-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1347636104-3419-1-git-send-email-lars@metafoo.de>
References: <1347636104-3419-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use the iio_read_channel_processed function to read the sample value in the
proper unit instead of using iio_read_channel_raw and iio_read_channel_scale and
doing the unit conversion manually.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/inkern.c            |    6 +++---
 drivers/staging/iio/iio_hwmon.c |   33 +++++----------------------------
 include/linux/iio/consumer.h    |    4 ++--
 3 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 37299bf..89fdf33 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -229,7 +229,7 @@ void iio_channel_release_all(struct iio_channel *channels)
 }
 EXPORT_SYMBOL_GPL(iio_channel_release_all);
 
-static iio_channel_read(struct iio_channel *chan, int *val, int *val2,
+static int iio_channel_read(struct iio_channel *chan, int *val, int *val2,
 	enum iio_chan_info_enum info)
 {
 	int unused;
@@ -325,7 +325,7 @@ EXPORT_SYMBOL_GPL(iio_convert_raw_to_processed);
 
 int iio_read_channel_processed(struct iio_channel *chan, int *val)
 {
-	int unused, ret;
+	int ret;
 
 	mutex_lock(&chan->indio_dev->info_exist_lock);
 	if (chan->indio_dev->info == NULL) {
@@ -359,7 +359,7 @@ int iio_read_channel_scale(struct iio_channel *chan, int *val, int *val2)
 		goto err_unlock;
 	}
 
-	ret = iio_read_channel(chan, val, val2, IIO_CHAN_INFO_SCALE);
+	ret = iio_channel_read(chan, val, val2, IIO_CHAN_INFO_SCALE);
 err_unlock:
 	mutex_unlock(&chan->indio_dev->info_exist_lock);
 
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
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 3f66304..d856e5d 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -83,7 +83,7 @@ int iio_read_channel_raw(struct iio_channel *channel,
  * the function will query the raw value and the channels scale and offset and
  * do the appropriate transformation.
  */
-int iio_read_channel_processed(const struct iio_channel *channel, int *val);
+int iio_read_channel_processed(struct iio_channel *channel, int *val);
 
 /**
  * iio_get_channel_type() - get the type of a channel
@@ -128,7 +128,7 @@ int iio_read_channel_scale(struct iio_channel *channel, int *val,
  * unit for the channel type. E.g. millivolt for voltage channels, if you want
  * nanovolts instead pass 1000 as the scale factor.
  */
-int iio_convert_raw_to_processed(const struct iio_channel *channel, int raw,
+int iio_convert_raw_to_processed(struct iio_channel *channel, int raw,
 	int *processed, unsigned int scale);
 
 #endif
-- 
1.7.10.4

