Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: manuel.stahl@iis.fraunhofer.de,
	linux-iio@vger.kernel.org
Cc: drivers@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 10/22] staging:iio: Remove unused bit_count from struct iio_scan_el
Date: Mon, 20 Sep 2010 15:12:55 +0100
Message-Id: <1284991987-12407-11-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1284991987-12407-1-git-send-email-jic23@cam.ac.uk>
References: <1284991987-12407-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

The job this was intended to do (never implemented) is now done
by explicit definition of _type attributes in all drivers

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16209_ring.c |   21 ++++++----------
 drivers/staging/iio/accel/adis16240_ring.c |   18 ++++---------
 drivers/staging/iio/accel/lis3l02dq_ring.c |    6 ++--
 drivers/staging/iio/accel/sca3000_ring.c   |    6 ++--
 drivers/staging/iio/adc/max1363_core.c     |    7 ++---
 drivers/staging/iio/gyro/adis16260_ring.c  |   14 ++++-------
 drivers/staging/iio/imu/adis16300_ring.c   |   26 +++++++-------------
 drivers/staging/iio/imu/adis16350_ring.c   |   32 ++++++++----------------
 drivers/staging/iio/imu/adis16400_ring.c   |   35 +++++++++------------------
 drivers/staging/iio/ring_generic.h         |   17 ++++--------
 10 files changed, 66 insertions(+), 116 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index 6837f8b..8dd2881 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -17,27 +17,22 @@
 #include "../trigger.h"
 #include "adis16209.h"
 
-static IIO_SCAN_EL_C(in_supply, ADIS16209_SCAN_SUPPLY, IIO_UNSIGNED(14),
+static IIO_SCAN_EL_C(in_supply, ADIS16209_SCAN_SUPPLY,
 		     ADIS16209_SUPPLY_OUT, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(in_supply, u, 14, 16)
-static IIO_SCAN_EL_C(accel_x, ADIS16209_SCAN_ACC_X, IIO_SIGNED(14),
-		     ADIS16209_XACCL_OUT, NULL);
-static IIO_SCAN_EL_C(accel_y, ADIS16209_SCAN_ACC_Y, IIO_SIGNED(14),
-		     ADIS16209_YACCL_OUT, NULL);
+static IIO_SCAN_EL_C(accel_x, ADIS16209_SCAN_ACC_X, ADIS16209_XACCL_OUT, NULL);
+static IIO_SCAN_EL_C(accel_y, ADIS16209_SCAN_ACC_Y, ADIS16209_YACCL_OUT, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(accel, s, 14, 16);
-static IIO_SCAN_EL_C(in0, ADIS16209_SCAN_AUX_ADC, IIO_UNSIGNED(12),
-		     ADIS16209_AUX_ADC, NULL);
+static IIO_SCAN_EL_C(in0, ADIS16209_SCAN_AUX_ADC, ADIS16209_AUX_ADC, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(in0, u, 12, 16);
-static IIO_SCAN_EL_C(temp, ADIS16209_SCAN_TEMP, IIO_UNSIGNED(12),
-		     ADIS16209_TEMP_OUT, NULL);
+static IIO_SCAN_EL_C(temp, ADIS16209_SCAN_TEMP, ADIS16209_TEMP_OUT, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(temp, u, 12, 16);
-static IIO_SCAN_EL_C(incli_x, ADIS16209_SCAN_INCLI_X, IIO_SIGNED(14),
+static IIO_SCAN_EL_C(incli_x, ADIS16209_SCAN_INCLI_X,
 		     ADIS16209_XINCL_OUT, NULL);
-static IIO_SCAN_EL_C(incli_y, ADIS16209_SCAN_INCLI_Y, IIO_SIGNED(14),
+static IIO_SCAN_EL_C(incli_y, ADIS16209_SCAN_INCLI_Y,
 		     ADIS16209_YINCL_OUT, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(incli, s, 14, 16);
-static IIO_SCAN_EL_C(rot, ADIS16209_SCAN_ROT, IIO_SIGNED(14),
-		     ADIS16209_ROT_OUT, NULL);
+static IIO_SCAN_EL_C(rot, ADIS16209_SCAN_ROT, ADIS16209_ROT_OUT, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(rot, s, 14, 16);
 static IIO_SCAN_EL_TIMESTAMP(8);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(timestamp, s, 64, 64);
diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
index b858d30..ae02268 100644
--- a/drivers/staging/iio/accel/adis16240_ring.c
+++ b/drivers/staging/iio/accel/adis16240_ring.c
@@ -17,23 +17,17 @@
 #include "../trigger.h"
 #include "adis16240.h"
 
-static IIO_SCAN_EL_C(in_supply, ADIS16240_SCAN_SUPPLY, IIO_UNSIGNED(10),
+static IIO_SCAN_EL_C(in_supply, ADIS16240_SCAN_SUPPLY,
 		ADIS16240_SUPPLY_OUT, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(in_supply, u, 10, 16);
-static IIO_SCAN_EL_C(accel_x, ADIS16240_SCAN_ACC_X, IIO_SIGNED(10),
-		ADIS16240_XACCL_OUT, NULL);
-static IIO_SCAN_EL_C(accel_y, ADIS16240_SCAN_ACC_Y, IIO_SIGNED(10),
-		ADIS16240_YACCL_OUT, NULL);
-static IIO_SCAN_EL_C(accel_z, ADIS16240_SCAN_ACC_Z, IIO_SIGNED(10),
-		ADIS16240_ZACCL_OUT, NULL);
+static IIO_SCAN_EL_C(accel_x, ADIS16240_SCAN_ACC_X, ADIS16240_XACCL_OUT, NULL);
+static IIO_SCAN_EL_C(accel_y, ADIS16240_SCAN_ACC_Y, ADIS16240_YACCL_OUT, NULL);
+static IIO_SCAN_EL_C(accel_z, ADIS16240_SCAN_ACC_Z, ADIS16240_ZACCL_OUT, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(accel, s, 10, 16);
-static IIO_SCAN_EL_C(in0, ADIS16240_SCAN_AUX_ADC, IIO_UNSIGNED(10),
-		ADIS16240_AUX_ADC, NULL);
+static IIO_SCAN_EL_C(in0, ADIS16240_SCAN_AUX_ADC, ADIS16240_AUX_ADC, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(in0, u, 10, 16);
-static IIO_SCAN_EL_C(temp, ADIS16240_SCAN_TEMP, IIO_UNSIGNED(10),
-		ADIS16240_TEMP_OUT, NULL);
+static IIO_SCAN_EL_C(temp, ADIS16240_SCAN_TEMP, ADIS16240_TEMP_OUT, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(temp, u, 10, 16);
-
 static IIO_SCAN_EL_TIMESTAMP(6);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(timestamp, s, 64, 64);
 
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 28a54f1..40cf670 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -75,13 +75,13 @@ error_ret:
 	return ret;
 
 }
-static IIO_SCAN_EL_C(accel_x, 0, IIO_SIGNED(16),
+static IIO_SCAN_EL_C(accel_x, 0,
 		     LIS3L02DQ_REG_OUT_X_L_ADDR,
 		     &lis3l02dq_scan_el_set_state);
-static IIO_SCAN_EL_C(accel_y, 1, IIO_SIGNED(16),
+static IIO_SCAN_EL_C(accel_y, 1,
 		     LIS3L02DQ_REG_OUT_Y_L_ADDR,
 		     &lis3l02dq_scan_el_set_state);
-static IIO_SCAN_EL_C(accel_z, 2, IIO_SIGNED(16),
+static IIO_SCAN_EL_C(accel_z, 2,
 		     LIS3L02DQ_REG_OUT_Z_L_ADDR,
 		     &lis3l02dq_scan_el_set_state);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(accel, s, 12, 16);
diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
index 15b91e1..003097d 100644
--- a/drivers/staging/iio/accel/sca3000_ring.c
+++ b/drivers/staging/iio/accel/sca3000_ring.c
@@ -194,9 +194,9 @@ error_ret:
 	return ret ? ret : len;
 }
 
-static IIO_SCAN_EL_C(accel_x, 0, 0, 0, NULL);
-static IIO_SCAN_EL_C(accel_y, 1, 0, 0, NULL);
-static IIO_SCAN_EL_C(accel_z, 2, 0, 0, NULL);
+static IIO_SCAN_EL_C(accel_x, 0, 0, NULL);
+static IIO_SCAN_EL_C(accel_y, 1, 0, NULL);
+static IIO_SCAN_EL_C(accel_z, 2, 0, NULL);
 static IIO_CONST_ATTR(accel_type_available, "s8/8 s11/16");
 static IIO_DEVICE_ATTR(accel_type,
 		       S_IRUGO | S_IWUSR,
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 40039e6..d59a8d2 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -42,11 +42,10 @@
 /* Here we claim all are 16 bits. This currently does no harm and saves
  * us a lot of scan element listings */
 
-#define MAX1363_SCAN_EL(number)						\
-	IIO_SCAN_EL_C(in##number, number, IIO_UNSIGNED(16), 0, NULL);
+#define MAX1363_SCAN_EL(number)				\
+	IIO_SCAN_EL_C(in##number, number, 0, NULL);
 #define MAX1363_SCAN_EL_D(p, n, number)					\
-	IIO_SCAN_NAMED_EL_C(in##p##m##in##n, in##p-in##n,		\
-			number, IIO_SIGNED(16), 0, NULL);
+	IIO_SCAN_NAMED_EL_C(in##p##m##in##n, in##p-in##n, number, 0, NULL);
 
 static MAX1363_SCAN_EL(0);
 static MAX1363_SCAN_EL(1);
diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
index 4b96394..77dca37 100644
--- a/drivers/staging/iio/gyro/adis16260_ring.c
+++ b/drivers/staging/iio/gyro/adis16260_ring.c
@@ -17,20 +17,16 @@
 #include "../trigger.h"
 #include "adis16260.h"
 
-static IIO_SCAN_EL_C(in_supply, ADIS16260_SCAN_SUPPLY, IIO_UNSIGNED(12),
+static IIO_SCAN_EL_C(in_supply, ADIS16260_SCAN_SUPPLY,
 		ADIS16260_SUPPLY_OUT, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(in_supply, u, 12, 16);
-static IIO_SCAN_EL_C(gyro, ADIS16260_SCAN_GYRO, IIO_SIGNED(14),
-		ADIS16260_GYRO_OUT, NULL);
+static IIO_SCAN_EL_C(gyro, ADIS16260_SCAN_GYRO, ADIS16260_GYRO_OUT, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(gyro, s, 14, 16);
-static IIO_SCAN_EL_C(in0, ADIS16260_SCAN_AUX_ADC, IIO_SIGNED(14),
-		ADIS16260_AUX_ADC, NULL);
+static IIO_SCAN_EL_C(in0, ADIS16260_SCAN_AUX_ADC, ADIS16260_AUX_ADC, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(in0, u, 12, 16);
-static IIO_SCAN_EL_C(temp, ADIS16260_SCAN_TEMP, IIO_UNSIGNED(12),
-		ADIS16260_TEMP_OUT, NULL);
+static IIO_SCAN_EL_C(temp, ADIS16260_SCAN_TEMP, ADIS16260_TEMP_OUT, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(temp, u, 12, 16);
-static IIO_SCAN_EL_C(angl, ADIS16260_SCAN_ANGL, IIO_UNSIGNED(12),
-		ADIS16260_ANGL_OUT, NULL);
+static IIO_SCAN_EL_C(angl, ADIS16260_SCAN_ANGL, ADIS16260_ANGL_OUT, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(angl, u, 14, 16);
 static IIO_SCAN_EL_TIMESTAMP(5);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(timestamp, s, 64, 64);
diff --git a/drivers/staging/iio/imu/adis16300_ring.c b/drivers/staging/iio/imu/adis16300_ring.c
index 3f67858..b3a1e75 100644
--- a/drivers/staging/iio/imu/adis16300_ring.c
+++ b/drivers/staging/iio/imu/adis16300_ring.c
@@ -17,40 +17,32 @@
 #include "../trigger.h"
 #include "adis16300.h"
 
-static IIO_SCAN_EL_C(in_supply, ADIS16300_SCAN_SUPPLY, IIO_UNSIGNED(14),
+static IIO_SCAN_EL_C(in_supply, ADIS16300_SCAN_SUPPLY,
 		     ADIS16300_SUPPLY_OUT, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(in_supply, u, 12, 16);
-
-static IIO_SCAN_EL_C(gyro_x, ADIS16300_SCAN_GYRO_X, IIO_SIGNED(14),
-		     ADIS16300_XGYRO_OUT, NULL);
+static IIO_SCAN_EL_C(gyro_x, ADIS16300_SCAN_GYRO_X, ADIS16300_XGYRO_OUT, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(gyro, s, 14, 16);
 
-static IIO_SCAN_EL_C(accel_x, ADIS16300_SCAN_ACC_X, IIO_SIGNED(14),
-		     ADIS16300_XACCL_OUT, NULL);
-static IIO_SCAN_EL_C(accel_y, ADIS16300_SCAN_ACC_Y, IIO_SIGNED(14),
-		     ADIS16300_YACCL_OUT, NULL);
-static IIO_SCAN_EL_C(accel_z, ADIS16300_SCAN_ACC_Z, IIO_SIGNED(14),
-		     ADIS16300_ZACCL_OUT, NULL);
+static IIO_SCAN_EL_C(accel_x, ADIS16300_SCAN_ACC_X, ADIS16300_XACCL_OUT, NULL);
+static IIO_SCAN_EL_C(accel_y, ADIS16300_SCAN_ACC_Y, ADIS16300_YACCL_OUT, NULL);
+static IIO_SCAN_EL_C(accel_z, ADIS16300_SCAN_ACC_Z, ADIS16300_ZACCL_OUT, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(accel, s, 14, 16);
 
-static IIO_SCAN_EL_C(temp, ADIS16300_SCAN_TEMP, IIO_UNSIGNED(12),
-		     ADIS16300_TEMP_OUT, NULL);
+static IIO_SCAN_EL_C(temp, ADIS16300_SCAN_TEMP, ADIS16300_TEMP_OUT, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(temp, s, 12, 16);
 
-static IIO_SCAN_EL_C(in0, ADIS16300_SCAN_ADC_0, IIO_UNSIGNED(12),
-		     ADIS16300_AUX_ADC, NULL);
+static IIO_SCAN_EL_C(in0, ADIS16300_SCAN_ADC_0, ADIS16300_AUX_ADC, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(in0, u, 12, 16);
 
-static IIO_SCAN_EL_C(incli_x, ADIS16300_SCAN_INCLI_X, IIO_SIGNED(12),
+static IIO_SCAN_EL_C(incli_x, ADIS16300_SCAN_INCLI_X,
 		     ADIS16300_XINCLI_OUT, NULL);
-static IIO_SCAN_EL_C(incli_y, ADIS16300_SCAN_INCLI_Y, IIO_SIGNED(12),
+static IIO_SCAN_EL_C(incli_y, ADIS16300_SCAN_INCLI_Y,
 		     ADIS16300_YINCLI_OUT, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(incli, s, 13, 16);
 
 static IIO_SCAN_EL_TIMESTAMP(9);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(timestamp, s, 64, 64);
 
-
 static struct attribute *adis16300_scan_el_attrs[] = {
 	&iio_scan_el_in_supply.dev_attr.attr,
 	&iio_const_attr_in_supply_type.dev_attr.attr,
diff --git a/drivers/staging/iio/imu/adis16350_ring.c b/drivers/staging/iio/imu/adis16350_ring.c
index ccd6c95..60331bf 100644
--- a/drivers/staging/iio/imu/adis16350_ring.c
+++ b/drivers/staging/iio/imu/adis16350_ring.c
@@ -17,36 +17,26 @@
 #include "../trigger.h"
 #include "adis16350.h"
 
-static IIO_SCAN_EL_C(in_supply, ADIS16350_SCAN_SUPPLY, IIO_UNSIGNED(12),
+static IIO_SCAN_EL_C(in_supply, ADIS16350_SCAN_SUPPLY,
 		ADIS16350_SUPPLY_OUT, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(in_supply, u, 12, 16);
 
-static IIO_SCAN_EL_C(gyro_x, ADIS16350_SCAN_GYRO_X, IIO_SIGNED(14),
-		ADIS16350_XGYRO_OUT, NULL);
-static IIO_SCAN_EL_C(gyro_y, ADIS16350_SCAN_GYRO_Y, IIO_SIGNED(14),
-		ADIS16350_YGYRO_OUT, NULL);
-static IIO_SCAN_EL_C(gyro_z, ADIS16350_SCAN_GYRO_Z, IIO_SIGNED(14),
-		ADIS16350_ZGYRO_OUT, NULL);
+static IIO_SCAN_EL_C(gyro_x, ADIS16350_SCAN_GYRO_X, ADIS16350_XGYRO_OUT, NULL);
+static IIO_SCAN_EL_C(gyro_y, ADIS16350_SCAN_GYRO_Y, ADIS16350_YGYRO_OUT, NULL);
+static IIO_SCAN_EL_C(gyro_z, ADIS16350_SCAN_GYRO_Z, ADIS16350_ZGYRO_OUT, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(gyro, s, 14, 16);
 
-static IIO_SCAN_EL_C(accel_x, ADIS16350_SCAN_ACC_X, IIO_SIGNED(14),
-		ADIS16350_XACCL_OUT, NULL);
-static IIO_SCAN_EL_C(accel_y, ADIS16350_SCAN_ACC_Y, IIO_SIGNED(14),
-		ADIS16350_YACCL_OUT, NULL);
-static IIO_SCAN_EL_C(accel_z, ADIS16350_SCAN_ACC_Z, IIO_SIGNED(14),
-		ADIS16350_ZACCL_OUT, NULL);
+static IIO_SCAN_EL_C(accel_x, ADIS16350_SCAN_ACC_X, ADIS16350_XACCL_OUT, NULL);
+static IIO_SCAN_EL_C(accel_y, ADIS16350_SCAN_ACC_Y, ADIS16350_YACCL_OUT, NULL);
+static IIO_SCAN_EL_C(accel_z, ADIS16350_SCAN_ACC_Z, ADIS16350_ZACCL_OUT, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(accel, s, 14, 16);
 
-static IIO_SCAN_EL_C(temp_x, ADIS16350_SCAN_TEMP_X, IIO_SIGNED(12),
-		ADIS16350_XTEMP_OUT, NULL);
-static IIO_SCAN_EL_C(temp_y, ADIS16350_SCAN_TEMP_Y, IIO_SIGNED(12),
-		ADIS16350_YTEMP_OUT, NULL);
-static IIO_SCAN_EL_C(temp_z, ADIS16350_SCAN_TEMP_Z, IIO_SIGNED(12),
-		ADIS16350_ZTEMP_OUT, NULL);
+static IIO_SCAN_EL_C(temp_x, ADIS16350_SCAN_TEMP_X, ADIS16350_XTEMP_OUT, NULL);
+static IIO_SCAN_EL_C(temp_y, ADIS16350_SCAN_TEMP_Y, ADIS16350_YTEMP_OUT, NULL);
+static IIO_SCAN_EL_C(temp_z, ADIS16350_SCAN_TEMP_Z, ADIS16350_ZTEMP_OUT, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(temp, s, 12, 16);
 
-static IIO_SCAN_EL_C(in0, ADIS16350_SCAN_ADC_0, IIO_UNSIGNED(12),
-		ADIS16350_AUX_ADC, NULL);
+static IIO_SCAN_EL_C(in0, ADIS16350_SCAN_ADC_0, ADIS16350_AUX_ADC, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(in0, u, 12, 16);
 
 static IIO_SCAN_EL_TIMESTAMP(11);
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index 5a8219b..42703da 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -17,40 +17,29 @@
 #include "../trigger.h"
 #include "adis16400.h"
 
-static IIO_SCAN_EL_C(in_supply, ADIS16400_SCAN_SUPPLY, IIO_SIGNED(14),
+static IIO_SCAN_EL_C(in_supply, ADIS16400_SCAN_SUPPLY,
 		     ADIS16400_SUPPLY_OUT, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(in_supply, u, 14, 16);
 
-static IIO_SCAN_EL_C(gyro_x, ADIS16400_SCAN_GYRO_X, IIO_SIGNED(14),
-		     ADIS16400_XGYRO_OUT, NULL);
-static IIO_SCAN_EL_C(gyro_y, ADIS16400_SCAN_GYRO_Y, IIO_SIGNED(14),
-		     ADIS16400_YGYRO_OUT, NULL);
-static IIO_SCAN_EL_C(gyro_z, ADIS16400_SCAN_GYRO_Z, IIO_SIGNED(14),
-		     ADIS16400_ZGYRO_OUT, NULL);
+static IIO_SCAN_EL_C(gyro_x, ADIS16400_SCAN_GYRO_X, ADIS16400_XGYRO_OUT, NULL);
+static IIO_SCAN_EL_C(gyro_y, ADIS16400_SCAN_GYRO_Y, ADIS16400_YGYRO_OUT, NULL);
+static IIO_SCAN_EL_C(gyro_z, ADIS16400_SCAN_GYRO_Z, ADIS16400_ZGYRO_OUT, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(gyro, s, 14, 16);
 
-static IIO_SCAN_EL_C(accel_x, ADIS16400_SCAN_ACC_X, IIO_SIGNED(14),
-		     ADIS16400_XACCL_OUT, NULL);
-static IIO_SCAN_EL_C(accel_y, ADIS16400_SCAN_ACC_Y, IIO_SIGNED(14),
-		     ADIS16400_YACCL_OUT, NULL);
-static IIO_SCAN_EL_C(accel_z, ADIS16400_SCAN_ACC_Z, IIO_SIGNED(14),
-		     ADIS16400_ZACCL_OUT, NULL);
+static IIO_SCAN_EL_C(accel_x, ADIS16400_SCAN_ACC_X, ADIS16400_XACCL_OUT, NULL);
+static IIO_SCAN_EL_C(accel_y, ADIS16400_SCAN_ACC_Y, ADIS16400_YACCL_OUT, NULL);
+static IIO_SCAN_EL_C(accel_z, ADIS16400_SCAN_ACC_Z, ADIS16400_ZACCL_OUT, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(accel, s, 14, 16);
 
-static IIO_SCAN_EL_C(magn_x, ADIS16400_SCAN_MAGN_X, IIO_SIGNED(14),
-		     ADIS16400_XMAGN_OUT, NULL);
-static IIO_SCAN_EL_C(magn_y, ADIS16400_SCAN_MAGN_Y, IIO_SIGNED(14),
-		     ADIS16400_YMAGN_OUT, NULL);
-static IIO_SCAN_EL_C(magn_z, ADIS16400_SCAN_MAGN_Z, IIO_SIGNED(14),
-		     ADIS16400_ZMAGN_OUT, NULL);
+static IIO_SCAN_EL_C(magn_x, ADIS16400_SCAN_MAGN_X, ADIS16400_XMAGN_OUT, NULL);
+static IIO_SCAN_EL_C(magn_y, ADIS16400_SCAN_MAGN_Y, ADIS16400_YMAGN_OUT, NULL);
+static IIO_SCAN_EL_C(magn_z, ADIS16400_SCAN_MAGN_Z, ADIS16400_ZMAGN_OUT, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(magn, s, 14, 16);
 
-static IIO_SCAN_EL_C(temp, ADIS16400_SCAN_TEMP, IIO_SIGNED(12),
-		     ADIS16400_TEMP_OUT, NULL);
+static IIO_SCAN_EL_C(temp, ADIS16400_SCAN_TEMP, ADIS16400_TEMP_OUT, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(temp, s, 12, 16);
 
-static IIO_SCAN_EL_C(in0, ADIS16400_SCAN_ADC_0, IIO_SIGNED(12),
-		     ADIS16400_AUX_ADC, NULL);
+static IIO_SCAN_EL_C(in0, ADIS16400_SCAN_ADC_0, ADIS16400_AUX_ADC, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(in0, u, 12, 16);
 
 static IIO_SCAN_EL_TIMESTAMP(12);
diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio/ring_generic.h
index 692b967..6be399a 100644
--- a/drivers/staging/iio/ring_generic.h
+++ b/drivers/staging/iio/ring_generic.h
@@ -168,7 +168,6 @@ static inline void __iio_update_ring_buffer(struct iio_ring_buffer *ring,
  * struct iio_scan_el - an individual element of a scan
  * @dev_attr:		control attribute (if directly controllable)
  * @number:		unique identifier of element (used for bit mask)
- * @bit_count:		number of bits in scan element
  * @label:		useful data for the scan el (often reg address)
  * @set_state:		for some devices datardy signals are generated
  *			for any enabled lines.  This allows unwanted lines
@@ -177,7 +176,6 @@ static inline void __iio_update_ring_buffer(struct iio_ring_buffer *ring,
 struct iio_scan_el {
 	struct device_attribute		dev_attr;
 	unsigned int			number;
-	int				bit_count;
 	unsigned int			label;
 
 	int (*set_state)(struct iio_scan_el *scanel,
@@ -232,39 +230,36 @@ ssize_t iio_scan_el_ts_show(struct device *dev, struct device_attribute *attr,
  * @_name:	identifying name. Resulting struct is iio_scan_el_##_name,
  *		sysfs element, _name##_en.
  * @_number:	unique id number for the scan element.
- * @_bits:	number of bits in the scan element result (used in mixed bit
  *		length devices).
  * @_label:	indentification variable used by drivers.  Often a reg address.
  * @_controlfunc: function used to notify hardware of whether state changes
  **/
-#define __IIO_SCAN_EL_C(_name, _number, _bits, _label, _controlfunc)	\
+#define __IIO_SCAN_EL_C(_name, _number, _label, _controlfunc)	\
 	struct iio_scan_el iio_scan_el_##_name = {			\
 		.dev_attr = __ATTR(_number##_##_name##_en,		\
 				   S_IRUGO | S_IWUSR,			\
 				   iio_scan_el_show,			\
 				   iio_scan_el_store),			\
 		.number =  _number,					\
-		.bit_count = _bits,					\
 		.label = _label,					\
 		.set_state = _controlfunc,				\
 	}	  
 
-#define IIO_SCAN_EL_C(_name, _number, _bits, _label, _controlfunc)	\
-	__IIO_SCAN_EL_C(_name, _number, _bits, _label, _controlfunc)
+#define IIO_SCAN_EL_C(_name, _number, _label, _controlfunc)	\
+	__IIO_SCAN_EL_C(_name, _number, _label, _controlfunc)
 
-#define __IIO_SCAN_NAMED_EL_C(_name, _string, _number, _bits, _label, _cf) \
+#define __IIO_SCAN_NAMED_EL_C(_name, _string, _number, _label, _cf) \
 	struct iio_scan_el iio_scan_el_##_name = {			\
 		.dev_attr = __ATTR(_number##_##_string##_en,		\
 				   S_IRUGO | S_IWUSR,			\
 				   iio_scan_el_show,			\
 				   iio_scan_el_store),			\
 		.number =  _number,					\
-		.bit_count = _bits,					\
 		.label = _label,					\
 		.set_state = _cf,					\
 	}
-#define IIO_SCAN_NAMED_EL_C(_name, _string, _number, _bits, _label, _cf) \
-	__IIO_SCAN_NAMED_EL_C(_name, _string, _number, _bits, _label, _cf)
+#define IIO_SCAN_NAMED_EL_C(_name, _string, _number, _label, _cf) \
+	__IIO_SCAN_NAMED_EL_C(_name, _string, _number, _label, _cf)
 /**
  * IIO_SCAN_EL_TIMESTAMP - declare a special scan element for timestamps
  * @number: specify where in the scan order this is stored.
-- 
1.7.2.2
