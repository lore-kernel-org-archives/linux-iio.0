Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 20/54] staging:iio:adc:ad7745 allocate chip state with iio_dev and use iio_priv to access.
Date: Mon, 27 Jun 2011 11:04:30 +0100
Message-Id: <1309169104-22139-21-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
References: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Also remove the iio_dev pointer from chip state as never needed.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/ad7745.c |   79 +++++++++++++++++---------------------
 1 files changed, 35 insertions(+), 44 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7745.c b/drivers/staging/iio/adc/ad7745.c
index 1944223..06dac12 100644
--- a/drivers/staging/iio/adc/ad7745.c
+++ b/drivers/staging/iio/adc/ad7745.c
@@ -54,7 +54,6 @@
 
 struct ad774x_chip_info {
 	struct i2c_client *client;
-	struct iio_dev *indio_dev;
 	bool inter;
 	u16 cap_offs;                   /* Capacitive offset */
 	u16 cap_gain;                   /* Capacitive gain calibration */
@@ -169,7 +168,7 @@ static ssize_t ad774x_show_conversion_mode(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad774x_chip_info *chip = dev_info->dev_data;
+	struct ad774x_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "%s\n", chip->conversion_mode);
 }
@@ -180,7 +179,7 @@ static ssize_t ad774x_store_conversion_mode(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad774x_chip_info *chip = dev_info->dev_data;
+	struct ad774x_chip_info *chip = iio_priv(dev_info);
 	u8 cfg;
 	int i;
 
@@ -210,7 +209,7 @@ static ssize_t ad774x_show_dac_value(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad774x_chip_info *chip = dev_info->dev_data;
+	struct ad774x_chip_info *chip = iio_priv(dev_info);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	u8 data;
 
@@ -225,7 +224,7 @@ static ssize_t ad774x_store_dac_value(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad774x_chip_info *chip = dev_info->dev_data;
+	struct ad774x_chip_info *chip = iio_priv(dev_info);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	unsigned long data;
 	int ret;
@@ -256,7 +255,7 @@ static ssize_t ad774x_show_cap_setup(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad774x_chip_info *chip = dev_info->dev_data;
+	struct ad774x_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "0x%02x\n", chip->cap_setup);
 }
@@ -267,7 +266,7 @@ static ssize_t ad774x_store_cap_setup(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad774x_chip_info *chip = dev_info->dev_data;
+	struct ad774x_chip_info *chip = iio_priv(dev_info);
 	unsigned long data;
 	int ret;
 
@@ -291,7 +290,7 @@ static ssize_t ad774x_show_vt_setup(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad774x_chip_info *chip = dev_info->dev_data;
+	struct ad774x_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "0x%02x\n", chip->vt_setup);
 }
@@ -302,7 +301,7 @@ static ssize_t ad774x_store_vt_setup(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad774x_chip_info *chip = dev_info->dev_data;
+	struct ad774x_chip_info *chip = iio_priv(dev_info);
 	unsigned long data;
 	int ret;
 
@@ -326,7 +325,7 @@ static ssize_t ad774x_show_exec_setup(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad774x_chip_info *chip = dev_info->dev_data;
+	struct ad774x_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "0x%02x\n", chip->exec_setup);
 }
@@ -337,7 +336,7 @@ static ssize_t ad774x_store_exec_setup(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad774x_chip_info *chip = dev_info->dev_data;
+	struct ad774x_chip_info *chip = iio_priv(dev_info);
 	unsigned long data;
 	int ret;
 
@@ -361,7 +360,7 @@ static ssize_t ad774x_show_volt_gain(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad774x_chip_info *chip = dev_info->dev_data;
+	struct ad774x_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "%d\n", chip->volt_gain);
 }
@@ -372,7 +371,7 @@ static ssize_t ad774x_store_volt_gain(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad774x_chip_info *chip = dev_info->dev_data;
+	struct ad774x_chip_info *chip = iio_priv(dev_info);
 	unsigned long data;
 	int ret;
 
@@ -397,7 +396,7 @@ static ssize_t ad774x_show_cap_data(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad774x_chip_info *chip = dev_info->dev_data;
+	struct ad774x_chip_info *chip = iio_priv(dev_info);
 	unsigned long data;
 	char tmp[3];
 
@@ -414,7 +413,7 @@ static ssize_t ad774x_show_vt_data(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad774x_chip_info *chip = dev_info->dev_data;
+	struct ad774x_chip_info *chip = iio_priv(dev_info);
 	unsigned long data;
 	char tmp[3];
 
@@ -431,7 +430,7 @@ static ssize_t ad774x_show_cap_offs(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad774x_chip_info *chip = dev_info->dev_data;
+	struct ad774x_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "%d\n", chip->cap_offs);
 }
@@ -442,7 +441,7 @@ static ssize_t ad774x_store_cap_offs(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad774x_chip_info *chip = dev_info->dev_data;
+	struct ad774x_chip_info *chip = iio_priv(dev_info);
 	unsigned long data;
 	int ret;
 
@@ -467,7 +466,7 @@ static ssize_t ad774x_show_cap_gain(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad774x_chip_info *chip = dev_info->dev_data;
+	struct ad774x_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "%d\n", chip->cap_gain);
 }
@@ -478,7 +477,7 @@ static ssize_t ad774x_store_cap_gain(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad774x_chip_info *chip = dev_info->dev_data;
+	struct ad774x_chip_info *chip = iio_priv(dev_info);
 	unsigned long data;
 	int ret;
 
@@ -534,7 +533,7 @@ static const struct attribute_group ad774x_attribute_group = {
 static irqreturn_t ad774x_event_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
-	struct ad774x_chip_info *chip = iio_dev_get_devdata(indio_dev);
+	struct ad774x_chip_info *chip = iio_priv(indio_dev);
 	u8 int_status;
 
 	ad774x_i2c_read(chip, AD774X_STATUS, &int_status, 1);
@@ -579,31 +578,27 @@ static int __devinit ad774x_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
 	int ret = 0, regdone = 0;
-	struct ad774x_chip_info *chip = kzalloc(sizeof(*chip), GFP_KERNEL);
-	if (chip == NULL) {
+	struct ad774x_chip_info *chip;
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
-	chip->indio_dev->info = &ad774x_info;
-	chip->indio_dev->dev_data = (void *)(chip);
-	chip->indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->name = id->name;
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->info = &ad774x_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(chip->indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
 	regdone = 1;
@@ -614,7 +609,7 @@ static int __devinit ad774x_probe(struct i2c_client *client,
 					   &ad774x_event_handler,
 					   IRQF_TRIGGER_FALLING,
 					   "ad774x",
-					   chip->indio_dev);
+					   indio_dev);
 		if (ret)
 			goto error_free_dev;
 	}
@@ -625,24 +620,20 @@ static int __devinit ad774x_probe(struct i2c_client *client,
 
 error_free_dev:
 	if (regdone)
-		free_irq(client->irq, chip->indio_dev);
+		free_irq(client->irq, indio_dev);
 	else
-		iio_free_device(chip->indio_dev);
-error_free_chip:
-	kfree(chip);
+		iio_free_device(indio_dev);
 error_ret:
 	return ret;
 }
 
 static int __devexit ad774x_remove(struct i2c_client *client)
 {
-	struct ad774x_chip_info *chip = i2c_get_clientdata(client);
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
