Return-Path: <SRS0=zGuk=GU=redhat.com=lorenzo.bianconi@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 1/2] iio: imu: st_lsm6dsx: add support to ism330dlc
Date: Fri, 30 Mar 2018 22:33:50 +0200
Message-Id: <20180330203351.22681-2-lorenzo.bianconi@redhat.com>
List-ID: <linux-iio@vger.kernel.org>

Add support to STM ISM330DLC 6-axis (acc + gyro) Mems sensor
http://www.st.com/resource/en/datasheet/ism330dlc.pdf

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
---
 drivers/iio/imu/st_lsm6dsx/Kconfig             |  3 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        |  2 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 10 +++++-----
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   |  3 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c    |  5 +++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c    |  5 +++++
 6 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
index 14f2eb6e9fb7..ccc817e17eb8 100644
--- a/drivers/iio/imu/st_lsm6dsx/Kconfig
+++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
@@ -8,7 +8,8 @@ config IIO_ST_LSM6DSX
 	select IIO_ST_LSM6DSX_SPI if (SPI_MASTER)
 	help
 	  Say yes here to build support for STMicroelectronics LSM6DSx imu
-	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm
+	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
+	  ism330dlc
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called st_lsm6dsx.
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index a3cc7cd97026..edcd838037cd 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -18,12 +18,14 @@
 #define ST_LSM6DS3H_DEV_NAME	"lsm6ds3h"
 #define ST_LSM6DSL_DEV_NAME	"lsm6dsl"
 #define ST_LSM6DSM_DEV_NAME	"lsm6dsm"
+#define ST_ISM330DLC_DEV_NAME	"ism330dlc"
 
 enum st_lsm6dsx_hw_id {
 	ST_LSM6DS3_ID,
 	ST_LSM6DS3H_ID,
 	ST_LSM6DSL_ID,
 	ST_LSM6DSM_ID,
+	ST_ISM330DLC_ID,
 	ST_LSM6DSX_MAX_ID,
 };
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 1045e025e92b..4994f920a836 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -1,10 +1,10 @@
 /*
  * STMicroelectronics st_lsm6dsx FIFO buffer library driver
  *
- * LSM6DS3/LSM6DS3H/LSM6DSL/LSM6DSM: The FIFO buffer can be configured
- * to store data from gyroscope and accelerometer. Samples are queued
- * without any tag according to a specific pattern based on 'FIFO data sets'
- * (6 bytes each):
+ * LSM6DS3/LSM6DS3H/LSM6DSL/LSM6DSM/ISM330DLC: The FIFO buffer can be
+ * configured to store data from gyroscope and accelerometer. Samples are
+ * queued without any tag according to a specific pattern based on
+ * 'FIFO data sets' (6 bytes each):
  *  - 1st data set is reserved for gyroscope data
  *  - 2nd data set is reserved for accelerometer data
  * The FIFO pattern changes depending on the ODRs and decimation factors
@@ -276,7 +276,7 @@ static inline int st_lsm6dsx_read_block(struct st_lsm6dsx_hw *hw, u8 *data,
 #define ST_LSM6DSX_IIO_BUFF_SIZE	(ALIGN(ST_LSM6DSX_SAMPLE_SIZE, \
 					       sizeof(s64)) + sizeof(s64))
 /**
- * st_lsm6dsx_read_fifo() - LSM6DS3-LSM6DS3H-LSM6DSL-LSM6DSM read FIFO routine
+ * st_lsm6dsx_read_fifo() - hw FIFO read routine
  * @hw: Pointer to instance of struct st_lsm6dsx_hw.
  *
  * Read samples from the hw FIFO and push them to IIO buffers.
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 50d6491df484..aebbe0ddd8d8 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -17,7 +17,7 @@
  *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
  *   - FIFO size: 8KB
  *
- * - LSM6DS3H/LSM6DSL/LSM6DSM:
+ * - LSM6DS3H/LSM6DSL/LSM6DSM/ISM330DLC:
  *   - Accelerometer/Gyroscope supported ODR [Hz]: 13, 26, 52, 104, 208, 416
  *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
  *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
@@ -252,6 +252,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 		.id = {
 			[0] = ST_LSM6DSL_ID,
 			[1] = ST_LSM6DSM_ID,
+			[2] = ST_ISM330DLC_ID,
 		},
 		.decimator = {
 			[ST_LSM6DSX_ID_ACC] = {
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
index 41525dd2aab7..377c4e9997da 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -57,6 +57,10 @@ static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
 		.compatible = "st,lsm6dsm",
 		.data = (void *)ST_LSM6DSM_ID,
 	},
+	{
+		.compatible = "st,ism330dlc",
+		.data = (void *)ST_ISM330DLC_ID,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
@@ -66,6 +70,7 @@ static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] = {
 	{ ST_LSM6DS3H_DEV_NAME, ST_LSM6DS3H_ID },
 	{ ST_LSM6DSL_DEV_NAME, ST_LSM6DSL_ID },
 	{ ST_LSM6DSM_DEV_NAME, ST_LSM6DSM_ID },
+	{ ST_ISM330DLC_DEV_NAME, ST_ISM330DLC_ID },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
index 2c8135834479..fec5c6ce7eb7 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
@@ -57,6 +57,10 @@ static const struct of_device_id st_lsm6dsx_spi_of_match[] = {
 		.compatible = "st,lsm6dsm",
 		.data = (void *)ST_LSM6DSM_ID,
 	},
+	{
+		.compatible = "st,ism330dlc",
+		.data = (void *)ST_ISM330DLC_ID,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_lsm6dsx_spi_of_match);
@@ -66,6 +70,7 @@ static const struct spi_device_id st_lsm6dsx_spi_id_table[] = {
 	{ ST_LSM6DS3H_DEV_NAME, ST_LSM6DS3H_ID },
 	{ ST_LSM6DSL_DEV_NAME, ST_LSM6DSL_ID },
 	{ ST_LSM6DSM_DEV_NAME, ST_LSM6DSM_ID },
+	{ ST_ISM330DLC_DEV_NAME, ST_ISM330DLC_ID },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);
-- 
2.16.2
