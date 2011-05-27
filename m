Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 13/50] staging:iio:adc:ad7152: allocate chip state with iio_dev and use iio_priv for access.
Date: Fri, 27 May 2011 19:35:53 +0100
Message-Id: <1306521390-24897-14-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
References: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7152.c |   73 ++++++++++++++++---------------------
 1 files changed, 32 insertions(+), 41 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7152.c b/drivers/staging/iio/adc/ad7152.c
index 7a38bcb..21f5f38 100644
--- a/drivers/staging/iio/adc/ad7152.c
+++ b/drivers/staging/iio/adc/ad7152.c
@@ -51,7 +51,6 @@
 
 struct ad7152_chip_info {
 	struct i2c_client *client;
-	struct iio_dev *indio_dev;
 	u16 ch1_offset;     /* Channel 1 offset calibration coefficient */
 	u16 ch1_gain;       /* Channel 1 gain coefficient */
 	u8  ch1_setup;
@@ -166,7 +165,7 @@ static ssize_t ad7152_show_ch1_value(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = dev_info->dev_data;
+	struct ad7152_chip_info *chip = iio_priv(dev_info);
 	u8 data[2];
 
 	ad7152_i2c_read(chip, AD7152_CH1_DATA_HIGH, data, 2);
@@ -180,7 +179,7 @@ static ssize_t ad7152_show_ch2_value(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = dev_info->dev_data;
+	struct ad7152_chip_info *chip = iio_priv(dev_info);
 	u8 data[2];
 
 	ad7152_i2c_read(chip, AD7152_CH2_DATA_HIGH, data, 2);
@@ -194,7 +193,7 @@ static ssize_t ad7152_show_conversion_mode(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = dev_info->dev_data;
+	struct ad7152_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "%s\n", chip->conversion_mode);
 }
@@ -205,7 +204,7 @@ static ssize_t ad7152_store_conversion_mode(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = dev_info->dev_data;
+	struct ad7152_chip_info *chip = iio_priv(dev_info);
 	u8 cfg;
 	int i;
 
@@ -234,7 +233,7 @@ static ssize_t ad7152_show_ch1_offset(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = dev_info->dev_data;
+	struct ad7152_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "%d\n", chip->ch1_offset);
 }
@@ -245,7 +244,7 @@ static ssize_t ad7152_store_ch1_offset(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = dev_info->dev_data;
+	struct ad7152_chip_info *chip = iio_priv(dev_info);
 	unsigned long data;
 	int ret;
 
@@ -270,7 +269,7 @@ static ssize_t ad7152_show_ch2_offset(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = dev_info->dev_data;
+	struct ad7152_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "%d\n", chip->ch2_offset);
 }
@@ -281,7 +280,7 @@ static ssize_t ad7152_store_ch2_offset(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = dev_info->dev_data;
+	struct ad7152_chip_info *chip = iio_priv(dev_info);
 	unsigned long data;
 	int ret;
 
@@ -306,7 +305,7 @@ static ssize_t ad7152_show_ch1_gain(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = dev_info->dev_data;
+	struct ad7152_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "%d\n", chip->ch1_gain);
 }
@@ -317,7 +316,7 @@ static ssize_t ad7152_store_ch1_gain(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = dev_info->dev_data;
+	struct ad7152_chip_info *chip = iio_priv(dev_info);
 	unsigned long data;
 	int ret;
 
@@ -342,7 +341,7 @@ static ssize_t ad7152_show_ch2_gain(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = dev_info->dev_data;
+	struct ad7152_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "%d\n", chip->ch2_gain);
 }
@@ -353,7 +352,7 @@ static ssize_t ad7152_store_ch2_gain(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = dev_info->dev_data;
+	struct ad7152_chip_info *chip = iio_priv(dev_info);
 	unsigned long data;
 	int ret;
 
@@ -378,7 +377,7 @@ static ssize_t ad7152_show_ch1_setup(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = dev_info->dev_data;
+	struct ad7152_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "0x%02x\n", chip->ch1_setup);
 }
@@ -389,7 +388,7 @@ static ssize_t ad7152_store_ch1_setup(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = dev_info->dev_data;
+	struct ad7152_chip_info *chip = iio_priv(dev_info);
 	unsigned long data;
 	int ret;
 
@@ -413,7 +412,7 @@ static ssize_t ad7152_show_ch2_setup(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = dev_info->dev_data;
+	struct ad7152_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "0x%02x\n", chip->ch2_setup);
 }
@@ -424,7 +423,7 @@ static ssize_t ad7152_store_ch2_setup(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = dev_info->dev_data;
+	struct ad7152_chip_info *chip = iio_priv(dev_info);
 	unsigned long data;
 	int ret;
 
@@ -448,7 +447,7 @@ static ssize_t ad7152_show_filter_rate_setup(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = dev_info->dev_data;
+	struct ad7152_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "0x%02x\n", chip->filter_rate_setup);
 }
@@ -459,7 +458,7 @@ static ssize_t ad7152_store_filter_rate_setup(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = dev_info->dev_data;
+	struct ad7152_chip_info *chip = iio_priv(dev_info);
 	unsigned long data;
 	int ret;
 
@@ -509,31 +508,27 @@ static int __devinit ad7152_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
 	int ret = 0;
-	struct ad7152_chip_info *chip = kzalloc(sizeof(*chip), GFP_KERNEL);
-	if (chip == NULL) {
+	struct ad7152_chip_info *chip;
+	struct iio_dev *indio_dev;
+
+	indio_dev = iio_allocate_device(sizeof(*chip));
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
 	/* Echipabilish that the iio_dev is a child of the i2c device */
-	chip->indio_dev->name = id->name;
-	chip->indio_dev->dev.parent = &client->dev;
-	chip->indio_dev->info = &ad7152_info;
-	chip->indio_dev->dev_data = (void *)(chip);
-	chip->indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->name = id->name;
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->info = &ad7152_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(chip->indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
@@ -542,20 +537,16 @@ static int __devinit ad7152_probe(struct i2c_client *client,
 	return 0;
 
 error_free_dev:
-	iio_free_device(chip->indio_dev);
-error_free_chip:
-	kfree(chip);
+	iio_free_device(indio_dev);
 error_ret:
 	return ret;
 }
 
 static int __devexit ad7152_remove(struct i2c_client *client)
 {
-	struct ad7152_chip_info *chip = i2c_get_clientdata(client);
-	struct iio_dev *indio_dev = chip->indio_dev;
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
 	iio_device_unregister(indio_dev);
-	kfree(chip);
 
 	return 0;
 }
-- 
1.7.3.4
