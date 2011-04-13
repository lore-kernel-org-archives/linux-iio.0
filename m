Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 01/12] staging:iio:tsl2563 take advantage of new iio_device_allocate private data.
Date: Wed, 13 Apr 2011 14:42:56 +0100
Message-Id: <1302702187-953-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1302702187-953-1-git-send-email-jic23@cam.ac.uk>
References: <1302702187-953-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/light/tsl2563.c |   68 +++++++++++++++--------------------
 1 files changed, 29 insertions(+), 39 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index 35d94c6..8c00584 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -115,7 +115,6 @@ static struct tsl2563_gainlevel_coeff tsl2563_gainlevel_table[] = {
 struct tsl2563_chip {
 	struct mutex		lock;
 	struct i2c_client	*client;
-	struct iio_dev		*indio_dev;
 	struct delayed_work	poweroff_work;
 
 	struct work_struct	work_thresh;
@@ -470,8 +469,7 @@ static unsigned int adc_to_lux(u32 adc0, u32 adc1)
 static ssize_t tsl2563_adc_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2563_chip *chip = indio_dev->dev_data;
+	struct tsl2563_chip *chip = iio_priv(dev_get_drvdata(dev));
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int ret;
 
@@ -508,8 +506,7 @@ static u32 calib_adc(u32 adc, u32 calib)
 static ssize_t tsl2563_lux_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2563_chip *chip = indio_dev->dev_data;
+	struct tsl2563_chip *chip = iio_priv(dev_get_drvdata(dev));
 	u32 calib0, calib1;
 	int ret;
 
@@ -537,8 +534,7 @@ static ssize_t format_calib(char *buf, int len, u32 calib)
 static ssize_t tsl2563_calib_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2563_chip *chip = indio_dev->dev_data;
+	struct tsl2563_chip *chip = iio_priv(dev_get_drvdata(dev));
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int ret;
 
@@ -561,8 +557,7 @@ static ssize_t tsl2563_calib_store(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t len)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2563_chip *chip = indio_dev->dev_data;
+	struct tsl2563_chip *chip = iio_priv(dev_get_drvdata(dev));
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int value;
 	u32 calib;
@@ -598,8 +593,7 @@ static ssize_t tsl2563_show_name(struct device *dev,
 				struct device_attribute *attr,
 				char *buf)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2563_chip *chip = indio_dev->dev_data;
+	struct tsl2563_chip *chip = iio_priv(dev_get_drvdata(dev));
 	return sprintf(buf, "%s\n", chip->client->name);
 }
 
@@ -623,8 +617,7 @@ static ssize_t tsl2563_read_thresh(struct device *dev,
 			struct device_attribute *attr,
 			char *buf)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2563_chip *chip = indio_dev->dev_data;
+	struct tsl2563_chip *chip = iio_priv(dev_get_drvdata(dev));
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	u16 val = 0;
 	switch (this_attr->address) {
@@ -643,8 +636,7 @@ static ssize_t tsl2563_write_thresh(struct device *dev,
 				const char *buf,
 				size_t len)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2563_chip *chip = indio_dev->dev_data;
+	struct tsl2563_chip *chip = iio_priv(dev_get_drvdata(dev));
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	unsigned long val;
 	int ret;
@@ -690,7 +682,7 @@ static int tsl2563_int_th(struct iio_dev *dev_info,
 			s64 timestamp,
 			int not_test)
 {
-	struct tsl2563_chip *chip = dev_info->dev_data;
+	struct tsl2563_chip *chip = iio_priv(dev_info);
 
 	chip->event_timestamp = timestamp;
 	schedule_work(&chip->work_thresh);
@@ -705,7 +697,7 @@ static void tsl2563_int_bh(struct work_struct *work_s)
 			struct tsl2563_chip, work_thresh);
 	u8 cmd = TSL2563_CMD | TSL2563_CLEARINT;
 
-	iio_push_event(chip->indio_dev, 0,
+	iio_push_event(iio_priv_to_dev(chip), 0,
 		       IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_LIGHT,
 					    0,
 					    IIO_EV_TYPE_THRESH,
@@ -725,7 +717,7 @@ static ssize_t tsl2563_write_interrupt_config(struct device *dev,
 					size_t len)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2563_chip *chip = indio_dev->dev_data;
+	struct tsl2563_chip *chip = iio_priv(indio_dev);
 	struct iio_event_attr *this_attr = to_iio_event_attr(attr);
 	int input, ret = 0;
 
@@ -771,8 +763,7 @@ static ssize_t tsl2563_read_interrupt_config(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2563_chip *chip = indio_dev->dev_data;
+	struct tsl2563_chip *chip = iio_priv(dev_get_drvdata(dev));
 	int ret;
 	u8 rxbuf;
 	ssize_t len;
@@ -816,16 +807,19 @@ static struct i2c_driver tsl2563_i2c_driver;
 static int __devinit tsl2563_probe(struct i2c_client *client,
 				const struct i2c_device_id *device_id)
 {
+	struct iio_dev *indio_dev;
 	struct tsl2563_chip *chip;
 	struct tsl2563_platform_data *pdata = client->dev.platform_data;
 	int err = 0;
 	int ret;
 	u8 id;
 
-	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
-	if (!chip)
+	indio_dev = iio_allocate_device(sizeof(*chip));
+	if (!indio_dev)
 		return -ENOMEM;
 
+	chip = iio_priv(indio_dev);
+
 	INIT_WORK(&chip->work_thresh, tsl2563_int_bh);
 	i2c_set_clientdata(client, chip);
 	chip->client = client;
@@ -857,26 +851,22 @@ static int __devinit tsl2563_probe(struct i2c_client *client,
 
 	dev_info(&client->dev, "model %d, rev. %d\n", id >> 4, id & 0x0f);
 
-	chip->indio_dev = iio_allocate_device(0);
-	if (!chip->indio_dev)
-		goto fail1;
-	chip->indio_dev->attrs = &tsl2563_group;
-	chip->indio_dev->dev.parent = &client->dev;
-	chip->indio_dev->dev_data = (void *)(chip);
-	chip->indio_dev->driver_module = THIS_MODULE;
-	chip->indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->attrs = &tsl2563_group;
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->driver_module = THIS_MODULE;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 	if (client->irq) {
-		chip->indio_dev->num_interrupt_lines = 1;
-		chip->indio_dev->event_attrs
+		indio_dev->num_interrupt_lines = 1;
+		indio_dev->event_attrs
 			= &tsl2563_event_attribute_group;
 	}
-	ret = iio_device_register(chip->indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto fail1;
 
 	if (client->irq) {
 		ret = iio_register_interrupt_line(client->irq,
-						chip->indio_dev,
+						indio_dev,
 						0,
 						IRQF_TRIGGER_RISING,
 						client->name);
@@ -894,9 +884,9 @@ static int __devinit tsl2563_probe(struct i2c_client *client,
 	return 0;
 fail3:
 	if (client->irq)
-		iio_unregister_interrupt_line(chip->indio_dev, 0);
+		iio_unregister_interrupt_line(indio_dev, 0);
 fail2:
-	iio_device_unregister(chip->indio_dev);
+	iio_device_unregister(indio_dev);
 fail1:
 	kfree(chip);
 	return err;
@@ -905,6 +895,7 @@ fail1:
 static int tsl2563_remove(struct i2c_client *client)
 {
 	struct tsl2563_chip *chip = i2c_get_clientdata(client);
+	struct iio_dev *indio_dev = iio_priv_to_dev(chip);
 	if (!chip->int_enabled)
 		cancel_delayed_work(&chip->poweroff_work);
 	/* Ensure that interrupts are disabled - then flush any bottom halves */
@@ -913,10 +904,9 @@ static int tsl2563_remove(struct i2c_client *client)
 	flush_scheduled_work();
 	tsl2563_set_power(chip, 0);
 	if (client->irq)
-		iio_unregister_interrupt_line(chip->indio_dev, 0);
-	iio_device_unregister(chip->indio_dev);
+		iio_unregister_interrupt_line(indio_dev, 0);
+	iio_device_unregister(indio_dev);
 
-	kfree(chip);
 	return 0;
 }
 
-- 
1.7.3.4
