Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 17/50] staging:iio:adc:ad7816: allocate chip state with iio_dev and use iio_priv to access.
Date: Fri, 27 May 2011 19:35:57 +0100
Message-Id: <1306521390-24897-18-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
References: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Again, get rid of unwanted iio_dev pointer in state.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7816.c |   74 +++++++++++++++++---------------------
 1 files changed, 33 insertions(+), 41 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 11379e4..0c84217 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -43,7 +43,6 @@
 
 struct ad7816_chip_info {
 	struct spi_device *spi_dev;
-	struct iio_dev *indio_dev;
 	u16 rdwr_pin;
 	u16 convert_pin;
 	u16 busy_pin;
@@ -113,7 +112,7 @@ static ssize_t ad7816_show_mode(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7816_chip_info *chip = dev_info->dev_data;
+	struct ad7816_chip_info *chip = iio_priv(dev_info);
 
 	if (chip->mode)
 		return sprintf(buf, "power-save\n");
@@ -127,7 +126,7 @@ static ssize_t ad7816_store_mode(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7816_chip_info *chip = dev_info->dev_data;
+	struct ad7816_chip_info *chip = iio_priv(dev_info);
 
 	if (strcmp(buf, "full")) {
 		gpio_set_value(chip->rdwr_pin, 1);
@@ -159,7 +158,7 @@ static ssize_t ad7816_show_channel(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7816_chip_info *chip = dev_info->dev_data;
+	struct ad7816_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "%d\n", chip->channel_id);
 }
@@ -170,7 +169,7 @@ static ssize_t ad7816_store_channel(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7816_chip_info *chip = dev_info->dev_data;
+	struct ad7816_chip_info *chip = iio_priv(dev_info);
 	unsigned long data;
 	int ret;
 
@@ -208,7 +207,7 @@ static ssize_t ad7816_show_value(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7816_chip_info *chip = dev_info->dev_data;
+	struct ad7816_chip_info *chip = iio_priv(dev_info);
 	u16 data;
 	s8 value;
 	int ret;
@@ -265,7 +264,7 @@ static ssize_t ad7816_show_oti(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7816_chip_info *chip = dev_info->dev_data;
+	struct ad7816_chip_info *chip = iio_priv(dev_info);
 	int value;
 
 	if (chip->channel_id > AD7816_CS_MAX) {
@@ -286,7 +285,7 @@ static inline ssize_t ad7816_set_oti(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7816_chip_info *chip = dev_info->dev_data;
+	struct ad7816_chip_info *chip = iio_priv(dev_info);
 	long value;
 	u8 data;
 	int ret;
@@ -345,6 +344,7 @@ static const struct iio_info ad7816_info = {
 static int __devinit ad7816_probe(struct spi_device *spi_dev)
 {
 	struct ad7816_chip_info *chip;
+	struct iio_dev *indio_dev;
 	unsigned short *pins = spi_dev->dev.platform_data;
 	int ret = 0;
 	int i;
@@ -354,13 +354,14 @@ static int __devinit ad7816_probe(struct spi_device *spi_dev)
 		return -EINVAL;
 	}
 
-	chip = kzalloc(sizeof(struct ad7816_chip_info), GFP_KERNEL);
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
-	dev_set_drvdata(&spi_dev->dev, chip);
+	dev_set_drvdata(&spi_dev->dev, indio_dev);
 
 	chip->spi_dev = spi_dev;
 	for (i = 0; i <= AD7816_CS_MAX; i++)
@@ -373,7 +374,7 @@ static int __devinit ad7816_probe(struct spi_device *spi_dev)
 	if (ret) {
 		dev_err(&spi_dev->dev, "Fail to request rdwr gpio PIN %d.\n",
 			chip->rdwr_pin);
-		goto error_free_chip;
+		goto error_free_device;
 	}
 	gpio_direction_input(chip->rdwr_pin);
 	ret = gpio_request(chip->convert_pin, spi_get_device_id(spi_dev)->name);
@@ -391,20 +392,14 @@ static int __devinit ad7816_probe(struct spi_device *spi_dev)
 	}
 	gpio_direction_input(chip->busy_pin);
 
-	chip->indio_dev = iio_allocate_device(0);
-	if (chip->indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_free_gpio;
-	}
-	chip->indio_dev->name = spi_get_device_id(spi_dev)->name;
-	chip->indio_dev->dev.parent = &spi_dev->dev;
-	chip->indio_dev->info = &ad7816_info;
-	chip->indio_dev->dev_data = (void *)chip;
-	chip->indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->name = spi_get_device_id(spi_dev)->name;
+	indio_dev->dev.parent = &spi_dev->dev;
+	indio_dev->info = &ad7816_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(chip->indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_free_dev;
+		goto error_free_gpio;
 
 	if (spi_dev->irq) {
 		/* Only low trigger is supported in ad7816/7/8 */
@@ -412,47 +407,44 @@ static int __devinit ad7816_probe(struct spi_device *spi_dev)
 					   NULL,
 					   &ad7816_event_handler,
 					   IRQF_TRIGGER_LOW,
-					   chip->indio_dev->name,
-					   chip->indio_dev);
+					   indio_dev->name,
+					   indio_dev);
 		if (ret)
 			goto error_unreg_dev;
 	}
 
 	dev_info(&spi_dev->dev, "%s temperature sensor and ADC registered.\n",
-			 chip->indio_dev->name);
+			 indio_dev->name);
 
 	return 0;
 
 error_unreg_dev:
-	iio_device_unregister(chip->indio_dev);
-error_free_dev:
-	iio_free_device(chip->indio_dev);
+	iio_device_unregister(indio_dev);
 error_free_gpio:
 	gpio_free(chip->busy_pin);
 error_free_gpio_convert:
 	gpio_free(chip->convert_pin);
 error_free_gpio_rdwr:
 	gpio_free(chip->rdwr_pin);
-error_free_chip:
-	kfree(chip);
-
+error_free_device:
+	iio_free_device(indio_dev);
+error_ret:
 	return ret;
 }
 
 static int __devexit ad7816_remove(struct spi_device *spi_dev)
 {
-	struct ad7816_chip_info *chip = dev_get_drvdata(&spi_dev->dev);
-	struct iio_dev *indio_dev = chip->indio_dev;
+	struct iio_dev *indio_dev = dev_get_drvdata(&spi_dev->dev);
+	struct ad7816_chip_info *chip = iio_priv(indio_dev);
 
 	dev_set_drvdata(&spi_dev->dev, NULL);
 	if (spi_dev->irq)
 		free_irq(spi_dev->irq, indio_dev);
-	iio_device_unregister(indio_dev);
-	iio_free_device(chip->indio_dev);
 	gpio_free(chip->busy_pin);
 	gpio_free(chip->convert_pin);
 	gpio_free(chip->rdwr_pin);
-	kfree(chip);
+	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
-- 
1.7.3.4
