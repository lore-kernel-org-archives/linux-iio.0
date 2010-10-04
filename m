Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: manuel.stahl@iis.fraunhofer.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 12/16] staging:iio:tsl2563 event attribute name updates
Date: Mon,  4 Oct 2010 16:58:01 +0100
Message-Id: <1286207885-26689-13-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1286207885-26689-1-git-send-email-jic23@cam.ac.uk>
References: <1286207885-26689-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Patch also renames the two raw channels to add numbers
so that we know to which channel the event code applies.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/light/tsl2563.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index 98149e1..dadae75 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -584,14 +584,14 @@ static ssize_t tsl2563_calib_store(struct device *dev,
 	return len;
 }
 
-static IIO_DEVICE_ATTR(intensity_both_raw, S_IRUGO,
+static IIO_DEVICE_ATTR(intensity0_both_raw, S_IRUGO,
 		tsl2563_adc_show, NULL, 0);
-static IIO_DEVICE_ATTR(intensity_ir_raw, S_IRUGO,
+static IIO_DEVICE_ATTR(intensity1_ir_raw, S_IRUGO,
 		tsl2563_adc_show, NULL, 1);
 static DEVICE_ATTR(illuminance0_input, S_IRUGO, tsl2563_lux_show, NULL);
-static IIO_DEVICE_ATTR(intensity_both_calibgain, S_IRUGO | S_IWUSR,
+static IIO_DEVICE_ATTR(intensity0_both_calibgain, S_IRUGO | S_IWUSR,
 		tsl2563_calib_show, tsl2563_calib_store, 0);
-static IIO_DEVICE_ATTR(intensity_ir_calibgain, S_IRUGO | S_IWUSR,
+static IIO_DEVICE_ATTR(intensity1_ir_calibgain, S_IRUGO | S_IWUSR,
 		tsl2563_calib_show, tsl2563_calib_store, 1);
 
 static ssize_t tsl2563_show_name(struct device *dev,
@@ -606,11 +606,11 @@ static ssize_t tsl2563_show_name(struct device *dev,
 static DEVICE_ATTR(name, S_IRUGO, tsl2563_show_name, NULL);
 
 static struct attribute *tsl2563_attributes[] = {
-	&iio_dev_attr_intensity_both_raw.dev_attr.attr,
-	&iio_dev_attr_intensity_ir_raw.dev_attr.attr,
+	&iio_dev_attr_intensity0_both_raw.dev_attr.attr,
+	&iio_dev_attr_intensity1_ir_raw.dev_attr.attr,
 	&dev_attr_illuminance0_input.attr,
-	&iio_dev_attr_intensity_both_calibgain.dev_attr.attr,
-	&iio_dev_attr_intensity_ir_calibgain.dev_attr.attr,
+	&iio_dev_attr_intensity0_both_calibgain.dev_attr.attr,
+	&iio_dev_attr_intensity1_ir_calibgain.dev_attr.attr,
 	&dev_attr_name.attr,
 	NULL
 };
@@ -673,13 +673,13 @@ error_ret:
 	return ret < 0 ? ret : len;
 }
 
-static IIO_DEVICE_ATTR(intensity_both_thresh_high_value,
+static IIO_DEVICE_ATTR(intensity0_both_raw_thresh_rising_value,
 		S_IRUGO | S_IWUSR,
 		tsl2563_read_thresh,
 		tsl2563_write_thresh,
 		TSL2563_REG_HIGHLOW);
 
-static IIO_DEVICE_ATTR(intensity_both_thresh_low_value,
+static IIO_DEVICE_ATTR(intensity0_both_raw_thresh_falling_value,
 		S_IRUGO | S_IWUSR,
 		tsl2563_read_thresh,
 		tsl2563_write_thresh,
@@ -791,16 +791,16 @@ error_ret:
 	return (ret < 0) ? ret : len;
 }
 
-IIO_EVENT_ATTR(intensity_both_thresh_both_en,
+IIO_EVENT_ATTR(intensity0_both_thresh_en,
 	tsl2563_read_interrupt_config,
 	tsl2563_write_interrupt_config,
 	0,
 	tsl2563_int_th);
 
 static struct attribute *tsl2563_event_attributes[] = {
-	&iio_event_attr_intensity_both_thresh_both_en.dev_attr.attr,
-	&iio_dev_attr_intensity_both_thresh_high_value.dev_attr.attr,
-	&iio_dev_attr_intensity_both_thresh_low_value.dev_attr.attr,
+	&iio_event_attr_intensity0_both_thresh_en.dev_attr.attr,
+	&iio_dev_attr_intensity0_both_raw_thresh_rising_value.dev_attr.attr,
+	&iio_dev_attr_intensity0_both_raw_thresh_falling_value.dev_attr.attr,
 	NULL,
 };
 
-- 
1.7.2.2
