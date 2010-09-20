Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: manuel.stahl@iis.fraunhofer.de,
	linux-iio@vger.kernel.org
Cc: drivers@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 20/22] staging:iio:sca3000 add _index attribute registration
Date: Mon, 20 Sep 2010 15:13:05 +0100
Message-Id: <1284991987-12407-21-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1284991987-12407-1-git-send-email-jic23@cam.ac.uk>
References: <1284991987-12407-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/sca3000_ring.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
index 003097d..8186d2b 100644
--- a/drivers/staging/iio/accel/sca3000_ring.c
+++ b/drivers/staging/iio/accel/sca3000_ring.c
@@ -206,8 +206,11 @@ static IIO_DEVICE_ATTR(accel_type,
 
 static struct attribute *sca3000_scan_el_attrs[] = {
 	&iio_scan_el_accel_x.dev_attr.attr,
+	&iio_const_attr_accel_x_index.dev_attr.attr,
 	&iio_scan_el_accel_y.dev_attr.attr,
+	&iio_const_attr_accel_y_index.dev_attr.attr,
 	&iio_scan_el_accel_z.dev_attr.attr,
+	&iio_const_attr_accel_z_index.dev_attr.attr,
 	&iio_const_attr_accel_type_available.dev_attr.attr,
 	&iio_dev_attr_accel_type.dev_attr.attr,
 	NULL
-- 
1.7.2.2
