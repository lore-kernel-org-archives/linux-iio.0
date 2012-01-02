Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: pirmin.duss@flytec.ch,
	lars@metafoo.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 6/6] staging:iio:treewide make attrs and event_attrs entries struct attribute *
Date: Mon,  2 Jan 2012 17:25:23 +0000
Message-Id: <1325525123-31158-7-git-send-email-jic23@kernel.org>
In-Reply-To: <1325525123-31158-1-git-send-email-jic23@kernel.org>
References: <1325525123-31158-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

They were previously struct attribute_group, but are copied internally
into another attribute_group.

Also clear out a rather odd unused attribute_group in ak8975.
No idea where that came from.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/adis16201_core.c      |    6 +----
 drivers/staging/iio/accel/adis16203_core.c      |    6 +----
 drivers/staging/iio/accel/adis16204_core.c      |    6 +----
 drivers/staging/iio/accel/adis16209_core.c      |    6 +----
 drivers/staging/iio/accel/adis16220_core.c      |    6 +----
 drivers/staging/iio/accel/adis16240_core.c      |    6 +----
 drivers/staging/iio/accel/kxsd9.c               |    6 +----
 drivers/staging/iio/accel/lis3l02dq_core.c      |    6 +----
 drivers/staging/iio/accel/sca3000_core.c        |   19 ++--------------
 drivers/staging/iio/adc/ad7192.c                |   12 +--------
 drivers/staging/iio/adc/ad7280a.c               |   12 +--------
 drivers/staging/iio/adc/ad7291.c                |   12 +--------
 drivers/staging/iio/adc/ad7606_core.c           |   18 ++-------------
 drivers/staging/iio/adc/ad7793.c                |    6 +----
 drivers/staging/iio/adc/ad7816.c                |   13 +---------
 drivers/staging/iio/adc/ad799x.h                |    1 -
 drivers/staging/iio/adc/ad799x_core.c           |   14 +----------
 drivers/staging/iio/adc/adt7310.c               |   13 +---------
 drivers/staging/iio/adc/adt7410.c               |   13 +---------
 drivers/staging/iio/adc/max1363_core.c          |   10 +--------
 drivers/staging/iio/addac/adt7316.c             |   26 +++-------------------
 drivers/staging/iio/cdc/ad7150.c                |    7 +-----
 drivers/staging/iio/cdc/ad7152.c                |    6 +----
 drivers/staging/iio/cdc/ad7746.c                |    6 +----
 drivers/staging/iio/dac/ad5064.c                |    6 +----
 drivers/staging/iio/dac/ad5360.c                |    6 +----
 drivers/staging/iio/dac/ad5380.c                |    6 +----
 drivers/staging/iio/dac/ad5446.c                |    6 +----
 drivers/staging/iio/dac/ad5504.c                |   21 +++---------------
 drivers/staging/iio/dac/ad5624r_spi.c           |    6 +----
 drivers/staging/iio/dac/ad5686.c                |    6 +----
 drivers/staging/iio/dac/ad5791.c                |    6 +----
 drivers/staging/iio/dac/max517.c                |   12 +--------
 drivers/staging/iio/dds/ad5930.c                |    6 +----
 drivers/staging/iio/dds/ad9832.c                |    6 +----
 drivers/staging/iio/dds/ad9834.c                |   12 +--------
 drivers/staging/iio/dds/ad9850.c                |    6 +----
 drivers/staging/iio/dds/ad9852.c                |    6 +----
 drivers/staging/iio/dds/ad9910.c                |    6 +----
 drivers/staging/iio/dds/ad9951.c                |    6 +----
 drivers/staging/iio/gyro/adis16260_core.c       |    6 +----
 drivers/staging/iio/iio.h                       |    4 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c |    6 +----
 drivers/staging/iio/imu/adis16400_core.c        |    6 +----
 drivers/staging/iio/industrialio-core.c         |    4 +-
 drivers/staging/iio/industrialio-event.c        |    4 +-
 drivers/staging/iio/light/isl29018.c            |    6 +----
 drivers/staging/iio/light/tsl2583.c             |    6 +----
 drivers/staging/iio/magnetometer/ak8975.c       |    7 +-----
 drivers/staging/iio/magnetometer/hmc5843.c      |    6 +----
 drivers/staging/iio/meter/ade7753.c             |    6 +----
 drivers/staging/iio/meter/ade7754.c             |    6 +----
 drivers/staging/iio/meter/ade7758_core.c        |    6 +----
 drivers/staging/iio/meter/ade7759.c             |    6 +----
 drivers/staging/iio/meter/ade7854.c             |    6 +----
 drivers/staging/iio/resolver/ad2s1210.c         |    6 +----
 56 files changed, 77 insertions(+), 373 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
index ed97da2..d2850b3 100644
--- a/drivers/staging/iio/accel/adis16201_core.c
+++ b/drivers/staging/iio/accel/adis16201_core.c
@@ -449,12 +449,8 @@ static struct attribute *adis16201_attributes[] = {
 	NULL
 };
 
-static const struct attribute_group adis16201_attribute_group = {
-	.attrs = adis16201_attributes,
-};
-
 static const struct iio_info adis16201_info = {
-	.attrs = &adis16201_attribute_group,
+	.attrs = adis16201_attributes,
 	.read_raw = &adis16201_read_raw,
 	.write_raw = &adis16201_write_raw,
 	.driver_module = THIS_MODULE,
diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index 41fe930..c8881b3 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -405,12 +405,8 @@ static struct attribute *adis16203_attributes[] = {
 	NULL
 };
 
-static const struct attribute_group adis16203_attribute_group = {
-	.attrs = adis16203_attributes,
-};
-
 static const struct iio_info adis16203_info = {
-	.attrs = &adis16203_attribute_group,
+	.attrs = adis16203_attributes,
 	.read_raw = &adis16203_read_raw,
 	.write_raw = &adis16203_write_raw,
 	.driver_module = THIS_MODULE,
diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index fcab806..32946b4 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -480,12 +480,8 @@ static struct attribute *adis16204_attributes[] = {
 	NULL
 };
 
-static const struct attribute_group adis16204_attribute_group = {
-	.attrs = adis16204_attributes,
-};
-
 static const struct iio_info adis16204_info = {
-	.attrs = &adis16204_attribute_group,
+	.attrs = adis16204_attributes,
 	.read_raw = &adis16204_read_raw,
 	.write_raw = &adis16204_write_raw,
 	.driver_module = THIS_MODULE,
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index 4ad33ec..2a07b72 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -453,12 +453,8 @@ static struct attribute *adis16209_attributes[] = {
 	NULL
 };
 
-static const struct attribute_group adis16209_attribute_group = {
-	.attrs = adis16209_attributes,
-};
-
 static const struct iio_info adis16209_info = {
-	.attrs = &adis16209_attribute_group,
+	.attrs = adis16209_attributes,
 	.read_raw = &adis16209_read_raw,
 	.write_raw = &adis16209_write_raw,
 	.driver_module = THIS_MODULE,
diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
index d0587e2..5a2cd16 100644
--- a/drivers/staging/iio/accel/adis16220_core.c
+++ b/drivers/staging/iio/accel/adis16220_core.c
@@ -612,12 +612,8 @@ static struct attribute *adis16220_attributes[] = {
 	NULL
 };
 
-static const struct attribute_group adis16220_attribute_group = {
-	.attrs = adis16220_attributes,
-};
-
 static const struct iio_info adis16220_info = {
-	.attrs = &adis16220_attribute_group,
+	.attrs = adis16220_attributes,
 	.driver_module = THIS_MODULE,
 	.read_raw = &adis16220_read_raw,
 };
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index 4298c40..e57ffac 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -505,12 +505,8 @@ static struct attribute *adis16240_attributes[] = {
 	NULL
 };
 
-static const struct attribute_group adis16240_attribute_group = {
-	.attrs = adis16240_attributes,
-};
-
 static const struct iio_info adis16240_info = {
-	.attrs = &adis16240_attribute_group,
+	.attrs = adis16240_attributes,
 	.read_raw = &adis16240_read_raw,
 	.write_raw = &adis16240_write_raw,
 	.driver_module = THIS_MODULE,
diff --git a/drivers/staging/iio/accel/kxsd9.c b/drivers/staging/iio/accel/kxsd9.c
index 5a543fa..a5188bd 100644
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
@@ -216,7 +212,7 @@ static int __devinit kxsd9_power_up(struct kxsd9_state *st)
 static const struct iio_info kxsd9_info = {
 	.read_raw = &kxsd9_read_raw,
 	.write_raw = &kxsd9_write_raw,
-	.attrs = &kxsd9_attribute_group,
+	.attrs = kxsd9_attributes,
 	.driver_module = THIS_MODULE,
 };
 
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index 3d99f8b..d203615 100644
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
@@ -657,7 +653,7 @@ static const struct iio_info lis3l02dq_info = {
 	.write_event_config = &lis3l02dq_write_event_config,
 	.read_event_config = &lis3l02dq_read_event_config,
 	.driver_module = THIS_MODULE,
-	.attrs = &lis3l02dq_attribute_group,
+	.attrs = lis3l02dq_attributes,
 };
 
 static int __devinit lis3l02dq_probe(struct spi_device *spi)
diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 1f30108..09eb109 100644
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
@@ -1105,9 +1092,9 @@ error_ret:
 }
 
 static const struct iio_info sca3000_info = {
-	.attrs = &sca3000_attribute_group,
+	.attrs = sca3000_attributes,
 	.read_raw = &sca3000_read_raw,
-	.event_attrs = &sca3000_event_attribute_group,
+	.event_attrs = sca3000_event_attributes,
 	.read_event_value = &sca3000_read_thresh,
 	.write_event_value = &sca3000_write_thresh,
 	.read_event_config = &sca3000_read_event_config,
@@ -1116,7 +1103,7 @@ static const struct iio_info sca3000_info = {
 };
 
 static const struct iio_info sca3000_info_with_temp = {
-	.attrs = &sca3000_attribute_group_with_temp,
+	.attrs = sca3000_attributes_with_temp,
 	.read_raw = &sca3000_read_raw,
 	.read_event_value = &sca3000_read_thresh,
 	.write_event_value = &sca3000_write_thresh,
diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 881c5e5..f2e7052 100644
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
@@ -962,7 +954,7 @@ static const struct iio_info ad7192_info = {
 	.read_raw = &ad7192_read_raw,
 	.write_raw = &ad7192_write_raw,
 	.write_raw_get_fmt = &ad7192_write_raw_get_fmt,
-	.attrs = &ad7192_attribute_group,
+	.attrs = ad7192_attributes,
 	.validate_trigger = ad7192_validate_trigger,
 	.driver_module = THIS_MODULE,
 };
@@ -971,7 +963,7 @@ static const struct iio_info ad7195_info = {
 	.read_raw = &ad7192_read_raw,
 	.write_raw = &ad7192_write_raw,
 	.write_raw_get_fmt = &ad7192_write_raw_get_fmt,
-	.attrs = &ad7195_attribute_group,
+	.attrs = ad7195_attributes,
 	.validate_trigger = ad7192_validate_trigger,
 	.driver_module = THIS_MODULE,
 };
diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 941db3a..5e97064 100644
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
@@ -818,8 +810,8 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info ad7280_info = {
 	.read_raw = &ad7280_read_raw,
-	.event_attrs = &ad7280_event_attrs_group,
-	.attrs = &ad7280_attrs_group,
+	.event_attrs = ad7280_event_attributes,
+	.attrs = ad7280_attributes,
 	.driver_module = THIS_MODULE,
 };
 
diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index c4977a7..7f43071 100644
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
@@ -564,18 +560,14 @@ static const struct iio_chan_spec ad7291_channels[] = {
 	}
 };
 
-static struct attribute_group ad7291_event_attribute_group = {
-	.attrs = ad7291_event_attributes,
-};
-
 static const struct iio_info ad7291_info = {
-	.attrs = &ad7291_attribute_group,
+	.attrs = ad7291_attributes,
 	.read_raw = &ad7291_read_raw,
 	.read_event_config = &ad7291_read_event_config,
 	.write_event_config = &ad7291_write_event_config,
 	.read_event_value = &ad7291_read_event_value,
 	.write_event_value = &ad7291_write_event_value,
-	.event_attrs = &ad7291_event_attribute_group,
+	.event_attrs = ad7291_event_attributes,
 };
 
 static int __devinit ad7291_probe(struct i2c_client *client,
diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index 97e8d3d..ea18586 100644
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
@@ -437,19 +425,19 @@ static const struct iio_info ad7606_info_no_os_or_range = {
 static const struct iio_info ad7606_info_os_and_range = {
 	.driver_module = THIS_MODULE,
 	.read_raw = &ad7606_read_raw,
-	.attrs = &ad7606_attribute_group_os_and_range,
+	.attrs = ad7606_attributes_os_and_range,
 };
 
 static const struct iio_info ad7606_info_os = {
 	.driver_module = THIS_MODULE,
 	.read_raw = &ad7606_read_raw,
-	.attrs = &ad7606_attribute_group_os,
+	.attrs = ad7606_attributes_os,
 };
 
 static const struct iio_info ad7606_info_range = {
 	.driver_module = THIS_MODULE,
 	.read_raw = &ad7606_read_raw,
-	.attrs = &ad7606_attribute_group_range,
+	.attrs = ad7606_attributes_range,
 };
 
 struct iio_dev *ad7606_probe(struct device *dev, int irq,
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index accf325..4a92235 100644
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
@@ -748,7 +744,7 @@ static const struct iio_info ad7793_info = {
 	.read_raw = &ad7793_read_raw,
 	.write_raw = &ad7793_write_raw,
 	.write_raw_get_fmt = &ad7793_write_raw_get_fmt,
-	.attrs = &ad7793_attribute_group,
+	.attrs = ad7793_attributes,
 	.validate_trigger = ad7793_validate_trigger,
 	.driver_module = THIS_MODULE,
 };
diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index a38a1a9..9977d83 100644
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
@@ -326,14 +322,9 @@ static struct attribute *ad7816_event_attributes[] = {
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
+	.attrs = ad7816_attributes,
+	.event_attrs = ad7816_event_attributes,
 	.driver_module = THIS_MODULE,
 };
 
diff --git a/drivers/staging/iio/adc/ad799x.h b/drivers/staging/iio/adc/ad799x.h
index 356f690..88382e8 100644
--- a/drivers/staging/iio/adc/ad799x.h
+++ b/drivers/staging/iio/adc/ad799x.h
@@ -90,7 +90,6 @@ struct ad799x_state;
  * @int_vref_mv:	the internal reference voltage
  * @monitor_mode:	whether the chip supports monitor interrupts
  * @default_config:	device default configuration
- * @event_attrs:	pointer to the monitor event attribute group
  */
 
 struct ad799x_chip_info {
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 815e6b9..094b7ed 100644
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
@@ -416,11 +411,6 @@ static struct attribute *ad7992_event_attributes[] = {
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
@@ -428,7 +418,7 @@ static const struct iio_info ad7991_info = {
 
 static const struct iio_info ad7992_info = {
 	.read_raw = &ad799x_read_raw,
-	.event_attrs = &ad7992_event_attrs_group,
+	.event_attrs = ad7992_event_attributes,
 	.read_event_config = &ad799x_read_event_config,
 	.read_event_value = &ad799x_read_event_value,
 	.write_event_value = &ad799x_write_event_value,
@@ -437,7 +427,7 @@ static const struct iio_info ad7992_info = {
 
 static const struct iio_info ad7993_4_7_8_info = {
 	.read_raw = &ad799x_read_raw,
-	.event_attrs = &ad7993_4_7_8_event_attrs_group,
+	.event_attrs = ad7993_4_7_8_event_attributes,
 	.read_event_config = &ad799x_read_event_config,
 	.read_event_value = &ad799x_read_event_value,
 	.write_event_value = &ad799x_write_event_value,
diff --git a/drivers/staging/iio/adc/adt7310.c b/drivers/staging/iio/adc/adt7310.c
index fc6ef6d..507d794 100644
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
@@ -730,14 +726,9 @@ static struct attribute *adt7310_event_int_attributes[] = {
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
+	.attrs = adt7310_attributes,
+	.event_attrs = adt7310_event_int_attributes,
 	.driver_module = THIS_MODULE,
 };
 
diff --git a/drivers/staging/iio/adc/adt7410.c b/drivers/staging/iio/adc/adt7410.c
index 74d28f4..ebf5048 100644
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
@@ -698,14 +694,9 @@ static struct attribute *adt7410_event_int_attributes[] = {
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
+	.attrs = adt7410_attributes,
+	.event_attrs = adt7410_event_int_attributes,
 	.driver_module = THIS_MODULE,
 };
 
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 1ce89ef..83ee0b7 100644
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
@@ -840,7 +832,7 @@ static const struct iio_info max1363_info = {
 	.read_raw = &max1363_read_raw,
 	.update_scan_mode = &max1363_update_scan_mode,
 	.driver_module = THIS_MODULE,
-	.event_attrs = &max1363_event_attribute_group,
+	.event_attrs = max1363_event_attributes,
 };
 
 /* max1363 and max1368 tested - rest from data sheet */
diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 13c3929..6203449 100644
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
@@ -2110,14 +2092,14 @@ EXPORT_SYMBOL(adt7316_enable);
 #endif
 
 static const struct iio_info adt7316_info = {
-	.attrs = &adt7316_attribute_group,
-	.event_attrs = &adt7316_event_attribute_group,
+	.attrs = adt7316_attributes,
+	.event_attrs = adt7316_event_attributes,
 	.driver_module = THIS_MODULE,
 };
 
 static const struct iio_info adt7516_info = {
-	.attrs = &adt7516_attribute_group,
-	.event_attrs = &adt7516_event_attribute_group,
+	.attrs =  adt7516_attributes,
+	.event_attrs = adt7516_event_attributes,
 	.driver_module = THIS_MODULE,
 };
 
diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 6bcdb14..a5d3587 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -530,13 +530,8 @@ static struct attribute *ad7150_event_attributes[] = {
 	NULL,
 };
 
-static struct attribute_group ad7150_event_attribute_group = {
-	.attrs = ad7150_event_attributes,
-	.name = "events",
-};
-
 static const struct iio_info ad7150_info = {
-	.event_attrs = &ad7150_event_attribute_group,
+	.event_attrs = ad7150_event_attributes,
 	.driver_module = THIS_MODULE,
 	.read_raw = &ad7150_read_raw,
 	.read_event_config = &ad7150_read_event_config,
diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
index 29b2dc6..1637638 100644
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
@@ -424,7 +420,7 @@ static int ad7152_write_raw_get_fmt(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info ad7152_info = {
-	.attrs = &ad7152_attribute_group,
+	.attrs = ad7152_attributes,
 	.read_raw = &ad7152_read_raw,
 	.write_raw = &ad7152_write_raw,
 	.write_raw_get_fmt = &ad7152_write_raw_get_fmt,
diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index de8f844..e498532 100644
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
@@ -677,7 +673,7 @@ out:
 }
 
 static const struct iio_info ad7746_info = {
-	.attrs = &ad7746_attribute_group,
+	.attrs = ad7746_attributes,
 	.read_raw = &ad7746_read_raw,
 	.write_raw = &ad7746_write_raw,
 	.driver_module = THIS_MODULE,
diff --git a/drivers/staging/iio/dac/ad5064.c b/drivers/staging/iio/dac/ad5064.c
index 867e4ab..0856879 100644
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
@@ -331,7 +327,7 @@ static int ad5064_write_raw(struct iio_dev *indio_dev,
 static const struct iio_info ad5064_info = {
 	.read_raw = ad5064_read_raw,
 	.write_raw = ad5064_write_raw,
-	.attrs = &ad5064_attribute_group,
+	.attrs = ad5064_attributes,
 	.driver_module = THIS_MODULE,
 };
 
diff --git a/drivers/staging/iio/dac/ad5360.c b/drivers/staging/iio/dac/ad5360.c
index 012d714..2fc292c 100644
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
@@ -425,7 +421,7 @@ static int ad5360_read_raw(struct iio_dev *indio_dev,
 static const struct iio_info ad5360_info = {
 	.read_raw = ad5360_read_raw,
 	.write_raw = ad5360_write_raw,
-	.attrs = &ad5360_attribute_group,
+	.attrs = ad5360_attributes,
 	.driver_module = THIS_MODULE,
 };
 
diff --git a/drivers/staging/iio/dac/ad5380.c b/drivers/staging/iio/dac/ad5380.c
index eff97ae0..bc86457 100644
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
@@ -353,7 +349,7 @@ static int ad5380_read_raw(struct iio_dev *indio_dev,
 static const struct iio_info ad5380_info = {
 	.read_raw = ad5380_read_raw,
 	.write_raw = ad5380_write_raw,
-	.attrs = &ad5380_attribute_group,
+	.attrs = ad5380_attributes,
 	.driver_module = THIS_MODULE,
 };
 
diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
index 05fccff..51a4385 100644
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
@@ -295,7 +291,7 @@ static int ad5446_write_raw(struct iio_dev *indio_dev,
 static const struct iio_info ad5446_info = {
 	.read_raw = ad5446_read_raw,
 	.write_raw = ad5446_write_raw,
-	.attrs = &ad5446_attribute_group,
+	.attrs = ad5446_attributes,
 	.driver_module = THIS_MODULE,
 };
 
diff --git a/drivers/staging/iio/dac/ad5504.c b/drivers/staging/iio/dac/ad5504.c
index f20a5dc..a6118c7 100644
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
@@ -266,16 +253,16 @@ static irqreturn_t ad5504_event_handler(int irq, void *private)
 static const struct iio_info ad5504_info = {
 	.write_raw = ad5504_write_raw,
 	.read_raw = ad5504_read_raw,
-	.attrs = &ad5504_attribute_group,
-	.event_attrs = &ad5504_ev_attribute_group,
+	.attrs = ad5504_attributes,
+	.event_attrs = ad5504_ev_attributes,
 	.driver_module = THIS_MODULE,
 };
 
 static const struct iio_info ad5501_info = {
 	.write_raw = ad5504_write_raw,
 	.read_raw = ad5504_read_raw,
-	.attrs = &ad5501_attribute_group,
-	.event_attrs = &ad5504_ev_attribute_group,
+	.attrs = ad5501_attributes,
+	.event_attrs = ad5504_ev_attributes,
 	.driver_module = THIS_MODULE,
 };
 
diff --git a/drivers/staging/iio/dac/ad5624r_spi.c b/drivers/staging/iio/dac/ad5624r_spi.c
index 6cb00e1..4361609 100644
--- a/drivers/staging/iio/dac/ad5624r_spi.c
+++ b/drivers/staging/iio/dac/ad5624r_spi.c
@@ -238,14 +238,10 @@ static struct attribute *ad5624r_attributes[] = {
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
+	.attrs = ad5624r_attributes,
 	.driver_module = THIS_MODULE,
 };
 
diff --git a/drivers/staging/iio/dac/ad5686.c b/drivers/staging/iio/dac/ad5686.c
index bbaa928..d04bf40 100644
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
@@ -349,7 +345,7 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
 static const struct iio_info ad5686_info = {
 	.read_raw = ad5686_read_raw,
 	.write_raw = ad5686_write_raw,
-	.attrs = &ad5686_attribute_group,
+	.attrs = ad5686_attributes,
 	.driver_module = THIS_MODULE,
 };
 
diff --git a/drivers/staging/iio/dac/ad5791.c b/drivers/staging/iio/dac/ad5791.c
index e919025..9e33669 100644
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
@@ -277,7 +273,7 @@ static int ad5791_write_raw(struct iio_dev *indio_dev,
 static const struct iio_info ad5791_info = {
 	.read_raw = &ad5791_read_raw,
 	.write_raw = &ad5791_write_raw,
-	.attrs = &ad5791_attribute_group,
+	.attrs = ad5791_attributes,
 	.driver_module = THIS_MODULE,
 };
 
diff --git a/drivers/staging/iio/dac/max517.c b/drivers/staging/iio/dac/max517.c
index adfbd20..2a15334 100644
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
@@ -194,12 +186,12 @@ static int max517_resume(struct i2c_client *client)
 }
 
 static const struct iio_info max517_info = {
-	.attrs = &max517_attribute_group,
+	.attrs = max517_attributes,
 	.driver_module = THIS_MODULE,
 };
 
 static const struct iio_info max518_info = {
-	.attrs = &max518_attribute_group,
+	.attrs = max518_attributes,
 	.driver_module = THIS_MODULE,
 };
 
diff --git a/drivers/staging/iio/dds/ad5930.c b/drivers/staging/iio/dds/ad5930.c
index 40807d2..3dfe7da 100644
--- a/drivers/staging/iio/dds/ad5930.c
+++ b/drivers/staging/iio/dds/ad5930.c
@@ -82,12 +82,8 @@ static struct attribute *ad5930_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group ad5930_attribute_group = {
-	.attrs = ad5930_attributes,
-};
-
 static const struct iio_info ad5930_info = {
-	.attrs = &ad5930_attribute_group,
+	.attrs = ad5930_attributes,
 	.driver_module = THIS_MODULE,
 };
 
diff --git a/drivers/staging/iio/dds/ad9832.c b/drivers/staging/iio/dds/ad9832.c
index d612d3d..4af5d96 100644
--- a/drivers/staging/iio/dds/ad9832.c
+++ b/drivers/staging/iio/dds/ad9832.c
@@ -192,12 +192,8 @@ static struct attribute *ad9832_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group ad9832_attribute_group = {
-	.attrs = ad9832_attributes,
-};
-
 static const struct iio_info ad9832_info = {
-	.attrs = &ad9832_attribute_group,
+	.attrs = ad9832_attributes,
 	.driver_module = THIS_MODULE,
 };
 
diff --git a/drivers/staging/iio/dds/ad9834.c b/drivers/staging/iio/dds/ad9834.c
index 80b1668..5c105bc 100644
--- a/drivers/staging/iio/dds/ad9834.c
+++ b/drivers/staging/iio/dds/ad9834.c
@@ -296,21 +296,13 @@ static struct attribute *ad9833_attributes[] = {
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
+	.attrs = ad9834_attributes,
 	.driver_module = THIS_MODULE,
 };
 
 static const struct iio_info ad9833_info = {
-	.attrs = &ad9833_attribute_group,
+	.attrs = ad9833_attributes,
 	.driver_module = THIS_MODULE,
 };
 
diff --git a/drivers/staging/iio/dds/ad9850.c b/drivers/staging/iio/dds/ad9850.c
index 159f6f2..74f4fc9 100644
--- a/drivers/staging/iio/dds/ad9850.c
+++ b/drivers/staging/iio/dds/ad9850.c
@@ -68,12 +68,8 @@ static struct attribute *ad9850_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group ad9850_attribute_group = {
-	.attrs = ad9850_attributes,
-};
-
 static const struct iio_info ad9850_info = {
-	.attrs = &ad9850_attribute_group,
+	.attrs = ad9850_attributes,
 	.driver_module = THIS_MODULE,
 };
 
diff --git a/drivers/staging/iio/dds/ad9852.c b/drivers/staging/iio/dds/ad9852.c
index 5a338d2..c302445 100644
--- a/drivers/staging/iio/dds/ad9852.c
+++ b/drivers/staging/iio/dds/ad9852.c
@@ -217,12 +217,8 @@ static struct attribute *ad9852_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group ad9852_attribute_group = {
-	.attrs = ad9852_attributes,
-};
-
 static const struct iio_info ad9852_info = {
-	.attrs = &ad9852_attribute_group,
+	.attrs = ad9852_attributes,
 	.driver_module = THIS_MODULE,
 };
 
diff --git a/drivers/staging/iio/dds/ad9910.c b/drivers/staging/iio/dds/ad9910.c
index a87ba84..04d75a3 100644
--- a/drivers/staging/iio/dds/ad9910.c
+++ b/drivers/staging/iio/dds/ad9910.c
@@ -352,12 +352,8 @@ static struct attribute *ad9910_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group ad9910_attribute_group = {
-	.attrs = ad9910_attributes,
-};
-
 static const struct iio_info ad9910_info = {
-	.attrs = &ad9910_attribute_group,
+	.attrs = ad9910_attributes,
 	.driver_module = THIS_MODULE,
 };
 
diff --git a/drivers/staging/iio/dds/ad9951.c b/drivers/staging/iio/dds/ad9951.c
index 42aea15..febabfe 100644
--- a/drivers/staging/iio/dds/ad9951.c
+++ b/drivers/staging/iio/dds/ad9951.c
@@ -161,12 +161,8 @@ static struct attribute *ad9951_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group ad9951_attribute_group = {
-	.attrs = ad9951_attributes,
-};
-
 static const struct iio_info ad9951_info = {
-	.attrs = &ad9951_attribute_group,
+	.attrs = ad9951_attributes,
 	.driver_module = THIS_MODULE,
 };
 
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index 871f76b..8270166 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -562,12 +562,8 @@ static struct attribute *adis16260_attributes[] = {
 	NULL
 };
 
-static const struct attribute_group adis16260_attribute_group = {
-	.attrs = adis16260_attributes,
-};
-
 static const struct iio_info adis16260_info = {
-	.attrs = &adis16260_attribute_group,
+	.attrs = adis16260_attributes,
 	.read_raw = &adis16260_read_raw,
 	.write_raw = &adis16260_write_raw,
 	.driver_module = THIS_MODULE,
diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index be6ced3..642788e 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -233,8 +233,8 @@ struct iio_dev;
  **/
 struct iio_info {
 	struct module			*driver_module;
-	struct attribute_group		*event_attrs;
-	const struct attribute_group	*attrs;
+	struct attribute		**event_attrs;
+	struct attribute		**attrs;
 
 	int (*read_raw)(struct iio_dev *indio_dev,
 			struct iio_chan_spec const *chan,
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index f02d1c0..5338ba2 100644
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
@@ -530,7 +526,7 @@ out:
 
 static const struct iio_info ad5933_info = {
 	.read_raw = &ad5933_read_raw,
-	.attrs = &ad5933_attribute_group,
+	.attrs = ad5933_attributes,
 	.driver_module = THIS_MODULE,
 };
 
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index de12f9a..ae548d7 100644
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
@@ -1115,7 +1111,7 @@ static const struct iio_info adis16400_info = {
 	.driver_module = THIS_MODULE,
 	.read_raw = &adis16400_read_raw,
 	.write_raw = &adis16400_write_raw,
-	.attrs = &adis16400_attribute_group,
+	.attrs = adis16400_attributes,
 };
 
 static int __devinit adis16400_probe(struct spi_device *spi)
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index e4824fe..e338fc6 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -487,7 +487,7 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
 
 	/* First count elements in any existing group */
 	if (indio_dev->info->attrs) {
-		attr = indio_dev->info->attrs->attrs;
+		attr = indio_dev->info->attrs;
 		while (*attr++ != NULL)
 			attrcount_orig++;
 	}
@@ -520,7 +520,7 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
 	/* Copy across original attributes */
 	if (indio_dev->info->attrs)
 		memcpy(indio_dev->chan_attr_group.attrs,
-		       indio_dev->info->attrs->attrs,
+		       indio_dev->info->attrs,
 		       sizeof(indio_dev->chan_attr_group.attrs[0])
 		       *attrcount_orig);
 	attrn = attrcount_orig;
diff --git a/drivers/staging/iio/industrialio-event.c b/drivers/staging/iio/industrialio-event.c
index 5e461e1..b229c53 100644
--- a/drivers/staging/iio/industrialio-event.c
+++ b/drivers/staging/iio/industrialio-event.c
@@ -396,7 +396,7 @@ int iio_device_register_eventset(struct iio_dev *indio_dev)
 
 	iio_setup_ev_int(indio_dev->event_interface);
 	if (indio_dev->info->event_attrs != NULL) {
-		attr = indio_dev->info->event_attrs->attrs;
+		attr = indio_dev->info->event_attrs;
 		while (*attr++ != NULL)
 			attrcount_orig++;
 	}
@@ -418,7 +418,7 @@ int iio_device_register_eventset(struct iio_dev *indio_dev)
 	}
 	if (indio_dev->info->event_attrs)
 		memcpy(indio_dev->event_interface->group.attrs,
-		       indio_dev->info->event_attrs->attrs,
+		       indio_dev->info->event_attrs,
 		       sizeof(indio_dev->event_interface->group.attrs[0])
 		       *attrcount_orig);
 	attrn = attrcount_orig;
diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index f0c733a..a70ba95 100644
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
@@ -521,7 +517,7 @@ static int isl29018_chip_init(struct i2c_client *client)
 }
 
 static const struct iio_info isl29108_info = {
-	.attrs = &isl29108_group,
+	.attrs = isl29018_attributes,
 	.driver_module = THIS_MODULE,
 	.read_raw = &isl29018_read_raw,
 	.write_raw = &isl29018_write_raw,
diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 25f4c1d..cd4da5a 100644
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
@@ -791,7 +787,7 @@ static int taos_tsl258x_device(unsigned char *bufp)
 }
 
 static const struct iio_info tsl2583_info = {
-	.attrs = &tsl2583_attribute_group,
+	.attrs = sysfs_attrs_ctrl,
 	.driver_module = THIS_MODULE,
 };
 
diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
index a2c4d00..3ac7c97 100644
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
@@ -458,12 +457,8 @@ static struct attribute *ak8975_attr[] = {
 	NULL
 };
 
-static struct attribute_group ak8975_attr_group = {
-	.attrs = ak8975_attr,
-};
-
 static const struct iio_info ak8975_info = {
-	.attrs = &ak8975_attr_group,
+	.attrs = ak8975_attr,
 	.read_raw = &ak8975_read_raw,
 	.driver_module = THIS_MODULE,
 };
diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index b492a0c..68c0636 100644
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
@@ -531,7 +527,7 @@ static void hmc5843_init_client(struct i2c_client *client)
 }
 
 static const struct iio_info hmc5843_info = {
-	.attrs = &hmc5843_group,
+	.attrs = hmc5843_attributes,
 	.read_raw = &hmc5843_read_raw,
 	.driver_module = THIS_MODULE,
 };
diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
index 62a879c..f42897b 100644
--- a/drivers/staging/iio/meter/ade7753.c
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -501,12 +501,8 @@ static struct attribute *ade7753_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group ade7753_attribute_group = {
-	.attrs = ade7753_attributes,
-};
-
 static const struct iio_info ade7753_info = {
-	.attrs = &ade7753_attribute_group,
+	.attrs = ade7753_attributes,
 	.driver_module = THIS_MODULE,
 };
 
diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
index 0111edb..f8fdaed 100644
--- a/drivers/staging/iio/meter/ade7754.c
+++ b/drivers/staging/iio/meter/ade7754.c
@@ -524,12 +524,8 @@ static struct attribute *ade7754_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group ade7754_attribute_group = {
-	.attrs = ade7754_attributes,
-};
-
 static const struct iio_info ade7754_info = {
-	.attrs = &ade7754_attribute_group,
+	.attrs = ade7754_attributes,
 	.driver_module = THIS_MODULE,
 };
 
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 9dc881f..e1d90d4 100644
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
@@ -726,7 +722,7 @@ static struct iio_chan_spec ade7758_channels[] = {
 };
 
 static const struct iio_info ade7758_info = {
-	.attrs = &ade7758_attribute_group,
+	.attrs = ade7758_attributes,
 	.driver_module = THIS_MODULE,
 };
 
diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index e7fcc7d..3e50dd28 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -447,12 +447,8 @@ static struct attribute *ade7759_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group ade7759_attribute_group = {
-	.attrs = ade7759_attributes,
-};
-
 static const struct iio_info ade7759_info = {
-	.attrs = &ade7759_attribute_group,
+	.attrs = ade7759_attributes,
 	.driver_module = THIS_MODULE,
 };
 
diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
index 49c01c5..364a849 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -547,12 +547,8 @@ static struct attribute *ade7854_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group ade7854_attribute_group = {
-	.attrs = ade7854_attributes,
-};
-
 static const struct iio_info ade7854_info = {
-	.attrs = &ade7854_attribute_group,
+	.attrs = ade7854_attributes,
 	.driver_module = THIS_MODULE,
 };
 
diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 8996c98..f349690 100644
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
@@ -647,7 +643,7 @@ error_ret:
 
 static const struct iio_info ad2s1210_info = {
 	.read_raw = &ad2s1210_read_raw,
-	.attrs = &ad2s1210_attribute_group,
+	.attrs = ad2s1210_attributes,
 	.driver_module = THIS_MODULE,
 };
 
-- 
1.7.7.4
