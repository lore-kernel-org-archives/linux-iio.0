Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: manuel.stahl@iis.fraunhofer.de,
	linux-iio@vger.kernel.org
Cc: drivers@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 17/22] staging:iio:adis16350 add _index attribute registration
Date: Mon, 20 Sep 2010 15:13:02 +0100
Message-Id: <1284991987-12407-18-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1284991987-12407-1-git-send-email-jic23@cam.ac.uk>
References: <1284991987-12407-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/imu/adis16350_ring.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16350_ring.c b/drivers/staging/iio/imu/adis16350_ring.c
index 60331bf..b2c8f43 100644
--- a/drivers/staging/iio/imu/adis16350_ring.c
+++ b/drivers/staging/iio/imu/adis16350_ring.c
@@ -44,22 +44,34 @@ static IIO_CONST_ATTR_SCAN_EL_TYPE(timestamp, s, 64, 64);
 
 static struct attribute *adis16350_scan_el_attrs[] = {
 	&iio_scan_el_in_supply.dev_attr.attr,
+	&iio_const_attr_in_supply_index.dev_attr.attr,
 	&iio_const_attr_in_supply_type.dev_attr.attr,
 	&iio_scan_el_gyro_x.dev_attr.attr,
+	&iio_const_attr_gyro_x_index.dev_attr.attr,
 	&iio_scan_el_gyro_y.dev_attr.attr,
+	&iio_const_attr_gyro_y_index.dev_attr.attr,
 	&iio_scan_el_gyro_z.dev_attr.attr,
+	&iio_const_attr_gyro_z_index.dev_attr.attr,
 	&iio_const_attr_gyro_type.dev_attr.attr,
 	&iio_scan_el_accel_x.dev_attr.attr,
+	&iio_const_attr_accel_x_index.dev_attr.attr,
 	&iio_scan_el_accel_y.dev_attr.attr,
+	&iio_const_attr_accel_y_index.dev_attr.attr,
 	&iio_scan_el_accel_z.dev_attr.attr,
+	&iio_const_attr_accel_z_index.dev_attr.attr,
 	&iio_const_attr_accel_type.dev_attr.attr,
 	&iio_scan_el_temp_x.dev_attr.attr,
+	&iio_const_attr_temp_x_index.dev_attr.attr,
 	&iio_scan_el_temp_y.dev_attr.attr,
+	&iio_const_attr_temp_y_index.dev_attr.attr,
 	&iio_scan_el_temp_z.dev_attr.attr,
+	&iio_const_attr_temp_z_index.dev_attr.attr,
 	&iio_const_attr_temp_type.dev_attr.attr,
 	&iio_scan_el_in0.dev_attr.attr,
+	&iio_const_attr_in0_index.dev_attr.attr,
 	&iio_const_attr_in0_type.dev_attr.attr,
 	&iio_scan_el_timestamp.dev_attr.attr,
+	&iio_const_attr_timestamp_index.dev_attr.attr,
 	&iio_const_attr_timestamp_type.dev_attr.attr,
 	NULL,
 };
-- 
1.7.2.2
