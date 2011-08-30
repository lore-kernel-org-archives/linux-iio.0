Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 13/14] staging:iio:fix using iio_priv or iio_dev after iio_unregister_device
Date: Tue, 30 Aug 2011 12:41:18 +0100
Message-Id: <1314704479-15956-14-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314704479-15956-1-git-send-email-jic23@cam.ac.uk>
References: <1314704479-15956-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This includes calling iio_free_device as that should only be called
before the device has been registered.

Also one case of iio_free_device being called on a registered device.

This has been pulled out of the reworking attributes patch.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16201_core.c |    2 +-
 drivers/staging/iio/accel/adis16203_core.c |    2 +-
 drivers/staging/iio/accel/adis16204_core.c |    2 +-
 drivers/staging/iio/accel/adis16209_core.c |    2 +-
 drivers/staging/iio/accel/adis16240_core.c |    2 +-
 drivers/staging/iio/adc/ad7291.c           |    1 -
 drivers/staging/iio/adc/ad7314.c           |    1 -
 drivers/staging/iio/adc/ad7816.c           |    1 -
 drivers/staging/iio/adc/adt7310.c          |    1 -
 drivers/staging/iio/adc/adt75.c            |    1 -
 drivers/staging/iio/addac/adt7316.c        |    1 -
 drivers/staging/iio/dac/ad5624r_spi.c      |    6 +++---
 drivers/staging/iio/gyro/adis16260_core.c  |    2 +-
 drivers/staging/iio/magnetometer/ak8975.c  |    1 -
 drivers/staging/iio/resolver/ad2s1210.c    |    2 +-
 15 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
index 30ac7e2..1e19aba 100644
--- a/drivers/staging/iio/accel/adis16201_core.c
+++ b/drivers/staging/iio/accel/adis16201_core.c
@@ -538,8 +538,8 @@ static int adis16201_remove(struct spi_device *spi)
 
 	adis16201_remove_trigger(indio_dev);
 	iio_ring_buffer_unregister(indio_dev);
-	iio_device_unregister(indio_dev);
 	adis16201_unconfigure_ring(indio_dev);
+	iio_device_unregister(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index dc52462..2a658f0 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -492,8 +492,8 @@ static int adis16203_remove(struct spi_device *spi)
 
 	adis16203_remove_trigger(indio_dev);
 	iio_ring_buffer_unregister(indio_dev);
-	iio_device_unregister(indio_dev);
 	adis16203_unconfigure_ring(indio_dev);
+	iio_device_unregister(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index dedccdd..42a37bb 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -567,8 +567,8 @@ static int adis16204_remove(struct spi_device *spi)
 
 	adis16204_remove_trigger(indio_dev);
 	iio_ring_buffer_unregister(indio_dev);
-	iio_device_unregister(indio_dev);
 	adis16204_unconfigure_ring(indio_dev);
+	iio_device_unregister(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index d8f4b27..d59a9e4 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -542,8 +542,8 @@ static int adis16209_remove(struct spi_device *spi)
 
 	adis16209_remove_trigger(indio_dev);
 	iio_ring_buffer_unregister(indio_dev);
-	iio_device_unregister(indio_dev);
 	adis16209_unconfigure_ring(indio_dev);
+	iio_device_unregister(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index f6fa0ba..b6504f1 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -596,8 +596,8 @@ static int adis16240_remove(struct spi_device *spi)
 
 	adis16240_remove_trigger(indio_dev);
 	iio_ring_buffer_unregister(indio_dev);
-	iio_device_unregister(indio_dev);
 	adis16240_unconfigure_ring(indio_dev);
+	iio_device_unregister(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index ac7c04e..16ddbde 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -857,7 +857,6 @@ static int __devexit ad7291_remove(struct i2c_client *client)
 	if (client->irq)
 		free_irq(client->irq, indio_dev);
 	iio_device_unregister(indio_dev);
-	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/ad7314.c b/drivers/staging/iio/adc/ad7314.c
index e3d38db..094a4ee 100644
--- a/drivers/staging/iio/adc/ad7314.c
+++ b/drivers/staging/iio/adc/ad7314.c
@@ -240,7 +240,6 @@ static int __devexit ad7314_remove(struct spi_device *spi_dev)
 
 	dev_set_drvdata(&spi_dev->dev, NULL);
 	iio_device_unregister(indio_dev);
-	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 2706de3..5a4586f 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -443,7 +443,6 @@ static int __devexit ad7816_remove(struct spi_device *spi_dev)
 	gpio_free(chip->convert_pin);
 	gpio_free(chip->rdwr_pin);
 	iio_device_unregister(indio_dev);
-	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/adt7310.c b/drivers/staging/iio/adc/adt7310.c
index e002e97..edc65c5 100644
--- a/drivers/staging/iio/adc/adt7310.c
+++ b/drivers/staging/iio/adc/adt7310.c
@@ -864,7 +864,6 @@ static int __devexit adt7310_remove(struct spi_device *spi_dev)
 	if (spi_dev->irq)
 		free_irq(spi_dev->irq, indio_dev);
 	iio_device_unregister(indio_dev);
-	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/adt75.c b/drivers/staging/iio/adc/adt75.c
index 440c799..b56bfcd 100644
--- a/drivers/staging/iio/adc/adt75.c
+++ b/drivers/staging/iio/adc/adt75.c
@@ -618,7 +618,6 @@ static int __devexit adt75_remove(struct i2c_client *client)
 	if (client->irq)
 		free_irq(client->irq, indio_dev);
 	iio_device_unregister(indio_dev);
-	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 0cb3091..e60a9d6 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -2225,7 +2225,6 @@ int __devexit adt7316_remove(struct device *dev)
 	if (chip->bus.irq)
 		free_irq(chip->bus.irq, indio_dev);
 	iio_device_unregister(indio_dev);
-	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/dac/ad5624r_spi.c b/drivers/staging/iio/dac/ad5624r_spi.c
index 7303bb1..c4bdf42 100644
--- a/drivers/staging/iio/dac/ad5624r_spi.c
+++ b/drivers/staging/iio/dac/ad5624r_spi.c
@@ -262,12 +262,12 @@ static int __devinit ad5624r_probe(struct spi_device *spi)
 	indio_dev->info = &ad5624r_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(indio_dev);
+	ret = ad5624r_spi_write(spi, AD5624R_CMD_INTERNAL_REFER_SETUP, 0,
+				!!voltage_uv, 16);
 	if (ret)
 		goto error_free_dev;
 
-	ret = ad5624r_spi_write(spi, AD5624R_CMD_INTERNAL_REFER_SETUP, 0,
-				!!voltage_uv, 16);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index ed3b6db..6ea6d58 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -677,8 +677,8 @@ static int adis16260_remove(struct spi_device *spi)
 
 	adis16260_remove_trigger(indio_dev);
 	iio_ring_buffer_unregister(indio_dev);
-	iio_device_unregister(indio_dev);
 	adis16260_unconfigure_ring(indio_dev);
+	iio_device_unregister(indio_dev);
 
 err_ret:
 	return ret;
diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
index 43936cb..0697ab3 100644
--- a/drivers/staging/iio/magnetometer/ak8975.c
+++ b/drivers/staging/iio/magnetometer/ak8975.c
@@ -547,7 +547,6 @@ static int ak8975_remove(struct i2c_client *client)
 	int eoc_gpio = data->eoc_gpio;
 
 	iio_device_unregister(indio_dev);
-	iio_free_device(indio_dev);
 
 	if (eoc_gpio)
 		gpio_free(eoc_gpio);
diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index f8459e8..5e83227 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -784,8 +784,8 @@ static int __devexit ad2s1210_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad2s1210_state *st = iio_priv(indio_dev);
-	iio_device_unregister(indio_dev);
 	ad2s1210_free_gpios(st);
+	iio_device_unregister(indio_dev);
 
 	return 0;
 }
-- 
1.7.3.4
