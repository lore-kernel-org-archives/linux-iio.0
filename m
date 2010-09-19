Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: manuel.stahl@iis.fraunhofer.de,
	linux-iio@vger.kernel.org
Cc: drivers@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 07/10] staging:iio:adis16300 add _type attributes for all scan elements
Date: Sun, 19 Sep 2010 18:04:31 +0100
Message-Id: <1284915874-24911-8-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1284915874-24911-1-git-send-email-jic23@cam.ac.uk>
References: <1284915874-24911-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Note some of the in driver type specifications do not match the
data sheet.  I am assuming the datasheet is correct. This bug
would not have been apparent in the driver as these values were
unusued.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/imu/adis16300_ring.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16300_ring.c b/drivers/staging/iio/imu/adis16300_ring.c
index 0e09051..f805f9e 100644
--- a/drivers/staging/iio/imu/adis16300_ring.c
+++ b/drivers/staging/iio/imu/adis16300_ring.c
@@ -19,9 +19,11 @@
 
 static IIO_SCAN_EL_C(in_supply, ADIS16300_SCAN_SUPPLY, IIO_UNSIGNED(14),
 		     ADIS16300_SUPPLY_OUT, NULL);
+static IIO_CONST_ATTR(in_supply_type, "u12/16");
 
 static IIO_SCAN_EL_C(gyro_x, ADIS16300_SCAN_GYRO_X, IIO_SIGNED(14),
 		     ADIS16300_XGYRO_OUT, NULL);
+static IIO_CONST_ATTR(gyro_type, "s14/16");
 
 static IIO_SCAN_EL_C(accel_x, ADIS16300_SCAN_ACC_X, IIO_SIGNED(14),
 		     ADIS16300_XACCL_OUT, NULL);
@@ -29,30 +31,44 @@ static IIO_SCAN_EL_C(accel_y, ADIS16300_SCAN_ACC_Y, IIO_SIGNED(14),
 		     ADIS16300_YACCL_OUT, NULL);
 static IIO_SCAN_EL_C(accel_z, ADIS16300_SCAN_ACC_Z, IIO_SIGNED(14),
 		     ADIS16300_ZACCL_OUT, NULL);
+static IIO_CONST_ATTR(accel_type, "s14/16");
 
 static IIO_SCAN_EL_C(temp, ADIS16300_SCAN_TEMP, IIO_UNSIGNED(12),
 		     ADIS16300_TEMP_OUT, NULL);
+static IIO_CONST_ATTR(temp_type, "s12/16");
+
 static IIO_SCAN_EL_C(in0, ADIS16300_SCAN_ADC_0, IIO_UNSIGNED(12),
 		     ADIS16300_AUX_ADC, NULL);
+static IIO_CONST_ATTR(in0_type, "u12/16");
 
 static IIO_SCAN_EL_C(incli_x, ADIS16300_SCAN_INCLI_X, IIO_SIGNED(12),
 		     ADIS16300_XINCLI_OUT, NULL);
 static IIO_SCAN_EL_C(incli_y, ADIS16300_SCAN_INCLI_Y, IIO_SIGNED(12),
 		     ADIS16300_YINCLI_OUT, NULL);
+static IIO_CONST_ATTR(incli_type, "s13/16");
 
 static IIO_SCAN_EL_TIMESTAMP(9);
+static IIO_CONST_ATTR(timestamp_type, "s64/64");
+
 
 static struct attribute *adis16300_scan_el_attrs[] = {
 	&iio_scan_el_in_supply.dev_attr.attr,
+	&iio_const_attr_in_supply_type.dev_attr.attr,
 	&iio_scan_el_gyro_x.dev_attr.attr,
+	&iio_const_attr_gyro_type.dev_attr.attr,
 	&iio_scan_el_temp.dev_attr.attr,
+	&iio_const_attr_temp_type.dev_attr.attr,
 	&iio_scan_el_accel_x.dev_attr.attr,
 	&iio_scan_el_accel_y.dev_attr.attr,
 	&iio_scan_el_accel_z.dev_attr.attr,
+	&iio_const_attr_accel_type.dev_attr.attr,
 	&iio_scan_el_incli_x.dev_attr.attr,
 	&iio_scan_el_incli_y.dev_attr.attr,
+	&iio_const_attr_incli_type.dev_attr.attr,
 	&iio_scan_el_in0.dev_attr.attr,
+	&iio_const_attr_in0_type.dev_attr.attr,
 	&iio_scan_el_timestamp.dev_attr.attr,
+	&iio_const_attr_timestamp_type.dev_attr.attr,
 	NULL,
 };
 
-- 
1.7.2.2
