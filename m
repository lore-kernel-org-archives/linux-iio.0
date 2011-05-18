Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 016/111] staging:iio:adc:ad7745 move from old to current event handling.
Date: Wed, 18 May 2011 14:41:06 +0100
Message-Id: <1305726161-5606-17-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Nice simple one.  Not sure we actually want devices outputting
datardy signals like that, but I'll leave it for now.
Cleaned up some unneeded functions whilst here.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7745.c |   89 ++++++++++---------------------------
 1 files changed, 24 insertions(+), 65 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7745.c b/drivers/staging/iio/adc/ad7745.c
index 1373d23..cb1fc61 100644
--- a/drivers/staging/iio/adc/ad7745.c
+++ b/drivers/staging/iio/adc/ad7745.c
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
@@ -58,9 +56,7 @@ struct ad774x_chip_info {
 	const char *name;
 	struct i2c_client *client;
 	struct iio_dev *indio_dev;
-	struct work_struct thresh_work;
 	bool inter;
-	s64 last_timestamp;
 	u16 cap_offs;                   /* Capacitive offset */
 	u16 cap_gain;                   /* Capacitive gain calibration */
 	u16 volt_gain;                  /* Voltage gain calibration */
@@ -76,7 +72,8 @@ struct ad774x_conversion_mode {
 	u8 reg_cfg;
 };
 
-struct ad774x_conversion_mode ad774x_conv_mode_table[AD774X_MAX_CONV_MODE] = {
+static struct ad774x_conversion_mode
+ad774x_conv_mode_table[AD774X_MAX_CONV_MODE] = {
 	{ "idle", 0 },
 	{ "continuous-conversion", 1 },
 	{ "single-conversion", 2 },
@@ -547,67 +544,33 @@ static const struct attribute_group ad774x_attribute_group = {
 #define IIO_EVENT_ATTR_VT_RDY_SH(_evlist, _show, _store, _mask)	\
 	IIO_EVENT_ATTR_SH(vt_rdy, _evlist, _show, _store, _mask)
 
-static void ad774x_interrupt_handler_bh(struct work_struct *work_s)
+static irqreturn_t ad774x_event_handler(int irq, void *private)
 {
-	struct ad774x_chip_info *chip =
-		container_of(work_s, struct ad774x_chip_info, thresh_work);
+	struct iio_dev *indio_dev = private;
+	struct ad774x_chip_info *chip = iio_dev_get_devdata(indio_dev);
 	u8 int_status;
 
-	enable_irq(chip->client->irq);
-
 	ad774x_i2c_read(chip, AD774X_STATUS, &int_status, 1);
 
 	if (int_status & AD774X_STATUS_RDYCAP)
-		iio_push_event(chip->indio_dev, 0,
-				IIO_EVENT_CODE_CAP_RDY,
-				chip->last_timestamp);
+		iio_push_event(indio_dev, 0,
+			       IIO_EVENT_CODE_CAP_RDY,
+			       iio_get_time_ns());
 
 	if (int_status & AD774X_STATUS_RDYVT)
-		iio_push_event(chip->indio_dev, 0,
-				IIO_EVENT_CODE_VT_RDY,
-				chip->last_timestamp);
-}
-
-static int ad774x_interrupt_handler_th(struct iio_dev *dev_info,
-		int index,
-		s64 timestamp,
-		int no_test)
-{
-	struct ad774x_chip_info *chip = dev_info->dev_data;
-
-	chip->last_timestamp = timestamp;
-	schedule_work(&chip->thresh_work);
-
-	return 0;
-}
-
-IIO_EVENT_SH(data_rdy, &ad774x_interrupt_handler_th);
-
-static ssize_t ad774x_query_out_mode(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	/*
-	 * AD774X provides one /RDY pin, which can be used as interrupt
-	 * but the pin is not configurable
-	 */
-	return sprintf(buf, "1\n");
-}
+		iio_push_event(indio_dev, 0,
+			       IIO_EVENT_CODE_VT_RDY,
+			       iio_get_time_ns());
 
-static ssize_t ad774x_set_out_mode(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	return len;
+	return IRQ_HANDLED;
 }
 
-IIO_EVENT_ATTR_CAP_RDY_SH(iio_event_data_rdy, ad774x_query_out_mode, ad774x_set_out_mode, 0);
-IIO_EVENT_ATTR_VT_RDY_SH(iio_event_data_rdy, ad774x_query_out_mode, ad774x_set_out_mode, 0);
+static IIO_CONST_ATTR(cap_rdy_en, "1");
+static IIO_CONST_ATTR(vt_rdy_en, "1");
 
 static struct attribute *ad774x_event_attributes[] = {
-	&iio_event_attr_cap_rdy.dev_attr.attr,
-	&iio_event_attr_vt_rdy.dev_attr.attr,
+	&iio_const_attr_cap_rdy_en.dev_attr.attr,
+	&iio_const_attr_vt_rdy_en.dev_attr.attr,
 	NULL,
 };
 
@@ -656,18 +619,14 @@ static int __devinit ad774x_probe(struct i2c_client *client,
 	regdone = 1;
 
 	if (client->irq) {
-		ret = iio_register_interrupt_line(client->irq,
-				chip->indio_dev,
-				0,
-				IRQF_TRIGGER_FALLING,
-				"ad774x");
+		ret = request_threaded_irq(client->irq,
+					   NULL,
+					   &ad774x_event_handler,
+					   IRQF_TRIGGER_FALLING,
+					   "ad774x",
+					   chip->indio_dev);
 		if (ret)
 			goto error_free_dev;
-
-		iio_add_event_to_list(iio_event_attr_cap_rdy.listel,
-				&chip->indio_dev->interrupts[0]->ev_list);
-
-		INIT_WORK(&chip->thresh_work, ad774x_interrupt_handler_bh);
 	}
 
 	dev_err(&client->dev, "%s capacitive sensor registered, irq: %d\n", id->name, client->irq);
@@ -676,7 +635,7 @@ static int __devinit ad774x_probe(struct i2c_client *client,
 
 error_free_dev:
 	if (regdone)
-		iio_device_unregister(chip->indio_dev);
+		free_irq(client->irq, chip->indio_dev);
 	else
 		iio_free_device(chip->indio_dev);
 error_free_chip:
@@ -691,7 +650,7 @@ static int __devexit ad774x_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = chip->indio_dev;
 
 	if (client->irq)
-		iio_unregister_interrupt_line(indio_dev, 0);
+		free_irq(client->irq, indio_dev);
 	iio_device_unregister(indio_dev);
 	kfree(chip);
 
-- 
1.7.3.4
