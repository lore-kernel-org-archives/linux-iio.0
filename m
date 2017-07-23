Return-Path: <SRS0=UbNB=62=huawei.com=Jonathan.Cameron@kernel.org>
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 19/45] iio:magnetometer: drop assign iio_info.driver_module and iio_trigger_ops.owner
Date: Sun, 23 Jul 2017 17:26:01 +0100
Message-Id: <20170723162627.22534-20-Jonathan.Cameron@huawei.com>
In-Reply-To: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@kernel.org>

The equivalent of both of these are now done via macro magic when
the relevant register calls are made.  The actual structure
elements will shortly go away.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/magnetometer/ak8974.c             | 1 -
 drivers/iio/magnetometer/ak8975.c             | 1 -
 drivers/iio/magnetometer/bmc150_magn.c        | 2 --
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 1 -
 drivers/iio/magnetometer/hmc5843_core.c       | 1 -
 drivers/iio/magnetometer/mag3110.c            | 1 -
 drivers/iio/magnetometer/mmc35240.c           | 1 -
 drivers/iio/magnetometer/st_magn_core.c       | 2 --
 8 files changed, 10 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index e13370dc9b1c..6b773e0e3215 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -568,7 +568,6 @@ static const unsigned long ak8974_scan_masks[] = { 0x7, 0 };
 
 static const struct iio_info ak8974_info = {
 	.read_raw = &ak8974_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static bool ak8974_writeable_reg(struct device *dev, unsigned int reg)
diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 4ff883942f7b..c09329069d0a 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -781,7 +781,6 @@ static const unsigned long ak8975_scan_masks[] = { 0x7, 0 };
 
 static const struct iio_info ak8975_info = {
 	.read_raw = &ak8975_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 #ifdef CONFIG_ACPI
diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index d104fb8d9379..d91cb845e3d6 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -651,7 +651,6 @@ static const struct iio_info bmc150_magn_info = {
 	.attrs = &bmc150_magn_attrs_group,
 	.read_raw = bmc150_magn_read_raw,
 	.write_raw = bmc150_magn_write_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static const unsigned long bmc150_magn_scan_masks[] = {
@@ -811,7 +810,6 @@ static int bmc150_magn_data_rdy_trigger_set_state(struct iio_trigger *trig,
 static const struct iio_trigger_ops bmc150_magn_trigger_ops = {
 	.set_trigger_state = bmc150_magn_data_rdy_trigger_set_state,
 	.try_reenable = bmc150_magn_trig_try_reen,
-	.owner = THIS_MODULE,
 };
 
 static int bmc150_magn_buffer_preenable(struct iio_dev *indio_dev)
diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index 0e791b02ed4a..a1fd9d591818 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -282,7 +282,6 @@ static int magn_3d_write_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info magn_3d_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = &magn_3d_read_raw,
 	.write_raw = &magn_3d_write_raw,
 };
diff --git a/drivers/iio/magnetometer/hmc5843_core.c b/drivers/iio/magnetometer/hmc5843_core.c
index ba3e2a374ee5..ada142fb7aa3 100644
--- a/drivers/iio/magnetometer/hmc5843_core.c
+++ b/drivers/iio/magnetometer/hmc5843_core.c
@@ -597,7 +597,6 @@ static const struct iio_info hmc5843_info = {
 	.read_raw = &hmc5843_read_raw,
 	.write_raw = &hmc5843_write_raw,
 	.write_raw_get_fmt = &hmc5843_write_raw_get_fmt,
-	.driver_module = THIS_MODULE,
 };
 
 static const unsigned long hmc5843_scan_masks[] = {0x7, 0};
diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
index dad8d57f7402..b34ace76d31b 100644
--- a/drivers/iio/magnetometer/mag3110.c
+++ b/drivers/iio/magnetometer/mag3110.c
@@ -333,7 +333,6 @@ static const struct iio_info mag3110_info = {
 	.attrs = &mag3110_group,
 	.read_raw = &mag3110_read_raw,
 	.write_raw = &mag3110_write_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static const unsigned long mag3110_scan_masks[] = {0x7, 0xf, 0};
diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
index 176e14a61558..6b640c6338c9 100644
--- a/drivers/iio/magnetometer/mmc35240.c
+++ b/drivers/iio/magnetometer/mmc35240.c
@@ -418,7 +418,6 @@ static int mmc35240_write_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info mmc35240_info = {
-	.driver_module	= THIS_MODULE,
 	.read_raw	= mmc35240_read_raw,
 	.write_raw	= mmc35240_write_raw,
 	.attrs		= &mmc35240_attribute_group,
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 3573636bad8e..f3217e7afd6f 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -435,7 +435,6 @@ static const struct attribute_group st_magn_attribute_group = {
 };
 
 static const struct iio_info magn_info = {
-	.driver_module = THIS_MODULE,
 	.attrs = &st_magn_attribute_group,
 	.read_raw = &st_magn_read_raw,
 	.write_raw = &st_magn_write_raw,
@@ -444,7 +443,6 @@ static const struct iio_info magn_info = {
 
 #ifdef CONFIG_IIO_TRIGGER
 static const struct iio_trigger_ops st_magn_trigger_ops = {
-	.owner = THIS_MODULE,
 	.set_trigger_state = ST_MAGN_TRIGGER_SET_STATE,
 	.validate_device = st_sensors_validate_device,
 };
-- 
2.13.3
