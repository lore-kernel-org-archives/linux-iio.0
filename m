Return-Path: <denis.ciocca@st.com>
From: Denis CIOCCA <denis.ciocca@st.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH] iio:gyro: bug on L3GD20H gyroscope support
Date: Fri, 14 Feb 2014 15:15:37 +0100
Message-Id: <1392387337-25324-1-git-send-email-denis.ciocca@st.com>
List-ID: <linux-iio@vger.kernel.org>

The driver was not able to manage the sensor: during probe function
and wai check, the driver stops and writes: "device name and WhoAmI mismatch."
The correct value of L3GD20H wai is 0xd7 instead of 0xd4.
Dropped support for the sensor.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/gyro/Kconfig        | 2 +-
 drivers/iio/gyro/st_gyro.h      | 1 -
 drivers/iio/gyro/st_gyro_core.c | 9 ++++-----
 drivers/iio/gyro/st_gyro_i2c.c  | 1 -
 drivers/iio/gyro/st_gyro_spi.c  | 1 -
 5 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
index 41c64a4..ac2d69e 100644
--- a/drivers/iio/gyro/Kconfig
+++ b/drivers/iio/gyro/Kconfig
@@ -70,7 +70,7 @@ config IIO_ST_GYRO_3AXIS
 	select IIO_TRIGGERED_BUFFER if (IIO_BUFFER)
 	help
 	  Say yes here to build support for STMicroelectronics gyroscopes:
-	  L3G4200D, LSM330DL, L3GD20, L3GD20H, LSM330DLC, L3G4IS, LSM330.
+	  L3G4200D, LSM330DL, L3GD20, LSM330DLC, L3G4IS, LSM330.
 
 	  This driver can also be built as a module. If so, these modules
 	  will be created:
diff --git a/drivers/iio/gyro/st_gyro.h b/drivers/iio/gyro/st_gyro.h
index f8f2bf8..c197360 100644
--- a/drivers/iio/gyro/st_gyro.h
+++ b/drivers/iio/gyro/st_gyro.h
@@ -19,7 +19,6 @@
 #define LSM330DL_GYRO_DEV_NAME		"lsm330dl_gyro"
 #define LSM330DLC_GYRO_DEV_NAME		"lsm330dlc_gyro"
 #define L3GD20_GYRO_DEV_NAME		"l3gd20"
-#define L3GD20H_GYRO_DEV_NAME		"l3gd20h"
 #define L3G4IS_GYRO_DEV_NAME		"l3g4is_ui"
 #define LSM330_GYRO_DEV_NAME		"lsm330_gyro"
 
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index d53d91a..a8e174a 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -167,11 +167,10 @@ static const struct st_sensors st_gyro_sensors[] = {
 		.wai = ST_GYRO_2_WAI_EXP,
 		.sensors_supported = {
 			[0] = L3GD20_GYRO_DEV_NAME,
-			[1] = L3GD20H_GYRO_DEV_NAME,
-			[2] = LSM330D_GYRO_DEV_NAME,
-			[3] = LSM330DLC_GYRO_DEV_NAME,
-			[4] = L3G4IS_GYRO_DEV_NAME,
-			[5] = LSM330_GYRO_DEV_NAME,
+			[1] = LSM330D_GYRO_DEV_NAME,
+			[2] = LSM330DLC_GYRO_DEV_NAME,
+			[3] = L3G4IS_GYRO_DEV_NAME,
+			[4] = LSM330_GYRO_DEV_NAME,
 		},
 		.ch = (struct iio_chan_spec *)st_gyro_16bit_channels,
 		.odr = {
diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
index 16b8b8d..23c12f3 100644
--- a/drivers/iio/gyro/st_gyro_i2c.c
+++ b/drivers/iio/gyro/st_gyro_i2c.c
@@ -55,7 +55,6 @@ static const struct i2c_device_id st_gyro_id_table[] = {
 	{ LSM330DL_GYRO_DEV_NAME },
 	{ LSM330DLC_GYRO_DEV_NAME },
 	{ L3GD20_GYRO_DEV_NAME },
-	{ L3GD20H_GYRO_DEV_NAME },
 	{ L3G4IS_GYRO_DEV_NAME },
 	{ LSM330_GYRO_DEV_NAME },
 	{},
diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
index 94763e2..b4ad3be 100644
--- a/drivers/iio/gyro/st_gyro_spi.c
+++ b/drivers/iio/gyro/st_gyro_spi.c
@@ -54,7 +54,6 @@ static const struct spi_device_id st_gyro_id_table[] = {
 	{ LSM330DL_GYRO_DEV_NAME },
 	{ LSM330DLC_GYRO_DEV_NAME },
 	{ L3GD20_GYRO_DEV_NAME },
-	{ L3GD20H_GYRO_DEV_NAME },
 	{ L3G4IS_GYRO_DEV_NAME },
 	{ LSM330_GYRO_DEV_NAME },
 	{},
-- 
1.8.5.4
