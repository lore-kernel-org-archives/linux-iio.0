Return-Path: <slm9ab33xy531iis.fraunhofer.de@bounce.antispameurope.com>
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
To: greg@kroah.com
Cc: jic23@cam.ac.uk, linux-iio@vger.kernel.org,
        Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Subject: [PATCH 6/6] staging:iio sync scale units
Date: Tue, 31 Aug 2010 11:32:55 +0200
Message-Id: <1283247175-12835-7-git-send-email-manuel.stahl@iis.fraunhofer.de>
In-Reply-To: <1283247175-12835-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
References: <1283247175-12835-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
List-ID: <linux-iio@vger.kernel.org>

g     -> ms/s^2
deg   -> rad
deg/s -> rad/s
some temperatures still broken

Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16209_core.c |    4 ++--
 drivers/staging/iio/accel/adis16220_core.c |    2 ++
 drivers/staging/iio/accel/adis16240_core.c |    5 +++++
 drivers/staging/iio/gyro/adis16260_core.c  |    2 ++
 drivers/staging/iio/imu/adis16300_core.c   |   10 +++++-----
 drivers/staging/iio/imu/adis16350_core.c   |    7 ++++---
 drivers/staging/iio/imu/adis16400_core.c   |    4 ++--
 7 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index bda497a..9ee523a 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -410,13 +410,13 @@ static IIO_DEV_ATTR_ACCEL_Y_CALIBBIAS(S_IWUSR | S_IRUGO,
 		adis16209_read_14bit_signed,
 		adis16209_write_16bit,
 		ADIS16209_YACCL_NULL);
-static IIO_CONST_ATTR(accel_scale, "0.24414");
+static IIO_CONST_ATTR_ACCEL_SCALE("0.002394195531");
 
 static IIO_DEV_ATTR_INCLI_X(adis16209_read_14bit_signed,
 		ADIS16209_XINCL_OUT);
 static IIO_DEV_ATTR_INCLI_Y(adis16209_read_14bit_signed,
 		ADIS16209_YINCL_OUT);
-static IIO_CONST_ATTR(incli_scale, "0.025");
+static IIO_CONST_ATTR(incli_scale, "0.00043633231");
 
 static IIO_DEVICE_ATTR(rot_raw, S_IRUGO, adis16209_read_14bit_signed,
 		       NULL, ADIS16209_ROT_OUT);
diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
index edcf57d..032616e 100644
--- a/drivers/staging/iio/accel/adis16220_core.c
+++ b/drivers/staging/iio/accel/adis16220_core.c
@@ -495,6 +495,7 @@ static IIO_DEV_ATTR_ACCEL_OFFSET(S_IWUSR | S_IRUGO,
 		adis16220_read_16bit,
 		adis16220_write_16bit,
 		ADIS16220_ACCL_NULL);
+static IIO_CONST_ATTR_ACCEL_SCALE("0.18704223545");
 static IIO_DEV_ATTR_TEMP_RAW(adis16220_read_12bit_unsigned);
 static IIO_CONST_ATTR_TEMP_OFFSET("25");
 static IIO_CONST_ATTR_TEMP_SCALE("-0.47");
@@ -528,6 +529,7 @@ static struct attribute *adis16220_attributes[] = {
 	&iio_dev_attr_accel_raw.dev_attr.attr,
 	&iio_dev_attr_accel_offset.dev_attr.attr,
 	&iio_dev_attr_accel_peak_raw.dev_attr.attr,
+	&iio_const_attr_accel_scale.dev_attr.attr,
 	&iio_dev_attr_temp_raw.dev_attr.attr,
 	&iio_dev_attr_in0_raw.dev_attr.attr,
 	&iio_dev_attr_in1_raw.dev_attr.attr,
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index 4583258..49e172a 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -381,6 +381,9 @@ static IIO_DEV_ATTR_IN_NAMED_RAW(supply, adis16240_read_10bit_unsigned,
 static IIO_DEV_ATTR_IN_RAW(0, adis16240_read_10bit_signed,
 		ADIS16240_AUX_ADC);
 static IIO_CONST_ATTR_IN_NAMED_SCALE(supply, "0.00488");
+
+static IIO_CONST_ATTR_ACCEL_SCALE("0.50406181");
+static IIO_CONST_ATTR(accel_peak_scale, "6.6292954");
 static IIO_DEV_ATTR_ACCEL_X(adis16240_read_10bit_signed,
 		ADIS16240_XACCL_OUT);
 static IIO_DEVICE_ATTR(accel_x_peak_raw, S_IRUGO,
@@ -433,6 +436,8 @@ static struct attribute *adis16240_attributes[] = {
 	&iio_dev_attr_in_supply_raw.dev_attr.attr,
 	&iio_const_attr_in_supply_scale.dev_attr.attr,
 	&iio_dev_attr_in0_raw.dev_attr.attr,
+	&iio_const_attr_accel_scale.dev_attr.attr,
+	&iio_const_attr_accel_peak_scale.dev_attr.attr,
 	&iio_dev_attr_accel_x_raw.dev_attr.attr,
 	&iio_dev_attr_accel_x_calibbias.dev_attr.attr,
 	&iio_dev_attr_accel_x_peak_raw.dev_attr.attr,
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index ac5378b..c1ad0c8 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -449,6 +449,7 @@ static IIO_CONST_ATTR_IN_NAMED_SCALE(supply, "0.0018315");
 
 static IIO_DEV_ATTR_GYRO(adis16260_read_14bit_signed,
 		ADIS16260_GYRO_OUT);
+static IIO_CONST_ATTR_GYRO_SCALE("0.00127862821");
 static IIO_DEV_ATTR_GYRO_CALIBSCALE(S_IWUSR | S_IRUGO,
 		adis16260_read_14bit_signed,
 		adis16260_write_16bit,
@@ -490,6 +491,7 @@ static struct attribute *adis16260_attributes[] = {
 	&iio_dev_attr_in_supply_raw.dev_attr.attr,
 	&iio_const_attr_in_supply_scale.dev_attr.attr,
 	&iio_dev_attr_gyro_raw.dev_attr.attr,
+	&iio_const_attr_gyro_scale.dev_attr.attr,
 	&iio_dev_attr_gyro_calibscale.dev_attr.attr,
 	&iio_dev_attr_gyro_calibbias.dev_attr.attr,
 	&iio_dev_attr_angl_raw.dev_attr.attr,
diff --git a/drivers/staging/iio/imu/adis16300_core.c b/drivers/staging/iio/imu/adis16300_core.c
index 168e8b3..3ed86cc 100644
--- a/drivers/staging/iio/imu/adis16300_core.c
+++ b/drivers/staging/iio/imu/adis16300_core.c
@@ -529,7 +529,7 @@ static IIO_CONST_ATTR_IN_NAMED_SCALE(supply, "0.00242");
 
 static IIO_DEV_ATTR_GYRO_X(adis16300_read_14bit_signed,
 		ADIS16300_XGYRO_OUT);
-static IIO_CONST_ATTR_GYRO_SCALE("0.05 deg/s");
+static IIO_CONST_ATTR_GYRO_SCALE("0.000872664");
 
 static IIO_DEV_ATTR_ACCEL_X(adis16300_read_14bit_signed,
 		ADIS16300_XACCL_OUT);
@@ -537,17 +537,17 @@ static IIO_DEV_ATTR_ACCEL_Y(adis16300_read_14bit_signed,
 		ADIS16300_YACCL_OUT);
 static IIO_DEV_ATTR_ACCEL_Z(adis16300_read_14bit_signed,
 		ADIS16300_ZACCL_OUT);
-static IIO_CONST_ATTR_ACCEL_SCALE("0.0006 g");
+static IIO_CONST_ATTR_ACCEL_SCALE("0.00588399");
 
 static IIO_DEV_ATTR_INCLI_X(adis16300_read_13bit_signed,
 		ADIS16300_XINCLI_OUT);
 static IIO_DEV_ATTR_INCLI_Y(adis16300_read_13bit_signed,
 		ADIS16300_YINCLI_OUT);
-static IIO_CONST_ATTR_INCLI_SCALE("0.044 deg");
+static IIO_CONST_ATTR_INCLI_SCALE("0.00076794487");
 
 static IIO_DEV_ATTR_TEMP_RAW(adis16300_read_12bit_unsigned);
-static IIO_CONST_ATTR_TEMP_OFFSET("198.16 K");
-static IIO_CONST_ATTR_TEMP_SCALE("0.14 K");
+static IIO_CONST_ATTR_TEMP_OFFSET("198.16");
+static IIO_CONST_ATTR_TEMP_SCALE("0.14");
 
 static IIO_DEV_ATTR_IN_RAW(0, adis16300_read_12bit_unsigned,
 		ADIS16300_AUX_ADC);
diff --git a/drivers/staging/iio/imu/adis16350_core.c b/drivers/staging/iio/imu/adis16350_core.c
index d1f1015..cc33843 100644
--- a/drivers/staging/iio/imu/adis16350_core.c
+++ b/drivers/staging/iio/imu/adis16350_core.c
@@ -515,7 +515,7 @@ static IIO_DEV_ATTR_GYRO_Y(adis16350_read_14bit_signed,
 		ADIS16350_YGYRO_OUT);
 static IIO_DEV_ATTR_GYRO_Z(adis16350_read_14bit_signed,
 		ADIS16350_ZGYRO_OUT);
-static IIO_CONST_ATTR_GYRO_SCALE("0.05");
+static IIO_CONST_ATTR_GYRO_SCALE("0.00127862821");
 
 static IIO_DEV_ATTR_ACCEL_X(adis16350_read_14bit_signed,
 		ADIS16350_XACCL_OUT);
@@ -523,7 +523,7 @@ static IIO_DEV_ATTR_ACCEL_Y(adis16350_read_14bit_signed,
 		ADIS16350_YACCL_OUT);
 static IIO_DEV_ATTR_ACCEL_Z(adis16350_read_14bit_signed,
 		ADIS16350_ZACCL_OUT);
-static IIO_CONST_ATTR_ACCEL_SCALE("0.00333");
+static IIO_CONST_ATTR_ACCEL_SCALE("0.0247323713");
 
 static IIO_DEVICE_ATTR(temp_x_raw, S_IRUGO, adis16350_read_12bit_signed,
 		NULL, ADIS16350_XTEMP_OUT);
@@ -531,7 +531,8 @@ static IIO_DEVICE_ATTR(temp_y_raw, S_IRUGO, adis16350_read_12bit_signed,
 		NULL, ADIS16350_YTEMP_OUT);
 static IIO_DEVICE_ATTR(temp_z_raw, S_IRUGO, adis16350_read_12bit_signed,
 		NULL, ADIS16350_ZTEMP_OUT);
-static IIO_CONST_ATTR_TEMP_SCALE("0.0005");
+static IIO_CONST_ATTR_TEMP_SCALE("0.14534");
+static IIO_CONST_ATTR_TEMP_OFFSET("198.16");
 
 static IIO_DEV_ATTR_IN_RAW(0, adis16350_read_12bit_unsigned,
 		ADIS16350_AUX_ADC);
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 1765fef..5f1643a 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -515,7 +515,7 @@ static IIO_DEV_ATTR_GYRO_Y(adis16400_read_14bit_signed,
 		ADIS16400_YGYRO_OUT);
 static IIO_DEV_ATTR_GYRO_Z(adis16400_read_14bit_signed,
 		ADIS16400_ZGYRO_OUT);
-static IIO_CONST_ATTR(gyro_scale, "0.05 deg/s");
+static IIO_CONST_ATTR(gyro_scale, "0.0008726646");
 
 static IIO_DEV_ATTR_ACCEL_X(adis16400_read_14bit_signed,
 		ADIS16400_XACCL_OUT);
@@ -523,7 +523,7 @@ static IIO_DEV_ATTR_ACCEL_Y(adis16400_read_14bit_signed,
 		ADIS16400_YACCL_OUT);
 static IIO_DEV_ATTR_ACCEL_Z(adis16400_read_14bit_signed,
 		ADIS16400_ZACCL_OUT);
-static IIO_CONST_ATTR(accel_scale, "0.00333 g");
+static IIO_CONST_ATTR(accel_scale, "0.0326561445");
 
 static IIO_DEV_ATTR_MAGN_X(adis16400_read_14bit_signed,
 		ADIS16400_XMAGN_OUT);
-- 
1.7.0.6
