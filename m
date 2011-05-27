Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 15/50] staging:iio:adc:ad7314 allocate chip state with iio_dev and use iio_priv to access.
Date: Fri, 27 May 2011 19:35:55 +0100
Message-Id: <1306521390-24897-16-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
References: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7314.c |   48 +++++++++++++++-----------------------
 1 files changed, 19 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7314.c b/drivers/staging/iio/adc/ad7314.c
index 98bb16f..9070d9c 100644
--- a/drivers/staging/iio/adc/ad7314.c
+++ b/drivers/staging/iio/adc/ad7314.c
@@ -43,7 +43,6 @@
 
 struct ad7314_chip_info {
 	struct spi_device *spi_dev;
-	struct iio_dev *indio_dev;
 	s64 last_timestamp;
 	u8  mode;
 };
@@ -87,7 +86,7 @@ static ssize_t ad7314_show_mode(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7314_chip_info *chip = dev_info->dev_data;
+	struct ad7314_chip_info *chip = iio_priv(dev_info);
 
 	if (chip->mode)
 		return sprintf(buf, "power-save\n");
@@ -101,7 +100,7 @@ static ssize_t ad7314_store_mode(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7314_chip_info *chip = dev_info->dev_data;
+	struct ad7314_chip_info *chip = iio_priv(dev_info);
 	u16 mode = 0;
 	int ret;
 
@@ -136,7 +135,7 @@ static ssize_t ad7314_show_temperature(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7314_chip_info *chip = dev_info->dev_data;
+	struct ad7314_chip_info *chip = iio_priv(dev_info);
 	u16 data;
 	char sign = ' ';
 	int ret;
@@ -202,54 +201,45 @@ static const struct iio_info ad7314_info = {
 static int __devinit ad7314_probe(struct spi_device *spi_dev)
 {
 	struct ad7314_chip_info *chip;
+	struct iio_dev *indio_dev;
 	int ret = 0;
 
-	chip = kzalloc(sizeof(struct ad7314_chip_info), GFP_KERNEL);
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
 	dev_set_drvdata(&spi_dev->dev, chip);
 
 	chip->spi_dev = spi_dev;
 
-	chip->indio_dev = iio_allocate_device(0);
-	if (chip->indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_free_chip;
-	}
+	indio_dev->name = spi_get_device_id(spi_dev)->name;
+	indio_dev->dev.parent = &spi_dev->dev;
+	indio_dev->info = &ad7314_info;
 
-	chip->indio_dev->name = spi_get_device_id(spi_dev)->name;
-	chip->indio_dev->dev.parent = &spi_dev->dev;
-	chip->indio_dev->info = &ad7314_info;
-	chip->indio_dev->dev_data = (void *)chip;
-
-	ret = iio_device_register(chip->indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
 	dev_info(&spi_dev->dev, "%s temperature sensor registered.\n",
-			 chip->indio_dev->name);
+			 indio_dev->name);
 
 	return 0;
 error_free_dev:
-	iio_free_device(chip->indio_dev);
-error_free_chip:
-	kfree(chip);
-
+	iio_free_device(indio_dev);
+error_ret:
 	return ret;
 }
 
 static int __devexit ad7314_remove(struct spi_device *spi_dev)
 {
-	struct ad7314_chip_info *chip = dev_get_drvdata(&spi_dev->dev);
-	struct iio_dev *indio_dev = chip->indio_dev;
+	struct iio_dev *indio_dev = dev_get_drvdata(&spi_dev->dev);
 
 	dev_set_drvdata(&spi_dev->dev, NULL);
 	iio_device_unregister(indio_dev);
-	iio_free_device(chip->indio_dev);
-	kfree(chip);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
-- 
1.7.3.4
