Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:51780 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755955Ab0JDPwi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Oct 2010 11:52:38 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: manuel.stahl@iis.fraunhofer.de, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 09/16] staging:iio:lis3l02dq event attribute renames
Date: Mon,  4 Oct 2010 16:57:58 +0100
Message-Id: <1286207885-26689-10-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1286207885-26689-1-git-send-email-jic23@cam.ac.uk>
References: <1286207885-26689-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/lis3l02dq_core.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index f52a0f5..c4b4ab7 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -497,7 +497,7 @@ static LIS3L02DQ_UNSIGNED_ATTR(accel_y_calibscale,
 static LIS3L02DQ_UNSIGNED_ATTR(accel_z_calibscale,
 			       LIS3L02DQ_REG_GAIN_Z_ADDR);
 
-static IIO_DEVICE_ATTR(accel_mag_either_rising_value,
+static IIO_DEVICE_ATTR(accel_raw_mag_value,
 		       S_IWUSR | S_IRUGO,
 		       lis3l02dq_read_16bit_signed,
 		       lis3l02dq_write_16bit_signed,
@@ -703,37 +703,37 @@ static void lis3l02dq_thresh_handler_bh_no_check(struct work_struct *work_s)
 /* A shared handler for a number of threshold types */
 IIO_EVENT_SH(threshold, &lis3l02dq_thresh_handler_th);
 
-IIO_EVENT_ATTR_SH(accel_x_mag_pos_rising_en,
+IIO_EVENT_ATTR_SH(accel_x_thresh_rising_en,
 		  iio_event_threshold,
 		  lis3l02dq_read_interrupt_config,
 		  lis3l02dq_write_interrupt_config,
 		  LIS3L02DQ_REG_WAKE_UP_CFG_INTERRUPT_X_HIGH);
 
-IIO_EVENT_ATTR_SH(accel_y_mag_pos_rising_en,
+IIO_EVENT_ATTR_SH(accel_y_thresh_rising_en,
 		  iio_event_threshold,
 		  lis3l02dq_read_interrupt_config,
 		  lis3l02dq_write_interrupt_config,
 		  LIS3L02DQ_REG_WAKE_UP_CFG_INTERRUPT_Y_HIGH);
 
-IIO_EVENT_ATTR_SH(accel_z_mag_pos_rising_en,
+IIO_EVENT_ATTR_SH(accel_z_thresh_rising_en,
 		  iio_event_threshold,
 		  lis3l02dq_read_interrupt_config,
 		  lis3l02dq_write_interrupt_config,
 		  LIS3L02DQ_REG_WAKE_UP_CFG_INTERRUPT_Z_HIGH);
 
-IIO_EVENT_ATTR_SH(accel_x_mag_neg_rising_en,
+IIO_EVENT_ATTR_SH(accel_x_thresh_falling_en,
 		  iio_event_threshold,
 		  lis3l02dq_read_interrupt_config,
 		  lis3l02dq_write_interrupt_config,
 		  LIS3L02DQ_REG_WAKE_UP_CFG_INTERRUPT_X_LOW);
 
-IIO_EVENT_ATTR_SH(accel_y_mag_neg_rising_en,
+IIO_EVENT_ATTR_SH(accel_y_thresh_falling_en,
 		  iio_event_threshold,
 		  lis3l02dq_read_interrupt_config,
 		  lis3l02dq_write_interrupt_config,
 		  LIS3L02DQ_REG_WAKE_UP_CFG_INTERRUPT_Y_LOW);
 
-IIO_EVENT_ATTR_SH(accel_z_mag_neg_rising_en,
+IIO_EVENT_ATTR_SH(accel_z_thresh_falling_en,
 		  iio_event_threshold,
 		  lis3l02dq_read_interrupt_config,
 		  lis3l02dq_write_interrupt_config,
@@ -741,13 +741,13 @@ IIO_EVENT_ATTR_SH(accel_z_mag_neg_rising_en,
 
 
 static struct attribute *lis3l02dq_event_attributes[] = {
-	&iio_event_attr_accel_x_mag_pos_rising_en.dev_attr.attr,
-	&iio_event_attr_accel_y_mag_pos_rising_en.dev_attr.attr,
-	&iio_event_attr_accel_z_mag_pos_rising_en.dev_attr.attr,
-	&iio_event_attr_accel_x_mag_neg_rising_en.dev_attr.attr,
-	&iio_event_attr_accel_y_mag_neg_rising_en.dev_attr.attr,
-	&iio_event_attr_accel_z_mag_neg_rising_en.dev_attr.attr,
-	&iio_dev_attr_accel_mag_either_rising_value.dev_attr.attr,
+	&iio_event_attr_accel_x_thresh_rising_en.dev_attr.attr,
+	&iio_event_attr_accel_y_thresh_rising_en.dev_attr.attr,
+	&iio_event_attr_accel_z_thresh_rising_en.dev_attr.attr,
+	&iio_event_attr_accel_x_thresh_falling_en.dev_attr.attr,
+	&iio_event_attr_accel_y_thresh_falling_en.dev_attr.attr,
+	&iio_event_attr_accel_z_thresh_falling_en.dev_attr.attr,
+	&iio_dev_attr_accel_raw_mag_value.dev_attr.attr,
 	NULL
 };
 
-- 
1.7.2.2

