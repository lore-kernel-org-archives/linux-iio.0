Return-Path: <SRS0=UbNB=62=huawei.com=Jonathan.Cameron@kernel.org>
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 23/45] iio:pressure: drop assign iio_info.driver_module and iio_trigger_ops.owner
Date: Sun, 23 Jul 2017 17:26:05 +0100
Message-Id: <20170723162627.22534-24-Jonathan.Cameron@huawei.com>
In-Reply-To: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@kernel.org>

The equivalent of both of these are now done via macro magic when
the relevant register calls are made.  The actual structure
elements will shortly go away.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/pressure/abp060mg.c         | 1 -
 drivers/iio/pressure/bmp280-core.c      | 1 -
 drivers/iio/pressure/cros_ec_baro.c     | 1 -
 drivers/iio/pressure/hid-sensor-press.c | 1 -
 drivers/iio/pressure/hp03.c             | 1 -
 drivers/iio/pressure/hp206c.c           | 1 -
 drivers/iio/pressure/mpl115.c           | 1 -
 drivers/iio/pressure/mpl3115.c          | 1 -
 drivers/iio/pressure/ms5611_core.c      | 1 -
 drivers/iio/pressure/ms5637.c           | 1 -
 drivers/iio/pressure/st_pressure_core.c | 2 --
 drivers/iio/pressure/t5403.c            | 1 -
 drivers/iio/pressure/zpa2326.c          | 2 --
 13 files changed, 15 deletions(-)

diff --git a/drivers/iio/pressure/abp060mg.c b/drivers/iio/pressure/abp060mg.c
index 43bdd0b9155f..46a220c70d6a 100644
--- a/drivers/iio/pressure/abp060mg.c
+++ b/drivers/iio/pressure/abp060mg.c
@@ -168,7 +168,6 @@ static int abp060mg_read_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info abp060mg_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = abp060mg_read_raw,
 };
 
diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index d82b788374b6..89696b70231a 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -546,7 +546,6 @@ static const struct attribute_group bmp280_attrs_group = {
 };
 
 static const struct iio_info bmp280_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = &bmp280_read_raw,
 	.write_raw = &bmp280_write_raw,
 	.attrs = &bmp280_attrs_group,
diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
index 48b2a30f57ae..37034188ab8e 100644
--- a/drivers/iio/pressure/cros_ec_baro.c
+++ b/drivers/iio/pressure/cros_ec_baro.c
@@ -120,7 +120,6 @@ static int cros_ec_baro_write(struct iio_dev *indio_dev,
 static const struct iio_info cros_ec_baro_info = {
 	.read_raw = &cros_ec_baro_read,
 	.write_raw = &cros_ec_baro_write,
-	.driver_module = THIS_MODULE,
 };
 
 static int cros_ec_baro_probe(struct platform_device *pdev)
diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index 6848d8c80eff..4c437918f1d2 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -160,7 +160,6 @@ static int press_write_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info press_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = &press_read_raw,
 	.write_raw = &press_write_raw,
 };
diff --git a/drivers/iio/pressure/hp03.c b/drivers/iio/pressure/hp03.c
index 8c7b3ec3d84a..406934ea6228 100644
--- a/drivers/iio/pressure/hp03.c
+++ b/drivers/iio/pressure/hp03.c
@@ -208,7 +208,6 @@ static int hp03_read_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info hp03_info = {
-	.driver_module	= THIS_MODULE,
 	.read_raw	= &hp03_read_raw,
 };
 
diff --git a/drivers/iio/pressure/hp206c.c b/drivers/iio/pressure/hp206c.c
index 12f769e86355..c38c19678cf6 100644
--- a/drivers/iio/pressure/hp206c.c
+++ b/drivers/iio/pressure/hp206c.c
@@ -351,7 +351,6 @@ static const struct iio_info hp206c_info = {
 	.attrs = &hp206c_attribute_group,
 	.read_raw = hp206c_read_raw,
 	.write_raw = hp206c_write_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static int hp206c_probe(struct i2c_client *client,
diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
index 8f2bce213248..ab4786d0102b 100644
--- a/drivers/iio/pressure/mpl115.c
+++ b/drivers/iio/pressure/mpl115.c
@@ -144,7 +144,6 @@ static const struct iio_chan_spec mpl115_channels[] = {
 
 static const struct iio_info mpl115_info = {
 	.read_raw = &mpl115_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 int mpl115_probe(struct device *dev, const char *name,
diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index 619b963714c7..7537547fb7ee 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -218,7 +218,6 @@ static const struct iio_chan_spec mpl3115_channels[] = {
 
 static const struct iio_info mpl3115_info = {
 	.read_raw = &mpl3115_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static int mpl3115_probe(struct i2c_client *client,
diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
index 2a77a2f15752..f950cfde5db9 100644
--- a/drivers/iio/pressure/ms5611_core.c
+++ b/drivers/iio/pressure/ms5611_core.c
@@ -384,7 +384,6 @@ static const struct iio_info ms5611_info = {
 	.read_raw = &ms5611_read_raw,
 	.write_raw = &ms5611_write_raw,
 	.attrs = &ms5611_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 static int ms5611_init(struct iio_dev *indio_dev)
diff --git a/drivers/iio/pressure/ms5637.c b/drivers/iio/pressure/ms5637.c
index c413f8a84a63..e2f73e6dc58f 100644
--- a/drivers/iio/pressure/ms5637.c
+++ b/drivers/iio/pressure/ms5637.c
@@ -124,7 +124,6 @@ static const struct iio_info ms5637_info = {
 	.read_raw = ms5637_read_raw,
 	.write_raw = ms5637_write_raw,
 	.attrs = &ms5637_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 static int ms5637_probe(struct i2c_client *client,
diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index aa61ec15c139..99bcc089a199 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -547,7 +547,6 @@ static const struct attribute_group st_press_attribute_group = {
 };
 
 static const struct iio_info press_info = {
-	.driver_module = THIS_MODULE,
 	.attrs = &st_press_attribute_group,
 	.read_raw = &st_press_read_raw,
 	.write_raw = &st_press_write_raw,
@@ -556,7 +555,6 @@ static const struct iio_info press_info = {
 
 #ifdef CONFIG_IIO_TRIGGER
 static const struct iio_trigger_ops st_press_trigger_ops = {
-	.owner = THIS_MODULE,
 	.set_trigger_state = ST_PRESS_TRIGGER_SET_STATE,
 	.validate_device = st_sensors_validate_device,
 };
diff --git a/drivers/iio/pressure/t5403.c b/drivers/iio/pressure/t5403.c
index 2667e71721f5..92c00f603b1d 100644
--- a/drivers/iio/pressure/t5403.c
+++ b/drivers/iio/pressure/t5403.c
@@ -209,7 +209,6 @@ static const struct iio_info t5403_info = {
 	.read_raw = &t5403_read_raw,
 	.write_raw = &t5403_write_raw,
 	.attrs = &t5403_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 static int t5403_probe(struct i2c_client *client,
diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
index ebfb1de7377f..78dfbde62028 100644
--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -1394,7 +1394,6 @@ static int zpa2326_set_trigger_state(struct iio_trigger *trig, bool state)
 }
 
 static const struct iio_trigger_ops zpa2326_trigger_ops = {
-	.owner             = THIS_MODULE,
 	.set_trigger_state = zpa2326_set_trigger_state,
 };
 
@@ -1594,7 +1593,6 @@ static const struct iio_chan_spec zpa2326_channels[] = {
 };
 
 static const struct iio_info zpa2326_info = {
-	.driver_module = THIS_MODULE,
 	.attrs         = &zpa2326_attribute_group,
 	.read_raw      = zpa2326_read_raw,
 	.write_raw     = zpa2326_write_raw,
-- 
2.13.3
