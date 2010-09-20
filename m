Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-33.csi.cam.ac.uk ([131.111.8.133]:49437 "EHLO
	ppsw-33.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756492Ab0ITOHz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 20 Sep 2010 10:07:55 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: manuel.stahl@iis.fraunhofer.de, linux-iio@vger.kernel.org
Cc: drivers@analog.com, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 08/22] staging:iio:adis16350 add _type attributes for all scan elements
Date: Mon, 20 Sep 2010 15:12:53 +0100
Message-Id: <1284991987-12407-9-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1284991987-12407-1-git-send-email-jic23@cam.ac.uk>
References: <1284991987-12407-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/imu/adis16350_ring.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16350_ring.c b/drivers/staging/iio/imu/adis16350_ring.c
index aefbae5..ccd6c95 100644
--- a/drivers/staging/iio/imu/adis16350_ring.c
+++ b/drivers/staging/iio/imu/adis16350_ring.c
@@ -19,6 +19,7 @@
 
 static IIO_SCAN_EL_C(in_supply, ADIS16350_SCAN_SUPPLY, IIO_UNSIGNED(12),
 		ADIS16350_SUPPLY_OUT, NULL);
+static IIO_CONST_ATTR_SCAN_EL_TYPE(in_supply, u, 12, 16);
 
 static IIO_SCAN_EL_C(gyro_x, ADIS16350_SCAN_GYRO_X, IIO_SIGNED(14),
 		ADIS16350_XGYRO_OUT, NULL);
@@ -26,6 +27,7 @@ static IIO_SCAN_EL_C(gyro_y, ADIS16350_SCAN_GYRO_Y, IIO_SIGNED(14),
 		ADIS16350_YGYRO_OUT, NULL);
 static IIO_SCAN_EL_C(gyro_z, ADIS16350_SCAN_GYRO_Z, IIO_SIGNED(14),
 		ADIS16350_ZGYRO_OUT, NULL);
+static IIO_CONST_ATTR_SCAN_EL_TYPE(gyro, s, 14, 16);
 
 static IIO_SCAN_EL_C(accel_x, ADIS16350_SCAN_ACC_X, IIO_SIGNED(14),
 		ADIS16350_XACCL_OUT, NULL);
@@ -33,6 +35,7 @@ static IIO_SCAN_EL_C(accel_y, ADIS16350_SCAN_ACC_Y, IIO_SIGNED(14),
 		ADIS16350_YACCL_OUT, NULL);
 static IIO_SCAN_EL_C(accel_z, ADIS16350_SCAN_ACC_Z, IIO_SIGNED(14),
 		ADIS16350_ZACCL_OUT, NULL);
+static IIO_CONST_ATTR_SCAN_EL_TYPE(accel, s, 14, 16);
 
 static IIO_SCAN_EL_C(temp_x, ADIS16350_SCAN_TEMP_X, IIO_SIGNED(12),
 		ADIS16350_XTEMP_OUT, NULL);
@@ -40,25 +43,34 @@ static IIO_SCAN_EL_C(temp_y, ADIS16350_SCAN_TEMP_Y, IIO_SIGNED(12),
 		ADIS16350_YTEMP_OUT, NULL);
 static IIO_SCAN_EL_C(temp_z, ADIS16350_SCAN_TEMP_Z, IIO_SIGNED(12),
 		ADIS16350_ZTEMP_OUT, NULL);
+static IIO_CONST_ATTR_SCAN_EL_TYPE(temp, s, 12, 16);
 
 static IIO_SCAN_EL_C(in0, ADIS16350_SCAN_ADC_0, IIO_UNSIGNED(12),
 		ADIS16350_AUX_ADC, NULL);
+static IIO_CONST_ATTR_SCAN_EL_TYPE(in0, u, 12, 16);
 
 static IIO_SCAN_EL_TIMESTAMP(11);
+static IIO_CONST_ATTR_SCAN_EL_TYPE(timestamp, s, 64, 64);
 
 static struct attribute *adis16350_scan_el_attrs[] = {
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
 	&iio_scan_el_temp_x.dev_attr.attr,
 	&iio_scan_el_temp_y.dev_attr.attr,
 	&iio_scan_el_temp_z.dev_attr.attr,
+	&iio_const_attr_temp_type.dev_attr.attr,
 	&iio_scan_el_in0.dev_attr.attr,
+	&iio_const_attr_in0_type.dev_attr.attr,
 	&iio_scan_el_timestamp.dev_attr.attr,
+	&iio_const_attr_timestamp_type.dev_attr.attr,
 	NULL,
 };
 
-- 
1.7.2.2

