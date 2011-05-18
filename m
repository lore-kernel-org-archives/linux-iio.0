Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 018/111] staging:iio:adc:ad7150 move from deprecated event handling plus remove irq as gpio requirement.
Date: Wed, 18 May 2011 14:41:08 +0100
Message-Id: <1305726161-5606-19-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Another driver with some very 'non standard' magic event codes.
Again I've left it be for now and merely moved it to the new
api.

There is no reason why the irq in this driver ever had to be a gpio.
Scrap that test and clean out unecessary headers.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7150.c |  121 ++++++++++---------------------------
 1 files changed, 33 insertions(+), 88 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7150.c b/drivers/staging/iio/adc/ad7150.c
index 5a2991a..6a9f326 100644
--- a/drivers/staging/iio/adc/ad7150.c
+++ b/drivers/staging/iio/adc/ad7150.c
@@ -7,15 +7,10 @@
  */
 
 #include <linux/interrupt.h>
-#include <linux/gpio.h>
-#include <linux/workqueue.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
-#include <linux/sysfs.h>
-#include <linux/list.h>
 #include <linux/i2c.h>
-#include <linux/rtc.h>
 
 #include "../iio.h"
 #include "../sysfs.h"
@@ -66,9 +61,7 @@ struct ad7150_chip_info {
 	const char *name;
 	struct i2c_client *client;
 	struct iio_dev *indio_dev;
-	struct work_struct thresh_work;
 	bool inter;
-	s64 last_timestamp;
 	u16 ch1_threshold;     /* Ch1 Threshold (in fixed threshold mode) */
 	u8  ch1_sensitivity;   /* Ch1 Sensitivity (in adaptive threshold mode) */
 	u8  ch1_timeout;       /* Ch1 Timeout (in adaptive threshold mode) */
@@ -88,7 +81,8 @@ struct ad7150_conversion_mode {
 	u8 reg_cfg;
 };
 
-struct ad7150_conversion_mode ad7150_conv_mode_table[AD7150_MAX_CONV_MODE] = {
+static struct ad7150_conversion_mode
+ad7150_conv_mode_table[AD7150_MAX_CONV_MODE] = {
 	{ "idle", 0 },
 	{ "continuous-conversion", 1 },
 	{ "single-conversion", 2 },
@@ -666,91 +660,45 @@ static const struct attribute_group ad7150_attribute_group = {
 #define IIO_EVENT_CODE_CH2_HIGH    IIO_BUFFER_EVENT_CODE(2)
 #define IIO_EVENT_CODE_CH2_LOW     IIO_BUFFER_EVENT_CODE(3)
 
-#define IIO_EVENT_ATTR_CH1_HIGH_SH(_evlist, _show, _store, _mask)	\
-	IIO_EVENT_ATTR_SH(ch1_high, _evlist, _show, _store, _mask)
-
-#define IIO_EVENT_ATTR_CH2_HIGH_SH(_evlist, _show, _store, _mask)	\
-	IIO_EVENT_ATTR_SH(ch2_high, _evlist, _show, _store, _mask)
-
-#define IIO_EVENT_ATTR_CH1_LOW_SH(_evlist, _show, _store, _mask)	\
-	IIO_EVENT_ATTR_SH(ch1_low, _evlist, _show, _store, _mask)
-
-#define IIO_EVENT_ATTR_CH2_LOW_SH(_evlist, _show, _store, _mask)	\
-	IIO_EVENT_ATTR_SH(ch2_low, _evlist, _show, _store, _mask)
-
-static void ad7150_interrupt_handler_bh(struct work_struct *work_s)
+static irqreturn_t ad7150_event_handler(int irq, void *private)
 {
-	struct ad7150_chip_info *chip =
-		container_of(work_s, struct ad7150_chip_info, thresh_work);
+	struct iio_dev *indio_dev = private;
+	struct ad7150_chip_info *chip = iio_dev_get_devdata(indio_dev);
 	u8 int_status;
-
-	enable_irq(chip->client->irq);
+	s64 timestamp = iio_get_time_ns();
 
 	ad7150_i2c_read(chip, AD7150_STATUS, &int_status, 1);
 
 	if ((int_status & AD7150_STATUS_OUT1) && !(chip->old_state & AD7150_STATUS_OUT1))
-		iio_push_event(chip->indio_dev, 0,
+		iio_push_event(indio_dev, 0,
 				IIO_EVENT_CODE_CH1_HIGH,
-				chip->last_timestamp);
+				timestamp);
 	else if ((!(int_status & AD7150_STATUS_OUT1)) && (chip->old_state & AD7150_STATUS_OUT1))
-		iio_push_event(chip->indio_dev, 0,
+		iio_push_event(indio_dev, 0,
 				IIO_EVENT_CODE_CH1_LOW,
-				chip->last_timestamp);
+				timestamp);
 
 	if ((int_status & AD7150_STATUS_OUT2) && !(chip->old_state & AD7150_STATUS_OUT2))
-		iio_push_event(chip->indio_dev, 0,
+		iio_push_event(indio_dev, 0,
 				IIO_EVENT_CODE_CH2_HIGH,
-				chip->last_timestamp);
+				timestamp);
 	else if ((!(int_status & AD7150_STATUS_OUT2)) && (chip->old_state & AD7150_STATUS_OUT2))
-		iio_push_event(chip->indio_dev, 0,
+		iio_push_event(indio_dev, 0,
 				IIO_EVENT_CODE_CH2_LOW,
-				chip->last_timestamp);
-}
-
-static int ad7150_interrupt_handler_th(struct iio_dev *dev_info,
-		int index,
-		s64 timestamp,
-		int no_test)
-{
-	struct ad7150_chip_info *chip = dev_info->dev_data;
-
-	chip->last_timestamp = timestamp;
-	schedule_work(&chip->thresh_work);
-
-	return 0;
+				timestamp);
+	return IRQ_HANDLED;
 }
 
-IIO_EVENT_SH(threshold, &ad7150_interrupt_handler_th);
-
-static ssize_t ad7150_query_out_mode(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	/*
-	 * AD7150 provides two logic output channels, which can be used as interrupt
-	 * but the pins are not configurable
-	 */
-	return sprintf(buf, "1\n");
-}
-
-static ssize_t ad7150_set_out_mode(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	return len;
-}
-
-IIO_EVENT_ATTR_CH1_HIGH_SH(iio_event_threshold, ad7150_query_out_mode, ad7150_set_out_mode, 0);
-IIO_EVENT_ATTR_CH2_HIGH_SH(iio_event_threshold, ad7150_query_out_mode, ad7150_set_out_mode, 0);
-IIO_EVENT_ATTR_CH1_LOW_SH(iio_event_threshold, ad7150_query_out_mode, ad7150_set_out_mode, 0);
-IIO_EVENT_ATTR_CH2_LOW_SH(iio_event_threshold, ad7150_query_out_mode, ad7150_set_out_mode, 0);
+static IIO_CONST_ATTR(ch1_high_en, "1");
+static IIO_CONST_ATTR(ch2_high_en, "1");
+static IIO_CONST_ATTR(ch1_low_en, "1");
+static IIO_CONST_ATTR(ch2_low_en, "1");
 
 static struct attribute *ad7150_event_attributes[] = {
-	&iio_event_attr_ch1_high.dev_attr.attr,
-	&iio_event_attr_ch2_high.dev_attr.attr,
-	&iio_event_attr_ch1_low.dev_attr.attr,
-	&iio_event_attr_ch2_low.dev_attr.attr,
+	&iio_const_attr_ch1_high_en.dev_attr.attr,
+	&iio_const_attr_ch2_high_en.dev_attr.attr,
+	&iio_const_attr_ch1_low_en.dev_attr.attr,
+	&iio_const_attr_ch2_low_en.dev_attr.attr,
 	NULL,
 };
 
@@ -798,19 +746,16 @@ static int __devinit ad7150_probe(struct i2c_client *client,
 		goto error_free_dev;
 	regdone = 1;
 
-	if (client->irq && gpio_is_valid(irq_to_gpio(client->irq)) > 0) {
-		ret = iio_register_interrupt_line(client->irq,
-				chip->indio_dev,
-				0,
-				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-				"ad7150");
+	if (client->irq) {
+		ret = request_threaded_irq(client->irq,
+					   NULL,
+					   &ad7150_event_handler,
+					   IRQF_TRIGGER_RISING |
+					   IRQF_TRIGGER_FALLING,
+					   "ad7150",
+					   chip->indio_dev);
 		if (ret)
 			goto error_free_dev;
-
-		iio_add_event_to_list(iio_event_attr_ch2_low.listel,
-				&chip->indio_dev->interrupts[0]->ev_list);
-
-		INIT_WORK(&chip->thresh_work, ad7150_interrupt_handler_bh);
 	}
 
 	dev_err(&client->dev, "%s capacitive sensor registered, irq: %d\n", id->name, client->irq);
@@ -833,8 +778,8 @@ static int __devexit ad7150_remove(struct i2c_client *client)
 	struct ad7150_chip_info *chip = i2c_get_clientdata(client);
 	struct iio_dev *indio_dev = chip->indio_dev;
 
-	if (client->irq && gpio_is_valid(irq_to_gpio(client->irq)) > 0)
-		iio_unregister_interrupt_line(indio_dev, 0);
+	if (client->irq)
+		free_irq(client->irq, indio_dev);
 	iio_device_unregister(indio_dev);
 	kfree(chip);
 
-- 
1.7.3.4
