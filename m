Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55634 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751428AbdGWQ0k (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Jul 2017 12:26:40 -0400
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 06/45] iio:accel: drop assign iio_info.driver_module and iio_trigger_ops.owner
Date: Sun, 23 Jul 2017 17:25:48 +0100
Message-Id: <20170723162627.22534-7-Jonathan.Cameron@huawei.com>
In-Reply-To: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Jonathan Cameron <jic23@kernel.org>

The equivalent of both of these are now done via macro magic when
the relevant register calls are made.  The actual structure
elements will shortly go away.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/adxl345_core.c        | 1 -
 drivers/iio/accel/bma180.c              | 2 --
 drivers/iio/accel/bma220_spi.c          | 1 -
 drivers/iio/accel/bmc150-accel-core.c   | 3 ---
 drivers/iio/accel/da280.c               | 1 -
 drivers/iio/accel/da311.c               | 1 -
 drivers/iio/accel/dmard06.c             | 1 -
 drivers/iio/accel/dmard09.c             | 1 -
 drivers/iio/accel/dmard10.c             | 1 -
 drivers/iio/accel/hid-sensor-accel-3d.c | 1 -
 drivers/iio/accel/kxcjk-1013.c          | 2 --
 drivers/iio/accel/kxsd9.c               | 1 -
 drivers/iio/accel/mc3230.c              | 1 -
 drivers/iio/accel/mma7455_core.c        | 1 -
 drivers/iio/accel/mma7660.c             | 1 -
 drivers/iio/accel/mma8452.c             | 2 --
 drivers/iio/accel/mma9551.c             | 1 -
 drivers/iio/accel/mma9553.c             | 1 -
 drivers/iio/accel/mxc4005.c             | 2 --
 drivers/iio/accel/mxc6255.c             | 1 -
 drivers/iio/accel/sca3000.c             | 1 -
 drivers/iio/accel/st_accel_core.c       | 2 --
 drivers/iio/accel/stk8312.c             | 2 --
 drivers/iio/accel/stk8ba50.c            | 2 --
 24 files changed, 33 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 9ccb5828db98..7251d0e63d74 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -95,7 +95,6 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info adxl345_info = {
-	.driver_module	= THIS_MODULE,
 	.read_raw	= adxl345_read_raw,
 };
 
diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index efc67739c28f..bae72ccc5b43 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -536,7 +536,6 @@ static const struct iio_info bma180_info = {
 	.attrs			= &bma180_attrs_group,
 	.read_raw		= bma180_read_raw,
 	.write_raw		= bma180_write_raw,
-	.driver_module		= THIS_MODULE,
 };
 
 static const char * const bma180_power_modes[] = { "low_noise", "low_power" };
@@ -700,7 +699,6 @@ static int bma180_trig_try_reen(struct iio_trigger *trig)
 static const struct iio_trigger_ops bma180_trigger_ops = {
 	.set_trigger_state = bma180_data_rdy_trigger_set_state,
 	.try_reenable = bma180_trig_try_reen,
-	.owner = THIS_MODULE,
 };
 
 static int bma180_probe(struct i2c_client *client,
diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index 5099f295dd37..e25d91c017ed 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -186,7 +186,6 @@ static int bma220_write_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info bma220_info = {
-	.driver_module		= THIS_MODULE,
 	.read_raw		= bma220_read_raw,
 	.write_raw		= bma220_write_raw,
 	.attrs			= &bma220_attribute_group,
diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 6b5d3be283c4..1d511c27d128 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1100,7 +1100,6 @@ static const struct iio_info bmc150_accel_info = {
 	.write_event_value	= bmc150_accel_write_event,
 	.write_event_config	= bmc150_accel_write_event_config,
 	.read_event_config	= bmc150_accel_read_event_config,
-	.driver_module		= THIS_MODULE,
 };
 
 static const struct iio_info bmc150_accel_info_fifo = {
@@ -1114,7 +1113,6 @@ static const struct iio_info bmc150_accel_info_fifo = {
 	.validate_trigger	= bmc150_accel_validate_trigger,
 	.hwfifo_set_watermark	= bmc150_accel_set_watermark,
 	.hwfifo_flush_to_buffer	= bmc150_accel_fifo_flush,
-	.driver_module		= THIS_MODULE,
 };
 
 static const unsigned long bmc150_accel_scan_masks[] = {
@@ -1206,7 +1204,6 @@ static int bmc150_accel_trigger_set_state(struct iio_trigger *trig,
 static const struct iio_trigger_ops bmc150_accel_trigger_ops = {
 	.set_trigger_state = bmc150_accel_trigger_set_state,
 	.try_reenable = bmc150_accel_trig_try_reen,
-	.owner = THIS_MODULE,
 };
 
 static int bmc150_accel_handle_roc_event(struct iio_dev *indio_dev)
diff --git a/drivers/iio/accel/da280.c b/drivers/iio/accel/da280.c
index ed8343aeac9c..6c214783241c 100644
--- a/drivers/iio/accel/da280.c
+++ b/drivers/iio/accel/da280.c
@@ -88,7 +88,6 @@ static int da280_read_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info da280_info = {
-	.driver_module	= THIS_MODULE,
 	.read_raw	= da280_read_raw,
 };
 
diff --git a/drivers/iio/accel/da311.c b/drivers/iio/accel/da311.c
index c0c1620d2a2f..aa64bca00955 100644
--- a/drivers/iio/accel/da311.c
+++ b/drivers/iio/accel/da311.c
@@ -212,7 +212,6 @@ static int da311_read_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info da311_info = {
-	.driver_module	= THIS_MODULE,
 	.read_raw	= da311_read_raw,
 };
 
diff --git a/drivers/iio/accel/dmard06.c b/drivers/iio/accel/dmard06.c
index 656ca8e1927f..d87e2c751475 100644
--- a/drivers/iio/accel/dmard06.c
+++ b/drivers/iio/accel/dmard06.c
@@ -124,7 +124,6 @@ static int dmard06_read_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info dmard06_info = {
-	.driver_module	= THIS_MODULE,
 	.read_raw	= dmard06_read_raw,
 };
 
diff --git a/drivers/iio/accel/dmard09.c b/drivers/iio/accel/dmard09.c
index d3a28f96565c..16a7e74f5e9a 100644
--- a/drivers/iio/accel/dmard09.c
+++ b/drivers/iio/accel/dmard09.c
@@ -93,7 +93,6 @@ static int dmard09_read_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info dmard09_info = {
-	.driver_module	= THIS_MODULE,
 	.read_raw	= dmard09_read_raw,
 };
 
diff --git a/drivers/iio/accel/dmard10.c b/drivers/iio/accel/dmard10.c
index b8736cc75656..9518ea00167e 100644
--- a/drivers/iio/accel/dmard10.c
+++ b/drivers/iio/accel/dmard10.c
@@ -170,7 +170,6 @@ static int dmard10_read_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info dmard10_info = {
-	.driver_module	= THIS_MODULE,
 	.read_raw	= dmard10_read_raw,
 };
 
diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 2238a26aba63..c066a3bdbff7 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -225,7 +225,6 @@ static int accel_3d_write_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info accel_3d_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = &accel_3d_read_raw,
 	.write_raw = &accel_3d_write_raw,
 };
diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 3f968c46e667..1e0b59f3e221 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -950,7 +950,6 @@ static const struct iio_info kxcjk1013_info = {
 	.write_event_value	= kxcjk1013_write_event,
 	.write_event_config	= kxcjk1013_write_event_config,
 	.read_event_config	= kxcjk1013_read_event_config,
-	.driver_module		= THIS_MODULE,
 };
 
 static const unsigned long kxcjk1013_scan_masks[] = {0x7, 0};
@@ -1036,7 +1035,6 @@ static int kxcjk1013_data_rdy_trigger_set_state(struct iio_trigger *trig,
 static const struct iio_trigger_ops kxcjk1013_trigger_ops = {
 	.set_trigger_state = kxcjk1013_data_rdy_trigger_set_state,
 	.try_reenable = kxcjk1013_trig_try_reen,
-	.owner = THIS_MODULE,
 };
 
 static irqreturn_t kxcjk1013_event_handler(int irq, void *private)
diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 9af60ac70738..0c0df4fce420 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -390,7 +390,6 @@ static const struct iio_info kxsd9_info = {
 	.read_raw = &kxsd9_read_raw,
 	.write_raw = &kxsd9_write_raw,
 	.attrs = &kxsd9_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 /* Four channels apart from timestamp, scan mask = 0x0f */
diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
index 4ea2ff623a6d..8b11604eed63 100644
--- a/drivers/iio/accel/mc3230.c
+++ b/drivers/iio/accel/mc3230.c
@@ -107,7 +107,6 @@ static int mc3230_read_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info mc3230_info = {
-	.driver_module	= THIS_MODULE,
 	.read_raw	= mc3230_read_raw,
 };
 
diff --git a/drivers/iio/accel/mma7455_core.c b/drivers/iio/accel/mma7455_core.c
index 6551085bedd7..da0ceaac46b5 100644
--- a/drivers/iio/accel/mma7455_core.c
+++ b/drivers/iio/accel/mma7455_core.c
@@ -199,7 +199,6 @@ static const struct iio_info mma7455_info = {
 	.attrs = &mma7455_group,
 	.read_raw = mma7455_read_raw,
 	.write_raw = mma7455_write_raw,
-	.driver_module = THIS_MODULE,
 };
 
 #define MMA7455_CHANNEL(axis, idx) { \
diff --git a/drivers/iio/accel/mma7660.c b/drivers/iio/accel/mma7660.c
index 42fa57e41bdd..f1a13724efb3 100644
--- a/drivers/iio/accel/mma7660.c
+++ b/drivers/iio/accel/mma7660.c
@@ -168,7 +168,6 @@ static int mma7660_read_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info mma7660_info = {
-	.driver_module	= THIS_MODULE,
 	.read_raw		= mma7660_read_raw,
 	.attrs			= &mma7660_attribute_group,
 };
diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index eb6e3dc789b2..7094c2ffcdc4 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1337,7 +1337,6 @@ static const struct iio_info mma8452_info = {
 	.read_event_config = &mma8452_read_event_config,
 	.write_event_config = &mma8452_write_event_config,
 	.debugfs_reg_access = &mma8452_reg_access_dbg,
-	.driver_module = THIS_MODULE,
 };
 
 static const unsigned long mma8452_scan_masks[] = {0x7, 0};
@@ -1368,7 +1367,6 @@ static int mma8452_data_rdy_trigger_set_state(struct iio_trigger *trig,
 static const struct iio_trigger_ops mma8452_trigger_ops = {
 	.set_trigger_state = mma8452_data_rdy_trigger_set_state,
 	.validate_device = iio_trigger_validate_own_device,
-	.owner = THIS_MODULE,
 };
 
 static int mma8452_trigger_setup(struct iio_dev *indio_dev)
diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index 1f53f08476f5..da7c21504f38 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -332,7 +332,6 @@ static const struct iio_chan_spec mma9551_channels[] = {
 };
 
 static const struct iio_info mma9551_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = mma9551_read_raw,
 	.read_event_config = mma9551_read_event_config,
 	.write_event_config = mma9551_write_event_config,
diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index 36bf19733be0..b52a3f182190 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -987,7 +987,6 @@ static const struct iio_chan_spec mma9553_channels[] = {
 };
 
 static const struct iio_info mma9553_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = mma9553_read_raw,
 	.write_raw = mma9553_write_raw,
 	.read_event_config = mma9553_read_event_config,
diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index c23f47af7256..58099e40d717 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -264,7 +264,6 @@ static int mxc4005_write_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info mxc4005_info = {
-	.driver_module	= THIS_MODULE,
 	.read_raw	= mxc4005_read_raw,
 	.write_raw	= mxc4005_write_raw,
 	.attrs		= &mxc4005_attrs_group,
@@ -376,7 +375,6 @@ static int mxc4005_trigger_try_reen(struct iio_trigger *trig)
 static const struct iio_trigger_ops mxc4005_trigger_ops = {
 	.set_trigger_state = mxc4005_set_trigger_state,
 	.try_reenable = mxc4005_trigger_try_reen,
-	.owner = THIS_MODULE,
 };
 
 static int mxc4005_chip_init(struct mxc4005_data *data)
diff --git a/drivers/iio/accel/mxc6255.c b/drivers/iio/accel/mxc6255.c
index 0abad6948201..ddd50d1781c5 100644
--- a/drivers/iio/accel/mxc6255.c
+++ b/drivers/iio/accel/mxc6255.c
@@ -78,7 +78,6 @@ static int mxc6255_read_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info mxc6255_info = {
-	.driver_module	= THIS_MODULE,
 	.read_raw	= mxc6255_read_raw,
 };
 
diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 39ab210c44f6..f33dadf7b262 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -1454,7 +1454,6 @@ static const struct iio_info sca3000_info = {
 	.write_event_value = &sca3000_write_event_value,
 	.read_event_config = &sca3000_read_event_config,
 	.write_event_config = &sca3000_write_event_config,
-	.driver_module = THIS_MODULE,
 };
 
 static int sca3000_probe(struct spi_device *spi)
diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index c7709494bed3..b658fb937b55 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -689,7 +689,6 @@ static const struct attribute_group st_accel_attribute_group = {
 };
 
 static const struct iio_info accel_info = {
-	.driver_module = THIS_MODULE,
 	.attrs = &st_accel_attribute_group,
 	.read_raw = &st_accel_read_raw,
 	.write_raw = &st_accel_write_raw,
@@ -698,7 +697,6 @@ static const struct iio_info accel_info = {
 
 #ifdef CONFIG_IIO_TRIGGER
 static const struct iio_trigger_ops st_accel_trigger_ops = {
-	.owner = THIS_MODULE,
 	.set_trigger_state = ST_ACCEL_TRIGGER_SET_STATE,
 	.validate_device = st_sensors_validate_device,
 };
diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index e31023dc5f1b..cacc0da2f874 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -237,7 +237,6 @@ static int stk8312_data_rdy_trigger_set_state(struct iio_trigger *trig,
 
 static const struct iio_trigger_ops stk8312_trigger_ops = {
 	.set_trigger_state = stk8312_data_rdy_trigger_set_state,
-	.owner = THIS_MODULE,
 };
 
 static int stk8312_set_sample_rate(struct stk8312_data *data, u8 rate)
@@ -421,7 +420,6 @@ static int stk8312_write_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info stk8312_info = {
-	.driver_module		= THIS_MODULE,
 	.read_raw		= stk8312_read_raw,
 	.write_raw		= stk8312_write_raw,
 	.attrs			= &stk8312_attribute_group,
diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index 300d955bad00..576b6b140f08 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -179,7 +179,6 @@ static int stk8ba50_data_rdy_trigger_set_state(struct iio_trigger *trig,
 
 static const struct iio_trigger_ops stk8ba50_trigger_ops = {
 	.set_trigger_state = stk8ba50_data_rdy_trigger_set_state,
-	.owner = THIS_MODULE,
 };
 
 static int stk8ba50_set_power(struct stk8ba50_data *data, bool mode)
@@ -307,7 +306,6 @@ static int stk8ba50_write_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info stk8ba50_info = {
-	.driver_module		= THIS_MODULE,
 	.read_raw		= stk8ba50_read_raw,
 	.write_raw		= stk8ba50_write_raw,
 	.attrs			= &stk8ba50_attribute_group,
-- 
2.13.3

