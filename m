Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 3/4] IIO-onwards: ADC: AD7606: Consitently use indio_dev
Date: Wed, 20 Apr 2011 15:35:31 +0200
Message-ID: <1303306532-28506-3-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1303306532-28506-1-git-send-email-michael.hennerich@analog.com>
References: <1303306532-28506-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>


Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/ad7606_core.c |   38 ++++++++++++++++----------------
 1 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index 93e5ef5..6cb7302 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -78,24 +78,24 @@ error_ret:
 	return ret;
 }
 
-static int ad7606_read_raw(struct iio_dev *dev_info,
+static int ad7606_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val,
 			   int *val2,
 			   long m)
 {
 	int ret;
-	struct ad7606_state *st = dev_info->dev_data;
+	struct ad7606_state *st = indio_dev->dev_data;
 	unsigned int scale_uv;
 
 	switch (m) {
 	case 0:
-		mutex_lock(&dev_info->mlock);
-		if (iio_ring_enabled(dev_info))
+		mutex_lock(&indio_dev->mlock);
+		if (iio_ring_enabled(indio_dev))
 			ret = ad7606_scan_from_ring(st, chan->address);
 		else
 			ret = ad7606_scan_direct(st, chan->address);
-		mutex_unlock(&dev_info->mlock);
+		mutex_unlock(&indio_dev->mlock);
 
 		if (ret < 0)
 			return ret;
@@ -114,8 +114,8 @@ static int ad7606_read_raw(struct iio_dev *dev_info,
 static ssize_t ad7606_show_range(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7606_state *st = iio_dev_get_devdata(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7606_state *st = iio_dev_get_devdata(indio_dev);
 
 	return sprintf(buf, "%u\n", st->range);
 }
@@ -123,8 +123,8 @@ static ssize_t ad7606_show_range(struct device *dev,
 static ssize_t ad7606_store_range(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7606_state *st = iio_dev_get_devdata(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7606_state *st = iio_dev_get_devdata(indio_dev);
 	unsigned long lval;
 
 	if (strict_strtoul(buf, 10, &lval))
@@ -133,10 +133,10 @@ static ssize_t ad7606_store_range(struct device *dev,
 		dev_err(dev, "range is not supported\n");
 		return -EINVAL;
 	}
-	mutex_lock(&dev_info->mlock);
+	mutex_lock(&indio_dev->mlock);
 	gpio_set_value(st->pdata->gpio_range, lval == 10000);
 	st->range = lval;
-	mutex_unlock(&dev_info->mlock);
+	mutex_unlock(&indio_dev->mlock);
 
 	return count;
 }
@@ -148,8 +148,8 @@ static IIO_CONST_ATTR(range_available, "5000 10000");
 static ssize_t ad7606_show_oversampling_ratio(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7606_state *st = iio_dev_get_devdata(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7606_state *st = iio_dev_get_devdata(indio_dev);
 
 	return sprintf(buf, "%u\n", st->oversampling);
 }
@@ -169,8 +169,8 @@ static int ad7606_oversampling_get_index(unsigned val)
 static ssize_t ad7606_store_oversampling_ratio(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7606_state *st = iio_dev_get_devdata(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7606_state *st = iio_dev_get_devdata(indio_dev);
 	unsigned long lval;
 	int ret;
 
@@ -183,12 +183,12 @@ static ssize_t ad7606_store_oversampling_ratio(struct device *dev,
 		return ret;
 	}
 
-	mutex_lock(&dev_info->mlock);
+	mutex_lock(&indio_dev->mlock);
 	gpio_set_value(st->pdata->gpio_os0, (ret >> 0) & 1);
 	gpio_set_value(st->pdata->gpio_os1, (ret >> 1) & 1);
 	gpio_set_value(st->pdata->gpio_os1, (ret >> 2) & 1);
 	st->oversampling = lval;
-	mutex_unlock(&dev_info->mlock);
+	mutex_unlock(&indio_dev->mlock);
 
 	return count;
 }
@@ -210,8 +210,8 @@ static mode_t ad7606_attr_is_visible(struct kobject *kobj,
 				     struct attribute *attr, int n)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7606_state *st = iio_dev_get_devdata(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7606_state *st = iio_dev_get_devdata(indio_dev);
 
 	mode_t mode = attr->mode;
 
-- 
1.6.0.2
