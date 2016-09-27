Return-Path: <masneyb@onstation.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	gregkh@linuxfoundation.org
Subject: [PATCH v3 2/5] staging: iio: isl29018: use IIO_DEVICE_ATTR_{RO, RW} macros
Date: Mon, 26 Sep 2016 20:20:17 -0400
Message-Id: <1474935620-13151-2-git-send-email-masneyb@onstation.org>
In-Reply-To: <1474935620-13151-1-git-send-email-masneyb@onstation.org>
References: <20160926075935.GA25938@kroah.com>
 <1474935620-13151-1-git-send-email-masneyb@onstation.org>
In-Reply-To: <20160926075935.GA25938@kroah.com>
References: <20160926075935.GA25938@kroah.com>
List-ID: <linux-iio@vger.kernel.org>

Use the IIO_DEVICE_ATTR_RO and IIO_DEVICE_ATTR_RW macros to
create the device attributes.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
This version of the patch now applies cleanly to the iio.git/testing
branch.

 drivers/staging/iio/light/isl29018.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 30dc1da..19f282c 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -268,8 +268,9 @@ static int isl29018_read_proximity_ir(struct isl29018_chip *chip, int scheme,
 	return 0;
 }
 
-static ssize_t isl29018_show_scale_available(struct device *dev,
-				    struct device_attribute *attr, char *buf)
+static ssize_t in_illuminance_scale_available_show
+			(struct device *dev, struct device_attribute *attr,
+			 char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct isl29018_chip *chip = iio_priv(indio_dev);
@@ -286,8 +287,9 @@ static ssize_t isl29018_show_scale_available(struct device *dev,
 	return len;
 }
 
-static ssize_t isl29018_show_int_time_available(struct device *dev,
-				       struct device_attribute *attr, char *buf)
+static ssize_t in_illuminance_integration_time_available_show
+			(struct device *dev, struct device_attribute *attr,
+			 char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct isl29018_chip *chip = iio_priv(indio_dev);
@@ -303,9 +305,9 @@ static ssize_t isl29018_show_int_time_available(struct device *dev,
 	return len;
 }
 
-static ssize_t isl29018_show_prox_infrared_suppression(struct device *dev,
-					      struct device_attribute *attr,
-					      char *buf)
+static ssize_t proximity_on_chip_ambient_infrared_suppression_show
+			(struct device *dev, struct device_attribute *attr,
+			 char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct isl29018_chip *chip = iio_priv(indio_dev);
@@ -317,9 +319,9 @@ static ssize_t isl29018_show_prox_infrared_suppression(struct device *dev,
 	return sprintf(buf, "%d\n", chip->prox_scheme);
 }
 
-static ssize_t isl29018_store_prox_infrared_suppression(struct device *dev,
-					       struct device_attribute *attr,
-					       const char *buf, size_t count)
+static ssize_t proximity_on_chip_ambient_infrared_suppression_store
+			(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct isl29018_chip *chip = iio_priv(indio_dev);
@@ -471,14 +473,9 @@ static const struct iio_chan_spec isl29023_channels[] = {
 	ISL29018_IR_CHANNEL,
 };
 
-static IIO_DEVICE_ATTR(in_illuminance_integration_time_available, S_IRUGO,
-		       isl29018_show_int_time_available, NULL, 0);
-static IIO_DEVICE_ATTR(in_illuminance_scale_available, S_IRUGO,
-		      isl29018_show_scale_available, NULL, 0);
-static IIO_DEVICE_ATTR(proximity_on_chip_ambient_infrared_suppression,
-					S_IRUGO | S_IWUSR,
-					isl29018_show_prox_infrared_suppression,
-					isl29018_store_prox_infrared_suppression, 0);
+static IIO_DEVICE_ATTR_RO(in_illuminance_integration_time_available, 0);
+static IIO_DEVICE_ATTR_RO(in_illuminance_scale_available, 0);
+static IIO_DEVICE_ATTR_RW(proximity_on_chip_ambient_infrared_suppression, 0);
 
 #define ISL29018_DEV_ATTR(name) (&iio_dev_attr_##name.dev_attr.attr)
 
-- 
2.7.4
