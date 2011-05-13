Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/5] staging:iio: implement an iio_info structure to take some of the constant elements out of iio_dev.
Date: Fri, 13 May 2011 17:08:59 +0100
Message-Id: <1305302943-16475-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305302943-16475-1-git-send-email-jic23@cam.ac.uk>
References: <1305302943-16475-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This was suggested by Arnd Bergmann,  Other elements may well
move in here in future, but it definitely makes sense for these.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16201_core.c |   13 +-
 drivers/staging/iio/accel/adis16203_core.c |   12 +-
 drivers/staging/iio/accel/adis16204_core.c |   12 +-
 drivers/staging/iio/accel/adis16209_core.c |   12 +-
 drivers/staging/iio/accel/adis16220_core.c |    7 +-
 drivers/staging/iio/accel/adis16240_core.c |   12 +-
 drivers/staging/iio/accel/kxsd9.c          |   12 +-
 drivers/staging/iio/accel/lis3l02dq_core.c |   23 +-
 drivers/staging/iio/accel/sca3000_core.c   |   33 +-
 drivers/staging/iio/adc/ad7150.c           |   15 +-
 drivers/staging/iio/adc/ad7152.c           |    7 +-
 drivers/staging/iio/adc/ad7291.c           |   11 +-
 drivers/staging/iio/adc/ad7298_core.c      |    8 +-
 drivers/staging/iio/adc/ad7314.c           |    7 +-
 drivers/staging/iio/adc/ad7476_core.c      |    8 +-
 drivers/staging/iio/adc/ad7606_core.c      |   10 +-
 drivers/staging/iio/adc/ad7745.c           |   11 +-
 drivers/staging/iio/adc/ad7780.c           |    8 +-
 drivers/staging/iio/adc/ad7816.c           |   12 +-
 drivers/staging/iio/adc/ad7887_core.c      |    8 +-
 drivers/staging/iio/adc/ad799x.h           |    3 +-
 drivers/staging/iio/adc/ad799x_core.c      |   47 ++-
 drivers/staging/iio/adc/adt7310.c          |   12 +-
 drivers/staging/iio/adc/adt7410.c          |   12 +-
 drivers/staging/iio/adc/adt75.c            |   12 +-
 drivers/staging/iio/adc/max1363.h          |   14 +-
 drivers/staging/iio/adc/max1363_core.c     |  782 +++++++++++++++-------------
 drivers/staging/iio/addac/adt7316.c        |   27 +-
 drivers/staging/iio/dac/ad5446.c           |    8 +-
 drivers/staging/iio/dac/ad5504.c           |   24 +-
 drivers/staging/iio/dac/ad5624r_spi.c      |    8 +-
 drivers/staging/iio/dac/ad5791.c           |    8 +-
 drivers/staging/iio/dac/max517.c           |   15 +-
 drivers/staging/iio/dds/ad5930.c           |   12 +-
 drivers/staging/iio/dds/ad9832.c           |    8 +-
 drivers/staging/iio/dds/ad9834.c           |    8 +-
 drivers/staging/iio/dds/ad9850.c           |   10 +-
 drivers/staging/iio/dds/ad9852.c           |   10 +-
 drivers/staging/iio/dds/ad9910.c           |   10 +-
 drivers/staging/iio/dds/ad9951.c           |   10 +-
 drivers/staging/iio/gyro/adis16060_core.c  |    8 +-
 drivers/staging/iio/gyro/adis16080_core.c  |    8 +-
 drivers/staging/iio/gyro/adis16130_core.c  |    8 +-
 drivers/staging/iio/gyro/adis16260_core.c  |   12 +-
 drivers/staging/iio/gyro/adxrs450_core.c   |    8 +-
 drivers/staging/iio/iio.h                  |  105 ++--
 drivers/staging/iio/imu/adis16400_core.c   |   12 +-
 drivers/staging/iio/industrialio-core.c    |   73 ++--
 drivers/staging/iio/light/isl29018.c       |    8 +-
 drivers/staging/iio/light/tsl2563.c        |   26 +-
 drivers/staging/iio/light/tsl2583.c        |    8 +-
 drivers/staging/iio/magnetometer/ak8975.c  |    8 +-
 drivers/staging/iio/magnetometer/hmc5843.c |    8 +-
 drivers/staging/iio/meter/ade7753.c        |    8 +-
 drivers/staging/iio/meter/ade7754.c        |    8 +-
 drivers/staging/iio/meter/ade7758_core.c   |    8 +-
 drivers/staging/iio/meter/ade7759.c        |    9 +-
 drivers/staging/iio/meter/ade7854.c        |    8 +-
 drivers/staging/iio/resolver/ad2s120x.c    |   11 +-
 drivers/staging/iio/resolver/ad2s1210.c    |   10 +-
 drivers/staging/iio/resolver/ad2s90.c      |   10 +-
 61 files changed, 970 insertions(+), 675 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
index 59b6ac2..e4c49f0 100644
--- a/drivers/staging/iio/accel/adis16201_core.c
+++ b/drivers/staging/iio/accel/adis16201_core.c
@@ -457,6 +457,13 @@ static const struct attribute_group adis16201_attribute_group = {
 	.attrs = adis16201_attributes,
 };
 
+static const struct iio_info adis16201_info = {
+	.attrs = &adis16201_attribute_group,
+	.read_raw = &adis16201_read_raw,
+	.write_raw = &adis16201_write_raw,
+	.driver_module = THIS_MODULE,
+};
+
 static int __devinit adis16201_probe(struct spi_device *spi)
 {
 	int ret, regdone = 0;
@@ -490,13 +497,11 @@ static int __devinit adis16201_probe(struct spi_device *spi)
 
 	st->indio_dev->name = spi->dev.driver->name;
 	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->attrs = &adis16201_attribute_group;
+	st->indio_dev->info = &adis16201_info;
+
 	st->indio_dev->channels = adis16201_channels;
 	st->indio_dev->num_channels = ARRAY_SIZE(adis16201_channels);
-	st->indio_dev->read_raw = &adis16201_read_raw;
-	st->indio_dev->write_raw = &adis16201_write_raw;
 	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = adis16201_configure_ring(st->indio_dev);
diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index 1694a0c..36be4d5 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -408,6 +408,13 @@ static const struct attribute_group adis16203_attribute_group = {
 	.attrs = adis16203_attributes,
 };
 
+static const struct iio_info adis16203_info = {
+	.attrs = &adis16203_attribute_group,
+	.read_raw = &adis16203_read_raw,
+	.write_raw = &adis16203_write_raw,
+	.driver_module = THIS_MODULE,
+};
+
 static int __devinit adis16203_probe(struct spi_device *spi)
 {
 	int ret, regdone = 0;
@@ -440,13 +447,10 @@ static int __devinit adis16203_probe(struct spi_device *spi)
 	}
 	st->indio_dev->name = spi->dev.driver->name;
 	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->attrs = &adis16203_attribute_group;
 	st->indio_dev->channels = adis16203_channels;
 	st->indio_dev->num_channels = ARRAY_SIZE(adis16203_channels);
-	st->indio_dev->read_raw = &adis16203_read_raw;
-	st->indio_dev->write_raw = &adis16203_write_raw;
+	st->indio_dev->info = &adis16203_info;
 	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = adis16203_configure_ring(st->indio_dev);
diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index 4e4944c..1680670 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -473,6 +473,13 @@ static const struct attribute_group adis16204_attribute_group = {
 	.attrs = adis16204_attributes,
 };
 
+static const struct iio_info adis16204_info = {
+	.attrs = &adis16204_attribute_group,
+	.read_raw = &adis16204_read_raw,
+	.write_raw = &adis16204_write_raw,
+	.driver_module = THIS_MODULE,
+};
+
 static int __devinit adis16204_probe(struct spi_device *spi)
 {
 	int ret, regdone = 0;
@@ -506,13 +513,10 @@ static int __devinit adis16204_probe(struct spi_device *spi)
 
 	st->indio_dev->name = spi->dev.driver->name;
 	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->attrs = &adis16204_attribute_group;
+	st->indio_dev->info = &adis16204_info;
 	st->indio_dev->channels = adis16204_channels;
 	st->indio_dev->num_channels = ARRAY_SIZE(adis16204_channels);
-	st->indio_dev->read_raw = &adis16204_read_raw;
-	st->indio_dev->write_raw = &adis16204_write_raw;
 	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = adis16204_configure_ring(st->indio_dev);
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index d48babe..c423cc9 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -456,6 +456,13 @@ static const struct attribute_group adis16209_attribute_group = {
 	.attrs = adis16209_attributes,
 };
 
+static const struct iio_info adis16209_info = {
+	.attrs = &adis16209_attribute_group,
+	.read_raw = &adis16209_read_raw,
+	.write_raw = &adis16209_write_raw,
+	.driver_module = THIS_MODULE,
+};
+
 static int __devinit adis16209_probe(struct spi_device *spi)
 {
 	int ret, regdone = 0;
@@ -489,13 +496,10 @@ static int __devinit adis16209_probe(struct spi_device *spi)
 
 	st->indio_dev->name = spi->dev.driver->name;
 	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->attrs = &adis16209_attribute_group;
+	st->indio_dev->info = &adis16209_info;
 	st->indio_dev->channels = adis16209_channels;
 	st->indio_dev->num_channels = ARRAY_SIZE(adis16209_channels);
-	st->indio_dev->read_raw = &adis16209_read_raw;
-	st->indio_dev->write_raw = &adis16209_write_raw;
 	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = adis16209_configure_ring(st->indio_dev);
diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
index 7af48b8..605a75e 100644
--- a/drivers/staging/iio/accel/adis16220_core.c
+++ b/drivers/staging/iio/accel/adis16220_core.c
@@ -544,6 +544,10 @@ static const struct attribute_group adis16220_attribute_group = {
 	.attrs = adis16220_attributes,
 };
 
+static const struct iio_info adis16220_info = {
+	.attrs = &adis16220_attribute_group,
+	.driver_module = THIS_MODULE,
+};
 static int __devinit adis16220_probe(struct spi_device *spi)
 {
 	int ret, regdone = 0;
@@ -577,9 +581,8 @@ static int __devinit adis16220_probe(struct spi_device *spi)
 
 	st->indio_dev->name = spi->dev.driver->name;
 	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->attrs = &adis16220_attribute_group;
+	st->indio_dev->info = &adis16220_info;
 	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(st->indio_dev);
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index 537e0f2..ac60385 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -507,6 +507,13 @@ static const struct attribute_group adis16240_attribute_group = {
 	.attrs = adis16240_attributes,
 };
 
+static const struct iio_info adis16240_info = {
+	.attrs = &adis16240_attribute_group,
+	.read_raw = &adis16240_read_raw,
+	.write_raw = &adis16240_write_raw,
+	.driver_module = THIS_MODULE,
+};
+
 static int __devinit adis16240_probe(struct spi_device *spi)
 {
 	int ret, regdone = 0;
@@ -540,13 +547,10 @@ static int __devinit adis16240_probe(struct spi_device *spi)
 
 	st->indio_dev->name = spi->dev.driver->name;
 	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->attrs = &adis16240_attribute_group;
+	st->indio_dev->info = &adis16240_info;
 	st->indio_dev->channels = adis16240_channels;
 	st->indio_dev->num_channels = ARRAY_SIZE(adis16240_channels);
-	st->indio_dev->read_raw = &adis16240_read_raw;
-	st->indio_dev->write_raw = &adis16240_write_raw;
 	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = adis16240_configure_ring(st->indio_dev);
diff --git a/drivers/staging/iio/accel/kxsd9.c b/drivers/staging/iio/accel/kxsd9.c
index 431aa0f..973156e 100644
--- a/drivers/staging/iio/accel/kxsd9.c
+++ b/drivers/staging/iio/accel/kxsd9.c
@@ -301,6 +301,11 @@ error_ret:
 
 };
 
+static const struct iio_info kxsd9_info = {
+	.attrs = &kxsd9_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
 static int __devinit kxsd9_probe(struct spi_device *spi)
 {
 
@@ -335,13 +340,8 @@ static int __devinit kxsd9_probe(struct spi_device *spi)
 		goto error_free_tx;
 	}
 	st->indio_dev->dev.parent = &spi->dev;
-	/* for now */
-	st->indio_dev->num_interrupt_lines = 0;
-	st->indio_dev->event_attrs = NULL;
-
-	st->indio_dev->attrs = &kxsd9_attribute_group;
+	st->indio_dev->info = &kxsd9_info;
 	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(st->indio_dev);
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index 942139a..ba5bc67 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -651,6 +651,18 @@ static const struct attribute_group lis3l02dq_attribute_group = {
 	.attrs = lis3l02dq_attributes,
 };
 
+static const struct iio_info lis3l02dq_info = {
+	.num_interrupt_lines = 1,
+	.read_raw = &lis3l02dq_read_raw,
+	.write_raw = &lis3l02dq_write_raw,
+	.read_event_value = &lis3l02dq_read_thresh,
+	.write_event_value = &lis3l02dq_write_thresh,
+	.write_event_config = &lis3l02dq_write_event_config,
+	.read_event_config = &lis3l02dq_read_event_config,
+	.driver_module = THIS_MODULE,
+	.attrs = &lis3l02dq_attribute_group,
+};
+
 static int __devinit lis3l02dq_probe(struct spi_device *spi)
 {
 	int ret, regdone = 0;
@@ -670,17 +682,10 @@ static int __devinit lis3l02dq_probe(struct spi_device *spi)
 	mutex_init(&st->buf_lock);
 	indio_dev->name = spi->dev.driver->name;
 	indio_dev->dev.parent = &spi->dev;
-	indio_dev->num_interrupt_lines = 1;
+	indio_dev->info = &lis3l02dq_info;
 	indio_dev->channels = lis3l02dq_channels;
 	indio_dev->num_channels = ARRAY_SIZE(lis3l02dq_channels);
-	indio_dev->read_raw = &lis3l02dq_read_raw;
-	indio_dev->write_raw = &lis3l02dq_write_raw;
-	indio_dev->read_event_value = &lis3l02dq_read_thresh;
-	indio_dev->write_event_value = &lis3l02dq_write_thresh;
-	indio_dev->write_event_config = &lis3l02dq_write_event_config;
-	indio_dev->read_event_config = &lis3l02dq_read_event_config;
-	indio_dev->attrs = &lis3l02dq_attribute_group;
-	indio_dev->driver_module = THIS_MODULE;
+
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = lis3l02dq_configure_ring(indio_dev);
diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 5de07fd..f213b86 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -1100,6 +1100,28 @@ error_ret:
 	return ret;
 }
 
+static const struct iio_info sca3000_info = {
+	.attrs = &sca3000_attribute_group,
+	.read_raw = &sca3000_read_raw,
+	.num_interrupt_lines = 1,
+	.event_attrs = &sca3000_event_attribute_group,
+	.read_event_value = &sca3000_read_thresh,
+	.write_event_value = &sca3000_write_thresh,
+	.read_event_config = &sca3000_read_event_config,
+	.write_event_config = &sca3000_write_event_config,
+	.driver_module = THIS_MODULE,
+};
+
+static const struct iio_info sca3000_info_with_temp = {
+	.attrs = &sca3000_attribute_group_with_temp,
+	.read_raw = &sca3000_read_raw,
+	.read_event_value = &sca3000_read_thresh,
+	.write_event_value = &sca3000_write_thresh,
+	.read_event_config = &sca3000_read_event_config,
+	.write_event_config = &sca3000_write_event_config,
+	.driver_module = THIS_MODULE,
+};
+
 static int __devinit sca3000_probe(struct spi_device *spi)
 {
 	int ret, regdone = 0;
@@ -1124,20 +1146,13 @@ static int __devinit sca3000_probe(struct spi_device *spi)
 	}
 	st->indio_dev->dev.parent = &spi->dev;
 	st->indio_dev->name = spi_get_device_id(spi)->name;
-	st->indio_dev->num_interrupt_lines = 1;
-	st->indio_dev->event_attrs = &sca3000_event_attribute_group;
 	if (st->info->temp_output)
-		st->indio_dev->attrs = &sca3000_attribute_group_with_temp;
+		st->indio_dev->info = &sca3000_info_with_temp;
 	else {
-		st->indio_dev->attrs = &sca3000_attribute_group;
+		st->indio_dev->info = &sca3000_info;
 		st->indio_dev->channels = sca3000_channels;
 		st->indio_dev->num_channels = ARRAY_SIZE(sca3000_channels);
 	}
-	st->indio_dev->read_raw = &sca3000_read_raw;
-	st->indio_dev->read_event_value = &sca3000_read_thresh;
-	st->indio_dev->write_event_value = &sca3000_write_thresh;
-	st->indio_dev->read_event_config = &sca3000_read_event_config;
-	st->indio_dev->write_event_config = &sca3000_write_event_config;
 	st->indio_dev->dev_data = (void *)(st);
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
 
diff --git a/drivers/staging/iio/adc/ad7150.c b/drivers/staging/iio/adc/ad7150.c
index e23bb99..ca32b67 100644
--- a/drivers/staging/iio/adc/ad7150.c
+++ b/drivers/staging/iio/adc/ad7150.c
@@ -700,6 +700,12 @@ static struct attribute_group ad7150_event_attribute_group = {
 	.attrs = ad7150_event_attributes,
 };
 
+static const struct iio_info ad7150_info = {
+	.attrs = &ad7150_attribute_group,
+	.num_interrupt_lines = 1,
+	.event_attrs = &ad7150_event_attribute_group,
+	.driver_module = THIS_MODULE,
+};
 /*
  * device probe and remove
  */
@@ -725,14 +731,13 @@ static int __devinit ad7150_probe(struct i2c_client *client,
 		goto error_free_chip;
 	}
 
-	/* Echipabilish that the iio_dev is a child of the i2c device */
+	/* Establish that the iio_dev is a child of the i2c device */
 	chip->indio_dev->name = id->name;
 	chip->indio_dev->dev.parent = &client->dev;
-	chip->indio_dev->attrs = &ad7150_attribute_group;
-	chip->indio_dev->event_attrs = &ad7150_event_attribute_group;
+
+	chip->indio_dev->info = &ad7150_info;
 	chip->indio_dev->dev_data = (void *)(chip);
-	chip->indio_dev->driver_module = THIS_MODULE;
-	chip->indio_dev->num_interrupt_lines = 1;
+
 	chip->indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(chip->indio_dev);
diff --git a/drivers/staging/iio/adc/ad7152.c b/drivers/staging/iio/adc/ad7152.c
index e53e3e9..7a38bcb 100644
--- a/drivers/staging/iio/adc/ad7152.c
+++ b/drivers/staging/iio/adc/ad7152.c
@@ -497,6 +497,10 @@ static const struct attribute_group ad7152_attribute_group = {
 	.attrs = ad7152_attributes,
 };
 
+static const struct iio_info ad7152_info = {
+	.attrs = &ad7152_attribute_group,
+	.driver_module = THIS_MODULE,
+};
 /*
  * device probe and remove
  */
@@ -525,9 +529,8 @@ static int __devinit ad7152_probe(struct i2c_client *client,
 	/* Echipabilish that the iio_dev is a child of the i2c device */
 	chip->indio_dev->name = id->name;
 	chip->indio_dev->dev.parent = &client->dev;
-	chip->indio_dev->attrs = &ad7152_attribute_group;
+	chip->indio_dev->info = &ad7152_info;
 	chip->indio_dev->dev_data = (void *)(chip);
-	chip->indio_dev->driver_module = THIS_MODULE;
 	chip->indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(chip->indio_dev);
diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index 0e4c728..1be3453 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -778,6 +778,12 @@ static struct attribute_group ad7291_event_attribute_group = {
 	.attrs = ad7291_event_attributes,
 };
 
+static const struct iio_info ad7291_info = {
+	.attrs = &ad7291_attribute_group,
+	.num_interrupt_lines = 1,
+	.event_attrs = &ad7291_event_attribute_group,
+};
+
 /*
  * device probe and remove
  */
@@ -807,11 +813,8 @@ static int __devinit ad7291_probe(struct i2c_client *client,
 
 	chip->indio_dev->name = id->name;
 	chip->indio_dev->dev.parent = &client->dev;
-	chip->indio_dev->attrs = &ad7291_attribute_group;
-	chip->indio_dev->event_attrs = &ad7291_event_attribute_group;
+	chip->indio_dev->info = &ad7291_info;
 	chip->indio_dev->dev_data = (void *)chip;
-	chip->indio_dev->driver_module = THIS_MODULE;
-	chip->indio_dev->num_interrupt_lines = 1;
 	chip->indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(chip->indio_dev);
diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/adc/ad7298_core.c
index 83b3d15..b8e4ae2 100644
--- a/drivers/staging/iio/adc/ad7298_core.c
+++ b/drivers/staging/iio/adc/ad7298_core.c
@@ -156,6 +156,11 @@ static int ad7298_read_raw(struct iio_dev *dev_info,
 	return -EINVAL;
 }
 
+static const struct iio_info ad7298_info = {
+	.read_raw = &ad7298_read_raw,
+	.driver_module = THIS_MODULE,
+};
+
 static int __devinit ad7298_probe(struct spi_device *spi)
 {
 	struct ad7298_platform_data *pdata = spi->dev.platform_data;
@@ -181,11 +186,10 @@ static int __devinit ad7298_probe(struct spi_device *spi)
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->dev.parent = &spi->dev;
-	indio_dev->driver_module = THIS_MODULE;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ad7298_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad7298_channels);
-	indio_dev->read_raw = &ad7298_read_raw;
+	indio_dev->info = &ad7298_info;
 
 	/* Setup default message */
 
diff --git a/drivers/staging/iio/adc/ad7314.c b/drivers/staging/iio/adc/ad7314.c
index a1f1b43..98bb16f 100644
--- a/drivers/staging/iio/adc/ad7314.c
+++ b/drivers/staging/iio/adc/ad7314.c
@@ -191,6 +191,10 @@ static const struct attribute_group ad7314_attribute_group = {
 	.attrs = ad7314_attributes,
 };
 
+static const struct iio_info ad7314_info = {
+	.attrs = &ad7314_attribute_group,
+	.driver_module = THIS_MODULE,
+};
 /*
  * device probe and remove
  */
@@ -218,9 +222,8 @@ static int __devinit ad7314_probe(struct spi_device *spi_dev)
 
 	chip->indio_dev->name = spi_get_device_id(spi_dev)->name;
 	chip->indio_dev->dev.parent = &spi_dev->dev;
-	chip->indio_dev->attrs = &ad7314_attribute_group;
+	chip->indio_dev->info = &ad7314_info;
 	chip->indio_dev->dev_data = (void *)chip;
-	chip->indio_dev->driver_module = THIS_MODULE;
 
 	ret = iio_device_register(chip->indio_dev);
 	if (ret)
diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
index 5b41e01..50cedb4 100644
--- a/drivers/staging/iio/adc/ad7476_core.c
+++ b/drivers/staging/iio/adc/ad7476_core.c
@@ -118,6 +118,11 @@ static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
 	},
 };
 
+static const struct iio_info ad7476_info = {
+	.driver_module = THIS_MODULE,
+	.read_raw = &ad7476_read_raw,
+};
+
 static int __devinit ad7476_probe(struct spi_device *spi)
 {
 	struct ad7476_platform_data *pdata = spi->dev.platform_data;
@@ -165,11 +170,10 @@ static int __devinit ad7476_probe(struct spi_device *spi)
 	st->indio_dev->dev.parent = &spi->dev;
 	st->indio_dev->name = spi_get_device_id(spi)->name;
 	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
 	st->indio_dev->channels = st->chip_info->channel;
 	st->indio_dev->num_channels = 2;
-	st->indio_dev->read_raw = &ad7476_read_raw;
+	st->indio_dev->info = &ad7476_info;
 	/* Setup default message */
 
 	st->xfer.rx_buf = &st->data;
diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index fb96802..459371a 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -426,6 +426,12 @@ static irqreturn_t ad7606_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 };
 
+static const struct iio_info ad7606_info = {
+	.driver_module = THIS_MODULE,
+	.read_raw = &ad7606_read_raw,
+	.attrs = &ad7606_attribute_group,
+};
+
 struct iio_dev *ad7606_probe(struct device *dev, int irq,
 			      void __iomem *base_address,
 			      unsigned id,
@@ -470,13 +476,11 @@ struct iio_dev *ad7606_probe(struct device *dev, int irq,
 	st->chip_info = &ad7606_chip_info_tbl[id];
 
 	indio_dev->dev.parent = dev;
-	indio_dev->attrs = &ad7606_attribute_group;
-	indio_dev->driver_module = THIS_MODULE;
+	indio_dev->info = &ad7606_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->name = st->chip_info->name;
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
-	indio_dev->read_raw = &ad7606_read_raw;
 
 	init_waitqueue_head(&st->wq_data_avail);
 
diff --git a/drivers/staging/iio/adc/ad7745.c b/drivers/staging/iio/adc/ad7745.c
index 98b510d..1944223 100644
--- a/drivers/staging/iio/adc/ad7745.c
+++ b/drivers/staging/iio/adc/ad7745.c
@@ -565,6 +565,12 @@ static struct attribute_group ad774x_event_attribute_group = {
 	.attrs = ad774x_event_attributes,
 };
 
+static const struct iio_info ad774x_info = {
+	.attrs = &ad774x_event_attribute_group,
+	.event_attrs = &ad774x_event_attribute_group,
+	.num_interrupt_lines = 1,
+	.driver_module = THIS_MODULE,
+};
 /*
  * device probe and remove
  */
@@ -593,11 +599,8 @@ static int __devinit ad774x_probe(struct i2c_client *client,
 	/* Establish that the iio_dev is a child of the i2c device */
 	chip->indio_dev->name = id->name;
 	chip->indio_dev->dev.parent = &client->dev;
-	chip->indio_dev->attrs = &ad774x_attribute_group;
-	chip->indio_dev->event_attrs = &ad774x_event_attribute_group;
+	chip->indio_dev->info = &ad774x_info;
 	chip->indio_dev->dev_data = (void *)(chip);
-	chip->indio_dev->driver_module = THIS_MODULE;
-	chip->indio_dev->num_interrupt_lines = 1;
 	chip->indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(chip->indio_dev);
diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 713e202..e0c7b6c 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -151,6 +151,11 @@ static irqreturn_t ad7780_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 };
 
+static const struct iio_info ad7780_info = {
+	.read_raw = &ad7780_read_raw,
+	.driver_module = THIS_MODULE,
+};
+
 static int __devinit ad7780_probe(struct spi_device *spi)
 {
 	struct ad7780_platform_data *pdata = spi->dev.platform_data;
@@ -195,11 +200,10 @@ static int __devinit ad7780_probe(struct spi_device *spi)
 
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->name = spi_get_device_id(spi)->name;
-	indio_dev->driver_module = THIS_MODULE;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = &st->chip_info->channel;
 	indio_dev->num_channels = 1;
-	indio_dev->read_raw = &ad7780_read_raw;
+	indio_dev->info = &ad7780_info;
 
 	init_waitqueue_head(&st->wq_data_avail);
 
diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 873fe2b..11379e4 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -331,6 +331,13 @@ static struct attribute_group ad7816_event_attribute_group = {
 	.attrs = ad7816_event_attributes,
 };
 
+static const struct iio_info ad7816_info = {
+	.attrs = &ad7816_attribute_group,
+	.num_interrupt_lines = 1,
+	.event_attrs = &ad7816_event_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
 /*
  * device probe and remove
  */
@@ -391,11 +398,8 @@ static int __devinit ad7816_probe(struct spi_device *spi_dev)
 	}
 	chip->indio_dev->name = spi_get_device_id(spi_dev)->name;
 	chip->indio_dev->dev.parent = &spi_dev->dev;
-	chip->indio_dev->attrs = &ad7816_attribute_group;
-	chip->indio_dev->event_attrs = &ad7816_event_attribute_group;
+	chip->indio_dev->info = &ad7816_info;
 	chip->indio_dev->dev_data = (void *)chip;
-	chip->indio_dev->driver_module = THIS_MODULE;
-	chip->indio_dev->num_interrupt_lines = 1;
 	chip->indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(chip->indio_dev);
diff --git a/drivers/staging/iio/adc/ad7887_core.c b/drivers/staging/iio/adc/ad7887_core.c
index 6773fe1..de14b17 100644
--- a/drivers/staging/iio/adc/ad7887_core.c
+++ b/drivers/staging/iio/adc/ad7887_core.c
@@ -83,6 +83,11 @@ static const struct ad7887_chip_info ad7887_chip_info_tbl[] = {
 	},
 };
 
+static const struct iio_info ad7887_info = {
+	.read_raw = &ad7887_read_raw,
+	.driver_module = THIS_MODULE,
+};
+
 static int __devinit ad7887_probe(struct spi_device *spi)
 {
 	struct ad7887_platform_data *pdata = spi->dev.platform_data;
@@ -114,8 +119,7 @@ static int __devinit ad7887_probe(struct spi_device *spi)
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->dev_data = (void *)(st);
-	indio_dev->read_raw = &ad7887_read_raw;
-	indio_dev->driver_module = THIS_MODULE;
+	indio_dev->info = &ad7887_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* Setup default message */
diff --git a/drivers/staging/iio/adc/ad799x.h b/drivers/staging/iio/adc/ad799x.h
index 0a8d6e2..0dc9b4c 100644
--- a/drivers/staging/iio/adc/ad799x.h
+++ b/drivers/staging/iio/adc/ad799x.h
@@ -97,9 +97,8 @@ struct ad799x_chip_info {
 	struct iio_chan_spec		channel[9];
 	int				num_channels;
 	u16				int_vref_mv;
-	bool				monitor_mode;
 	u16				default_config;
-	struct attribute_group		*event_attrs;
+	const struct iio_info		*info;
 };
 
 struct ad799x_state {
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index a105910..29bfbcf 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -459,6 +459,25 @@ static struct attribute_group ad7992_event_attrs_group = {
 	.attrs = ad7992_event_attributes,
 };
 
+static const struct iio_info ad7991_info = {
+	.read_raw = &ad799x_read_raw,
+	.driver_module = THIS_MODULE,
+};
+
+static const struct iio_info ad7992_info = {
+	.read_raw = &ad799x_read_raw,
+	.num_interrupt_lines = 1,
+	.event_attrs = &ad7992_event_attrs_group,
+	.driver_module = THIS_MODULE,
+};
+
+static const struct iio_info ad7993_4_7_8_info = {
+	.read_raw = &ad799x_read_raw,
+	.num_interrupt_lines = 1,
+	.event_attrs = &ad7993_4_7_8_event_attrs_group,
+	.driver_module = THIS_MODULE,
+};
+
 static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	[ad7991] = {
 		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
@@ -476,6 +495,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 		.channel[4] = IIO_CHAN_SOFT_TIMESTAMP(4),
 		.num_channels = 5,
 		.int_vref_mv = 4096,
+		.info = &ad7991_info,
 	},
 	[ad7995] = {
 		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
@@ -493,6 +513,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 		.channel[4] = IIO_CHAN_SOFT_TIMESTAMP(4),
 		.num_channels = 5,
 		.int_vref_mv = 1024,
+		.info = &ad7991_info,
 	},
 	[ad7999] = {
 		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
@@ -510,6 +531,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 		.channel[4] = IIO_CHAN_SOFT_TIMESTAMP(4),
 		.num_channels = 5,
 		.int_vref_mv = 1024,
+		.info = &ad7991_info,
 	},
 	[ad7992] = {
 		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
@@ -521,9 +543,8 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 		.channel[2] = IIO_CHAN_SOFT_TIMESTAMP(2),
 		.num_channels = 3,
 		.int_vref_mv = 4096,
-		.monitor_mode = true,
 		.default_config = AD7998_ALERT_EN,
-		.event_attrs = &ad7992_event_attrs_group,
+		.info = &ad7992_info,
 	},
 	[ad7993] = {
 		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
@@ -541,9 +562,8 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 		.channel[4] = IIO_CHAN_SOFT_TIMESTAMP(4),
 		.num_channels = 5,
 		.int_vref_mv = 1024,
-		.monitor_mode = true,
 		.default_config = AD7998_ALERT_EN,
-		.event_attrs = &ad7993_4_7_8_event_attrs_group,
+		.info = &ad7993_4_7_8_info,
 	},
 	[ad7994] = {
 		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
@@ -561,9 +581,8 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 		.channel[4] = IIO_CHAN_SOFT_TIMESTAMP(4),
 		.num_channels = 5,
 		.int_vref_mv = 4096,
-		.monitor_mode = true,
 		.default_config = AD7998_ALERT_EN,
-		.event_attrs = &ad7993_4_7_8_event_attrs_group,
+		.info = &ad7993_4_7_8_info,
 	},
 	[ad7997] = {
 		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
@@ -593,9 +612,8 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 		.channel[8] = IIO_CHAN_SOFT_TIMESTAMP(8),
 		.num_channels = 9,
 		.int_vref_mv = 1024,
-		.monitor_mode = true,
 		.default_config = AD7998_ALERT_EN,
-		.event_attrs = &ad7993_4_7_8_event_attrs_group,
+		.info = &ad7993_4_7_8_info,
 	},
 	[ad7998] = {
 		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
@@ -625,9 +643,8 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 		.channel[8] = IIO_CHAN_SOFT_TIMESTAMP(8),
 		.num_channels = 9,
 		.int_vref_mv = 4096,
-		.monitor_mode = true,
 		.default_config = AD7998_ALERT_EN,
-		.event_attrs = &ad7993_4_7_8_event_attrs_group,
+		.info = &ad7993_4_7_8_info,
 	},
 };
 
@@ -667,15 +684,13 @@ static int __devinit ad799x_probe(struct i2c_client *client,
 
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->name = id->name;
-	indio_dev->event_attrs = st->chip_info->event_attrs;
+	indio_dev->info = st->chip_info->info;
 	indio_dev->name = id->name;
 	indio_dev->dev_data = (void *)(st);
-	indio_dev->driver_module = THIS_MODULE;
+
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->num_interrupt_lines = 1;
 	indio_dev->channels = st->chip_info->channel;
 	indio_dev->num_channels = st->chip_info->num_channels;
-	indio_dev->read_raw = &ad799x_read_raw;
 
 	ret = ad799x_register_ring_funcs_and_init(indio_dev);
 	if (ret)
@@ -692,7 +707,7 @@ static int __devinit ad799x_probe(struct i2c_client *client,
 	if (ret)
 		goto error_cleanup_ring;
 
-	if (client->irq > 0 && st->chip_info->monitor_mode) {
+	if (client->irq > 0) {
 		ret = request_threaded_irq(client->irq,
 					   NULL,
 					   ad799x_event_handler,
@@ -727,7 +742,7 @@ static __devexit int ad799x_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct ad799x_state *st = iio_priv(indio_dev);
 
-	if (client->irq > 0 && st->chip_info->monitor_mode)
+	if (client->irq > 0)
 		free_irq(client->irq, indio_dev);
 
 	iio_ring_buffer_unregister(indio_dev->ring);
diff --git a/drivers/staging/iio/adc/adt7310.c b/drivers/staging/iio/adc/adt7310.c
index e405fc3..68eca0b 100644
--- a/drivers/staging/iio/adc/adt7310.c
+++ b/drivers/staging/iio/adc/adt7310.c
@@ -746,6 +746,13 @@ static struct attribute_group adt7310_event_attribute_group[ADT7310_IRQS] = {
 	}
 };
 
+static const struct iio_info adt7310_info = {
+	.attrs = &adt7310_attribute_group,
+	.num_interrupt_lines = ADT7310_IRQS,
+	.event_attrs = adt7310_event_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
 /*
  * device probe and remove
  */
@@ -775,11 +782,8 @@ static int __devinit adt7310_probe(struct spi_device *spi_dev)
 
 	chip->indio_dev->dev.parent = &spi_dev->dev;
 	chip->indio_dev->name = spi_get_device_id(spi_dev)->name;
-	chip->indio_dev->attrs = &adt7310_attribute_group;
-	chip->indio_dev->event_attrs = adt7310_event_attribute_group;
+	chip->indio_dev->info = &adt7310_info;
 	chip->indio_dev->dev_data = (void *)chip;
-	chip->indio_dev->driver_module = THIS_MODULE;
-	chip->indio_dev->num_interrupt_lines = ADT7310_IRQS;
 	chip->indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(chip->indio_dev);
diff --git a/drivers/staging/iio/adc/adt7410.c b/drivers/staging/iio/adc/adt7410.c
index 85b5c1a..c40a84f 100644
--- a/drivers/staging/iio/adc/adt7410.c
+++ b/drivers/staging/iio/adc/adt7410.c
@@ -713,6 +713,13 @@ static struct attribute_group adt7410_event_attribute_group[ADT7410_IRQS] = {
 	}
 };
 
+static const struct iio_info adt7410_info = {
+	.attrs = &adt7410_attribute_group,
+	.num_interrupt_lines = ADT7410_IRQS,
+	.event_attrs = adt7410_event_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
 /*
  * device probe and remove
  */
@@ -741,11 +748,8 @@ static int __devinit adt7410_probe(struct i2c_client *client,
 	}
 	chip->indio_dev->name = id->name;
 	chip->indio_dev->dev.parent = &client->dev;
-	chip->indio_dev->attrs = &adt7410_attribute_group;
-	chip->indio_dev->event_attrs = adt7410_event_attribute_group;
+	chip->indio_dev->info = &adt7410_info;
 	chip->indio_dev->dev_data = (void *)chip;
-	chip->indio_dev->driver_module = THIS_MODULE;
-	chip->indio_dev->num_interrupt_lines = ADT7410_IRQS;
 	chip->indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(chip->indio_dev);
diff --git a/drivers/staging/iio/adc/adt75.c b/drivers/staging/iio/adc/adt75.c
index 2a44428..1171fb9 100644
--- a/drivers/staging/iio/adc/adt75.c
+++ b/drivers/staging/iio/adc/adt75.c
@@ -534,6 +534,13 @@ static struct attribute_group adt75_event_attribute_group = {
 	.attrs = adt75_event_attributes,
 };
 
+static const struct iio_info adt75_info = {
+	.attrs = &adt75_attribute_group,
+	.num_interrupt_lines = 1,
+	.event_attrs = &adt75_event_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
 /*
  * device probe and remove
  */
@@ -562,11 +569,8 @@ static int __devinit adt75_probe(struct i2c_client *client,
 
 	chip->indio_dev->name = id->name;
 	chip->indio_dev->dev.parent = &client->dev;
-	chip->indio_dev->attrs = &adt75_attribute_group;
-	chip->indio_dev->event_attrs = &adt75_event_attribute_group;
+	chip->indio_dev->info = &adt75_info;
 	chip->indio_dev->dev_data = (void *)chip;
-	chip->indio_dev->driver_module = THIS_MODULE;
-	chip->indio_dev->num_interrupt_lines = 1;
 	chip->indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(chip->indio_dev);
diff --git a/drivers/staging/iio/adc/max1363.h b/drivers/staging/iio/adc/max1363.h
index 15227bd..5243b5a 100644
--- a/drivers/staging/iio/adc/max1363.h
+++ b/drivers/staging/iio/adc/max1363.h
@@ -154,7 +154,7 @@ enum max1363_modes {
  * @name:		indentification string for chip
  * @bits:		accuracy of the adc in bits
  * @int_vref_mv:	the internal reference voltage
- * @monitor_mode:	whether the chip supports monitor interrupts
+ * @info:		iio core function callbacks structure
  * @mode_list:		array of available scan modes
  * @num_modes:		the number of scan modes available
  * @default_mode:	the scan mode in which the chip starts up
@@ -162,14 +162,14 @@ enum max1363_modes {
  * @num_channels:	number of channels
  */
 struct max1363_chip_info {
-	u8				bits;
-	u16				int_vref_mv;
-	bool				monitor_mode;
-	const enum max1363_modes	*mode_list;
-	int				num_modes;
-	enum max1363_modes		default_mode;
+	const struct iio_info		*info;
 	struct iio_chan_spec *channels;
 	int num_channels;
+	const enum max1363_modes	*mode_list;
+	enum max1363_modes		default_mode;
+	u16				int_vref_mv;
+	u8				num_modes;
+	u8				bits;
 };
 
 /**
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 0c80abb..8d09bf3 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -472,356 +472,6 @@ enum { max1361,
        max11647
 };
 
-/* max1363 and max1368 tested - rest from data sheet */
-static const struct max1363_chip_info max1363_chip_info_tbl[] = {
-	[max1361] = {
-		.bits = 10,
-		.int_vref_mv = 2048,
-		.monitor_mode = 1,
-		.mode_list = max1363_mode_list,
-		.num_modes = ARRAY_SIZE(max1363_mode_list),
-		.default_mode = s0to3,
-		.channels = max1361_channels,
-		.num_channels = ARRAY_SIZE(max1361_channels),
-	},
-	[max1362] = {
-		.bits = 10,
-		.int_vref_mv = 4096,
-		.monitor_mode = 1,
-		.mode_list = max1363_mode_list,
-		.num_modes = ARRAY_SIZE(max1363_mode_list),
-		.default_mode = s0to3,
-		.channels = max1361_channels,
-		.num_channels = ARRAY_SIZE(max1361_channels),
-	},
-	[max1363] = {
-		.bits = 12,
-		.int_vref_mv = 2048,
-		.monitor_mode = 1,
-		.mode_list = max1363_mode_list,
-		.num_modes = ARRAY_SIZE(max1363_mode_list),
-		.default_mode = s0to3,
-		.channels = max1363_channels,
-		.num_channels = ARRAY_SIZE(max1363_channels),
-	},
-	[max1364] = {
-		.bits = 12,
-		.int_vref_mv = 4096,
-		.monitor_mode = 1,
-		.mode_list = max1363_mode_list,
-		.num_modes = ARRAY_SIZE(max1363_mode_list),
-		.default_mode = s0to3,
-		.channels = max1363_channels,
-		.num_channels = ARRAY_SIZE(max1363_channels),
-	},
-	[max1036] = {
-		.bits = 8,
-		.int_vref_mv = 4096,
-		.mode_list = max1236_mode_list,
-		.num_modes = ARRAY_SIZE(max1236_mode_list),
-		.default_mode = s0to3,
-		.channels = max1036_channels,
-		.num_channels = ARRAY_SIZE(max1036_channels),
-	},
-	[max1037] = {
-		.bits = 8,
-		.int_vref_mv = 2048,
-		.mode_list = max1236_mode_list,
-		.num_modes = ARRAY_SIZE(max1236_mode_list),
-		.default_mode = s0to3,
-		.channels = max1036_channels,
-		.num_channels = ARRAY_SIZE(max1036_channels),
-	},
-	[max1038] = {
-		.bits = 8,
-		.int_vref_mv = 4096,
-		.mode_list = max1238_mode_list,
-		.num_modes = ARRAY_SIZE(max1238_mode_list),
-		.default_mode = s0to11,
-		.channels = max1038_channels,
-		.num_channels = ARRAY_SIZE(max1038_channels),
-	},
-	[max1039] = {
-		.bits = 8,
-		.int_vref_mv = 2048,
-		.mode_list = max1238_mode_list,
-		.num_modes = ARRAY_SIZE(max1238_mode_list),
-		.default_mode = s0to11,
-		.channels = max1038_channels,
-		.num_channels = ARRAY_SIZE(max1038_channels),
-	},
-	[max1136] = {
-		.bits = 10,
-		.int_vref_mv = 4096,
-		.mode_list = max1236_mode_list,
-		.num_modes = ARRAY_SIZE(max1236_mode_list),
-		.default_mode = s0to3,
-		.channels = max1136_channels,
-		.num_channels = ARRAY_SIZE(max1136_channels),
-	},
-	[max1137] = {
-		.bits = 10,
-		.int_vref_mv = 2048,
-		.mode_list = max1236_mode_list,
-		.num_modes = ARRAY_SIZE(max1236_mode_list),
-		.default_mode = s0to3,
-		.channels = max1136_channels,
-		.num_channels = ARRAY_SIZE(max1136_channels),
-	},
-	[max1138] = {
-		.bits = 10,
-		.int_vref_mv = 4096,
-		.mode_list = max1238_mode_list,
-		.num_modes = ARRAY_SIZE(max1238_mode_list),
-		.default_mode = s0to11,
-		.channels = max1138_channels,
-		.num_channels = ARRAY_SIZE(max1138_channels),
-	},
-	[max1139] = {
-		.bits = 10,
-		.int_vref_mv = 2048,
-		.mode_list = max1238_mode_list,
-		.num_modes = ARRAY_SIZE(max1238_mode_list),
-		.default_mode = s0to11,
-		.channels = max1138_channels,
-		.num_channels = ARRAY_SIZE(max1138_channels),
-	},
-	[max1236] = {
-		.bits = 12,
-		.int_vref_mv = 4096,
-		.mode_list = max1236_mode_list,
-		.num_modes = ARRAY_SIZE(max1236_mode_list),
-		.default_mode = s0to3,
-		.channels = max1236_channels,
-		.num_channels = ARRAY_SIZE(max1236_channels),
-	},
-	[max1237] = {
-		.bits = 12,
-		.int_vref_mv = 2048,
-		.mode_list = max1236_mode_list,
-		.num_modes = ARRAY_SIZE(max1236_mode_list),
-		.default_mode = s0to3,
-		.channels = max1236_channels,
-		.num_channels = ARRAY_SIZE(max1236_channels),
-	},
-	[max1238] = {
-		.bits = 12,
-		.int_vref_mv = 4096,
-		.mode_list = max1238_mode_list,
-		.num_modes = ARRAY_SIZE(max1238_mode_list),
-		.default_mode = s0to11,
-		.channels = max1238_channels,
-		.num_channels = ARRAY_SIZE(max1238_channels),
-	},
-	[max1239] = {
-		.bits = 12,
-		.int_vref_mv = 2048,
-		.mode_list = max1238_mode_list,
-		.num_modes = ARRAY_SIZE(max1238_mode_list),
-		.default_mode = s0to11,
-		.channels = max1238_channels,
-		.num_channels = ARRAY_SIZE(max1238_channels),
-	},
-	[max11600] = {
-		.bits = 8,
-		.int_vref_mv = 4096,
-		.mode_list = max11607_mode_list,
-		.num_modes = ARRAY_SIZE(max11607_mode_list),
-		.default_mode = s0to3,
-		.channels = max1036_channels,
-		.num_channels = ARRAY_SIZE(max1036_channels),
-	},
-	[max11601] = {
-		.bits = 8,
-		.int_vref_mv = 2048,
-		.mode_list = max11607_mode_list,
-		.num_modes = ARRAY_SIZE(max11607_mode_list),
-		.default_mode = s0to3,
-		.channels = max1036_channels,
-		.num_channels = ARRAY_SIZE(max1036_channels),
-	},
-	[max11602] = {
-		.bits = 8,
-		.int_vref_mv = 4096,
-		.mode_list = max11608_mode_list,
-		.num_modes = ARRAY_SIZE(max11608_mode_list),
-		.default_mode = s0to7,
-		.channels = max11602_channels,
-		.num_channels = ARRAY_SIZE(max11602_channels),
-	},
-	[max11603] = {
-		.bits = 8,
-		.int_vref_mv = 2048,
-		.mode_list = max11608_mode_list,
-		.num_modes = ARRAY_SIZE(max11608_mode_list),
-		.default_mode = s0to7,
-		.channels = max11602_channels,
-		.num_channels = ARRAY_SIZE(max11602_channels),
-	},
-	[max11604] = {
-		.bits = 8,
-		.int_vref_mv = 4098,
-		.mode_list = max1238_mode_list,
-		.num_modes = ARRAY_SIZE(max1238_mode_list),
-		.default_mode = s0to11,
-		.channels = max1238_channels,
-		.num_channels = ARRAY_SIZE(max1238_channels),
-	},
-	[max11605] = {
-		.bits = 8,
-		.int_vref_mv = 2048,
-		.mode_list = max1238_mode_list,
-		.num_modes = ARRAY_SIZE(max1238_mode_list),
-		.default_mode = s0to11,
-		.channels = max1238_channels,
-		.num_channels = ARRAY_SIZE(max1238_channels),
-	},
-	[max11606] = {
-		.bits = 10,
-		.int_vref_mv = 4096,
-		.mode_list = max11607_mode_list,
-		.num_modes = ARRAY_SIZE(max11607_mode_list),
-		.default_mode = s0to3,
-		.channels = max1136_channels,
-		.num_channels = ARRAY_SIZE(max1136_channels),
-	},
-	[max11607] = {
-		.bits = 10,
-		.int_vref_mv = 2048,
-		.mode_list = max11607_mode_list,
-		.num_modes = ARRAY_SIZE(max11607_mode_list),
-		.default_mode = s0to3,
-		.channels = max1136_channels,
-		.num_channels = ARRAY_SIZE(max1136_channels),
-	},
-	[max11608] = {
-		.bits = 10,
-		.int_vref_mv = 4096,
-		.mode_list = max11608_mode_list,
-		.num_modes = ARRAY_SIZE(max11608_mode_list),
-		.default_mode = s0to7,
-		.channels = max11608_channels,
-		.num_channels = ARRAY_SIZE(max11608_channels),
-	},
-	[max11609] = {
-		.bits = 10,
-		.int_vref_mv = 2048,
-		.mode_list = max11608_mode_list,
-		.num_modes = ARRAY_SIZE(max11608_mode_list),
-		.default_mode = s0to7,
-		.channels = max11608_channels,
-		.num_channels = ARRAY_SIZE(max11608_channels),
-	},
-	[max11610] = {
-		.bits = 10,
-		.int_vref_mv = 4098,
-		.mode_list = max1238_mode_list,
-		.num_modes = ARRAY_SIZE(max1238_mode_list),
-		.default_mode = s0to11,
-		.channels = max1238_channels,
-		.num_channels = ARRAY_SIZE(max1238_channels),
-	},
-	[max11611] = {
-		.bits = 10,
-		.int_vref_mv = 2048,
-		.mode_list = max1238_mode_list,
-		.num_modes = ARRAY_SIZE(max1238_mode_list),
-		.default_mode = s0to11,
-		.channels = max1238_channels,
-		.num_channels = ARRAY_SIZE(max1238_channels),
-	},
-	[max11612] = {
-		.bits = 12,
-		.int_vref_mv = 4096,
-		.mode_list = max11607_mode_list,
-		.num_modes = ARRAY_SIZE(max11607_mode_list),
-		.default_mode = s0to3,
-		.channels = max1363_channels,
-		.num_channels = ARRAY_SIZE(max1363_channels),
-	},
-	[max11613] = {
-		.bits = 12,
-		.int_vref_mv = 2048,
-		.mode_list = max11607_mode_list,
-		.num_modes = ARRAY_SIZE(max11607_mode_list),
-		.default_mode = s0to3,
-		.channels = max1363_channels,
-		.num_channels = ARRAY_SIZE(max1363_channels),
-	},
-	[max11614] = {
-		.bits = 12,
-		.int_vref_mv = 4096,
-		.mode_list = max11608_mode_list,
-		.num_modes = ARRAY_SIZE(max11608_mode_list),
-		.default_mode = s0to7,
-		.channels = max11614_channels,
-		.num_channels = ARRAY_SIZE(max11614_channels),
-	},
-	[max11615] = {
-		.bits = 12,
-		.int_vref_mv = 2048,
-		.mode_list = max11608_mode_list,
-		.num_modes = ARRAY_SIZE(max11608_mode_list),
-		.default_mode = s0to7,
-		.channels = max11614_channels,
-		.num_channels = ARRAY_SIZE(max11614_channels),
-	},
-	[max11616] = {
-		.bits = 12,
-		.int_vref_mv = 4098,
-		.mode_list = max1238_mode_list,
-		.num_modes = ARRAY_SIZE(max1238_mode_list),
-		.default_mode = s0to11,
-		.channels = max1238_channels,
-		.num_channels = ARRAY_SIZE(max1238_channels),
-	},
-	[max11617] = {
-		.bits = 12,
-		.int_vref_mv = 2048,
-		.mode_list = max1238_mode_list,
-		.num_modes = ARRAY_SIZE(max1238_mode_list),
-		.default_mode = s0to11,
-		.channels = max1238_channels,
-		.num_channels = ARRAY_SIZE(max1238_channels),
-	},
-	[max11644] = {
-		.bits = 12,
-		.int_vref_mv = 2048,
-		.mode_list = max11644_mode_list,
-		.num_modes = ARRAY_SIZE(max11644_mode_list),
-		.default_mode = s0to1,
-		.channels = max11644_channels,
-		.num_channels = ARRAY_SIZE(max11644_channels),
-	},
-	[max11645] = {
-		.bits = 12,
-		.int_vref_mv = 4096,
-		.mode_list = max11644_mode_list,
-		.num_modes = ARRAY_SIZE(max11644_mode_list),
-		.default_mode = s0to1,
-		.channels = max11644_channels,
-		.num_channels = ARRAY_SIZE(max11644_channels),
-	},
-	[max11646] = {
-		.bits = 10,
-		.int_vref_mv = 2048,
-		.mode_list = max11644_mode_list,
-		.num_modes = ARRAY_SIZE(max11644_mode_list),
-		.default_mode = s0to1,
-		.channels = max11644_channels,
-		.num_channels = ARRAY_SIZE(max11646_channels),
-	},
-	[max11647] = {
-		.bits = 10,
-		.int_vref_mv = 4096,
-		.mode_list = max11644_mode_list,
-		.num_modes = ARRAY_SIZE(max11644_mode_list),
-		.default_mode = s0to1,
-		.channels = max11644_channels,
-		.num_channels = ARRAY_SIZE(max11646_channels),
-	},
-};
-
 static const int max1363_monitor_speeds[] = { 133000, 665000, 33300, 16600,
 					      8300, 4200, 2000, 1000 };
 
@@ -1161,9 +811,414 @@ static struct attribute *max1363_event_attributes[] = {
 	NULL,
 };
 
-static struct attribute_group max1363_event_attribute_group = {
-	.attrs = max1363_event_attributes,
-};
+static struct attribute_group max1363_event_attribute_group = {
+	.attrs = max1363_event_attributes,
+};
+
+#define MAX1363_EVENT_FUNCS						\
+
+
+static const struct iio_info max1238_info = {
+	.read_raw = &max1363_read_raw,
+	.driver_module = THIS_MODULE,
+};
+
+static const struct iio_info max1363_info = {
+	.read_event_value = &max1363_read_thresh,
+	.write_event_value = &max1363_write_thresh,
+	.read_event_config = &max1363_read_event_config,
+	.write_event_config = &max1363_write_event_config,
+	.read_raw = &max1363_read_raw,
+	.driver_module = THIS_MODULE,
+	.num_interrupt_lines = 1,
+	.event_attrs = &max1363_event_attribute_group,
+};
+
+/* max1363 and max1368 tested - rest from data sheet */
+static const struct max1363_chip_info max1363_chip_info_tbl[] = {
+	[max1361] = {
+		.bits = 10,
+		.int_vref_mv = 2048,
+		.mode_list = max1363_mode_list,
+		.num_modes = ARRAY_SIZE(max1363_mode_list),
+		.default_mode = s0to3,
+		.channels = max1361_channels,
+		.num_channels = ARRAY_SIZE(max1361_channels),
+		.info = &max1363_info,
+	},
+	[max1362] = {
+		.bits = 10,
+		.int_vref_mv = 4096,
+		.mode_list = max1363_mode_list,
+		.num_modes = ARRAY_SIZE(max1363_mode_list),
+		.default_mode = s0to3,
+		.channels = max1361_channels,
+		.num_channels = ARRAY_SIZE(max1361_channels),
+		.info = &max1363_info,
+	},
+	[max1363] = {
+		.bits = 12,
+		.int_vref_mv = 2048,
+		.mode_list = max1363_mode_list,
+		.num_modes = ARRAY_SIZE(max1363_mode_list),
+		.default_mode = s0to3,
+		.channels = max1363_channels,
+		.num_channels = ARRAY_SIZE(max1363_channels),
+		.info = &max1363_info,
+	},
+	[max1364] = {
+		.bits = 12,
+		.int_vref_mv = 4096,
+		.mode_list = max1363_mode_list,
+		.num_modes = ARRAY_SIZE(max1363_mode_list),
+		.default_mode = s0to3,
+		.channels = max1363_channels,
+		.num_channels = ARRAY_SIZE(max1363_channels),
+		.info = &max1363_info,
+	},
+	[max1036] = {
+		.bits = 8,
+		.int_vref_mv = 4096,
+		.mode_list = max1236_mode_list,
+		.num_modes = ARRAY_SIZE(max1236_mode_list),
+		.default_mode = s0to3,
+		.info = &max1238_info,
+		.channels = max1036_channels,
+		.num_channels = ARRAY_SIZE(max1036_channels),
+	},
+	[max1037] = {
+		.bits = 8,
+		.int_vref_mv = 2048,
+		.mode_list = max1236_mode_list,
+		.num_modes = ARRAY_SIZE(max1236_mode_list),
+		.default_mode = s0to3,
+		.info = &max1238_info,
+		.channels = max1036_channels,
+		.num_channels = ARRAY_SIZE(max1036_channels),
+	},
+	[max1038] = {
+		.bits = 8,
+		.int_vref_mv = 4096,
+		.mode_list = max1238_mode_list,
+		.num_modes = ARRAY_SIZE(max1238_mode_list),
+		.default_mode = s0to11,
+		.info = &max1238_info,
+		.channels = max1038_channels,
+		.num_channels = ARRAY_SIZE(max1038_channels),
+	},
+	[max1039] = {
+		.bits = 8,
+		.int_vref_mv = 2048,
+		.mode_list = max1238_mode_list,
+		.num_modes = ARRAY_SIZE(max1238_mode_list),
+		.default_mode = s0to11,
+		.info = &max1238_info,
+		.channels = max1038_channels,
+		.num_channels = ARRAY_SIZE(max1038_channels),
+	},
+	[max1136] = {
+		.bits = 10,
+		.int_vref_mv = 4096,
+		.mode_list = max1236_mode_list,
+		.num_modes = ARRAY_SIZE(max1236_mode_list),
+		.default_mode = s0to3,
+		.info = &max1238_info,
+		.channels = max1136_channels,
+		.num_channels = ARRAY_SIZE(max1136_channels),
+	},
+	[max1137] = {
+		.bits = 10,
+		.int_vref_mv = 2048,
+		.mode_list = max1236_mode_list,
+		.num_modes = ARRAY_SIZE(max1236_mode_list),
+		.default_mode = s0to3,
+		.info = &max1238_info,
+		.channels = max1136_channels,
+		.num_channels = ARRAY_SIZE(max1136_channels),
+	},
+	[max1138] = {
+		.bits = 10,
+		.int_vref_mv = 4096,
+		.mode_list = max1238_mode_list,
+		.num_modes = ARRAY_SIZE(max1238_mode_list),
+		.default_mode = s0to11,
+		.info = &max1238_info,
+		.channels = max1138_channels,
+		.num_channels = ARRAY_SIZE(max1138_channels),
+	},
+	[max1139] = {
+		.bits = 10,
+		.int_vref_mv = 2048,
+		.mode_list = max1238_mode_list,
+		.num_modes = ARRAY_SIZE(max1238_mode_list),
+		.default_mode = s0to11,
+		.info = &max1238_info,
+		.channels = max1138_channels,
+		.num_channels = ARRAY_SIZE(max1138_channels),
+	},
+	[max1236] = {
+		.bits = 12,
+		.int_vref_mv = 4096,
+		.mode_list = max1236_mode_list,
+		.num_modes = ARRAY_SIZE(max1236_mode_list),
+		.default_mode = s0to3,
+		.info = &max1238_info,
+		.channels = max1236_channels,
+		.num_channels = ARRAY_SIZE(max1236_channels),
+	},
+	[max1237] = {
+		.bits = 12,
+		.int_vref_mv = 2048,
+		.mode_list = max1236_mode_list,
+		.num_modes = ARRAY_SIZE(max1236_mode_list),
+		.default_mode = s0to3,
+		.info = &max1238_info,
+		.channels = max1236_channels,
+		.num_channels = ARRAY_SIZE(max1236_channels),
+	},
+	[max1238] = {
+		.bits = 12,
+		.int_vref_mv = 4096,
+		.mode_list = max1238_mode_list,
+		.num_modes = ARRAY_SIZE(max1238_mode_list),
+		.default_mode = s0to11,
+		.info = &max1238_info,
+		.channels = max1238_channels,
+		.num_channels = ARRAY_SIZE(max1238_channels),
+	},
+	[max1239] = {
+		.bits = 12,
+		.int_vref_mv = 2048,
+		.mode_list = max1238_mode_list,
+		.num_modes = ARRAY_SIZE(max1238_mode_list),
+		.default_mode = s0to11,
+		.info = &max1238_info,
+		.channels = max1238_channels,
+		.num_channels = ARRAY_SIZE(max1238_channels),
+	},
+	[max11600] = {
+		.bits = 8,
+		.int_vref_mv = 4096,
+		.mode_list = max11607_mode_list,
+		.num_modes = ARRAY_SIZE(max11607_mode_list),
+		.default_mode = s0to3,
+		.info = &max1238_info,
+		.channels = max1036_channels,
+		.num_channels = ARRAY_SIZE(max1036_channels),
+	},
+	[max11601] = {
+		.bits = 8,
+		.int_vref_mv = 2048,
+		.mode_list = max11607_mode_list,
+		.num_modes = ARRAY_SIZE(max11607_mode_list),
+		.default_mode = s0to3,
+		.info = &max1238_info,
+		.channels = max1036_channels,
+		.num_channels = ARRAY_SIZE(max1036_channels),
+	},
+	[max11602] = {
+		.bits = 8,
+		.int_vref_mv = 4096,
+		.mode_list = max11608_mode_list,
+		.num_modes = ARRAY_SIZE(max11608_mode_list),
+		.default_mode = s0to7,
+		.info = &max1238_info,
+		.channels = max11602_channels,
+		.num_channels = ARRAY_SIZE(max11602_channels),
+	},
+	[max11603] = {
+		.bits = 8,
+		.int_vref_mv = 2048,
+		.mode_list = max11608_mode_list,
+		.num_modes = ARRAY_SIZE(max11608_mode_list),
+		.default_mode = s0to7,
+		.info = &max1238_info,
+		.channels = max11602_channels,
+		.num_channels = ARRAY_SIZE(max11602_channels),
+	},
+	[max11604] = {
+		.bits = 8,
+		.int_vref_mv = 4098,
+		.mode_list = max1238_mode_list,
+		.num_modes = ARRAY_SIZE(max1238_mode_list),
+		.default_mode = s0to11,
+		.info = &max1238_info,
+		.channels = max1238_channels,
+		.num_channels = ARRAY_SIZE(max1238_channels),
+	},
+	[max11605] = {
+		.bits = 8,
+		.int_vref_mv = 2048,
+		.mode_list = max1238_mode_list,
+		.num_modes = ARRAY_SIZE(max1238_mode_list),
+		.default_mode = s0to11,
+		.info = &max1238_info,
+		.channels = max1238_channels,
+		.num_channels = ARRAY_SIZE(max1238_channels),
+	},
+	[max11606] = {
+		.bits = 10,
+		.int_vref_mv = 4096,
+		.mode_list = max11607_mode_list,
+		.num_modes = ARRAY_SIZE(max11607_mode_list),
+		.default_mode = s0to3,
+		.info = &max1238_info,
+		.channels = max1136_channels,
+		.num_channels = ARRAY_SIZE(max1136_channels),
+	},
+	[max11607] = {
+		.bits = 10,
+		.int_vref_mv = 2048,
+		.mode_list = max11607_mode_list,
+		.num_modes = ARRAY_SIZE(max11607_mode_list),
+		.default_mode = s0to3,
+		.info = &max1238_info,
+		.channels = max1136_channels,
+		.num_channels = ARRAY_SIZE(max1136_channels),
+	},
+	[max11608] = {
+		.bits = 10,
+		.int_vref_mv = 4096,
+		.mode_list = max11608_mode_list,
+		.num_modes = ARRAY_SIZE(max11608_mode_list),
+		.default_mode = s0to7,
+		.info = &max1238_info,
+		.channels = max11608_channels,
+		.num_channels = ARRAY_SIZE(max11608_channels),
+	},
+	[max11609] = {
+		.bits = 10,
+		.int_vref_mv = 2048,
+		.mode_list = max11608_mode_list,
+		.num_modes = ARRAY_SIZE(max11608_mode_list),
+		.default_mode = s0to7,
+		.info = &max1238_info,
+		.channels = max11608_channels,
+		.num_channels = ARRAY_SIZE(max11608_channels),
+	},
+	[max11610] = {
+		.bits = 10,
+		.int_vref_mv = 4098,
+		.mode_list = max1238_mode_list,
+		.num_modes = ARRAY_SIZE(max1238_mode_list),
+		.default_mode = s0to11,
+		.info = &max1238_info,
+		.channels = max1238_channels,
+		.num_channels = ARRAY_SIZE(max1238_channels),
+	},
+	[max11611] = {
+		.bits = 10,
+		.int_vref_mv = 2048,
+		.mode_list = max1238_mode_list,
+		.num_modes = ARRAY_SIZE(max1238_mode_list),
+		.default_mode = s0to11,
+		.info = &max1238_info,
+		.channels = max1238_channels,
+		.num_channels = ARRAY_SIZE(max1238_channels),
+	},
+	[max11612] = {
+		.bits = 12,
+		.int_vref_mv = 4096,
+		.mode_list = max11607_mode_list,
+		.num_modes = ARRAY_SIZE(max11607_mode_list),
+		.default_mode = s0to3,
+		.info = &max1238_info,
+		.channels = max1363_channels,
+		.num_channels = ARRAY_SIZE(max1363_channels),
+	},
+	[max11613] = {
+		.bits = 12,
+		.int_vref_mv = 2048,
+		.mode_list = max11607_mode_list,
+		.num_modes = ARRAY_SIZE(max11607_mode_list),
+		.default_mode = s0to3,
+		.info = &max1238_info,
+		.channels = max1363_channels,
+		.num_channels = ARRAY_SIZE(max1363_channels),
+	},
+	[max11614] = {
+		.bits = 12,
+		.int_vref_mv = 4096,
+		.mode_list = max11608_mode_list,
+		.num_modes = ARRAY_SIZE(max11608_mode_list),
+		.default_mode = s0to7,
+		.info = &max1238_info,
+		.channels = max11614_channels,
+		.num_channels = ARRAY_SIZE(max11614_channels),
+	},
+	[max11615] = {
+		.bits = 12,
+		.int_vref_mv = 2048,
+		.mode_list = max11608_mode_list,
+		.num_modes = ARRAY_SIZE(max11608_mode_list),
+		.default_mode = s0to7,
+		.info = &max1238_info,
+		.channels = max11614_channels,
+		.num_channels = ARRAY_SIZE(max11614_channels),
+	},
+	[max11616] = {
+		.bits = 12,
+		.int_vref_mv = 4098,
+		.mode_list = max1238_mode_list,
+		.num_modes = ARRAY_SIZE(max1238_mode_list),
+		.default_mode = s0to11,
+		.info = &max1238_info,
+		.channels = max1238_channels,
+		.num_channels = ARRAY_SIZE(max1238_channels),
+	},
+	[max11617] = {
+		.bits = 12,
+		.int_vref_mv = 2048,
+		.mode_list = max1238_mode_list,
+		.num_modes = ARRAY_SIZE(max1238_mode_list),
+		.default_mode = s0to11,
+		.info = &max1238_info,
+		.channels = max1238_channels,
+		.num_channels = ARRAY_SIZE(max1238_channels),
+	},
+	[max11644] = {
+		.bits = 12,
+		.int_vref_mv = 2048,
+		.mode_list = max11644_mode_list,
+		.num_modes = ARRAY_SIZE(max11644_mode_list),
+		.default_mode = s0to1,
+		.info = &max1238_info,
+		.channels = max11644_channels,
+		.num_channels = ARRAY_SIZE(max11644_channels),
+	},
+	[max11645] = {
+		.bits = 12,
+		.int_vref_mv = 4096,
+		.mode_list = max11644_mode_list,
+		.num_modes = ARRAY_SIZE(max11644_mode_list),
+		.default_mode = s0to1,
+		.info = &max1238_info,
+		.channels = max11644_channels,
+		.num_channels = ARRAY_SIZE(max11644_channels),
+	},
+	[max11646] = {
+		.bits = 10,
+		.int_vref_mv = 2048,
+		.mode_list = max11644_mode_list,
+		.num_modes = ARRAY_SIZE(max11644_mode_list),
+		.default_mode = s0to1,
+		.info = &max1238_info,
+		.channels = max11646_channels,
+		.num_channels = ARRAY_SIZE(max11646_channels),
+	},
+	[max11647] = {
+		.bits = 10,
+		.int_vref_mv = 4096,
+		.mode_list = max11644_mode_list,
+		.num_modes = ARRAY_SIZE(max11644_mode_list),
+		.default_mode = s0to1,
+		.info = &max1238_info,
+		.channels = max11646_channels,
+		.num_channels = ARRAY_SIZE(max11646_channels),
+	},
+};
+
+
 
 static int max1363_initial_setup(struct max1363_state *st)
 {
@@ -1224,22 +1279,9 @@ static int __devinit max1363_probe(struct i2c_client *client,
 	/* Estabilish that the iio_dev is a child of the i2c device */
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->name = id->name;
-	indio_dev->read_event_value = &max1363_read_thresh;
-	indio_dev->write_event_value = &max1363_write_thresh;
-	indio_dev->read_event_config = &max1363_read_event_config;
-	indio_dev->write_event_config = &max1363_write_event_config;
-	indio_dev->channels = st->chip_info->channels;
-	indio_dev->num_channels = st->chip_info->num_channels;
-	indio_dev->read_raw = &max1363_read_raw;
-	/* Todo: this shouldn't be here. */
-	indio_dev->driver_module = THIS_MODULE;
-	indio_dev->modes = INDIO_DIRECT_MODE;
-	if (st->chip_info->monitor_mode && client->irq) {
-		indio_dev->num_interrupt_lines = 1;
-		indio_dev->event_attrs
-			= &max1363_event_attribute_group;
-	}
 
+	indio_dev->info = st->chip_info->info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 	ret = max1363_initial_setup(st);
 	if (ret)
 		goto error_free_available_scan_masks;
@@ -1258,7 +1300,7 @@ static int __devinit max1363_probe(struct i2c_client *client,
 	if (ret)
 		goto error_cleanup_ring;
 
-	if (st->chip_info->monitor_mode && client->irq) {
+	if (client->irq) {
 		ret = request_threaded_irq(st->client->irq,
 					   NULL,
 					   &max1363_event_handler,
@@ -1298,7 +1340,7 @@ static int max1363_remove(struct i2c_client *client)
 	struct max1363_state *st = iio_priv(indio_dev);
 	struct regulator *reg = st->reg;
 
-	if (st->chip_info->monitor_mode && client->irq)
+	if (client->irq)
 		free_irq(st->client->irq, indio_dev);
 	iio_ring_buffer_unregister(indio_dev->ring);
 	max1363_ring_cleanup(indio_dev);
diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index b71994e..7097deb 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -2106,6 +2106,20 @@ int adt7316_enable(struct device *dev)
 EXPORT_SYMBOL(adt7316_enable);
 #endif
 
+static const struct iio_info adt7316_info = {
+	.attrs = &adt7316_attribute_group,
+	.num_interrupt_lines = 1,
+	.event_attrs = &adt7316_event_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
+static const struct iio_info adt7516_info = {
+	.attrs = &adt7516_attribute_group,
+	.num_interrupt_lines = 1,
+	.event_attrs = &adt7516_event_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
 /*
  * device probe and remove
  */
@@ -2150,17 +2164,12 @@ int __devinit adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 	}
 
 	chip->indio_dev->dev.parent = dev;
-	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX) {
-		chip->indio_dev->attrs = &adt7516_attribute_group;
-		chip->indio_dev->event_attrs = &adt7516_event_attribute_group;
-	} else {
-		chip->indio_dev->attrs = &adt7316_attribute_group;
-		chip->indio_dev->event_attrs = &adt7316_event_attribute_group;
-	}
+	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
+		chip->indio_dev->info = &adt7516_info;
+	else
+		chip->indio_dev->info = &adt7316_info;
 	chip->indio_dev->name = name;
 	chip->indio_dev->dev_data = (void *)chip;
-	chip->indio_dev->driver_module = THIS_MODULE;
-	chip->indio_dev->num_interrupt_lines = 1;
 	chip->indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(chip->indio_dev);
diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
index 22646a6..86cb08c 100644
--- a/drivers/staging/iio/dac/ad5446.c
+++ b/drivers/staging/iio/dac/ad5446.c
@@ -334,6 +334,11 @@ static const struct ad5446_chip_info ad5446_chip_info_tbl[] = {
 	},
 };
 
+static const struct iio_info ad5446_info = {
+	.attrs = &ad5446_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
 static int __devinit ad5446_probe(struct spi_device *spi)
 {
 	struct ad5446_state *st;
@@ -370,9 +375,8 @@ static int __devinit ad5446_probe(struct spi_device *spi)
 	/* Estabilish that the iio_dev is a child of the spi device */
 	st->indio_dev->dev.parent = &spi->dev;
 	st->indio_dev->name = spi_get_device_id(spi)->name;
-	st->indio_dev->attrs = &ad5446_attribute_group;
+	st->indio_dev->info = &ad5446_info;
 	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* Setup default message */
diff --git a/drivers/staging/iio/dac/ad5504.c b/drivers/staging/iio/dac/ad5504.c
index 351a9d3..ed029cd 100644
--- a/drivers/staging/iio/dac/ad5504.c
+++ b/drivers/staging/iio/dac/ad5504.c
@@ -260,6 +260,20 @@ static irqreturn_t ad5504_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+static const struct iio_info ad5504_info = {
+	.attrs = &ad5504_attribute_group,
+	.num_interrupt_lines = 1,
+	.event_attrs = &ad5504_ev_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
+static const struct iio_info ad5501_info = {
+	.attrs = &ad5501_attribute_group,
+	.num_interrupt_lines = 1,
+	.event_attrs = &ad5504_ev_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
 static int __devinit ad5504_probe(struct spi_device *spi)
 {
 	struct ad5504_platform_data *pdata = spi->dev.platform_data;
@@ -298,14 +312,12 @@ static int __devinit ad5504_probe(struct spi_device *spi)
 	}
 	st->indio_dev->dev.parent = &spi->dev;
 	st->indio_dev->name = spi_get_device_id(st->spi)->name;
-	st->indio_dev->attrs = spi_get_device_id(st->spi)->driver_data
-		== ID_AD5501 ? &ad5501_attribute_group :
-		&ad5504_attribute_group;
+	if (spi_get_device_id(st->spi)->driver_data == ID_AD5501)
+		st->indio_dev->info = &ad5501_info;
+	else
+		st->indio_dev->info = &ad5504_info;
 	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
-	st->indio_dev->num_interrupt_lines = 1;
-	st->indio_dev->event_attrs = &ad5504_ev_attribute_group,
 
 	ret = iio_device_register(st->indio_dev);
 	if (ret)
diff --git a/drivers/staging/iio/dac/ad5624r_spi.c b/drivers/staging/iio/dac/ad5624r_spi.c
index b0e25e2..c679981 100644
--- a/drivers/staging/iio/dac/ad5624r_spi.c
+++ b/drivers/staging/iio/dac/ad5624r_spi.c
@@ -218,6 +218,11 @@ static const struct attribute_group ad5624r_attribute_group = {
 	.attrs = ad5624r_attributes,
 };
 
+static const struct iio_info ad5624r_info = {
+	.attrs = &ad5624r_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
 static int __devinit ad5624r_probe(struct spi_device *spi)
 {
 	struct ad5624r_state *st;
@@ -255,9 +260,8 @@ static int __devinit ad5624r_probe(struct spi_device *spi)
 	}
 	st->indio_dev->dev.parent = &spi->dev;
 	st->indio_dev->name = spi_get_device_id(spi)->name;
-	st->indio_dev->attrs = &ad5624r_attribute_group;
+	st->indio_dev->info = &ad5624r_info;
 	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(st->indio_dev);
diff --git a/drivers/staging/iio/dac/ad5791.c b/drivers/staging/iio/dac/ad5791.c
index acfd13b..4eda25c 100644
--- a/drivers/staging/iio/dac/ad5791.c
+++ b/drivers/staging/iio/dac/ad5791.c
@@ -287,6 +287,11 @@ static const struct ad5791_chip_info ad5791_chip_info_tbl[] = {
 	},
 };
 
+static const struct iio_info ad5791_info = {
+	.attrs = &ad5791_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
 static int __devinit ad5791_probe(struct spi_device *spi)
 {
 	struct ad5791_platform_data *pdata = spi->dev.platform_data;
@@ -353,8 +358,7 @@ static int __devinit ad5791_probe(struct spi_device *spi)
 	}
 	st->indio_dev->dev.parent = &spi->dev;
 	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->attrs = &ad5791_attribute_group;
-	st->indio_dev->driver_module = THIS_MODULE;
+	st->indio_dev->info = &ad5791_info;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(st->indio_dev);
diff --git a/drivers/staging/iio/dac/max517.c b/drivers/staging/iio/dac/max517.c
index 3eb48b6..881768d 100644
--- a/drivers/staging/iio/dac/max517.c
+++ b/drivers/staging/iio/dac/max517.c
@@ -189,6 +189,16 @@ static int max517_resume(struct i2c_client *client)
 	return i2c_master_send(client, &outbuf, 1);
 }
 
+static const struct iio_info max517_info = {
+	.attrs = &max517_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
+static const struct iio_info max518_info = {
+	.attrs = &max517_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
 static int max517_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -217,11 +227,10 @@ static int max517_probe(struct i2c_client *client,
 
 	/* reduced attribute set for MAX517 */
 	if (id->driver_data == ID_MAX517)
-		data->indio_dev->attrs = &max517_attribute_group;
+		data->indio_dev->info = &max517_info;
 	else
-		data->indio_dev->attrs = &max518_attribute_group;
+		data->indio_dev->info = &max518_info;
 	data->indio_dev->dev_data = (void *)(data);
-	data->indio_dev->driver_module = THIS_MODULE;
 	data->indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/*
diff --git a/drivers/staging/iio/dds/ad5930.c b/drivers/staging/iio/dds/ad5930.c
index 5d98f93..490c363 100644
--- a/drivers/staging/iio/dds/ad5930.c
+++ b/drivers/staging/iio/dds/ad5930.c
@@ -87,6 +87,12 @@ static const struct attribute_group ad5930_attribute_group = {
 	.attrs = ad5930_attributes,
 };
 
+static const struct iio_info ad5930_info = {
+	.attrs = &ad5930_attribute_group,
+
+	.driver_module = THIS_MODULE,
+};
+
 static int __devinit ad5930_probe(struct spi_device *spi)
 {
 	struct ad5930_state *st;
@@ -108,12 +114,8 @@ static int __devinit ad5930_probe(struct spi_device *spi)
 		goto error_free_st;
 	}
 	st->idev->dev.parent = &spi->dev;
-	st->idev->num_interrupt_lines = 0;
-	st->idev->event_attrs = NULL;
-
-	st->idev->attrs = &ad5930_attribute_group;
 	st->idev->dev_data = (void *)(st);
-	st->idev->driver_module = THIS_MODULE;
+	st->idev->info = &ad5930_info;
 	st->idev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(st->idev);
diff --git a/drivers/staging/iio/dds/ad9832.c b/drivers/staging/iio/dds/ad9832.c
index 4b5721c..e8fe142 100644
--- a/drivers/staging/iio/dds/ad9832.c
+++ b/drivers/staging/iio/dds/ad9832.c
@@ -195,6 +195,11 @@ static const struct attribute_group ad9832_attribute_group = {
 	.attrs = ad9832_attributes,
 };
 
+static const struct iio_info ad9832_info = {
+	.attrs = &ad9832_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
 static int __devinit ad9832_probe(struct spi_device *spi)
 {
 	struct ad9832_platform_data *pdata = spi->dev.platform_data;
@@ -232,9 +237,8 @@ static int __devinit ad9832_probe(struct spi_device *spi)
 
 	st->indio_dev->dev.parent = &spi->dev;
 	st->indio_dev->name = spi_get_device_id(spi)->name;
-	st->indio_dev->attrs = &ad9832_attribute_group;
+	st->indio_dev->info = &ad9832_info;
 	st->indio_dev->dev_data = (void *) st;
-	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* Setup default messages */
diff --git a/drivers/staging/iio/dds/ad9834.c b/drivers/staging/iio/dds/ad9834.c
index e5303e6..0ebe8d5 100644
--- a/drivers/staging/iio/dds/ad9834.c
+++ b/drivers/staging/iio/dds/ad9834.c
@@ -305,6 +305,11 @@ static const struct attribute_group ad9834_attribute_group = {
 	.is_visible = ad9834_attr_is_visible,
 };
 
+static const struct iio_info ad9834_info = {
+	.attrs = &ad9834_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
 static int __devinit ad9834_probe(struct spi_device *spi)
 {
 	struct ad9834_platform_data *pdata = spi->dev.platform_data;
@@ -344,9 +349,8 @@ static int __devinit ad9834_probe(struct spi_device *spi)
 
 	st->indio_dev->dev.parent = &spi->dev;
 	st->indio_dev->name = spi_get_device_id(spi)->name;
-	st->indio_dev->attrs = &ad9834_attribute_group;
+	st->indio_dev->info = &ad9834_info;
 	st->indio_dev->dev_data = (void *) st;
-	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* Setup default messages */
diff --git a/drivers/staging/iio/dds/ad9850.c b/drivers/staging/iio/dds/ad9850.c
index 34bc0e6..b580d85 100644
--- a/drivers/staging/iio/dds/ad9850.c
+++ b/drivers/staging/iio/dds/ad9850.c
@@ -73,6 +73,11 @@ static const struct attribute_group ad9850_attribute_group = {
 	.attrs = ad9850_attributes,
 };
 
+static const struct iio_info ad9850_info = {
+	.attrs = &ad9850_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
 static int __devinit ad9850_probe(struct spi_device *spi)
 {
 	struct ad9850_state *st;
@@ -94,12 +99,9 @@ static int __devinit ad9850_probe(struct spi_device *spi)
 		goto error_free_st;
 	}
 	st->idev->dev.parent = &spi->dev;
-	st->idev->num_interrupt_lines = 0;
-	st->idev->event_attrs = NULL;
 
-	st->idev->attrs = &ad9850_attribute_group;
+	st->idev->info = &ad9850_info;
 	st->idev->dev_data = (void *)(st);
-	st->idev->driver_module = THIS_MODULE;
 	st->idev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(st->idev);
diff --git a/drivers/staging/iio/dds/ad9852.c b/drivers/staging/iio/dds/ad9852.c
index 899a72a..08020f9 100644
--- a/drivers/staging/iio/dds/ad9852.c
+++ b/drivers/staging/iio/dds/ad9852.c
@@ -222,6 +222,11 @@ static const struct attribute_group ad9852_attribute_group = {
 	.attrs = ad9852_attributes,
 };
 
+static const struct iio_info ad9852_info = {
+	.attrs = &ad9852_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
 static int __devinit ad9852_probe(struct spi_device *spi)
 {
 	struct ad9852_state *st;
@@ -243,12 +248,9 @@ static int __devinit ad9852_probe(struct spi_device *spi)
 		goto error_free_st;
 	}
 	st->idev->dev.parent = &spi->dev;
-	st->idev->num_interrupt_lines = 0;
-	st->idev->event_attrs = NULL;
 
-	st->idev->attrs = &ad9852_attribute_group;
+	st->idev->info = &ad9852_info;
 	st->idev->dev_data = (void *)(st);
-	st->idev->driver_module = THIS_MODULE;
 	st->idev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(st->idev);
diff --git a/drivers/staging/iio/dds/ad9910.c b/drivers/staging/iio/dds/ad9910.c
index fddb6e7..97d75d7 100644
--- a/drivers/staging/iio/dds/ad9910.c
+++ b/drivers/staging/iio/dds/ad9910.c
@@ -357,6 +357,11 @@ static const struct attribute_group ad9910_attribute_group = {
 	.attrs = ad9910_attributes,
 };
 
+static const struct iio_info ad9910_info = {
+	.attrs = &ad9910_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
 static int __devinit ad9910_probe(struct spi_device *spi)
 {
 	struct ad9910_state *st;
@@ -378,12 +383,9 @@ static int __devinit ad9910_probe(struct spi_device *spi)
 		goto error_free_st;
 	}
 	st->idev->dev.parent = &spi->dev;
-	st->idev->num_interrupt_lines = 0;
-	st->idev->event_attrs = NULL;
 
-	st->idev->attrs = &ad9910_attribute_group;
+	st->idev->info = &ad9910_info;
 	st->idev->dev_data = (void *)(st);
-	st->idev->driver_module = THIS_MODULE;
 	st->idev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(st->idev);
diff --git a/drivers/staging/iio/dds/ad9951.c b/drivers/staging/iio/dds/ad9951.c
index a9e56c6..d4dfcd4 100644
--- a/drivers/staging/iio/dds/ad9951.c
+++ b/drivers/staging/iio/dds/ad9951.c
@@ -166,6 +166,11 @@ static const struct attribute_group ad9951_attribute_group = {
 	.attrs = ad9951_attributes,
 };
 
+static const struct iio_info ad9951_info = {
+	.attrs = &ad9951_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
 static int __devinit ad9951_probe(struct spi_device *spi)
 {
 	struct ad9951_state *st;
@@ -187,12 +192,9 @@ static int __devinit ad9951_probe(struct spi_device *spi)
 		goto error_free_st;
 	}
 	st->idev->dev.parent = &spi->dev;
-	st->idev->num_interrupt_lines = 0;
-	st->idev->event_attrs = NULL;
 
-	st->idev->attrs = &ad9951_attribute_group;
+	st->idev->info = &ad9951_info;
 	st->idev->dev_data = (void *)(st);
-	st->idev->driver_module = THIS_MODULE;
 	st->idev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(st->idev);
diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
index e1f8a70..edf9e3b 100644
--- a/drivers/staging/iio/gyro/adis16060_core.c
+++ b/drivers/staging/iio/gyro/adis16060_core.c
@@ -133,6 +133,11 @@ static const struct attribute_group adis16060_attribute_group = {
 	.attrs = adis16060_attributes,
 };
 
+static const struct iio_info adis16060_info = {
+	.attrs = &adis16060_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
 static int __devinit adis16060_r_probe(struct spi_device *spi)
 {
 	int ret, regdone = 0;
@@ -154,9 +159,8 @@ static int __devinit adis16060_r_probe(struct spi_device *spi)
 	}
 
 	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->attrs = &adis16060_attribute_group;
+	st->indio_dev->info = &adis16060_info;
 	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(st->indio_dev);
diff --git a/drivers/staging/iio/gyro/adis16080_core.c b/drivers/staging/iio/gyro/adis16080_core.c
index fb48e9b..d42690b 100644
--- a/drivers/staging/iio/gyro/adis16080_core.c
+++ b/drivers/staging/iio/gyro/adis16080_core.c
@@ -123,6 +123,11 @@ static const struct attribute_group adis16080_attribute_group = {
 	.attrs = adis16080_attributes,
 };
 
+static const struct iio_info adis16080_info = {
+	.attrs = &adis16080_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
 static int __devinit adis16080_probe(struct spi_device *spi)
 {
 	int ret, regdone = 0;
@@ -146,9 +151,8 @@ static int __devinit adis16080_probe(struct spi_device *spi)
 
 	st->indio_dev->name = spi->dev.driver->name;
 	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->attrs = &adis16080_attribute_group;
+	st->indio_dev->info = &adis16080_info;
 	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(st->indio_dev);
diff --git a/drivers/staging/iio/gyro/adis16130_core.c b/drivers/staging/iio/gyro/adis16130_core.c
index c2f338c..14d5a34 100644
--- a/drivers/staging/iio/gyro/adis16130_core.c
+++ b/drivers/staging/iio/gyro/adis16130_core.c
@@ -175,6 +175,11 @@ static const struct attribute_group adis16130_attribute_group = {
 	.attrs = adis16130_attributes,
 };
 
+static const struct iio_info adis16130_info = {
+	.attrs = &adis16130_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
 static int __devinit adis16130_probe(struct spi_device *spi)
 {
 	int ret;
@@ -196,9 +201,8 @@ static int __devinit adis16130_probe(struct spi_device *spi)
 
 	st->indio_dev->name = spi->dev.driver->name;
 	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->attrs = &adis16130_attribute_group;
+	st->indio_dev->info = &adis16130_info;
 	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
 	st->mode = 1;
 
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index 0eb6a87..3dc9a27 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -565,6 +565,13 @@ static const struct attribute_group adis16260_attribute_group = {
 	.attrs = adis16260_attributes,
 };
 
+static const struct iio_info adis16260_info = {
+	.attrs = &adis16260_attribute_group,
+	.read_raw = &adis16260_read_raw,
+	.write_raw = &adis16260_write_raw,
+	.driver_module = THIS_MODULE,
+};
+
 static int __devinit adis16260_probe(struct spi_device *spi)
 {
 	int ret, regdone = 0;
@@ -601,7 +608,7 @@ static int __devinit adis16260_probe(struct spi_device *spi)
 
 	st->indio_dev->name = spi_get_device_id(st->us)->name;
 	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->attrs = &adis16260_attribute_group;
+	st->indio_dev->info = &adis16260_info;
 	st->indio_dev->num_channels
 		= ARRAY_SIZE(adis16260_channels_x);
 	if (pd && pd->direction)
@@ -621,10 +628,7 @@ static int __devinit adis16260_probe(struct spi_device *spi)
 	else
 		st->indio_dev->channels = adis16260_channels_x;
 
-	st->indio_dev->read_raw = &adis16260_read_raw;
-	st->indio_dev->write_raw = &adis16260_write_raw;
 	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = adis16260_configure_ring(st->indio_dev);
diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
index 7a9d7c2..3714e4a 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450_core.c
@@ -349,6 +349,11 @@ static const struct attribute_group adxrs450_attribute_group = {
 	.attrs = adxrs450_attributes,
 };
 
+static const struct iio_info adxrs450_info = {
+	.attrs = &adxrs450_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
 static int __devinit adxrs450_probe(struct spi_device *spi)
 {
 	int ret, regdone = 0;
@@ -381,9 +386,8 @@ static int __devinit adxrs450_probe(struct spi_device *spi)
 	}
 
 	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->attrs = &adxrs450_attribute_group;
+	st->indio_dev->info = &adxrs450_info;
 	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(st->indio_dev);
diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 4dc4ff0..38f1425 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -202,6 +202,61 @@ static inline s64 iio_get_time_ns(void)
  * call to iio_device_register. */
 #define IIO_VAL_INT 1
 #define IIO_VAL_INT_PLUS_MICRO 2
+
+/**
+ * struct iio_info - constant information about device
+ * @driver_module:	module structure used to ensure correct
+ *			ownership of chrdevs etc
+ * @num_interrupt_lines:number of physical interrupt lines from device
+ * @event_attrs:	event control attributes
+ * @attrs:		general purpose device attributes
+ * @read_raw:		function to request a value from the device.
+ *			mask specifies which value. Note 0 means a reading of
+ *			the channel in question.  Return value will specify the
+ *			type of value returned by the device. val and val2 will
+ *			contain the elements making up the returned value.
+ * @write_raw:		function to write a value to the device.
+ *			Parameters are the same as for read_raw.
+ * @read_event_config:	find out if the event is enabled.
+ * @write_event_config:	set if the event is enabled.
+ * @read_event_value:	read a value associated with the event. Meaning
+ *			is event dependant. event_code specifies which event.
+ * @write_event_value:	write the value associate with the event.
+ *			Meaning is event dependent.
+ **/
+struct iio_info {
+	struct module			*driver_module;
+	int				num_interrupt_lines;
+	struct attribute_group		*event_attrs;
+	const struct attribute_group	*attrs;
+
+	int (*read_raw)(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *chan,
+			int *val,
+			int *val2,
+			long mask);
+
+	int (*write_raw)(struct iio_dev *indio_dev,
+			 struct iio_chan_spec const *chan,
+			 int val,
+			 int val2,
+			 long mask);
+
+	int (*read_event_config)(struct iio_dev *indio_dev,
+				 int event_code);
+
+	int (*write_event_config)(struct iio_dev *indio_dev,
+				  int event_code,
+				  int state);
+
+	int (*read_event_value)(struct iio_dev *indio_dev,
+				int event_code,
+				int *val);
+	int (*write_event_value)(struct iio_dev *indio_dev,
+				 int event_code,
+				 int val);
+};
+
 /**
  * struct iio_dev - industrial I/O device
  * @id:			[INTERN] used to identify device internally
@@ -210,11 +265,6 @@ static inline s64 iio_get_time_ns(void)
  * @currentmode:	[DRIVER] current operating mode
  * @dev:		[DRIVER] device structure, should be assigned a parent
  *			and owner
- * @attrs:		[DRIVER] general purpose device attributes
- * @driver_module:	[DRIVER] module structure used to ensure correct
- *			ownership of chrdevs etc
- * @num_interrupt_lines:[DRIVER] number of physical interrupt lines from device
- * @event_attrs:	[DRIVER] event control attributes
  * @event_interfaces:	[INTERN] event chrdevs associated with interrupt lines
  * @ring:		[DRIVER] any ring buffer present
  * @mlock:		[INTERN] lock used to prevent simultaneous device state
@@ -227,19 +277,6 @@ static inline s64 iio_get_time_ns(void)
  * @channel_attr_list:	[INTERN] keep track of automatically created channel
  *			attributes.
  * @name:		[DRIVER] name of the device.
- * @read_raw:		[DRIVER] function to request a value from the device.
- *			mask specifies which value. Note 0 means a reading of
- *			the channel in question.  Return value will specify the
- *			type of value returned by the device. val and val2 will
- *			contain the elements making up the returned value.
- * @write_raw:		[DRIVER] function to write a value to the device.
- *			Parameters are the same as for read_raw.
- * @read_event_config:	[DRIVER] find out if the event is enabled.
- * @write_event_config:	[DRIVER] set if the event is enabled.
- * @read_event_value:	[DRIVER] read a value associated with the event. Meaning
- *			is event dependant. event_code specifies which event.
- * @write_event_value:	[DRIVER] write the value associate with the event.
- *			Meaning is event dependent.
  **/
 struct iio_dev {
 	int				id;
@@ -247,11 +284,7 @@ struct iio_dev {
 	int				modes;
 	int				currentmode;
 	struct device			dev;
-	const struct attribute_group	*attrs;
-	struct module			*driver_module;
 
-	int				num_interrupt_lines;
-	struct attribute_group		*event_attrs;
 	struct iio_event_interface	*event_interfaces;
 
 	struct iio_ring_buffer		*ring;
@@ -263,34 +296,10 @@ struct iio_dev {
 
 	struct iio_chan_spec const *channels;
 	int num_channels;
-	struct list_head channel_attr_list;
 
+	struct list_head channel_attr_list;
 	const char *name;
-	int (*read_raw)(struct iio_dev *indio_dev,
-			struct iio_chan_spec const *chan,
-			int *val,
-			int *val2,
-			long mask);
-
-	int (*write_raw)(struct iio_dev *indio_dev,
-			 struct iio_chan_spec const *chan,
-			 int val,
-			 int val2,
-			 long mask);
-
-	int (*read_event_config)(struct iio_dev *indio_dev,
-				 int event_code);
-
-	int (*write_event_config)(struct iio_dev *indio_dev,
-				  int event_code,
-				  int state);
-
-	int (*read_event_value)(struct iio_dev *indio_dev,
-				int event_code,
-				int *val);
-	int (*write_event_value)(struct iio_dev *indio_dev,
-				 int event_code,
-				 int val);
+	const struct iio_info *info;
 };
 
 /**
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 0067bc7..fe89802 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -770,7 +770,12 @@ static struct adis16400_chip_info adis16400_chips[] = {
 	}
 };
 
-
+static const struct iio_info adis16400_info = {
+	.driver_module = THIS_MODULE,
+	.read_raw = &adis16400_read_raw,
+	.write_raw = &adis16400_write_raw,
+	.attrs = &adis16400_attribute_group,
+};
 
 static int __devinit adis16400_probe(struct spi_device *spi)
 {
@@ -792,12 +797,9 @@ static int __devinit adis16400_probe(struct spi_device *spi)
 	st->variant = &adis16400_chips[spi_get_device_id(spi)->driver_data];
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->name = spi_get_device_id(spi)->name;
-	indio_dev->attrs = &adis16400_attribute_group;
 	indio_dev->channels = st->variant->channels;
 	indio_dev->num_channels = st->variant->num_channels;
-	indio_dev->read_raw = &adis16400_read_raw;
-	indio_dev->write_raw = &adis16400_write_raw;
-	indio_dev->driver_module = THIS_MODULE;
+	indio_dev->info = &adis16400_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = adis16400_configure_ring(indio_dev);
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 9218fee..94d3bfa 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -383,8 +383,8 @@ static ssize_t iio_read_channel_info(struct device *dev,
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int val, val2;
-	int ret = indio_dev->read_raw(indio_dev, this_attr->c,
-				      &val, &val2, this_attr->address);
+	int ret = indio_dev->info->read_raw(indio_dev, this_attr->c,
+					    &val, &val2, this_attr->address);
 
 	if (ret < 0)
 		return ret;
@@ -411,7 +411,7 @@ static ssize_t iio_write_channel_info(struct device *dev,
 	bool integer_part = true, negative = false;
 
 	/* Assumes decimal - precision based on number of digits */
-	if (!indio_dev->write_raw)
+	if (!indio_dev->info->write_raw)
 		return -EINVAL;
 	if (buf[0] == '-') {
 		negative = true;
@@ -446,8 +446,8 @@ static ssize_t iio_write_channel_info(struct device *dev,
 			micro = -micro;
 	}
 
-	ret = indio_dev->write_raw(indio_dev, this_attr->c,
-				       integer, micro, this_attr->address);
+	ret = indio_dev->info->write_raw(indio_dev, this_attr->c,
+					 integer, micro, this_attr->address);
 	if (ret)
 		return ret;
 
@@ -707,8 +707,9 @@ static int iio_device_register_sysfs(struct iio_dev *dev_info)
 	int i, ret = 0;
 	struct iio_dev_attr *p, *n;
 
-	if (dev_info->attrs) {
-		ret = sysfs_create_group(&dev_info->dev.kobj, dev_info->attrs);
+	if (dev_info->info->attrs) {
+		ret = sysfs_create_group(&dev_info->dev.kobj,
+					 dev_info->info->attrs);
 		if (ret) {
 			dev_err(dev_info->dev.parent,
 				"Failed to register sysfs hooks\n");
@@ -744,8 +745,8 @@ error_clear_attrs:
 		list_del(&p->l);
 		iio_device_remove_and_free_read_attr(dev_info, p);
 	}
-	if (dev_info->attrs)
-		sysfs_remove_group(&dev_info->dev.kobj, dev_info->attrs);
+	if (dev_info->info->attrs)
+		sysfs_remove_group(&dev_info->dev.kobj, dev_info->info->attrs);
 error_ret:
 	return ret;
 
@@ -764,8 +765,8 @@ static void iio_device_unregister_sysfs(struct iio_dev *dev_info)
 		iio_device_remove_and_free_read_attr(dev_info, p);
 	}
 
-	if (dev_info->attrs)
-		sysfs_remove_group(&dev_info->dev.kobj, dev_info->attrs);
+	if (dev_info->info->attrs)
+		sysfs_remove_group(&dev_info->dev.kobj, dev_info->info->attrs);
 }
 
 /* Return a negative errno on failure */
@@ -824,8 +825,9 @@ static ssize_t iio_ev_state_store(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	ret = indio_dev->write_event_config(indio_dev, this_attr->address,
-					    val);
+	ret = indio_dev->info->write_event_config(indio_dev,
+						  this_attr->address,
+						  val);
 	return (ret < 0) ? ret : len;
 }
 
@@ -835,7 +837,8 @@ static ssize_t iio_ev_state_show(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	int val = indio_dev->read_event_config(indio_dev, this_attr->address);
+	int val = indio_dev->info->read_event_config(indio_dev,
+						     this_attr->address);
 
 	if (val < 0)
 		return val;
@@ -851,8 +854,8 @@ static ssize_t iio_ev_value_show(struct device *dev,
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int val, ret;
 
-	ret = indio_dev->read_event_value(indio_dev,
-					  this_attr->address, &val);
+	ret = indio_dev->info->read_event_value(indio_dev,
+						this_attr->address, &val);
 	if (ret < 0)
 		return ret;
 
@@ -873,8 +876,8 @@ static ssize_t iio_ev_value_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	ret = indio_dev->write_event_value(indio_dev, this_attr->address,
-					   val);
+	ret = indio_dev->info->write_event_value(indio_dev, this_attr->address,
+						 val);
 	if (ret < 0)
 		return ret;
 
@@ -930,8 +933,7 @@ static int iio_device_add_event_sysfs(struct iio_dev *dev_info,
 					       extending the bitmask - but
 					       how far*/
 					     0,
-					     &dev_info->event_interfaces[0]
-					     .dev,
+					     &dev_info->event_interfaces[0].dev,
 					     &dev_info->event_interfaces[0].
 					     dev_attr_list);
 		kfree(postfix);
@@ -1015,23 +1017,23 @@ static int iio_device_register_eventset(struct iio_dev *dev_info)
 {
 	int ret = 0, i, j;
 
-	if (dev_info->num_interrupt_lines == 0)
+	if (dev_info->info->num_interrupt_lines == 0)
 		return 0;
 
 	dev_info->event_interfaces =
 		kzalloc(sizeof(struct iio_event_interface)
-			*dev_info->num_interrupt_lines,
+			*dev_info->info->num_interrupt_lines,
 			GFP_KERNEL);
 	if (dev_info->event_interfaces == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
 
-	for (i = 0; i < dev_info->num_interrupt_lines; i++) {
+	for (i = 0; i < dev_info->info->num_interrupt_lines; i++) {
 		ret = iio_setup_ev_int(&dev_info->event_interfaces[i],
 				       dev_name(&dev_info->dev),
 				       i,
-				       dev_info->driver_module,
+				       dev_info->info->driver_module,
 				       &dev_info->dev);
 		if (ret) {
 			dev_err(&dev_info->dev,
@@ -1042,11 +1044,12 @@ static int iio_device_register_eventset(struct iio_dev *dev_info)
 		dev_set_drvdata(&dev_info->event_interfaces[i].dev,
 				(void *)dev_info);
 
-		if (dev_info->event_attrs != NULL)
+		if (dev_info->info->event_attrs != NULL)
 			ret = sysfs_create_group(&dev_info
 						 ->event_interfaces[i]
 						 .dev.kobj,
-						 &dev_info->event_attrs[i]);
+						 &dev_info->info
+						 ->event_attrs[i]);
 
 		if (ret) {
 			dev_err(&dev_info->dev,
@@ -1055,7 +1058,7 @@ static int iio_device_register_eventset(struct iio_dev *dev_info)
 		}
 	}
 
-	for (i = 0; i < dev_info->num_interrupt_lines; i++) {
+	for (i = 0; i < dev_info->info->num_interrupt_lines; i++) {
 		ret = __iio_add_event_config_attrs(dev_info, i);
 		if (ret)
 			goto error_unregister_config_attrs;
@@ -1066,13 +1069,13 @@ static int iio_device_register_eventset(struct iio_dev *dev_info)
 error_unregister_config_attrs:
 	for (j = 0; j < i; j++)
 		__iio_remove_event_config_attrs(dev_info, i);
-	i = dev_info->num_interrupt_lines - 1;
+	i = dev_info->info->num_interrupt_lines - 1;
 error_remove_sysfs_interfaces:
 	for (j = 0; j < i; j++)
-		if (dev_info->event_attrs != NULL)
+		if (dev_info->info->event_attrs != NULL)
 			sysfs_remove_group(&dev_info
 				   ->event_interfaces[j].dev.kobj,
-				   &dev_info->event_attrs[j]);
+				   &dev_info->info->event_attrs[j]);
 error_free_setup_ev_ints:
 	for (j = 0; j < i; j++)
 		iio_free_ev_int(&dev_info->event_interfaces[j]);
@@ -1086,17 +1089,17 @@ static void iio_device_unregister_eventset(struct iio_dev *dev_info)
 {
 	int i;
 
-	if (dev_info->num_interrupt_lines == 0)
+	if (dev_info->info->num_interrupt_lines == 0)
 		return;
-	for (i = 0; i < dev_info->num_interrupt_lines; i++) {
+	for (i = 0; i < dev_info->info->num_interrupt_lines; i++) {
 		__iio_remove_event_config_attrs(dev_info, i);
-		if (dev_info->event_attrs != NULL)
+		if (dev_info->info->event_attrs != NULL)
 			sysfs_remove_group(&dev_info
 					   ->event_interfaces[i].dev.kobj,
-					   &dev_info->event_attrs[i]);
+					   &dev_info->info->event_attrs[i]);
 	}
 
-	for (i = 0; i < dev_info->num_interrupt_lines; i++)
+	for (i = 0; i < dev_info->info->num_interrupt_lines; i++)
 		iio_free_ev_int(&dev_info->event_interfaces[i]);
 	kfree(dev_info->event_interfaces);
 }
diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 307c664..4794ffd 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -455,6 +455,11 @@ static int isl29018_chip_init(struct i2c_client *client)
 	return 0;
 }
 
+static const struct iio_info isl29108_info = {
+	.attrs = &isl29108_group,
+	.driver_module = THIS_MODULE,
+};
+
 static int __devinit isl29018_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -485,11 +490,10 @@ static int __devinit isl29018_probe(struct i2c_client *client,
 		dev_err(&client->dev, "iio allocation fails\n");
 		goto exit_free;
 	}
-	chip->indio_dev->attrs = &isl29108_group;
+	chip->indio_dev->info = &isl29108_info;
 	chip->indio_dev->name = id->name;
 	chip->indio_dev->dev.parent = &client->dev;
 	chip->indio_dev->dev_data = (void *)(chip);
-	chip->indio_dev->driver_module = THIS_MODULE;
 	chip->indio_dev->modes = INDIO_DIRECT_MODE;
 	err = iio_device_register(chip->indio_dev);
 	if (err) {
diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index ded3053..9cffa2e 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -688,6 +688,21 @@ error_ret:
 /*--------------------------------------------------------------*/
 static struct i2c_driver tsl2563_i2c_driver;
 
+static const struct iio_info tsl2563_info_no_irq = {
+	.driver_module = THIS_MODULE,
+};
+
+static const struct iio_info tsl2563_info = {
+	.driver_module = THIS_MODULE,
+	.num_interrupt_lines = 1,
+	.read_raw = &tsl2563_read_raw,
+	.write_raw = &tsl2563_write_raw,
+	.read_event_value = &tsl2563_read_thresh,
+	.write_event_value = &tsl2563_write_thresh,
+	.read_event_config = &tsl2563_read_interrupt_config,
+	.write_event_config = &tsl2563_write_interrupt_config,
+};
+
 static int __devinit tsl2563_probe(struct i2c_client *client,
 				const struct i2c_device_id *device_id)
 {
@@ -736,17 +751,12 @@ static int __devinit tsl2563_probe(struct i2c_client *client,
 	indio_dev->name = client->name;
 	indio_dev->channels = tsl2563_channels;
 	indio_dev->num_channels = ARRAY_SIZE(tsl2563_channels);
-	indio_dev->read_raw = &tsl2563_read_raw;
-	indio_dev->write_raw = &tsl2563_write_raw;
-	indio_dev->read_event_value = &tsl2563_read_thresh;
-	indio_dev->write_event_value = &tsl2563_write_thresh;
-	indio_dev->read_event_config = &tsl2563_read_interrupt_config;
-	indio_dev->write_event_config = &tsl2563_write_interrupt_config;
 	indio_dev->dev.parent = &client->dev;
-	indio_dev->driver_module = THIS_MODULE;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	if (client->irq)
-		indio_dev->num_interrupt_lines = 1;
+		indio_dev->info = &tsl2563_info;
+	else
+		indio_dev->info = &tsl2563_info_no_irq;
 	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto fail1;
diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index b87ccd5..5694610 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -786,6 +786,11 @@ static int taos_tsl258x_device(unsigned char *bufp)
 	return ((bufp[TSL258X_CHIPID] & 0xf0) == 0x90);
 }
 
+static const struct iio_info tsl2583_info = {
+	.attrs = &tsl2583_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
 /*
  * Client probe function - When a valid device is found, the driver's device
  * data structure is updated, and initialization completes successfully.
@@ -854,10 +859,9 @@ static int __devinit taos_probe(struct i2c_client *clientp,
 		goto fail1;
 	}
 
-	chip->iio_dev->attrs = &tsl2583_attribute_group;
+	chip->iio_dev->info = &tsl2583_info;
 	chip->iio_dev->dev.parent = &clientp->dev;
 	chip->iio_dev->dev_data = (void *)(chip);
-	chip->iio_dev->driver_module = THIS_MODULE;
 	chip->iio_dev->modes = INDIO_DIRECT_MODE;
 	ret = iio_device_register(chip->iio_dev);
 	if (ret) {
diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
index 2226b88..700f96c 100644
--- a/drivers/staging/iio/magnetometer/ak8975.c
+++ b/drivers/staging/iio/magnetometer/ak8975.c
@@ -474,6 +474,11 @@ static struct attribute_group ak8975_attr_group = {
 	.attrs = ak8975_attr,
 };
 
+static const struct iio_info ak8975_info = {
+	.attrs = &ak8975_attr_group,
+	.driver_module = THIS_MODULE,
+};
+
 static int ak8975_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -533,9 +538,8 @@ static int ak8975_probe(struct i2c_client *client,
 	}
 
 	data->indio_dev->dev.parent = &client->dev;
-	data->indio_dev->attrs = &ak8975_attr_group;
+	data->indio_dev->info = &ak8975_info;
 	data->indio_dev->dev_data = (void *)(data);
-	data->indio_dev->driver_module = THIS_MODULE;
 	data->indio_dev->modes = INDIO_DIRECT_MODE;
 
 	err = iio_device_register(data->indio_dev);
diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index d0676e9..dd9a3bb 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -529,6 +529,11 @@ static void hmc5843_init_client(struct i2c_client *client)
 	pr_info("HMC5843 initialized\n");
 }
 
+static const struct iio_info hmc5843_info = {
+	.attrs = &hmc5843_group,
+	.driver_module = THIS_MODULE,
+};
+
 static int hmc5843_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -557,10 +562,9 @@ static int hmc5843_probe(struct i2c_client *client,
 		err = -ENOMEM;
 		goto exit_free1;
 	}
-	data->indio_dev->attrs = &hmc5843_group;
+	data->indio_dev->info = &hmc5843_info;
 	data->indio_dev->dev.parent = &client->dev;
 	data->indio_dev->dev_data = (void *)(data);
-	data->indio_dev->driver_module = THIS_MODULE;
 	data->indio_dev->modes = INDIO_DIRECT_MODE;
 	err = iio_device_register(data->indio_dev);
 	if (err)
diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
index 8b6bf50..6c9c23f 100644
--- a/drivers/staging/iio/meter/ade7753.c
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -504,6 +504,11 @@ static const struct attribute_group ade7753_attribute_group = {
 	.attrs = ade7753_attributes,
 };
 
+static const struct iio_info ade7753_info = {
+	.attrs = &ade7753_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
 static int __devinit ade7753_probe(struct spi_device *spi)
 {
 	int ret, regdone = 0;
@@ -537,9 +542,8 @@ static int __devinit ade7753_probe(struct spi_device *spi)
 
 	st->indio_dev->name = spi->dev.driver->name;
 	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->attrs = &ade7753_attribute_group;
+	st->indio_dev->info = &ade7753_info;
 	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(st->indio_dev);
diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
index 4179325..378f2c8 100644
--- a/drivers/staging/iio/meter/ade7754.c
+++ b/drivers/staging/iio/meter/ade7754.c
@@ -527,7 +527,10 @@ static const struct attribute_group ade7754_attribute_group = {
 	.attrs = ade7754_attributes,
 };
 
-
+static const struct iio_info ade7754_info = {
+	.attrs = &ade7754_attribute_group,
+	.driver_module = THIS_MODULE,
+};
 
 static int __devinit ade7754_probe(struct spi_device *spi)
 {
@@ -562,9 +565,8 @@ static int __devinit ade7754_probe(struct spi_device *spi)
 
 	st->indio_dev->name = spi->dev.driver->name;
 	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->attrs = &ade7754_attribute_group;
+	st->indio_dev->info = &ade7754_info;
 	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(st->indio_dev);
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index d9dfd83..299b954 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -725,6 +725,11 @@ static struct iio_chan_spec ade7758_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(15),
 };
 
+static const struct iio_info ade7758_info = {
+	.attrs = &ade7758_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
 static int __devinit ade7758_probe(struct spi_device *spi)
 {
 	int i, ret, regdone = 0;
@@ -757,8 +762,7 @@ static int __devinit ade7758_probe(struct spi_device *spi)
 
 	indio_dev->name = spi->dev.driver->name;
 	indio_dev->dev.parent = &spi->dev;
-	indio_dev->attrs = &ade7758_attribute_group;
-	indio_dev->driver_module = THIS_MODULE;
+	indio_dev->info = &ade7758_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	for (i = 0; i < AD7758_NUM_WAVESRC; i++)
diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index 86fe0ae..730f6d9 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -450,6 +450,11 @@ static const struct attribute_group ade7759_attribute_group = {
 	.attrs = ade7759_attributes,
 };
 
+static const struct iio_info ade7759_info = {
+	.attrs = &ade7759_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
 static int __devinit ade7759_probe(struct spi_device *spi)
 {
 	int ret;
@@ -483,11 +488,9 @@ static int __devinit ade7759_probe(struct spi_device *spi)
 
 	st->indio_dev->name = spi->dev.driver->name;
 	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->num_interrupt_lines = 1;
 
-	st->indio_dev->attrs = &ade7759_attribute_group;
+	st->indio_dev->info = &ade7759_info;
 	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(st->indio_dev);
diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
index d3f1df7..44cd3ec 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -551,6 +551,11 @@ static const struct attribute_group ade7854_attribute_group = {
 	.attrs = ade7854_attributes,
 };
 
+static const struct iio_info ade7854_info = {
+	.attrs = &ade7854_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
 int ade7854_probe(struct ade7854_state *st, struct device *dev)
 {
 	int ret;
@@ -575,9 +580,8 @@ int ade7854_probe(struct ade7854_state *st, struct device *dev)
 	}
 
 	st->indio_dev->dev.parent = dev;
-	st->indio_dev->attrs = &ade7854_attribute_group;
+	st->indio_dev->info = &ade7854_info;
 	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(st->indio_dev);
diff --git a/drivers/staging/iio/resolver/ad2s120x.c b/drivers/staging/iio/resolver/ad2s120x.c
index e0237ff..f83e142 100644
--- a/drivers/staging/iio/resolver/ad2s120x.c
+++ b/drivers/staging/iio/resolver/ad2s120x.c
@@ -209,10 +209,14 @@ static struct attribute *ad2s120x_attributes[] = {
 };
 
 static const struct attribute_group ad2s120x_attribute_group = {
-	.name = DRV_NAME,
 	.attrs = ad2s120x_attributes,
 };
 
+static const struct iio_info ad2s120x_info = {
+	.attrs = &ad2s120x_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
 static int __devinit ad2s120x_probe(struct spi_device *spi)
 {
 	struct ad2s120x_state *st;
@@ -246,12 +250,9 @@ static int __devinit ad2s120x_probe(struct spi_device *spi)
 		goto error_free_st;
 	}
 	st->idev->dev.parent = &spi->dev;
-	st->idev->num_interrupt_lines = 0;
-	st->idev->event_attrs = NULL;
 
-	st->idev->attrs = &ad2s120x_attribute_group;
+	st->idev->info = &ad2s120x_info;
 	st->idev->dev_data = (void *)(st);
-	st->idev->driver_module = THIS_MODULE;
 	st->idev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(st->idev);
diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index dc7cae8..09f4fcf 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -755,6 +755,11 @@ error_ret:
 	return ret;
 }
 
+static const struct iio_info ad2s1210_info = {
+	.attrs = &ad2s1210_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
 static int __devinit ad2s1210_probe(struct spi_device *spi)
 {
 	struct ad2s1210_state *st;
@@ -806,12 +811,9 @@ static int __devinit ad2s1210_probe(struct spi_device *spi)
 		goto error_free_st;
 	}
 	st->idev->dev.parent = &spi->dev;
-	st->idev->num_interrupt_lines = 0;
-	st->idev->event_attrs = NULL;
 
-	st->idev->attrs = &ad2s1210_attribute_group;
+	st->idev->info = &ad2s1210_info;
 	st->idev->dev_data = (void *)(st);
-	st->idev->driver_module = THIS_MODULE;
 	st->idev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(st->idev);
diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index e300ade..9b72a95 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -75,6 +75,11 @@ static const struct attribute_group ad2s90_attribute_group = {
 	.attrs = ad2s90_attributes,
 };
 
+static const struct iio_info ad2s90_info = {
+	.attrs = &ad2s90_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
 static int __devinit ad2s90_probe(struct spi_device *spi)
 {
 	struct ad2s90_state *st;
@@ -96,12 +101,9 @@ static int __devinit ad2s90_probe(struct spi_device *spi)
 		goto error_free_st;
 	}
 	st->idev->dev.parent = &spi->dev;
-	st->idev->num_interrupt_lines = 0;
-	st->idev->event_attrs = NULL;
 
-	st->idev->attrs = &ad2s90_attribute_group;
+	st->idev->info = &ad2s90_info;
 	st->idev->dev_data = (void *)(st);
-	st->idev->driver_module = THIS_MODULE;
 	st->idev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(st->idev);
-- 
1.7.3.4
