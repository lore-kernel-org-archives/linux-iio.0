Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 20/50] staging:iio:adc:adt7410 allocate chip state with iio_dev and use iio_priv to access.
Date: Fri, 27 May 2011 19:36:00 +0100
Message-Id: <1306521390-24897-21-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
References: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/adt7410.c |   86 ++++++++++++++++--------------------
 1 files changed, 38 insertions(+), 48 deletions(-)

diff --git a/drivers/staging/iio/adc/adt7410.c b/drivers/staging/iio/adc/adt7410.c
index c40a84f..76aa063 100644
--- a/drivers/staging/iio/adc/adt7410.c
+++ b/drivers/staging/iio/adc/adt7410.c
@@ -75,7 +75,6 @@
 
 struct adt7410_chip_info {
 	struct i2c_client *client;
-	struct iio_dev *indio_dev;
 	u8  config;
 };
 
@@ -144,7 +143,7 @@ static ssize_t adt7410_show_mode(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7410_chip_info *chip = dev_info->dev_data;
+	struct adt7410_chip_info *chip = iio_priv(dev_info);
 	u8 config;
 
 	config = chip->config & ADT7410_MODE_MASK;
@@ -167,7 +166,7 @@ static ssize_t adt7410_store_mode(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7410_chip_info *chip = dev_info->dev_data;
+	struct adt7410_chip_info *chip = iio_priv(dev_info);
 	u16 config;
 	int ret;
 
@@ -211,7 +210,7 @@ static ssize_t adt7410_show_resolution(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7410_chip_info *chip = dev_info->dev_data;
+	struct adt7410_chip_info *chip = iio_priv(dev_info);
 	int ret;
 	int bits;
 
@@ -233,7 +232,7 @@ static ssize_t adt7410_store_resolution(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7410_chip_info *chip = dev_info->dev_data;
+	struct adt7410_chip_info *chip = iio_priv(dev_info);
 	unsigned long data;
 	u16 config;
 	int ret;
@@ -269,7 +268,7 @@ static ssize_t adt7410_show_id(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7410_chip_info *chip = dev_info->dev_data;
+	struct adt7410_chip_info *chip = iio_priv(dev_info);
 	u8 id;
 	int ret;
 
@@ -319,7 +318,7 @@ static ssize_t adt7410_show_value(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7410_chip_info *chip = dev_info->dev_data;
+	struct adt7410_chip_info *chip = iio_priv(dev_info);
 	u8 status;
 	u16 data;
 	int ret, i = 0;
@@ -358,7 +357,7 @@ static const struct attribute_group adt7410_attribute_group = {
 static irqreturn_t adt7410_event_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
-	struct adt7410_chip_info *chip = iio_dev_get_devdata(indio_dev);
+	struct adt7410_chip_info *chip = iio_priv(indio_dev);
 	s64 timestamp = iio_get_time_ns();
 	u8 status;
 
@@ -392,7 +391,7 @@ static ssize_t adt7410_show_event_mode(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7410_chip_info *chip = dev_info->dev_data;
+	struct adt7410_chip_info *chip = iio_priv(dev_info);
 	int ret;
 
 	ret = adt7410_i2c_read_byte(chip, ADT7410_CONFIG, &chip->config);
@@ -411,7 +410,7 @@ static ssize_t adt7410_set_event_mode(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7410_chip_info *chip = dev_info->dev_data;
+	struct adt7410_chip_info *chip = iio_priv(dev_info);
 	u16 config;
 	int ret;
 
@@ -444,7 +443,7 @@ static ssize_t adt7410_show_fault_queue(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7410_chip_info *chip = dev_info->dev_data;
+	struct adt7410_chip_info *chip = iio_priv(dev_info);
 	int ret;
 
 	ret = adt7410_i2c_read_byte(chip, ADT7410_CONFIG, &chip->config);
@@ -460,7 +459,7 @@ static ssize_t adt7410_set_fault_queue(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7410_chip_info *chip = dev_info->dev_data;
+	struct adt7410_chip_info *chip = iio_priv(dev_info);
 	unsigned long data;
 	int ret;
 	u8 config;
@@ -490,7 +489,7 @@ static inline ssize_t adt7410_show_t_bound(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7410_chip_info *chip = dev_info->dev_data;
+	struct adt7410_chip_info *chip = iio_priv(dev_info);
 	u16 data;
 	int ret;
 
@@ -508,7 +507,7 @@ static inline ssize_t adt7410_set_t_bound(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7410_chip_info *chip = dev_info->dev_data;
+	struct adt7410_chip_info *chip = iio_priv(dev_info);
 	long tmp1, tmp2;
 	u16 data;
 	char *pos;
@@ -628,7 +627,7 @@ static ssize_t adt7410_show_t_hyst(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7410_chip_info *chip = dev_info->dev_data;
+	struct adt7410_chip_info *chip = iio_priv(dev_info);
 	int ret;
 	u8 t_hyst;
 
@@ -645,7 +644,7 @@ static inline ssize_t adt7410_set_t_hyst(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7410_chip_info *chip = dev_info->dev_data;
+	struct adt7410_chip_info *chip = iio_priv(dev_info);
 	int ret;
 	unsigned long data;
 	u8 t_hyst;
@@ -728,31 +727,27 @@ static int __devinit adt7410_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
 	struct adt7410_chip_info *chip;
+	struct iio_dev *indio_dev;
 	int ret = 0;
 	unsigned long *adt7410_platform_data = client->dev.platform_data;
 
-	chip = kzalloc(sizeof(struct adt7410_chip_info), GFP_KERNEL);
-
-	if (chip == NULL)
-		return -ENOMEM;
-
+	indio_dev = iio_allocate_device(sizeof(*chip));
+	if (indio_dev == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
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
-	chip->indio_dev->name = id->name;
-	chip->indio_dev->dev.parent = &client->dev;
-	chip->indio_dev->info = &adt7410_info;
-	chip->indio_dev->dev_data = (void *)chip;
-	chip->indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->name = id->name;
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->info = &adt7410_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(chip->indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
@@ -763,7 +758,7 @@ static int __devinit adt7410_probe(struct i2c_client *client,
 					   &adt7410_event_handler,
 					   IRQF_TRIGGER_LOW,
 					   id->name,
-					   chip->indio_dev);
+					   indio_dev);
 		if (ret)
 			goto error_unreg_dev;
 	}
@@ -775,7 +770,7 @@ static int __devinit adt7410_probe(struct i2c_client *client,
 					   &adt7410_event_handler,
 					   adt7410_platform_data[1],
 					   id->name,
-					   chip->indio_dev);
+					   indio_dev);
 		if (ret)
 			goto error_unreg_ct_irq;
 	}
@@ -809,32 +804,27 @@ static int __devinit adt7410_probe(struct i2c_client *client,
 	return 0;
 
 error_unreg_int_irq:
-	free_irq(adt7410_platform_data[0], chip->indio_dev);
+	free_irq(adt7410_platform_data[0], indio_dev);
 error_unreg_ct_irq:
-	free_irq(client->irq, chip->indio_dev);
+	free_irq(client->irq, indio_dev);
 error_unreg_dev:
-	iio_device_unregister(chip->indio_dev);
+	iio_device_unregister(indio_dev);
 error_free_dev:
-	iio_free_device(chip->indio_dev);
-error_free_chip:
-	kfree(chip);
-
+	iio_free_device(indio_dev);
+error_ret:
 	return ret;
 }
 
 static int __devexit adt7410_remove(struct i2c_client *client)
 {
-	struct adt7410_chip_info *chip = i2c_get_clientdata(client);
-	struct iio_dev *indio_dev = chip->indio_dev;
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	unsigned long *adt7410_platform_data = client->dev.platform_data;
 
 	if (adt7410_platform_data[0])
-		free_irq(adt7410_platform_data[0], chip->indio_dev);
+		free_irq(adt7410_platform_data[0], indio_dev);
 	if (client->irq)
-		free_irq(client->irq, chip->indio_dev);
+		free_irq(client->irq, indio_dev);
 	iio_device_unregister(indio_dev);
-	iio_free_device(chip->indio_dev);
-	kfree(chip);
 
 	return 0;
 }
-- 
1.7.3.4
