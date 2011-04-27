Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <drivers@analog.com>,
	<device-drivers-devel@blackfin.uclinux.org>, Michael Hennerich
	<michael.hennerich@analog.com>
Subject: [PATCH 2/2] IIO-onwards: ADC: AD7780: Use private data space from iio_allocate_device
Date: Wed, 27 Apr 2011 09:45:25 +0200
Message-ID: <1303890325-3770-2-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1303890325-3770-1-git-send-email-michael.hennerich@analog.com>
References: <1303890325-3770-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Use private data space from iio_allocate_device
Drop dev_data in favour of iio_priv()
Fix typo in gpio name
Fix error return path, free gpio
Make scale_uv type unsigned long

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/ad7780.c |   80 +++++++++++++++++---------------------
 1 files changed, 36 insertions(+), 44 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index c000efc..e68f2c2 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -40,7 +40,6 @@ struct ad7780_chip_info {
 };
 
 struct ad7780_state {
-	struct iio_dev			*indio_dev;
 	struct spi_device		*spi;
 	const struct ad7780_chip_info	*chip_info;
 	struct regulator		*reg;
@@ -92,9 +91,10 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
 			   int *val2,
 			   long m)
 {
-	int ret, smpl;
-	struct ad7780_state *st = indio_dev->dev_data;
-	unsigned int scale_uv;
+	struct ad7780_state *st = iio_priv(indio_dev);
+	struct iio_chan_spec channel = st->chip_info->channel;
+	int ret, smpl = 0;
+	unsigned long scale_uv;
 
 	switch (m) {
 	case 0:
@@ -109,11 +109,9 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
 			!((smpl & AD7780_PAT0) && !(smpl & AD7780_PAT1)))
 			return -EIO;
 
-		*val = (smpl >> st->chip_info->channel.scan_type.shift) &
-			((1 << (st->chip_info->channel.scan_type.realbits))
-			- 1);
-		*val -= (1 << (st->chip_info->channel.scan_type.realbits
-			- 1));
+		*val = (smpl >> channel.scan_type.shift) &
+			((1 << (channel.scan_type.realbits)) - 1);
+		*val -= (1 << (channel.scan_type.realbits - 1));
 
 		if (!(smpl & AD7780_GAIN))
 			*val *= 128;
@@ -121,7 +119,7 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
 		scale_uv = (st->int_vref_mv * 100000)
-			>> (st->chip_info->channel.scan_type.realbits - 1);
+			>> (channel.scan_type.realbits - 1);
 		*val =  scale_uv / 100000;
 		*val2 = (scale_uv % 100000) * 10;
 		return IIO_VAL_INT_PLUS_MICRO;
@@ -159,6 +157,7 @@ static int __devinit ad7780_probe(struct spi_device *spi)
 {
 	struct ad7780_platform_data *pdata = spi->dev.platform_data;
 	struct ad7780_state *st;
+	struct iio_dev *indio_dev;
 	int ret, voltage_uv = 0;
 
 	if (!pdata) {
@@ -166,11 +165,11 @@ static int __devinit ad7780_probe(struct spi_device *spi)
 		return -ENODEV;
 	}
 
-	st = kzalloc(sizeof(*st), GFP_KERNEL);
-	if (st == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
+	indio_dev = iio_allocate_device(sizeof(*st));
+	if (indio_dev == NULL)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
 
 	st->reg = regulator_get(&spi->dev, "vcc");
 	if (!IS_ERR(st->reg)) {
@@ -193,24 +192,16 @@ static int __devinit ad7780_probe(struct spi_device *spi)
 	else
 		dev_warn(&spi->dev, "reference voltage unspecified\n");
 
-	spi_set_drvdata(spi, st);
+	spi_set_drvdata(spi, indio_dev);
 	st->spi = spi;
 
-	st->indio_dev = iio_allocate_device(0);
-	if (st->indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_disable_reg;
-	}
-
-	/* Establish that the iio_dev is a child of the spi device */
-	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->name = spi_get_device_id(spi)->name;
-	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->driver_module = THIS_MODULE;
-	st->indio_dev->modes = INDIO_DIRECT_MODE;
-	st->indio_dev->channels = &st->chip_info->channel;
-	st->indio_dev->num_channels = 1;
-	st->indio_dev->read_raw = &ad7780_read_raw;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->driver_module = THIS_MODULE;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = &st->chip_info->channel;
+	indio_dev->num_channels = 1;
+	indio_dev->read_raw = &ad7780_read_raw;
 
 	init_waitqueue_head(&st->wq_data_avail);
 
@@ -223,20 +214,20 @@ static int __devinit ad7780_probe(struct spi_device *spi)
 	spi_message_add_tail(&st->xfer, &st->msg);
 
 	ret = gpio_request_one(st->pdata->gpio_pdrst, GPIOF_OUT_INIT_LOW,
-			       "AD7877 /PDRST");
+			       "AD7780 /PDRST");
 	if (ret) {
 		dev_err(&spi->dev, "failed to request GPIO PDRST\n");
-		goto error_free_device;
+		goto error_disable_reg;
 	}
 
 	ret = request_irq(spi->irq, ad7780_interrupt,
 		IRQF_TRIGGER_FALLING, spi_get_device_id(spi)->name, st);
 	if (ret)
-		goto error_free_device;
+		goto error_free_gpio;
 
 	disable_irq(spi->irq);
 
-	ret = iio_device_register(st->indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_free_irq;
 
@@ -244,32 +235,33 @@ static int __devinit ad7780_probe(struct spi_device *spi)
 
 error_free_irq:
 	free_irq(spi->irq, st);
-
-error_free_device:
-	iio_free_device(st->indio_dev);
+error_free_gpio:
+	gpio_free(st->pdata->gpio_pdrst);
 error_disable_reg:
 	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
 error_put_reg:
 	if (!IS_ERR(st->reg))
 		regulator_put(st->reg);
-	kfree(st);
-error_ret:
+
+	iio_free_device(indio_dev);
+
 	return ret;
 }
 
 static int ad7780_remove(struct spi_device *spi)
 {
-	struct ad7780_state *st = spi_get_drvdata(spi);
-	struct iio_dev *indio_dev = st->indio_dev;
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct ad7780_state *st = iio_priv(indio_dev);
+
 	free_irq(spi->irq, st);
 	gpio_free(st->pdata->gpio_pdrst);
-	iio_device_unregister(indio_dev);
 	if (!IS_ERR(st->reg)) {
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
 	}
-	kfree(st);
+	iio_device_unregister(indio_dev);
+
 	return 0;
 }
 
-- 
1.6.0.2
