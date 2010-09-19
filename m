Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: manuel.stahl@iis.fraunhofer.de,
	linux-iio@vger.kernel.org
Cc: drivers@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 01/10] staging:iio:lis3l02dq add _type attributes for all scan elements
Date: Sun, 19 Sep 2010 18:04:25 +0100
Message-Id: <1284915874-24911-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1284915874-24911-1-git-send-email-jic23@cam.ac.uk>
References: <1284915874-24911-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/lis3l02dq_ring.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index f26c0fe..6c37c3b 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -84,13 +84,17 @@ static IIO_SCAN_EL_C(accel_y, 1, IIO_SIGNED(16),
 static IIO_SCAN_EL_C(accel_z, 2, IIO_SIGNED(16),
 		     LIS3L02DQ_REG_OUT_Z_L_ADDR,
 		     &lis3l02dq_scan_el_set_state);
+static IIO_CONST_ATTR(accel_type, "s12/16");
 static IIO_SCAN_EL_TIMESTAMP(3);
+static IIO_CONST_ATTR(timestamp_type, "s64/64");
 
 static struct attribute *lis3l02dq_scan_el_attrs[] = {
 	&iio_scan_el_accel_x.dev_attr.attr,
 	&iio_scan_el_accel_y.dev_attr.attr,
 	&iio_scan_el_accel_z.dev_attr.attr,
+	&iio_const_attr_accel_type.dev_attr.attr,
 	&iio_scan_el_timestamp.dev_attr.attr,
+	&iio_const_attr_timestamp_type.dev_attr.attr,
 	NULL,
 };
 
-- 
1.7.2.2
