Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:56700 "EHLO
	ppsw-32.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755351Ab0IAOxW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 1 Sep 2010 10:53:22 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 5/9] staging:iio: Remove deprecated ATTR_TEMP in favour of ATTR_TEMP_RAW
Date: Wed,  1 Sep 2010 15:57:59 +0100
Message-Id: <1283353083-31313-6-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1283353083-31313-1-git-send-email-jic23@cam.ac.uk>
References: <1283353083-31313-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16209_core.c |    4 ++--
 drivers/staging/iio/sysfs.h                |    7 -------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index 9ee523a..ab39885 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -421,7 +421,7 @@ static IIO_CONST_ATTR(incli_scale, "0.00043633231");
 static IIO_DEVICE_ATTR(rot_raw, S_IRUGO, adis16209_read_14bit_signed,
 		       NULL, ADIS16209_ROT_OUT);
 
-static IIO_DEV_ATTR_TEMP(adis16209_read_temp);
+static IIO_DEV_ATTR_TEMP_RAW(adis16209_read_temp);
 static IIO_CONST_ATTR_TEMP_OFFSET("25");
 static IIO_CONST_ATTR_TEMP_SCALE("-0.47");
 
@@ -440,7 +440,7 @@ static struct attribute_group adis16209_event_attribute_group = {
 static struct attribute *adis16209_attributes[] = {
 	&iio_dev_attr_in_supply_raw.dev_attr.attr,
 	&iio_const_attr_in_supply_scale.dev_attr.attr,
-	&iio_dev_attr_temp.dev_attr.attr,
+	&iio_dev_attr_temp_raw.dev_attr.attr,
 	&iio_const_attr_temp_offset.dev_attr.attr,
 	&iio_const_attr_temp_scale.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index 96cc3a7..b531dc1 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -161,13 +161,6 @@ struct iio_const_attr {
 #define IIO_DEV_ATTR_HW_RING_ENABLE(_show, _store)			\
 	IIO_DEVICE_ATTR(hw_ring_enable, S_IRUGO | S_IWUSR, _show, _store, 0)
 
-/**
- * IIO_DEV_ATTR_TEMP - many sensors have auxiliary temperature sensors
- * @_show: output method for the attribute
- **/
-#define IIO_DEV_ATTR_TEMP(_show)			\
-	IIO_DEVICE_ATTR(temp, S_IRUGO, _show, NULL, 0)
-
 #define IIO_DEV_ATTR_TEMP_RAW(_show)			\
 	IIO_DEVICE_ATTR(temp_raw, S_IRUGO, _show, NULL, 0)
 
-- 
1.7.1

