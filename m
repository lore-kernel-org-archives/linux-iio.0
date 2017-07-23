Return-Path: <SRS0=UbNB=62=huawei.com=Jonathan.Cameron@kernel.org>
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 17/45] iio:imu: drop assign iio_info.driver_module and iio_trigger_ops.owner
Date: Sun, 23 Jul 2017 17:25:59 +0100
Message-Id: <20170723162627.22534-18-Jonathan.Cameron@huawei.com>
In-Reply-To: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@kernel.org>

The equivalent of both of these are now done via macro magic when
the relevant register calls are made.  The actual structure
elements will shortly go away.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/adis16400_core.c              | 1 -
 drivers/iio/imu/adis16480.c                   | 1 -
 drivers/iio/imu/adis_trigger.c                | 1 -
 drivers/iio/imu/bmi160/bmi160_core.c          | 1 -
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 1 -
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 1 -
 drivers/iio/imu/kmx61.c                       | 3 ---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 2 --
 8 files changed, 11 deletions(-)

diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
index 9b697d35dbef..46a569005a13 100644
--- a/drivers/iio/imu/adis16400_core.c
+++ b/drivers/iio/imu/adis16400_core.c
@@ -833,7 +833,6 @@ static struct adis16400_chip_info adis16400_chips[] = {
 };
 
 static const struct iio_info adis16400_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = &adis16400_read_raw,
 	.write_raw = &adis16400_write_raw,
 	.update_scan_mode = adis16400_update_scan_mode,
diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index 8cf84d3488b2..440c1580160c 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -720,7 +720,6 @@ static const struct iio_info adis16480_info = {
 	.read_raw = &adis16480_read_raw,
 	.write_raw = &adis16480_write_raw,
 	.update_scan_mode = adis_update_scan_mode,
-	.driver_module = THIS_MODULE,
 };
 
 static int adis16480_stop_device(struct iio_dev *indio_dev)
diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigger.c
index f53e9a803a0e..0dd5a381be64 100644
--- a/drivers/iio/imu/adis_trigger.c
+++ b/drivers/iio/imu/adis_trigger.c
@@ -25,7 +25,6 @@ static int adis_data_rdy_trigger_set_state(struct iio_trigger *trig,
 }
 
 static const struct iio_trigger_ops adis_trigger_ops = {
-	.owner = THIS_MODULE,
 	.set_trigger_state = &adis_data_rdy_trigger_set_state,
 };
 
diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index cfd225ed1c8d..c85659ca9507 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -482,7 +482,6 @@ static const struct attribute_group bmi160_attrs_group = {
 };
 
 static const struct iio_info bmi160_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = bmi160_read_raw,
 	.write_raw = bmi160_write_raw,
 	.attrs = &bmi160_attrs_group,
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 44830bce13df..db578e0faaab 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -795,7 +795,6 @@ static const struct attribute_group inv_attribute_group = {
 };
 
 static const struct iio_info mpu_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = &inv_mpu6050_read_raw,
 	.write_raw = &inv_mpu6050_write_raw,
 	.write_raw_get_fmt = &inv_write_raw_get_fmt,
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index 540070f0a230..f963f9fc98c0 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -114,7 +114,6 @@ static int inv_mpu_data_rdy_trigger_set_state(struct iio_trigger *trig,
 }
 
 static const struct iio_trigger_ops inv_mpu_trigger_ops = {
-	.owner = THIS_MODULE,
 	.set_trigger_state = &inv_mpu_data_rdy_trigger_set_state,
 };
 
diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 2e7dd5754a56..44b3f5397343 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -1003,7 +1003,6 @@ static int kmx61_mag_validate_trigger(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info kmx61_acc_info = {
-	.driver_module		= THIS_MODULE,
 	.read_raw		= kmx61_read_raw,
 	.write_raw		= kmx61_write_raw,
 	.attrs			= &kmx61_acc_attribute_group,
@@ -1015,7 +1014,6 @@ static const struct iio_info kmx61_acc_info = {
 };
 
 static const struct iio_info kmx61_mag_info = {
-	.driver_module		= THIS_MODULE,
 	.read_raw		= kmx61_read_raw,
 	.write_raw		= kmx61_write_raw,
 	.attrs			= &kmx61_mag_attribute_group,
@@ -1087,7 +1085,6 @@ static int kmx61_trig_try_reenable(struct iio_trigger *trig)
 static const struct iio_trigger_ops kmx61_trigger_ops = {
 	.set_trigger_state = kmx61_data_rdy_trigger_set_state,
 	.try_reenable = kmx61_trig_try_reenable,
-	.owner = THIS_MODULE,
 };
 
 static irqreturn_t kmx61_event_handler(int irq, void *private)
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index b485540da89e..d45d714acdd3 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -530,7 +530,6 @@ static const struct attribute_group st_lsm6dsx_acc_attribute_group = {
 };
 
 static const struct iio_info st_lsm6dsx_acc_info = {
-	.driver_module = THIS_MODULE,
 	.attrs = &st_lsm6dsx_acc_attribute_group,
 	.read_raw = st_lsm6dsx_read_raw,
 	.write_raw = st_lsm6dsx_write_raw,
@@ -548,7 +547,6 @@ static const struct attribute_group st_lsm6dsx_gyro_attribute_group = {
 };
 
 static const struct iio_info st_lsm6dsx_gyro_info = {
-	.driver_module = THIS_MODULE,
 	.attrs = &st_lsm6dsx_gyro_attribute_group,
 	.read_raw = st_lsm6dsx_read_raw,
 	.write_raw = st_lsm6dsx_write_raw,
-- 
2.13.3
