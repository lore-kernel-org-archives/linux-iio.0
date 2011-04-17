Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 20/70] staging:iio:adc:adt75 old to new event handling conversion
Date: Sun, 17 Apr 2011 20:05:53 +0100
Message-Id: <1303067203-4894-21-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1303067203-4894-1-git-send-email-jic23@cam.ac.uk>
References: <1303067203-4894-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Another one where the events are 'unusual'.  Still left sorting
that out for another day.

Untested changes

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/adt75.c |  142 ++++++++++++---------------------------
 1 files changed, 43 insertions(+), 99 deletions(-)

diff --git a/drivers/staging/iio/adc/adt75.c b/drivers/staging/iio/adc/adt75.c
index f247c4c..cf0e5e4 100644
--- a/drivers/staging/iio/adc/adt75.c
+++ b/drivers/staging/iio/adc/adt75.c
@@ -8,14 +8,12 @@
 
 #include <linux/interrupt.h>
 #include <linux/gpio.h>
-#include <linux/workqueue.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/list.h>
 #include <linux/i2c.h>
-#include <linux/rtc.h>
 
 #include "../iio.h"
 #include "../sysfs.h"
@@ -57,8 +55,6 @@ struct adt75_chip_info {
 	const char *name;
 	struct i2c_client *client;
 	struct iio_dev *indio_dev;
-	struct work_struct thresh_work;
-	s64 last_timestamp;
 	u8  config;
 };
 
@@ -279,33 +275,15 @@ static const struct attribute_group adt75_attribute_group = {
 
 #define IIO_EVENT_CODE_ADT75_OTI    IIO_BUFFER_EVENT_CODE(0)
 
-static void adt75_interrupt_bh(struct work_struct *work_s)
+static irqreturn_t adt75_event_handler(int irq, void *private)
 {
-	struct adt75_chip_info *chip =
-		container_of(work_s, struct adt75_chip_info, thresh_work);
+	iio_push_event(private, 0,
+		       IIO_EVENT_CODE_ADT75_OTI,
+		       iio_get_time_ns());
 
-	enable_irq(chip->client->irq);
-
-	iio_push_event(chip->indio_dev, 0,
-			IIO_EVENT_CODE_ADT75_OTI,
-			chip->last_timestamp);
-}
-
-static int adt75_interrupt(struct iio_dev *dev_info,
-		int index,
-		s64 timestamp,
-		int no_test)
-{
-	struct adt75_chip_info *chip = dev_info->dev_data;
-
-	chip->last_timestamp = timestamp;
-	schedule_work(&chip->thresh_work);
-
-	return 0;
+	return IRQ_HANDLED;
 }
 
-IIO_EVENT_SH(adt75, &adt75_interrupt);
-
 static ssize_t adt75_show_oti_mode(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
@@ -458,16 +436,16 @@ static ssize_t adt75_set_fault_queue(struct device *dev,
 }
 static inline ssize_t adt75_show_t_bound(struct device *dev,
 		struct device_attribute *attr,
-		u8 bound_reg,
 		char *buf)
 {
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
 	struct adt75_chip_info *chip = dev_info->dev_data;
 	u16 data;
 	char sign = ' ';
 	int ret;
 
-	ret = adt75_i2c_read(chip, bound_reg, (u8 *)&data);
+	ret = adt75_i2c_read(chip, this_attr->address, (u8 *)&data);
 	if (ret)
 		return -EIO;
 
@@ -485,10 +463,10 @@ static inline ssize_t adt75_show_t_bound(struct device *dev,
 
 static inline ssize_t adt75_set_t_bound(struct device *dev,
 		struct device_attribute *attr,
-		u8 bound_reg,
 		const char *buf,
 		size_t len)
 {
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
 	struct adt75_chip_info *chip = dev_info->dev_data;
 	long tmp1, tmp2;
@@ -525,67 +503,42 @@ static inline ssize_t adt75_set_t_bound(struct device *dev,
 	data <<= ADT75_VALUE_OFFSET;
 	data = swab16(data);
 
-	ret = adt75_i2c_write(chip, bound_reg, (u8)data);
+	ret = adt75_i2c_write(chip, this_attr->address, (u8)data);
 	if (ret)
 		return -EIO;
 
 	return ret;
 }
 
-static ssize_t adt75_show_t_os(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	return adt75_show_t_bound(dev, attr,
-			ADT75_T_OS, buf);
-}
-
-static inline ssize_t adt75_set_t_os(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	return adt75_set_t_bound(dev, attr,
-			ADT75_T_OS, buf, len);
-}
-
-static ssize_t adt75_show_t_hyst(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	return adt75_show_t_bound(dev, attr,
-			ADT75_T_HYST, buf);
-}
-
-static inline ssize_t adt75_set_t_hyst(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	return adt75_set_t_bound(dev, attr,
-			ADT75_T_HYST, buf, len);
-}
 
-IIO_EVENT_ATTR_SH(oti_mode, iio_event_adt75,
-		adt75_show_oti_mode, adt75_set_oti_mode, 0);
-IIO_EVENT_ATTR_SH(available_oti_modes, iio_event_adt75,
-		adt75_show_available_oti_modes, NULL, 0);
-IIO_EVENT_ATTR_SH(smbus_alart, iio_event_adt75,
-		adt75_show_smbus_alart, adt75_set_smbus_alart, 0);
-IIO_EVENT_ATTR_SH(fault_queue, iio_event_adt75,
-		adt75_show_fault_queue, adt75_set_fault_queue, 0);
-IIO_EVENT_ATTR_SH(t_os, iio_event_adt75,
-		adt75_show_t_os, adt75_set_t_os, 0);
-IIO_EVENT_ATTR_SH(t_hyst, iio_event_adt75,
-		adt75_show_t_hyst, adt75_set_t_hyst, 0);
+static IIO_DEVICE_ATTR(oti_mode,
+		       S_IRUGO | S_IWUSR,
+		       adt75_show_oti_mode, adt75_set_oti_mode, 0);
+static IIO_DEVICE_ATTR(available_oti_modes,
+		       S_IRUGO,
+		       adt75_show_available_oti_modes, NULL, 0);
+static IIO_DEVICE_ATTR(smbus_alart,
+		       S_IRUGO | S_IWUSR,
+		       adt75_show_smbus_alart, adt75_set_smbus_alart, 0);
+static IIO_DEVICE_ATTR(fault_queue,
+		       S_IRUGO | S_IWUSR,
+		       adt75_show_fault_queue, adt75_set_fault_queue, 0);
+static IIO_DEVICE_ATTR(t_os_value,
+		       S_IRUGO | S_IWUSR,
+		       adt75_show_t_bound, adt75_set_t_bound,
+		       ADT75_T_OS);
+static IIO_DEVICE_ATTR(t_hyst_value,
+		       S_IRUGO | S_IWUSR,
+		       adt75_show_t_bound, adt75_set_t_bound,
+		       ADT75_T_HYST);
 
 static struct attribute *adt75_event_attributes[] = {
-	&iio_event_attr_oti_mode.dev_attr.attr,
-	&iio_event_attr_available_oti_modes.dev_attr.attr,
-	&iio_event_attr_smbus_alart.dev_attr.attr,
-	&iio_event_attr_fault_queue.dev_attr.attr,
-	&iio_event_attr_t_os.dev_attr.attr,
-	&iio_event_attr_t_hyst.dev_attr.attr,
+	&iio_dev_attr_oti_mode.dev_attr.attr,
+	&iio_dev_attr_available_oti_modes.dev_attr.attr,
+	&iio_dev_attr_smbus_alart.dev_attr.attr,
+	&iio_dev_attr_fault_queue.dev_attr.attr,
+	&iio_dev_attr_t_os_value.dev_attr.attr,
+	&iio_dev_attr_t_hyst_value.dev_attr.attr,
 	NULL,
 };
 
@@ -633,24 +586,15 @@ static int __devinit adt75_probe(struct i2c_client *client,
 		goto error_free_dev;
 
 	if (client->irq > 0) {
-		ret = iio_register_interrupt_line(client->irq,
-				chip->indio_dev,
-				0,
-				IRQF_TRIGGER_LOW,
-				chip->name);
+		ret = request_threaded_irq(client->irq,
+					   NULL,
+					   &adt75_event_handler,
+					   IRQF_TRIGGER_LOW,
+					   chip->name,
+					   chip->indio_dev);
 		if (ret)
 			goto error_unreg_dev;
 
-		/*
-		 * The event handler list element refer to iio_event_adt75.
-		 * All event attributes bind to the same event handler.
-		 * So, only register event handler once.
-		 */
-		iio_add_event_to_list(&iio_event_adt75,
-				&chip->indio_dev->interrupts[0]->ev_list);
-
-		INIT_WORK(&chip->thresh_work, adt75_interrupt_bh);
-
 		ret = adt75_i2c_read(chip, ADT75_CONFIG, &chip->config);
 		if (ret) {
 			ret = -EIO;
@@ -672,7 +616,7 @@ static int __devinit adt75_probe(struct i2c_client *client,
 
 	return 0;
 error_unreg_irq:
-	iio_unregister_interrupt_line(chip->indio_dev, 0);
+	free_irq(client->irq, chip->indio_dev);
 error_unreg_dev:
 	iio_device_unregister(chip->indio_dev);
 error_free_dev:
@@ -689,7 +633,7 @@ static int __devexit adt75_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = chip->indio_dev;
 
 	if (client->irq)
-		iio_unregister_interrupt_line(indio_dev, 0);
+		free_irq(client->irq, chip->indio_dev);
 	iio_device_unregister(indio_dev);
 	iio_free_device(chip->indio_dev);
 	kfree(chip);
-- 
1.7.3.4
