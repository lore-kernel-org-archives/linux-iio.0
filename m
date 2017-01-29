Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33828 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751014AbdA2Ktk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Jan 2017 05:49:40 -0500
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
Subject: [PATCH 4/5] iio: imu: st_lsm6dsx: add support to lsm6ds3h
Date: Sun, 29 Jan 2017 11:49:27 +0100
Message-Id: <20170129104928.15533-5-lorenzo.bianconi@st.com>
In-Reply-To: <20170129104928.15533-1-lorenzo.bianconi@st.com>
References: <20170129104928.15533-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add support to STM LSM6DS3H 6-axis (acc + gyro) Mems sensor

http://www.st.com/resource/en/datasheet/lsm6ds3h.pdf
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/imu/st_lsm6dsx/Kconfig             | 2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        | 2 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 9 +++++----
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 9 ++++++++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c    | 5 +++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c    | 5 +++++
 6 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
index d264783..e573371 100644
--- a/drivers/iio/imu/st_lsm6dsx/Kconfig
+++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
@@ -8,7 +8,7 @@ config IIO_ST_LSM6DSX
 	select IIO_ST_LSM6DSX_SPI if (SPI_MASTER)
 	help
 	  Say yes here to build support for STMicroelectronics LSM6DSx imu
-	  sensor. Supported devices: lsm6ds3, lsm6dsl, lsm6dsm
+	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called st_lsm6dsx.
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index e0ece13..6a9849e 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -15,11 +15,13 @@
 #include <linux/device.h>
 
 #define ST_LSM6DS3_DEV_NAME	"lsm6ds3"
+#define ST_LSM6DS3H_DEV_NAME	"lsm6ds3h"
 #define ST_LSM6DSL_DEV_NAME	"lsm6dsl"
 #define ST_LSM6DSM_DEV_NAME	"lsm6dsm"
 
 enum st_lsm6dsx_hw_id {
 	ST_LSM6DS3_ID,
+	ST_LSM6DS3H_ID,
 	ST_LSM6DSL_ID,
 	ST_LSM6DSM_ID,
 	ST_LSM6DSX_MAX_ID,
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 73a6492e..e71ecce 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -1,9 +1,10 @@
 /*
  * STMicroelectronics st_lsm6dsx FIFO buffer library driver
  *
- * LSM6DS3/LSM6DSL/LSM6DSM: The FIFO buffer can be configured to store data
- * from gyroscope and accelerometer. Samples are queued without any tag
- * according to a specific pattern based on 'FIFO data sets' (6 bytes each):
+ * LSM6DS3/LSM6DS3H/LSM6DSL/LSM6DSM: The FIFO buffer can be configured
+ * to store data from gyroscope and accelerometer. Samples are queued
+ * without any tag according to a specific pattern based on 'FIFO data sets'
+ * (6 bytes each):
  *  - 1st data set is reserved for gyroscope data
  *  - 2nd data set is reserved for accelerometer data
  * The FIFO pattern changes depending on the ODRs and decimation factors
@@ -206,7 +207,7 @@ int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor, u16 watermark)
 }
 
 /**
- * st_lsm6dsx_read_fifo() - LSM6DS3-LSM6DSL-LSM6DSM read FIFO routine
+ * st_lsm6dsx_read_fifo() - LSM6DS3-LSM6DS3H-LSM6DSL-LSM6DSM read FIFO routine
  * @hw: Pointer to instance of struct st_lsm6dsx_hw.
  *
  * Read samples from the hw FIFO and push them to IIO buffers.
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 5d8d5cd..c433223 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -17,7 +17,7 @@
  *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
  *   - FIFO size: 8KB
  *
- * - LSM6DSL/LSM6DSM:
+ * - LSM6DS3H/LSM6DSL/LSM6DSM:
  *   - Accelerometer/Gyroscope supported ODR [Hz]: 13, 26, 52, 104, 208, 416
  *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
  *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
@@ -165,6 +165,13 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 		},
 	},
 	{
+		.wai = 0x69,
+		.max_fifo_size = 4096,
+		.id = {
+			[0] = ST_LSM6DS3H_ID,
+		},
+	},
+	{
 		.wai = 0x6a,
 		.max_fifo_size = 4096,
 		.id = {
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
index 60a3de0..2e4ed26 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -71,6 +71,10 @@ static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
 		.data = (void *)ST_LSM6DS3_ID,
 	},
 	{
+		.compatible = "st,lsm6ds3h",
+		.data = (void *)ST_LSM6DS3H_ID,
+	},
+	{
 		.compatible = "st,lsm6dsl",
 		.data = (void *)ST_LSM6DSL_ID,
 	},
@@ -84,6 +88,7 @@ MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
 
 static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] = {
 	{ ST_LSM6DS3_DEV_NAME, ST_LSM6DS3_ID },
+	{ ST_LSM6DS3H_DEV_NAME, ST_LSM6DS3H_ID },
 	{ ST_LSM6DSL_DEV_NAME, ST_LSM6DSL_ID },
 	{ ST_LSM6DSM_DEV_NAME, ST_LSM6DSM_ID },
 	{},
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
index 39edb40..1bf4a58 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
@@ -88,6 +88,10 @@ static const struct of_device_id st_lsm6dsx_spi_of_match[] = {
 		.data = (void *)ST_LSM6DS3_ID,
 	},
 	{
+		.compatible = "st,lsm6ds3h",
+		.data = (void *)ST_LSM6DS3H_ID,
+	},
+	{
 		.compatible = "st,lsm6dsl",
 		.data = (void *)ST_LSM6DSL_ID,
 	},
@@ -101,6 +105,7 @@ MODULE_DEVICE_TABLE(of, st_lsm6dsx_spi_of_match);
 
 static const struct spi_device_id st_lsm6dsx_spi_id_table[] = {
 	{ ST_LSM6DS3_DEV_NAME, ST_LSM6DS3_ID },
+	{ ST_LSM6DS3H_DEV_NAME, ST_LSM6DS3H_ID },
 	{ ST_LSM6DSL_DEV_NAME, ST_LSM6DSL_ID },
 	{ ST_LSM6DSM_DEV_NAME, ST_LSM6DSM_ID },
 	{},
-- 
2.9.3

