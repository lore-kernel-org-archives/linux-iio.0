Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/2] staging:iio:namespace move iio_device_register -> iio_st_device_register
Date: Mon,  7 Nov 2011 14:31:27 +0000
Message-Id: <1320676288-11395-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1320676288-11395-1-git-send-email-jic23@kernel.org>
References: <1320676288-11395-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@cam.ac.uk>

Making space for the move out of staging.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Documentation/device.txt    |    4 ++--
 drivers/staging/iio/accel/adis16201_core.c      |    4 ++--
 drivers/staging/iio/accel/adis16203_core.c      |    4 ++--
 drivers/staging/iio/accel/adis16204_core.c      |    4 ++--
 drivers/staging/iio/accel/adis16209_core.c      |    4 ++--
 drivers/staging/iio/accel/adis16220_core.c      |    6 +++---
 drivers/staging/iio/accel/adis16240_core.c      |    4 ++--
 drivers/staging/iio/accel/kxsd9.c               |    4 ++--
 drivers/staging/iio/accel/lis3l02dq_core.c      |    4 ++--
 drivers/staging/iio/accel/sca3000_core.c        |    6 +++---
 drivers/staging/iio/adc/ad7192.c                |    4 ++--
 drivers/staging/iio/adc/ad7280a.c               |    6 +++---
 drivers/staging/iio/adc/ad7291.c                |    4 ++--
 drivers/staging/iio/adc/ad7298_core.c           |    4 ++--
 drivers/staging/iio/adc/ad7476_core.c           |    4 ++--
 drivers/staging/iio/adc/ad7606_core.c           |    4 ++--
 drivers/staging/iio/adc/ad7780.c                |    4 ++--
 drivers/staging/iio/adc/ad7793.c                |    4 ++--
 drivers/staging/iio/adc/ad7816.c                |    4 ++--
 drivers/staging/iio/adc/ad7887_core.c           |    4 ++--
 drivers/staging/iio/adc/ad799x_core.c           |    4 ++--
 drivers/staging/iio/adc/adt7310.c               |    4 ++--
 drivers/staging/iio/adc/adt7410.c               |    4 ++--
 drivers/staging/iio/adc/max1363_core.c          |    4 ++--
 drivers/staging/iio/addac/adt7316.c             |    4 ++--
 drivers/staging/iio/cdc/ad7150.c                |    4 ++--
 drivers/staging/iio/cdc/ad7152.c                |    4 ++--
 drivers/staging/iio/cdc/ad7746.c                |    4 ++--
 drivers/staging/iio/dac/ad5064.c                |    4 ++--
 drivers/staging/iio/dac/ad5360.c                |    4 ++--
 drivers/staging/iio/dac/ad5446.c                |    4 ++--
 drivers/staging/iio/dac/ad5504.c                |    4 ++--
 drivers/staging/iio/dac/ad5624r_spi.c           |    4 ++--
 drivers/staging/iio/dac/ad5686.c                |    4 ++--
 drivers/staging/iio/dac/ad5791.c                |    4 ++--
 drivers/staging/iio/dac/max517.c                |    2 +-
 drivers/staging/iio/dds/ad5930.c                |    4 ++--
 drivers/staging/iio/dds/ad9832.c                |    4 ++--
 drivers/staging/iio/dds/ad9834.c                |    4 ++--
 drivers/staging/iio/dds/ad9850.c                |    4 ++--
 drivers/staging/iio/dds/ad9852.c                |    4 ++--
 drivers/staging/iio/dds/ad9910.c                |    4 ++--
 drivers/staging/iio/dds/ad9951.c                |    4 ++--
 drivers/staging/iio/gyro/adis16060_core.c       |    4 ++--
 drivers/staging/iio/gyro/adis16080_core.c       |    4 ++--
 drivers/staging/iio/gyro/adis16130_core.c       |    4 ++--
 drivers/staging/iio/gyro/adis16260_core.c       |    4 ++--
 drivers/staging/iio/gyro/adxrs450_core.c        |    6 +++---
 drivers/staging/iio/iio.h                       |    8 ++++----
 drivers/staging/iio/iio_simple_dummy.c          |    4 ++--
 drivers/staging/iio/impedance-analyzer/ad5933.c |    4 ++--
 drivers/staging/iio/imu/adis16400_core.c        |    4 ++--
 drivers/staging/iio/industrialio-core.c         |    8 ++++----
 drivers/staging/iio/light/isl29018.c            |    4 ++--
 drivers/staging/iio/light/tsl2563.c             |    4 ++--
 drivers/staging/iio/light/tsl2583.c             |    4 ++--
 drivers/staging/iio/magnetometer/ak8975.c       |    4 ++--
 drivers/staging/iio/magnetometer/hmc5843.c      |    4 ++--
 drivers/staging/iio/meter/ade7753.c             |    4 ++--
 drivers/staging/iio/meter/ade7754.c             |    4 ++--
 drivers/staging/iio/meter/ade7758_core.c        |    4 ++--
 drivers/staging/iio/meter/ade7759.c             |    4 ++--
 drivers/staging/iio/meter/ade7854.c             |    6 +++---
 drivers/staging/iio/resolver/ad2s1200.c         |    4 ++--
 drivers/staging/iio/resolver/ad2s1210.c         |    4 ++--
 drivers/staging/iio/resolver/ad2s90.c           |    4 ++--
 66 files changed, 140 insertions(+), 140 deletions(-)

diff --git a/drivers/staging/iio/Documentation/device.txt b/drivers/staging/iio/Documentation/device.txt
index 1abb80c..eb28554 100644
--- a/drivers/staging/iio/Documentation/device.txt
+++ b/drivers/staging/iio/Documentation/device.txt
@@ -69,7 +69,7 @@ Then fill in the following:
 - indio_dev->num_channels:
 	How many channels are there?
 
-Once these are set up, a call to iio_device_register(indio_dev),
+Once these are set up, a call to iio_st_device_register(indio_dev),
 will register the device with the iio core.
 
 Worth noting here is that, if a ring buffer is to be used, it can be
@@ -77,5 +77,5 @@ allocated prior to registering the device with the iio-core, but must
 be registered afterwards (otherwise the whole parentage of devices
 gets confused)
 
-On remove, iio_device_unregister(indio_dev) will remove the device from
+On remove, iio_st_device_unregister(indio_dev) will remove the device from
 the core, and iio_free_device will clean up.
diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
index d3d877f..fd6b1de 100644
--- a/drivers/staging/iio/accel/adis16201_core.c
+++ b/drivers/staging/iio/accel/adis16201_core.c
@@ -510,7 +510,7 @@ static int __devinit adis16201_probe(struct spi_device *spi)
 	if (ret)
 		goto error_remove_trigger;
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret < 0)
 		goto error_remove_trigger;
 	return 0;
@@ -531,7 +531,7 @@ static int adis16201_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	adis16201_remove_trigger(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	adis16201_unconfigure_ring(indio_dev);
diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index bdc44fe..727b5a2 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -464,7 +464,7 @@ static int __devinit adis16203_probe(struct spi_device *spi)
 	if (ret)
 		goto error_remove_trigger;
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_remove_trigger;
 
@@ -486,7 +486,7 @@ static int adis16203_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	adis16203_remove_trigger(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	adis16203_unconfigure_ring(indio_dev);
diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index 96d8c7b..468d7ab 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -538,7 +538,7 @@ static int __devinit adis16204_probe(struct spi_device *spi)
 	ret = adis16204_initial_setup(indio_dev);
 	if (ret)
 		goto error_remove_trigger;
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_remove_trigger;
 
@@ -560,7 +560,7 @@ static int adis16204_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	adis16204_remove_trigger(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	adis16204_unconfigure_ring(indio_dev);
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index 62e6bd8..c5f3999 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -511,7 +511,7 @@ static int __devinit adis16209_probe(struct spi_device *spi)
 	ret = adis16209_initial_setup(indio_dev);
 	if (ret)
 		goto error_remove_trigger;
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_remove_trigger;
 
@@ -535,7 +535,7 @@ static int adis16209_remove(struct spi_device *spi)
 
 	flush_scheduled_work();
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	adis16209_remove_trigger(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	adis16209_unconfigure_ring(indio_dev);
diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
index ca18f72..0608821 100644
--- a/drivers/staging/iio/accel/adis16220_core.c
+++ b/drivers/staging/iio/accel/adis16220_core.c
@@ -649,7 +649,7 @@ static int __devinit adis16220_probe(struct spi_device *spi)
 	indio_dev->channels = adis16220_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adis16220_channels);
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
@@ -678,7 +678,7 @@ error_rm_adc1_bin:
 error_rm_accel_bin:
 	sysfs_remove_bin_file(&indio_dev->dev.kobj, &accel_bin);
 error_unregister_dev:
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 error_free_dev:
 	iio_free_device(indio_dev);
 error_ret:
@@ -694,7 +694,7 @@ static int adis16220_remove(struct spi_device *spi)
 	sysfs_remove_bin_file(&indio_dev->dev.kobj, &adc2_bin);
 	sysfs_remove_bin_file(&indio_dev->dev.kobj, &adc1_bin);
 	sysfs_remove_bin_file(&indio_dev->dev.kobj, &accel_bin);
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	iio_free_device(indio_dev);
 
 	return 0;
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index 1348393..2555219 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -564,7 +564,7 @@ static int __devinit adis16240_probe(struct spi_device *spi)
 	ret = adis16240_initial_setup(indio_dev);
 	if (ret)
 		goto error_remove_trigger;
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_remove_trigger;
 	return 0;
@@ -588,7 +588,7 @@ static int adis16240_remove(struct spi_device *spi)
 
 	flush_scheduled_work();
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	adis16240_remove_trigger(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	adis16240_unconfigure_ring(indio_dev);
diff --git a/drivers/staging/iio/accel/kxsd9.c b/drivers/staging/iio/accel/kxsd9.c
index abb6071..9798f3c 100644
--- a/drivers/staging/iio/accel/kxsd9.c
+++ b/drivers/staging/iio/accel/kxsd9.c
@@ -243,7 +243,7 @@ static int __devinit kxsd9_probe(struct spi_device *spi)
 	indio_dev->info = &kxsd9_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
@@ -261,7 +261,7 @@ error_ret:
 
 static int __devexit kxsd9_remove(struct spi_device *spi)
 {
-	iio_device_unregister(spi_get_drvdata(spi));
+	iio_st_device_unregister(spi_get_drvdata(spi));
 	iio_free_device(spi_get_drvdata(spi));
 
 	return 0;
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index 6d715a6..1f6d1fb 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -720,7 +720,7 @@ static int __devinit lis3l02dq_probe(struct spi_device *spi)
 	if (ret)
 		goto error_remove_trigger;
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_remove_trigger;
 
@@ -775,7 +775,7 @@ static int lis3l02dq_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct lis3l02dq_state *st = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 
 	ret = lis3l02dq_disable_all_events(indio_dev);
 	if (ret)
diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 021a08f..c61578b 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -1152,7 +1152,7 @@ static int __devinit sca3000_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	sca3000_configure_ring(indio_dev);
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret < 0)
 		goto error_free_dev;
 
@@ -1189,7 +1189,7 @@ error_free_irq:
 error_unregister_ring:
 	iio_buffer_unregister(indio_dev);
 error_unregister_dev:
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 error_free_dev:
 	iio_free_device(indio_dev);
 
@@ -1226,7 +1226,7 @@ static int sca3000_remove(struct spi_device *spi)
 		return ret;
 	if (spi->irq)
 		free_irq(spi->irq, indio_dev);
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	sca3000_unconfigure_ring(indio_dev);
 	iio_free_device(indio_dev);
diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 1dd0f9f..66a1d4a 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -1106,7 +1106,7 @@ static int __devinit ad7192_probe(struct spi_device *spi)
 	if (ret)
 		goto error_unreg_ring;
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret < 0)
 		goto error_unreg_ring;
 	return 0;
@@ -1134,7 +1134,7 @@ static int ad7192_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad7192_state *st = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	ad7192_remove_trigger(indio_dev);
 	ad7192_ring_cleanup(indio_dev);
diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 2b7cb52..fb2b4fd 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -901,7 +901,7 @@ static int __devinit ad7280_probe(struct spi_device *spi)
 	if (ret < 0)
 		goto error_free_channels;
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_free_attr;
 
@@ -932,7 +932,7 @@ static int __devinit ad7280_probe(struct spi_device *spi)
 
 	return 0;
 error_unregister:
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 
 error_free_attr:
 	kfree(st->iio_attr);
@@ -953,7 +953,7 @@ static int __devexit ad7280_remove(struct spi_device *spi)
 
 	if (spi->irq > 0)
 		free_irq(spi->irq, indio_dev);
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 
 	ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CONTROL_HB, 1,
 			AD7280A_CTRL_HB_PWRDN_SW | st->ctrl_hb);
diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index c4977a7..eb9585e 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -648,7 +648,7 @@ static int __devinit ad7291_probe(struct i2c_client *client,
 			goto error_disable_reg;
 	}
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_unreg_irq;
 
@@ -677,7 +677,7 @@ static int __devexit ad7291_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct ad7291_chip_info *chip = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 
 	if (client->irq)
 		free_irq(client->irq, indio_dev);
diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/adc/ad7298_core.c
index 0be71df..0e8a082 100644
--- a/drivers/staging/iio/adc/ad7298_core.c
+++ b/drivers/staging/iio/adc/ad7298_core.c
@@ -228,7 +228,7 @@ static int __devinit ad7298_probe(struct spi_device *spi)
 				  ARRAY_SIZE(ad7298_channels) - 1);
 	if (ret)
 		goto error_cleanup_ring;
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_unregister_ring;
 
@@ -254,7 +254,7 @@ static int __devexit ad7298_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad7298_state *st = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	ad7298_ring_cleanup(indio_dev);
 	if (!IS_ERR(st->reg)) {
diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
index a06ae9e..31670bb 100644
--- a/drivers/staging/iio/adc/ad7476_core.c
+++ b/drivers/staging/iio/adc/ad7476_core.c
@@ -185,7 +185,7 @@ static int __devinit ad7476_probe(struct spi_device *spi)
 	if (ret)
 		goto error_cleanup_ring;
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_ring_unregister;
 	return 0;
@@ -211,7 +211,7 @@ static int ad7476_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad7476_state *st = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	ad7476_ring_cleanup(indio_dev);
 	if (!IS_ERR(st->reg)) {
diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index a8596b8..74f86fa 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -513,7 +513,7 @@ struct iio_dev *ad7606_probe(struct device *dev, int irq,
 				  indio_dev->num_channels);
 	if (ret)
 		goto error_cleanup_ring;
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_unregister_ring;
 
@@ -545,7 +545,7 @@ int ad7606_remove(struct iio_dev *indio_dev, int irq)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	ad7606_ring_cleanup(indio_dev);
 
diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index f5f7e76..61bf5b4 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -228,7 +228,7 @@ static int __devinit ad7780_probe(struct spi_device *spi)
 
 	disable_irq(spi->irq);
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_free_irq;
 
@@ -255,7 +255,7 @@ static int ad7780_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad7780_state *st = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	free_irq(spi->irq, st);
 	gpio_free(st->pdata->gpio_pdrst);
 	if (!IS_ERR(st->reg)) {
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index cbefa22..df2e671 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -986,7 +986,7 @@ static int __devinit ad7793_probe(struct spi_device *spi)
 	if (ret)
 		goto error_uninitialize_ring;
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_uninitialize_ring;
 
@@ -1015,7 +1015,7 @@ static int ad7793_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad7793_state *st = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	ad7793_remove_trigger(indio_dev);
 	ad7793_ring_cleanup(indio_dev);
diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 7a344a2..aa94c9a 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -409,7 +409,7 @@ static int __devinit ad7816_probe(struct spi_device *spi_dev)
 			goto error_free_gpio;
 	}
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_free_irq;
 
@@ -436,7 +436,7 @@ static int __devexit ad7816_remove(struct spi_device *spi_dev)
 	struct iio_dev *indio_dev = dev_get_drvdata(&spi_dev->dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	dev_set_drvdata(&spi_dev->dev, NULL);
 	if (spi_dev->irq)
 		free_irq(spi_dev->irq, indio_dev);
diff --git a/drivers/staging/iio/adc/ad7887_core.c b/drivers/staging/iio/adc/ad7887_core.c
index baa6e6a..c26ea9e 100644
--- a/drivers/staging/iio/adc/ad7887_core.c
+++ b/drivers/staging/iio/adc/ad7887_core.c
@@ -205,7 +205,7 @@ static int __devinit ad7887_probe(struct spi_device *spi)
 	if (ret)
 		goto error_cleanup_ring;
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_unregister_ring;
 
@@ -230,7 +230,7 @@ static int ad7887_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad7887_state *st = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	ad7887_ring_cleanup(indio_dev);
 	if (!IS_ERR(st->reg)) {
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index cdee9b9..25ed246 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -867,7 +867,7 @@ static int __devinit ad799x_probe(struct i2c_client *client,
 		if (ret)
 			goto error_cleanup_ring;
 	}
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_free_irq;
 
@@ -893,7 +893,7 @@ static __devexit int ad799x_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct ad799x_state *st = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	if (client->irq > 0)
 		free_irq(client->irq, indio_dev);
 
diff --git a/drivers/staging/iio/adc/adt7310.c b/drivers/staging/iio/adc/adt7310.c
index c937ac1..aa3a1c0 100644
--- a/drivers/staging/iio/adc/adt7310.c
+++ b/drivers/staging/iio/adc/adt7310.c
@@ -832,7 +832,7 @@ static int __devinit adt7310_probe(struct spi_device *spi_dev)
 		}
 	}
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_unreg_int_irq;
 
@@ -856,7 +856,7 @@ static int __devexit adt7310_remove(struct spi_device *spi_dev)
 	struct iio_dev *indio_dev = dev_get_drvdata(&spi_dev->dev);
 	unsigned long *adt7310_platform_data = spi_dev->dev.platform_data;
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	dev_set_drvdata(&spi_dev->dev, NULL);
 	if (adt7310_platform_data[0])
 		free_irq(adt7310_platform_data[0], indio_dev);
diff --git a/drivers/staging/iio/adc/adt7410.c b/drivers/staging/iio/adc/adt7410.c
index 16467a7..5fbe0a1 100644
--- a/drivers/staging/iio/adc/adt7410.c
+++ b/drivers/staging/iio/adc/adt7410.c
@@ -796,7 +796,7 @@ static int __devinit adt7410_probe(struct i2c_client *client,
 			goto error_unreg_int_irq;
 		}
 	}
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_unreg_int_irq;
 
@@ -820,7 +820,7 @@ static int __devexit adt7410_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	unsigned long *adt7410_platform_data = client->dev.platform_data;
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	if (adt7410_platform_data[0])
 		free_irq(adt7410_platform_data[0], indio_dev);
 	if (client->irq)
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index c3e28e1..cbd49577 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -1319,7 +1319,7 @@ static int __devinit max1363_probe(struct i2c_client *client,
 			goto error_uninit_ring;
 	}
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret < 0)
 		goto error_free_irq;
 
@@ -1348,7 +1348,7 @@ static int max1363_remove(struct i2c_client *client)
 	struct max1363_state *st = iio_priv(indio_dev);
 	struct regulator *reg = st->reg;
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	if (client->irq)
 		free_irq(st->client->irq, indio_dev);
 	iio_buffer_unregister(indio_dev);
diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 13c3929..dee498b 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -2197,7 +2197,7 @@ int __devinit adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 		goto error_unreg_irq;
 	}
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_unreg_irq;
 
@@ -2220,7 +2220,7 @@ int __devexit adt7316_remove(struct device *dev)
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adt7316_chip_info *chip = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	if (chip->bus.irq)
 		free_irq(chip->bus.irq, indio_dev);
 	iio_free_device(indio_dev);
diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 6bcdb14..ea68ffc 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -603,7 +603,7 @@ static int __devinit ad7150_probe(struct i2c_client *client,
 			goto error_free_irq;
 	}
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_free_irq2;
 
@@ -628,7 +628,7 @@ static int __devexit ad7150_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	if (client->irq)
 		free_irq(client->irq, indio_dev);
 
diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
index 29b2dc6..d193b65 100644
--- a/drivers/staging/iio/cdc/ad7152.c
+++ b/drivers/staging/iio/cdc/ad7152.c
@@ -500,7 +500,7 @@ static int __devinit ad7152_probe(struct i2c_client *client,
 	indio_dev->num_channels = ARRAY_SIZE(ad7152_channels);
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
@@ -518,7 +518,7 @@ static int __devexit ad7152_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	iio_free_device(indio_dev);
 
 	return 0;
diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index de8f844..ecbaf12 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -747,7 +747,7 @@ static int __devinit ad7746_probe(struct i2c_client *client,
 	if (ret < 0)
 		goto error_free_dev;
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
@@ -765,7 +765,7 @@ static int __devexit ad7746_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	iio_free_device(indio_dev);
 
 	return 0;
diff --git a/drivers/staging/iio/dac/ad5064.c b/drivers/staging/iio/dac/ad5064.c
index a701063..58d726d 100644
--- a/drivers/staging/iio/dac/ad5064.c
+++ b/drivers/staging/iio/dac/ad5064.c
@@ -395,7 +395,7 @@ static int __devinit ad5064_probe(struct spi_device *spi)
 	indio_dev->channels = st->chip_info->channel;
 	indio_dev->num_channels = AD5064_DAC_CHANNELS;
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_disable_reg;
 
@@ -417,7 +417,7 @@ static int __devexit ad5064_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad5064_state *st = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 
 	regulator_bulk_disable(ad5064_num_vref(st), st->vref_reg);
 	regulator_bulk_free(ad5064_num_vref(st), st->vref_reg);
diff --git a/drivers/staging/iio/dac/ad5360.c b/drivers/staging/iio/dac/ad5360.c
index c5bf582..b852cf1 100644
--- a/drivers/staging/iio/dac/ad5360.c
+++ b/drivers/staging/iio/dac/ad5360.c
@@ -504,7 +504,7 @@ static int __devinit ad5360_probe(struct spi_device *spi)
 		goto error_free_reg;
 	}
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret) {
 		dev_err(&spi->dev, "Failed to register iio device: %d\n", ret);
 		goto error_disable_reg;
@@ -529,7 +529,7 @@ static int __devexit ad5360_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad5360_state *st = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 
 	kfree(indio_dev->channels);
 
diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
index e1c204d..ef3bde1 100644
--- a/drivers/staging/iio/dac/ad5446.c
+++ b/drivers/staging/iio/dac/ad5446.c
@@ -402,7 +402,7 @@ static int __devinit ad5446_probe(struct spi_device *spi)
 				 "reference voltage unspecified\n");
 	}
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_free_device;
 
@@ -425,7 +425,7 @@ static int ad5446_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad5446_state *st = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	if (!IS_ERR(st->reg)) {
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
diff --git a/drivers/staging/iio/dac/ad5504.c b/drivers/staging/iio/dac/ad5504.c
index 72040cc..412de2d 100644
--- a/drivers/staging/iio/dac/ad5504.c
+++ b/drivers/staging/iio/dac/ad5504.c
@@ -325,7 +325,7 @@ static int __devinit ad5504_probe(struct spi_device *spi)
 			goto error_disable_reg;
 	}
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_free_irq;
 
@@ -350,7 +350,7 @@ static int __devexit ad5504_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad5504_state *st = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	if (spi->irq)
 		free_irq(spi->irq, indio_dev);
 
diff --git a/drivers/staging/iio/dac/ad5624r_spi.c b/drivers/staging/iio/dac/ad5624r_spi.c
index 284d879..4552b80 100644
--- a/drivers/staging/iio/dac/ad5624r_spi.c
+++ b/drivers/staging/iio/dac/ad5624r_spi.c
@@ -265,7 +265,7 @@ static int __devinit ad5624r_probe(struct spi_device *spi)
 	if (ret)
 		goto error_disable_reg;
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_disable_reg;
 
@@ -288,7 +288,7 @@ static int __devexit ad5624r_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad5624r_state *st = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	if (!IS_ERR(st->reg)) {
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
diff --git a/drivers/staging/iio/dac/ad5686.c b/drivers/staging/iio/dac/ad5686.c
index 8563b63..cb30181 100644
--- a/drivers/staging/iio/dac/ad5686.c
+++ b/drivers/staging/iio/dac/ad5686.c
@@ -397,7 +397,7 @@ static int __devinit ad5686_probe(struct spi_device *spi)
 	if (ret)
 		goto error_disable_reg;
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_disable_reg;
 
@@ -420,7 +420,7 @@ static int __devexit ad5686_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad5686_state *st = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	if (!IS_ERR(st->reg)) {
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
diff --git a/drivers/staging/iio/dac/ad5791.c b/drivers/staging/iio/dac/ad5791.c
index db0bd12..4779678 100644
--- a/drivers/staging/iio/dac/ad5791.c
+++ b/drivers/staging/iio/dac/ad5791.c
@@ -349,7 +349,7 @@ static int __devinit ad5791_probe(struct spi_device *spi)
 		= &ad5791_channels[spi_get_device_id(spi)->driver_data];
 	indio_dev->num_channels = 1;
 	indio_dev->name = spi_get_device_id(st->spi)->name;
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_disable_reg_neg;
 
@@ -378,7 +378,7 @@ static int __devexit ad5791_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad5791_state *st = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	if (!IS_ERR(st->reg_vdd)) {
 		regulator_disable(st->reg_vdd);
 		regulator_put(st->reg_vdd);
diff --git a/drivers/staging/iio/dac/max517.c b/drivers/staging/iio/dac/max517.c
index adfbd20..ff26a86 100644
--- a/drivers/staging/iio/dac/max517.c
+++ b/drivers/staging/iio/dac/max517.c
@@ -241,7 +241,7 @@ static int max517_probe(struct i2c_client *client,
 		data->vref_mv[1] = platform_data->vref_mv[1];
 	}
 
-	err = iio_device_register(indio_dev);
+	err = iio_st_device_register(indio_dev);
 	if (err)
 		goto exit_free_device;
 
diff --git a/drivers/staging/iio/dds/ad5930.c b/drivers/staging/iio/dds/ad5930.c
index f5e368b..35cada4 100644
--- a/drivers/staging/iio/dds/ad5930.c
+++ b/drivers/staging/iio/dds/ad5930.c
@@ -111,7 +111,7 @@ static int __devinit ad5930_probe(struct spi_device *spi)
 	idev->info = &ad5930_info;
 	idev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(idev);
+	ret = iio_st_device_register(idev);
 	if (ret)
 		goto error_free_dev;
 	spi->max_speed_hz = 2000000;
@@ -129,7 +129,7 @@ error_ret:
 
 static int __devexit ad5930_remove(struct spi_device *spi)
 {
-	iio_device_unregister(spi_get_drvdata(spi));
+	iio_st_device_unregister(spi_get_drvdata(spi));
 	iio_free_device(spi_get_drvdata(spi));
 
 	return 0;
diff --git a/drivers/staging/iio/dds/ad9832.c b/drivers/staging/iio/dds/ad9832.c
index 9b4ff60..c8af201 100644
--- a/drivers/staging/iio/dds/ad9832.c
+++ b/drivers/staging/iio/dds/ad9832.c
@@ -306,7 +306,7 @@ static int __devinit ad9832_probe(struct spi_device *spi)
 	if (ret)
 		goto error_free_device;
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_free_device;
 
@@ -329,7 +329,7 @@ static int __devexit ad9832_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad9832_state *st = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	if (!IS_ERR(st->reg)) {
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
diff --git a/drivers/staging/iio/dds/ad9834.c b/drivers/staging/iio/dds/ad9834.c
index c468f69..4c1d453 100644
--- a/drivers/staging/iio/dds/ad9834.c
+++ b/drivers/staging/iio/dds/ad9834.c
@@ -396,7 +396,7 @@ static int __devinit ad9834_probe(struct spi_device *spi)
 	if (ret)
 		goto error_free_device;
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_free_device;
 
@@ -418,7 +418,7 @@ static int __devexit ad9834_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad9834_state *st = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	if (!IS_ERR(st->reg)) {
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
diff --git a/drivers/staging/iio/dds/ad9850.c b/drivers/staging/iio/dds/ad9850.c
index a14771b..834cc33 100644
--- a/drivers/staging/iio/dds/ad9850.c
+++ b/drivers/staging/iio/dds/ad9850.c
@@ -97,7 +97,7 @@ static int __devinit ad9850_probe(struct spi_device *spi)
 	idev->info = &ad9850_info;
 	idev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(idev);
+	ret = iio_st_device_register(idev);
 	if (ret)
 		goto error_free_dev;
 	spi->max_speed_hz = 2000000;
@@ -115,7 +115,7 @@ error_ret:
 
 static int __devexit ad9850_remove(struct spi_device *spi)
 {
-	iio_device_unregister(spi_get_drvdata(spi));
+	iio_st_device_unregister(spi_get_drvdata(spi));
 	iio_free_device(spi_get_drvdata(spi));
 
 	return 0;
diff --git a/drivers/staging/iio/dds/ad9852.c b/drivers/staging/iio/dds/ad9852.c
index cfceaa6..ec8cb11 100644
--- a/drivers/staging/iio/dds/ad9852.c
+++ b/drivers/staging/iio/dds/ad9852.c
@@ -246,7 +246,7 @@ static int __devinit ad9852_probe(struct spi_device *spi)
 	idev->info = &ad9852_info;
 	idev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(idev);
+	ret = iio_st_device_register(idev);
 	if (ret)
 		goto error_free_dev;
 	spi->max_speed_hz = 2000000;
@@ -266,7 +266,7 @@ error_ret:
 
 static int __devexit ad9852_remove(struct spi_device *spi)
 {
-	iio_device_unregister(spi_get_drvdata(spi));
+	iio_st_device_unregister(spi_get_drvdata(spi));
 	iio_free_device(spi_get_drvdata(spi));
 
 	return 0;
diff --git a/drivers/staging/iio/dds/ad9910.c b/drivers/staging/iio/dds/ad9910.c
index da83d2b..742bbf1 100644
--- a/drivers/staging/iio/dds/ad9910.c
+++ b/drivers/staging/iio/dds/ad9910.c
@@ -381,7 +381,7 @@ static int __devinit ad9910_probe(struct spi_device *spi)
 	idev->info = &ad9910_info;
 	idev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(idev);
+	ret = iio_st_device_register(idev);
 	if (ret)
 		goto error_free_dev;
 	spi->max_speed_hz = 2000000;
@@ -399,7 +399,7 @@ error_ret:
 
 static int __devexit ad9910_remove(struct spi_device *spi)
 {
-	iio_device_unregister(spi_get_drvdata(spi));
+	iio_st_device_unregister(spi_get_drvdata(spi));
 	iio_free_device(spi_get_drvdata(spi));
 
 	return 0;
diff --git a/drivers/staging/iio/dds/ad9951.c b/drivers/staging/iio/dds/ad9951.c
index 20c1825..df478d5 100644
--- a/drivers/staging/iio/dds/ad9951.c
+++ b/drivers/staging/iio/dds/ad9951.c
@@ -191,7 +191,7 @@ static int __devinit ad9951_probe(struct spi_device *spi)
 	idev->info = &ad9951_info;
 	idev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(idev);
+	ret = iio_st_device_register(idev);
 	if (ret)
 		goto error_free_dev;
 	spi->max_speed_hz = 2000000;
@@ -210,7 +210,7 @@ error_ret:
 
 static int __devexit ad9951_remove(struct spi_device *spi)
 {
-	iio_device_unregister(spi_get_drvdata(spi));
+	iio_st_device_unregister(spi_get_drvdata(spi));
 	iio_free_device(spi_get_drvdata(spi));
 
 	return 0;
diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
index 465f870..40e60d3 100644
--- a/drivers/staging/iio/gyro/adis16060_core.c
+++ b/drivers/staging/iio/gyro/adis16060_core.c
@@ -166,7 +166,7 @@ static int __devinit adis16060_r_probe(struct spi_device *spi)
 	indio_dev->channels = adis16060_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adis16060_channels);
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
@@ -182,7 +182,7 @@ error_ret:
 /* fixme, confirm ordering in this function */
 static int adis16060_r_remove(struct spi_device *spi)
 {
-	iio_device_unregister(spi_get_drvdata(spi));
+	iio_st_device_unregister(spi_get_drvdata(spi));
 	iio_free_device(spi_get_drvdata(spi));
 
 	return 0;
diff --git a/drivers/staging/iio/gyro/adis16080_core.c b/drivers/staging/iio/gyro/adis16080_core.c
index 5d7a906..c66e3f6 100644
--- a/drivers/staging/iio/gyro/adis16080_core.c
+++ b/drivers/staging/iio/gyro/adis16080_core.c
@@ -161,7 +161,7 @@ static int __devinit adis16080_probe(struct spi_device *spi)
 	indio_dev->info = &adis16080_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
 	return 0;
@@ -175,7 +175,7 @@ error_ret:
 /* fixme, confirm ordering in this function */
 static int adis16080_remove(struct spi_device *spi)
 {
-	iio_device_unregister(spi_get_drvdata(spi));
+	iio_st_device_unregister(spi_get_drvdata(spi));
 	iio_free_device(spi_get_drvdata(spi));
 
 	return 0;
diff --git a/drivers/staging/iio/gyro/adis16130_core.c b/drivers/staging/iio/gyro/adis16130_core.c
index 749240d..b3c2851 100644
--- a/drivers/staging/iio/gyro/adis16130_core.c
+++ b/drivers/staging/iio/gyro/adis16130_core.c
@@ -138,7 +138,7 @@ static int __devinit adis16130_probe(struct spi_device *spi)
 	indio_dev->info = &adis16130_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
@@ -154,7 +154,7 @@ error_ret:
 /* fixme, confirm ordering in this function */
 static int adis16130_remove(struct spi_device *spi)
 {
-	iio_device_unregister(spi_get_drvdata(spi));
+	iio_st_device_unregister(spi_get_drvdata(spi));
 	iio_free_device(spi_get_drvdata(spi));
 
 	return 0;
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index e86ce6a..0abf03a 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -648,7 +648,7 @@ static int __devinit adis16260_probe(struct spi_device *spi)
 	ret = adis16260_initial_setup(indio_dev);
 	if (ret)
 		goto error_remove_trigger;
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_remove_trigger;
 
@@ -671,7 +671,7 @@ static int adis16260_remove(struct spi_device *spi)
 	int ret;
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 
 	ret = adis16260_stop_device(indio_dev);
 	if (ret)
diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
index 40bfb32..7bdd339 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450_core.c
@@ -347,7 +347,7 @@ static int __devinit adxrs450_probe(struct spi_device *spi)
 	indio_dev->num_channels = ARRAY_SIZE(adxrs450_channels);
 	indio_dev->name = spi->dev.driver->name;
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
@@ -357,7 +357,7 @@ static int __devinit adxrs450_probe(struct spi_device *spi)
 		goto error_initial;
 	return 0;
 error_initial:
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 error_free_dev:
 	iio_free_device(indio_dev);
 
@@ -367,7 +367,7 @@ error_ret:
 
 static int adxrs450_remove(struct spi_device *spi)
 {
-	iio_device_unregister(spi_get_drvdata(spi));
+	iio_st_device_unregister(spi_get_drvdata(spi));
 	iio_free_device(spi_get_drvdata(spi));
 
 	return 0;
diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 66c2604..0b05286 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -316,16 +316,16 @@ struct iio_dev {
 };
 
 /**
- * iio_device_register() - register a device with the IIO subsystem
+ * iio_st_device_register() - register a device with the IIO subsystem
  * @indio_dev:		Device structure filled by the device driver
  **/
-int iio_device_register(struct iio_dev *indio_dev);
+int iio_st_device_register(struct iio_dev *indio_dev);
 
 /**
- * iio_device_unregister() - unregister a device from the IIO subsystem
+ * iio_st_device_unregister() - unregister a device from the IIO subsystem
  * @indio_dev:		Device structure representing the device.
  **/
-void iio_device_unregister(struct iio_dev *indio_dev);
+void iio_st_device_unregister(struct iio_dev *indio_dev);
 
 /**
  * iio_push_event() - try to add event to the list for userspace reading
diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
index 228f991..fe9268c 100644
--- a/drivers/staging/iio/iio_simple_dummy.c
+++ b/drivers/staging/iio/iio_simple_dummy.c
@@ -443,7 +443,7 @@ static int __devinit iio_dummy_probe(int index)
 	if (ret < 0)
 		goto error_unconfigure_buffer;
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret < 0)
 		goto error_unregister_buffer;
 
@@ -481,7 +481,7 @@ static int iio_dummy_remove(int index)
 
 
 	/* Unregister the device */
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 
 	/* Device specific code to power down etc */
 
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 56c89af..51defd9 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -741,7 +741,7 @@ static int __devinit ad5933_probe(struct i2c_client *client,
 	if (ret)
 		goto error_uninitialize_ring;
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_uninitialize_ring;
 
@@ -768,7 +768,7 @@ static __devexit int ad5933_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct ad5933_state *st = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	iio_sw_rb_free(indio_dev->buffer);
 	if (!IS_ERR(st->reg)) {
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 174454a..5e7f3c4 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -1062,7 +1062,7 @@ static int __devinit adis16400_probe(struct spi_device *spi)
 	ret = adis16400_initial_setup(indio_dev);
 	if (ret)
 		goto error_remove_trigger;
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_remove_trigger;
 
@@ -1087,7 +1087,7 @@ static int adis16400_remove(struct spi_device *spi)
 	int ret;
 	struct iio_dev *indio_dev =  spi_get_drvdata(spi);
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	ret = adis16400_stop_device(indio_dev);
 	if (ret)
 		goto err_ret;
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index cfa4fcb..08d0c20 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -1105,7 +1105,7 @@ static const struct file_operations iio_buffer_fileops = {
 	.compat_ioctl = iio_ioctl,
 };
 
-int iio_device_register(struct iio_dev *indio_dev)
+int iio_st_device_register(struct iio_dev *indio_dev)
 {
 	int ret;
 
@@ -1146,13 +1146,13 @@ error_free_sysfs:
 error_ret:
 	return ret;
 }
-EXPORT_SYMBOL(iio_device_register);
+EXPORT_SYMBOL(iio_st_device_register);
 
-void iio_device_unregister(struct iio_dev *indio_dev)
+void iio_st_device_unregister(struct iio_dev *indio_dev)
 {
 	device_unregister(&indio_dev->dev);
 }
-EXPORT_SYMBOL(iio_device_unregister);
+EXPORT_SYMBOL(iio_st_device_unregister);
 subsys_initcall(iio_init);
 module_exit(iio_exit);
 
diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index f0c733a..8f2e98c 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -561,7 +561,7 @@ static int __devinit isl29018_probe(struct i2c_client *client,
 	indio_dev->name = id->name;
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	err = iio_device_register(indio_dev);
+	err = iio_st_device_register(indio_dev);
 	if (err) {
 		dev_err(&client->dev, "iio registration fails\n");
 		goto exit_iio_free;
@@ -579,7 +579,7 @@ static int __devexit isl29018_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
 	dev_dbg(&client->dev, "%s()\n", __func__);
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	iio_free_device(indio_dev);
 
 	return 0;
diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index 9199ea6..5c00ebd 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -773,7 +773,7 @@ static int __devinit tsl2563_probe(struct i2c_client *client,
 	/* The interrupt cannot yet be enabled so this is fine without lock */
 	schedule_delayed_work(&chip->poweroff_work, 5 * HZ);
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto fail3;
 
@@ -793,7 +793,7 @@ static int tsl2563_remove(struct i2c_client *client)
 	struct tsl2563_chip *chip = i2c_get_clientdata(client);
 	struct iio_dev *indio_dev = iio_priv_to_dev(chip);
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	if (!chip->int_enabled)
 		cancel_delayed_work(&chip->poweroff_work);
 	/* Ensure that interrupts are disabled - then flush any bottom halves */
diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 80f77cf..e4d75e3 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -853,7 +853,7 @@ static int __devinit taos_probe(struct i2c_client *clientp,
 	indio_dev->dev.parent = &clientp->dev;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->name = chip->client->name;
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret) {
 		dev_err(&clientp->dev, "iio registration failed\n");
 		goto fail2;
@@ -908,7 +908,7 @@ static int taos_resume(struct i2c_client *client)
 
 static int __devexit taos_remove(struct i2c_client *client)
 {
-	iio_device_unregister(i2c_get_clientdata(client));
+	iio_st_device_unregister(i2c_get_clientdata(client));
 	iio_free_device(i2c_get_clientdata(client));
 
 	return 0;
diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
index a2c4d00..877e15f 100644
--- a/drivers/staging/iio/magnetometer/ak8975.c
+++ b/drivers/staging/iio/magnetometer/ak8975.c
@@ -527,7 +527,7 @@ static int ak8975_probe(struct i2c_client *client,
 	indio_dev->info = &ak8975_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	err = iio_device_register(indio_dev);
+	err = iio_st_device_register(indio_dev);
 	if (err < 0)
 		goto exit_free_iio;
 
@@ -547,7 +547,7 @@ static int ak8975_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct ak8975_data *data = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 
 	if (gpio_is_valid(data->eoc_gpio))
 		gpio_free(data->eoc_gpio);
diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index f90d4d1..d2ba61f 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -566,7 +566,7 @@ static int hmc5843_probe(struct i2c_client *client,
 	indio_dev->num_channels = ARRAY_SIZE(hmc5843_channels);
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	err = iio_device_register(indio_dev);
+	err = iio_st_device_register(indio_dev);
 	if (err)
 		goto exit_free2;
 	return 0;
@@ -580,7 +580,7 @@ static int hmc5843_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	 /*  sleep mode to save power */
 	hmc5843_configure(client, MODE_SLEEP);
 	iio_free_device(indio_dev);
diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
index 940fef6..dc3cdd2 100644
--- a/drivers/staging/iio/meter/ade7753.c
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -539,7 +539,7 @@ static int __devinit ade7753_probe(struct spi_device *spi)
 	if (ret)
 		goto error_free_dev;
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
@@ -558,7 +558,7 @@ static int ade7753_remove(struct spi_device *spi)
 	int ret;
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 
 	ret = ade7753_stop_device(&(indio_dev->dev));
 	if (ret)
diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
index 33f0d32..d9ca2df 100644
--- a/drivers/staging/iio/meter/ade7754.c
+++ b/drivers/staging/iio/meter/ade7754.c
@@ -561,7 +561,7 @@ static int __devinit ade7754_probe(struct spi_device *spi)
 	ret = ade7754_initial_setup(indio_dev);
 	if (ret)
 		goto error_free_dev;
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
@@ -580,7 +580,7 @@ static int ade7754_remove(struct spi_device *spi)
 	int ret;
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	ret = ade7754_stop_device(&(indio_dev->dev));
 	if (ret)
 		goto err_ret;
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 839b48b..c5be6c4 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -793,7 +793,7 @@ static int __devinit ade7758_probe(struct spi_device *spi)
 			goto error_uninitialize_ring;
 	}
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_remove_trigger;
 
@@ -822,7 +822,7 @@ static int ade7758_remove(struct spi_device *spi)
 	struct ade7758_state *st = iio_priv(indio_dev);
 	int ret;
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	ret = ade7758_stop_device(&indio_dev->dev);
 	if (ret)
 		goto err_ret;
diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index b691f10..7ee34da 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -484,7 +484,7 @@ static int __devinit ade7759_probe(struct spi_device *spi)
 	if (ret)
 		goto error_free_dev;
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
@@ -502,7 +502,7 @@ static int ade7759_remove(struct spi_device *spi)
 	int ret;
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	ret = ade7759_stop_device(&(indio_dev->dev));
 	if (ret)
 		goto err_ret;
diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
index 49c01c5..9c8dde0 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -567,7 +567,7 @@ int ade7854_probe(struct iio_dev *indio_dev, struct device *dev)
 	indio_dev->info = &ade7854_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
@@ -579,7 +579,7 @@ int ade7854_probe(struct iio_dev *indio_dev, struct device *dev)
 	return 0;
 
 error_unreg_dev:
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 error_free_dev:
 	iio_free_device(indio_dev);
 
@@ -589,7 +589,7 @@ EXPORT_SYMBOL(ade7854_probe);
 
 int ade7854_remove(struct iio_dev *indio_dev)
 {
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	iio_free_device(indio_dev);
 
 	return 0;
diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
index d7ad46a..c8c5de8 100644
--- a/drivers/staging/iio/resolver/ad2s1200.c
+++ b/drivers/staging/iio/resolver/ad2s1200.c
@@ -129,7 +129,7 @@ static int __devinit ad2s1200_probe(struct spi_device *spi)
 	indio_dev->num_channels = ARRAY_SIZE(ad2s1200_channels);
 	indio_dev->name = spi_get_device_id(spi)->name;
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
@@ -149,7 +149,7 @@ error_ret:
 
 static int __devexit ad2s1200_remove(struct spi_device *spi)
 {
-	iio_device_unregister(spi_get_drvdata(spi));
+	iio_st_device_unregister(spi_get_drvdata(spi));
 	iio_free_device(spi_get_drvdata(spi));
 
 	return 0;
diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 6401a62..7183ae7 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -715,7 +715,7 @@ static int __devinit ad2s1210_probe(struct spi_device *spi)
 	indio_dev->num_channels = ARRAY_SIZE(ad2s1210_channels);
 	indio_dev->name = spi_get_device_id(spi)->name;
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_free_gpios;
 
@@ -738,7 +738,7 @@ static int __devexit ad2s1210_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
-	iio_device_unregister(indio_dev);
+	iio_st_device_unregister(indio_dev);
 	ad2s1210_free_gpios(iio_priv(indio_dev));
 	iio_free_device(indio_dev);
 
diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index a9200d9..e2a35bf 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -80,7 +80,7 @@ static int __devinit ad2s90_probe(struct spi_device *spi)
 	indio_dev->num_channels = 1;
 	indio_dev->name = spi_get_device_id(spi)->name;
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_st_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
@@ -99,7 +99,7 @@ error_ret:
 
 static int __devexit ad2s90_remove(struct spi_device *spi)
 {
-	iio_device_unregister(spi_get_drvdata(spi));
+	iio_st_device_unregister(spi_get_drvdata(spi));
 	iio_free_device(spi_get_drvdata(spi));
 
 	return 0;
-- 
1.7.7.2
