Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/6] staging:iio  Break up gyro.h and move to new abi
Date: Wed,  5 May 2010 23:25:42 +0100
Message-Id: <1273098346-4184-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1273098346-4184-1-git-send-email-jic23@cam.ac.uk>
References: <1273098346-4184-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/inclinometer.h  |   23 +++++++++++++++
 drivers/staging/iio/gyro/gyro.h           |   43 +++--------------------------
 drivers/staging/iio/imu/adis16300_core.c  |   11 ++++---
 drivers/staging/iio/imu/adis16400_core.c  |   16 +++++-----
 drivers/staging/iio/magnetometer/magnet.h |   12 ++++----
 5 files changed, 47 insertions(+), 58 deletions(-)

diff --git a/drivers/staging/iio/accel/inclinometer.h b/drivers/staging/iio/accel/inclinometer.h
new file mode 100644
index 0000000..5b49f83
--- /dev/null
+++ b/drivers/staging/iio/accel/inclinometer.h
@@ -0,0 +1,23 @@
+/*
+ * Inclinometer related attributes
+ */
+#include "../sysfs.h"
+
+#define IIO_DEV_ATTR_INCLI_X(_show, _addr)			\
+	IIO_DEVICE_ATTR(incli_x_raw, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_INCLI_Y(_show, _addr)			\
+	IIO_DEVICE_ATTR(incli_y_raw, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_INCLI_Z(_show, _addr)			\
+	IIO_DEVICE_ATTR(incli_z_raw, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_INCLI_X_OFFSET(_mode, _show, _store, _addr) \
+	IIO_DEVICE_ATTR(incli_x_offset, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_INCLI_Y_OFFSET(_mode, _show, _store, _addr) \
+	IIO_DEVICE_ATTR(incli_y_offset, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_INCLI_Z_OFFSET(_mode, _show, _store, _addr) \
+	IIO_DEVICE_ATTR(incli_z_offset, _mode, _show, _store, _addr)
+
diff --git a/drivers/staging/iio/gyro/gyro.h b/drivers/staging/iio/gyro/gyro.h
index 7c4dcf2..16f6ffa 100644
--- a/drivers/staging/iio/gyro/gyro.h
+++ b/drivers/staging/iio/gyro/gyro.h
@@ -28,49 +28,14 @@
 	IIO_DEVICE_ATTR(gyro_scale, S_IRUGO, _show, _store, _addr)
 
 #define IIO_DEV_ATTR_GYRO(_show, _addr)			\
-	IIO_DEVICE_ATTR(gyro, S_IRUGO, _show, NULL, _addr)
+	IIO_DEVICE_ATTR(gyro_raw, S_IRUGO, _show, NULL, _addr)
 
 #define IIO_DEV_ATTR_GYRO_X(_show, _addr)			\
-	IIO_DEVICE_ATTR(gyro_x, S_IRUGO, _show, NULL, _addr)
+	IIO_DEVICE_ATTR(gyro_x_raw, S_IRUGO, _show, NULL, _addr)
 
 #define IIO_DEV_ATTR_GYRO_Y(_show, _addr)			\
-	IIO_DEVICE_ATTR(gyro_y, S_IRUGO, _show, NULL, _addr)
+	IIO_DEVICE_ATTR(gyro_y_raw, S_IRUGO, _show, NULL, _addr)
 
 #define IIO_DEV_ATTR_GYRO_Z(_show, _addr)			\
-	IIO_DEVICE_ATTR(gyro_z, S_IRUGO, _show, NULL, _addr)
+	IIO_DEVICE_ATTR(gyro_z_raw, S_IRUGO, _show, NULL, _addr)
 
-#define IIO_DEV_ATTR_TEMP_X(_show, _addr)			\
-	IIO_DEVICE_ATTR(temp_x, S_IRUGO, _show, NULL, _addr)
-
-#define IIO_DEV_ATTR_TEMP_Y(_show, _addr)			\
-	IIO_DEVICE_ATTR(temp_y, S_IRUGO, _show, NULL, _addr)
-
-#define IIO_DEV_ATTR_TEMP_Z(_show, _addr)			\
-	IIO_DEVICE_ATTR(temp_z, S_IRUGO, _show, NULL, _addr)
-
-#define IIO_DEV_ATTR_INCLI_X(_show, _addr)			\
-	IIO_DEVICE_ATTR(incli_x, S_IRUGO, _show, NULL, _addr)
-
-#define IIO_DEV_ATTR_INCLI_Y(_show, _addr)			\
-	IIO_DEVICE_ATTR(incli_y, S_IRUGO, _show, NULL, _addr)
-
-#define IIO_DEV_ATTR_INCLI_Z(_show, _addr)			\
-	IIO_DEVICE_ATTR(incli_z, S_IRUGO, _show, NULL, _addr)
-
-#define IIO_DEV_ATTR_INCLI_X_OFFSET(_mode, _show, _store, _addr) \
-	IIO_DEVICE_ATTR(incli_x_offset, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_INCLI_Y_OFFSET(_mode, _show, _store, _addr) \
-	IIO_DEVICE_ATTR(incli_y_offset, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_INCLI_Z_OFFSET(_mode, _show, _store, _addr) \
-	IIO_DEVICE_ATTR(incli_z_offset, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_ROT(_show, _addr)                    \
-	IIO_DEVICE_ATTR(rot, S_IRUGO, _show, NULL, _addr)
-
-#define IIO_DEV_ATTR_ROT_OFFSET(_mode, _show, _store, _addr) \
-	IIO_DEVICE_ATTR(rot_offset, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_ANGL(_show, _addr)                         \
-	IIO_DEVICE_ATTR(angl, S_IRUGO, _show, NULL, _addr)
diff --git a/drivers/staging/iio/imu/adis16300_core.c b/drivers/staging/iio/imu/adis16300_core.c
index 9f5f8cb..b923ecc 100644
--- a/drivers/staging/iio/imu/adis16300_core.c
+++ b/drivers/staging/iio/imu/adis16300_core.c
@@ -21,6 +21,7 @@
 #include "../iio.h"
 #include "../sysfs.h"
 #include "../accel/accel.h"
+#include "../accel/inclinometer.h"
 #include "../gyro/gyro.h"
 #include "../adc/adc.h"
 
@@ -613,7 +614,7 @@ static IIO_DEV_ATTR_INCLI_Y(adis16300_read_13bit_signed,
 		ADIS16300_YINCLI_OUT);
 static IIO_CONST_ATTR(incli_scale, "0.044 d");
 
-static IIO_DEV_ATTR_TEMP(adis16300_read_12bit_signed);
+static IIO_DEV_ATTR_TEMP_RAW(adis16300_read_12bit_signed);
 static IIO_CONST_ATTR(temp_offset, "198.16 K");
 static IIO_CONST_ATTR(temp_scale, "0.14 K");
 
@@ -645,16 +646,16 @@ static struct attribute *adis16300_attributes[] = {
 	&iio_dev_attr_accel_z_offset.dev_attr.attr,
 	&iio_dev_attr_in_supply_raw.dev_attr.attr,
 	&iio_const_attr_in_supply_scale.dev_attr.attr,
-	&iio_dev_attr_gyro_x.dev_attr.attr,
+	&iio_dev_attr_gyro_x_raw.dev_attr.attr,
 	&iio_const_attr_gyro_scale.dev_attr.attr,
 	&iio_dev_attr_accel_x_raw.dev_attr.attr,
 	&iio_dev_attr_accel_y_raw.dev_attr.attr,
 	&iio_dev_attr_accel_z_raw.dev_attr.attr,
 	&iio_const_attr_accel_scale.dev_attr.attr,
-	&iio_dev_attr_incli_x.dev_attr.attr,
-	&iio_dev_attr_incli_y.dev_attr.attr,
+	&iio_dev_attr_incli_x_raw.dev_attr.attr,
+	&iio_dev_attr_incli_y_raw.dev_attr.attr,
 	&iio_const_attr_incli_scale.dev_attr.attr,
-	&iio_dev_attr_temp.dev_attr.attr,
+	&iio_dev_attr_temp_raw.dev_attr.attr,
 	&iio_const_attr_temp_offset.dev_attr.attr,
 	&iio_const_attr_temp_scale.dev_attr.attr,
 	&iio_dev_attr_in0_raw.dev_attr.attr,
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 27e4a73..868c526 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -626,7 +626,7 @@ static IIO_DEV_ATTR_MAGN_Z(adis16400_read_14bit_signed,
 static IIO_CONST_ATTR(magn_scale, "0.0005 Gs");
 
 
-static IIO_DEV_ATTR_TEMP(adis16400_read_12bit_signed);
+static IIO_DEV_ATTR_TEMP_RAW(adis16400_read_12bit_signed);
 static IIO_CONST_ATTR(temp_offset, "198.16 K");
 static IIO_CONST_ATTR(temp_scale, "0.14 K");
 
@@ -658,19 +658,19 @@ static struct attribute *adis16400_attributes[] = {
 	&iio_dev_attr_accel_z_offset.dev_attr.attr,
 	&iio_dev_attr_in_supply_raw.dev_attr.attr,
 	&iio_const_attr_in_supply_scale.dev_attr.attr,
-	&iio_dev_attr_gyro_x.dev_attr.attr,
-	&iio_dev_attr_gyro_y.dev_attr.attr,
-	&iio_dev_attr_gyro_z.dev_attr.attr,
+	&iio_dev_attr_gyro_x_raw.dev_attr.attr,
+	&iio_dev_attr_gyro_y_raw.dev_attr.attr,
+	&iio_dev_attr_gyro_z_raw.dev_attr.attr,
 	&iio_const_attr_gyro_scale.dev_attr.attr,
 	&iio_dev_attr_accel_x_raw.dev_attr.attr,
 	&iio_dev_attr_accel_y_raw.dev_attr.attr,
 	&iio_dev_attr_accel_z_raw.dev_attr.attr,
 	&iio_const_attr_accel_scale.dev_attr.attr,
-	&iio_dev_attr_magn_x.dev_attr.attr,
-	&iio_dev_attr_magn_y.dev_attr.attr,
-	&iio_dev_attr_magn_z.dev_attr.attr,
+	&iio_dev_attr_magn_x_raw.dev_attr.attr,
+	&iio_dev_attr_magn_y_raw.dev_attr.attr,
+	&iio_dev_attr_magn_z_raw.dev_attr.attr,
 	&iio_const_attr_magn_scale.dev_attr.attr,
-	&iio_dev_attr_temp.dev_attr.attr,
+	&iio_dev_attr_temp_raw.dev_attr.attr,
 	&iio_const_attr_temp_offset.dev_attr.attr,
 	&iio_const_attr_temp_scale.dev_attr.attr,
 	&iio_dev_attr_in0_raw.dev_attr.attr,
diff --git a/drivers/staging/iio/magnetometer/magnet.h b/drivers/staging/iio/magnetometer/magnet.h
index 6f6c6ed..6433830 100644
--- a/drivers/staging/iio/magnetometer/magnet.h
+++ b/drivers/staging/iio/magnetometer/magnet.h
@@ -21,11 +21,11 @@
 #define IIO_DEV_ATTR_MAGN_Z_GAIN(_mode, _show, _store, _addr)		\
 	IIO_DEVICE_ATTR(magn_z_gain, _mode, _show, _store, _addr)
 
-#define IIO_DEV_ATTR_MAGN_X(_show, _addr)			\
-	IIO_DEVICE_ATTR(magn_x, S_IRUGO, _show, NULL, _addr)
+#define IIO_DEV_ATTR_MAGN_X(_show, _addr)				\
+	IIO_DEVICE_ATTR(magn_x_raw, S_IRUGO, _show, NULL, _addr)
 
-#define IIO_DEV_ATTR_MAGN_Y(_show, _addr)			\
-	IIO_DEVICE_ATTR(magn_y, S_IRUGO, _show, NULL, _addr)
+#define IIO_DEV_ATTR_MAGN_Y(_show, _addr)				\
+	IIO_DEVICE_ATTR(magn_y_raw, S_IRUGO, _show, NULL, _addr)
 
-#define IIO_DEV_ATTR_MAGN_Z(_show, _addr)			\
-	IIO_DEVICE_ATTR(magn_z, S_IRUGO, _show, NULL, _addr)
+#define IIO_DEV_ATTR_MAGN_Z(_show, _addr)				\
+	IIO_DEVICE_ATTR(magn_z_raw, S_IRUGO, _show, NULL, _addr)
-- 
1.7.0.4
