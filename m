Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-33.csi.cam.ac.uk ([131.111.8.133]:49452 "EHLO
	ppsw-33.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756496Ab0ITOHz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 20 Sep 2010 10:07:55 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: manuel.stahl@iis.fraunhofer.de, linux-iio@vger.kernel.org
Cc: drivers@analog.com, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 12/22] staging:iio:lis3l02dq add _index attribute registration
Date: Mon, 20 Sep 2010 15:12:57 +0100
Message-Id: <1284991987-12407-13-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1284991987-12407-1-git-send-email-jic23@cam.ac.uk>
References: <1284991987-12407-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/lis3l02dq_ring.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 40cf670..330d5d6 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -90,10 +90,14 @@ static IIO_CONST_ATTR_SCAN_EL_TYPE(timestamp, s, 64, 64);
 
 static struct attribute *lis3l02dq_scan_el_attrs[] = {
 	&iio_scan_el_accel_x.dev_attr.attr,
+	&iio_const_attr_accel_x_index.dev_attr.attr,
 	&iio_scan_el_accel_y.dev_attr.attr,
+	&iio_const_attr_accel_y_index.dev_attr.attr,
 	&iio_scan_el_accel_z.dev_attr.attr,
+	&iio_const_attr_accel_z_index.dev_attr.attr,
 	&iio_const_attr_accel_type.dev_attr.attr,
 	&iio_scan_el_timestamp.dev_attr.attr,
+	&iio_const_attr_timestamp_index.dev_attr.attr,
 	&iio_const_attr_timestamp_type.dev_attr.attr,
 	NULL,
 };
-- 
1.7.2.2

