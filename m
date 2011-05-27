Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 18/50] staging:iio:adc:adt75: allocate chip state with iio_dev and cleanup some function calls.
Date: Fri, 27 May 2011 19:35:58 +0100
Message-Id: <1306521390-24897-19-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
References: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/adt75.c |  123 ++++++++++++++++++---------------------
 1 files changed, 56 insertions(+), 67 deletions(-)

diff --git a/drivers/staging/iio/adc/adt75.c b/drivers/staging/iio/adc/adt75.c
index 1171fb9..38f141d 100644
--- a/drivers/staging/iio/adc/adt75.c
+++ b/drivers/staging/iio/adc/adt75.c
@@ -51,7 +51,6 @@
 
 struct adt75_chip_info {
 	struct i2c_client *client;
-	struct iio_dev *indio_dev;
 	u8  config;
 };
 
@@ -59,8 +58,9 @@ struct adt75_chip_info {
  * adt75 register access by I2C
  */
 
-static int adt75_i2c_read(struct adt75_chip_info *chip, u8 reg, u8 *data)
+static int adt75_i2c_read(struct iio_dev *dev_info, u8 reg, u8 *data)
 {
+	struct adt75_chip_info *chip = iio_priv(dev_info);
 	struct i2c_client *client = chip->client;
 	int ret = 0, len;
 
@@ -84,8 +84,9 @@ static int adt75_i2c_read(struct adt75_chip_info *chip, u8 reg, u8 *data)
 	return ret;
 }
 
-static int adt75_i2c_write(struct adt75_chip_info *chip, u8 reg, u8 data)
+static int adt75_i2c_write(struct iio_dev *dev_info, u8 reg, u8 data)
 {
+	struct adt75_chip_info *chip = iio_priv(dev_info);
 	struct i2c_client *client = chip->client;
 	int ret = 0;
 
@@ -104,8 +105,7 @@ static ssize_t adt75_show_mode(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt75_chip_info *chip = dev_info->dev_data;
+	struct adt75_chip_info *chip = iio_priv(dev_get_drvdata(dev));
 
 	if (chip->config & ADT75_PD)
 		return sprintf(buf, "power-save\n");
@@ -119,11 +119,11 @@ static ssize_t adt75_store_mode(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt75_chip_info *chip = dev_info->dev_data;
+	struct adt75_chip_info *chip = iio_priv(dev_info);
 	int ret;
 	u8 config;
 
-	ret = adt75_i2c_read(chip, ADT75_CONFIG, &chip->config);
+	ret = adt75_i2c_read(dev_info, ADT75_CONFIG, &chip->config);
 	if (ret)
 		return -EIO;
 
@@ -131,7 +131,7 @@ static ssize_t adt75_store_mode(struct device *dev,
 	if (!strcmp(buf, "full"))
 		config |= ADT75_PD;
 
-	ret = adt75_i2c_write(chip, ADT75_CONFIG, config);
+	ret = adt75_i2c_write(dev_info, ADT75_CONFIG, config);
 	if (ret)
 		return -EIO;
 
@@ -158,8 +158,7 @@ static ssize_t adt75_show_oneshot(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt75_chip_info *chip = dev_info->dev_data;
+	struct adt75_chip_info *chip = iio_priv(dev_get_drvdata(dev));
 
 	return sprintf(buf, "%d\n", !!(chip->config & ADT75_ONESHOT));
 }
@@ -170,7 +169,7 @@ static ssize_t adt75_store_oneshot(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt75_chip_info *chip = dev_info->dev_data;
+	struct adt75_chip_info *chip = iio_priv(dev_info);
 	unsigned long data = 0;
 	int ret;
 	u8 config;
@@ -180,7 +179,7 @@ static ssize_t adt75_store_oneshot(struct device *dev,
 		return -EINVAL;
 
 
-	ret = adt75_i2c_read(chip, ADT75_CONFIG, &chip->config);
+	ret = adt75_i2c_read(dev_info, ADT75_CONFIG, &chip->config);
 	if (ret)
 		return -EIO;
 
@@ -188,7 +187,7 @@ static ssize_t adt75_store_oneshot(struct device *dev,
 	if (data)
 		config |= ADT75_ONESHOT;
 
-	ret = adt75_i2c_write(chip, ADT75_CONFIG, config);
+	ret = adt75_i2c_write(dev_info, ADT75_CONFIG, config);
 	if (ret)
 		return -EIO;
 
@@ -207,7 +206,7 @@ static ssize_t adt75_show_value(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt75_chip_info *chip = dev_info->dev_data;
+	struct adt75_chip_info *chip = iio_priv(dev_info);
 	u16 data;
 	char sign = ' ';
 	int ret;
@@ -224,7 +223,7 @@ static ssize_t adt75_show_value(struct device *dev,
 			return -EIO;
 	}
 
-	ret = adt75_i2c_read(chip, ADT75_TEMPERATURE, (u8 *)&data);
+	ret = adt75_i2c_read(dev_info, ADT75_TEMPERATURE, (u8 *)&data);
 	if (ret)
 		return -EIO;
 
@@ -277,11 +276,11 @@ static ssize_t adt75_show_oti_mode(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt75_chip_info *chip = dev_info->dev_data;
+	struct adt75_chip_info *chip = iio_priv(dev_info);
 	int ret;
 
 	/* retrive ALART status */
-	ret = adt75_i2c_read(chip, ADT75_CONFIG, &chip->config);
+	ret = adt75_i2c_read(dev_info, ADT75_CONFIG, &chip->config);
 	if (ret)
 		return -EIO;
 
@@ -297,12 +296,12 @@ static ssize_t adt75_set_oti_mode(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt75_chip_info *chip = dev_info->dev_data;
+	struct adt75_chip_info *chip = iio_priv(dev_info);
 	int ret;
 	u8 config;
 
 	/* retrive ALART status */
-	ret = adt75_i2c_read(chip, ADT75_CONFIG, &chip->config);
+	ret = adt75_i2c_read(dev_info, ADT75_CONFIG, &chip->config);
 	if (ret)
 		return -EIO;
 
@@ -310,7 +309,7 @@ static ssize_t adt75_set_oti_mode(struct device *dev,
 	if (strcmp(buf, "comparator") != 0)
 		config |= ADT75_OS_INT;
 
-	ret = adt75_i2c_write(chip, ADT75_CONFIG, config);
+	ret = adt75_i2c_write(dev_info, ADT75_CONFIG, config);
 	if (ret)
 		return -EIO;
 
@@ -331,11 +330,11 @@ static ssize_t adt75_show_smbus_alart(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt75_chip_info *chip = dev_info->dev_data;
+	struct adt75_chip_info *chip = iio_priv(dev_info);
 	int ret;
 
 	/* retrive ALART status */
-	ret = adt75_i2c_read(chip, ADT75_CONFIG, &chip->config);
+	ret = adt75_i2c_read(dev_info, ADT75_CONFIG, &chip->config);
 	if (ret)
 		return -EIO;
 
@@ -348,7 +347,7 @@ static ssize_t adt75_set_smbus_alart(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt75_chip_info *chip = dev_info->dev_data;
+	struct adt75_chip_info *chip = iio_priv(dev_info);
 	unsigned long data = 0;
 	int ret;
 	u8 config;
@@ -358,7 +357,7 @@ static ssize_t adt75_set_smbus_alart(struct device *dev,
 		return -EINVAL;
 
 	/* retrive ALART status */
-	ret = adt75_i2c_read(chip, ADT75_CONFIG, &chip->config);
+	ret = adt75_i2c_read(dev_info, ADT75_CONFIG, &chip->config);
 	if (ret)
 		return -EIO;
 
@@ -366,7 +365,7 @@ static ssize_t adt75_set_smbus_alart(struct device *dev,
 	if (data)
 		config |= ADT75_SMBUS_ALART;
 
-	ret = adt75_i2c_write(chip, ADT75_CONFIG, config);
+	ret = adt75_i2c_write(dev_info, ADT75_CONFIG, config);
 	if (ret)
 		return -EIO;
 
@@ -380,11 +379,11 @@ static ssize_t adt75_show_fault_queue(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt75_chip_info *chip = dev_info->dev_data;
+	struct adt75_chip_info *chip = iio_priv(dev_info);
 	int ret;
 
 	/* retrive ALART status */
-	ret = adt75_i2c_read(chip, ADT75_CONFIG, &chip->config);
+	ret = adt75_i2c_read(dev_info, ADT75_CONFIG, &chip->config);
 	if (ret)
 		return -EIO;
 
@@ -398,7 +397,7 @@ static ssize_t adt75_set_fault_queue(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt75_chip_info *chip = dev_info->dev_data;
+	struct adt75_chip_info *chip = iio_priv(dev_info);
 	unsigned long data;
 	int ret;
 	u8 config;
@@ -408,13 +407,13 @@ static ssize_t adt75_set_fault_queue(struct device *dev,
 		return -EINVAL;
 
 	/* retrive ALART status */
-	ret = adt75_i2c_read(chip, ADT75_CONFIG, &chip->config);
+	ret = adt75_i2c_read(dev_info, ADT75_CONFIG, &chip->config);
 	if (ret)
 		return -EIO;
 
 	config = chip->config & ~ADT75_FAULT_QUEUE_MASK;
 	config |= (data << ADT75_FAULT_QUEUE_OFFSET);
-	ret = adt75_i2c_write(chip, ADT75_CONFIG, config);
+	ret = adt75_i2c_write(dev_info, ADT75_CONFIG, config);
 	if (ret)
 		return -EIO;
 
@@ -428,12 +427,11 @@ static inline ssize_t adt75_show_t_bound(struct device *dev,
 {
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt75_chip_info *chip = dev_info->dev_data;
 	u16 data;
 	char sign = ' ';
 	int ret;
 
-	ret = adt75_i2c_read(chip, this_attr->address, (u8 *)&data);
+	ret = adt75_i2c_read(dev_info, this_attr->address, (u8 *)&data);
 	if (ret)
 		return -EIO;
 
@@ -456,7 +454,6 @@ static inline ssize_t adt75_set_t_bound(struct device *dev,
 {
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt75_chip_info *chip = dev_info->dev_data;
 	long tmp1, tmp2;
 	u16 data;
 	char *pos;
@@ -491,7 +488,7 @@ static inline ssize_t adt75_set_t_bound(struct device *dev,
 	data <<= ADT75_VALUE_OFFSET;
 	data = swab16(data);
 
-	ret = adt75_i2c_write(chip, this_attr->address, (u8)data);
+	ret = adt75_i2c_write(dev_info, this_attr->address, (u8)data);
 	if (ret)
 		return -EIO;
 
@@ -549,31 +546,27 @@ static int __devinit adt75_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
 	struct adt75_chip_info *chip;
+	struct iio_dev *indio_dev;
 	int ret = 0;
 
-	chip = kzalloc(sizeof(struct adt75_chip_info), GFP_KERNEL);
-
-	if (chip == NULL)
-		return -ENOMEM;
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
-
-	chip->indio_dev->name = id->name;
-	chip->indio_dev->dev.parent = &client->dev;
-	chip->indio_dev->info = &adt75_info;
-	chip->indio_dev->dev_data = (void *)chip;
-	chip->indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->name = id->name;
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->info = &adt75_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(chip->indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
@@ -582,12 +575,12 @@ static int __devinit adt75_probe(struct i2c_client *client,
 					   NULL,
 					   &adt75_event_handler,
 					   IRQF_TRIGGER_LOW,
-					   chip->indio_dev->name,
-					   chip->indio_dev);
+					   indio_dev->name,
+					   indio_dev);
 		if (ret)
 			goto error_unreg_dev;
 
-		ret = adt75_i2c_read(chip, ADT75_CONFIG, &chip->config);
+		ret = adt75_i2c_read(indio_dev, ADT75_CONFIG, &chip->config);
 		if (ret) {
 			ret = -EIO;
 			goto error_unreg_irq;
@@ -596,7 +589,7 @@ static int __devinit adt75_probe(struct i2c_client *client,
 		/* set irq polarity low level */
 		chip->config &= ~ADT75_OS_POLARITY;
 
-		ret = adt75_i2c_write(chip, ADT75_CONFIG, chip->config);
+		ret = adt75_i2c_write(indio_dev, ADT75_CONFIG, chip->config);
 		if (ret) {
 			ret = -EIO;
 			goto error_unreg_irq;
@@ -604,31 +597,27 @@ static int __devinit adt75_probe(struct i2c_client *client,
 	}
 
 	dev_info(&client->dev, "%s temperature sensor registered.\n",
-			 chip->indio_dev->name);
+			 indio_dev->name);
 
 	return 0;
 error_unreg_irq:
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
 
 static int __devexit adt75_remove(struct i2c_client *client)
 {
-	struct adt75_chip_info *chip = i2c_get_clientdata(client);
-	struct iio_dev *indio_dev = chip->indio_dev;
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
 	if (client->irq)
-		free_irq(client->irq, chip->indio_dev);
+		free_irq(client->irq, indio_dev);
 	iio_device_unregister(indio_dev);
-	iio_free_device(chip->indio_dev);
-	kfree(chip);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
-- 
1.7.3.4
