Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:34442 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756210AbcIYT1y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Sep 2016 15:27:54 -0400
From: Brian Masney <masneyb@onstation.org>
To: gregkh@linuxfoundation.org
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH v2 2/2] staging: iio: isl29018: use IIO_DEVICE_ATTR_{RO,RW} macros
Date: Sun, 25 Sep 2016 15:27:55 -0400
Message-Id: <1474831675-4201-2-git-send-email-masneyb@onstation.org>
In-Reply-To: <1474831675-4201-1-git-send-email-masneyb@onstation.org>
References: <1474831675-4201-1-git-send-email-masneyb@onstation.org>
In-Reply-To: <20160925175852.GB13088@kroah.com>
References: <20160925175852.GB13088@kroah.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use the IIO_DEVICE_ATTR_RO and IIO_DEVICE_ATTR_RW macros to
create the device attributes.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/isl29018.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 76d9f74..055981a 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -280,8 +280,9 @@ static int isl29018_read_proximity_ir(struct isl29018_chip *chip, int scheme,
 	return 0;
 }
 
-static ssize_t show_scale_available(struct device *dev,
-				    struct device_attribute *attr, char *buf)
+static ssize_t in_illuminance_scale_available_show
+			(struct device *dev, struct device_attribute *attr,
+			 char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct isl29018_chip *chip = iio_priv(indio_dev);
@@ -297,8 +298,9 @@ static ssize_t show_scale_available(struct device *dev,
 	return len;
 }
 
-static ssize_t show_int_time_available(struct device *dev,
-				       struct device_attribute *attr, char *buf)
+static ssize_t in_illuminance_integration_time_available_show
+			(struct device *dev, struct device_attribute *attr,
+			 char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct isl29018_chip *chip = iio_priv(indio_dev);
@@ -314,9 +316,9 @@ static ssize_t show_int_time_available(struct device *dev,
 }
 
 /* proximity scheme */
-static ssize_t show_prox_infrared_suppression(struct device *dev,
-					      struct device_attribute *attr,
-					      char *buf)
+static ssize_t proximity_on_chip_ambient_infrared_suppression_show
+			(struct device *dev, struct device_attribute *attr,
+			 char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct isl29018_chip *chip = iio_priv(indio_dev);
@@ -328,9 +330,9 @@ static ssize_t show_prox_infrared_suppression(struct device *dev,
 	return sprintf(buf, "%d\n", chip->prox_scheme);
 }
 
-static ssize_t store_prox_infrared_suppression(struct device *dev,
-					       struct device_attribute *attr,
-					       const char *buf, size_t count)
+static ssize_t proximity_on_chip_ambient_infrared_suppression_store
+			(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct isl29018_chip *chip = iio_priv(indio_dev);
@@ -490,14 +492,9 @@ static const struct iio_chan_spec isl29023_channels[] = {
 	ISL29018_IR_CHANNEL,
 };
 
-static IIO_DEVICE_ATTR(in_illuminance_integration_time_available, S_IRUGO,
-		       show_int_time_available, NULL, 0);
-static IIO_DEVICE_ATTR(in_illuminance_scale_available, S_IRUGO,
-		      show_scale_available, NULL, 0);
-static IIO_DEVICE_ATTR(proximity_on_chip_ambient_infrared_suppression,
-					S_IRUGO | S_IWUSR,
-					show_prox_infrared_suppression,
-					store_prox_infrared_suppression, 0);
+static IIO_DEVICE_ATTR_RO(in_illuminance_integration_time_available, 0);
+static IIO_DEVICE_ATTR_RO(in_illuminance_scale_available, 0);
+static IIO_DEVICE_ATTR_RW(proximity_on_chip_ambient_infrared_suppression, 0);
 
 #define ISL29018_DEV_ATTR(name) (&iio_dev_attr_##name.dev_attr.attr)
 
-- 
2.7.4

