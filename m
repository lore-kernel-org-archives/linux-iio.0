Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: manuel.stahl@iis.fraunhofer.de,
	linux-iio@vger.kernel.org
Cc: drivers@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 03/10] staging:iio:adis16209 add _type attributes for all scan elements
Date: Sun, 19 Sep 2010 18:04:27 +0100
Message-Id: <1284915874-24911-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1284915874-24911-1-git-send-email-jic23@cam.ac.uk>
References: <1284915874-24911-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16209_ring.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index 3eb1d55..a1b2058 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -19,33 +19,46 @@
 
 static IIO_SCAN_EL_C(in_supply, ADIS16209_SCAN_SUPPLY, IIO_UNSIGNED(14),
 		     ADIS16209_SUPPLY_OUT, NULL);
+static IIO_CONST_ATTR(in_supply_type, "u14/16");
 static IIO_SCAN_EL_C(accel_x, ADIS16209_SCAN_ACC_X, IIO_SIGNED(14),
 		     ADIS16209_XACCL_OUT, NULL);
 static IIO_SCAN_EL_C(accel_y, ADIS16209_SCAN_ACC_Y, IIO_SIGNED(14),
 		     ADIS16209_YACCL_OUT, NULL);
+static IIO_CONST_ATTR(accel_type, "s14/16");
 static IIO_SCAN_EL_C(in0, ADIS16209_SCAN_AUX_ADC, IIO_UNSIGNED(12),
 		     ADIS16209_AUX_ADC, NULL);
+static IIO_CONST_ATTR(in0_type, "u12/16");
 static IIO_SCAN_EL_C(temp, ADIS16209_SCAN_TEMP, IIO_UNSIGNED(12),
 		     ADIS16209_TEMP_OUT, NULL);
+static IIO_CONST_ATTR(temp_type, "u12/16");
 static IIO_SCAN_EL_C(incli_x, ADIS16209_SCAN_INCLI_X, IIO_SIGNED(14),
 		     ADIS16209_XINCL_OUT, NULL);
 static IIO_SCAN_EL_C(incli_y, ADIS16209_SCAN_INCLI_Y, IIO_SIGNED(14),
 		     ADIS16209_YINCL_OUT, NULL);
+static IIO_CONST_ATTR(incli_type, "s14/16");
 static IIO_SCAN_EL_C(rot, ADIS16209_SCAN_ROT, IIO_SIGNED(14),
 		     ADIS16209_ROT_OUT, NULL);
-
+static IIO_CONST_ATTR(rot_type, "s14/16");
 static IIO_SCAN_EL_TIMESTAMP(8);
+static IIO_CONST_ATTR(timestamp_type, "s64/64");
 
 static struct attribute *adis16209_scan_el_attrs[] = {
 	&iio_scan_el_in_supply.dev_attr.attr,
+	&iio_const_attr_in_supply_type.dev_attr.attr,
 	&iio_scan_el_accel_x.dev_attr.attr,
 	&iio_scan_el_accel_y.dev_attr.attr,
+	&iio_const_attr_accel_type.dev_attr.attr,
 	&iio_scan_el_in0.dev_attr.attr,
+	&iio_const_attr_in0_type.dev_attr.attr,
 	&iio_scan_el_temp.dev_attr.attr,
+	&iio_const_attr_temp_type.dev_attr.attr,
 	&iio_scan_el_incli_x.dev_attr.attr,
 	&iio_scan_el_incli_y.dev_attr.attr,
+	&iio_const_attr_incli_type.dev_attr.attr,
 	&iio_scan_el_rot.dev_attr.attr,
+	&iio_const_attr_rot_type.dev_attr.attr,
 	&iio_scan_el_timestamp.dev_attr.attr,
+	&iio_const_attr_timestamp_type.dev_attr.attr,
 	NULL,
 };
 
-- 
1.7.2.2
