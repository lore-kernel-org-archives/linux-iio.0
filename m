Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 4/4] IIO-onwards: ADC: AD7606: Drop dev_data in favour of iio_priv()
Date: Wed, 20 Apr 2011 15:35:32 +0200
Message-ID: <1303306532-28506-4-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1303306532-28506-1-git-send-email-michael.hennerich@analog.com>
References: <1303306532-28506-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Some other small cleanups.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/ad7606.h      |    2 +-
 drivers/staging/iio/adc/ad7606_core.c |   20 ++++++++++----------
 drivers/staging/iio/adc/ad7606_ring.c |   10 +++++-----
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
index 8ba245a..2738f40 100644
--- a/drivers/staging/iio/adc/ad7606.h
+++ b/drivers/staging/iio/adc/ad7606.h
@@ -107,7 +107,7 @@ enum ad7606_supported_device_ids {
 	ID_AD7606_4
 };
 
-int ad7606_scan_from_ring(struct ad7606_state *st, unsigned ch);
+int ad7606_scan_from_ring(struct iio_dev *indio_dev, unsigned ch);
 int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev);
 void ad7606_ring_cleanup(struct iio_dev *indio_dev);
 #endif /* IIO_ADC_AD7606_H_ */
diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index 6cb7302..28659ce 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -38,8 +38,9 @@ int ad7606_reset(struct ad7606_state *st)
 	return -ENODEV;
 }
 
-static int ad7606_scan_direct(struct ad7606_state *st, unsigned ch)
+static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned ch)
 {
+	struct ad7606_state *st = iio_priv(indio_dev);
 	int ret;
 
 	st->done = false;
@@ -85,16 +86,16 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 			   long m)
 {
 	int ret;
-	struct ad7606_state *st = indio_dev->dev_data;
+	struct ad7606_state *st = iio_priv(indio_dev);
 	unsigned int scale_uv;
 
 	switch (m) {
 	case 0:
 		mutex_lock(&indio_dev->mlock);
 		if (iio_ring_enabled(indio_dev))
-			ret = ad7606_scan_from_ring(st, chan->address);
+			ret = ad7606_scan_from_ring(indio_dev, chan->address);
 		else
-			ret = ad7606_scan_direct(st, chan->address);
+			ret = ad7606_scan_direct(indio_dev, chan->address);
 		mutex_unlock(&indio_dev->mlock);
 
 		if (ret < 0)
@@ -115,7 +116,7 @@ static ssize_t ad7606_show_range(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad7606_state *st = iio_dev_get_devdata(indio_dev);
+	struct ad7606_state *st = iio_priv(indio_dev);
 
 	return sprintf(buf, "%u\n", st->range);
 }
@@ -124,7 +125,7 @@ static ssize_t ad7606_store_range(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad7606_state *st = iio_dev_get_devdata(indio_dev);
+	struct ad7606_state *st = iio_priv(indio_dev);
 	unsigned long lval;
 
 	if (strict_strtoul(buf, 10, &lval))
@@ -149,7 +150,7 @@ static ssize_t ad7606_show_oversampling_ratio(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad7606_state *st = iio_dev_get_devdata(indio_dev);
+	struct ad7606_state *st = iio_priv(indio_dev);
 
 	return sprintf(buf, "%u\n", st->oversampling);
 }
@@ -170,7 +171,7 @@ static ssize_t ad7606_store_oversampling_ratio(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad7606_state *st = iio_dev_get_devdata(indio_dev);
+	struct ad7606_state *st = iio_priv(indio_dev);
 	unsigned long lval;
 	int ret;
 
@@ -211,7 +212,7 @@ static mode_t ad7606_attr_is_visible(struct kobject *kobj,
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad7606_state *st = iio_dev_get_devdata(indio_dev);
+	struct ad7606_state *st = iio_priv(indio_dev);
 
 	mode_t mode = attr->mode;
 
@@ -472,7 +473,6 @@ struct iio_dev *ad7606_probe(struct device *dev, int irq,
 
 	indio_dev->dev.parent = dev;
 	indio_dev->attrs = &ad7606_attribute_group;
-	indio_dev->dev_data = (void *)(st);
 	indio_dev->driver_module = THIS_MODULE;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->name = st->chip_info->name;
diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
index 1040082..2690475 100644
--- a/drivers/staging/iio/adc/ad7606_ring.c
+++ b/drivers/staging/iio/adc/ad7606_ring.c
@@ -21,9 +21,9 @@
 
 #include "ad7606.h"
 
-int ad7606_scan_from_ring(struct ad7606_state *st, unsigned ch)
+int ad7606_scan_from_ring(struct iio_dev *indio_dev, unsigned ch)
 {
-	struct iio_ring_buffer *ring = iio_priv_to_dev(st)->ring;
+	struct iio_ring_buffer *ring = indio_dev->ring;
 	int ret;
 	u16 *ring_data;
 
@@ -54,7 +54,7 @@ error_ret:
  **/
 static int ad7606_ring_preenable(struct iio_dev *indio_dev)
 {
-	struct ad7606_state *st = indio_dev->dev_data;
+	struct ad7606_state *st = iio_priv(indio_dev);
 	struct iio_ring_buffer *ring = indio_dev->ring;
 	size_t d_size;
 
@@ -84,7 +84,7 @@ static irqreturn_t ad7606_trigger_handler_th_bh(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->private_data;
-	struct ad7606_state *st = indio_dev->dev_data;
+	struct ad7606_state *st = iio_priv(indio_dev);
 
 	gpio_set_value(st->pdata->gpio_convst, 1);
 
@@ -160,7 +160,7 @@ static struct iio_ring_setup_ops ad7606_ring_setup_ops = {
 
 int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 {
-	struct ad7606_state *st = indio_dev->dev_data;
+	struct ad7606_state *st = iio_priv(indio_dev);
 	int ret;
 
 	indio_dev->ring = iio_sw_rb_allocate(indio_dev);
-- 
1.6.0.2
