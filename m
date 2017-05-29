Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 24/38] iio:temperature: drop assignment of iio_info.driver_module
Date: Mon, 29 May 2017 16:51:40 +0100
Message-Id: <20170529155154.22580-25-jic23@kernel.org>
In-Reply-To: <20170529155154.22580-1-jic23@kernel.org>
References: <20170529155154.22580-1-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

The equivalent of this is now done via macro magic when
the relevant register call is made.  The actual structure
elements will shortly go away.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/temperature/hid-sensor-temperature.c | 1 -
 drivers/iio/temperature/maxim_thermocouple.c     | 1 -
 drivers/iio/temperature/mlx90614.c               | 1 -
 drivers/iio/temperature/tmp006.c                 | 1 -
 drivers/iio/temperature/tmp007.c                 | 1 -
 drivers/iio/temperature/tsys01.c                 | 1 -
 drivers/iio/temperature/tsys02d.c                | 1 -
 7 files changed, 7 deletions(-)

diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
index c01efeca4002..beaf6fd3e337 100644
--- a/drivers/iio/temperature/hid-sensor-temperature.c
+++ b/drivers/iio/temperature/hid-sensor-temperature.c
@@ -123,7 +123,6 @@ static int temperature_write_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info temperature_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = &temperature_read_raw,
 	.write_raw = &temperature_write_raw,
 };
diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
index d70e2e53d6a7..e8b7e0b6c8ad 100644
--- a/drivers/iio/temperature/maxim_thermocouple.c
+++ b/drivers/iio/temperature/maxim_thermocouple.c
@@ -208,7 +208,6 @@ static int maxim_thermocouple_read_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info maxim_thermocouple_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = maxim_thermocouple_read_raw,
 };
 
diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index 2077eef4095c..d619e8634a00 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -400,7 +400,6 @@ static const struct iio_info mlx90614_info = {
 	.write_raw = mlx90614_write_raw,
 	.write_raw_get_fmt = mlx90614_write_raw_get_fmt,
 	.attrs = &mlx90614_attr_group,
-	.driver_module = THIS_MODULE,
 };
 
 #ifdef CONFIG_PM
diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
index 18c9b43c02cb..a9b5b7cc7836 100644
--- a/drivers/iio/temperature/tmp006.c
+++ b/drivers/iio/temperature/tmp006.c
@@ -179,7 +179,6 @@ static const struct iio_info tmp006_info = {
 	.read_raw = tmp006_read_raw,
 	.write_raw = tmp006_write_raw,
 	.attrs = &tmp006_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 static bool tmp006_check_identification(struct i2c_client *client)
diff --git a/drivers/iio/temperature/tmp007.c b/drivers/iio/temperature/tmp007.c
index 0615324d054c..0e3f2d432e10 100644
--- a/drivers/iio/temperature/tmp007.c
+++ b/drivers/iio/temperature/tmp007.c
@@ -426,7 +426,6 @@ static const struct iio_info tmp007_info = {
 	.read_event_value = tmp007_read_thresh,
 	.write_event_value = tmp007_write_thresh,
 	.attrs = &tmp007_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 static bool tmp007_identify(struct i2c_client *client)
diff --git a/drivers/iio/temperature/tsys01.c b/drivers/iio/temperature/tsys01.c
index 3e60c6189d98..0f7d025d7fa3 100644
--- a/drivers/iio/temperature/tsys01.c
+++ b/drivers/iio/temperature/tsys01.c
@@ -111,7 +111,6 @@ static const struct iio_chan_spec tsys01_channels[] = {
 
 static const struct iio_info tsys01_info = {
 	.read_raw = tsys01_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static bool tsys01_crc_valid(u16 *n_prom)
diff --git a/drivers/iio/temperature/tsys02d.c b/drivers/iio/temperature/tsys02d.c
index c0a19a000387..9b2e56fa5fd5 100644
--- a/drivers/iio/temperature/tsys02d.c
+++ b/drivers/iio/temperature/tsys02d.c
@@ -120,7 +120,6 @@ static const struct iio_info tsys02d_info = {
 	.read_raw = tsys02d_read_raw,
 	.write_raw = tsys02d_write_raw,
 	.attrs = &tsys02d_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 static int tsys02d_probe(struct i2c_client *client,
-- 
2.13.0
