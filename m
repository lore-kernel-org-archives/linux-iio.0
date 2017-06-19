Return-Path: <SRS0=ZnXk=5Y=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: robert.dolca@intel.com,
	denis.ciocca@st.com,
	linus.walleij@linaro.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	lorenzo.bianconi@st.com
Subject: [PATCH 1/2] iio: gyro: st_gyro: fix L3GD20H support
Date: Mon, 19 Jun 2017 22:04:30 +0200
Message-Id: <20170619200431.9615-2-lorenzo.bianconi@st.com>
In-Reply-To: <20170619200431.9615-1-lorenzo.bianconi@st.com>
References: <20170619200431.9615-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Add proper support for L3GD20H gyroscope sensor. In particular:
- use L3GD20H as device name instead of L3GD20
- fix available full scales
- fix available sample frequencies

Fixes: 9444a300c2be (IIO: Add support for L3GD20H gyroscope)
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/gyro/st_gyro.h      |  1 +
 drivers/iio/gyro/st_gyro_core.c | 13 +++++++------
 drivers/iio/gyro/st_gyro_i2c.c  |  5 +++++
 drivers/iio/gyro/st_gyro_spi.c  |  1 +
 4 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/gyro/st_gyro.h b/drivers/iio/gyro/st_gyro.h
index a5c5c4e29add..48923ae6ac3b 100644
--- a/drivers/iio/gyro/st_gyro.h
+++ b/drivers/iio/gyro/st_gyro.h
@@ -19,6 +19,7 @@
 #define LSM330DL_GYRO_DEV_NAME		"lsm330dl_gyro"
 #define LSM330DLC_GYRO_DEV_NAME		"lsm330dlc_gyro"
 #define L3GD20_GYRO_DEV_NAME		"l3gd20"
+#define L3GD20H_GYRO_DEV_NAME		"l3gd20h"
 #define L3G4IS_GYRO_DEV_NAME		"l3g4is_ui"
 #define LSM330_GYRO_DEV_NAME		"lsm330_gyro"
 #define LSM9DS0_GYRO_DEV_NAME		"lsm9ds0_gyro"
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index 2a42b3d583e8..e366422e8512 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -35,6 +35,7 @@
 #define ST_GYRO_DEFAULT_OUT_Z_L_ADDR		0x2c
 
 /* FULLSCALE */
+#define ST_GYRO_FS_AVL_245DPS			245
 #define ST_GYRO_FS_AVL_250DPS			250
 #define ST_GYRO_FS_AVL_500DPS			500
 #define ST_GYRO_FS_AVL_2000DPS			2000
@@ -196,17 +197,17 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
 		.wai = 0xd7,
 		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
 		.sensors_supported = {
-			[0] = L3GD20_GYRO_DEV_NAME,
+			[0] = L3GD20H_GYRO_DEV_NAME,
 		},
 		.ch = (struct iio_chan_spec *)st_gyro_16bit_channels,
 		.odr = {
 			.addr = 0x20,
 			.mask = 0xc0,
 			.odr_avl = {
-				{ .hz = 95, .value = 0x00, },
-				{ .hz = 190, .value = 0x01, },
-				{ .hz = 380, .value = 0x02, },
-				{ .hz = 760, .value = 0x03, },
+				{ .hz = 100, .value = 0x00, },
+				{ .hz = 200, .value = 0x01, },
+				{ .hz = 400, .value = 0x02, },
+				{ .hz = 800, .value = 0x03, },
 			},
 		},
 		.pw = {
@@ -224,7 +225,7 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
 			.mask = 0x30,
 			.fs_avl = {
 				[0] = {
-					.num = ST_GYRO_FS_AVL_250DPS,
+					.num = ST_GYRO_FS_AVL_245DPS,
 					.value = 0x00,
 					.gain = IIO_DEGREE_TO_RAD(8750),
 				},
diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
index 40056b821036..3f628746cb93 100644
--- a/drivers/iio/gyro/st_gyro_i2c.c
+++ b/drivers/iio/gyro/st_gyro_i2c.c
@@ -41,6 +41,10 @@ static const struct of_device_id st_gyro_of_match[] = {
 		.data = L3GD20_GYRO_DEV_NAME,
 	},
 	{
+		.compatible = "st,l3gd20h-gyro",
+		.data = L3GD20H_GYRO_DEV_NAME,
+	},
+	{
 		.compatible = "st,l3g4is-gyro",
 		.data = L3G4IS_GYRO_DEV_NAME,
 	},
@@ -95,6 +99,7 @@ static const struct i2c_device_id st_gyro_id_table[] = {
 	{ LSM330DL_GYRO_DEV_NAME },
 	{ LSM330DLC_GYRO_DEV_NAME },
 	{ L3GD20_GYRO_DEV_NAME },
+	{ L3GD20H_GYRO_DEV_NAME },
 	{ L3G4IS_GYRO_DEV_NAME },
 	{ LSM330_GYRO_DEV_NAME },
 	{ LSM9DS0_GYRO_DEV_NAME },
diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
index fbf2faed501c..fa14d8f2170d 100644
--- a/drivers/iio/gyro/st_gyro_spi.c
+++ b/drivers/iio/gyro/st_gyro_spi.c
@@ -52,6 +52,7 @@ static const struct spi_device_id st_gyro_id_table[] = {
 	{ LSM330DL_GYRO_DEV_NAME },
 	{ LSM330DLC_GYRO_DEV_NAME },
 	{ L3GD20_GYRO_DEV_NAME },
+	{ L3GD20H_GYRO_DEV_NAME },
 	{ L3G4IS_GYRO_DEV_NAME },
 	{ LSM330_GYRO_DEV_NAME },
 	{ LSM9DS0_GYRO_DEV_NAME },
-- 
2.13.1
