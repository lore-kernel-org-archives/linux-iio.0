Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 023/111] staging:iio:adt7310 move to current event handling
Date: Wed, 18 May 2011 14:41:13 +0100
Message-Id: <1305726161-5606-24-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Another driver that has two event lines, but pushes all events out
the same chrdev. Probably needs a rethink.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/adt7310.c |  155 +++++++++++++++----------------------
 1 files changed, 64 insertions(+), 91 deletions(-)

diff --git a/drivers/staging/iio/adc/adt7310.c b/drivers/staging/iio/adc/adt7310.c
index 7e66c42..9b2a8ec 100644
--- a/drivers/staging/iio/adc/adt7310.c
+++ b/drivers/staging/iio/adc/adt7310.c
@@ -7,15 +7,12 @@
  */
 
 #include <linux/interrupt.h>
-#include <linux/gpio.h>
-#include <linux/workqueue.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/list.h>
 #include <linux/spi/spi.h>
-#include <linux/rtc.h>
 
 #include "../iio.h"
 #include "../sysfs.h"
@@ -85,8 +82,6 @@ struct adt7310_chip_info {
 	const char *name;
 	struct spi_device *spi_dev;
 	struct iio_dev *indio_dev;
-	struct work_struct thresh_work;
-	s64 last_timestamp;
 	u8  config;
 };
 
@@ -413,45 +408,33 @@ static const struct attribute_group adt7310_attribute_group = {
 #define IIO_EVENT_CODE_ADT7310_BELLOW_ALARM   IIO_BUFFER_EVENT_CODE(1)
 #define IIO_EVENT_CODE_ADT7310_ABOVE_CRIT     IIO_BUFFER_EVENT_CODE(2)
 
-static void adt7310_interrupt_bh(struct work_struct *work_s)
+static irqreturn_t adt7310_event_handler(int irq, void *private)
 {
-	struct adt7310_chip_info *chip =
-		container_of(work_s, struct adt7310_chip_info, thresh_work);
+	struct iio_dev *indio_dev = private;
+	struct adt7310_chip_info *chip = iio_dev_get_devdata(indio_dev);
+	s64 timestamp = iio_get_time_ns();
 	u8 status;
+	int ret;
 
-	if (adt7310_spi_read_byte(chip, ADT7310_STATUS, &status))
-		return;
+	ret = adt7310_spi_read_byte(chip, ADT7310_STATUS, &status);
+	if (ret)
+		return ret;
 
 	if (status & ADT7310_STAT_T_HIGH)
-		iio_push_event(chip->indio_dev, 0,
+		iio_push_event(indio_dev, 0,
 			IIO_EVENT_CODE_ADT7310_ABOVE_ALARM,
-			chip->last_timestamp);
+			timestamp);
 	if (status & ADT7310_STAT_T_LOW)
-		iio_push_event(chip->indio_dev, 0,
+		iio_push_event(indio_dev, 0,
 			IIO_EVENT_CODE_ADT7310_BELLOW_ALARM,
-			chip->last_timestamp);
+			timestamp);
 	if (status & ADT7310_STAT_T_CRIT)
-		iio_push_event(chip->indio_dev, 0,
+		iio_push_event(indio_dev, 0,
 			IIO_EVENT_CODE_ADT7310_ABOVE_CRIT,
-			chip->last_timestamp);
-}
-
-static int adt7310_interrupt(struct iio_dev *dev_info,
-		int index,
-		s64 timestamp,
-		int no_test)
-{
-	struct adt7310_chip_info *chip = dev_info->dev_data;
-
-	chip->last_timestamp = timestamp;
-	schedule_work(&chip->thresh_work);
-
-	return 0;
+			timestamp);
+	return IRQ_HANDLED;
 }
 
-IIO_EVENT_SH(adt7310, &adt7310_interrupt);
-IIO_EVENT_SH(adt7310_ct, &adt7310_interrupt);
-
 static ssize_t adt7310_show_event_mode(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
@@ -729,45 +712,51 @@ static inline ssize_t adt7310_set_t_hyst(struct device *dev,
 	return len;
 }
 
-IIO_EVENT_ATTR_SH(event_mode, iio_event_adt7310,
-		adt7310_show_event_mode, adt7310_set_event_mode, 0);
-IIO_EVENT_ATTR_SH(available_event_modes, iio_event_adt7310,
-		adt7310_show_available_event_modes, NULL, 0);
-IIO_EVENT_ATTR_SH(fault_queue, iio_event_adt7310,
-		adt7310_show_fault_queue, adt7310_set_fault_queue, 0);
-IIO_EVENT_ATTR_SH(t_alarm_high, iio_event_adt7310,
-		adt7310_show_t_alarm_high, adt7310_set_t_alarm_high, 0);
-IIO_EVENT_ATTR_SH(t_alarm_low, iio_event_adt7310,
-		adt7310_show_t_alarm_low, adt7310_set_t_alarm_low, 0);
-IIO_EVENT_ATTR_SH(t_crit, iio_event_adt7310_ct,
-		adt7310_show_t_crit, adt7310_set_t_crit, 0);
-IIO_EVENT_ATTR_SH(t_hyst, iio_event_adt7310,
-		adt7310_show_t_hyst, adt7310_set_t_hyst, 0);
+static IIO_DEVICE_ATTR(event_mode,
+		       S_IRUGO | S_IWUSR,
+		       adt7310_show_event_mode, adt7310_set_event_mode, 0);
+static IIO_DEVICE_ATTR(available_event_modes,
+		       S_IRUGO | S_IWUSR,
+		       adt7310_show_available_event_modes, NULL, 0);
+static IIO_DEVICE_ATTR(fault_queue,
+		       S_IRUGO | S_IWUSR,
+		       adt7310_show_fault_queue, adt7310_set_fault_queue, 0);
+static IIO_DEVICE_ATTR(t_alarm_high,
+		       S_IRUGO | S_IWUSR,
+		       adt7310_show_t_alarm_high, adt7310_set_t_alarm_high, 0);
+static IIO_DEVICE_ATTR(t_alarm_low,
+		       S_IRUGO | S_IWUSR,
+		       adt7310_show_t_alarm_low, adt7310_set_t_alarm_low, 0);
+static IIO_DEVICE_ATTR(t_crit,
+		       S_IRUGO | S_IWUSR,
+		       adt7310_show_t_crit, adt7310_set_t_crit, 0);
+static IIO_DEVICE_ATTR(t_hyst,
+		       S_IRUGO | S_IWUSR,
+		       adt7310_show_t_hyst, adt7310_set_t_hyst, 0);
 
 static struct attribute *adt7310_event_int_attributes[] = {
-	&iio_event_attr_event_mode.dev_attr.attr,
-	&iio_event_attr_available_event_modes.dev_attr.attr,
-	&iio_event_attr_fault_queue.dev_attr.attr,
-	&iio_event_attr_t_alarm_high.dev_attr.attr,
-	&iio_event_attr_t_alarm_low.dev_attr.attr,
-	&iio_event_attr_t_hyst.dev_attr.attr,
+	&iio_dev_attr_event_mode.dev_attr.attr,
+	&iio_dev_attr_available_event_modes.dev_attr.attr,
+	&iio_dev_attr_fault_queue.dev_attr.attr,
+	&iio_dev_attr_t_alarm_high.dev_attr.attr,
+	&iio_dev_attr_t_alarm_low.dev_attr.attr,
+	&iio_dev_attr_t_hyst.dev_attr.attr,
 	NULL,
 };
 
 static struct attribute *adt7310_event_ct_attributes[] = {
-	&iio_event_attr_event_mode.dev_attr.attr,
-	&iio_event_attr_available_event_modes.dev_attr.attr,
-	&iio_event_attr_fault_queue.dev_attr.attr,
-	&iio_event_attr_t_crit.dev_attr.attr,
-	&iio_event_attr_t_hyst.dev_attr.attr,
+	&iio_dev_attr_event_mode.dev_attr.attr,
+	&iio_dev_attr_available_event_modes.dev_attr.attr,
+	&iio_dev_attr_fault_queue.dev_attr.attr,
+	&iio_dev_attr_t_crit.dev_attr.attr,
+	&iio_dev_attr_t_hyst.dev_attr.attr,
 	NULL,
 };
 
 static struct attribute_group adt7310_event_attribute_group[ADT7310_IRQS] = {
 	{
 		.attrs = adt7310_event_int_attributes,
-	},
-	{
+	}, {
 		.attrs = adt7310_event_ct_attributes,
 	}
 };
@@ -818,45 +807,29 @@ static int __devinit adt7310_probe(struct spi_device *spi_dev)
 			irq_flags = adt7310_platform_data[2];
 		else
 			irq_flags = IRQF_TRIGGER_LOW;
-		ret = iio_register_interrupt_line(spi_dev->irq,
-				chip->indio_dev,
-				0,
-				irq_flags,
-				chip->name);
+		ret = request_threaded_irq(spi_dev->irq,
+					   NULL,
+					   &adt7310_event_handler,
+					   irq_flags,
+					   chip->name,
+					   chip->indio_dev);
 		if (ret)
 			goto error_unreg_dev;
-
-		/*
-		 * The event handler list element refer to iio_event_adt7310.
-		 * All event attributes bind to the same event handler.
-		 * One event handler can only be added to one event list.
-		 */
-		iio_add_event_to_list(&iio_event_adt7310,
-				&chip->indio_dev->interrupts[0]->ev_list);
 	}
 
 	/* INT bound temperature alarm event. line 1 */
 	if (adt7310_platform_data[0]) {
-		ret = iio_register_interrupt_line(adt7310_platform_data[0],
-				chip->indio_dev,
-				1,
-				adt7310_platform_data[1],
-				chip->name);
+		ret = request_threaded_irq(adt7310_platform_data[0],
+					   NULL,
+					   &adt7310_event_handler,
+					   adt7310_platform_data[1],
+					   chip->name,
+					   chip->indio_dev);
 		if (ret)
 			goto error_unreg_ct_irq;
-
-		/*
-		 * The event handler list element refer to iio_event_adt7310.
-		 * All event attributes bind to the same event handler.
-		 * One event handler can only be added to one event list.
-		 */
-		iio_add_event_to_list(&iio_event_adt7310_ct,
-				&chip->indio_dev->interrupts[1]->ev_list);
 	}
 
 	if (spi_dev->irq && adt7310_platform_data[0]) {
-		INIT_WORK(&chip->thresh_work, adt7310_interrupt_bh);
-
 		ret = adt7310_spi_read_byte(chip, ADT7310_CONFIG, &chip->config);
 		if (ret) {
 			ret = -EIO;
@@ -884,9 +857,9 @@ static int __devinit adt7310_probe(struct spi_device *spi_dev)
 	return 0;
 
 error_unreg_int_irq:
-	iio_unregister_interrupt_line(chip->indio_dev, 1);
+	free_irq(adt7310_platform_data[0], chip->indio_dev);
 error_unreg_ct_irq:
-	iio_unregister_interrupt_line(chip->indio_dev, 0);
+	free_irq(spi_dev->irq, chip->indio_dev);
 error_unreg_dev:
 	iio_device_unregister(chip->indio_dev);
 error_free_dev:
@@ -905,9 +878,9 @@ static int __devexit adt7310_remove(struct spi_device *spi_dev)
 
 	dev_set_drvdata(&spi_dev->dev, NULL);
 	if (adt7310_platform_data[0])
-		iio_unregister_interrupt_line(indio_dev, 1);
+		free_irq(adt7310_platform_data[0], chip->indio_dev);
 	if (spi_dev->irq)
-		iio_unregister_interrupt_line(indio_dev, 0);
+		free_irq(spi_dev->irq, chip->indio_dev);
 	iio_device_unregister(indio_dev);
 	iio_free_device(chip->indio_dev);
 	kfree(chip);
-- 
1.7.3.4
