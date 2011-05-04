Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:57820 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754361Ab1EDL46 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 May 2011 07:56:58 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de, Michael.Hennerich@analog.com,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 92/99] staging:iio:adc: AD7606: Drop dev_data in favour of iio_priv()
Date: Wed,  4 May 2011 12:59:04 +0100
Message-Id: <1304510351-10922-93-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

Some other small cleanups including excess header removals.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7606.h      |    2 +-
 drivers/staging/iio/adc/ad7606_core.c |   22 ++++++++++------------
 drivers/staging/iio/adc/ad7606_ring.c |   11 +++++------
 3 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
index db76bfd..22cccc7 100644
--- a/drivers/staging/iio/adc/ad7606.h
+++ b/drivers/staging/iio/adc/ad7606.h
@@ -109,7 +109,7 @@ enum ad7606_supported_device_ids {
 	ID_AD7606_4
 };
 
-int ad7606_scan_from_ring(struct ad7606_state *st, unsigned ch);
+int ad7606_scan_from_ring(struct iio_dev *indio_dev, unsigned ch);
 int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev);
 void ad7606_ring_cleanup(struct iio_dev *indio_dev);
 #endif /* IIO_ADC_AD7606_H_ */
diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index 0db11f1..fb96802 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -7,12 +7,10 @@
  */
 
 #include <linux/interrupt.h>
-#include <linux/workqueue.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
-#include <linux/list.h>
 #include <linux/regulator/consumer.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
@@ -38,8 +36,9 @@ int ad7606_reset(struct ad7606_state *st)
 	return -ENODEV;
 }
 
-static int ad7606_scan_direct(struct ad7606_state *st, unsigned ch)
+static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned ch)
 {
+	struct ad7606_state *st = iio_priv(indio_dev);
 	int ret;
 
 	st->done = false;
@@ -85,16 +84,16 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
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
@@ -115,7 +114,7 @@ static ssize_t ad7606_show_range(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad7606_state *st = iio_dev_get_devdata(indio_dev);
+	struct ad7606_state *st = iio_priv(indio_dev);
 
 	return sprintf(buf, "%u\n", st->range);
 }
@@ -124,7 +123,7 @@ static ssize_t ad7606_store_range(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad7606_state *st = iio_dev_get_devdata(indio_dev);
+	struct ad7606_state *st = iio_priv(indio_dev);
 	unsigned long lval;
 
 	if (strict_strtoul(buf, 10, &lval))
@@ -149,7 +148,7 @@ static ssize_t ad7606_show_oversampling_ratio(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad7606_state *st = iio_dev_get_devdata(indio_dev);
+	struct ad7606_state *st = iio_priv(indio_dev);
 
 	return sprintf(buf, "%u\n", st->oversampling);
 }
@@ -170,7 +169,7 @@ static ssize_t ad7606_store_oversampling_ratio(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad7606_state *st = iio_dev_get_devdata(indio_dev);
+	struct ad7606_state *st = iio_priv(indio_dev);
 	unsigned long lval;
 	int ret;
 
@@ -211,7 +210,7 @@ static mode_t ad7606_attr_is_visible(struct kobject *kobj,
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad7606_state *st = iio_dev_get_devdata(indio_dev);
+	struct ad7606_state *st = iio_priv(indio_dev);
 
 	mode_t mode = attr->mode;
 
@@ -472,7 +471,6 @@ struct iio_dev *ad7606_probe(struct device *dev, int irq,
 
 	indio_dev->dev.parent = dev;
 	indio_dev->attrs = &ad7606_attribute_group;
-	indio_dev->dev_data = (void *)(st);
 	indio_dev->driver_module = THIS_MODULE;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->name = st->chip_info->name;
diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
index 925806c..85cde6a 100644
--- a/drivers/staging/iio/adc/ad7606_ring.c
+++ b/drivers/staging/iio/adc/ad7606_ring.c
@@ -7,7 +7,6 @@
 
 #include <linux/interrupt.h>
 #include <linux/gpio.h>
-#include <linux/workqueue.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -21,9 +20,9 @@
 
 #include "ad7606.h"
 
-int ad7606_scan_from_ring(struct ad7606_state *st, unsigned ch)
+int ad7606_scan_from_ring(struct iio_dev *indio_dev, unsigned ch)
 {
-	struct iio_ring_buffer *ring = iio_priv_to_dev(st)->ring;
+	struct iio_ring_buffer *ring = indio_dev->ring;
 	int ret;
 	u16 *ring_data;
 
@@ -54,7 +53,7 @@ error_ret:
  **/
 static int ad7606_ring_preenable(struct iio_dev *indio_dev)
 {
-	struct ad7606_state *st = indio_dev->dev_data;
+	struct ad7606_state *st = iio_priv(indio_dev);
 	struct iio_ring_buffer *ring = indio_dev->ring;
 	size_t d_size;
 
@@ -84,7 +83,7 @@ static irqreturn_t ad7606_trigger_handler_th_bh(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->private_data;
-	struct ad7606_state *st = indio_dev->dev_data;
+	struct ad7606_state *st = iio_priv(indio_dev);
 
 	gpio_set_value(st->pdata->gpio_convst, 1);
 
@@ -159,7 +158,7 @@ static const struct iio_ring_setup_ops ad7606_ring_setup_ops = {
 
 int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 {
-	struct ad7606_state *st = indio_dev->dev_data;
+	struct ad7606_state *st = iio_priv(indio_dev);
 	int ret;
 
 	indio_dev->ring = iio_sw_rb_allocate(indio_dev);
-- 
1.7.3.4

