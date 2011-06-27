Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 51/54] staging:iio:light:isl29018: allocate device state with iio_dev
Date: Mon, 27 Jun 2011 11:05:01 +0100
Message-Id: <1309169104-22139-52-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
References: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/light/isl29018.c |   52 ++++++++++++++-------------------
 1 files changed, 22 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 4794ffd..c0cedc4 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -54,7 +54,6 @@
 #define ISL29018_MAX_REGS		ISL29018_REG_ADD_DATA_MSB
 
 struct isl29018_chip {
-	struct iio_dev		*indio_dev;
 	struct i2c_client	*client;
 	struct mutex		lock;
 	unsigned int		range;
@@ -227,7 +226,7 @@ static int isl29018_read_proximity_ir(struct i2c_client *client, int scheme,
 static ssize_t get_sensor_data(struct device *dev, char *buf, int mode)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct isl29018_chip *chip = indio_dev->dev_data;
+	struct isl29018_chip *chip = iio_priv(indio_dev);
 	struct i2c_client *client = chip->client;
 	int value = 0;
 	int status;
@@ -269,7 +268,7 @@ static ssize_t show_range(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct isl29018_chip *chip = indio_dev->dev_data;
+	struct isl29018_chip *chip = iio_priv(indio_dev);
 
 	return sprintf(buf, "%u\n", chip->range);
 }
@@ -278,7 +277,7 @@ static ssize_t store_range(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct isl29018_chip *chip = indio_dev->dev_data;
+	struct isl29018_chip *chip = iio_priv(indio_dev);
 	struct i2c_client *client = chip->client;
 	int status;
 	unsigned long lval;
@@ -311,7 +310,7 @@ static ssize_t show_resolution(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct isl29018_chip *chip = indio_dev->dev_data;
+	struct isl29018_chip *chip = iio_priv(indio_dev);
 
 	return sprintf(buf, "%u\n", chip->adc_bit);
 }
@@ -320,7 +319,7 @@ static ssize_t store_resolution(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct isl29018_chip *chip = indio_dev->dev_data;
+	struct isl29018_chip *chip = iio_priv(indio_dev);
 	struct i2c_client *client = chip->client;
 	int status;
 	unsigned long lval;
@@ -351,7 +350,7 @@ static ssize_t show_prox_infrared_supression(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct isl29018_chip *chip = indio_dev->dev_data;
+	struct isl29018_chip *chip = iio_priv(indio_dev);
 
 	/* return the "proximity scheme" i.e. if the chip does on chip
 	infrared supression (1 means perform on chip supression) */
@@ -362,7 +361,7 @@ static ssize_t store_prox_infrared_supression(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct isl29018_chip *chip = indio_dev->dev_data;
+	struct isl29018_chip *chip = iio_priv(indio_dev);
 	unsigned long lval;
 
 	if (strict_strtoul(buf, 10, &lval))
@@ -464,16 +463,18 @@ static int __devinit isl29018_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct isl29018_chip *chip;
+	struct iio_dev *indio_dev;
 	int err;
 
-	chip = kzalloc(sizeof(struct isl29018_chip), GFP_KERNEL);
-	if (!chip) {
-		dev_err(&client->dev, "Memory allocation fails\n");
+	indio_dev = iio_allocate_device(0);
+	if (indio_dev == NULL) {
+		dev_err(&client->dev, "iio allocation fails\n");
 		err = -ENOMEM;
 		goto exit;
 	}
+	chip = iio_priv(indio_dev);
 
-	i2c_set_clientdata(client, chip);
+	i2c_set_clientdata(client, indio_dev);
 	chip->client = client;
 
 	mutex_init(&chip->lock);
@@ -483,19 +484,13 @@ static int __devinit isl29018_probe(struct i2c_client *client,
 
 	err = isl29018_chip_init(client);
 	if (err)
-		goto exit_free;
+		goto exit_iio_free;
 
-	chip->indio_dev = iio_allocate_device(0);
-	if (!chip->indio_dev) {
-		dev_err(&client->dev, "iio allocation fails\n");
-		goto exit_free;
-	}
-	chip->indio_dev->info = &isl29108_info;
-	chip->indio_dev->name = id->name;
-	chip->indio_dev->dev.parent = &client->dev;
-	chip->indio_dev->dev_data = (void *)(chip);
-	chip->indio_dev->modes = INDIO_DIRECT_MODE;
-	err = iio_device_register(chip->indio_dev);
+	indio_dev->info = &isl29108_info;
+	indio_dev->name = id->name;
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	err = iio_device_register(indio_dev);
 	if (err) {
 		dev_err(&client->dev, "iio registration fails\n");
 		goto exit_iio_free;
@@ -503,20 +498,17 @@ static int __devinit isl29018_probe(struct i2c_client *client,
 
 	return 0;
 exit_iio_free:
-	iio_free_device(chip->indio_dev);
-exit_free:
-	kfree(chip);
+	iio_free_device(indio_dev);
 exit:
 	return err;
 }
 
 static int __devexit isl29018_remove(struct i2c_client *client)
 {
-	struct isl29018_chip *chip = i2c_get_clientdata(client);
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
 	dev_dbg(&client->dev, "%s()\n", __func__);
-	iio_device_unregister(chip->indio_dev);
-	kfree(chip);
+	iio_device_unregister(indio_dev);
 
 	return 0;
 }
-- 
1.7.3.4
