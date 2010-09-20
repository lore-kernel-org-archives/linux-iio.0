Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: manuel.stahl@iis.fraunhofer.de,
	linux-iio@vger.kernel.org
Cc: drivers@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 13/22] staging:iio:adis16209 add _index attribute registration
Date: Mon, 20 Sep 2010 15:12:58 +0100
Message-Id: <1284991987-12407-14-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1284991987-12407-1-git-send-email-jic23@cam.ac.uk>
References: <1284991987-12407-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16209_ring.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index 8dd2881..033135c 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -39,20 +39,29 @@ static IIO_CONST_ATTR_SCAN_EL_TYPE(timestamp, s, 64, 64);
 
 static struct attribute *adis16209_scan_el_attrs[] = {
 	&iio_scan_el_in_supply.dev_attr.attr,
+	&iio_const_attr_in_supply_index.dev_attr.attr,
 	&iio_const_attr_in_supply_type.dev_attr.attr,
 	&iio_scan_el_accel_x.dev_attr.attr,
+	&iio_const_attr_accel_x_index.dev_attr.attr,
 	&iio_scan_el_accel_y.dev_attr.attr,
+	&iio_const_attr_accel_y_index.dev_attr.attr,
 	&iio_const_attr_accel_type.dev_attr.attr,
 	&iio_scan_el_in0.dev_attr.attr,
+	&iio_const_attr_in0_index.dev_attr.attr,
 	&iio_const_attr_in0_type.dev_attr.attr,
 	&iio_scan_el_temp.dev_attr.attr,
+	&iio_const_attr_temp_index.dev_attr.attr,
 	&iio_const_attr_temp_type.dev_attr.attr,
 	&iio_scan_el_incli_x.dev_attr.attr,
+	&iio_const_attr_incli_x_index.dev_attr.attr,
 	&iio_scan_el_incli_y.dev_attr.attr,
+	&iio_const_attr_incli_y_index.dev_attr.attr,
 	&iio_const_attr_incli_type.dev_attr.attr,
 	&iio_scan_el_rot.dev_attr.attr,
+	&iio_const_attr_rot_index.dev_attr.attr,
 	&iio_const_attr_rot_type.dev_attr.attr,
 	&iio_scan_el_timestamp.dev_attr.attr,
+	&iio_const_attr_timestamp_index.dev_attr.attr,
 	&iio_const_attr_timestamp_type.dev_attr.attr,
 	NULL,
 };
-- 
1.7.2.2
