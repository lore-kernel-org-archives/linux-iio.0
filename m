Return-Path: <SRS0=UbNB=62=huawei.com=Jonathan.Cameron@kernel.org>
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 14/45] iio:gyro: drop assign iio_info.driver_module and iio_trigger_ops.owner
Date: Sun, 23 Jul 2017 17:25:56 +0100
Message-Id: <20170723162627.22534-15-Jonathan.Cameron@huawei.com>
In-Reply-To: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@kernel.org>

The equivalent of both of these are now done via macro magic when
the relevant register calls are made.  The actual structure
elements will shortly go away.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/gyro/adis16080.c          | 1 -
 drivers/iio/gyro/adis16130.c          | 1 -
 drivers/iio/gyro/adis16136.c          | 1 -
 drivers/iio/gyro/adis16260.c          | 1 -
 drivers/iio/gyro/adxrs450.c           | 1 -
 drivers/iio/gyro/bmg160_core.c        | 2 --
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 1 -
 drivers/iio/gyro/itg3200_buffer.c     | 1 -
 drivers/iio/gyro/itg3200_core.c       | 1 -
 drivers/iio/gyro/mpu3050-core.c       | 2 --
 drivers/iio/gyro/st_gyro_core.c       | 2 --
 11 files changed, 14 deletions(-)

diff --git a/drivers/iio/gyro/adis16080.c b/drivers/iio/gyro/adis16080.c
index ad31a1372a04..a551ebde4762 100644
--- a/drivers/iio/gyro/adis16080.c
+++ b/drivers/iio/gyro/adis16080.c
@@ -163,7 +163,6 @@ static const struct iio_chan_spec adis16080_channels[] = {
 
 static const struct iio_info adis16080_info = {
 	.read_raw = &adis16080_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 enum {
diff --git a/drivers/iio/gyro/adis16130.c b/drivers/iio/gyro/adis16130.c
index e5241f41e65e..aea80ab04122 100644
--- a/drivers/iio/gyro/adis16130.c
+++ b/drivers/iio/gyro/adis16130.c
@@ -137,7 +137,6 @@ static const struct iio_chan_spec adis16130_channels[] = {
 
 static const struct iio_info adis16130_info = {
 	.read_raw = &adis16130_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static int adis16130_probe(struct spi_device *spi)
diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
index b04faf93e1bc..90ec4bed62b7 100644
--- a/drivers/iio/gyro/adis16136.c
+++ b/drivers/iio/gyro/adis16136.c
@@ -398,7 +398,6 @@ static const struct attribute_group adis16136_attribute_group = {
 };
 
 static const struct iio_info adis16136_info = {
-	.driver_module = THIS_MODULE,
 	.attrs = &adis16136_attribute_group,
 	.read_raw = &adis16136_read_raw,
 	.write_raw = &adis16136_write_raw,
diff --git a/drivers/iio/gyro/adis16260.c b/drivers/iio/gyro/adis16260.c
index 7da8825f4791..a8cb1ca349d9 100644
--- a/drivers/iio/gyro/adis16260.c
+++ b/drivers/iio/gyro/adis16260.c
@@ -321,7 +321,6 @@ static const struct iio_info adis16260_info = {
 	.read_raw = &adis16260_read_raw,
 	.write_raw = &adis16260_write_raw,
 	.update_scan_mode = adis_update_scan_mode,
-	.driver_module = THIS_MODULE,
 };
 
 static const char * const adis1620_status_error_msgs[] = {
diff --git a/drivers/iio/gyro/adxrs450.c b/drivers/iio/gyro/adxrs450.c
index a330d4288bb0..5d39fd008378 100644
--- a/drivers/iio/gyro/adxrs450.c
+++ b/drivers/iio/gyro/adxrs450.c
@@ -405,7 +405,6 @@ static const struct iio_chan_spec adxrs450_channels[2][2] = {
 };
 
 static const struct iio_info adxrs450_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = &adxrs450_read_raw,
 	.write_raw = &adxrs450_write_raw,
 };
diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 821919dd245b..15046172e437 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -858,7 +858,6 @@ static const struct iio_info bmg160_info = {
 	.write_event_value	= bmg160_write_event,
 	.write_event_config	= bmg160_write_event_config,
 	.read_event_config	= bmg160_read_event_config,
-	.driver_module		= THIS_MODULE,
 };
 
 static const unsigned long bmg160_accel_scan_masks[] = {
@@ -956,7 +955,6 @@ static int bmg160_data_rdy_trigger_set_state(struct iio_trigger *trig,
 static const struct iio_trigger_ops bmg160_trigger_ops = {
 	.set_trigger_state = bmg160_data_rdy_trigger_set_state,
 	.try_reenable = bmg160_trig_try_reen,
-	.owner = THIS_MODULE,
 };
 
 static irqreturn_t bmg160_event_handler(int irq, void *private)
diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index c67ce2ac4715..f59995a90387 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -186,7 +186,6 @@ static int gyro_3d_write_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info gyro_3d_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = &gyro_3d_read_raw,
 	.write_raw = &gyro_3d_write_raw,
 };
diff --git a/drivers/iio/gyro/itg3200_buffer.c b/drivers/iio/gyro/itg3200_buffer.c
index eef50e91f17c..59770e5b6660 100644
--- a/drivers/iio/gyro/itg3200_buffer.c
+++ b/drivers/iio/gyro/itg3200_buffer.c
@@ -101,7 +101,6 @@ static int itg3200_data_rdy_trigger_set_state(struct iio_trigger *trig,
 }
 
 static const struct iio_trigger_ops itg3200_trigger_ops = {
-	.owner = THIS_MODULE,
 	.set_trigger_state = &itg3200_data_rdy_trigger_set_state,
 };
 
diff --git a/drivers/iio/gyro/itg3200_core.c b/drivers/iio/gyro/itg3200_core.c
index cfa2db04a8ab..7adecb562c81 100644
--- a/drivers/iio/gyro/itg3200_core.c
+++ b/drivers/iio/gyro/itg3200_core.c
@@ -278,7 +278,6 @@ static const struct iio_chan_spec itg3200_channels[] = {
 static const struct iio_info itg3200_info = {
 	.read_raw = &itg3200_read_raw,
 	.write_raw = &itg3200_write_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static const unsigned long itg3200_available_scan_masks[] = { 0xffffffff, 0x0 };
diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index e0d241a9aa30..77fac81a3adc 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -742,7 +742,6 @@ static const struct attribute_group mpu3050_attribute_group = {
 };
 
 static const struct iio_info mpu3050_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = mpu3050_read_raw,
 	.write_raw = mpu3050_write_raw,
 	.attrs = &mpu3050_attribute_group,
@@ -1032,7 +1031,6 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
 }
 
 static const struct iio_trigger_ops mpu3050_trigger_ops = {
-	.owner = THIS_MODULE,
 	.set_trigger_state = mpu3050_drdy_trigger_set_state,
 };
 
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index e366422e8512..4cf85aa01dde 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -326,7 +326,6 @@ static const struct attribute_group st_gyro_attribute_group = {
 };
 
 static const struct iio_info gyro_info = {
-	.driver_module = THIS_MODULE,
 	.attrs = &st_gyro_attribute_group,
 	.read_raw = &st_gyro_read_raw,
 	.write_raw = &st_gyro_write_raw,
@@ -335,7 +334,6 @@ static const struct iio_info gyro_info = {
 
 #ifdef CONFIG_IIO_TRIGGER
 static const struct iio_trigger_ops st_gyro_trigger_ops = {
-	.owner = THIS_MODULE,
 	.set_trigger_state = ST_GYRO_TRIGGER_SET_STATE,
 	.validate_device = st_sensors_validate_device,
 };
-- 
2.13.3
