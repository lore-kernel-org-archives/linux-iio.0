Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:53461 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754674Ab1HZJ5l (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Aug 2011 05:57:41 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 13/14] staging:iio:fix using iio_priv or iio_dev after iio_unregister_device
Date: Fri, 26 Aug 2011 11:05:47 +0100
Message-Id: <1314353148-6670-14-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314353148-6670-1-git-send-email-jic23@cam.ac.uk>
References: <1314353148-6670-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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
index 0260026..11fd17a 100644
--- a/drivers/staging/iio/accel/adis16201_core.c
+++ b/drivers/staging/iio/accel/adis16201_core.c
@@ -537,8 +537,8 @@ static int adis16201_remove(struct spi_device *spi)
 
 	adis16201_remove_trigger(indio_dev);
 	iio_ring_buffer_unregister(indio_dev);
-	iio_device_unregister(indio_dev);
 	adis16201_unconfigure_ring(indio_dev);
+	iio_device_unregister(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index c13cfc7..7909a67 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -491,8 +491,8 @@ static int adis16203_remove(struct spi_device *spi)
 
 	adis16203_remove_trigger(indio_dev);
 	iio_ring_buffer_unregister(indio_dev);
-	iio_device_unregister(indio_dev);
 	adis16203_unconfigure_ring(indio_dev);
+	iio_device_unregister(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index 16a0fbd..4458d9d 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -566,8 +566,8 @@ static int adis16204_remove(struct spi_device *spi)
 
 	adis16204_remove_trigger(indio_dev);
 	iio_ring_buffer_unregister(indio_dev);
-	iio_device_unregister(indio_dev);
 	adis16204_unconfigure_ring(indio_dev);
+	iio_device_unregister(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index 93b76ca..178d64e 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -541,8 +541,8 @@ static int adis16209_remove(struct spi_device *spi)
 
 	adis16209_remove_trigger(indio_dev);
 	iio_ring_buffer_unregister(indio_dev);
-	iio_device_unregister(indio_dev);
 	adis16209_unconfigure_ring(indio_dev);
+	iio_device_unregister(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index 720fd45..cae8b27 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -595,8 +595,8 @@ static int adis16240_remove(struct spi_device *spi)
 
 	adis16240_remove_trigger(indio_dev);
 	iio_ring_buffer_unregister(indio_dev);
-	iio_device_unregister(indio_dev);
 	adis16240_unconfigure_ring(indio_dev);
+	iio_device_unregister(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index 3991633..cf927e1 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -856,7 +856,6 @@ static int __devexit ad7291_remove(struct i2c_client *client)
 	if (client->irq)
 		free_irq(client->irq, indio_dev);
 	iio_device_unregister(indio_dev);
-	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/ad7314.c b/drivers/staging/iio/adc/ad7314.c
index 9070d9c..bd67acd 100644
--- a/drivers/staging/iio/adc/ad7314.c
+++ b/drivers/staging/iio/adc/ad7314.c
@@ -239,7 +239,6 @@ static int __devexit ad7314_remove(struct spi_device *spi_dev)
 
 	dev_set_drvdata(&spi_dev->dev, NULL);
 	iio_device_unregister(indio_dev);
-	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index fb861fb..3a9c0fc 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -442,7 +442,6 @@ static int __devexit ad7816_remove(struct spi_device *spi_dev)
 	gpio_free(chip->convert_pin);
 	gpio_free(chip->rdwr_pin);
 	iio_device_unregister(indio_dev);
-	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/adt7310.c b/drivers/staging/iio/adc/adt7310.c
index 8f5c3fc..096e097 100644
--- a/drivers/staging/iio/adc/adt7310.c
+++ b/drivers/staging/iio/adc/adt7310.c
@@ -863,7 +863,6 @@ static int __devexit adt7310_remove(struct spi_device *spi_dev)
 	if (spi_dev->irq)
 		free_irq(spi_dev->irq, indio_dev);
 	iio_device_unregister(indio_dev);
-	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/adt75.c b/drivers/staging/iio/adc/adt75.c
index a306dbd..988c200 100644
--- a/drivers/staging/iio/adc/adt75.c
+++ b/drivers/staging/iio/adc/adt75.c
@@ -617,7 +617,6 @@ static int __devexit adt75_remove(struct i2c_client *client)
 	if (client->irq)
 		free_irq(client->irq, indio_dev);
 	iio_device_unregister(indio_dev);
-	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 82cbd26..14319d1b 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -2224,7 +2224,6 @@ int __devexit adt7316_remove(struct device *dev)
 	if (chip->bus.irq)
 		free_irq(chip->bus.irq, indio_dev);
 	iio_device_unregister(indio_dev);
-	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/dac/ad5624r_spi.c b/drivers/staging/iio/dac/ad5624r_spi.c
index a5b3776..4581d26 100644
--- a/drivers/staging/iio/dac/ad5624r_spi.c
+++ b/drivers/staging/iio/dac/ad5624r_spi.c
@@ -261,12 +261,12 @@ static int __devinit ad5624r_probe(struct spi_device *spi)
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
index 66610a3..97294de 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -676,8 +676,8 @@ static int adis16260_remove(struct spi_device *spi)
 
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
index 53cb031..1424469 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -783,8 +783,8 @@ static int __devexit ad2s1210_remove(struct spi_device *spi)
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

