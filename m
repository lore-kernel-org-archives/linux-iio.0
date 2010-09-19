Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: manuel.stahl@iis.fraunhofer.de,
	linux-iio@vger.kernel.org
Cc: drivers@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 09/10] staging:iio:adis16400 add _type attributes for all scan elements
Date: Sun, 19 Sep 2010 18:04:33 +0100
Message-Id: <1284915874-24911-10-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1284915874-24911-1-git-send-email-jic23@cam.ac.uk>
References: <1284915874-24911-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

The bit depth of 14 for the supply adc on the datasheet is highly
suspicious.  Confirmation requested from Analog.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/imu/adis16400_ring.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index de5ef5c..05bf7fc 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -19,6 +19,7 @@
 
 static IIO_SCAN_EL_C(in_supply, ADIS16400_SCAN_SUPPLY, IIO_SIGNED(14),
 		     ADIS16400_SUPPLY_OUT, NULL);
+static IIO_CONST_ATTR(in_supply_type, "u14/16");
 
 static IIO_SCAN_EL_C(gyro_x, ADIS16400_SCAN_GYRO_X, IIO_SIGNED(14),
 		     ADIS16400_XGYRO_OUT, NULL);
@@ -26,6 +27,7 @@ static IIO_SCAN_EL_C(gyro_y, ADIS16400_SCAN_GYRO_Y, IIO_SIGNED(14),
 		     ADIS16400_YGYRO_OUT, NULL);
 static IIO_SCAN_EL_C(gyro_z, ADIS16400_SCAN_GYRO_Z, IIO_SIGNED(14),
 		     ADIS16400_ZGYRO_OUT, NULL);
+static IIO_CONST_ATTR(gyro_type, "s14/16");
 
 static IIO_SCAN_EL_C(accel_x, ADIS16400_SCAN_ACC_X, IIO_SIGNED(14),
 		     ADIS16400_XACCL_OUT, NULL);
@@ -33,6 +35,7 @@ static IIO_SCAN_EL_C(accel_y, ADIS16400_SCAN_ACC_Y, IIO_SIGNED(14),
 		     ADIS16400_YACCL_OUT, NULL);
 static IIO_SCAN_EL_C(accel_z, ADIS16400_SCAN_ACC_Z, IIO_SIGNED(14),
 		     ADIS16400_ZACCL_OUT, NULL);
+static IIO_CONST_ATTR(accel_type, "s14/16");
 
 static IIO_SCAN_EL_C(magn_x, ADIS16400_SCAN_MAGN_X, IIO_SIGNED(14),
 		     ADIS16400_XMAGN_OUT, NULL);
@@ -40,28 +43,40 @@ static IIO_SCAN_EL_C(magn_y, ADIS16400_SCAN_MAGN_Y, IIO_SIGNED(14),
 		     ADIS16400_YMAGN_OUT, NULL);
 static IIO_SCAN_EL_C(magn_z, ADIS16400_SCAN_MAGN_Z, IIO_SIGNED(14),
 		     ADIS16400_ZMAGN_OUT, NULL);
+static IIO_CONST_ATTR(magn_type, "s14/16");
 
 static IIO_SCAN_EL_C(temp, ADIS16400_SCAN_TEMP, IIO_SIGNED(12),
 		     ADIS16400_TEMP_OUT, NULL);
+static IIO_CONST_ATTR(temp_type, "s12/16");
+
 static IIO_SCAN_EL_C(in0, ADIS16400_SCAN_ADC_0, IIO_SIGNED(12),
 		     ADIS16400_AUX_ADC, NULL);
+static IIO_CONST_ATTR(in0_type, "u12/16");
 
 static IIO_SCAN_EL_TIMESTAMP(12);
+static IIO_CONST_ATTR(timestamp_type, "s64/64");
 
 static struct attribute *adis16400_scan_el_attrs[] = {
 	&iio_scan_el_in_supply.dev_attr.attr,
+	&iio_const_attr_in_supply_type.dev_attr.attr,
 	&iio_scan_el_gyro_x.dev_attr.attr,
 	&iio_scan_el_gyro_y.dev_attr.attr,
 	&iio_scan_el_gyro_z.dev_attr.attr,
+	&iio_const_attr_gyro_type.dev_attr.attr,
 	&iio_scan_el_accel_x.dev_attr.attr,
 	&iio_scan_el_accel_y.dev_attr.attr,
 	&iio_scan_el_accel_z.dev_attr.attr,
+	&iio_const_attr_accel_type.dev_attr.attr,
 	&iio_scan_el_magn_x.dev_attr.attr,
 	&iio_scan_el_magn_y.dev_attr.attr,
 	&iio_scan_el_magn_z.dev_attr.attr,
+	&iio_const_attr_magn_type.dev_attr.attr,
 	&iio_scan_el_temp.dev_attr.attr,
+	&iio_const_attr_temp_type.dev_attr.attr,
 	&iio_scan_el_in0.dev_attr.attr,
+	&iio_const_attr_in0_type.dev_attr.attr,
 	&iio_scan_el_timestamp.dev_attr.attr,
+	&iio_const_attr_timestamp_type.dev_attr.attr,
 	NULL,
 };
 
-- 
1.7.2.2
