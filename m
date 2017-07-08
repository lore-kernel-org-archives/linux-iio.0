Return-Path: <SRS0=khi1=6L=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	lorenzo.bianconi@st.com,
	linus.walleij@linaro.org,
	tiberiu.a.breana@intel.com
Subject: [PATCH 3/3] iio: accel: st_accel: rename H3LIS331DL_DRIVER_NAME in H3LIS331DL_ACCEL_DEV_NAME
Date: Sat,  8 Jul 2017 13:00:18 +0200
Message-Id: <20170708110018.12772-4-lorenzo.bianconi@st.com>
In-Reply-To: <20170708110018.12772-1-lorenzo.bianconi@st.com>
References: <20170708110018.12772-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

In order to use the standard name convention rename H3LIS331DL_DRIVER_NAME
macro in H3LIS331DL_ACCEL_DEV_NAME

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/accel/st_accel.h      | 2 +-
 drivers/iio/accel/st_accel_core.c | 2 +-
 drivers/iio/accel/st_accel_i2c.c  | 4 ++--
 drivers/iio/accel/st_accel_spi.c  | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
index fe3864f0f146..0fe521609a3a 100644
--- a/drivers/iio/accel/st_accel.h
+++ b/drivers/iio/accel/st_accel.h
@@ -35,7 +35,7 @@ enum st_accel_type {
 	ST_ACCEL_MAX,
 };
 
-#define H3LIS331DL_DRIVER_NAME		"h3lis331dl_accel"
+#define H3LIS331DL_ACCEL_DEV_NAME	"h3lis331dl_accel"
 #define LIS3LV02DL_ACCEL_DEV_NAME	"lis3lv02dl_accel"
 #define LSM303DLHC_ACCEL_DEV_NAME	"lsm303dlhc_accel"
 #define LIS3DH_ACCEL_DEV_NAME		"lis3dh"
diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 07d1489cd457..c7709494bed3 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -444,7 +444,7 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 		.wai = 0x32,
 		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
 		.sensors_supported = {
-			[0] = H3LIS331DL_DRIVER_NAME,
+			[0] = H3LIS331DL_ACCEL_DEV_NAME,
 		},
 		.ch = (struct iio_chan_spec *)st_accel_12bit_channels,
 		.odr = {
diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index 1b22c5714e89..18cafb9f2468 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -84,7 +84,7 @@ static const struct of_device_id st_accel_of_match[] = {
 	},
 	{
 		.compatible = "st,h3lis331dl-accel",
-		.data = H3LIS331DL_DRIVER_NAME,
+		.data = H3LIS331DL_ACCEL_DEV_NAME,
 	},
 	{
 		.compatible = "st,lis3l02dq",
@@ -126,7 +126,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
 	{ LIS2DH12_ACCEL_DEV_NAME, LIS2DH12 },
 	{ LIS3L02DQ_ACCEL_DEV_NAME, LIS3L02DQ },
 	{ LNG2DM_ACCEL_DEV_NAME, LNG2DM },
-	{ H3LIS331DL_DRIVER_NAME, H3LIS331DL },
+	{ H3LIS331DL_ACCEL_DEV_NAME, H3LIS331DL },
 	{ LIS331DL_ACCEL_DEV_NAME, LIS331DL },
 	{ LIS3LV02DL_ACCEL_DEV_NAME, LIS3LV02DL },
 	{},
diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index 7a2a0384b42d..915fa49085f7 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -76,7 +76,7 @@ static const struct of_device_id st_accel_of_match[] = {
 	},
 	{
 		.compatible = "st,h3lis331dl-accel",
-		.data = H3LIS331DL_DRIVER_NAME,
+		.data = H3LIS331DL_ACCEL_DEV_NAME,
 	},
 	{
 		.compatible = "st,lis331dl-accel",
@@ -130,7 +130,7 @@ static const struct spi_device_id st_accel_id_table[] = {
 	{ LIS2DH12_ACCEL_DEV_NAME },
 	{ LIS3L02DQ_ACCEL_DEV_NAME },
 	{ LNG2DM_ACCEL_DEV_NAME },
-	{ H3LIS331DL_DRIVER_NAME },
+	{ H3LIS331DL_ACCEL_DEV_NAME },
 	{ LIS331DL_ACCEL_DEV_NAME },
 	{ LIS3LV02DL_ACCEL_DEV_NAME },
 	{},
-- 
2.13.1
