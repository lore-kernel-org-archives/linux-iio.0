Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 23/54] staging:iio:adc:adt7310: allocate chip state with iio_dev and use iio_priv for access.
Date: Mon, 27 Jun 2011 11:04:33 +0100
Message-Id: <1309169104-22139-24-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
References: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/adt7310.c |   94 ++++++++++++++++--------------------
 1 files changed, 42 insertions(+), 52 deletions(-)

diff --git a/drivers/staging/iio/adc/adt7310.c b/drivers/staging/iio/adc/adt7310.c
index 68eca0b..1a41b80 100644
--- a/drivers/staging/iio/adc/adt7310.c
+++ b/drivers/staging/iio/adc/adt7310.c
@@ -80,7 +80,6 @@
 
 struct adt7310_chip_info {
 	struct spi_device *spi_dev;
-	struct iio_dev *indio_dev;
 	u8  config;
 };
 
@@ -176,7 +175,7 @@ static ssize_t adt7310_show_mode(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7310_chip_info *chip = dev_info->dev_data;
+	struct adt7310_chip_info *chip = iio_priv(dev_info);
 	u8 config;
 
 	config = chip->config & ADT7310_MODE_MASK;
@@ -199,7 +198,7 @@ static ssize_t adt7310_store_mode(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7310_chip_info *chip = dev_info->dev_data;
+	struct adt7310_chip_info *chip = iio_priv(dev_info);
 	u16 config;
 	int ret;
 
@@ -243,7 +242,7 @@ static ssize_t adt7310_show_resolution(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7310_chip_info *chip = dev_info->dev_data;
+	struct adt7310_chip_info *chip = iio_priv(dev_info);
 	int ret;
 	int bits;
 
@@ -265,7 +264,7 @@ static ssize_t adt7310_store_resolution(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7310_chip_info *chip = dev_info->dev_data;
+	struct adt7310_chip_info *chip = iio_priv(dev_info);
 	unsigned long data;
 	u16 config;
 	int ret;
@@ -301,7 +300,7 @@ static ssize_t adt7310_show_id(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7310_chip_info *chip = dev_info->dev_data;
+	struct adt7310_chip_info *chip = iio_priv(dev_info);
 	u8 id;
 	int ret;
 
@@ -351,7 +350,7 @@ static ssize_t adt7310_show_value(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7310_chip_info *chip = dev_info->dev_data;
+	struct adt7310_chip_info *chip = iio_priv(dev_info);
 	u8 status;
 	u16 data;
 	int ret, i = 0;
@@ -390,7 +389,7 @@ static const struct attribute_group adt7310_attribute_group = {
 static irqreturn_t adt7310_event_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
-	struct adt7310_chip_info *chip = iio_dev_get_devdata(indio_dev);
+	struct adt7310_chip_info *chip = iio_priv(indio_dev);
 	s64 timestamp = iio_get_time_ns();
 	u8 status;
 	int ret;
@@ -425,7 +424,7 @@ static ssize_t adt7310_show_event_mode(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7310_chip_info *chip = dev_info->dev_data;
+	struct adt7310_chip_info *chip = iio_priv(dev_info);
 	int ret;
 
 	ret = adt7310_spi_read_byte(chip, ADT7310_CONFIG, &chip->config);
@@ -444,7 +443,7 @@ static ssize_t adt7310_set_event_mode(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7310_chip_info *chip = dev_info->dev_data;
+	struct adt7310_chip_info *chip = iio_priv(dev_info);
 	u16 config;
 	int ret;
 
@@ -477,7 +476,7 @@ static ssize_t adt7310_show_fault_queue(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7310_chip_info *chip = dev_info->dev_data;
+	struct adt7310_chip_info *chip = iio_priv(dev_info);
 	int ret;
 
 	ret = adt7310_spi_read_byte(chip, ADT7310_CONFIG, &chip->config);
@@ -493,7 +492,7 @@ static ssize_t adt7310_set_fault_queue(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7310_chip_info *chip = dev_info->dev_data;
+	struct adt7310_chip_info *chip = iio_priv(dev_info);
 	unsigned long data;
 	int ret;
 	u8 config;
@@ -523,7 +522,7 @@ static inline ssize_t adt7310_show_t_bound(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7310_chip_info *chip = dev_info->dev_data;
+	struct adt7310_chip_info *chip = iio_priv(dev_info);
 	u16 data;
 	int ret;
 
@@ -541,7 +540,7 @@ static inline ssize_t adt7310_set_t_bound(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7310_chip_info *chip = dev_info->dev_data;
+	struct adt7310_chip_info *chip = iio_priv(dev_info);
 	long tmp1, tmp2;
 	u16 data;
 	char *pos;
@@ -661,7 +660,7 @@ static ssize_t adt7310_show_t_hyst(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7310_chip_info *chip = dev_info->dev_data;
+	struct adt7310_chip_info *chip = iio_priv(dev_info);
 	int ret;
 	u8 t_hyst;
 
@@ -678,7 +677,7 @@ static inline ssize_t adt7310_set_t_hyst(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7310_chip_info *chip = dev_info->dev_data;
+	struct adt7310_chip_info *chip = iio_priv(dev_info);
 	int ret;
 	unsigned long data;
 	u8 t_hyst;
@@ -760,33 +759,28 @@ static const struct iio_info adt7310_info = {
 static int __devinit adt7310_probe(struct spi_device *spi_dev)
 {
 	struct adt7310_chip_info *chip;
+	struct iio_dev *indio_dev;
 	int ret = 0;
 	unsigned long *adt7310_platform_data = spi_dev->dev.platform_data;
 	unsigned long irq_flags;
 
-	chip = kzalloc(sizeof(struct adt7310_chip_info), GFP_KERNEL);
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
 
-	chip->indio_dev = iio_allocate_device(0);
-	if (chip->indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_free_chip;
-	}
-
-	chip->indio_dev->dev.parent = &spi_dev->dev;
-	chip->indio_dev->name = spi_get_device_id(spi_dev)->name;
-	chip->indio_dev->info = &adt7310_info;
-	chip->indio_dev->dev_data = (void *)chip;
-	chip->indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->dev.parent = &spi_dev->dev;
+	indio_dev->name = spi_get_device_id(spi_dev)->name;
+	indio_dev->info = &adt7310_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(chip->indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
@@ -800,8 +794,8 @@ static int __devinit adt7310_probe(struct spi_device *spi_dev)
 					   NULL,
 					   &adt7310_event_handler,
 					   irq_flags,
-					   chip->indio_dev->name,
-					   chip->indio_dev);
+					   indio_dev->name,
+					   indio_dev);
 		if (ret)
 			goto error_unreg_dev;
 	}
@@ -812,8 +806,8 @@ static int __devinit adt7310_probe(struct spi_device *spi_dev)
 					   NULL,
 					   &adt7310_event_handler,
 					   adt7310_platform_data[1],
-					   chip->indio_dev->name,
-					   chip->indio_dev);
+					   indio_dev->name,
+					   indio_dev);
 		if (ret)
 			goto error_unreg_ct_irq;
 	}
@@ -841,38 +835,34 @@ static int __devinit adt7310_probe(struct spi_device *spi_dev)
 	}
 
 	dev_info(&spi_dev->dev, "%s temperature sensor registered.\n",
-			chip->indio_dev->name);
+			indio_dev->name);
 
 	return 0;
 
 error_unreg_int_irq:
-	free_irq(adt7310_platform_data[0], chip->indio_dev);
+	free_irq(adt7310_platform_data[0], indio_dev);
 error_unreg_ct_irq:
-	free_irq(spi_dev->irq, chip->indio_dev);
+	free_irq(spi_dev->irq, indio_dev);
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
 
 static int __devexit adt7310_remove(struct spi_device *spi_dev)
 {
-	struct adt7310_chip_info *chip = dev_get_drvdata(&spi_dev->dev);
-	struct iio_dev *indio_dev = chip->indio_dev;
+	struct iio_dev *indio_dev = dev_get_drvdata(&spi_dev->dev);
 	unsigned long *adt7310_platform_data = spi_dev->dev.platform_data;
 
 	dev_set_drvdata(&spi_dev->dev, NULL);
 	if (adt7310_platform_data[0])
-		free_irq(adt7310_platform_data[0], chip->indio_dev);
+		free_irq(adt7310_platform_data[0], indio_dev);
 	if (spi_dev->irq)
-		free_irq(spi_dev->irq, chip->indio_dev);
+		free_irq(spi_dev->irq, indio_dev);
 	iio_device_unregister(indio_dev);
-	iio_free_device(chip->indio_dev);
-	kfree(chip);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
-- 
1.7.3.4
