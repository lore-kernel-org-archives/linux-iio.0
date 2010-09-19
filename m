Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: manuel.stahl@iis.fraunhofer.de,
	linux-iio@vger.kernel.org
Cc: drivers@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 04/10] staging:iio:adis16240 add _type attributes for all scan elements
Date: Sun, 19 Sep 2010 18:04:28 +0100
Message-Id: <1284915874-24911-5-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1284915874-24911-1-git-send-email-jic23@cam.ac.uk>
References: <1284915874-24911-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16240_ring.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
index 9282372..ac0560f 100644
--- a/drivers/staging/iio/accel/adis16240_ring.c
+++ b/drivers/staging/iio/accel/adis16240_ring.c
@@ -19,27 +19,37 @@
 
 static IIO_SCAN_EL_C(in_supply, ADIS16240_SCAN_SUPPLY, IIO_UNSIGNED(10),
 		ADIS16240_SUPPLY_OUT, NULL);
+static IIO_CONST_ATTR(in_supply_type, "u10/16");
 static IIO_SCAN_EL_C(accel_x, ADIS16240_SCAN_ACC_X, IIO_SIGNED(10),
 		ADIS16240_XACCL_OUT, NULL);
 static IIO_SCAN_EL_C(accel_y, ADIS16240_SCAN_ACC_Y, IIO_SIGNED(10),
 		ADIS16240_YACCL_OUT, NULL);
 static IIO_SCAN_EL_C(accel_z, ADIS16240_SCAN_ACC_Z, IIO_SIGNED(10),
 		ADIS16240_ZACCL_OUT, NULL);
+static IIO_CONST_ATTR(accel_type, "s10/16");
 static IIO_SCAN_EL_C(in0, ADIS16240_SCAN_AUX_ADC, IIO_UNSIGNED(10),
 		ADIS16240_AUX_ADC, NULL);
+static IIO_CONST_ATTR(in0_type, "u10/16");
 static IIO_SCAN_EL_C(temp, ADIS16240_SCAN_TEMP, IIO_UNSIGNED(10),
 		ADIS16240_TEMP_OUT, NULL);
+static IIO_CONST_ATTR(temp_type, "u10/16");
 
 static IIO_SCAN_EL_TIMESTAMP(6);
+static IIO_CONST_ATTR(timestamp_type, "s64/64");
 
 static struct attribute *adis16240_scan_el_attrs[] = {
 	&iio_scan_el_in_supply.dev_attr.attr,
+	&iio_const_attr_in_supply_type.dev_attr.attr,
 	&iio_scan_el_accel_x.dev_attr.attr,
 	&iio_scan_el_accel_y.dev_attr.attr,
 	&iio_scan_el_accel_z.dev_attr.attr,
+	&iio_const_attr_accel_type.dev_attr.attr,
 	&iio_scan_el_in0.dev_attr.attr,
+	&iio_const_attr_in0_type.dev_attr.attr,
 	&iio_scan_el_temp.dev_attr.attr,
+	&iio_const_attr_temp_type.dev_attr.attr,
 	&iio_scan_el_timestamp.dev_attr.attr,
+	&iio_const_attr_timestamp_type.dev_attr.attr,
 	NULL,
 };
 
-- 
1.7.2.2
