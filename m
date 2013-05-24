Return-Path: <denis.ciocca@st.com>
From: Denis CIOCCA <denis.ciocca@st.com>
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
	j.anaszewski@samsung.com, lee.jones@stericsson.com,
	Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 1/3] iio:common: ST_SENSORS_LSM_CHANNELS macro changed
Date: Fri, 24 May 2013 16:25:15 +0200
Message-Id: <1369405517-2619-2-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1369405517-2619-1-git-send-email-denis.ciocca@st.com>
References: <1369405517-2619-1-git-send-email-denis.ciocca@st.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/accel/st_accel_core.c       |   36 ++++++++++++++++++++-----------
 drivers/iio/gyro/st_gyro_core.c         |   21 ++++++++++--------
 drivers/iio/magnetometer/st_magn_core.c |   36 ++++++++++++++++++++-----------
 include/linux/iio/common/st_sensors.h   |   20 ++++++++---------
 4 files changed, 69 insertions(+), 44 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index e0f5a3c..40236d5 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -125,22 +125,34 @@
 #define ST_ACCEL_3_MULTIREAD_BIT		false
 
 static const struct iio_chan_spec st_accel_12bit_channels[] = {
-	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL, ST_SENSORS_SCAN_X, IIO_MOD_X, IIO_LE,
-		ST_SENSORS_DEFAULT_12_REALBITS, ST_ACCEL_DEFAULT_OUT_X_L_ADDR),
-	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL, ST_SENSORS_SCAN_Y, IIO_MOD_Y, IIO_LE,
-		ST_SENSORS_DEFAULT_12_REALBITS, ST_ACCEL_DEFAULT_OUT_Y_L_ADDR),
-	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL, ST_SENSORS_SCAN_Z, IIO_MOD_Z, IIO_LE,
-		ST_SENSORS_DEFAULT_12_REALBITS, ST_ACCEL_DEFAULT_OUT_Z_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_LE, 12, 16,
+			ST_ACCEL_DEFAULT_OUT_X_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_Y, 1, IIO_MOD_Y, 's', IIO_LE, 12, 16,
+			ST_ACCEL_DEFAULT_OUT_Y_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_Z, 1, IIO_MOD_Z, 's', IIO_LE, 12, 16,
+			ST_ACCEL_DEFAULT_OUT_Z_L_ADDR),
 	IIO_CHAN_SOFT_TIMESTAMP(3)
 };
 
 static const struct iio_chan_spec st_accel_16bit_channels[] = {
-	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL, ST_SENSORS_SCAN_X, IIO_MOD_X, IIO_LE,
-		ST_SENSORS_DEFAULT_16_REALBITS, ST_ACCEL_DEFAULT_OUT_X_L_ADDR),
-	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL, ST_SENSORS_SCAN_Y, IIO_MOD_Y, IIO_LE,
-		ST_SENSORS_DEFAULT_16_REALBITS, ST_ACCEL_DEFAULT_OUT_Y_L_ADDR),
-	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL, ST_SENSORS_SCAN_Z, IIO_MOD_Z, IIO_LE,
-		ST_SENSORS_DEFAULT_16_REALBITS, ST_ACCEL_DEFAULT_OUT_Z_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_LE, 16, 16,
+			ST_ACCEL_DEFAULT_OUT_X_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_Y, 1, IIO_MOD_Y, 's', IIO_LE, 16, 16,
+			ST_ACCEL_DEFAULT_OUT_Y_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_Z, 1, IIO_MOD_Z, 's', IIO_LE, 16, 16,
+			ST_ACCEL_DEFAULT_OUT_Z_L_ADDR),
 	IIO_CHAN_SOFT_TIMESTAMP(3)
 };
 
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index fa9b242..9bae46b 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -86,15 +86,18 @@
 #define ST_GYRO_2_MULTIREAD_BIT			true
 
 static const struct iio_chan_spec st_gyro_16bit_channels[] = {
-	ST_SENSORS_LSM_CHANNELS(IIO_ANGL_VEL, ST_SENSORS_SCAN_X,
-		IIO_MOD_X, IIO_LE, ST_SENSORS_DEFAULT_16_REALBITS,
-						ST_GYRO_DEFAULT_OUT_X_L_ADDR),
-	ST_SENSORS_LSM_CHANNELS(IIO_ANGL_VEL, ST_SENSORS_SCAN_Y,
-		IIO_MOD_Y, IIO_LE, ST_SENSORS_DEFAULT_16_REALBITS,
-						ST_GYRO_DEFAULT_OUT_Y_L_ADDR),
-	ST_SENSORS_LSM_CHANNELS(IIO_ANGL_VEL, ST_SENSORS_SCAN_Z,
-		IIO_MOD_Z, IIO_LE, ST_SENSORS_DEFAULT_16_REALBITS,
-						ST_GYRO_DEFAULT_OUT_Z_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_ANGL_VEL,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_LE, 16, 16,
+			ST_GYRO_DEFAULT_OUT_X_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_ANGL_VEL,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_Y, 1, IIO_MOD_Y, 's', IIO_LE, 16, 16,
+			ST_GYRO_DEFAULT_OUT_Y_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_ANGL_VEL,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_Z, 1, IIO_MOD_Z, 's', IIO_LE, 16, 16,
+			ST_GYRO_DEFAULT_OUT_Z_L_ADDR),
 	IIO_CHAN_SOFT_TIMESTAMP(3)
 };
 
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 16f0d6d..715d616 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -113,22 +113,34 @@
 #define ST_MAGN_2_OUT_Z_L_ADDR			0x2c
 
 static const struct iio_chan_spec st_magn_16bit_channels[] = {
-	ST_SENSORS_LSM_CHANNELS(IIO_MAGN, ST_SENSORS_SCAN_X, IIO_MOD_X, IIO_LE,
-		ST_SENSORS_DEFAULT_16_REALBITS, ST_MAGN_DEFAULT_OUT_X_L_ADDR),
-	ST_SENSORS_LSM_CHANNELS(IIO_MAGN, ST_SENSORS_SCAN_Y, IIO_MOD_Y, IIO_LE,
-		ST_SENSORS_DEFAULT_16_REALBITS, ST_MAGN_DEFAULT_OUT_Y_L_ADDR),
-	ST_SENSORS_LSM_CHANNELS(IIO_MAGN, ST_SENSORS_SCAN_Z, IIO_MOD_Z, IIO_LE,
-		ST_SENSORS_DEFAULT_16_REALBITS, ST_MAGN_DEFAULT_OUT_Z_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_LE, 16, 16,
+			ST_MAGN_DEFAULT_OUT_X_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_Y, 1, IIO_MOD_Y, 's', IIO_LE, 16, 16,
+			ST_MAGN_DEFAULT_OUT_Y_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_Z, 1, IIO_MOD_Z, 's', IIO_LE, 16, 16,
+			ST_MAGN_DEFAULT_OUT_Z_L_ADDR),
 	IIO_CHAN_SOFT_TIMESTAMP(3)
 };
 
 static const struct iio_chan_spec st_magn_2_16bit_channels[] = {
-	ST_SENSORS_LSM_CHANNELS(IIO_MAGN, ST_SENSORS_SCAN_X, IIO_MOD_X, IIO_LE,
-		ST_SENSORS_DEFAULT_16_REALBITS, ST_MAGN_2_OUT_X_L_ADDR),
-	ST_SENSORS_LSM_CHANNELS(IIO_MAGN, ST_SENSORS_SCAN_Y, IIO_MOD_Y, IIO_LE,
-		ST_SENSORS_DEFAULT_16_REALBITS, ST_MAGN_2_OUT_Y_L_ADDR),
-	ST_SENSORS_LSM_CHANNELS(IIO_MAGN, ST_SENSORS_SCAN_Z, IIO_MOD_Z, IIO_LE,
-		ST_SENSORS_DEFAULT_16_REALBITS, ST_MAGN_2_OUT_Z_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_LE, 16, 16,
+			ST_MAGN_2_OUT_X_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_Y, 1, IIO_MOD_Y, 's', IIO_LE, 16, 16,
+			ST_MAGN_2_OUT_Y_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_Z, 1, IIO_MOD_Z, 's', IIO_LE, 16, 16,
+			ST_MAGN_2_OUT_Z_L_ADDR),
 	IIO_CHAN_SOFT_TIMESTAMP(3)
 };
 
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index 172c5b2..5ffd763 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -30,8 +30,6 @@
 #define ST_SENSORS_SCAN_X			0
 #define ST_SENSORS_SCAN_Y			1
 #define ST_SENSORS_SCAN_Z			2
-#define ST_SENSORS_DEFAULT_12_REALBITS		12
-#define ST_SENSORS_DEFAULT_16_REALBITS		16
 #define ST_SENSORS_DEFAULT_POWER_ON_VALUE	0x01
 #define ST_SENSORS_DEFAULT_POWER_OFF_VALUE	0x00
 #define ST_SENSORS_DEFAULT_WAI_ADDRESS		0x0f
@@ -42,20 +40,20 @@
 #define ST_SENSORS_MAX_NAME			17
 #define ST_SENSORS_MAX_4WAI			7
 
-#define ST_SENSORS_LSM_CHANNELS(device_type, index, mod, endian, bits, addr) \
+#define ST_SENSORS_LSM_CHANNELS(device_type, mask, index, mod, \
+					ch2, s, endian, rbits, sbits, addr) \
 { \
 	.type = device_type, \
-	.modified = 1, \
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
-			BIT(IIO_CHAN_INFO_SCALE), \
+	.modified = mod, \
+	.info_mask_separate = mask, \
 	.scan_index = index, \
-	.channel2 = mod, \
+	.channel2 = ch2, \
 	.address = addr, \
 	.scan_type = { \
-		.sign = 's', \
-		.realbits = bits, \
-		.shift = 16 - bits, \
-		.storagebits = 16, \
+		.sign = s, \
+		.realbits = rbits, \
+		.shift = sbits - rbits, \
+		.storagebits = sbits, \
 		.endianness = endian, \
 	}, \
 }
-- 
1.7.9.5
