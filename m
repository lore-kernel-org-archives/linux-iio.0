Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 14/50] staging:iio:adc:ad7291: allocate chip state with iio_dev and use iio_priv for access.
Date: Fri, 27 May 2011 19:35:54 +0100
Message-Id: <1306521390-24897-15-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
References: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7291.c |   85 ++++++++++++++++---------------------
 1 files changed, 37 insertions(+), 48 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index 1be3453..f024026 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -61,7 +61,6 @@
 
 struct ad7291_chip_info {
 	struct i2c_client *client;
-	struct iio_dev *indio_dev;
 	u16 command;
 	u8  channels;	/* Active voltage channels */
 };
@@ -157,7 +156,7 @@ static ssize_t ad7291_show_mode(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7291_chip_info *chip = dev_info->dev_data;
+	struct ad7291_chip_info *chip = iio_priv(dev_info);
 
 	if (chip->command & AD7291_AUTOCYCLE)
 		return sprintf(buf, "autocycle\n");
@@ -171,7 +170,7 @@ static ssize_t ad7291_store_mode(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7291_chip_info *chip = dev_info->dev_data;
+	struct ad7291_chip_info *chip = iio_priv(dev_info);
 	u16 command;
 	int ret;
 
@@ -208,7 +207,7 @@ static ssize_t ad7291_store_reset(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7291_chip_info *chip = dev_info->dev_data;
+	struct ad7291_chip_info *chip = iio_priv(dev_info);
 	u16 command;
 	int ret;
 
@@ -231,7 +230,7 @@ static ssize_t ad7291_show_ext_ref(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7291_chip_info *chip = dev_info->dev_data;
+	struct ad7291_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "%d\n", !!(chip->command & AD7291_EXT_REF));
 }
@@ -242,7 +241,7 @@ static ssize_t ad7291_store_ext_ref(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7291_chip_info *chip = dev_info->dev_data;
+	struct ad7291_chip_info *chip = iio_priv(dev_info);
 	u16 command;
 	int ret;
 
@@ -269,7 +268,7 @@ static ssize_t ad7291_show_noise_delay(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7291_chip_info *chip = dev_info->dev_data;
+	struct ad7291_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "%d\n", !!(chip->command & AD7291_NOISE_DELAY));
 }
@@ -280,7 +279,7 @@ static ssize_t ad7291_store_noise_delay(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7291_chip_info *chip = dev_info->dev_data;
+	struct ad7291_chip_info *chip = iio_priv(dev_info);
 	u16 command;
 	int ret;
 
@@ -307,7 +306,7 @@ static ssize_t ad7291_show_t_sense(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7291_chip_info *chip = dev_info->dev_data;
+	struct ad7291_chip_info *chip = iio_priv(dev_info);
 	u16 data;
 	char sign = ' ';
 	int ret;
@@ -334,7 +333,7 @@ static ssize_t ad7291_show_t_average(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7291_chip_info *chip = dev_info->dev_data;
+	struct ad7291_chip_info *chip = iio_priv(dev_info);
 	u16 data;
 	char sign = ' ';
 	int ret;
@@ -361,7 +360,7 @@ static ssize_t ad7291_show_voltage(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7291_chip_info *chip = dev_info->dev_data;
+	struct ad7291_chip_info *chip = iio_priv(dev_info);
 	u16 data[AD7291_VOLTAGE_LIMIT_COUNT];
 	int i, size, ret;
 
@@ -390,7 +389,7 @@ static ssize_t ad7291_show_channel_mask(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7291_chip_info *chip = dev_info->dev_data;
+	struct ad7291_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "0x%x\n", (chip->command & AD7291_VOLTAGE_MASK) >>
 			AD7291_VOLTAGE_OFFSET);
@@ -402,7 +401,7 @@ static ssize_t ad7291_store_channel_mask(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7291_chip_info *chip = dev_info->dev_data;
+	struct ad7291_chip_info *chip = iio_priv(dev_info);
 	u16 command;
 	unsigned long data;
 	int i, ret;
@@ -457,7 +456,7 @@ static const struct attribute_group ad7291_attribute_group = {
 static irqreturn_t ad7291_event_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
-	struct ad7291_chip_info *chip = iio_dev_get_devdata(private);
+	struct ad7291_chip_info *chip = iio_priv(private);
 	u16 t_status, v_status;
 	u16 command;
 	int i;
@@ -532,7 +531,7 @@ static inline ssize_t ad7291_show_t_bound(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7291_chip_info *chip = dev_info->dev_data;
+	struct ad7291_chip_info *chip = iio_priv(dev_info);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	u16 data;
 	char sign = ' ';
@@ -560,7 +559,7 @@ static inline ssize_t ad7291_set_t_bound(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7291_chip_info *chip = dev_info->dev_data;
+	struct ad7291_chip_info *chip = iio_priv(dev_info);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	long tmp1, tmp2;
 	u16 data;
@@ -608,7 +607,7 @@ static inline ssize_t ad7291_show_v_bound(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7291_chip_info *chip = dev_info->dev_data;
+	struct ad7291_chip_info *chip = iio_priv(dev_info);
 	u16 data;
 	int ret;
 
@@ -633,7 +632,7 @@ static inline ssize_t ad7291_set_v_bound(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7291_chip_info *chip = dev_info->dev_data;
+	struct ad7291_chip_info *chip = iio_priv(dev_info);
 	unsigned long value;
 	u16 data;
 	int ret;
@@ -792,32 +791,26 @@ static int __devinit ad7291_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
 	struct ad7291_chip_info *chip;
+	struct iio_dev *indio_dev;
 	int ret = 0;
 
-	chip = kzalloc(sizeof(struct ad7291_chip_info), GFP_KERNEL);
-
-	if (chip == NULL)
-		return -ENOMEM;
-
+	indio_dev = iio_allocate_device(sizeof(*chip));
+	if (indio_dev == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
 	/* this is only used for device removal purposes */
-	i2c_set_clientdata(client, chip);
+	i2c_set_clientdata(client, indio_dev);
 
 	chip->client = client;
 	chip->command = AD7291_NOISE_DELAY | AD7291_T_SENSE_MASK;
 
-	chip->indio_dev = iio_allocate_device(0);
-	if (chip->indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_free_chip;
-	}
-
-	chip->indio_dev->name = id->name;
-	chip->indio_dev->dev.parent = &client->dev;
-	chip->indio_dev->info = &ad7291_info;
-	chip->indio_dev->dev_data = (void *)chip;
-	chip->indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->name = id->name;
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->info = &ad7291_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(chip->indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
@@ -827,7 +820,7 @@ static int __devinit ad7291_probe(struct i2c_client *client,
 					   &ad7291_event_handler,
 					   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 					   id->name,
-					   chip->indio_dev);
+					   indio_dev);
 		if (ret)
 			goto error_unreg_dev;
 
@@ -847,27 +840,23 @@ static int __devinit ad7291_probe(struct i2c_client *client,
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
 
 static int __devexit ad7291_remove(struct i2c_client *client)
 {
-	struct ad7291_chip_info *chip = i2c_get_clientdata(client);
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
