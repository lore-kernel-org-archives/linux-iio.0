Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de,
	Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 22/99] staging:iio:adc:adt7410 move to current event handling
Date: Wed,  4 May 2011 12:57:54 +0100
Message-Id: <1304510351-10922-23-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This device actually has a pair of interrupts. The code basically ignores
that and feeds them both to the same handlers.  I'm not sure if that is
the right thing to do, but the updated code should do exactly the same.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/adt7410.c |  151 +++++++++++++++----------------------
 1 files changed, 61 insertions(+), 90 deletions(-)

diff --git a/drivers/staging/iio/adc/adt7410.c b/drivers/staging/iio/adc/adt7410.c
index 7cc3feb..dc59130 100644
--- a/drivers/staging/iio/adc/adt7410.c
+++ b/drivers/staging/iio/adc/adt7410.c
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
 #include <linux/i2c.h>
-#include <linux/rtc.h>
 
 #include "../iio.h"
 #include "../sysfs.h"
@@ -80,8 +77,6 @@ struct adt7410_chip_info {
 	const char *name;
 	struct i2c_client *client;
 	struct iio_dev *indio_dev;
-	struct work_struct thresh_work;
-	s64 last_timestamp;
 	u8  config;
 };
 
@@ -381,47 +376,32 @@ static const struct attribute_group adt7410_attribute_group = {
 #define IIO_EVENT_CODE_ADT7410_BELLOW_ALARM   IIO_BUFFER_EVENT_CODE(1)
 #define IIO_EVENT_CODE_ADT7410_ABOVE_CRIT     IIO_BUFFER_EVENT_CODE(2)
 
-static void adt7410_interrupt_bh(struct work_struct *work_s)
+static irqreturn_t adt7410_event_handler(int irq, void *private)
 {
-	struct adt7410_chip_info *chip =
-		container_of(work_s, struct adt7410_chip_info, thresh_work);
+	struct iio_dev *indio_dev = private;
+	struct adt7410_chip_info *chip = iio_dev_get_devdata(indio_dev);
+	s64 timestamp = iio_get_time_ns();
 	u8 status;
 
 	if (adt7410_i2c_read_byte(chip, ADT7410_STATUS, &status))
-		return;
-
-	enable_irq(chip->client->irq);
+		return IRQ_HANDLED;
 
 	if (status & ADT7410_STAT_T_HIGH)
-		iio_push_event(chip->indio_dev, 0,
+		iio_push_event(indio_dev, 0,
 			IIO_EVENT_CODE_ADT7410_ABOVE_ALARM,
-			chip->last_timestamp);
+			timestamp);
 	if (status & ADT7410_STAT_T_LOW)
-		iio_push_event(chip->indio_dev, 0,
+		iio_push_event(indio_dev, 0,
 			IIO_EVENT_CODE_ADT7410_BELLOW_ALARM,
-			chip->last_timestamp);
+			timestamp);
 	if (status & ADT7410_STAT_T_CRIT)
-		iio_push_event(chip->indio_dev, 0,
+		iio_push_event(indio_dev, 0,
 			IIO_EVENT_CODE_ADT7410_ABOVE_CRIT,
-			chip->last_timestamp);
-}
-
-static int adt7410_interrupt(struct iio_dev *dev_info,
-		int index,
-		s64 timestamp,
-		int no_test)
-{
-	struct adt7410_chip_info *chip = dev_info->dev_data;
-
-	chip->last_timestamp = timestamp;
-	schedule_work(&chip->thresh_work);
+			timestamp);
 
-	return 0;
+	return IRQ_HANDLED;
 }
 
-IIO_EVENT_SH(adt7410, &adt7410_interrupt);
-IIO_EVENT_SH(adt7410_ct, &adt7410_interrupt);
-
 static ssize_t adt7410_show_event_mode(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
@@ -699,45 +679,51 @@ static inline ssize_t adt7410_set_t_hyst(struct device *dev,
 	return ret;
 }
 
-IIO_EVENT_ATTR_SH(event_mode, iio_event_adt7410,
-		adt7410_show_event_mode, adt7410_set_event_mode, 0);
-IIO_EVENT_ATTR_SH(available_event_modes, iio_event_adt7410,
-		adt7410_show_available_event_modes, NULL, 0);
-IIO_EVENT_ATTR_SH(fault_queue, iio_event_adt7410,
-		adt7410_show_fault_queue, adt7410_set_fault_queue, 0);
-IIO_EVENT_ATTR_SH(t_alarm_high, iio_event_adt7410,
-		adt7410_show_t_alarm_high, adt7410_set_t_alarm_high, 0);
-IIO_EVENT_ATTR_SH(t_alarm_low, iio_event_adt7410,
-		adt7410_show_t_alarm_low, adt7410_set_t_alarm_low, 0);
-IIO_EVENT_ATTR_SH(t_crit, iio_event_adt7410_ct,
-		adt7410_show_t_crit, adt7410_set_t_crit, 0);
-IIO_EVENT_ATTR_SH(t_hyst, iio_event_adt7410,
-		adt7410_show_t_hyst, adt7410_set_t_hyst, 0);
+static IIO_DEVICE_ATTR(event_mode,
+		       S_IRUGO | S_IWUSR,
+		       adt7410_show_event_mode, adt7410_set_event_mode, 0);
+static IIO_DEVICE_ATTR(available_event_modes,
+		       S_IRUGO,
+		       adt7410_show_available_event_modes, NULL, 0);
+static IIO_DEVICE_ATTR(fault_queue,
+		       S_IRUGO | S_IWUSR,
+		       adt7410_show_fault_queue, adt7410_set_fault_queue, 0);
+static IIO_DEVICE_ATTR(t_alarm_high,
+		       S_IRUGO | S_IWUSR,
+		       adt7410_show_t_alarm_high, adt7410_set_t_alarm_high, 0);
+static IIO_DEVICE_ATTR(t_alarm_low,
+		       S_IRUGO | S_IWUSR,
+		       adt7410_show_t_alarm_low, adt7410_set_t_alarm_low, 0);
+static IIO_DEVICE_ATTR(t_crit,
+		       S_IRUGO | S_IWUSR,
+		       adt7410_show_t_crit, adt7410_set_t_crit, 0);
+static IIO_DEVICE_ATTR(t_hyst,
+		       S_IRUGO | S_IWUSR,
+		       adt7410_show_t_hyst, adt7410_set_t_hyst, 0);
 
 static struct attribute *adt7410_event_int_attributes[] = {
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
 
 static struct attribute *adt7410_event_ct_attributes[] = {
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
 
 static struct attribute_group adt7410_event_attribute_group[ADT7410_IRQS] = {
 	{
 		.attrs = adt7410_event_int_attributes,
-	},
-	{
+	}, {
 		.attrs = adt7410_event_ct_attributes,
 	}
 };
@@ -784,44 +770,29 @@ static int __devinit adt7410_probe(struct i2c_client *client,
 
 	/* CT critcal temperature event. line 0 */
 	if (client->irq) {
-		ret = iio_register_interrupt_line(client->irq,
-				chip->indio_dev,
-				0,
-				IRQF_TRIGGER_LOW,
-				chip->name);
+		ret = request_threaded_irq(client->irq,
+					   NULL,
+					   &adt7410_event_handler,
+					   IRQF_TRIGGER_LOW,
+					   chip->name,
+					   chip->indio_dev);
 		if (ret)
 			goto error_unreg_dev;
-
-		/*
-		 * The event handler list element refer to iio_event_adt7410.
-		 * All event attributes bind to the same event handler.
-		 * One event handler can only be added to one event list.
-		 */
-		iio_add_event_to_list(&iio_event_adt7410,
-				&chip->indio_dev->interrupts[0]->ev_list);
 	}
 
 	/* INT bound temperature alarm event. line 1 */
 	if (adt7410_platform_data[0]) {
-		ret = iio_register_interrupt_line(adt7410_platform_data[0],
-				chip->indio_dev,
-				1,
-				adt7410_platform_data[1],
-				chip->name);
+		ret = request_threaded_irq(adt7410_platform_data[0],
+					   NULL,
+					   &adt7410_event_handler,
+					   adt7410_platform_data[1],
+					   chip->name,
+					   chip->indio_dev);
 		if (ret)
 			goto error_unreg_ct_irq;
-
-		/*
-		 * The event handler list element refer to iio_event_adt7410.
-		 * All event attributes bind to the same event handler.
-		 * One event handler can only be added to one event list.
-		 */
-		iio_add_event_to_list(&iio_event_adt7410_ct,
-				&chip->indio_dev->interrupts[1]->ev_list);
 	}
 
 	if (client->irq && adt7410_platform_data[0]) {
-		INIT_WORK(&chip->thresh_work, adt7410_interrupt_bh);
 
 		ret = adt7410_i2c_read_byte(chip, ADT7410_CONFIG, &chip->config);
 		if (ret) {
@@ -850,9 +821,9 @@ static int __devinit adt7410_probe(struct i2c_client *client,
 	return 0;
 
 error_unreg_int_irq:
-	iio_unregister_interrupt_line(chip->indio_dev, 1);
+	free_irq(adt7410_platform_data[0], chip->indio_dev);
 error_unreg_ct_irq:
-	iio_unregister_interrupt_line(chip->indio_dev, 0);
+	free_irq(client->irq, chip->indio_dev);
 error_unreg_dev:
 	iio_device_unregister(chip->indio_dev);
 error_free_dev:
@@ -870,9 +841,9 @@ static int __devexit adt7410_remove(struct i2c_client *client)
 	unsigned long *adt7410_platform_data = client->dev.platform_data;
 
 	if (adt7410_platform_data[0])
-		iio_unregister_interrupt_line(indio_dev, 1);
+		free_irq(adt7410_platform_data[0], chip->indio_dev);
 	if (client->irq)
-		iio_unregister_interrupt_line(indio_dev, 0);
+		free_irq(client->irq, chip->indio_dev);
 	iio_device_unregister(indio_dev);
 	iio_free_device(chip->indio_dev);
 	kfree(chip);
-- 
1.7.3.4
