Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-33.csi.cam.ac.uk ([131.111.8.133]:49429 "EHLO
	ppsw-33.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756426Ab0ITOHz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 20 Sep 2010 10:07:55 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: manuel.stahl@iis.fraunhofer.de, linux-iio@vger.kernel.org
Cc: drivers@analog.com, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 06/22] staging:iio:adis16260 add _type attributes for all scan elements
Date: Mon, 20 Sep 2010 15:12:51 +0100
Message-Id: <1284991987-12407-7-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1284991987-12407-1-git-send-email-jic23@cam.ac.uk>
References: <1284991987-12407-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/gyro/adis16260_ring.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
index 659a672..4b96394 100644
--- a/drivers/staging/iio/gyro/adis16260_ring.c
+++ b/drivers/staging/iio/gyro/adis16260_ring.c
@@ -19,24 +19,35 @@
 
 static IIO_SCAN_EL_C(in_supply, ADIS16260_SCAN_SUPPLY, IIO_UNSIGNED(12),
 		ADIS16260_SUPPLY_OUT, NULL);
+static IIO_CONST_ATTR_SCAN_EL_TYPE(in_supply, u, 12, 16);
 static IIO_SCAN_EL_C(gyro, ADIS16260_SCAN_GYRO, IIO_SIGNED(14),
 		ADIS16260_GYRO_OUT, NULL);
+static IIO_CONST_ATTR_SCAN_EL_TYPE(gyro, s, 14, 16);
 static IIO_SCAN_EL_C(in0, ADIS16260_SCAN_AUX_ADC, IIO_SIGNED(14),
 		ADIS16260_AUX_ADC, NULL);
+static IIO_CONST_ATTR_SCAN_EL_TYPE(in0, u, 12, 16);
 static IIO_SCAN_EL_C(temp, ADIS16260_SCAN_TEMP, IIO_UNSIGNED(12),
 		ADIS16260_TEMP_OUT, NULL);
+static IIO_CONST_ATTR_SCAN_EL_TYPE(temp, u, 12, 16);
 static IIO_SCAN_EL_C(angl, ADIS16260_SCAN_ANGL, IIO_UNSIGNED(12),
 		ADIS16260_ANGL_OUT, NULL);
-
+static IIO_CONST_ATTR_SCAN_EL_TYPE(angl, u, 14, 16);
 static IIO_SCAN_EL_TIMESTAMP(5);
+static IIO_CONST_ATTR_SCAN_EL_TYPE(timestamp, s, 64, 64);
 
 static struct attribute *adis16260_scan_el_attrs[] = {
 	&iio_scan_el_in_supply.dev_attr.attr,
+	&iio_const_attr_in_supply_type.dev_attr.attr,
 	&iio_scan_el_gyro.dev_attr.attr,
+	&iio_const_attr_gyro_type.dev_attr.attr,
 	&iio_scan_el_in0.dev_attr.attr,
+	&iio_const_attr_in0_type.dev_attr.attr,
 	&iio_scan_el_temp.dev_attr.attr,
+	&iio_const_attr_temp_type.dev_attr.attr,
 	&iio_scan_el_angl.dev_attr.attr,
+	&iio_const_attr_angl_type.dev_attr.attr,
 	&iio_scan_el_timestamp.dev_attr.attr,
+	&iio_const_attr_timestamp_type.dev_attr.attr,
 	NULL,
 };
 
-- 
1.7.2.2

