Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 16/54] staging:iio:adc:ad7150: allocate chip state with iio_dev and use iio_priv to access.
Date: Mon, 27 Jun 2011 11:04:26 +0100
Message-Id: <1309169104-22139-17-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
References: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/ad7150.c |   91 +++++++++++++++++---------------------
 1 files changed, 41 insertions(+), 50 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7150.c b/drivers/staging/iio/adc/ad7150.c
index ca32b67..460f8f4 100644
--- a/drivers/staging/iio/adc/ad7150.c
+++ b/drivers/staging/iio/adc/ad7150.c
@@ -59,7 +59,6 @@
 
 struct ad7150_chip_info {
 	struct i2c_client *client;
-	struct iio_dev *indio_dev;
 	bool inter;
 	u16 ch1_threshold;     /* Ch1 Threshold (in fixed threshold mode) */
 	u8  ch1_sensitivity;   /* Ch1 Sensitivity (in adaptive threshold mode) */
@@ -184,7 +183,7 @@ static ssize_t ad7150_show_conversion_mode(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = dev_info->dev_data;
+	struct ad7150_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "%s\n", chip->conversion_mode);
 }
@@ -195,7 +194,7 @@ static ssize_t ad7150_store_conversion_mode(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = dev_info->dev_data;
+	struct ad7150_chip_info *chip = iio_priv(dev_info);
 	u8 cfg;
 	int i;
 
@@ -234,7 +233,7 @@ static ssize_t ad7150_show_ch1_value(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = dev_info->dev_data;
+	struct ad7150_chip_info *chip = iio_priv(dev_info);
 	u8 data[2];
 
 	ad7150_i2c_read(chip, AD7150_CH1_DATA_HIGH, data, 2);
@@ -248,7 +247,7 @@ static ssize_t ad7150_show_ch2_value(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = dev_info->dev_data;
+	struct ad7150_chip_info *chip = iio_priv(dev_info);
 	u8 data[2];
 
 	ad7150_i2c_read(chip, AD7150_CH2_DATA_HIGH, data, 2);
@@ -262,7 +261,7 @@ static ssize_t ad7150_show_threshold_mode(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = dev_info->dev_data;
+	struct ad7150_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "%s\n", chip->threshold_mode);
 }
@@ -273,7 +272,7 @@ static ssize_t ad7150_store_threshold_mode(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = dev_info->dev_data;
+	struct ad7150_chip_info *chip = iio_priv(dev_info);
 	u8 cfg;
 
 	ad7150_i2c_read(chip, AD7150_CFG, &cfg, 1);
@@ -305,7 +304,7 @@ static ssize_t ad7150_show_ch1_threshold(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = dev_info->dev_data;
+	struct ad7150_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "%d\n", chip->ch1_threshold);
 }
@@ -316,7 +315,7 @@ static ssize_t ad7150_store_ch1_threshold(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = dev_info->dev_data;
+	struct ad7150_chip_info *chip = iio_priv(dev_info);
 	unsigned long data;
 	int ret;
 
@@ -341,7 +340,7 @@ static ssize_t ad7150_show_ch2_threshold(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = dev_info->dev_data;
+	struct ad7150_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "%d\n", chip->ch2_threshold);
 }
@@ -352,7 +351,7 @@ static ssize_t ad7150_store_ch2_threshold(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = dev_info->dev_data;
+	struct ad7150_chip_info *chip = iio_priv(dev_info);
 	unsigned long data;
 	int ret;
 
@@ -377,7 +376,7 @@ static ssize_t ad7150_show_ch1_sensitivity(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = dev_info->dev_data;
+	struct ad7150_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "%d\n", chip->ch1_sensitivity);
 }
@@ -388,7 +387,7 @@ static ssize_t ad7150_store_ch1_sensitivity(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = dev_info->dev_data;
+	struct ad7150_chip_info *chip = iio_priv(dev_info);
 	unsigned long data;
 	int ret;
 
@@ -412,7 +411,7 @@ static ssize_t ad7150_show_ch2_sensitivity(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = dev_info->dev_data;
+	struct ad7150_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "%d\n", chip->ch2_sensitivity);
 }
@@ -423,7 +422,7 @@ static ssize_t ad7150_store_ch2_sensitivity(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = dev_info->dev_data;
+	struct ad7150_chip_info *chip = iio_priv(dev_info);
 	unsigned long data;
 	int ret;
 
@@ -447,7 +446,7 @@ static ssize_t ad7150_show_ch1_timeout(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = dev_info->dev_data;
+	struct ad7150_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "%d\n", chip->ch1_timeout);
 }
@@ -458,7 +457,7 @@ static ssize_t ad7150_store_ch1_timeout(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = dev_info->dev_data;
+	struct ad7150_chip_info *chip = iio_priv(dev_info);
 	unsigned long data;
 	int ret;
 
@@ -482,7 +481,7 @@ static ssize_t ad7150_show_ch2_timeout(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = dev_info->dev_data;
+	struct ad7150_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "%d\n", chip->ch2_timeout);
 }
@@ -493,7 +492,7 @@ static ssize_t ad7150_store_ch2_timeout(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = dev_info->dev_data;
+	struct ad7150_chip_info *chip = iio_priv(dev_info);
 	unsigned long data;
 	int ret;
 
@@ -517,7 +516,7 @@ static ssize_t ad7150_show_ch1_setup(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = dev_info->dev_data;
+	struct ad7150_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "0x%02x\n", chip->ch1_setup);
 }
@@ -528,7 +527,7 @@ static ssize_t ad7150_store_ch1_setup(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = dev_info->dev_data;
+	struct ad7150_chip_info *chip = iio_priv(dev_info);
 	unsigned long data;
 	int ret;
 
@@ -553,7 +552,7 @@ static ssize_t ad7150_show_ch2_setup(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = dev_info->dev_data;
+	struct ad7150_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "0x%02x\n", chip->ch2_setup);
 }
@@ -564,7 +563,7 @@ static ssize_t ad7150_store_ch2_setup(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = dev_info->dev_data;
+	struct ad7150_chip_info *chip = iio_priv(dev_info);
 	unsigned long data;
 	int ret;
 
@@ -588,7 +587,7 @@ static ssize_t ad7150_show_powerdown_timer(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = dev_info->dev_data;
+	struct ad7150_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "0x%02x\n", chip->powerdown_timer);
 }
@@ -599,7 +598,7 @@ static ssize_t ad7150_store_powerdown_timer(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = dev_info->dev_data;
+	struct ad7150_chip_info *chip = iio_priv(dev_info);
 	unsigned long data;
 	int ret;
 
@@ -645,7 +644,7 @@ static const struct attribute_group ad7150_attribute_group = {
 static irqreturn_t ad7150_event_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
-	struct ad7150_chip_info *chip = iio_dev_get_devdata(indio_dev);
+	struct ad7150_chip_info *chip = iio_priv(indio_dev);
 	u8 int_status;
 	s64 timestamp = iio_get_time_ns();
 
@@ -714,33 +713,29 @@ static int __devinit ad7150_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
 	int ret = 0, regdone = 0;
-	struct ad7150_chip_info *chip = kzalloc(sizeof(*chip), GFP_KERNEL);
-	if (chip == NULL) {
+	struct ad7150_chip_info *chip;
+	struct iio_dev *indio_dev;
+
+	indio_dev = iio_allocate_device(0);
+	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
-
+	chip = iio_priv(indio_dev);
 	/* this is only used for device removal purposes */
-	i2c_set_clientdata(client, chip);
+	i2c_set_clientdata(client, indio_dev);
 
 	chip->client = client;
 
-	chip->indio_dev = iio_allocate_device(0);
-	if (chip->indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_free_chip;
-	}
-
 	/* Establish that the iio_dev is a child of the i2c device */
-	chip->indio_dev->name = id->name;
-	chip->indio_dev->dev.parent = &client->dev;
+	indio_dev->name = id->name;
+	indio_dev->dev.parent = &client->dev;
 
-	chip->indio_dev->info = &ad7150_info;
-	chip->indio_dev->dev_data = (void *)(chip);
+	indio_dev->info = &ad7150_info;
 
-	chip->indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(chip->indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
 	regdone = 1;
@@ -752,7 +747,7 @@ static int __devinit ad7150_probe(struct i2c_client *client,
 					   IRQF_TRIGGER_RISING |
 					   IRQF_TRIGGER_FALLING,
 					   "ad7150",
-					   chip->indio_dev);
+					   indio_dev);
 		if (ret)
 			goto error_free_dev;
 	}
@@ -763,24 +758,20 @@ static int __devinit ad7150_probe(struct i2c_client *client,
 
 error_free_dev:
 	if (regdone)
-		iio_device_unregister(chip->indio_dev);
+		iio_device_unregister(indio_dev);
 	else
-		iio_free_device(chip->indio_dev);
-error_free_chip:
-	kfree(chip);
+		iio_free_device(indio_dev);
 error_ret:
 	return ret;
 }
 
 static int __devexit ad7150_remove(struct i2c_client *client)
 {
-	struct ad7150_chip_info *chip = i2c_get_clientdata(client);
-	struct iio_dev *indio_dev = chip->indio_dev;
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
 	if (client->irq)
 		free_irq(client->irq, indio_dev);
 	iio_device_unregister(indio_dev);
-	kfree(chip);
 
 	return 0;
 }
-- 
1.7.3.4
