Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 017/111] staging:iio:adc:ad7816 move from old to current event handling.
Date: Wed, 18 May 2011 14:41:07 +0100
Message-Id: <1305726161-5606-18-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

I'm not sure what the event is and am very much against the dodgy
hack to give it a code. However for now, lets just stop it using
the deprecated core handling so we can move on.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7816.c |   62 +++++++++----------------------------
 1 files changed, 15 insertions(+), 47 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 9e30d35..a062ec3 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -8,14 +8,12 @@
 
 #include <linux/interrupt.h>
 #include <linux/gpio.h>
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
@@ -47,8 +45,6 @@ struct ad7816_chip_info {
 	const char *name;
 	struct spi_device *spi_dev;
 	struct iio_dev *indio_dev;
-	struct work_struct thresh_work;
-	s64 last_timestamp;
 	u16 rdwr_pin;
 	u16 convert_pin;
 	u16 busy_pin;
@@ -266,33 +262,14 @@ static const struct attribute_group ad7816_attribute_group = {
 
 #define IIO_EVENT_CODE_AD7816_OTI    IIO_BUFFER_EVENT_CODE(0)
 
-static void ad7816_interrupt_bh(struct work_struct *work_s)
+static irqreturn_t ad7816_event_handler(int irq, void *private)
 {
-	struct ad7816_chip_info *chip =
-		container_of(work_s, struct ad7816_chip_info, thresh_work);
-
-	enable_irq(chip->spi_dev->irq);
-
-	iio_push_event(chip->indio_dev, 0,
-			IIO_EVENT_CODE_AD7816_OTI,
-			chip->last_timestamp);
-}
-
-static int ad7816_interrupt(struct iio_dev *dev_info,
-		int index,
-		s64 timestamp,
-		int no_test)
-{
-	struct ad7816_chip_info *chip = dev_info->dev_data;
-
-	chip->last_timestamp = timestamp;
-	schedule_work(&chip->thresh_work);
-
-	return 0;
+	iio_push_event(private, 0,
+		       IIO_EVENT_CODE_AD7816_OTI,
+		       iio_get_time_ns());
+	return IRQ_HANDLED;
 }
 
-IIO_EVENT_SH(ad7816, &ad7816_interrupt);
-
 static ssize_t ad7816_show_oti(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
@@ -352,11 +329,11 @@ static inline ssize_t ad7816_set_oti(struct device *dev,
 	return len;
 }
 
-IIO_EVENT_ATTR_SH(oti, iio_event_ad7816,
-		ad7816_show_oti, ad7816_set_oti, 0);
+static IIO_DEVICE_ATTR(oti, S_IRUGO | S_IWUSR,
+		       ad7816_show_oti, ad7816_set_oti, 0);
 
 static struct attribute *ad7816_event_attributes[] = {
-	&iio_event_attr_oti.dev_attr.attr,
+	&iio_dev_attr_oti.dev_attr.attr,
 	NULL,
 };
 
@@ -438,23 +415,14 @@ static int __devinit ad7816_probe(struct spi_device *spi_dev)
 
 	if (spi_dev->irq) {
 		/* Only low trigger is supported in ad7816/7/8 */
-		ret = iio_register_interrupt_line(spi_dev->irq,
-				chip->indio_dev,
-				0,
-				IRQF_TRIGGER_LOW,
-				chip->name);
+		ret = request_threaded_irq(spi_dev->irq,
+					   NULL,
+					   &ad7816_event_handler,
+					   IRQF_TRIGGER_LOW,
+					   chip->name,
+					   chip->indio_dev);
 		if (ret)
 			goto error_unreg_dev;
-
-		/*
-		 * The event handler list element refer to iio_event_ad7816.
-		 * All event attributes bind to the same event handler.
-		 * So, only register event handler once.
-		 */
-		iio_add_event_to_list(&iio_event_ad7816,
-				&chip->indio_dev->interrupts[0]->ev_list);
-
-		INIT_WORK(&chip->thresh_work, ad7816_interrupt_bh);
 	}
 
 	dev_info(&spi_dev->dev, "%s temperature sensor and ADC registered.\n",
@@ -485,7 +453,7 @@ static int __devexit ad7816_remove(struct spi_device *spi_dev)
 
 	dev_set_drvdata(&spi_dev->dev, NULL);
 	if (spi_dev->irq)
-		iio_unregister_interrupt_line(indio_dev, 0);
+		free_irq(spi_dev->irq, indio_dev);
 	iio_device_unregister(indio_dev);
 	iio_free_device(chip->indio_dev);
 	gpio_free(chip->busy_pin);
-- 
1.7.3.4
