Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de,
	Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 54/99] staging:iio: use the new central name attribute creation code
Date: Wed,  4 May 2011 12:58:26 +0100
Message-Id: <1304510351-10922-55-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16201_core.c |    4 +--
 drivers/staging/iio/accel/adis16203_core.c |    5 +---
 drivers/staging/iio/accel/adis16204_core.c |    4 +--
 drivers/staging/iio/accel/adis16209_core.c |    4 +--
 drivers/staging/iio/accel/adis16220_core.c |    4 +--
 drivers/staging/iio/accel/adis16240_core.c |    4 +--
 drivers/staging/iio/accel/lis3l02dq_core.c |    4 +--
 drivers/staging/iio/accel/sca3000.h        |    2 -
 drivers/staging/iio/accel/sca3000_core.c   |   28 +++++++----------------
 drivers/staging/iio/adc/ad7150.c           |   15 +------------
 drivers/staging/iio/adc/ad7152.c           |   15 +------------
 drivers/staging/iio/adc/ad7291.c           |   17 +-------------
 drivers/staging/iio/adc/ad7298_core.c      |   13 +----------
 drivers/staging/iio/adc/ad7314.c           |   19 ++--------------
 drivers/staging/iio/adc/ad7476_core.c      |   22 +------------------
 drivers/staging/iio/adc/ad7745.c           |   15 +------------
 drivers/staging/iio/adc/ad7780.c           |   13 +----------
 drivers/staging/iio/adc/ad7816.c           |   32 +++++++--------------------
 drivers/staging/iio/adc/ad7887_core.c      |   13 +----------
 drivers/staging/iio/adc/ad799x_core.c      |   14 ------------
 drivers/staging/iio/adc/adt7310.c          |   21 +++--------------
 drivers/staging/iio/adc/adt7410.c          |   20 ++--------------
 drivers/staging/iio/adc/adt75.c            |   19 ++--------------
 drivers/staging/iio/adc/max1363_core.c     |   21 +-----------------
 drivers/staging/iio/addac/adt7316.c        |   21 ++---------------
 drivers/staging/iio/dac/ad5446.c           |   13 +----------
 drivers/staging/iio/dac/ad5504.c           |   15 +------------
 drivers/staging/iio/dac/ad5624r_spi.c      |   13 +----------
 drivers/staging/iio/dds/ad9832.c           |   13 +----------
 drivers/staging/iio/dds/ad9834.c           |   13 +----------
 drivers/staging/iio/gyro/adis16080_core.c  |    3 +-
 drivers/staging/iio/gyro/adis16130_core.c  |    4 +--
 drivers/staging/iio/gyro/adis16260_core.c  |    4 +--
 drivers/staging/iio/imu/adis16400_core.c   |   12 +---------
 drivers/staging/iio/light/isl29018.c       |   13 +----------
 drivers/staging/iio/meter/ade7753.c        |    4 +--
 drivers/staging/iio/meter/ade7754.c        |    4 +--
 drivers/staging/iio/meter/ade7758_core.c   |    4 +--
 drivers/staging/iio/meter/ade7759.c        |    4 +--
 drivers/staging/iio/sysfs.h                |    7 ------
 40 files changed, 65 insertions(+), 410 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
index 08e42f4..f45eb8f 100644
--- a/drivers/staging/iio/accel/adis16201_core.c
+++ b/drivers/staging/iio/accel/adis16201_core.c
@@ -477,8 +477,6 @@ static IIO_CONST_ATTR(temp_scale, "-0.47");
 
 static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16201_write_reset, 0);
 
-static IIO_CONST_ATTR(name, "adis16201");
-
 static struct attribute *adis16201_attributes[] = {
 	&iio_dev_attr_in0_supply_raw.dev_attr.attr,
 	&iio_const_attr_in0_supply_scale.dev_attr.attr,
@@ -486,7 +484,6 @@ static struct attribute *adis16201_attributes[] = {
 	&iio_const_attr_temp_offset.dev_attr.attr,
 	&iio_const_attr_temp_scale.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
-	&iio_const_attr_name.dev_attr.attr,
 	&iio_dev_attr_in1_raw.dev_attr.attr,
 	&iio_const_attr_in1_scale.dev_attr.attr,
 	&iio_dev_attr_accel_x_raw.dev_attr.attr,
@@ -537,6 +534,7 @@ static int __devinit adis16201_probe(struct spi_device *spi)
 		goto error_free_tx;
 	}
 
+	st->indio_dev->name = spi->dev.driver->name;
 	st->indio_dev->dev.parent = &spi->dev;
 	st->indio_dev->attrs = &adis16201_attribute_group;
 	st->indio_dev->dev_data = (void *)(st);
diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index 4043a97..6162311 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -392,8 +392,6 @@ static IIO_CONST_ATTR(temp_scale, "-0.47");
 
 static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16203_write_reset, 0);
 
-static IIO_CONST_ATTR(name, "adis16203");
-
 static struct attribute *adis16203_attributes[] = {
 	&iio_dev_attr_in0_supply_raw.dev_attr.attr,
 	&iio_const_attr_in0_supply_scale.dev_attr.attr,
@@ -401,7 +399,6 @@ static struct attribute *adis16203_attributes[] = {
 	&iio_const_attr_temp_offset.dev_attr.attr,
 	&iio_const_attr_temp_scale.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
-	&iio_const_attr_name.dev_attr.attr,
 	&iio_dev_attr_in1_raw.dev_attr.attr,
 	&iio_const_attr_in1_scale.dev_attr.attr,
 	&iio_dev_attr_incli_x_raw.dev_attr.attr,
@@ -445,7 +442,7 @@ static int __devinit adis16203_probe(struct spi_device *spi)
 		ret = -ENOMEM;
 		goto error_free_tx;
 	}
-
+	st->indio_dev->name = spi->dev.driver->name;
 	st->indio_dev->dev.parent = &spi->dev;
 	st->indio_dev->attrs = &adis16203_attribute_group;
 	st->indio_dev->dev_data = (void *)(st);
diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index fe44b25..a9c890d 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -430,8 +430,6 @@ static IIO_CONST_ATTR(temp_scale, "-0.47");
 
 static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16204_write_reset, 0);
 
-static IIO_CONST_ATTR(name, "adis16204");
-
 static struct attribute *adis16204_attributes[] = {
 	&iio_dev_attr_in0_supply_raw.dev_attr.attr,
 	&iio_const_attr_in0_supply_scale.dev_attr.attr,
@@ -439,7 +437,6 @@ static struct attribute *adis16204_attributes[] = {
 	&iio_const_attr_temp_offset.dev_attr.attr,
 	&iio_const_attr_temp_scale.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
-	&iio_const_attr_name.dev_attr.attr,
 	&iio_dev_attr_in1_raw.dev_attr.attr,
 	&iio_const_attr_in1_scale.dev_attr.attr,
 	&iio_dev_attr_accel_x_raw.dev_attr.attr,
@@ -491,6 +488,7 @@ static int __devinit adis16204_probe(struct spi_device *spi)
 		goto error_free_tx;
 	}
 
+	st->indio_dev->name = spi->dev.driver->name;
 	st->indio_dev->dev.parent = &spi->dev;
 	st->indio_dev->attrs = &adis16204_attribute_group;
 	st->indio_dev->dev_data = (void *)(st);
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index 54b5bae..fa0a3ad 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -427,8 +427,6 @@ static IIO_CONST_ATTR_TEMP_SCALE("-0.47");
 
 static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16209_write_reset, 0);
 
-static IIO_CONST_ATTR_NAME("adis16209");
-
 static struct attribute *adis16209_attributes[] = {
 	&iio_dev_attr_in0_supply_raw.dev_attr.attr,
 	&iio_const_attr_in0_supply_scale.dev_attr.attr,
@@ -436,7 +434,6 @@ static struct attribute *adis16209_attributes[] = {
 	&iio_const_attr_temp_offset.dev_attr.attr,
 	&iio_const_attr_temp_scale.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
-	&iio_const_attr_name.dev_attr.attr,
 	&iio_dev_attr_in1_raw.dev_attr.attr,
 	&iio_const_attr_in1_scale.dev_attr.attr,
 	&iio_dev_attr_accel_x_raw.dev_attr.attr,
@@ -486,6 +483,7 @@ static int __devinit adis16209_probe(struct spi_device *spi)
 		goto error_free_tx;
 	}
 
+	st->indio_dev->name = spi->dev.driver->name;
 	st->indio_dev->dev.parent = &spi->dev;
 	st->indio_dev->attrs = &adis16209_attribute_group;
 	st->indio_dev->dev_data = (void *)(st);
diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
index 0689e41..7af48b8 100644
--- a/drivers/staging/iio/accel/adis16220_core.c
+++ b/drivers/staging/iio/accel/adis16220_core.c
@@ -521,8 +521,6 @@ static IIO_DEV_ATTR_CAPTURE_COUNT(S_IWUSR | S_IRUGO,
 
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("100200");
 
-static IIO_CONST_ATTR_NAME("adis16220");
-
 static struct attribute *adis16220_attributes[] = {
 	&iio_dev_attr_in0_supply_raw.dev_attr.attr,
 	&iio_const_attr_in0_supply_scale.dev_attr.attr,
@@ -539,7 +537,6 @@ static struct attribute *adis16220_attributes[] = {
 	&iio_dev_attr_reset.dev_attr.attr,
 	&iio_dev_attr_capture.dev_attr.attr,
 	&iio_dev_attr_capture_count.dev_attr.attr,
-	&iio_const_attr_name.dev_attr.attr,
 	NULL
 };
 
@@ -578,6 +575,7 @@ static int __devinit adis16220_probe(struct spi_device *spi)
 		goto error_free_tx;
 	}
 
+	st->indio_dev->name = spi->dev.driver->name;
 	st->indio_dev->dev.parent = &spi->dev;
 	st->indio_dev->attrs = &adis16220_attribute_group;
 	st->indio_dev->dev_data = (void *)(st);
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index 89ab810..6350c7c 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -422,8 +422,6 @@ static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16240_write_reset, 0);
 
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("4096");
 
-static IIO_CONST_ATTR_NAME("adis16240");
-
 static struct attribute *adis16240_attributes[] = {
 	&iio_dev_attr_in0_supply_raw.dev_attr.attr,
 	&iio_const_attr_in0_supply_scale.dev_attr.attr,
@@ -444,7 +442,6 @@ static struct attribute *adis16240_attributes[] = {
 	&iio_const_attr_temp_scale.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
-	&iio_const_attr_name.dev_attr.attr,
 	NULL
 };
 
@@ -483,6 +480,7 @@ static int __devinit adis16240_probe(struct spi_device *spi)
 		goto error_free_tx;
 	}
 
+	st->indio_dev->name = spi->dev.driver->name;
 	st->indio_dev->dev.parent = &spi->dev;
 	st->indio_dev->attrs = &adis16240_attribute_group;
 	st->indio_dev->dev_data = (void *)(st);
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index b1fb049..a6b4631 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -644,12 +644,9 @@ error_ret:
 	return ret;
 }
 
-static IIO_CONST_ATTR_NAME("lis3l02dq");
-
 static struct attribute *lis3l02dq_attributes[] = {
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
-	&iio_const_attr_name.dev_attr.attr,
 	NULL
 };
 
@@ -689,6 +686,7 @@ static int __devinit lis3l02dq_probe(struct spi_device *spi)
 		goto error_free_tx;
 	}
 
+	st->help.indio_dev->name = spi->dev.driver->name;
 	st->help.indio_dev->dev.parent = &spi->dev;
 	st->help.indio_dev->num_interrupt_lines = 1;
 	st->help.indio_dev->channels = lis3l02dq_channels;
diff --git a/drivers/staging/iio/accel/sca3000.h b/drivers/staging/iio/accel/sca3000.h
index f77eb74..cf0751d 100644
--- a/drivers/staging/iio/accel/sca3000.h
+++ b/drivers/staging/iio/accel/sca3000.h
@@ -186,7 +186,6 @@ struct sca3000_state {
 
 /**
  * struct sca3000_chip_info - model dependent parameters
- * @name:			model identification
  * @scale:			scale * 10^-6
  * @temp_output:		some devices have temperature sensors.
  * @measurement_mode_freq:	normal mode sampling frequency
@@ -199,7 +198,6 @@ struct sca3000_state {
  * sca3000 variant.
  **/
 struct sca3000_chip_info {
-	const char		*name;
 	unsigned int		scale;
 	bool			temp_output;
 	int			measurement_mode_freq;
diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index d11fc94..5de07fd 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -40,8 +40,7 @@ enum sca3000_variant {
  * do not actually appear to be available.
  */
 static const struct sca3000_chip_info sca3000_spi_chip_info_tbl[] = {
-	{
-		.name = "sca3000-d01",
+	[d01] = {
 		.scale = 7357,
 		.temp_output = true,
 		.measurement_mode_freq = 250,
@@ -49,16 +48,16 @@ static const struct sca3000_chip_info sca3000_spi_chip_info_tbl[] = {
 		.option_mode_1_freq = 250,
 		.mot_det_mult_xz = {50, 100, 200, 350, 650, 1300},
 		.mot_det_mult_y = {50, 100, 150, 250, 450, 850, 1750},
-	}, {
-		.name = "sca3000-e02",
+	},
+	[e02] = {
 		.scale = 9810,
 		.measurement_mode_freq = 125,
 		.option_mode_1 = SCA3000_OP_MODE_NARROW,
 		.option_mode_1_freq = 63,
 		.mot_det_mult_xz = {100, 150, 300, 550, 1050, 2050},
 		.mot_det_mult_y = {50, 100, 200, 350, 700, 1350, 2700},
-	}, {
-		.name = "sca3000-e04",
+	},
+	[e04] = {
 		.scale = 19620,
 		.measurement_mode_freq = 100,
 		.option_mode_1 = SCA3000_OP_MODE_NARROW,
@@ -67,8 +66,8 @@ static const struct sca3000_chip_info sca3000_spi_chip_info_tbl[] = {
 		.option_mode_2_freq = 400,
 		.mot_det_mult_xz = {200, 300, 600, 1100, 2100, 4100},
 		.mot_det_mult_y = {100, 200, 400, 7000, 1400, 2700, 54000},
-	}, {
-		.name = "sca3000-e05",
+	},
+	[e05] = {
 		.scale = 61313,
 		.measurement_mode_freq = 200,
 		.option_mode_1 = SCA3000_OP_MODE_NARROW,
@@ -260,14 +259,7 @@ error_ret:
 }
 #endif /* SCA3000_DEBUG */
 
-static ssize_t sca3000_show_name(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct sca3000_state *st = dev_info->dev_data;
-	return sprintf(buf, "%s\n", st->info->name);
-}
+
 /**
  * sca3000_show_reg() - sysfs interface to read the chip revision number
  **/
@@ -430,7 +422,6 @@ static IIO_DEVICE_ATTR(measurement_mode, S_IRUGO | S_IWUSR,
 
 /* More standard attributes */
 
-static IIO_DEV_ATTR_NAME(sca3000_show_name);
 static IIO_DEV_ATTR_REV(sca3000_show_rev);
 
 #define SCA3000_INFO_MASK			\
@@ -765,7 +756,6 @@ static int sca3000_write_thresh(struct iio_dev *indio_dev,
 }
 
 static struct attribute *sca3000_attributes[] = {
-	&iio_dev_attr_name.dev_attr.attr,
 	&iio_dev_attr_revision.dev_attr.attr,
 	&iio_dev_attr_measurement_mode_available.dev_attr.attr,
 	&iio_dev_attr_measurement_mode.dev_attr.attr,
@@ -775,7 +765,6 @@ static struct attribute *sca3000_attributes[] = {
 };
 
 static struct attribute *sca3000_attributes_with_temp[] = {
-	&iio_dev_attr_name.dev_attr.attr,
 	&iio_dev_attr_revision.dev_attr.attr,
 	&iio_dev_attr_measurement_mode_available.dev_attr.attr,
 	&iio_dev_attr_measurement_mode.dev_attr.attr,
@@ -1134,6 +1123,7 @@ static int __devinit sca3000_probe(struct spi_device *spi)
 		goto error_clear_st;
 	}
 	st->indio_dev->dev.parent = &spi->dev;
+	st->indio_dev->name = spi_get_device_id(spi)->name;
 	st->indio_dev->num_interrupt_lines = 1;
 	st->indio_dev->event_attrs = &sca3000_event_attribute_group;
 	if (st->info->temp_output)
diff --git a/drivers/staging/iio/adc/ad7150.c b/drivers/staging/iio/adc/ad7150.c
index 6a9f326..cbd1f96 100644
--- a/drivers/staging/iio/adc/ad7150.c
+++ b/drivers/staging/iio/adc/ad7150.c
@@ -58,7 +58,6 @@
  */
 
 struct ad7150_chip_info {
-	const char *name;
 	struct i2c_client *client;
 	struct iio_dev *indio_dev;
 	bool inter;
@@ -584,17 +583,6 @@ static IIO_DEV_ATTR_CH2_SETUP(S_IRUGO | S_IWUSR,
 		ad7150_show_ch2_setup,
 		ad7150_store_ch2_setup);
 
-static ssize_t ad7150_show_name(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = dev_info->dev_data;
-	return sprintf(buf, "%s\n", chip->name);
-}
-
-static IIO_DEVICE_ATTR(name, S_IRUGO, ad7150_show_name, NULL, 0);
-
 static ssize_t ad7150_show_powerdown_timer(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
@@ -643,7 +631,6 @@ static struct attribute *ad7150_attributes[] = {
 	&iio_dev_attr_powerdown_timer.dev_attr.attr,
 	&iio_dev_attr_ch1_value.dev_attr.attr,
 	&iio_dev_attr_ch2_value.dev_attr.attr,
-	&iio_dev_attr_name.dev_attr.attr,
 	NULL,
 };
 
@@ -724,7 +711,6 @@ static int __devinit ad7150_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, chip);
 
 	chip->client = client;
-	chip->name = id->name;
 
 	chip->indio_dev = iio_allocate_device(0);
 	if (chip->indio_dev == NULL) {
@@ -733,6 +719,7 @@ static int __devinit ad7150_probe(struct i2c_client *client,
 	}
 
 	/* Echipabilish that the iio_dev is a child of the i2c device */
+	chip->indio_dev->name = id->name;
 	chip->indio_dev->dev.parent = &client->dev;
 	chip->indio_dev->attrs = &ad7150_attribute_group;
 	chip->indio_dev->event_attrs = &ad7150_event_attribute_group;
diff --git a/drivers/staging/iio/adc/ad7152.c b/drivers/staging/iio/adc/ad7152.c
index 25715f0..e53e3e9 100644
--- a/drivers/staging/iio/adc/ad7152.c
+++ b/drivers/staging/iio/adc/ad7152.c
@@ -50,7 +50,6 @@
  */
 
 struct ad7152_chip_info {
-	const char *name;
 	struct i2c_client *client;
 	struct iio_dev *indio_dev;
 	u16 ch1_offset;     /* Channel 1 offset calibration coefficient */
@@ -479,17 +478,6 @@ static IIO_DEV_ATTR_FILTER_RATE_SETUP(S_IRUGO | S_IWUSR,
 		ad7152_show_filter_rate_setup,
 		ad7152_store_filter_rate_setup);
 
-static ssize_t ad7152_show_name(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = dev_info->dev_data;
-	return sprintf(buf, "%s\n", chip->name);
-}
-
-static IIO_DEVICE_ATTR(name, S_IRUGO, ad7152_show_name, NULL, 0);
-
 static struct attribute *ad7152_attributes[] = {
 	&iio_dev_attr_available_conversion_modes.dev_attr.attr,
 	&iio_dev_attr_conversion_mode.dev_attr.attr,
@@ -502,7 +490,6 @@ static struct attribute *ad7152_attributes[] = {
 	&iio_dev_attr_ch1_setup.dev_attr.attr,
 	&iio_dev_attr_ch2_setup.dev_attr.attr,
 	&iio_dev_attr_filter_rate_setup.dev_attr.attr,
-	&iio_dev_attr_name.dev_attr.attr,
 	NULL,
 };
 
@@ -528,7 +515,6 @@ static int __devinit ad7152_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, chip);
 
 	chip->client = client;
-	chip->name = id->name;
 
 	chip->indio_dev = iio_allocate_device(0);
 	if (chip->indio_dev == NULL) {
@@ -537,6 +523,7 @@ static int __devinit ad7152_probe(struct i2c_client *client,
 	}
 
 	/* Echipabilish that the iio_dev is a child of the i2c device */
+	chip->indio_dev->name = id->name;
 	chip->indio_dev->dev.parent = &client->dev;
 	chip->indio_dev->attrs = &ad7152_attribute_group;
 	chip->indio_dev->dev_data = (void *)(chip);
diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index 23ad18e..527311c 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -60,7 +60,6 @@
  */
 
 struct ad7291_chip_info {
-	const char *name;
 	struct i2c_client *client;
 	struct iio_dev *indio_dev;
 	u16 command;
@@ -434,17 +433,6 @@ static IIO_DEVICE_ATTR(channel_mask, S_IRUGO | S_IWUSR,
 		ad7291_store_channel_mask,
 		0);
 
-static ssize_t ad7291_show_name(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7291_chip_info *chip = dev_info->dev_data;
-	return sprintf(buf, "%s\n", chip->name);
-}
-
-static IIO_DEVICE_ATTR(name, S_IRUGO, ad7291_show_name, NULL, 0);
-
 static struct attribute *ad7291_attributes[] = {
 	&iio_dev_attr_available_modes.dev_attr.attr,
 	&iio_dev_attr_mode.dev_attr.attr,
@@ -455,7 +443,6 @@ static struct attribute *ad7291_attributes[] = {
 	&iio_dev_attr_t_average.dev_attr.attr,
 	&iio_dev_attr_voltage.dev_attr.attr,
 	&iio_dev_attr_channel_mask.dev_attr.attr,
-	&iio_dev_attr_name.dev_attr.attr,
 	NULL,
 };
 
@@ -784,7 +771,6 @@ static int __devinit ad7291_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, chip);
 
 	chip->client = client;
-	chip->name = id->name;
 	chip->command = AD7291_NOISE_DELAY | AD7291_T_SENSE_MASK;
 
 	chip->indio_dev = iio_allocate_device(0);
@@ -793,6 +779,7 @@ static int __devinit ad7291_probe(struct i2c_client *client,
 		goto error_free_chip;
 	}
 
+	chip->indio_dev->name = id->name;
 	chip->indio_dev->dev.parent = &client->dev;
 	chip->indio_dev->attrs = &ad7291_attribute_group;
 	chip->indio_dev->event_attrs = &ad7291_event_attribute_group;
@@ -810,7 +797,7 @@ static int __devinit ad7291_probe(struct i2c_client *client,
 					   NULL,
 					   &ad7291_event_handler,
 					   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-					   chip->name,
+					   id->name,
 					   chip->indio_dev);
 		if (ret)
 			goto error_unreg_dev;
diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/adc/ad7298_core.c
index 40bbb42..d43f63d 100644
--- a/drivers/staging/iio/adc/ad7298_core.c
+++ b/drivers/staging/iio/adc/ad7298_core.c
@@ -118,17 +118,6 @@ static ssize_t ad7298_show_scale(struct device *dev,
 }
 static IIO_DEVICE_ATTR(in_scale, S_IRUGO, ad7298_show_scale, NULL, 0);
 
-static ssize_t ad7298_show_name(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7298_state *st = iio_dev_get_devdata(dev_info);
-
-	return sprintf(buf, "%s\n", spi_get_device_id(st->spi)->name);
-}
-static IIO_DEVICE_ATTR(name, S_IRUGO, ad7298_show_name, NULL, 0);
-
 static struct attribute *ad7298_attributes[] = {
 	&iio_dev_attr_in0_raw.dev_attr.attr,
 	&iio_dev_attr_in1_raw.dev_attr.attr,
@@ -140,7 +129,6 @@ static struct attribute *ad7298_attributes[] = {
 	&iio_dev_attr_in7_raw.dev_attr.attr,
 	&iio_dev_attr_in_scale.dev_attr.attr,
 	&iio_dev_attr_temp0_input.dev_attr.attr,
-	&iio_dev_attr_name.dev_attr.attr,
 	NULL,
 };
 
@@ -177,6 +165,7 @@ static int __devinit ad7298_probe(struct spi_device *spi)
 		goto error_disable_reg;
 	}
 
+	st->indio_dev->name = spi_get_device_id(spi)->name;
 	st->indio_dev->dev.parent = &spi->dev;
 	st->indio_dev->attrs = &ad7298_attribute_group;
 	st->indio_dev->dev_data = (void *)(st);
diff --git a/drivers/staging/iio/adc/ad7314.c b/drivers/staging/iio/adc/ad7314.c
index bc34e29..a1f1b43 100644
--- a/drivers/staging/iio/adc/ad7314.c
+++ b/drivers/staging/iio/adc/ad7314.c
@@ -42,7 +42,6 @@
  */
 
 struct ad7314_chip_info {
-	const char *name;
 	struct spi_device *spi_dev;
 	struct iio_dev *indio_dev;
 	s64 last_timestamp;
@@ -155,7 +154,7 @@ static ssize_t ad7314_show_temperature(struct device *dev,
 	if (chip->mode)
 		ad7314_spi_write(chip, chip->mode);
 
-	if (strcmp(chip->name, "ad7314")) {
+	if (strcmp(dev_info->name, "ad7314")) {
 		data = (data & AD7314_TEMP_MASK) >>
 			AD7314_TEMP_OFFSET;
 		if (data & AD7314_TEMP_SIGN) {
@@ -181,22 +180,10 @@ static ssize_t ad7314_show_temperature(struct device *dev,
 
 static IIO_DEVICE_ATTR(temperature, S_IRUGO, ad7314_show_temperature, NULL, 0);
 
-static ssize_t ad7314_show_name(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7314_chip_info *chip = dev_info->dev_data;
-	return sprintf(buf, "%s\n", chip->name);
-}
-
-static IIO_DEVICE_ATTR(name, S_IRUGO, ad7314_show_name, NULL, 0);
-
 static struct attribute *ad7314_attributes[] = {
 	&iio_dev_attr_available_modes.dev_attr.attr,
 	&iio_dev_attr_mode.dev_attr.attr,
 	&iio_dev_attr_temperature.dev_attr.attr,
-	&iio_dev_attr_name.dev_attr.attr,
 	NULL,
 };
 
@@ -222,7 +209,6 @@ static int __devinit ad7314_probe(struct spi_device *spi_dev)
 	dev_set_drvdata(&spi_dev->dev, chip);
 
 	chip->spi_dev = spi_dev;
-	chip->name = spi_dev->modalias;
 
 	chip->indio_dev = iio_allocate_device(0);
 	if (chip->indio_dev == NULL) {
@@ -230,6 +216,7 @@ static int __devinit ad7314_probe(struct spi_device *spi_dev)
 		goto error_free_chip;
 	}
 
+	chip->indio_dev->name = spi_get_device_id(spi_dev)->name;
 	chip->indio_dev->dev.parent = &spi_dev->dev;
 	chip->indio_dev->attrs = &ad7314_attribute_group;
 	chip->indio_dev->dev_data = (void *)chip;
@@ -240,7 +227,7 @@ static int __devinit ad7314_probe(struct spi_device *spi_dev)
 		goto error_free_dev;
 
 	dev_info(&spi_dev->dev, "%s temperature sensor registered.\n",
-			 chip->name);
+			 chip->indio_dev->name);
 
 	return 0;
 error_free_dev:
diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
index 9729a1c..5b41e01 100644
--- a/drivers/staging/iio/adc/ad7476_core.c
+++ b/drivers/staging/iio/adc/ad7476_core.c
@@ -66,26 +66,6 @@ static int ad7476_read_raw(struct iio_dev *dev_info,
 	return -EINVAL;
 }
 
-static ssize_t ad7476_show_name(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7476_state *st = iio_dev_get_devdata(dev_info);
-
-	return sprintf(buf, "%s\n", spi_get_device_id(st->spi)->name);
-}
-static IIO_DEVICE_ATTR(name, S_IRUGO, ad7476_show_name, NULL, 0);
-
-static struct attribute *ad7476_attributes[] = {
-	&iio_dev_attr_name.dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group ad7476_attribute_group = {
-	.attrs = ad7476_attributes,
-};
-
 static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
 	[ID_AD7466] = {
 		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
@@ -183,7 +163,7 @@ static int __devinit ad7476_probe(struct spi_device *spi)
 
 	/* Establish that the iio_dev is a child of the spi device */
 	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->attrs = &ad7476_attribute_group;
+	st->indio_dev->name = spi_get_device_id(spi)->name;
 	st->indio_dev->dev_data = (void *)(st);
 	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
diff --git a/drivers/staging/iio/adc/ad7745.c b/drivers/staging/iio/adc/ad7745.c
index cb1fc61..afa2648 100644
--- a/drivers/staging/iio/adc/ad7745.c
+++ b/drivers/staging/iio/adc/ad7745.c
@@ -53,7 +53,6 @@
  */
 
 struct ad774x_chip_info {
-	const char *name;
 	struct i2c_client *client;
 	struct iio_dev *indio_dev;
 	bool inter;
@@ -499,17 +498,6 @@ static IIO_DEV_ATTR_CAP_GAIN(S_IRUGO | S_IWUSR,
 		ad774x_show_cap_gain,
 		ad774x_store_cap_gain);
 
-static ssize_t ad774x_show_name(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad774x_chip_info *chip = dev_info->dev_data;
-	return sprintf(buf, "%s\n", chip->name);
-}
-
-static IIO_DEVICE_ATTR(name, S_IRUGO, ad774x_show_name, NULL, 0);
-
 static struct attribute *ad774x_attributes[] = {
 	&iio_dev_attr_available_conversion_modes.dev_attr.attr,
 	&iio_dev_attr_conversion_mode.dev_attr.attr,
@@ -523,7 +511,6 @@ static struct attribute *ad774x_attributes[] = {
 	&iio_dev_attr_cap0_raw.dev_attr.attr,
 	&iio_dev_attr_capdac0_raw.dev_attr.attr,
 	&iio_dev_attr_capdac1_raw.dev_attr.attr,
-	&iio_dev_attr_name.dev_attr.attr,
 	NULL,
 };
 
@@ -596,7 +583,6 @@ static int __devinit ad774x_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, chip);
 
 	chip->client = client;
-	chip->name = id->name;
 
 	chip->indio_dev = iio_allocate_device(0);
 	if (chip->indio_dev == NULL) {
@@ -605,6 +591,7 @@ static int __devinit ad774x_probe(struct i2c_client *client,
 	}
 
 	/* Establish that the iio_dev is a child of the i2c device */
+	chip->indio_dev->name = id->name;
 	chip->indio_dev->dev.parent = &client->dev;
 	chip->indio_dev->attrs = &ad774x_attribute_group;
 	chip->indio_dev->event_attrs = &ad774x_event_attribute_group;
diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index ab23c5c..f828e83 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -132,21 +132,9 @@ static ssize_t ad7780_show_scale(struct device *dev,
 }
 static IIO_DEVICE_ATTR(in_scale, S_IRUGO, ad7780_show_scale, NULL, 0);
 
-static ssize_t ad7780_show_name(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7780_state *st = iio_dev_get_devdata(dev_info);
-
-	return sprintf(buf, "%s\n", spi_get_device_id(st->spi)->name);
-}
-static IIO_DEVICE_ATTR(name, S_IRUGO, ad7780_show_name, NULL, 0);
-
 static struct attribute *ad7780_attributes[] = {
 	&iio_dev_attr_in0_raw.dev_attr.attr,
 	&iio_dev_attr_in_scale.dev_attr.attr,
-	&iio_dev_attr_name.dev_attr.attr,
 	NULL,
 };
 
@@ -229,6 +217,7 @@ static int __devinit ad7780_probe(struct spi_device *spi)
 
 	/* Establish that the iio_dev is a child of the spi device */
 	st->indio_dev->dev.parent = &spi->dev;
+	st->indio_dev->name = spi_get_device_id(spi)->name;
 	st->indio_dev->attrs = &ad7780_attribute_group;
 	st->indio_dev->dev_data = (void *)(st);
 	st->indio_dev->driver_module = THIS_MODULE;
diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index a062ec3..bee4209 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -42,7 +42,6 @@
  */
 
 struct ad7816_chip_info {
-	const char *name;
 	struct spi_device *spi_dev;
 	struct iio_dev *indio_dev;
 	u16 rdwr_pin;
@@ -181,13 +180,13 @@ static ssize_t ad7816_store_channel(struct device *dev,
 
 	if (data > AD7816_CS_MAX && data != AD7816_CS_MASK) {
 		dev_err(&chip->spi_dev->dev, "Invalid channel id %lu for %s.\n",
-			data, chip->name);
+			data, dev_info->name);
 		return -EINVAL;
-	} else if (strcmp(chip->name, "ad7818") == 0 && data > 1) {
+	} else if (strcmp(dev_info->name, "ad7818") == 0 && data > 1) {
 		dev_err(&chip->spi_dev->dev,
 			"Invalid channel id %lu for ad7818.\n", data);
 		return -EINVAL;
-	} else if (strcmp(chip->name, "ad7816") == 0 && data > 0) {
+	} else if (strcmp(dev_info->name, "ad7816") == 0 && data > 0) {
 		dev_err(&chip->spi_dev->dev,
 			"Invalid channel id %lu for ad7816.\n", data);
 		return -EINVAL;
@@ -232,23 +231,11 @@ static ssize_t ad7816_show_value(struct device *dev,
 
 static IIO_DEVICE_ATTR(value, S_IRUGO, ad7816_show_value, NULL, 0);
 
-static ssize_t ad7816_show_name(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7816_chip_info *chip = dev_info->dev_data;
-	return sprintf(buf, "%s\n", chip->name);
-}
-
-static IIO_DEVICE_ATTR(name, S_IRUGO, ad7816_show_name, NULL, 0);
-
 static struct attribute *ad7816_attributes[] = {
 	&iio_dev_attr_available_modes.dev_attr.attr,
 	&iio_dev_attr_mode.dev_attr.attr,
 	&iio_dev_attr_channel.dev_attr.attr,
 	&iio_dev_attr_value.dev_attr.attr,
-	&iio_dev_attr_name.dev_attr.attr,
 	NULL,
 };
 
@@ -366,28 +353,27 @@ static int __devinit ad7816_probe(struct spi_device *spi_dev)
 	dev_set_drvdata(&spi_dev->dev, chip);
 
 	chip->spi_dev = spi_dev;
-	chip->name = spi_dev->modalias;
 	for (i = 0; i <= AD7816_CS_MAX; i++)
 		chip->oti_data[i] = 203;
 	chip->rdwr_pin = pins[0];
 	chip->convert_pin = pins[1];
 	chip->busy_pin = pins[2];
 
-	ret = gpio_request(chip->rdwr_pin, chip->name);
+	ret = gpio_request(chip->rdwr_pin, spi_get_device_id(spi_dev)->name);
 	if (ret) {
 		dev_err(&spi_dev->dev, "Fail to request rdwr gpio PIN %d.\n",
 			chip->rdwr_pin);
 		goto error_free_chip;
 	}
 	gpio_direction_input(chip->rdwr_pin);
-	ret = gpio_request(chip->convert_pin, chip->name);
+	ret = gpio_request(chip->convert_pin, spi_get_device_id(spi_dev)->name);
 	if (ret) {
 		dev_err(&spi_dev->dev, "Fail to request convert gpio PIN %d.\n",
 			chip->convert_pin);
 		goto error_free_gpio_rdwr;
 	}
 	gpio_direction_input(chip->convert_pin);
-	ret = gpio_request(chip->busy_pin, chip->name);
+	ret = gpio_request(chip->busy_pin, spi_get_device_id(spi_dev)->name);
 	if (ret) {
 		dev_err(&spi_dev->dev, "Fail to request busy gpio PIN %d.\n",
 			chip->busy_pin);
@@ -400,7 +386,7 @@ static int __devinit ad7816_probe(struct spi_device *spi_dev)
 		ret = -ENOMEM;
 		goto error_free_gpio;
 	}
-
+	chip->indio_dev->name = spi_get_device_id(spi_dev)->name;
 	chip->indio_dev->dev.parent = &spi_dev->dev;
 	chip->indio_dev->attrs = &ad7816_attribute_group;
 	chip->indio_dev->event_attrs = &ad7816_event_attribute_group;
@@ -419,14 +405,14 @@ static int __devinit ad7816_probe(struct spi_device *spi_dev)
 					   NULL,
 					   &ad7816_event_handler,
 					   IRQF_TRIGGER_LOW,
-					   chip->name,
+					   chip->indio_dev->name,
 					   chip->indio_dev);
 		if (ret)
 			goto error_unreg_dev;
 	}
 
 	dev_info(&spi_dev->dev, "%s temperature sensor and ADC registered.\n",
-			 chip->name);
+			 chip->indio_dev->name);
 
 	return 0;
 
diff --git a/drivers/staging/iio/adc/ad7887_core.c b/drivers/staging/iio/adc/ad7887_core.c
index 42e9cd7..27adff4 100644
--- a/drivers/staging/iio/adc/ad7887_core.c
+++ b/drivers/staging/iio/adc/ad7887_core.c
@@ -72,22 +72,10 @@ static ssize_t ad7887_show_scale(struct device *dev,
 }
 static IIO_DEVICE_ATTR(in_scale, S_IRUGO, ad7887_show_scale, NULL, 0);
 
-static ssize_t ad7887_show_name(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7887_state *st = iio_dev_get_devdata(dev_info);
-
-	return sprintf(buf, "%s\n", spi_get_device_id(st->spi)->name);
-}
-static IIO_DEVICE_ATTR(name, S_IRUGO, ad7887_show_name, NULL, 0);
-
 static struct attribute *ad7887_attributes[] = {
 	&iio_dev_attr_in0_raw.dev_attr.attr,
 	&iio_dev_attr_in1_raw.dev_attr.attr,
 	&iio_dev_attr_in_scale.dev_attr.attr,
-	&iio_dev_attr_name.dev_attr.attr,
 	NULL,
 };
 
@@ -160,6 +148,7 @@ static int __devinit ad7887_probe(struct spi_device *spi)
 
 	/* Estabilish that the iio_dev is a child of the spi device */
 	st->indio_dev->dev.parent = &spi->dev;
+	st->indio_dev->name = spi_get_device_id(spi)->name;
 	st->indio_dev->attrs = &ad7887_attribute_group;
 	st->indio_dev->dev_data = (void *)(st);
 	st->indio_dev->driver_module = THIS_MODULE;
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 009efb8..3383a35 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -426,23 +426,11 @@ static ssize_t ad799x_show_scale(struct device *dev,
 
 static IIO_DEVICE_ATTR(in_scale, S_IRUGO, ad799x_show_scale, NULL, 0);
 
-static ssize_t ad799x_show_name(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad799x_state *st = iio_dev_get_devdata(dev_info);
-	return sprintf(buf, "%s\n", st->client->name);
-}
-
-static IIO_DEVICE_ATTR(name, S_IRUGO, ad799x_show_name, NULL, 0);
-
 static struct attribute *ad7991_5_9_3_4_device_attrs[] = {
 	&iio_dev_attr_in0_raw.dev_attr.attr,
 	&iio_dev_attr_in1_raw.dev_attr.attr,
 	&iio_dev_attr_in2_raw.dev_attr.attr,
 	&iio_dev_attr_in3_raw.dev_attr.attr,
-	&iio_dev_attr_name.dev_attr.attr,
 	&iio_dev_attr_in_scale.dev_attr.attr,
 	NULL
 };
@@ -475,7 +463,6 @@ static struct attribute_group ad7991_5_9_3_4_scan_el_group = {
 static struct attribute *ad7992_device_attrs[] = {
 	&iio_dev_attr_in0_raw.dev_attr.attr,
 	&iio_dev_attr_in1_raw.dev_attr.attr,
-	&iio_dev_attr_name.dev_attr.attr,
 	&iio_dev_attr_in_scale.dev_attr.attr,
 	NULL
 };
@@ -510,7 +497,6 @@ static struct attribute *ad7997_8_device_attrs[] = {
 	&iio_dev_attr_in5_raw.dev_attr.attr,
 	&iio_dev_attr_in6_raw.dev_attr.attr,
 	&iio_dev_attr_in7_raw.dev_attr.attr,
-	&iio_dev_attr_name.dev_attr.attr,
 	&iio_dev_attr_in_scale.dev_attr.attr,
 	NULL
 };
diff --git a/drivers/staging/iio/adc/adt7310.c b/drivers/staging/iio/adc/adt7310.c
index 9b2a8ec..2ade485 100644
--- a/drivers/staging/iio/adc/adt7310.c
+++ b/drivers/staging/iio/adc/adt7310.c
@@ -79,7 +79,6 @@
  */
 
 struct adt7310_chip_info {
-	const char *name;
 	struct spi_device *spi_dev;
 	struct iio_dev *indio_dev;
 	u8  config;
@@ -375,24 +374,12 @@ static ssize_t adt7310_show_value(struct device *dev,
 
 static IIO_DEVICE_ATTR(value, S_IRUGO, adt7310_show_value, NULL, 0);
 
-static ssize_t adt7310_show_name(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7310_chip_info *chip = dev_info->dev_data;
-	return sprintf(buf, "%s\n", chip->name);
-}
-
-static IIO_DEVICE_ATTR(name, S_IRUGO, adt7310_show_name, NULL, 0);
-
 static struct attribute *adt7310_attributes[] = {
 	&iio_dev_attr_available_modes.dev_attr.attr,
 	&iio_dev_attr_mode.dev_attr.attr,
 	&iio_dev_attr_resolution.dev_attr.attr,
 	&iio_dev_attr_id.dev_attr.attr,
 	&iio_dev_attr_value.dev_attr.attr,
-	&iio_dev_attr_name.dev_attr.attr,
 	NULL,
 };
 
@@ -781,7 +768,6 @@ static int __devinit adt7310_probe(struct spi_device *spi_dev)
 	dev_set_drvdata(&spi_dev->dev, chip);
 
 	chip->spi_dev = spi_dev;
-	chip->name = spi_dev->modalias;
 
 	chip->indio_dev = iio_allocate_device(0);
 	if (chip->indio_dev == NULL) {
@@ -790,6 +776,7 @@ static int __devinit adt7310_probe(struct spi_device *spi_dev)
 	}
 
 	chip->indio_dev->dev.parent = &spi_dev->dev;
+	chip->indio_dev->name = spi_get_device_id(spi_dev)->name;
 	chip->indio_dev->attrs = &adt7310_attribute_group;
 	chip->indio_dev->event_attrs = adt7310_event_attribute_group;
 	chip->indio_dev->dev_data = (void *)chip;
@@ -811,7 +798,7 @@ static int __devinit adt7310_probe(struct spi_device *spi_dev)
 					   NULL,
 					   &adt7310_event_handler,
 					   irq_flags,
-					   chip->name,
+					   chip->indio_dev->name,
 					   chip->indio_dev);
 		if (ret)
 			goto error_unreg_dev;
@@ -823,7 +810,7 @@ static int __devinit adt7310_probe(struct spi_device *spi_dev)
 					   NULL,
 					   &adt7310_event_handler,
 					   adt7310_platform_data[1],
-					   chip->name,
+					   chip->indio_dev->name,
 					   chip->indio_dev);
 		if (ret)
 			goto error_unreg_ct_irq;
@@ -852,7 +839,7 @@ static int __devinit adt7310_probe(struct spi_device *spi_dev)
 	}
 
 	dev_info(&spi_dev->dev, "%s temperature sensor registered.\n",
-			chip->name);
+			chip->indio_dev->name);
 
 	return 0;
 
diff --git a/drivers/staging/iio/adc/adt7410.c b/drivers/staging/iio/adc/adt7410.c
index dc59130..c102b42 100644
--- a/drivers/staging/iio/adc/adt7410.c
+++ b/drivers/staging/iio/adc/adt7410.c
@@ -74,7 +74,6 @@
  */
 
 struct adt7410_chip_info {
-	const char *name;
 	struct i2c_client *client;
 	struct iio_dev *indio_dev;
 	u8  config;
@@ -343,24 +342,12 @@ static ssize_t adt7410_show_value(struct device *dev,
 
 static IIO_DEVICE_ATTR(value, S_IRUGO, adt7410_show_value, NULL, 0);
 
-static ssize_t adt7410_show_name(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7410_chip_info *chip = dev_info->dev_data;
-	return sprintf(buf, "%s\n", chip->name);
-}
-
-static IIO_DEVICE_ATTR(name, S_IRUGO, adt7410_show_name, NULL, 0);
-
 static struct attribute *adt7410_attributes[] = {
 	&iio_dev_attr_available_modes.dev_attr.attr,
 	&iio_dev_attr_mode.dev_attr.attr,
 	&iio_dev_attr_resolution.dev_attr.attr,
 	&iio_dev_attr_id.dev_attr.attr,
 	&iio_dev_attr_value.dev_attr.attr,
-	&iio_dev_attr_name.dev_attr.attr,
 	NULL,
 };
 
@@ -748,14 +735,13 @@ static int __devinit adt7410_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, chip);
 
 	chip->client = client;
-	chip->name = id->name;
 
 	chip->indio_dev = iio_allocate_device(0);
 	if (chip->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_chip;
 	}
-
+	chip->indio_dev->name = id->name;
 	chip->indio_dev->dev.parent = &client->dev;
 	chip->indio_dev->attrs = &adt7410_attribute_group;
 	chip->indio_dev->event_attrs = adt7410_event_attribute_group;
@@ -774,7 +760,7 @@ static int __devinit adt7410_probe(struct i2c_client *client,
 					   NULL,
 					   &adt7410_event_handler,
 					   IRQF_TRIGGER_LOW,
-					   chip->name,
+					   id->name,
 					   chip->indio_dev);
 		if (ret)
 			goto error_unreg_dev;
@@ -786,7 +772,7 @@ static int __devinit adt7410_probe(struct i2c_client *client,
 					   NULL,
 					   &adt7410_event_handler,
 					   adt7410_platform_data[1],
-					   chip->name,
+					   id->name,
 					   chip->indio_dev);
 		if (ret)
 			goto error_unreg_ct_irq;
diff --git a/drivers/staging/iio/adc/adt75.c b/drivers/staging/iio/adc/adt75.c
index 0d1cc75..4b1c0fa 100644
--- a/drivers/staging/iio/adc/adt75.c
+++ b/drivers/staging/iio/adc/adt75.c
@@ -50,7 +50,6 @@
  */
 
 struct adt75_chip_info {
-	const char *name;
 	struct i2c_client *client;
 	struct iio_dev *indio_dev;
 	u8  config;
@@ -243,23 +242,11 @@ static ssize_t adt75_show_value(struct device *dev,
 
 static IIO_DEVICE_ATTR(value, S_IRUGO, adt75_show_value, NULL, 0);
 
-static ssize_t adt75_show_name(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt75_chip_info *chip = dev_info->dev_data;
-	return sprintf(buf, "%s\n", chip->name);
-}
-
-static IIO_DEVICE_ATTR(name, S_IRUGO, adt75_show_name, NULL, 0);
-
 static struct attribute *adt75_attributes[] = {
 	&iio_dev_attr_available_modes.dev_attr.attr,
 	&iio_dev_attr_mode.dev_attr.attr,
 	&iio_dev_attr_oneshot.dev_attr.attr,
 	&iio_dev_attr_value.dev_attr.attr,
-	&iio_dev_attr_name.dev_attr.attr,
 	NULL,
 };
 
@@ -563,7 +550,6 @@ static int __devinit adt75_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, chip);
 
 	chip->client = client;
-	chip->name = id->name;
 
 	chip->indio_dev = iio_allocate_device(0);
 	if (chip->indio_dev == NULL) {
@@ -571,6 +557,7 @@ static int __devinit adt75_probe(struct i2c_client *client,
 		goto error_free_chip;
 	}
 
+	chip->indio_dev->name = id->name;
 	chip->indio_dev->dev.parent = &client->dev;
 	chip->indio_dev->attrs = &adt75_attribute_group;
 	chip->indio_dev->event_attrs = &adt75_event_attribute_group;
@@ -588,7 +575,7 @@ static int __devinit adt75_probe(struct i2c_client *client,
 					   NULL,
 					   &adt75_event_handler,
 					   IRQF_TRIGGER_LOW,
-					   chip->name,
+					   chip->indio_dev->name,
 					   chip->indio_dev);
 		if (ret)
 			goto error_unreg_dev;
@@ -610,7 +597,7 @@ static int __devinit adt75_probe(struct i2c_client *client,
 	}
 
 	dev_info(&client->dev, "%s temperature sensor registered.\n",
-			 id->name);
+			 chip->indio_dev->name);
 
 	return 0;
 error_unreg_irq:
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 62fefb3..555f149 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -244,16 +244,6 @@ static int max1363_read_raw(struct iio_dev *indio_dev,
 	return 0;
 }
 
-static ssize_t max1363_show_name(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	struct max1363_state *st = iio_priv(dev_get_drvdata(dev));
-	return sprintf(buf, "%s\n", st->client->name);
-}
-
-static IIO_DEVICE_ATTR(name, S_IRUGO, max1363_show_name, NULL, 0);
-
 /* Applies to max1363 */
 static const enum max1363_modes max1363_mode_list[] = {
 	_s0, _s1, _s2, _s3,
@@ -333,15 +323,6 @@ static struct iio_chan_spec max1036_channels[] = MAX1363_4X_CHANS(8);
 static struct iio_chan_spec max1136_channels[] = MAX1363_4X_CHANS(10);
 static struct iio_chan_spec max1236_channels[] = MAX1363_4X_CHANS(12);
 
-static struct attribute *max1363_device_attrs[] = {
-	&iio_dev_attr_name.dev_attr.attr,
-	NULL
-};
-
-static struct attribute_group max1363_dev_attr_group = {
-	.attrs = max1363_device_attrs,
-};
-
 /* Appies to max1236, max1237 */
 static const enum max1363_modes max1236_mode_list[] = {
 	_s0, _s1, _s2, _s3,
@@ -1188,7 +1169,7 @@ static int __devinit max1363_probe(struct i2c_client *client,
 			.modemask;
 	/* Estabilish that the iio_dev is a child of the i2c device */
 	indio_dev->dev.parent = &client->dev;
-	indio_dev->attrs = &max1363_dev_attr_group;
+	indio_dev->name = id->name;
 	indio_dev->read_event_value = &max1363_read_thresh;
 	indio_dev->write_event_value = &max1363_write_thresh;
 	indio_dev->read_event_config = &max1363_read_event_config;
diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 7174e7b..24dd2d2 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -174,7 +174,6 @@
  */
 
 struct adt7316_chip_info {
-	const char		*name;
 	struct iio_dev		*indio_dev;
 	struct adt7316_bus	bus;
 	u16			ldac_pin;
@@ -1672,18 +1671,6 @@ static ssize_t adt7316_show_bus_type(struct device *dev,
 
 static IIO_DEVICE_ATTR(bus_type, S_IRUGO, adt7316_show_bus_type, NULL, 0);
 
-static ssize_t adt7316_show_name(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
-
-	return sprintf(buf, "%s\n", chip->name);
-}
-
-static IIO_DEVICE_ATTR(name, S_IRUGO, adt7316_show_name, NULL, 0);
-
 static struct attribute *adt7316_attributes[] = {
 	&iio_dev_attr_all_modes.dev_attr.attr,
 	&iio_dev_attr_mode.dev_attr.attr,
@@ -1720,7 +1707,6 @@ static struct attribute *adt7316_attributes[] = {
 	&iio_dev_attr_manufactorer_id.dev_attr.attr,
 	&iio_dev_attr_device_rev.dev_attr.attr,
 	&iio_dev_attr_bus_type.dev_attr.attr,
-	&iio_dev_attr_name.dev_attr.attr,
 	NULL,
 };
 
@@ -1769,7 +1755,6 @@ static struct attribute *adt7516_attributes[] = {
 	&iio_dev_attr_manufactorer_id.dev_attr.attr,
 	&iio_dev_attr_device_rev.dev_attr.attr,
 	&iio_dev_attr_bus_type.dev_attr.attr,
-	&iio_dev_attr_name.dev_attr.attr,
 	NULL,
 };
 
@@ -2118,7 +2103,6 @@ int __devinit adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 	dev_set_drvdata(dev, chip);
 
 	chip->bus = *bus;
-	chip->name = name;
 
 	if (name[4] == '3')
 		chip->id = ID_ADT7316 + (name[6] - '6');
@@ -2151,6 +2135,7 @@ int __devinit adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 		chip->indio_dev->attrs = &adt7316_attribute_group;
 		chip->indio_dev->event_attrs = &adt7316_event_attribute_group;
 	}
+	chip->indio_dev->name = name;
 	chip->indio_dev->dev_data = (void *)chip;
 	chip->indio_dev->driver_module = THIS_MODULE;
 	chip->indio_dev->num_interrupt_lines = 1;
@@ -2168,7 +2153,7 @@ int __devinit adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 					   NULL,
 					   &adt7316_event_handler,
 					   chip->bus.irq_flags | IRQF_ONESHOT,
-					   chip->name,
+					   chip->indio_dev->name,
 					   chip->indio_dev);
 		if (ret)
 			goto error_unreg_dev;
@@ -2190,7 +2175,7 @@ int __devinit adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 	}
 
 	dev_info(dev, "%s temperature sensor, ADC and DAC registered.\n",
-			chip->name);
+			chip->indio_dev->name);
 
 	return 0;
 
diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
index fd4fa54..22646a6 100644
--- a/drivers/staging/iio/dac/ad5446.c
+++ b/drivers/staging/iio/dac/ad5446.c
@@ -106,17 +106,6 @@ static ssize_t ad5446_show_scale(struct device *dev,
 }
 static IIO_DEVICE_ATTR(out_scale, S_IRUGO, ad5446_show_scale, NULL, 0);
 
-static ssize_t ad5446_show_name(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad5446_state *st = iio_dev_get_devdata(dev_info);
-
-	return sprintf(buf, "%s\n", spi_get_device_id(st->spi)->name);
-}
-static IIO_DEVICE_ATTR(name, S_IRUGO, ad5446_show_name, NULL, 0);
-
 static ssize_t ad5446_write_powerdown_mode(struct device *dev,
 				       struct device_attribute *attr,
 				       const char *buf, size_t len)
@@ -204,7 +193,6 @@ static struct attribute *ad5446_attributes[] = {
 	&iio_dev_attr_out0_powerdown.dev_attr.attr,
 	&iio_dev_attr_out_powerdown_mode.dev_attr.attr,
 	&iio_const_attr_out_powerdown_mode_available.dev_attr.attr,
-	&iio_dev_attr_name.dev_attr.attr,
 	NULL,
 };
 
@@ -381,6 +369,7 @@ static int __devinit ad5446_probe(struct spi_device *spi)
 
 	/* Estabilish that the iio_dev is a child of the spi device */
 	st->indio_dev->dev.parent = &spi->dev;
+	st->indio_dev->name = spi_get_device_id(spi)->name;
 	st->indio_dev->attrs = &ad5446_attribute_group;
 	st->indio_dev->dev_data = (void *)(st);
 	st->indio_dev->driver_module = THIS_MODULE;
diff --git a/drivers/staging/iio/dac/ad5504.c b/drivers/staging/iio/dac/ad5504.c
index 5534c41..351a9d3 100644
--- a/drivers/staging/iio/dac/ad5504.c
+++ b/drivers/staging/iio/dac/ad5504.c
@@ -170,17 +170,6 @@ static ssize_t ad5504_show_scale(struct device *dev,
 }
 static IIO_DEVICE_ATTR(out_scale, S_IRUGO, ad5504_show_scale, NULL, 0);
 
-static ssize_t ad5504_show_name(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5504_state *st = iio_dev_get_devdata(indio_dev);
-
-	return sprintf(buf, "%s\n", spi_get_device_id(st->spi)->name);
-}
-static IIO_DEVICE_ATTR(name, S_IRUGO, ad5504_show_name, NULL, 0);
-
 #define IIO_DEV_ATTR_OUT_RW_RAW(_num, _show, _store, _addr)		\
 	IIO_DEVICE_ATTR(out##_num##_raw,				\
 			S_IRUGO | S_IWUSR, _show, _store, _addr)
@@ -226,7 +215,6 @@ static struct attribute *ad5504_attributes[] = {
 	&iio_dev_attr_out_powerdown_mode.dev_attr.attr,
 	&iio_const_attr_out_powerdown_mode_available.dev_attr.attr,
 	&iio_dev_attr_out_scale.dev_attr.attr,
-	&iio_dev_attr_name.dev_attr.attr,
 	NULL,
 };
 
@@ -240,7 +228,6 @@ static struct attribute *ad5501_attributes[] = {
 	&iio_dev_attr_out_powerdown_mode.dev_attr.attr,
 	&iio_const_attr_out_powerdown_mode_available.dev_attr.attr,
 	&iio_dev_attr_out_scale.dev_attr.attr,
-	&iio_dev_attr_name.dev_attr.attr,
 	NULL,
 };
 
@@ -310,7 +297,7 @@ static int __devinit ad5504_probe(struct spi_device *spi)
 		goto error_disable_reg;
 	}
 	st->indio_dev->dev.parent = &spi->dev;
-
+	st->indio_dev->name = spi_get_device_id(st->spi)->name;
 	st->indio_dev->attrs = spi_get_device_id(st->spi)->driver_data
 		== ID_AD5501 ? &ad5501_attribute_group :
 		&ad5504_attribute_group;
diff --git a/drivers/staging/iio/dac/ad5624r_spi.c b/drivers/staging/iio/dac/ad5624r_spi.c
index cfb5828..b0e25e2 100644
--- a/drivers/staging/iio/dac/ad5624r_spi.c
+++ b/drivers/staging/iio/dac/ad5624r_spi.c
@@ -174,17 +174,6 @@ static ssize_t ad5624r_show_scale(struct device *dev,
 }
 static IIO_DEVICE_ATTR(out_scale, S_IRUGO, ad5624r_show_scale, NULL, 0);
 
-static ssize_t ad5624r_show_name(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5624r_state *st = iio_dev_get_devdata(indio_dev);
-
-	return sprintf(buf, "%s\n", spi_get_device_id(st->us)->name);
-}
-static IIO_DEVICE_ATTR(name, S_IRUGO, ad5624r_show_name, NULL, 0);
-
 static IIO_DEV_ATTR_OUT_RAW(0, ad5624r_write_dac, AD5624R_ADDR_DAC0);
 static IIO_DEV_ATTR_OUT_RAW(1, ad5624r_write_dac, AD5624R_ADDR_DAC1);
 static IIO_DEV_ATTR_OUT_RAW(2, ad5624r_write_dac, AD5624R_ADDR_DAC2);
@@ -222,7 +211,6 @@ static struct attribute *ad5624r_attributes[] = {
 	&iio_dev_attr_out_powerdown_mode.dev_attr.attr,
 	&iio_const_attr_out_powerdown_mode_available.dev_attr.attr,
 	&iio_dev_attr_out_scale.dev_attr.attr,
-	&iio_dev_attr_name.dev_attr.attr,
 	NULL,
 };
 
@@ -266,6 +254,7 @@ static int __devinit ad5624r_probe(struct spi_device *spi)
 		goto error_disable_reg;
 	}
 	st->indio_dev->dev.parent = &spi->dev;
+	st->indio_dev->name = spi_get_device_id(spi)->name;
 	st->indio_dev->attrs = &ad5624r_attribute_group;
 	st->indio_dev->dev_data = (void *)(st);
 	st->indio_dev->driver_module = THIS_MODULE;
diff --git a/drivers/staging/iio/dds/ad9832.c b/drivers/staging/iio/dds/ad9832.c
index 9c6114f..4b5721c 100644
--- a/drivers/staging/iio/dds/ad9832.c
+++ b/drivers/staging/iio/dds/ad9832.c
@@ -153,17 +153,6 @@ error_ret:
 	return ret ? ret : len;
 }
 
-static ssize_t ad9832_show_name(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad9832_state *st = iio_dev_get_devdata(dev_info);
-
-	return sprintf(buf, "%s\n", spi_get_device_id(st->spi)->name);
-}
-static IIO_DEVICE_ATTR(name, S_IRUGO, ad9832_show_name, NULL, 0);
-
 /**
  * see dds.h for further information
  */
@@ -199,7 +188,6 @@ static struct attribute *ad9832_attributes[] = {
 	&iio_dev_attr_dds0_freqsymbol.dev_attr.attr,
 	&iio_dev_attr_dds0_phasesymbol.dev_attr.attr,
 	&iio_dev_attr_dds0_out_enable.dev_attr.attr,
-	&iio_dev_attr_name.dev_attr.attr,
 	NULL,
 };
 
@@ -243,6 +231,7 @@ static int __devinit ad9832_probe(struct spi_device *spi)
 	}
 
 	st->indio_dev->dev.parent = &spi->dev;
+	st->indio_dev->name = spi_get_device_id(spi)->name;
 	st->indio_dev->attrs = &ad9832_attribute_group;
 	st->indio_dev->dev_data = (void *) st;
 	st->indio_dev->driver_module = THIS_MODULE;
diff --git a/drivers/staging/iio/dds/ad9834.c b/drivers/staging/iio/dds/ad9834.c
index 6dbc458..e5303e6 100644
--- a/drivers/staging/iio/dds/ad9834.c
+++ b/drivers/staging/iio/dds/ad9834.c
@@ -198,17 +198,6 @@ static ssize_t ad9834_store_wavetype(struct device *dev,
 	return ret ? ret : len;
 }
 
-static ssize_t ad9834_show_name(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad9834_state *st = iio_dev_get_devdata(dev_info);
-
-	return sprintf(buf, "%s\n", spi_get_device_id(st->spi)->name);
-}
-static IIO_DEVICE_ATTR(name, S_IRUGO, ad9834_show_name, NULL, 0);
-
 static ssize_t ad9834_show_out0_wavetype_available(struct device *dev,
 						struct device_attribute *attr,
 						char *buf)
@@ -288,7 +277,6 @@ static struct attribute *ad9834_attributes[] = {
 	&iio_dev_attr_dds0_out1_wavetype.dev_attr.attr,
 	&iio_dev_attr_dds0_out0_wavetype_available.dev_attr.attr,
 	&iio_dev_attr_dds0_out1_wavetype_available.dev_attr.attr,
-	&iio_dev_attr_name.dev_attr.attr,
 	NULL,
 };
 
@@ -355,6 +343,7 @@ static int __devinit ad9834_probe(struct spi_device *spi)
 	}
 
 	st->indio_dev->dev.parent = &spi->dev;
+	st->indio_dev->name = spi_get_device_id(spi)->name;
 	st->indio_dev->attrs = &ad9834_attribute_group;
 	st->indio_dev->dev_data = (void *) st;
 	st->indio_dev->driver_module = THIS_MODULE;
diff --git a/drivers/staging/iio/gyro/adis16080_core.c b/drivers/staging/iio/gyro/adis16080_core.c
index 26af63f..fb48e9b 100644
--- a/drivers/staging/iio/gyro/adis16080_core.c
+++ b/drivers/staging/iio/gyro/adis16080_core.c
@@ -110,14 +110,12 @@ static IIO_DEVICE_ATTR(temp_raw, S_IRUGO, adis16080_read, NULL,
 		       ADIS16080_DIN_TEMP);
 static IIO_DEV_ATTR_IN_RAW(0, adis16080_read, ADIS16080_DIN_AIN1);
 static IIO_DEV_ATTR_IN_RAW(1, adis16080_read, ADIS16080_DIN_AIN2);
-static IIO_CONST_ATTR(name, "adis16080");
 
 static struct attribute *adis16080_attributes[] = {
 	&iio_dev_attr_gyro_z_raw.dev_attr.attr,
 	&iio_dev_attr_temp_raw.dev_attr.attr,
 	&iio_dev_attr_in0_raw.dev_attr.attr,
 	&iio_dev_attr_in1_raw.dev_attr.attr,
-	&iio_const_attr_name.dev_attr.attr,
 	NULL
 };
 
@@ -146,6 +144,7 @@ static int __devinit adis16080_probe(struct spi_device *spi)
 		goto error_free_st;
 	}
 
+	st->indio_dev->name = spi->dev.driver->name;
 	st->indio_dev->dev.parent = &spi->dev;
 	st->indio_dev->attrs = &adis16080_attribute_group;
 	st->indio_dev->dev_data = (void *)(st);
diff --git a/drivers/staging/iio/gyro/adis16130_core.c b/drivers/staging/iio/gyro/adis16130_core.c
index 02fbe07..c2f338c 100644
--- a/drivers/staging/iio/gyro/adis16130_core.c
+++ b/drivers/staging/iio/gyro/adis16130_core.c
@@ -155,8 +155,6 @@ static ssize_t adis16130_bitsmode_write(struct device *dev,
 static IIO_DEVICE_ATTR(temp_raw, S_IRUGO, adis16130_val_read, NULL,
 		      ADIS16130_TEMPDATA);
 
-static IIO_CONST_ATTR(name, "adis16130");
-
 static IIO_DEV_ATTR_GYRO_Z(adis16130_val_read, ADIS16130_RATEDATA);
 
 static IIO_DEVICE_ATTR(gyro_z_type, S_IWUSR | S_IRUGO, adis16130_bitsmode_read,
@@ -167,7 +165,6 @@ static IIO_CONST_ATTR(gyro_z_type_available, "s16 s24");
 
 static struct attribute *adis16130_attributes[] = {
 	&iio_dev_attr_temp_raw.dev_attr.attr,
-	&iio_const_attr_name.dev_attr.attr,
 	&iio_dev_attr_gyro_z_raw.dev_attr.attr,
 	&iio_dev_attr_gyro_z_type.dev_attr.attr,
 	&iio_const_attr_gyro_z_type_available.dev_attr.attr,
@@ -197,6 +194,7 @@ static int __devinit adis16130_probe(struct spi_device *spi)
 		goto error_free_st;
 	}
 
+	st->indio_dev->name = spi->dev.driver->name;
 	st->indio_dev->dev.parent = &spi->dev;
 	st->indio_dev->attrs = &adis16130_attribute_group;
 	st->indio_dev->dev_data = (void *)(st);
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index a50b645..3366bd0 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -505,8 +505,6 @@ static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16260_write_reset, 0);
 static IIO_DEVICE_ATTR(sampling_frequency_available,
 		       S_IRUGO, adis16260_read_frequency_available, NULL, 0);
 
-static IIO_CONST_ATTR_NAME("adis16260");
-
 #define ADIS16260_GYRO_ATTR_SET(axis)					\
 	IIO_DEV_ATTR_GYRO##axis(adis16260_read_14bit_signed,		\
 				ADIS16260_GYRO_OUT);			\
@@ -547,7 +545,6 @@ static ADIS16260_GYRO_ATTR_SET(_Z);
 		&iio_dev_attr_sampling_frequency.dev_attr.attr,		\
 		&iio_dev_attr_sampling_frequency_available.dev_attr.attr, \
 		&iio_dev_attr_reset.dev_attr.attr,			\
-		&iio_const_attr_name.dev_attr.attr,			\
 		NULL							\
 	};								\
 	static const struct attribute_group adis16260_attribute_group##axis \
@@ -594,6 +591,7 @@ static int __devinit adis16260_probe(struct spi_device *spi)
 		goto error_free_tx;
 	}
 
+	st->indio_dev->name = spi_get_device_id(st->us)->name;
 	st->indio_dev->dev.parent = &spi->dev;
 	if (pd && pd->direction)
 		switch (pd->direction) {
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index ddcae43..6419b75 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -427,16 +427,6 @@ static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16400_write_reset, 0);
 
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("409 546 819 1638");
 
-static ssize_t adis16400_show_name(struct device *dev,
-				   struct device_attribute *attr,
-				   char *buf)
-{
-	struct adis16400_state *st
-		= iio_dev_get_devdata(dev_get_drvdata(dev));
-	return sprintf(buf, "%s\n", spi_get_device_id(st->us)->name);
-}
-static IIO_DEVICE_ATTR(name, S_IRUGO, adis16400_show_name, NULL, 0);
-
 enum adis16400_chan {
 	in_supply,
 	gyro_x,
@@ -704,7 +694,6 @@ static struct attribute *adis16400_attributes[] = {
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
-	&iio_dev_attr_name.dev_attr.attr,
 	NULL
 };
 
@@ -814,6 +803,7 @@ static int __devinit adis16400_probe(struct spi_device *spi)
 	}
 	st->variant = &adis16400_chips[spi_get_device_id(spi)->driver_data];
 	st->indio_dev->dev.parent = &spi->dev;
+	st->indio_dev->name = spi_get_device_id(spi)->name;
 	st->indio_dev->attrs = &adis16400_attribute_group;
 	st->indio_dev->channels = st->variant->channels;
 	st->indio_dev->num_channels = st->variant->num_channels;
diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index dfbc423..307c664 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -402,16 +402,6 @@ static ssize_t show_proxim_ir(struct device *dev,
 	return get_sensor_data(dev, buf, COMMMAND1_OPMODE_PROX_ONCE);
 }
 
-/* Read name */
-static ssize_t show_name(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct isl29018_chip *chip = indio_dev->dev_data;
-
-	return sprintf(buf, "%s\n", chip->client->name);
-}
-
 static IIO_DEVICE_ATTR(range, S_IRUGO | S_IWUSR, show_range, store_range, 0);
 static IIO_CONST_ATTR(range_available, "1000 4000 16000 64000");
 static IIO_CONST_ATTR(adc_resolution_available, "4 8 12 16");
@@ -424,12 +414,10 @@ static IIO_DEVICE_ATTR(proximity_on_chip_ambient_infrared_supression,
 static IIO_DEVICE_ATTR(illuminance0_input, S_IRUGO, show_lux, NULL, 0);
 static IIO_DEVICE_ATTR(intensity_infrared_raw, S_IRUGO, show_ir, NULL, 0);
 static IIO_DEVICE_ATTR(proximity_raw, S_IRUGO, show_proxim_ir, NULL, 0);
-static IIO_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, 0);
 
 #define ISL29018_DEV_ATTR(name) (&iio_dev_attr_##name.dev_attr.attr)
 #define ISL29018_CONST_ATTR(name) (&iio_const_attr_##name.dev_attr.attr)
 static struct attribute *isl29018_attributes[] = {
-	ISL29018_DEV_ATTR(name),
 	ISL29018_DEV_ATTR(range),
 	ISL29018_CONST_ATTR(range_available),
 	ISL29018_DEV_ATTR(adc_resolution),
@@ -498,6 +486,7 @@ static int __devinit isl29018_probe(struct i2c_client *client,
 		goto exit_free;
 	}
 	chip->indio_dev->attrs = &isl29108_group;
+	chip->indio_dev->name = id->name;
 	chip->indio_dev->dev.parent = &client->dev;
 	chip->indio_dev->dev_data = (void *)(chip);
 	chip->indio_dev->driver_module = THIS_MODULE;
diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
index d62d9e2..8b6bf50 100644
--- a/drivers/staging/iio/meter/ade7753.c
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -463,8 +463,6 @@ static IIO_DEV_ATTR_RESET(ade7753_write_reset);
 
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("27900 14000 7000 3500");
 
-static IIO_CONST_ATTR(name, "ade7753");
-
 static struct attribute *ade7753_attributes[] = {
 	&iio_dev_attr_temp_raw.dev_attr.attr,
 	&iio_const_attr_temp_offset.dev_attr.attr,
@@ -472,7 +470,6 @@ static struct attribute *ade7753_attributes[] = {
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
-	&iio_const_attr_name.dev_attr.attr,
 	&iio_dev_attr_phcal.dev_attr.attr,
 	&iio_dev_attr_cfden.dev_attr.attr,
 	&iio_dev_attr_aenergy.dev_attr.attr,
@@ -538,6 +535,7 @@ static int __devinit ade7753_probe(struct spi_device *spi)
 		goto error_free_tx;
 	}
 
+	st->indio_dev->name = spi->dev.driver->name;
 	st->indio_dev->dev.parent = &spi->dev;
 	st->indio_dev->attrs = &ade7753_attribute_group;
 	st->indio_dev->dev_data = (void *)(st);
diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
index 2d0b8cc..4179325 100644
--- a/drivers/staging/iio/meter/ade7754.c
+++ b/drivers/staging/iio/meter/ade7754.c
@@ -482,8 +482,6 @@ static IIO_DEV_ATTR_RESET(ade7754_write_reset);
 
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("26000 13000 65000 33000");
 
-static IIO_CONST_ATTR(name, "ade7754");
-
 static struct attribute *ade7754_attributes[] = {
 	&iio_dev_attr_temp_raw.dev_attr.attr,
 	&iio_const_attr_temp_offset.dev_attr.attr,
@@ -491,7 +489,6 @@ static struct attribute *ade7754_attributes[] = {
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
-	&iio_const_attr_name.dev_attr.attr,
 	&iio_dev_attr_aenergy.dev_attr.attr,
 	&iio_dev_attr_laenergy.dev_attr.attr,
 	&iio_dev_attr_vaenergy.dev_attr.attr,
@@ -563,6 +560,7 @@ static int __devinit ade7754_probe(struct spi_device *spi)
 		goto error_free_tx;
 	}
 
+	st->indio_dev->name = spi->dev.driver->name;
 	st->indio_dev->dev.parent = &spi->dev;
 	st->indio_dev->attrs = &ade7754_attribute_group;
 	st->indio_dev->dev_data = (void *)(st);
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index cab31dd..c9956c4 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -650,8 +650,6 @@ static IIO_DEV_ATTR_RESET(ade7758_write_reset);
 
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("26000 13000 65000 33000");
 
-static IIO_CONST_ATTR(name, "ade7758");
-
 static struct attribute *ade7758_attributes[] = {
 	&iio_dev_attr_temp_raw.dev_attr.attr,
 	&iio_const_attr_temp_offset.dev_attr.attr,
@@ -660,7 +658,6 @@ static struct attribute *ade7758_attributes[] = {
 	&iio_dev_attr_waveform_type.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
-	&iio_const_attr_name.dev_attr.attr,
 	&iio_dev_attr_awatthr.dev_attr.attr,
 	&iio_dev_attr_bwatthr.dev_attr.attr,
 	&iio_dev_attr_cwatthr.dev_attr.attr,
@@ -735,6 +732,7 @@ static int __devinit ade7758_probe(struct spi_device *spi)
 		goto error_free_tx;
 	}
 
+	st->indio_dev->name = spi->dev.driver->name;
 	st->indio_dev->dev.parent = &spi->dev;
 	st->indio_dev->attrs = &ade7758_attribute_group;
 	st->indio_dev->dev_data = (void *)(st);
diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index 42b3b27..86fe0ae 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -422,8 +422,6 @@ static IIO_DEV_ATTR_RESET(ade7759_write_reset);
 
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("27900 14000 7000 3500");
 
-static IIO_CONST_ATTR(name, "ade7759");
-
 static struct attribute *ade7759_attributes[] = {
 	&iio_dev_attr_temp_raw.dev_attr.attr,
 	&iio_const_attr_temp_offset.dev_attr.attr,
@@ -431,7 +429,6 @@ static struct attribute *ade7759_attributes[] = {
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
-	&iio_const_attr_name.dev_attr.attr,
 	&iio_dev_attr_phcal.dev_attr.attr,
 	&iio_dev_attr_cfden.dev_attr.attr,
 	&iio_dev_attr_aenergy.dev_attr.attr,
@@ -484,6 +481,7 @@ static int __devinit ade7759_probe(struct spi_device *spi)
 		goto error_free_tx;
 	}
 
+	st->indio_dev->name = spi->dev.driver->name;
 	st->indio_dev->dev.parent = &spi->dev;
 	st->indio_dev->num_interrupt_lines = 1;
 
diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index 6a7642e..9b855f3 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -89,13 +89,6 @@ struct iio_const_attr {
 	IIO_DEVICE_ATTR(revision, S_IRUGO, _show, NULL, 0)
 
 /**
- * IIO_DEV_ATTR_NAME - chip type dependent identifier
- * @_show: output method for the attribute
- **/
-#define IIO_DEV_ATTR_NAME(_show)				\
-	IIO_DEVICE_ATTR(name, S_IRUGO, _show, NULL, 0)
-
-/**
  * IIO_DEV_ATTR_RESET: resets the device
  **/
 #define IIO_DEV_ATTR_RESET(_store)			\
-- 
1.7.3.4
