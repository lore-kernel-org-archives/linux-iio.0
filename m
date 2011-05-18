Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:53894 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933175Ab1ERNkD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 May 2011 09:40:03 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 015/111] staging:iio:adt7316 get rid of legacy event handling code.
Date: Wed, 18 May 2011 14:41:05 +0100
Message-Id: <1305726161-5606-16-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Note this driver is still a long way from being abi compliant.
What I have done here cleans up a few corners, but primarily gets
it away from using the infrastructure that is going away.

Untested

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/addac/adt7316.c |  366 +++++++++-------------------------
 1 files changed, 97 insertions(+), 269 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index d01cb4c..7174e7b 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -176,8 +176,6 @@
 struct adt7316_chip_info {
 	const char		*name;
 	struct iio_dev		*indio_dev;
-	struct work_struct	thresh_work;
-	s64			last_timestamp;
 	struct adt7316_bus	bus;
 	u16			ldac_pin;
 	u16			int_mask;	/* 0x2f */
@@ -1795,10 +1793,10 @@ static const struct attribute_group adt7516_attribute_group = {
 #define IIO_EVENT_CODE_ADT7516_AIN4           IIO_BUFFER_EVENT_CODE(8)
 #define IIO_EVENT_CODE_ADT7316_VDD            IIO_BUFFER_EVENT_CODE(9)
 
-static void adt7316_interrupt_bh(struct work_struct *work_s)
+static irqreturn_t adt7316_event_handler(int irq, void *private)
 {
-	struct adt7316_chip_info *chip =
-		container_of(work_s, struct adt7316_chip_info, thresh_work);
+	struct iio_dev *indio_dev = private;
+	struct adt7316_chip_info *chip = iio_dev_get_devdata(indio_dev);
 	u8 stat1, stat2;
 	int i, ret, count;
 
@@ -1813,7 +1811,7 @@ static void adt7316_interrupt_bh(struct work_struct *work_s)
 			if (stat1 & (1 << i))
 				iio_push_event(chip->indio_dev, 0,
 					IIO_EVENT_CODE_ADT7316_IN_TEMP_HIGH + i,
-					chip->last_timestamp);
+					iio_get_time_ns());
 		}
 	}
 
@@ -1822,27 +1820,12 @@ static void adt7316_interrupt_bh(struct work_struct *work_s)
 		if (stat2 & ADT7316_INT_MASK2_VDD)
 			iio_push_event(chip->indio_dev, 0,
 				IIO_EVENT_CODE_ADT7316_VDD,
-				chip->last_timestamp);
+				       iio_get_time_ns());
 	}
 
-	enable_irq(chip->bus.irq);
+	return IRQ_HANDLED;
 }
 
-static int adt7316_interrupt(struct iio_dev *dev_info,
-		int index,
-		s64 timestamp,
-		int no_test)
-{
-	struct adt7316_chip_info *chip = dev_info->dev_data;
-
-	chip->last_timestamp = timestamp;
-	schedule_work(&chip->thresh_work);
-
-	return 0;
-}
-
-IIO_EVENT_SH(adt7316, &adt7316_interrupt);
-
 /*
  * Show mask of enabled interrupts in Hex.
  */
@@ -1901,9 +1884,9 @@ static ssize_t adt7316_set_int_mask(struct device *dev,
 }
 static inline ssize_t adt7316_show_ad_bound(struct device *dev,
 		struct device_attribute *attr,
-		u8 bound_reg,
 		char *buf)
 {
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
 	struct adt7316_chip_info *chip = dev_info->dev_data;
 	u8 val;
@@ -1911,10 +1894,10 @@ static inline ssize_t adt7316_show_ad_bound(struct device *dev,
 	int ret;
 
 	if ((chip->id & ID_FAMILY_MASK) == ID_ADT73XX &&
-		bound_reg > ADT7316_EX_TEMP_LOW)
+		this_attr->address > ADT7316_EX_TEMP_LOW)
 		return -EPERM;
 
-	ret = chip->bus.read(chip->bus.client, bound_reg, &val);
+	ret = chip->bus.read(chip->bus.client, this_attr->address, &val);
 	if (ret)
 		return -EIO;
 
@@ -1931,10 +1914,10 @@ static inline ssize_t adt7316_show_ad_bound(struct device *dev,
 
 static inline ssize_t adt7316_set_ad_bound(struct device *dev,
 		struct device_attribute *attr,
-		u8 bound_reg,
 		const char *buf,
 		size_t len)
 {
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
 	struct adt7316_chip_info *chip = dev_info->dev_data;
 	long data;
@@ -1942,7 +1925,7 @@ static inline ssize_t adt7316_set_ad_bound(struct device *dev,
 	int ret;
 
 	if ((chip->id & ID_FAMILY_MASK) == ID_ADT73XX &&
-		bound_reg > ADT7316_EX_TEMP_LOW)
+		this_attr->address > ADT7316_EX_TEMP_LOW)
 		return -EPERM;
 
 	ret = strict_strtol(buf, 10, &data);
@@ -1963,183 +1946,13 @@ static inline ssize_t adt7316_set_ad_bound(struct device *dev,
 
 	val = (u8)data;
 
-	ret = chip->bus.write(chip->bus.client, bound_reg, val);
+	ret = chip->bus.write(chip->bus.client, this_attr->address, val);
 	if (ret)
 		return -EIO;
 
 	return len;
 }
 
-static ssize_t adt7316_show_in_temp_high(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	return adt7316_show_ad_bound(dev, attr,
-			ADT7316_IN_TEMP_HIGH, buf);
-}
-
-static inline ssize_t adt7316_set_in_temp_high(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	return adt7316_set_ad_bound(dev, attr,
-			ADT7316_IN_TEMP_HIGH, buf, len);
-}
-
-static ssize_t adt7316_show_in_temp_low(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	return adt7316_show_ad_bound(dev, attr,
-			ADT7316_IN_TEMP_LOW, buf);
-}
-
-static inline ssize_t adt7316_set_in_temp_low(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	return adt7316_set_ad_bound(dev, attr,
-			ADT7316_IN_TEMP_LOW, buf, len);
-}
-
-static ssize_t adt7316_show_ex_temp_ain1_high(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	return adt7316_show_ad_bound(dev, attr,
-			ADT7316_EX_TEMP_HIGH, buf);
-}
-
-static inline ssize_t adt7316_set_ex_temp_ain1_high(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	return adt7316_set_ad_bound(dev, attr,
-			ADT7316_EX_TEMP_HIGH, buf, len);
-}
-
-static ssize_t adt7316_show_ex_temp_ain1_low(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	return adt7316_show_ad_bound(dev, attr,
-			ADT7316_EX_TEMP_LOW, buf);
-}
-
-static inline ssize_t adt7316_set_ex_temp_ain1_low(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	return adt7316_set_ad_bound(dev, attr,
-			ADT7316_EX_TEMP_LOW, buf, len);
-}
-
-static ssize_t adt7316_show_ain2_high(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	return adt7316_show_ad_bound(dev, attr,
-			ADT7516_AIN2_HIGH, buf);
-}
-
-static inline ssize_t adt7316_set_ain2_high(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	return adt7316_set_ad_bound(dev, attr,
-			ADT7516_AIN2_HIGH, buf, len);
-}
-
-static ssize_t adt7316_show_ain2_low(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	return adt7316_show_ad_bound(dev, attr,
-			ADT7516_AIN2_LOW, buf);
-}
-
-static inline ssize_t adt7316_set_ain2_low(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	return adt7316_set_ad_bound(dev, attr,
-			ADT7516_AIN2_LOW, buf, len);
-}
-
-static ssize_t adt7316_show_ain3_high(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	return adt7316_show_ad_bound(dev, attr,
-			ADT7516_AIN3_HIGH, buf);
-}
-
-static inline ssize_t adt7316_set_ain3_high(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	return adt7316_set_ad_bound(dev, attr,
-			ADT7516_AIN3_HIGH, buf, len);
-}
-
-static ssize_t adt7316_show_ain3_low(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	return adt7316_show_ad_bound(dev, attr,
-			ADT7516_AIN3_LOW, buf);
-}
-
-static inline ssize_t adt7316_set_ain3_low(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	return adt7316_set_ad_bound(dev, attr,
-			ADT7516_AIN3_LOW, buf, len);
-}
-
-static ssize_t adt7316_show_ain4_high(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	return adt7316_show_ad_bound(dev, attr,
-			ADT7516_AIN4_HIGH, buf);
-}
-
-static inline ssize_t adt7316_set_ain4_high(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	return adt7316_set_ad_bound(dev, attr,
-			ADT7516_AIN4_HIGH, buf, len);
-}
-
-static ssize_t adt7316_show_ain4_low(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	return adt7316_show_ad_bound(dev, attr,
-			ADT7516_AIN4_LOW, buf);
-}
-
-static inline ssize_t adt7316_set_ain4_low(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	return adt7316_set_ad_bound(dev, attr,
-			ADT7516_AIN4_LOW, buf, len);
-}
-
 static ssize_t adt7316_show_int_enabled(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
@@ -2173,47 +1986,72 @@ static ssize_t adt7316_set_int_enabled(struct device *dev,
 	return len;
 }
 
-
-IIO_EVENT_ATTR_SH(int_mask, iio_event_adt7316,
-		adt7316_show_int_mask, adt7316_set_int_mask, 0);
-IIO_EVENT_ATTR_SH(in_temp_high, iio_event_adt7316,
-		adt7316_show_in_temp_high, adt7316_set_in_temp_high, 0);
-IIO_EVENT_ATTR_SH(in_temp_low, iio_event_adt7316,
-		adt7316_show_in_temp_low, adt7316_set_in_temp_low, 0);
-IIO_EVENT_ATTR_SH(ex_temp_high, iio_event_adt7316,
-		adt7316_show_ex_temp_ain1_high,
-		adt7316_set_ex_temp_ain1_high, 0);
-IIO_EVENT_ATTR_SH(ex_temp_low, iio_event_adt7316,
-		adt7316_show_ex_temp_ain1_low,
-		adt7316_set_ex_temp_ain1_low, 0);
-IIO_EVENT_ATTR_SH(ex_temp_ain1_high, iio_event_adt7316,
-		adt7316_show_ex_temp_ain1_high,
-		adt7316_set_ex_temp_ain1_high, 0);
-IIO_EVENT_ATTR_SH(ex_temp_ain1_low, iio_event_adt7316,
-		adt7316_show_ex_temp_ain1_low,
-		adt7316_set_ex_temp_ain1_low, 0);
-IIO_EVENT_ATTR_SH(ain2_high, iio_event_adt7316,
-		adt7316_show_ain2_high, adt7316_set_ain2_high, 0);
-IIO_EVENT_ATTR_SH(ain2_low, iio_event_adt7316,
-		adt7316_show_ain2_low, adt7316_set_ain2_low, 0);
-IIO_EVENT_ATTR_SH(ain3_high, iio_event_adt7316,
-		adt7316_show_ain3_high, adt7316_set_ain3_high, 0);
-IIO_EVENT_ATTR_SH(ain3_low, iio_event_adt7316,
-		adt7316_show_ain3_low, adt7316_set_ain3_low, 0);
-IIO_EVENT_ATTR_SH(ain4_high, iio_event_adt7316,
-		adt7316_show_ain4_high, adt7316_set_ain4_high, 0);
-IIO_EVENT_ATTR_SH(ain4_low, iio_event_adt7316,
-		adt7316_show_ain4_low, adt7316_set_ain4_low, 0);
-IIO_EVENT_ATTR_SH(int_enabled, iio_event_adt7316,
-		adt7316_show_int_enabled, adt7316_set_int_enabled, 0);
+static IIO_DEVICE_ATTR(int_mask,
+		       S_IRUGO | S_IWUSR,
+		       adt7316_show_int_mask, adt7316_set_int_mask,
+		       0);
+static IIO_DEVICE_ATTR(in_temp_high_value,
+		       S_IRUGO | S_IWUSR,
+		       adt7316_show_ad_bound, adt7316_set_ad_bound,
+		       ADT7316_IN_TEMP_HIGH);
+static IIO_DEVICE_ATTR(in_temp_low_value,
+		       S_IRUGO | S_IWUSR,
+		       adt7316_show_ad_bound, adt7316_set_ad_bound,
+		       ADT7316_IN_TEMP_LOW);
+static IIO_DEVICE_ATTR(ex_temp_high_value,
+		       S_IRUGO | S_IWUSR,
+		       adt7316_show_ad_bound, adt7316_set_ad_bound,
+		       ADT7316_EX_TEMP_HIGH);
+static IIO_DEVICE_ATTR(ex_temp_low_value,
+		       S_IRUGO | S_IWUSR,
+		       adt7316_show_ad_bound, adt7316_set_ad_bound,
+		       ADT7316_EX_TEMP_LOW);
+
+/* NASTY duplication to be fixed */
+static IIO_DEVICE_ATTR(ex_temp_ain1_high_value,
+		       S_IRUGO | S_IWUSR,
+		       adt7316_show_ad_bound, adt7316_set_ad_bound,
+		       ADT7316_EX_TEMP_HIGH);
+static IIO_DEVICE_ATTR(ex_temp_ain1_low_value,
+		       S_IRUGO | S_IWUSR,
+		       adt7316_show_ad_bound, adt7316_set_ad_bound,
+		       ADT7316_EX_TEMP_LOW);
+static IIO_DEVICE_ATTR(ain2_high_value,
+		       S_IRUGO | S_IWUSR,
+		       adt7316_show_ad_bound, adt7316_set_ad_bound,
+		       ADT7516_AIN2_HIGH);
+static IIO_DEVICE_ATTR(ain2_low_value,
+		       S_IRUGO | S_IWUSR,
+		       adt7316_show_ad_bound, adt7316_set_ad_bound,
+		       ADT7516_AIN2_LOW);
+static IIO_DEVICE_ATTR(ain3_high_value,
+		       S_IRUGO | S_IWUSR,
+		       adt7316_show_ad_bound, adt7316_set_ad_bound,
+		       ADT7516_AIN3_HIGH);
+static IIO_DEVICE_ATTR(ain3_low_value,
+		       S_IRUGO | S_IWUSR,
+		       adt7316_show_ad_bound, adt7316_set_ad_bound,
+		       ADT7516_AIN3_LOW);
+static IIO_DEVICE_ATTR(ain4_high_value,
+		       S_IRUGO | S_IWUSR,
+		       adt7316_show_ad_bound, adt7316_set_ad_bound,
+		       ADT7516_AIN4_HIGH);
+static IIO_DEVICE_ATTR(ain4_low_value,
+		       S_IRUGO | S_IWUSR,
+		       adt7316_show_ad_bound, adt7316_set_ad_bound,
+		       ADT7516_AIN4_LOW);
+static IIO_DEVICE_ATTR(int_enabled,
+		       S_IRUGO | S_IWUSR,
+		       adt7316_show_int_enabled,
+		       adt7316_set_int_enabled, 0);
 
 static struct attribute *adt7316_event_attributes[] = {
-	&iio_event_attr_int_mask.dev_attr.attr,
-	&iio_event_attr_in_temp_high.dev_attr.attr,
-	&iio_event_attr_in_temp_low.dev_attr.attr,
-	&iio_event_attr_ex_temp_high.dev_attr.attr,
-	&iio_event_attr_ex_temp_low.dev_attr.attr,
-	&iio_event_attr_int_enabled.dev_attr.attr,
+	&iio_dev_attr_int_mask.dev_attr.attr,
+	&iio_dev_attr_in_temp_high_value.dev_attr.attr,
+	&iio_dev_attr_in_temp_low_value.dev_attr.attr,
+	&iio_dev_attr_ex_temp_high_value.dev_attr.attr,
+	&iio_dev_attr_ex_temp_low_value.dev_attr.attr,
+	&iio_dev_attr_int_enabled.dev_attr.attr,
 	NULL,
 };
 
@@ -2222,18 +2060,18 @@ static struct attribute_group adt7316_event_attribute_group = {
 };
 
 static struct attribute *adt7516_event_attributes[] = {
-	&iio_event_attr_int_mask.dev_attr.attr,
-	&iio_event_attr_in_temp_high.dev_attr.attr,
-	&iio_event_attr_in_temp_low.dev_attr.attr,
-	&iio_event_attr_ex_temp_ain1_high.dev_attr.attr,
-	&iio_event_attr_ex_temp_ain1_low.dev_attr.attr,
-	&iio_event_attr_ain2_high.dev_attr.attr,
-	&iio_event_attr_ain2_low.dev_attr.attr,
-	&iio_event_attr_ain3_high.dev_attr.attr,
-	&iio_event_attr_ain3_low.dev_attr.attr,
-	&iio_event_attr_ain4_high.dev_attr.attr,
-	&iio_event_attr_ain4_low.dev_attr.attr,
-	&iio_event_attr_int_enabled.dev_attr.attr,
+	&iio_dev_attr_int_mask.dev_attr.attr,
+	&iio_dev_attr_in_temp_high_value.dev_attr.attr,
+	&iio_dev_attr_in_temp_low_value.dev_attr.attr,
+	&iio_dev_attr_ex_temp_ain1_high_value.dev_attr.attr,
+	&iio_dev_attr_ex_temp_ain1_low_value.dev_attr.attr,
+	&iio_dev_attr_ain2_high_value.dev_attr.attr,
+	&iio_dev_attr_ain2_low_value.dev_attr.attr,
+	&iio_dev_attr_ain3_high_value.dev_attr.attr,
+	&iio_dev_attr_ain3_low_value.dev_attr.attr,
+	&iio_dev_attr_ain4_high_value.dev_attr.attr,
+	&iio_dev_attr_ain4_low_value.dev_attr.attr,
+	&iio_dev_attr_int_enabled.dev_attr.attr,
 	NULL,
 };
 
@@ -2326,24 +2164,15 @@ int __devinit adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 		if (adt7316_platform_data[0])
 			chip->bus.irq_flags = adt7316_platform_data[0];
 
-		ret = iio_register_interrupt_line(chip->bus.irq,
-				chip->indio_dev,
-				0,
-				chip->bus.irq_flags,
-				chip->name);
+		ret = request_threaded_irq(chip->bus.irq,
+					   NULL,
+					   &adt7316_event_handler,
+					   chip->bus.irq_flags | IRQF_ONESHOT,
+					   chip->name,
+					   chip->indio_dev);
 		if (ret)
 			goto error_unreg_dev;
 
-		/*
-		 * The event handler list element refer to iio_event_adt7316.
-		 * All event attributes bind to the same event handler.
-		 * So, only register event handler once.
-		 */
-		iio_add_event_to_list(&iio_event_adt7316,
-				&chip->indio_dev->interrupts[0]->ev_list);
-
-		INIT_WORK(&chip->thresh_work, adt7316_interrupt_bh);
-
 		if (chip->bus.irq_flags & IRQF_TRIGGER_HIGH)
 			chip->config1 |= ADT7316_INT_POLARITY;
 	}
@@ -2366,7 +2195,7 @@ int __devinit adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 	return 0;
 
 error_unreg_irq:
-	iio_unregister_interrupt_line(chip->indio_dev, 0);
+	free_irq(chip->bus.irq, chip->indio_dev);
 error_unreg_dev:
 	iio_device_unregister(chip->indio_dev);
 error_free_dev:
@@ -2383,12 +2212,11 @@ int __devexit adt7316_remove(struct device *dev)
 
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
 	struct adt7316_chip_info *chip = dev_info->dev_data;
-	struct iio_dev *indio_dev = chip->indio_dev;
 
 	dev_set_drvdata(dev, NULL);
 	if (chip->bus.irq)
-		iio_unregister_interrupt_line(indio_dev, 0);
-	iio_device_unregister(indio_dev);
+		free_irq(chip->bus.irq, chip->indio_dev);
+	iio_device_unregister(chip->indio_dev);
 	iio_free_device(chip->indio_dev);
 	kfree(chip);
 
-- 
1.7.3.4

