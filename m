Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-33.csi.cam.ac.uk ([131.111.8.133]:49472 "EHLO
	ppsw-33.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756505Ab0ITOH4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 20 Sep 2010 10:07:56 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: manuel.stahl@iis.fraunhofer.de, linux-iio@vger.kernel.org
Cc: drivers@analog.com, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 18/22] staging:iio:adis16400 add _index attribute registration
Date: Mon, 20 Sep 2010 15:13:03 +0100
Message-Id: <1284991987-12407-19-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1284991987-12407-1-git-send-email-jic23@cam.ac.uk>
References: <1284991987-12407-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/imu/adis16400_ring.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index 42703da..1de858c 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -47,24 +47,37 @@ static IIO_CONST_ATTR_SCAN_EL_TYPE(timestamp, s, 64, 64);
 
 static struct attribute *adis16400_scan_el_attrs[] = {
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
 	&iio_scan_el_magn_x.dev_attr.attr,
+	&iio_const_attr_magn_x_index.dev_attr.attr,
 	&iio_scan_el_magn_y.dev_attr.attr,
+	&iio_const_attr_magn_y_index.dev_attr.attr,
 	&iio_scan_el_magn_z.dev_attr.attr,
+	&iio_const_attr_magn_z_index.dev_attr.attr,
 	&iio_const_attr_magn_type.dev_attr.attr,
 	&iio_scan_el_temp.dev_attr.attr,
+	&iio_const_attr_temp_index.dev_attr.attr,
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

