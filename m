Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 13/70] staging:iio:light:tsl2563 remove old style event registration.
Date: Sun, 17 Apr 2011 20:05:46 +0100
Message-Id: <1303067203-4894-14-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1303067203-4894-1-git-send-email-jic23@cam.ac.uk>
References: <1303067203-4894-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Untested.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/light/tsl2563.c |   62 +++++++++++------------------------
 1 files changed, 19 insertions(+), 43 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index 19b7215..d613086 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -117,8 +117,6 @@ struct tsl2563_chip {
 	struct i2c_client	*client;
 	struct delayed_work	poweroff_work;
 
-	struct work_struct	work_thresh;
-	s64			event_timestamp;
 	/* Remember state for suspend and resume functions */
 	pm_message_t		state;
 
@@ -677,38 +675,22 @@ static IIO_DEVICE_ATTR(intensity0_both_raw_thresh_falling_value,
 		tsl2563_write_thresh,
 		TSL2563_REG_LOWLOW);
 
-static int tsl2563_int_th(struct iio_dev *dev_info,
-			int index,
-			s64 timestamp,
-			int not_test)
+static irqreturn_t tsl2563_event_handler(int irq, void *private)
 {
+	struct iio_dev *dev_info = private;
 	struct tsl2563_chip *chip = iio_priv(dev_info);
-
-	chip->event_timestamp = timestamp;
-	schedule_work(&chip->work_thresh);
-
-	return 0;
-}
-
-static void tsl2563_int_bh(struct work_struct *work_s)
-{
-	struct tsl2563_chip *chip
-		= container_of(work_s,
-			struct tsl2563_chip, work_thresh);
 	u8 cmd = TSL2563_CMD | TSL2563_CLEARINT;
 
-	iio_push_event(iio_priv_to_dev(chip), 0,
+	iio_push_event(dev_info, 0,
 		       IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_LIGHT,
 					    0,
 					    IIO_EV_TYPE_THRESH,
 					    IIO_EV_DIR_EITHER),
-		       chip->event_timestamp);
+		       iio_get_time_ns());
 
-	/* reenable_irq */
-	enable_irq(chip->client->irq);
 	/* clear the interrupt and push the event */
 	i2c_master_send(chip->client, &cmd, sizeof(cmd));
-
+	return IRQ_HANDLED;
 }
 
 static ssize_t tsl2563_write_interrupt_config(struct device *dev,
@@ -718,7 +700,6 @@ static ssize_t tsl2563_write_interrupt_config(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct tsl2563_chip *chip = iio_priv(indio_dev);
-	struct iio_event_attr *this_attr = to_iio_event_attr(attr);
 	int input, ret = 0;
 
 	ret = sscanf(buf, "%d", &input);
@@ -726,8 +707,6 @@ static ssize_t tsl2563_write_interrupt_config(struct device *dev,
 		return -EINVAL;
 	mutex_lock(&chip->lock);
 	if (input && !(chip->intr & 0x30)) {
-		iio_add_event_to_list(this_attr->listel,
-				&indio_dev->interrupts[0]->ev_list);
 		chip->intr &= ~0x30;
 		chip->intr |= 0x10;
 		/* ensure the chip is actually on */
@@ -747,8 +726,6 @@ static ssize_t tsl2563_write_interrupt_config(struct device *dev,
 	if (!input && (chip->intr & 0x30)) {
 		chip->intr |= ~0x30;
 		ret = tsl2563_write(chip->client, TSL2563_REG_INT, chip->intr);
-		iio_remove_event_from_list(this_attr->listel,
-					&indio_dev->interrupts[0]->ev_list);
 		chip->int_enabled = false;
 		/* now the interrupt is not enabled, we can go to sleep */
 		schedule_delayed_work(&chip->poweroff_work, 5 * HZ);
@@ -781,15 +758,14 @@ error_ret:
 
 	return (ret < 0) ? ret : len;
 }
-
-IIO_EVENT_ATTR(intensity0_both_thresh_en,
-	tsl2563_read_interrupt_config,
-	tsl2563_write_interrupt_config,
-	0,
-	tsl2563_int_th);
+static IIO_DEVICE_ATTR(intensity0_both_thresh_en,
+		       S_IRUGO | S_IWUSR,
+		       tsl2563_read_interrupt_config,
+		       tsl2563_write_interrupt_config,
+		       0);
 
 static struct attribute *tsl2563_event_attributes[] = {
-	&iio_event_attr_intensity0_both_thresh_en.dev_attr.attr,
+	&iio_dev_attr_intensity0_both_thresh_en.dev_attr.attr,
 	&iio_dev_attr_intensity0_both_raw_thresh_rising_value.dev_attr.attr,
 	&iio_dev_attr_intensity0_both_raw_thresh_falling_value.dev_attr.attr,
 	NULL,
@@ -820,7 +796,6 @@ static int __devinit tsl2563_probe(struct i2c_client *client,
 
 	chip = iio_priv(indio_dev);
 
-	INIT_WORK(&chip->work_thresh, tsl2563_int_bh);
 	i2c_set_clientdata(client, chip);
 	chip->client = client;
 
@@ -865,11 +840,12 @@ static int __devinit tsl2563_probe(struct i2c_client *client,
 		goto fail1;
 
 	if (client->irq) {
-		ret = iio_register_interrupt_line(client->irq,
-						indio_dev,
-						0,
-						IRQF_TRIGGER_RISING,
-						client->name);
+		ret = request_threaded_irq(client->irq,
+					   NULL,
+					   &tsl2563_event_handler,
+					   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					   "tsl2563_event",
+					   indio_dev);
 		if (ret)
 			goto fail2;
 	}
@@ -884,7 +860,7 @@ static int __devinit tsl2563_probe(struct i2c_client *client,
 	return 0;
 fail3:
 	if (client->irq)
-		iio_unregister_interrupt_line(indio_dev, 0);
+		free_irq(client->irq, indio_dev);
 fail2:
 	iio_device_unregister(indio_dev);
 fail1:
@@ -904,7 +880,7 @@ static int tsl2563_remove(struct i2c_client *client)
 	flush_scheduled_work();
 	tsl2563_set_power(chip, 0);
 	if (client->irq)
-		iio_unregister_interrupt_line(indio_dev, 0);
+		free_irq(client->irq, indio_dev);
 	iio_device_unregister(indio_dev);
 
 	return 0;
-- 
1.7.3.4
