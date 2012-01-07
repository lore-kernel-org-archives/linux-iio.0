Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: pirmin.duss@flytec.ch,
	lars@metafoo.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 6/6] staging:iio: attrs/event_attrs -> struct attribute * + move to iio_dev.
Date: Sat,  7 Jan 2012 10:25:21 +0000
Message-Id: <1325931921-14547-7-git-send-email-jic23@kernel.org>
In-Reply-To: <1325931921-14547-1-git-send-email-jic23@kernel.org>
References: <1325931921-14547-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

They were previously struct attribute_group, but are copied internally
into another attribute_group.  Also they may well be dynamically created
so should not be in iio_info structures.

Also clear out a rather odd unused attribute_group in ak8975.
No idea where that came from.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/adis16201_core.c      |    6 +---
 drivers/staging/iio/accel/adis16203_core.c      |    6 +---
 drivers/staging/iio/accel/adis16204_core.c      |    6 +---
 drivers/staging/iio/accel/adis16209_core.c      |    6 +---
 drivers/staging/iio/accel/adis16220_core.c      |    6 +---
 drivers/staging/iio/accel/adis16240_core.c      |    6 +---
 drivers/staging/iio/accel/kxsd9.c               |    6 +---
 drivers/staging/iio/accel/lis3l02dq_core.c      |    6 +---
 drivers/staging/iio/accel/sca3000_core.c        |   38 ++++----------------
 drivers/staging/iio/adc/ad7192.c                |   23 ++----------
 drivers/staging/iio/adc/ad7280a.c               |   12 +-----
 drivers/staging/iio/adc/ad7291.c                |   12 +-----
 drivers/staging/iio/adc/ad7606_core.c           |   45 +++--------------------
 drivers/staging/iio/adc/ad7793.c                |    6 +---
 drivers/staging/iio/adc/ad7816.c                |   14 ++------
 drivers/staging/iio/adc/ad799x.h                |    2 +-
 drivers/staging/iio/adc/ad799x_core.c           |   39 +++++++-------------
 drivers/staging/iio/adc/adt7310.c               |   13 +------
 drivers/staging/iio/adc/adt7410.c               |   13 +------
 drivers/staging/iio/adc/max1363.h               |    2 +
 drivers/staging/iio/adc/max1363_core.c          |   14 +++-----
 drivers/staging/iio/addac/adt7316.c             |   38 ++++---------------
 drivers/staging/iio/cdc/ad7150.c                |    8 +----
 drivers/staging/iio/cdc/ad7152.c                |    6 +---
 drivers/staging/iio/cdc/ad7746.c                |    6 +---
 drivers/staging/iio/dac/ad5064.c                |    6 +---
 drivers/staging/iio/dac/ad5360.c                |    6 +---
 drivers/staging/iio/dac/ad5380.c                |    6 +---
 drivers/staging/iio/dac/ad5446.c                |   16 +-------
 drivers/staging/iio/dac/ad5504.c                |   29 ++-------------
 drivers/staging/iio/dac/ad5624r_spi.c           |    6 +---
 drivers/staging/iio/dac/ad5686.c                |    6 +---
 drivers/staging/iio/dac/ad5791.c                |    6 +---
 drivers/staging/iio/dac/max517.c                |   19 ++--------
 drivers/staging/iio/dds/ad5930.c                |    6 +---
 drivers/staging/iio/dds/ad9832.c                |    6 +---
 drivers/staging/iio/dds/ad9834.c                |   19 ++--------
 drivers/staging/iio/dds/ad9850.c                |    6 +---
 drivers/staging/iio/dds/ad9852.c                |    6 +---
 drivers/staging/iio/dds/ad9910.c                |    6 +---
 drivers/staging/iio/dds/ad9951.c                |    6 +---
 drivers/staging/iio/gyro/adis16260_core.c       |    6 +---
 drivers/staging/iio/iio.h                       |    8 ++--
 drivers/staging/iio/impedance-analyzer/ad5933.c |    6 +---
 drivers/staging/iio/imu/adis16400_core.c        |    6 +---
 drivers/staging/iio/industrialio-core.c         |    8 ++--
 drivers/staging/iio/industrialio-event.c        |   10 +++---
 drivers/staging/iio/light/isl29018.c            |    6 +---
 drivers/staging/iio/light/tsl2583.c             |    6 +---
 drivers/staging/iio/magnetometer/ak8975.c       |    7 +---
 drivers/staging/iio/magnetometer/hmc5843.c      |    6 +---
 drivers/staging/iio/meter/ade7753.c             |    6 +---
 drivers/staging/iio/meter/ade7754.c             |    6 +---
 drivers/staging/iio/meter/ade7758_core.c        |    6 +---
 drivers/staging/iio/meter/ade7759.c             |    6 +---
 drivers/staging/iio/meter/ade7854.c             |    6 +---
 drivers/staging/iio/resolver/ad2s1210.c         |    6 +---
 57 files changed, 118 insertions(+), 481 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
index ed97da2..41a5a4e 100644
--- a/drivers/staging/iio/accel/adis16201_core.c
+++ b/drivers/staging/iio/accel/adis16201_core.c
@@ -449,12 +449,7 @@ static struct attribute *adis16201_attributes[] = {
 	NULL
 };
 
-static const struct attribute_group adis16201_attribute_group = {
-	.attrs = adis16201_attributes,
-};
-
 static const struct iio_info adis16201_info = {
-	.attrs = &adis16201_attribute_group,
 	.read_raw = &adis16201_read_raw,
 	.write_raw = &adis16201_write_raw,
 	.driver_module = THIS_MODULE,
@@ -482,6 +477,7 @@ static int __devinit adis16201_probe(struct spi_device *spi)
 	indio_dev->name = spi->dev.driver->name;
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->info = &adis16201_info;
+	indio_dev->attrs = adis16201_attributes,
 
 	indio_dev->channels = adis16201_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adis16201_channels);
diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index 41fe930..b3f8b14 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -405,12 +405,7 @@ static struct attribute *adis16203_attributes[] = {
 	NULL
 };
 
-static const struct attribute_group adis16203_attribute_group = {
-	.attrs = adis16203_attributes,
-};
-
 static const struct iio_info adis16203_info = {
-	.attrs = &adis16203_attribute_group,
 	.read_raw = &adis16203_read_raw,
 	.write_raw = &adis16203_write_raw,
 	.driver_module = THIS_MODULE,
@@ -439,6 +434,7 @@ static int __devinit adis16203_probe(struct spi_device *spi)
 	indio_dev->channels = adis16203_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adis16203_channels);
 	indio_dev->info = &adis16203_info;
+	indio_dev->attrs = adis16203_attributes,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = adis16203_configure_ring(indio_dev);
diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index fcab806..dd00270 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -480,12 +480,7 @@ static struct attribute *adis16204_attributes[] = {
 	NULL
 };
 
-static const struct attribute_group adis16204_attribute_group = {
-	.attrs = adis16204_attributes,
-};
-
 static const struct iio_info adis16204_info = {
-	.attrs = &adis16204_attribute_group,
 	.read_raw = &adis16204_read_raw,
 	.write_raw = &adis16204_write_raw,
 	.driver_module = THIS_MODULE,
@@ -512,6 +507,7 @@ static int __devinit adis16204_probe(struct spi_device *spi)
 	indio_dev->name = spi->dev.driver->name;
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->info = &adis16204_info;
+	indio_dev->attrs = adis16204_attributes;
 	indio_dev->channels = adis16204_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adis16204_channels);
 	indio_dev->modes = INDIO_DIRECT_MODE;
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index 4ad33ec..e5f39ee 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -453,12 +453,7 @@ static struct attribute *adis16209_attributes[] = {
 	NULL
 };
 
-static const struct attribute_group adis16209_attribute_group = {
-	.attrs = adis16209_attributes,
-};
-
 static const struct iio_info adis16209_info = {
-	.attrs = &adis16209_attribute_group,
 	.read_raw = &adis16209_read_raw,
 	.write_raw = &adis16209_write_raw,
 	.driver_module = THIS_MODULE,
@@ -485,6 +480,7 @@ static int __devinit adis16209_probe(struct spi_device *spi)
 	indio_dev->name = spi->dev.driver->name;
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->info = &adis16209_info;
+	indio_dev->attrs = adis16209_attributes;
 	indio_dev->channels = adis16209_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adis16209_channels);
 	indio_dev->modes = INDIO_DIRECT_MODE;
diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
index d0587e2..47776e3 100644
--- a/drivers/staging/iio/accel/adis16220_core.c
+++ b/drivers/staging/iio/accel/adis16220_core.c
@@ -612,12 +612,7 @@ static struct attribute *adis16220_attributes[] = {
 	NULL
 };
 
-static const struct attribute_group adis16220_attribute_group = {
-	.attrs = adis16220_attributes,
-};
-
 static const struct iio_info adis16220_info = {
-	.attrs = &adis16220_attribute_group,
 	.driver_module = THIS_MODULE,
 	.read_raw = &adis16220_read_raw,
 };
@@ -645,6 +640,7 @@ static int __devinit adis16220_probe(struct spi_device *spi)
 	indio_dev->name = spi->dev.driver->name;
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->info = &adis16220_info;
+	indio_dev->attrs = adis16220_attributes;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = adis16220_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adis16220_channels);
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index 4298c40..44201c1 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -505,12 +505,7 @@ static struct attribute *adis16240_attributes[] = {
 	NULL
 };
 
-static const struct attribute_group adis16240_attribute_group = {
-	.attrs = adis16240_attributes,
-};
-
 static const struct iio_info adis16240_info = {
-	.attrs = &adis16240_attribute_group,
 	.read_raw = &adis16240_read_raw,
 	.write_raw = &adis16240_write_raw,
 	.driver_module = THIS_MODULE,
@@ -538,6 +533,7 @@ static int __devinit adis16240_probe(struct spi_device *spi)
 	indio_dev->name = spi->dev.driver->name;
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->info = &adis16240_info;
+	indio_dev->attrs = adis16240_attributes;
 	indio_dev->channels = adis16240_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adis16240_channels);
 	indio_dev->modes = INDIO_DIRECT_MODE;
diff --git a/drivers/staging/iio/accel/kxsd9.c b/drivers/staging/iio/accel/kxsd9.c
index 5a543fa..89facf3 100644
--- a/drivers/staging/iio/accel/kxsd9.c
+++ b/drivers/staging/iio/accel/kxsd9.c
@@ -194,10 +194,6 @@ static struct iio_chan_spec kxsd9_channels[] = {
 	}
 };
 
-static const struct attribute_group kxsd9_attribute_group = {
-	.attrs = kxsd9_attributes,
-};
-
 static int __devinit kxsd9_power_up(struct kxsd9_state *st)
 {
 	int ret;
@@ -216,7 +212,6 @@ static int __devinit kxsd9_power_up(struct kxsd9_state *st)
 static const struct iio_info kxsd9_info = {
 	.read_raw = &kxsd9_read_raw,
 	.write_raw = &kxsd9_write_raw,
-	.attrs = &kxsd9_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
@@ -241,6 +236,7 @@ static int __devinit kxsd9_probe(struct spi_device *spi)
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->info = &kxsd9_info;
+	indio_dev->attrs = kxsd9_attributes;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(indio_dev);
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index 3d99f8b..4950c58 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -645,10 +645,6 @@ static struct attribute *lis3l02dq_attributes[] = {
 	NULL
 };
 
-static const struct attribute_group lis3l02dq_attribute_group = {
-	.attrs = lis3l02dq_attributes,
-};
-
 static const struct iio_info lis3l02dq_info = {
 	.read_raw = &lis3l02dq_read_raw,
 	.write_raw = &lis3l02dq_write_raw,
@@ -657,7 +653,6 @@ static const struct iio_info lis3l02dq_info = {
 	.write_event_config = &lis3l02dq_write_event_config,
 	.read_event_config = &lis3l02dq_read_event_config,
 	.driver_module = THIS_MODULE,
-	.attrs = &lis3l02dq_attribute_group,
 };
 
 static int __devinit lis3l02dq_probe(struct spi_device *spi)
@@ -680,6 +675,7 @@ static int __devinit lis3l02dq_probe(struct spi_device *spi)
 	indio_dev->name = spi->dev.driver->name;
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->info = &lis3l02dq_info;
+	indio_dev->attrs = lis3l02dq_attributes;
 	indio_dev->channels = lis3l02dq_channels;
 	indio_dev->num_channels = ARRAY_SIZE(lis3l02dq_channels);
 
diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 1f30108..453770a 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -781,14 +781,6 @@ static struct attribute *sca3000_attributes_with_temp[] = {
 	NULL,
 };
 
-static const struct attribute_group sca3000_attribute_group = {
-	.attrs = sca3000_attributes,
-};
-
-static const struct attribute_group sca3000_attribute_group_with_temp = {
-	.attrs = sca3000_attributes_with_temp,
-};
-
 /* RING RELATED interrupt handler */
 /* depending on event, push to the ring buffer event chrdev or the event one */
 
@@ -1038,11 +1030,6 @@ static struct attribute *sca3000_event_attributes[] = {
 	NULL,
 };
 
-static struct attribute_group sca3000_event_attribute_group = {
-	.attrs = sca3000_event_attributes,
-	.name = "events",
-};
-
 /**
  * sca3000_clean_setup() get the device into a predictable state
  *
@@ -1105,18 +1092,6 @@ error_ret:
 }
 
 static const struct iio_info sca3000_info = {
-	.attrs = &sca3000_attribute_group,
-	.read_raw = &sca3000_read_raw,
-	.event_attrs = &sca3000_event_attribute_group,
-	.read_event_value = &sca3000_read_thresh,
-	.write_event_value = &sca3000_write_thresh,
-	.read_event_config = &sca3000_read_event_config,
-	.write_event_config = &sca3000_write_event_config,
-	.driver_module = THIS_MODULE,
-};
-
-static const struct iio_info sca3000_info_with_temp = {
-	.attrs = &sca3000_attribute_group_with_temp,
 	.read_raw = &sca3000_read_raw,
 	.read_event_value = &sca3000_read_thresh,
 	.write_event_value = &sca3000_write_thresh,
@@ -1147,12 +1122,13 @@ static int __devinit sca3000_probe(struct spi_device *spi)
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->name = spi_get_device_id(spi)->name;
 	if (st->info->temp_output)
-		indio_dev->info = &sca3000_info_with_temp;
-	else {
-		indio_dev->info = &sca3000_info;
-		indio_dev->channels = sca3000_channels;
-		indio_dev->num_channels = ARRAY_SIZE(sca3000_channels);
-	}
+		indio_dev->attrs = sca3000_attributes_with_temp;
+	else
+		indio_dev->attrs = sca3000_attributes;
+	indio_dev->event_attrs = sca3000_event_attributes;
+	indio_dev->info = &sca3000_info;
+	indio_dev->channels = sca3000_channels;
+	indio_dev->num_channels = ARRAY_SIZE(sca3000_channels);
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	sca3000_configure_ring(indio_dev);
diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 881c5e5..aca1693 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -824,10 +824,6 @@ static struct attribute *ad7192_attributes[] = {
 	NULL
 };
 
-static const struct attribute_group ad7192_attribute_group = {
-	.attrs = ad7192_attributes,
-};
-
 static struct attribute *ad7195_attributes[] = {
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_dev_attr_in_v_m_v_scale_available.dev_attr.attr,
@@ -836,10 +832,6 @@ static struct attribute *ad7195_attributes[] = {
 	NULL
 };
 
-static const struct attribute_group ad7195_attribute_group = {
-	.attrs = ad7195_attributes,
-};
-
 static int ad7192_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val,
@@ -962,16 +954,6 @@ static const struct iio_info ad7192_info = {
 	.read_raw = &ad7192_read_raw,
 	.write_raw = &ad7192_write_raw,
 	.write_raw_get_fmt = &ad7192_write_raw_get_fmt,
-	.attrs = &ad7192_attribute_group,
-	.validate_trigger = ad7192_validate_trigger,
-	.driver_module = THIS_MODULE,
-};
-
-static const struct iio_info ad7195_info = {
-	.read_raw = &ad7192_read_raw,
-	.write_raw = &ad7192_write_raw,
-	.write_raw_get_fmt = &ad7192_write_raw_get_fmt,
-	.attrs = &ad7195_attribute_group,
 	.validate_trigger = ad7192_validate_trigger,
 	.driver_module = THIS_MODULE,
 };
@@ -1069,9 +1051,10 @@ static int __devinit ad7192_probe(struct spi_device *spi)
 	indio_dev->num_channels = ARRAY_SIZE(ad7192_channels);
 	indio_dev->available_scan_masks = st->available_scan_masks;
 	if (st->devid == ID_AD7195)
-		indio_dev->info = &ad7195_info;
+		indio_dev->attrs = ad7195_attributes;
 	else
-		indio_dev->info = &ad7192_info;
+		indio_dev->attrs = ad7192_attributes;
+	indio_dev->info = &ad7192_info;
 
 	for (i = 0; i < indio_dev->num_channels; i++)
 		st->available_scan_masks[i] = (1 << i) | (1 <<
diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 941db3a..bd5a3b0 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -480,10 +480,6 @@ static ssize_t ad7280_store_balance_timer(struct device *dev,
 static struct attribute *ad7280_attributes[AD7280A_MAX_CHAIN *
 					   AD7280A_CELLS_PER_DEV * 2 + 1];
 
-static struct attribute_group ad7280_attrs_group = {
-	.attrs = ad7280_attributes,
-};
-
 static int ad7280_channel_init(struct ad7280_state *st)
 {
 	int dev, ch, cnt;
@@ -773,10 +769,6 @@ static struct attribute *ad7280_event_attributes[] = {
 	NULL,
 };
 
-static struct attribute_group ad7280_event_attrs_group = {
-	.attrs = ad7280_event_attributes,
-};
-
 static int ad7280_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val,
@@ -818,8 +810,6 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info ad7280_info = {
 	.read_raw = &ad7280_read_raw,
-	.event_attrs = &ad7280_event_attrs_group,
-	.attrs = &ad7280_attrs_group,
 	.driver_module = THIS_MODULE,
 };
 
@@ -897,6 +887,8 @@ static int __devinit ad7280_probe(struct spi_device *spi)
 	indio_dev->num_channels = ret;
 	indio_dev->channels = st->channels;
 	indio_dev->info = &ad7280_info;
+	indio_dev->event_attrs = ad7280_event_attributes;
+	indio_dev->attrs = ad7280_attributes;
 
 	ret = ad7280_attr_init(st);
 	if (ret < 0)
diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index c4977a7..9054cce 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -146,10 +146,6 @@ static struct attribute *ad7291_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group ad7291_attribute_group = {
-	.attrs = ad7291_attributes,
-};
-
 static irqreturn_t ad7291_event_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
@@ -564,18 +560,12 @@ static const struct iio_chan_spec ad7291_channels[] = {
 	}
 };
 
-static struct attribute_group ad7291_event_attribute_group = {
-	.attrs = ad7291_event_attributes,
-};
-
 static const struct iio_info ad7291_info = {
-	.attrs = &ad7291_attribute_group,
 	.read_raw = &ad7291_read_raw,
 	.read_event_config = &ad7291_read_event_config,
 	.write_event_config = &ad7291_write_event_config,
 	.read_event_value = &ad7291_read_event_value,
 	.write_event_value = &ad7291_write_event_value,
-	.event_attrs = &ad7291_event_attribute_group,
 };
 
 static int __devinit ad7291_probe(struct i2c_client *client,
@@ -623,6 +613,8 @@ static int __devinit ad7291_probe(struct i2c_client *client,
 
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->info = &ad7291_info;
+	indio_dev->attrs = ad7291_attributes;
+	indio_dev->event_attrs = ad7291_event_attributes;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = ad7291_i2c_write(chip, AD7291_COMMAND, AD7291_RESET);
diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index 97e8d3d..99d91ee 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -205,30 +205,18 @@ static struct attribute *ad7606_attributes_os_and_range[] = {
 	NULL,
 };
 
-static const struct attribute_group ad7606_attribute_group_os_and_range = {
-	.attrs = ad7606_attributes_os_and_range,
-};
-
 static struct attribute *ad7606_attributes_os[] = {
 	&iio_dev_attr_oversampling_ratio.dev_attr.attr,
 	&iio_const_attr_oversampling_ratio_available.dev_attr.attr,
 	NULL,
 };
 
-static const struct attribute_group ad7606_attribute_group_os = {
-	.attrs = ad7606_attributes_os,
-};
-
 static struct attribute *ad7606_attributes_range[] = {
 	&iio_dev_attr_in_voltage_range.dev_attr.attr,
 	&iio_const_attr_in_voltage_range_available.dev_attr.attr,
 	NULL,
 };
 
-static const struct attribute_group ad7606_attribute_group_range = {
-	.attrs = ad7606_attributes_range,
-};
-
 #define AD7606_CHANNEL(num)				\
 	{						\
 		.type = IIO_VOLTAGE,			\
@@ -429,27 +417,9 @@ static irqreturn_t ad7606_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 };
 
-static const struct iio_info ad7606_info_no_os_or_range = {
-	.driver_module = THIS_MODULE,
-	.read_raw = &ad7606_read_raw,
-};
-
-static const struct iio_info ad7606_info_os_and_range = {
-	.driver_module = THIS_MODULE,
-	.read_raw = &ad7606_read_raw,
-	.attrs = &ad7606_attribute_group_os_and_range,
-};
-
-static const struct iio_info ad7606_info_os = {
+static const struct iio_info ad7606_info = {
 	.driver_module = THIS_MODULE,
 	.read_raw = &ad7606_read_raw,
-	.attrs = &ad7606_attribute_group_os,
-};
-
-static const struct iio_info ad7606_info_range = {
-	.driver_module = THIS_MODULE,
-	.read_raw = &ad7606_read_raw,
-	.attrs = &ad7606_attribute_group_range,
 };
 
 struct iio_dev *ad7606_probe(struct device *dev, int irq,
@@ -494,19 +464,16 @@ struct iio_dev *ad7606_probe(struct device *dev, int irq,
 	st->chip_info = &ad7606_chip_info_tbl[id];
 
 	indio_dev->dev.parent = dev;
+	indio_dev->info = &ad7606_info;
 	if (gpio_is_valid(st->pdata->gpio_os0) &&
 	    gpio_is_valid(st->pdata->gpio_os1) &&
 	    gpio_is_valid(st->pdata->gpio_os2)) {
 		if (gpio_is_valid(st->pdata->gpio_range))
-			indio_dev->info = &ad7606_info_os_and_range;
+			indio_dev->attrs = ad7606_attributes_os_and_range;
 		else
-			indio_dev->info = &ad7606_info_os;
-	} else {
-		if (gpio_is_valid(st->pdata->gpio_range))
-			indio_dev->info = &ad7606_info_range;
-		else
-			indio_dev->info = &ad7606_info_no_os_or_range;
-	}
+			indio_dev->attrs = ad7606_attributes_os;
+	} else if (gpio_is_valid(st->pdata->gpio_range))
+			indio_dev->attrs = ad7606_attributes_range;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->name = st->chip_info->name;
 	indio_dev->channels = st->chip_info->channels;
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index accf325..7a1631d 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -616,10 +616,6 @@ static struct attribute *ad7793_attributes[] = {
 	NULL
 };
 
-static const struct attribute_group ad7793_attribute_group = {
-	.attrs = ad7793_attributes,
-};
-
 static int ad7793_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val,
@@ -748,7 +744,6 @@ static const struct iio_info ad7793_info = {
 	.read_raw = &ad7793_read_raw,
 	.write_raw = &ad7793_write_raw,
 	.write_raw_get_fmt = &ad7793_write_raw_get_fmt,
-	.attrs = &ad7793_attribute_group,
 	.validate_trigger = ad7793_validate_trigger,
 	.driver_module = THIS_MODULE,
 };
@@ -944,6 +939,7 @@ static int __devinit ad7793_probe(struct spi_device *spi)
 	indio_dev->available_scan_masks = st->available_scan_masks;
 	indio_dev->num_channels = 7;
 	indio_dev->info = &ad7793_info;
+	indio_dev->attrs = ad7793_attributes;
 
 	for (i = 0; i < indio_dev->num_channels; i++) {
 		set_bit(i, &st->available_scan_masks[i]);
diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index a38a1a9..56fc656 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -240,10 +240,6 @@ static struct attribute *ad7816_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group ad7816_attribute_group = {
-	.attrs = ad7816_attributes,
-};
-
 /*
  * temperature bound events
  */
@@ -326,14 +322,7 @@ static struct attribute *ad7816_event_attributes[] = {
 	NULL,
 };
 
-static struct attribute_group ad7816_event_attribute_group = {
-	.attrs = ad7816_event_attributes,
-	.name = "events",
-};
-
 static const struct iio_info ad7816_info = {
-	.attrs = &ad7816_attribute_group,
-	.event_attrs = &ad7816_event_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
@@ -395,6 +384,9 @@ static int __devinit ad7816_probe(struct spi_device *spi_dev)
 	indio_dev->name = spi_get_device_id(spi_dev)->name;
 	indio_dev->dev.parent = &spi_dev->dev;
 	indio_dev->info = &ad7816_info;
+	indio_dev->attrs = ad7816_attributes;
+	indio_dev->event_attrs = ad7816_event_attributes;
+
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	if (spi_dev->irq) {
diff --git a/drivers/staging/iio/adc/ad799x.h b/drivers/staging/iio/adc/ad799x.h
index 356f690..41dfff8 100644
--- a/drivers/staging/iio/adc/ad799x.h
+++ b/drivers/staging/iio/adc/ad799x.h
@@ -90,7 +90,6 @@ struct ad799x_state;
  * @int_vref_mv:	the internal reference voltage
  * @monitor_mode:	whether the chip supports monitor interrupts
  * @default_config:	device default configuration
- * @event_attrs:	pointer to the monitor event attribute group
  */
 
 struct ad799x_chip_info {
@@ -99,6 +98,7 @@ struct ad799x_chip_info {
 	u16				int_vref_mv;
 	u16				default_config;
 	const struct iio_info		*info;
+	struct attribute		**event_attrs;
 };
 
 struct ad799x_state {
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 815e6b9..cf56c66 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -403,11 +403,6 @@ static struct attribute *ad7993_4_7_8_event_attributes[] = {
 	NULL,
 };
 
-static struct attribute_group ad7993_4_7_8_event_attrs_group = {
-	.attrs = ad7993_4_7_8_event_attributes,
-	.name = "events",
-};
-
 static struct attribute *ad7992_event_attributes[] = {
 	&iio_dev_attr_in_voltage0_thresh_both_hyst_raw.dev_attr.attr,
 	&iio_dev_attr_in_voltage1_thresh_both_hyst_raw.dev_attr.attr,
@@ -416,28 +411,13 @@ static struct attribute *ad7992_event_attributes[] = {
 	NULL,
 };
 
-static struct attribute_group ad7992_event_attrs_group = {
-	.attrs = ad7992_event_attributes,
-	.name = "events",
-};
-
 static const struct iio_info ad7991_info = {
 	.read_raw = &ad799x_read_raw,
 	.driver_module = THIS_MODULE,
 };
 
-static const struct iio_info ad7992_info = {
-	.read_raw = &ad799x_read_raw,
-	.event_attrs = &ad7992_event_attrs_group,
-	.read_event_config = &ad799x_read_event_config,
-	.read_event_value = &ad799x_read_event_value,
-	.write_event_value = &ad799x_write_event_value,
-	.driver_module = THIS_MODULE,
-};
-
-static const struct iio_info ad7993_4_7_8_info = {
+static const struct iio_info ad7992_3_4_7_8_info = {
 	.read_raw = &ad799x_read_raw,
-	.event_attrs = &ad7993_4_7_8_event_attrs_group,
 	.read_event_config = &ad799x_read_event_config,
 	.read_event_value = &ad799x_read_event_value,
 	.write_event_value = &ad799x_write_event_value,
@@ -579,7 +559,9 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 		.num_channels = 3,
 		.int_vref_mv = 4096,
 		.default_config = AD7998_ALERT_EN,
-		.info = &ad7992_info,
+		.info = &ad7992_3_4_7_8_info,
+		.event_attrs = ad7992_event_attributes,
+
 	},
 	[ad7993] = {
 		.channel = {
@@ -620,7 +602,8 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 		.num_channels = 5,
 		.int_vref_mv = 1024,
 		.default_config = AD7998_ALERT_EN,
-		.info = &ad7993_4_7_8_info,
+		.info = &ad7992_3_4_7_8_info,
+		.event_attrs = ad7993_4_7_8_event_attributes,
 	},
 	[ad7994] = {
 		.channel = {
@@ -661,7 +644,8 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 		.num_channels = 5,
 		.int_vref_mv = 4096,
 		.default_config = AD7998_ALERT_EN,
-		.info = &ad7993_4_7_8_info,
+		.info = &ad7992_3_4_7_8_info,
+		.event_attrs = ad7993_4_7_8_event_attributes,
 	},
 	[ad7997] = {
 		.channel = {
@@ -730,7 +714,8 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 		.num_channels = 9,
 		.int_vref_mv = 1024,
 		.default_config = AD7998_ALERT_EN,
-		.info = &ad7993_4_7_8_info,
+		.info = &ad7992_3_4_7_8_info,
+		.event_attrs = ad7993_4_7_8_event_attributes,
 	},
 	[ad7998] = {
 		.channel = {
@@ -799,7 +784,8 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 		.num_channels = 9,
 		.int_vref_mv = 4096,
 		.default_config = AD7998_ALERT_EN,
-		.info = &ad7993_4_7_8_info,
+		.info = &ad7992_3_4_7_8_info,
+		.event_attrs = ad7993_4_7_8_event_attributes,
 	},
 };
 
@@ -840,6 +826,7 @@ static int __devinit ad799x_probe(struct i2c_client *client,
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->name = id->name;
 	indio_dev->info = st->chip_info->info;
+	indio_dev->event_attrs = st->chip_info->event_attrs;
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->chip_info->channel;
diff --git a/drivers/staging/iio/adc/adt7310.c b/drivers/staging/iio/adc/adt7310.c
index fc6ef6d..f07cebf 100644
--- a/drivers/staging/iio/adc/adt7310.c
+++ b/drivers/staging/iio/adc/adt7310.c
@@ -383,10 +383,6 @@ static struct attribute *adt7310_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group adt7310_attribute_group = {
-	.attrs = adt7310_attributes,
-};
-
 static irqreturn_t adt7310_event_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
@@ -730,14 +726,7 @@ static struct attribute *adt7310_event_int_attributes[] = {
 	NULL,
 };
 
-static struct attribute_group adt7310_event_attribute_group = {
-	.attrs = adt7310_event_int_attributes,
-	.name = "events",
-};
-
 static const struct iio_info adt7310_info = {
-	.attrs = &adt7310_attribute_group,
-	.event_attrs = &adt7310_event_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
@@ -767,6 +756,8 @@ static int __devinit adt7310_probe(struct spi_device *spi_dev)
 	indio_dev->dev.parent = &spi_dev->dev;
 	indio_dev->name = spi_get_device_id(spi_dev)->name;
 	indio_dev->info = &adt7310_info;
+	indio_dev->attrs = adt7310_attributes;
+	indio_dev->event_attrs = adt7310_event_int_attributes;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* CT critcal temperature event. line 0 */
diff --git a/drivers/staging/iio/adc/adt7410.c b/drivers/staging/iio/adc/adt7410.c
index 74d28f4..d34d039 100644
--- a/drivers/staging/iio/adc/adt7410.c
+++ b/drivers/staging/iio/adc/adt7410.c
@@ -352,10 +352,6 @@ static struct attribute *adt7410_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group adt7410_attribute_group = {
-	.attrs = adt7410_attributes,
-};
-
 static irqreturn_t adt7410_event_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
@@ -698,14 +694,7 @@ static struct attribute *adt7410_event_int_attributes[] = {
 	NULL,
 };
 
-static struct attribute_group adt7410_event_attribute_group = {
-	.attrs = adt7410_event_int_attributes,
-	.name = "events",
-};
-
 static const struct iio_info adt7410_info = {
-	.attrs = &adt7410_attribute_group,
-	.event_attrs = &adt7410_event_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
@@ -735,6 +724,8 @@ static int __devinit adt7410_probe(struct i2c_client *client,
 	indio_dev->name = id->name;
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->info = &adt7410_info;
+	indio_dev->attrs = adt7410_attributes;
+	indio_dev->event_attrs = adt7410_event_int_attributes;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* CT critcal temperature event. line 0 */
diff --git a/drivers/staging/iio/adc/max1363.h b/drivers/staging/iio/adc/max1363.h
index 2cd0112..968ac35 100644
--- a/drivers/staging/iio/adc/max1363.h
+++ b/drivers/staging/iio/adc/max1363.h
@@ -92,6 +92,7 @@ enum max1363_modes {
  * @bits:		accuracy of the adc in bits
  * @int_vref_mv:	the internal reference voltage
  * @info:		iio core function callbacks structure
+ * @event_attrs:	additional event related attributes
  * @mode_list:		array of available scan modes
  * @num_modes:		the number of scan modes available
  * @default_mode:	the scan mode in which the chip starts up
@@ -100,6 +101,7 @@ enum max1363_modes {
  */
 struct max1363_chip_info {
 	const struct iio_info		*info;
+	struct attribute		**event_attrs;
 	struct iio_chan_spec *channels;
 	int num_channels;
 	const enum max1363_modes	*mode_list;
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 1ce89ef..8572c07 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -819,14 +819,6 @@ static struct attribute *max1363_event_attributes[] = {
 	NULL,
 };
 
-static struct attribute_group max1363_event_attribute_group = {
-	.attrs = max1363_event_attributes,
-	.name = "events",
-};
-
-#define MAX1363_EVENT_FUNCS						\
-
-
 static const struct iio_info max1238_info = {
 	.read_raw = &max1363_read_raw,
 	.driver_module = THIS_MODULE,
@@ -840,7 +832,6 @@ static const struct iio_info max1363_info = {
 	.read_raw = &max1363_read_raw,
 	.update_scan_mode = &max1363_update_scan_mode,
 	.driver_module = THIS_MODULE,
-	.event_attrs = &max1363_event_attribute_group,
 };
 
 /* max1363 and max1368 tested - rest from data sheet */
@@ -854,6 +845,7 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.channels = max1361_channels,
 		.num_channels = ARRAY_SIZE(max1361_channels),
 		.info = &max1363_info,
+		.event_attrs = max1363_event_attributes,
 	},
 	[max1362] = {
 		.bits = 10,
@@ -864,6 +856,7 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.channels = max1361_channels,
 		.num_channels = ARRAY_SIZE(max1361_channels),
 		.info = &max1363_info,
+		.event_attrs = max1363_event_attributes,
 	},
 	[max1363] = {
 		.bits = 12,
@@ -874,6 +867,7 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.channels = max1363_channels,
 		.num_channels = ARRAY_SIZE(max1363_channels),
 		.info = &max1363_info,
+		.event_attrs = max1363_event_attributes,
 	},
 	[max1364] = {
 		.bits = 12,
@@ -884,6 +878,7 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.channels = max1363_channels,
 		.num_channels = ARRAY_SIZE(max1363_channels),
 		.info = &max1363_info,
+		.event_attrs = max1363_event_attributes,
 	},
 	[max1036] = {
 		.bits = 8,
@@ -1295,6 +1290,7 @@ static int __devinit max1363_probe(struct i2c_client *client,
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
 	indio_dev->info = st->chip_info->info;
+	indio_dev->event_attrs = st->chip_info->event_attrs;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 13c3929..77be8ee 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -1711,10 +1711,6 @@ static struct attribute *adt7316_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group adt7316_attribute_group = {
-	.attrs = adt7316_attributes,
-};
-
 static struct attribute *adt7516_attributes[] = {
 	&iio_dev_attr_all_modes.dev_attr.attr,
 	&iio_dev_attr_mode.dev_attr.attr,
@@ -1759,10 +1755,6 @@ static struct attribute *adt7516_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group adt7516_attribute_group = {
-	.attrs = adt7516_attributes,
-};
-
 static irqreturn_t adt7316_event_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
@@ -2063,11 +2055,6 @@ static struct attribute *adt7316_event_attributes[] = {
 	NULL,
 };
 
-static struct attribute_group adt7316_event_attribute_group = {
-	.attrs = adt7316_event_attributes,
-	.name = "events",
-};
-
 static struct attribute *adt7516_event_attributes[] = {
 	&iio_dev_attr_int_mask.dev_attr.attr,
 	&iio_dev_attr_in_temp_high_value.dev_attr.attr,
@@ -2084,11 +2071,6 @@ static struct attribute *adt7516_event_attributes[] = {
 	NULL,
 };
 
-static struct attribute_group adt7516_event_attribute_group = {
-	.attrs = adt7516_event_attributes,
-	.name = "events",
-};
-
 #ifdef CONFIG_PM
 int adt7316_disable(struct device *dev)
 {
@@ -2110,14 +2092,6 @@ EXPORT_SYMBOL(adt7316_enable);
 #endif
 
 static const struct iio_info adt7316_info = {
-	.attrs = &adt7316_attribute_group,
-	.event_attrs = &adt7316_event_attribute_group,
-	.driver_module = THIS_MODULE,
-};
-
-static const struct iio_info adt7516_info = {
-	.attrs = &adt7516_attribute_group,
-	.event_attrs = &adt7516_event_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
@@ -2161,10 +2135,14 @@ int __devinit adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 		chip->int_mask |= ADT7516_AIN_INT_MASK;
 
 	indio_dev->dev.parent = dev;
-	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
-		indio_dev->info = &adt7516_info;
-	else
-		indio_dev->info = &adt7316_info;
+	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX) {
+		indio_dev->attrs = adt7516_attributes;
+		indio_dev->event_attrs = adt7516_event_attributes;
+	} else {
+		indio_dev->attrs = adt7316_attributes;
+		indio_dev->event_attrs = adt7316_event_attributes;
+	}
+	indio_dev->info = &adt7316_info;
 	indio_dev->name = name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 6bcdb14..e7031a7 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -530,13 +530,7 @@ static struct attribute *ad7150_event_attributes[] = {
 	NULL,
 };
 
-static struct attribute_group ad7150_event_attribute_group = {
-	.attrs = ad7150_event_attributes,
-	.name = "events",
-};
-
 static const struct iio_info ad7150_info = {
-	.event_attrs = &ad7150_event_attribute_group,
 	.driver_module = THIS_MODULE,
 	.read_raw = &ad7150_read_raw,
 	.read_event_config = &ad7150_read_event_config,
@@ -575,7 +569,7 @@ static int __devinit ad7150_probe(struct i2c_client *client,
 	indio_dev->dev.parent = &client->dev;
 
 	indio_dev->info = &ad7150_info;
-
+	indio_dev->event_attrs = ad7150_event_attributes;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	if (client->irq) {
diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
index 29b2dc6..b5e1200 100644
--- a/drivers/staging/iio/cdc/ad7152.c
+++ b/drivers/staging/iio/cdc/ad7152.c
@@ -231,10 +231,6 @@ static struct attribute *ad7152_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group ad7152_attribute_group = {
-	.attrs = ad7152_attributes,
-};
-
 static const u8 ad7152_addresses[][4] = {
 	{ AD7152_REG_CH1_DATA_HIGH, AD7152_REG_CH1_OFFS_HIGH,
 	  AD7152_REG_CH1_GAIN_HIGH, AD7152_REG_CH1_SETUP },
@@ -424,7 +420,6 @@ static int ad7152_write_raw_get_fmt(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info ad7152_info = {
-	.attrs = &ad7152_attribute_group,
 	.read_raw = &ad7152_read_raw,
 	.write_raw = &ad7152_write_raw,
 	.write_raw_get_fmt = &ad7152_write_raw_get_fmt,
@@ -492,6 +487,7 @@ static int __devinit ad7152_probe(struct i2c_client *client,
 	indio_dev->name = id->name;
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->info = &ad7152_info;
+	indio_dev->attrs = ad7152_attributes;
 	indio_dev->channels = ad7152_channels;
 	if (id->driver_data == 0)
 		indio_dev->num_channels = ARRAY_SIZE(ad7152_channels);
diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index de8f844..7f2fcab 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -461,10 +461,6 @@ static struct attribute *ad7746_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group ad7746_attribute_group = {
-	.attrs = ad7746_attributes,
-};
-
 static int ad7746_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int val,
@@ -677,7 +673,6 @@ out:
 }
 
 static const struct iio_info ad7746_info = {
-	.attrs = &ad7746_attribute_group,
 	.read_raw = &ad7746_read_raw,
 	.write_raw = &ad7746_write_raw,
 	.driver_module = THIS_MODULE,
@@ -712,6 +707,7 @@ static int __devinit ad7746_probe(struct i2c_client *client,
 	indio_dev->name = id->name;
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->info = &ad7746_info;
+	indio_dev->attrs = ad7746_attributes;
 	indio_dev->channels = ad7746_channels;
 	if (id->driver_data == 7746)
 		indio_dev->num_channels = ARRAY_SIZE(ad7746_channels);
diff --git a/drivers/staging/iio/dac/ad5064.c b/drivers/staging/iio/dac/ad5064.c
index 867e4ab..5f68d55 100644
--- a/drivers/staging/iio/dac/ad5064.c
+++ b/drivers/staging/iio/dac/ad5064.c
@@ -269,10 +269,6 @@ static struct attribute *ad5064_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group ad5064_attribute_group = {
-	.attrs = ad5064_attributes,
-};
-
 static int ad5064_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val,
@@ -331,7 +327,6 @@ static int ad5064_write_raw(struct iio_dev *indio_dev,
 static const struct iio_info ad5064_info = {
 	.read_raw = ad5064_read_raw,
 	.write_raw = ad5064_write_raw,
-	.attrs = &ad5064_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
@@ -391,6 +386,7 @@ static int __devinit ad5064_probe(struct spi_device *spi)
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad5064_info;
+	indio_dev->attrs = ad5064_attributes;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->chip_info->channel;
 	indio_dev->num_channels = AD5064_DAC_CHANNELS;
diff --git a/drivers/staging/iio/dac/ad5360.c b/drivers/staging/iio/dac/ad5360.c
index 012d714..4493676 100644
--- a/drivers/staging/iio/dac/ad5360.c
+++ b/drivers/staging/iio/dac/ad5360.c
@@ -304,10 +304,6 @@ static struct attribute *ad5360_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group ad5360_attribute_group = {
-	.attrs = ad5360_attributes,
-};
-
 static int ad5360_write_raw(struct iio_dev *indio_dev,
 			       struct iio_chan_spec const *chan,
 			       int val,
@@ -425,7 +421,6 @@ static int ad5360_read_raw(struct iio_dev *indio_dev,
 static const struct iio_info ad5360_info = {
 	.read_raw = ad5360_read_raw,
 	.write_raw = ad5360_write_raw,
-	.attrs = &ad5360_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
@@ -479,6 +474,7 @@ static int __devinit ad5360_probe(struct spi_device *spi)
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad5360_info;
+	indio_dev->attrs = ad5360_attributes;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->num_channels = st->chip_info->num_channels;
 
diff --git a/drivers/staging/iio/dac/ad5380.c b/drivers/staging/iio/dac/ad5380.c
index eff97ae0..6efc11e 100644
--- a/drivers/staging/iio/dac/ad5380.c
+++ b/drivers/staging/iio/dac/ad5380.c
@@ -264,10 +264,6 @@ static struct attribute *ad5380_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group ad5380_attribute_group = {
-	.attrs = ad5380_attributes,
-};
-
 static unsigned int ad5380_info_to_reg(struct iio_chan_spec const *chan,
 	long info)
 {
@@ -353,7 +349,6 @@ static int ad5380_read_raw(struct iio_dev *indio_dev,
 static const struct iio_info ad5380_info = {
 	.read_raw = ad5380_read_raw,
 	.write_raw = ad5380_write_raw,
-	.attrs = &ad5380_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
@@ -404,6 +399,7 @@ static int __devinit ad5380_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->dev.parent = dev;
 	indio_dev->name = name;
 	indio_dev->info = &ad5380_info;
+	indio_dev->attrs = ad5380_attributes;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->num_channels = st->chip_info->num_channels;
 
diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
index 05fccff..1ac71d0 100644
--- a/drivers/staging/iio/dac/ad5446.c
+++ b/drivers/staging/iio/dac/ad5446.c
@@ -149,10 +149,6 @@ static struct attribute *ad5446_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group ad5446_attribute_group = {
-	.attrs = ad5446_attributes,
-};
-
 #define AD5446_CHANNEL(bits, storage, shift) { \
 	.type = IIO_VOLTAGE, \
 	.indexed = 1, \
@@ -295,13 +291,6 @@ static int ad5446_write_raw(struct iio_dev *indio_dev,
 static const struct iio_info ad5446_info = {
 	.read_raw = ad5446_read_raw,
 	.write_raw = ad5446_write_raw,
-	.attrs = &ad5446_attribute_group,
-	.driver_module = THIS_MODULE,
-};
-
-static const struct iio_info ad5446_info_no_pwr_down = {
-	.read_raw = ad5446_read_raw,
-	.write_raw = ad5446_write_raw,
 	.driver_module = THIS_MODULE,
 };
 
@@ -338,9 +327,8 @@ static int __devinit ad5446_probe(struct spi_device *spi)
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->name = spi_get_device_id(spi)->name;
 	if (st->chip_info->store_pwr_down)
-		indio_dev->info = &ad5446_info;
-	else
-		indio_dev->info = &ad5446_info_no_pwr_down;
+		indio_dev->attrs = ad5446_attributes;
+	indio_dev->info = &ad5446_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = &st->chip_info->channel;
 	indio_dev->num_channels = 1;
diff --git a/drivers/staging/iio/dac/ad5504.c b/drivers/staging/iio/dac/ad5504.c
index f20a5dc..53ae3a0 100644
--- a/drivers/staging/iio/dac/ad5504.c
+++ b/drivers/staging/iio/dac/ad5504.c
@@ -222,10 +222,6 @@ static struct attribute *ad5504_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group ad5504_attribute_group = {
-	.attrs = ad5504_attributes,
-};
-
 static struct attribute *ad5501_attributes[] = {
 	&iio_dev_attr_out_voltage0_powerdown.dev_attr.attr,
 	&iio_dev_attr_out_voltage_powerdown_mode.dev_attr.attr,
@@ -233,10 +229,6 @@ static struct attribute *ad5501_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group ad5501_attribute_group = {
-	.attrs = ad5501_attributes,
-};
-
 static IIO_CONST_ATTR(temp0_thresh_rising_value, "110000");
 static IIO_CONST_ATTR(temp0_thresh_rising_en, "1");
 
@@ -246,11 +238,6 @@ static struct attribute *ad5504_ev_attributes[] = {
 	NULL,
 };
 
-static struct attribute_group ad5504_ev_attribute_group = {
-	.attrs = ad5504_ev_attributes,
-	.name = "events",
-};
-
 static irqreturn_t ad5504_event_handler(int irq, void *private)
 {
 	iio_push_event(private,
@@ -266,16 +253,6 @@ static irqreturn_t ad5504_event_handler(int irq, void *private)
 static const struct iio_info ad5504_info = {
 	.write_raw = ad5504_write_raw,
 	.read_raw = ad5504_read_raw,
-	.attrs = &ad5504_attribute_group,
-	.event_attrs = &ad5504_ev_attribute_group,
-	.driver_module = THIS_MODULE,
-};
-
-static const struct iio_info ad5501_info = {
-	.write_raw = ad5504_write_raw,
-	.read_raw = ad5504_read_raw,
-	.attrs = &ad5501_attribute_group,
-	.event_attrs = &ad5504_ev_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
@@ -314,11 +291,13 @@ static int __devinit ad5504_probe(struct spi_device *spi)
 	st->spi = spi;
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->name = spi_get_device_id(st->spi)->name;
+	indio_dev->info = &ad5504_info;
+	indio_dev->event_attrs = ad5504_ev_attributes;
 	if (spi_get_device_id(st->spi)->driver_data == ID_AD5501) {
-		indio_dev->info = &ad5501_info;
+		indio_dev->attrs = ad5501_attributes;
 		indio_dev->num_channels = 1;
 	} else {
-		indio_dev->info = &ad5504_info;
+		indio_dev->attrs = ad5504_attributes;
 		indio_dev->num_channels = 4;
 	}
 	indio_dev->channels = ad5504_channels;
diff --git a/drivers/staging/iio/dac/ad5624r_spi.c b/drivers/staging/iio/dac/ad5624r_spi.c
index 6cb00e1..949e152 100644
--- a/drivers/staging/iio/dac/ad5624r_spi.c
+++ b/drivers/staging/iio/dac/ad5624r_spi.c
@@ -238,14 +238,9 @@ static struct attribute *ad5624r_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group ad5624r_attribute_group = {
-	.attrs = ad5624r_attributes,
-};
-
 static const struct iio_info ad5624r_info = {
 	.write_raw = ad5624r_write_raw,
 	.read_raw = ad5624r_read_raw,
-	.attrs = &ad5624r_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
@@ -284,6 +279,7 @@ static int __devinit ad5624r_probe(struct spi_device *spi)
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad5624r_info;
+	indio_dev->attrs = ad5624r_attributes;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = AD5624R_DAC_CHANNELS;
diff --git a/drivers/staging/iio/dac/ad5686.c b/drivers/staging/iio/dac/ad5686.c
index bbaa928..f6de2cb 100644
--- a/drivers/staging/iio/dac/ad5686.c
+++ b/drivers/staging/iio/dac/ad5686.c
@@ -282,10 +282,6 @@ static struct attribute *ad5686_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group ad5686_attribute_group = {
-	.attrs = ad5686_attributes,
-};
-
 static int ad5686_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val,
@@ -349,7 +345,6 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
 static const struct iio_info ad5686_info = {
 	.read_raw = ad5686_read_raw,
 	.write_raw = ad5686_write_raw,
-	.attrs = &ad5686_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
@@ -388,6 +383,7 @@ static int __devinit ad5686_probe(struct spi_device *spi)
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad5686_info;
+	indio_dev->attrs = ad5686_attributes;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->chip_info->channel;
 	indio_dev->num_channels = AD5686_DAC_CHANNELS;
diff --git a/drivers/staging/iio/dac/ad5791.c b/drivers/staging/iio/dac/ad5791.c
index e919025..770aa5c 100644
--- a/drivers/staging/iio/dac/ad5791.c
+++ b/drivers/staging/iio/dac/ad5791.c
@@ -180,10 +180,6 @@ static struct attribute *ad5791_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group ad5791_attribute_group = {
-	.attrs = ad5791_attributes,
-};
-
 static int ad5791_get_lin_comp(unsigned int span)
 {
 	if (span <= 10000)
@@ -277,7 +273,6 @@ static int ad5791_write_raw(struct iio_dev *indio_dev,
 static const struct iio_info ad5791_info = {
 	.read_raw = &ad5791_read_raw,
 	.write_raw = &ad5791_write_raw,
-	.attrs = &ad5791_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
@@ -345,6 +340,7 @@ static int __devinit ad5791_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->info = &ad5791_info;
+	indio_dev->attrs = ad5791_attributes;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels
 		= &ad5791_channels[spi_get_device_id(spi)->driver_data];
diff --git a/drivers/staging/iio/dac/max517.c b/drivers/staging/iio/dac/max517.c
index adfbd20..fd3b967 100644
--- a/drivers/staging/iio/dac/max517.c
+++ b/drivers/staging/iio/dac/max517.c
@@ -161,10 +161,6 @@ static struct attribute *max517_attributes[] = {
 	NULL
 };
 
-static struct attribute_group max517_attribute_group = {
-	.attrs = max517_attributes,
-};
-
 /* On MAX518 and MAX519 variant, we have two outputs */
 static struct attribute *max518_attributes[] = {
 	&iio_dev_attr_out_voltage1_raw.dev_attr.attr,
@@ -175,10 +171,6 @@ static struct attribute *max518_attributes[] = {
 	NULL
 };
 
-static struct attribute_group max518_attribute_group = {
-	.attrs = max518_attributes,
-};
-
 static int max517_suspend(struct i2c_client *client, pm_message_t mesg)
 {
 	u8 outbuf = COMMAND_PD;
@@ -194,12 +186,6 @@ static int max517_resume(struct i2c_client *client)
 }
 
 static const struct iio_info max517_info = {
-	.attrs = &max517_attribute_group,
-	.driver_module = THIS_MODULE,
-};
-
-static const struct iio_info max518_info = {
-	.attrs = &max518_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
@@ -223,11 +209,12 @@ static int max517_probe(struct i2c_client *client,
 	/* establish that the iio_dev is a child of the i2c device */
 	indio_dev->dev.parent = &client->dev;
 
+	indio_dev->info = &max517_info;
 	/* reduced attribute set for MAX517 */
 	if (id->driver_data == ID_MAX517)
-		indio_dev->info = &max517_info;
+		indio_dev->attrs = max517_attributes;
 	else
-		indio_dev->info = &max518_info;
+		indio_dev->attrs = max518_attributes;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/*
diff --git a/drivers/staging/iio/dds/ad5930.c b/drivers/staging/iio/dds/ad5930.c
index 40807d2..655db33 100644
--- a/drivers/staging/iio/dds/ad5930.c
+++ b/drivers/staging/iio/dds/ad5930.c
@@ -82,12 +82,7 @@ static struct attribute *ad5930_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group ad5930_attribute_group = {
-	.attrs = ad5930_attributes,
-};
-
 static const struct iio_info ad5930_info = {
-	.attrs = &ad5930_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
@@ -109,6 +104,7 @@ static int __devinit ad5930_probe(struct spi_device *spi)
 	st->sdev = spi;
 	idev->dev.parent = &spi->dev;
 	idev->info = &ad5930_info;
+	idev->attrs = ad5930_attributes;
 	idev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(idev);
diff --git a/drivers/staging/iio/dds/ad9832.c b/drivers/staging/iio/dds/ad9832.c
index d612d3d..42a1e55 100644
--- a/drivers/staging/iio/dds/ad9832.c
+++ b/drivers/staging/iio/dds/ad9832.c
@@ -192,12 +192,7 @@ static struct attribute *ad9832_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group ad9832_attribute_group = {
-	.attrs = ad9832_attributes,
-};
-
 static const struct iio_info ad9832_info = {
-	.attrs = &ad9832_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
@@ -235,6 +230,7 @@ static int __devinit ad9832_probe(struct spi_device *spi)
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad9832_info;
+	indio_dev->attrs = ad9832_attributes;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* Setup default messages */
diff --git a/drivers/staging/iio/dds/ad9834.c b/drivers/staging/iio/dds/ad9834.c
index 323718b..f68941c 100644
--- a/drivers/staging/iio/dds/ad9834.c
+++ b/drivers/staging/iio/dds/ad9834.c
@@ -296,21 +296,7 @@ static struct attribute *ad9833_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group ad9834_attribute_group = {
-	.attrs = ad9834_attributes,
-};
-
-static const struct attribute_group ad9833_attribute_group = {
-	.attrs = ad9833_attributes,
-};
-
 static const struct iio_info ad9834_info = {
-	.attrs = &ad9834_attribute_group,
-	.driver_module = THIS_MODULE,
-};
-
-static const struct iio_info ad9833_info = {
-	.attrs = &ad9833_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
@@ -347,13 +333,14 @@ static int __devinit ad9834_probe(struct spi_device *spi)
 	st->reg = reg;
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->info = &ad9834_info;
 	switch (st->devid) {
 	case ID_AD9833:
 	case ID_AD9837:
-		indio_dev->info = &ad9833_info;
+		indio_dev->attrs = ad9833_attributes;
 		break;
 	default:
-		indio_dev->info = &ad9834_info;
+		indio_dev->attrs = ad9834_attributes;
 		break;
 	}
 	indio_dev->modes = INDIO_DIRECT_MODE;
diff --git a/drivers/staging/iio/dds/ad9850.c b/drivers/staging/iio/dds/ad9850.c
index 159f6f2..57ec4ee 100644
--- a/drivers/staging/iio/dds/ad9850.c
+++ b/drivers/staging/iio/dds/ad9850.c
@@ -68,12 +68,7 @@ static struct attribute *ad9850_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group ad9850_attribute_group = {
-	.attrs = ad9850_attributes,
-};
-
 static const struct iio_info ad9850_info = {
-	.attrs = &ad9850_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
@@ -95,6 +90,7 @@ static int __devinit ad9850_probe(struct spi_device *spi)
 
 	idev->dev.parent = &spi->dev;
 	idev->info = &ad9850_info;
+	idev->attrs = ad9850_attributes;
 	idev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(idev);
diff --git a/drivers/staging/iio/dds/ad9852.c b/drivers/staging/iio/dds/ad9852.c
index 5a338d2..45e3691 100644
--- a/drivers/staging/iio/dds/ad9852.c
+++ b/drivers/staging/iio/dds/ad9852.c
@@ -217,12 +217,7 @@ static struct attribute *ad9852_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group ad9852_attribute_group = {
-	.attrs = ad9852_attributes,
-};
-
 static const struct iio_info ad9852_info = {
-	.attrs = &ad9852_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
@@ -244,6 +239,7 @@ static int __devinit ad9852_probe(struct spi_device *spi)
 
 	idev->dev.parent = &spi->dev;
 	idev->info = &ad9852_info;
+	idev->attrs = ad9852_attributes;
 	idev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(idev);
diff --git a/drivers/staging/iio/dds/ad9910.c b/drivers/staging/iio/dds/ad9910.c
index a87ba84..96ad7a5 100644
--- a/drivers/staging/iio/dds/ad9910.c
+++ b/drivers/staging/iio/dds/ad9910.c
@@ -352,12 +352,7 @@ static struct attribute *ad9910_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group ad9910_attribute_group = {
-	.attrs = ad9910_attributes,
-};
-
 static const struct iio_info ad9910_info = {
-	.attrs = &ad9910_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
@@ -379,6 +374,7 @@ static int __devinit ad9910_probe(struct spi_device *spi)
 
 	idev->dev.parent = &spi->dev;
 	idev->info = &ad9910_info;
+	idev->attrs = ad9910_attributes;
 	idev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(idev);
diff --git a/drivers/staging/iio/dds/ad9951.c b/drivers/staging/iio/dds/ad9951.c
index 42aea15..3d43a72 100644
--- a/drivers/staging/iio/dds/ad9951.c
+++ b/drivers/staging/iio/dds/ad9951.c
@@ -161,12 +161,7 @@ static struct attribute *ad9951_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group ad9951_attribute_group = {
-	.attrs = ad9951_attributes,
-};
-
 static const struct iio_info ad9951_info = {
-	.attrs = &ad9951_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
@@ -189,6 +184,7 @@ static int __devinit ad9951_probe(struct spi_device *spi)
 	idev->dev.parent = &spi->dev;
 
 	idev->info = &ad9951_info;
+	idev->attrs = ad9951_attributes;
 	idev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(idev);
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index 871f76b..04266d98 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -562,12 +562,7 @@ static struct attribute *adis16260_attributes[] = {
 	NULL
 };
 
-static const struct attribute_group adis16260_attribute_group = {
-	.attrs = adis16260_attributes,
-};
-
 static const struct iio_info adis16260_info = {
-	.attrs = &adis16260_attribute_group,
 	.read_raw = &adis16260_read_raw,
 	.write_raw = &adis16260_write_raw,
 	.driver_module = THIS_MODULE,
@@ -598,6 +593,7 @@ static int __devinit adis16260_probe(struct spi_device *spi)
 	indio_dev->name = spi_get_device_id(st->us)->name;
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->info = &adis16260_info;
+	indio_dev->attrs = adis16260_attributes;
 	indio_dev->num_channels
 		= ARRAY_SIZE(adis16260_channels_x);
 	if (pd && pd->direction)
diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index be6ced3..b512343 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -210,8 +210,6 @@ struct iio_dev;
  * struct iio_info - constant information about device
  * @driver_module:	module structure used to ensure correct
  *			ownership of chrdevs etc
- * @event_attrs:	event control attributes
- * @attrs:		general purpose device attributes
  * @read_raw:		function to request a value from the device.
  *			mask specifies which value. Note 0 means a reading of
  *			the channel in question.  Return value will specify the
@@ -233,8 +231,6 @@ struct iio_dev;
  **/
 struct iio_info {
 	struct module			*driver_module;
-	struct attribute_group		*event_attrs;
-	const struct attribute_group	*attrs;
 
 	int (*read_raw)(struct iio_dev *indio_dev,
 			struct iio_chan_spec const *chan,
@@ -310,6 +306,8 @@ struct iio_buffer_setup_ops {
  * @chan_attr_group:	[INTERN] group for all attrs in base directory
  * @name:		[DRIVER] name of the device.
  * @info:		[DRIVER] callbacks and constant info from driver
+ * @event_attrs:	event control attributes
+ * @attrs:		general purpose device attributes
  * @chrdev:		[INTERN] associated character device
  * @groups:		[INTERN] attribute groups
  * @groupcounter:	[INTERN] index of next attribute group
@@ -340,6 +338,8 @@ struct iio_dev {
 	struct attribute_group		chan_attr_group;
 	const char			*name;
 	const struct iio_info		*info;
+	struct attribute		**event_attrs;
+	struct attribute		**attrs;
 	const struct iio_buffer_setup_ops	*setup_ops;
 	struct cdev			chrdev;
 #define IIO_MAX_GROUPS 6
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index f02d1c0..74865c3 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -479,10 +479,6 @@ static struct attribute *ad5933_attributes[] = {
 	NULL
 };
 
-static const struct attribute_group ad5933_attribute_group = {
-	.attrs = ad5933_attributes,
-};
-
 static int ad5933_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val,
@@ -530,7 +526,6 @@ out:
 
 static const struct iio_info ad5933_info = {
 	.read_raw = &ad5933_read_raw,
-	.attrs = &ad5933_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
@@ -721,6 +716,7 @@ static int __devinit ad5933_probe(struct i2c_client *client,
 
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->info = &ad5933_info;
+	indio_dev->attrs = ad5933_attributes;
 	indio_dev->name = id->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ad5933_channels;
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index de12f9a..6002dff 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -1029,10 +1029,6 @@ static struct attribute *adis16400_attributes[] = {
 	NULL
 };
 
-static const struct attribute_group adis16400_attribute_group = {
-	.attrs = adis16400_attributes,
-};
-
 static struct adis16400_chip_info adis16400_chips[] = {
 	[ADIS16300] = {
 		.channels = adis16300_channels,
@@ -1115,7 +1111,6 @@ static const struct iio_info adis16400_info = {
 	.driver_module = THIS_MODULE,
 	.read_raw = &adis16400_read_raw,
 	.write_raw = &adis16400_write_raw,
-	.attrs = &adis16400_attribute_group,
 };
 
 static int __devinit adis16400_probe(struct spi_device *spi)
@@ -1141,6 +1136,7 @@ static int __devinit adis16400_probe(struct spi_device *spi)
 	indio_dev->channels = st->variant->channels;
 	indio_dev->num_channels = st->variant->num_channels;
 	indio_dev->info = &adis16400_info;
+	indio_dev->attrs = adis16400_attributes;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = adis16400_configure_ring(indio_dev);
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index e4824fe..b06eced 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -486,8 +486,8 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
 	struct attribute **attr;
 
 	/* First count elements in any existing group */
-	if (indio_dev->info->attrs) {
-		attr = indio_dev->info->attrs->attrs;
+	if (indio_dev->attrs) {
+		attr = indio_dev->attrs;
 		while (*attr++ != NULL)
 			attrcount_orig++;
 	}
@@ -518,9 +518,9 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
 		goto error_clear_attrs;
 	}
 	/* Copy across original attributes */
-	if (indio_dev->info->attrs)
+	if (indio_dev->attrs)
 		memcpy(indio_dev->chan_attr_group.attrs,
-		       indio_dev->info->attrs->attrs,
+		       indio_dev->attrs,
 		       sizeof(indio_dev->chan_attr_group.attrs[0])
 		       *attrcount_orig);
 	attrn = attrcount_orig;
diff --git a/drivers/staging/iio/industrialio-event.c b/drivers/staging/iio/industrialio-event.c
index 5e461e1..fcef13b 100644
--- a/drivers/staging/iio/industrialio-event.c
+++ b/drivers/staging/iio/industrialio-event.c
@@ -383,7 +383,7 @@ int iio_device_register_eventset(struct iio_dev *indio_dev)
 	int ret = 0, attrcount_orig = 0, attrcount, attrn;
 	struct attribute **attr;
 
-	if (!(indio_dev->info->event_attrs ||
+	if (!(indio_dev->event_attrs ||
 	      iio_check_for_dynamic_events(indio_dev)))
 		return 0;
 
@@ -395,8 +395,8 @@ int iio_device_register_eventset(struct iio_dev *indio_dev)
 	}
 
 	iio_setup_ev_int(indio_dev->event_interface);
-	if (indio_dev->info->event_attrs != NULL) {
-		attr = indio_dev->info->event_attrs->attrs;
+	if (indio_dev->event_attrs != NULL) {
+		attr = indio_dev->event_attrs;
 		while (*attr++ != NULL)
 			attrcount_orig++;
 	}
@@ -416,9 +416,9 @@ int iio_device_register_eventset(struct iio_dev *indio_dev)
 		ret = -ENOMEM;
 		goto error_free_setup_event_lines;
 	}
-	if (indio_dev->info->event_attrs)
+	if (indio_dev->event_attrs)
 		memcpy(indio_dev->event_interface->group.attrs,
-		       indio_dev->info->event_attrs->attrs,
+		       indio_dev->event_attrs,
 		       sizeof(indio_dev->event_interface->group.attrs[0])
 		       *attrcount_orig);
 	attrn = attrcount_orig;
diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index f0c733a..6de2cca 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -452,10 +452,6 @@ static struct attribute *isl29018_attributes[] = {
 	NULL
 };
 
-static const struct attribute_group isl29108_group = {
-	.attrs = isl29018_attributes,
-};
-
 static int isl29018_chip_init(struct i2c_client *client)
 {
 	struct isl29018_chip *chip = iio_priv(i2c_get_clientdata(client));
@@ -521,7 +517,6 @@ static int isl29018_chip_init(struct i2c_client *client)
 }
 
 static const struct iio_info isl29108_info = {
-	.attrs = &isl29108_group,
 	.driver_module = THIS_MODULE,
 	.read_raw = &isl29018_read_raw,
 	.write_raw = &isl29018_write_raw,
@@ -556,6 +551,7 @@ static int __devinit isl29018_probe(struct i2c_client *client,
 		goto exit_iio_free;
 
 	indio_dev->info = &isl29108_info;
+	indio_dev->attrs = isl29018_attributes;
 	indio_dev->channels = isl29018_channels;
 	indio_dev->num_channels = ARRAY_SIZE(isl29018_channels);
 	indio_dev->name = id->name;
diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 25f4c1d..60445c4 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -780,10 +780,6 @@ static struct attribute *sysfs_attrs_ctrl[] = {
 	NULL
 };
 
-static struct attribute_group tsl2583_attribute_group = {
-	.attrs = sysfs_attrs_ctrl,
-};
-
 /* Use the default register values to identify the Taos device */
 static int taos_tsl258x_device(unsigned char *bufp)
 {
@@ -791,7 +787,6 @@ static int taos_tsl258x_device(unsigned char *bufp)
 }
 
 static const struct iio_info tsl2583_info = {
-	.attrs = &tsl2583_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
@@ -861,6 +856,7 @@ static int __devinit taos_probe(struct i2c_client *clientp,
 	}
 
 	indio_dev->info = &tsl2583_info;
+	indio_dev->attrs = sysfs_attrs_ctrl;
 	indio_dev->dev.parent = &clientp->dev;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->name = chip->client->name;
diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
index a2c4d00..34dbac3 100644
--- a/drivers/staging/iio/magnetometer/ak8975.c
+++ b/drivers/staging/iio/magnetometer/ak8975.c
@@ -88,7 +88,6 @@
  */
 struct ak8975_data {
 	struct i2c_client	*client;
-	struct attribute_group	attrs;
 	struct mutex		lock;
 	u8			asa[3];
 	long			raw_to_gauss[3];
@@ -458,12 +457,7 @@ static struct attribute *ak8975_attr[] = {
 	NULL
 };
 
-static struct attribute_group ak8975_attr_group = {
-	.attrs = ak8975_attr,
-};
-
 static const struct iio_info ak8975_info = {
-	.attrs = &ak8975_attr_group,
 	.read_raw = &ak8975_read_raw,
 	.driver_module = THIS_MODULE,
 };
@@ -525,6 +519,7 @@ static int ak8975_probe(struct i2c_client *client,
 	indio_dev->channels = ak8975_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ak8975_channels);
 	indio_dev->info = &ak8975_info;
+	indio_dev->attrs = ak8975_attr;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	err = iio_device_register(indio_dev);
diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index b492a0c..975423f 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -495,10 +495,6 @@ static struct attribute *hmc5843_attributes[] = {
 	NULL
 };
 
-static const struct attribute_group hmc5843_group = {
-	.attrs = hmc5843_attributes,
-};
-
 static int hmc5843_detect(struct i2c_client *client,
 			  struct i2c_board_info *info)
 {
@@ -531,7 +527,6 @@ static void hmc5843_init_client(struct i2c_client *client)
 }
 
 static const struct iio_info hmc5843_info = {
-	.attrs = &hmc5843_group,
 	.read_raw = &hmc5843_read_raw,
 	.driver_module = THIS_MODULE,
 };
@@ -561,6 +556,7 @@ static int hmc5843_probe(struct i2c_client *client,
 	hmc5843_init_client(client);
 
 	indio_dev->info = &hmc5843_info;
+	indio_dev->attrs = hmc5843_attributes;
 	indio_dev->name = id->name;
 	indio_dev->channels = hmc5843_channels;
 	indio_dev->num_channels = ARRAY_SIZE(hmc5843_channels);
diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
index 62a879c..00f75a6 100644
--- a/drivers/staging/iio/meter/ade7753.c
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -501,12 +501,7 @@ static struct attribute *ade7753_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group ade7753_attribute_group = {
-	.attrs = ade7753_attributes,
-};
-
 static const struct iio_info ade7753_info = {
-	.attrs = &ade7753_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
@@ -532,6 +527,7 @@ static int __devinit ade7753_probe(struct spi_device *spi)
 	indio_dev->name = spi->dev.driver->name;
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->info = &ade7753_info;
+	indio_dev->attrs = ade7753_attributes;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* Get the device into a sane initial state */
diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
index 0111edb..bbf9623 100644
--- a/drivers/staging/iio/meter/ade7754.c
+++ b/drivers/staging/iio/meter/ade7754.c
@@ -524,12 +524,7 @@ static struct attribute *ade7754_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group ade7754_attribute_group = {
-	.attrs = ade7754_attributes,
-};
-
 static const struct iio_info ade7754_info = {
-	.attrs = &ade7754_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
@@ -555,6 +550,7 @@ static int __devinit ade7754_probe(struct spi_device *spi)
 	indio_dev->name = spi->dev.driver->name;
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->info = &ade7754_info;
+	indio_dev->attrs = ade7754_attributes;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* Get the device into a sane initial state */
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 9dc881f..88bc2ba 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -657,10 +657,6 @@ static struct attribute *ade7758_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group ade7758_attribute_group = {
-	.attrs = ade7758_attributes,
-};
-
 static struct iio_chan_spec ade7758_channels[] = {
 	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, "raw", 0, 0,
 		IIO_CHAN_INFO_SCALE_SHARED_BIT,
@@ -726,7 +722,6 @@ static struct iio_chan_spec ade7758_channels[] = {
 };
 
 static const struct iio_info ade7758_info = {
-	.attrs = &ade7758_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
@@ -763,6 +758,7 @@ static int __devinit ade7758_probe(struct spi_device *spi)
 	indio_dev->name = spi->dev.driver->name;
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->info = &ade7758_info;
+	indio_dev->attrs = ade7758_attributes;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	for (i = 0; i < AD7758_NUM_WAVESRC; i++)
diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index e7fcc7d..04be04e 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -447,12 +447,7 @@ static struct attribute *ade7759_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group ade7759_attribute_group = {
-	.attrs = ade7759_attributes,
-};
-
 static const struct iio_info ade7759_info = {
-	.attrs = &ade7759_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
@@ -477,6 +472,7 @@ static int __devinit ade7759_probe(struct spi_device *spi)
 	indio_dev->name = spi->dev.driver->name;
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->info = &ade7759_info;
+	indio_dev->attrs = ade7759_attributes;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* Get the device into a sane initial state */
diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
index 49c01c5..338343a 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -547,12 +547,7 @@ static struct attribute *ade7854_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group ade7854_attribute_group = {
-	.attrs = ade7854_attributes,
-};
-
 static const struct iio_info ade7854_info = {
-	.attrs = &ade7854_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
@@ -565,6 +560,7 @@ int ade7854_probe(struct iio_dev *indio_dev, struct device *dev)
 
 	indio_dev->dev.parent = dev;
 	indio_dev->info = &ade7854_info;
+	indio_dev->attrs = ade7854_attributes;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(indio_dev);
diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 8996c98..c7df19f 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -604,10 +604,6 @@ static struct attribute *ad2s1210_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group ad2s1210_attribute_group = {
-	.attrs = ad2s1210_attributes,
-};
-
 static int __devinit ad2s1210_initial(struct ad2s1210_state *st)
 {
 	unsigned char data;
@@ -647,7 +643,6 @@ error_ret:
 
 static const struct iio_info ad2s1210_info = {
 	.read_raw = &ad2s1210_read_raw,
-	.attrs = &ad2s1210_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
@@ -710,6 +705,7 @@ static int __devinit ad2s1210_probe(struct spi_device *spi)
 
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->info = &ad2s1210_info;
+	indio_dev->attrs = ad2s1210_attributes;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ad2s1210_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad2s1210_channels);
-- 
1.7.7.4
