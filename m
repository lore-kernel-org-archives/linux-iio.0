Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:34968 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755536Ab1CQU7Z (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 17 Mar 2011 16:59:25 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 6/8] staging:iio:adc: max1363 dev_info -> indio_dev in naming for consistency
Date: Thu, 17 Mar 2011 21:00:25 +0000
Message-Id: <1300395627-18547-7-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1300395627-18547-1-git-send-email-jic23@cam.ac.uk>
References: <1300395627-18547-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Either name is fine, so went with the most common.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/max1363_core.c |   70 ++++++++++++++++----------------
 1 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index a853cae..603292f 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -155,8 +155,8 @@ static ssize_t max1363_show_precision_u(struct device *dev,
 				char *buf)
 {
 	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
-	struct iio_dev *dev_info = ring->indio_dev;
-	struct max1363_state *st = iio_dev_get_devdata(dev_info);
+	struct iio_dev *indio_dev = ring->indio_dev;
+	struct max1363_state *st = iio_dev_get_devdata(indio_dev);
 	return sprintf(buf, "u%d/16\n", st->chip_info->bits);
 }
 
@@ -165,8 +165,8 @@ static ssize_t max1363_show_precision_s(struct device *dev,
 				char *buf)
 {
 	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
-	struct iio_dev *dev_info = ring->indio_dev;
-	struct max1363_state *st = iio_dev_get_devdata(dev_info);
+	struct iio_dev *indio_dev = ring->indio_dev;
+	struct max1363_state *st = iio_dev_get_devdata(indio_dev);
 	return sprintf(buf, "s%d/16\n", st->chip_info->bits);
 }
 
@@ -238,8 +238,8 @@ static ssize_t max1363_read_single_channel(struct device *dev,
 				   struct device_attribute *attr,
 				   char *buf)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct max1363_state *st = iio_dev_get_devdata(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct max1363_state *st = iio_dev_get_devdata(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	struct i2c_client *client = st->client;
 	int ret = 0, len = 0;
@@ -247,7 +247,7 @@ static ssize_t max1363_read_single_channel(struct device *dev,
 	char rxbuf[2];
 	long mask;
 
-	mutex_lock(&dev_info->mlock);
+	mutex_lock(&indio_dev->mlock);
 	/*
 	 * If monitor mode is enabled, the method for reading a single
 	 * channel will have to be rather different and has not yet
@@ -259,7 +259,7 @@ static ssize_t max1363_read_single_channel(struct device *dev,
 	}
 
 	/* If ring buffer capture is occuring, query the buffer */
-	if (iio_ring_enabled(dev_info)) {
+	if (iio_ring_enabled(indio_dev)) {
 		mask = max1363_mode_table[this_attr->address].modemask;
 		data = max1363_single_channel_from_ring(mask, st);
 		if (data < 0) {
@@ -300,7 +300,7 @@ static ssize_t max1363_read_single_channel(struct device *dev,
 	len = sprintf(buf, "%u\n", data);
 
 error_ret:
-	mutex_unlock(&dev_info->mlock);
+	mutex_unlock(&indio_dev->mlock);
 	return ret ? ret : len;
 }
 
@@ -337,8 +337,8 @@ static ssize_t max1363_show_scale(struct device *dev,
 				char *buf)
 {
 	/* Driver currently only support internal vref */
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct max1363_state *st = iio_dev_get_devdata(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct max1363_state *st = iio_dev_get_devdata(indio_dev);
 	/* Corresponds to Vref / 2^(bits) */
 
 	if ((1 << (st->chip_info->bits + 1))
@@ -355,8 +355,8 @@ static ssize_t max1363_show_name(struct device *dev,
 				 struct device_attribute *attr,
 				 char *buf)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct max1363_state *st = iio_dev_get_devdata(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct max1363_state *st = iio_dev_get_devdata(indio_dev);
 	return sprintf(buf, "%s\n", st->client->name);
 }
 
@@ -1012,8 +1012,8 @@ static ssize_t max1363_monitor_show_freq(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct max1363_state *st = iio_dev_get_devdata(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct max1363_state *st = iio_dev_get_devdata(indio_dev);
 	return sprintf(buf, "%d\n", max1363_monitor_speeds[st->monitor_speed]);
 }
 
@@ -1022,8 +1022,8 @@ static ssize_t max1363_monitor_store_freq(struct device *dev,
 					const char *buf,
 					size_t len)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct max1363_state *st = iio_dev_get_devdata(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct max1363_state *st = iio_dev_get_devdata(indio_dev);
 	int i, ret;
 	unsigned long val;
 	bool found = false;
@@ -1039,9 +1039,9 @@ static ssize_t max1363_monitor_store_freq(struct device *dev,
 	if (!found)
 		return -EINVAL;
 
-	mutex_lock(&dev_info->mlock);
+	mutex_lock(&indio_dev->mlock);
 	st->monitor_speed = i;
-	mutex_unlock(&dev_info->mlock);
+	mutex_unlock(&indio_dev->mlock);
 
 	return 0;
 }
@@ -1058,8 +1058,8 @@ static ssize_t max1363_show_thresh(struct device *dev,
 				char *buf,
 				bool high)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct max1363_state *st = iio_dev_get_devdata(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct max1363_state *st = iio_dev_get_devdata(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	if (high)
@@ -1090,8 +1090,8 @@ static ssize_t max1363_store_thresh_unsigned(struct device *dev,
 					size_t len,
 					bool high)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct max1363_state *st = iio_dev_get_devdata(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct max1363_state *st = iio_dev_get_devdata(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	unsigned long val;
 	int ret;
@@ -1144,8 +1144,8 @@ static ssize_t max1363_store_thresh_signed(struct device *dev,
 					size_t len,
 					bool high)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct max1363_state *st = iio_dev_get_devdata(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct max1363_state *st = iio_dev_get_devdata(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	long val;
 	int ret;
@@ -1250,12 +1250,12 @@ static IIO_DEVICE_ATTR_NAMED(in3min2_thresh_low_value,
 			S_IRUGO | S_IWUSR, max1363_show_thresh_low,
 			max1363_store_thresh_low_signed, 7);
 
-static int max1363_int_th(struct iio_dev *dev_info,
+static int max1363_int_th(struct iio_dev *indio_dev,
 			int index,
 			s64 timestamp,
 			int not_test)
 {
-	struct max1363_state *st = dev_info->dev_data;
+	struct max1363_state *st = indio_dev->dev_data;
 
 	st->last_timestamp = timestamp;
 	schedule_work(&st->thresh_work);
@@ -1311,17 +1311,17 @@ static ssize_t max1363_read_interrupt_config(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct max1363_state *st = iio_dev_get_devdata(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct max1363_state *st = iio_dev_get_devdata(indio_dev);
 	struct iio_event_attr *this_attr = to_iio_event_attr(attr);
 	int val;
 
-	mutex_lock(&dev_info->mlock);
+	mutex_lock(&indio_dev->mlock);
 	if (this_attr->mask & 0x8)
 		val = (1 << (this_attr->mask & 0x7)) & st->mask_low;
 	else
 		val = (1 << this_attr->mask) & st->mask_high;
-	mutex_unlock(&dev_info->mlock);
+	mutex_unlock(&indio_dev->mlock);
 
 	return sprintf(buf, "%d\n", !!val);
 }
@@ -1465,8 +1465,8 @@ static ssize_t max1363_write_interrupt_config(struct device *dev,
 					const char *buf,
 					size_t len)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct max1363_state *st = iio_dev_get_devdata(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct max1363_state *st = iio_dev_get_devdata(indio_dev);
 	struct iio_event_attr *this_attr = to_iio_event_attr(attr);
 	unsigned long val;
 	int ret;
@@ -1500,10 +1500,10 @@ static ssize_t max1363_write_interrupt_config(struct device *dev,
 	}
 	if (st->monitor_on && !st->mask_high && !st->mask_low)
 		iio_remove_event_from_list(this_attr->listel,
-					&dev_info->interrupts[0]->ev_list);
+					&indio_dev->interrupts[0]->ev_list);
 	if (!st->monitor_on && val)
 		iio_add_event_to_list(this_attr->listel,
-				&dev_info->interrupts[0]->ev_list);
+				&indio_dev->interrupts[0]->ev_list);
 
 	max1363_monitor_mode_update(st, !!(st->mask_high | st->mask_low));
 error_ret:
-- 
1.7.3.4

