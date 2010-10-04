Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:51882 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756355Ab0JDPwn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Oct 2010 11:52:43 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: manuel.stahl@iis.fraunhofer.de, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 15/16] staging:iio:adc add numbers to naming of all adc channels as needed to associate events with them.
Date: Mon,  4 Oct 2010 16:58:04 +0100
Message-Id: <1286207885-26689-16-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1286207885-26689-1-git-send-email-jic23@cam.ac.uk>
References: <1286207885-26689-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Given event codes are associated by number not name, all adc channels
including those with names need to have numbers.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16209_core.c |   16 ++++++++--------
 drivers/staging/iio/accel/adis16220_core.c |   14 +++++++-------
 drivers/staging/iio/accel/adis16240_core.c |   12 ++++++------
 drivers/staging/iio/adc/adc.h              |   12 ++++++------
 drivers/staging/iio/gyro/adis16260_core.c  |   16 ++++++++--------
 drivers/staging/iio/imu/adis16300_core.c   |   16 ++++++++--------
 drivers/staging/iio/imu/adis16300_ring.c   |   24 ++++++++++++------------
 drivers/staging/iio/imu/adis16350_core.c   |   16 ++++++++--------
 drivers/staging/iio/imu/adis16350_ring.c   |   24 ++++++++++++------------
 drivers/staging/iio/imu/adis16400_core.c   |   16 ++++++++--------
 drivers/staging/iio/imu/adis16400_ring.c   |   24 ++++++++++++------------
 11 files changed, 95 insertions(+), 95 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index ab39885..e4ac956 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -391,12 +391,12 @@ err_ret:
 	return ret;
 }
 
-static IIO_DEV_ATTR_IN_NAMED_RAW(supply, adis16209_read_14bit_unsigned,
+static IIO_DEV_ATTR_IN_NAMED_RAW(0, supply, adis16209_read_14bit_unsigned,
 		ADIS16209_SUPPLY_OUT);
-static IIO_CONST_ATTR_IN_NAMED_SCALE(supply, "0.30518");
-static IIO_DEV_ATTR_IN_RAW(0, adis16209_read_12bit_unsigned,
+static IIO_CONST_ATTR_IN_NAMED_SCALE(0, supply, "0.30518");
+static IIO_DEV_ATTR_IN_RAW(1, adis16209_read_12bit_unsigned,
 		ADIS16209_AUX_ADC);
-static IIO_CONST_ATTR(in0_scale, "0.6105");
+static IIO_CONST_ATTR(in1_scale, "0.6105");
 
 static IIO_DEV_ATTR_ACCEL_X(adis16209_read_14bit_signed,
 		ADIS16209_XACCL_OUT);
@@ -438,15 +438,15 @@ static struct attribute_group adis16209_event_attribute_group = {
 };
 
 static struct attribute *adis16209_attributes[] = {
-	&iio_dev_attr_in_supply_raw.dev_attr.attr,
-	&iio_const_attr_in_supply_scale.dev_attr.attr,
+	&iio_dev_attr_in0_supply_raw.dev_attr.attr,
+	&iio_const_attr_in0_supply_scale.dev_attr.attr,
 	&iio_dev_attr_temp_raw.dev_attr.attr,
 	&iio_const_attr_temp_offset.dev_attr.attr,
 	&iio_const_attr_temp_scale.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
 	&iio_const_attr_name.dev_attr.attr,
-	&iio_dev_attr_in0_raw.dev_attr.attr,
-	&iio_const_attr_in0_scale.dev_attr.attr,
+	&iio_dev_attr_in1_raw.dev_attr.attr,
+	&iio_const_attr_in1_scale.dev_attr.attr,
 	&iio_dev_attr_accel_x_raw.dev_attr.attr,
 	&iio_dev_attr_accel_y_raw.dev_attr.attr,
 	&iio_dev_attr_accel_x_calibbias.dev_attr.attr,
diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
index 032616e..c86d149 100644
--- a/drivers/staging/iio/accel/adis16220_core.c
+++ b/drivers/staging/iio/accel/adis16220_core.c
@@ -485,9 +485,9 @@ static struct bin_attribute adc2_bin = {
 	.size = ADIS16220_CAPTURE_SIZE,
 };
 
-static IIO_DEV_ATTR_IN_NAMED_RAW(supply, adis16220_read_12bit_unsigned,
+static IIO_DEV_ATTR_IN_NAMED_RAW(0, supply, adis16220_read_12bit_unsigned,
 		ADIS16220_CAPT_SUPPLY);
-static IIO_CONST_ATTR_IN_NAMED_SCALE(supply, "0.0012207");
+static IIO_CONST_ATTR_IN_NAMED_SCALE(0, supply, "0.0012207");
 static IIO_DEV_ATTR_ACCEL(adis16220_read_16bit, ADIS16220_CAPT_BUFA);
 static IIO_DEVICE_ATTR(accel_peak_raw, S_IRUGO, adis16220_read_16bit,
 		NULL, ADIS16220_CAPT_PEAKA);
@@ -500,8 +500,8 @@ static IIO_DEV_ATTR_TEMP_RAW(adis16220_read_12bit_unsigned);
 static IIO_CONST_ATTR_TEMP_OFFSET("25");
 static IIO_CONST_ATTR_TEMP_SCALE("-0.47");
 
-static IIO_DEV_ATTR_IN_RAW(0, adis16220_read_16bit, ADIS16220_CAPT_BUF1);
-static IIO_DEV_ATTR_IN_RAW(1, adis16220_read_16bit, ADIS16220_CAPT_BUF2);
+static IIO_DEV_ATTR_IN_RAW(1, adis16220_read_16bit, ADIS16220_CAPT_BUF1);
+static IIO_DEV_ATTR_IN_RAW(2, adis16220_read_16bit, ADIS16220_CAPT_BUF2);
 
 static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL,
 		adis16220_write_reset, 0);
@@ -524,15 +524,15 @@ static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("100200");
 static IIO_CONST_ATTR_NAME("adis16220");
 
 static struct attribute *adis16220_attributes[] = {
-	&iio_dev_attr_in_supply_raw.dev_attr.attr,
-	&iio_const_attr_in_supply_scale.dev_attr.attr,
+	&iio_dev_attr_in0_supply_raw.dev_attr.attr,
+	&iio_const_attr_in0_supply_scale.dev_attr.attr,
 	&iio_dev_attr_accel_raw.dev_attr.attr,
 	&iio_dev_attr_accel_offset.dev_attr.attr,
 	&iio_dev_attr_accel_peak_raw.dev_attr.attr,
 	&iio_const_attr_accel_scale.dev_attr.attr,
 	&iio_dev_attr_temp_raw.dev_attr.attr,
-	&iio_dev_attr_in0_raw.dev_attr.attr,
 	&iio_dev_attr_in1_raw.dev_attr.attr,
+	&iio_dev_attr_in2_raw.dev_attr.attr,
 	&iio_const_attr_temp_offset.dev_attr.attr,
 	&iio_const_attr_temp_scale.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index 49e172a..d11d164 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -376,11 +376,11 @@ err_ret:
 	return ret;
 }
 
-static IIO_DEV_ATTR_IN_NAMED_RAW(supply, adis16240_read_10bit_unsigned,
+static IIO_DEV_ATTR_IN_NAMED_RAW(0, supply, adis16240_read_10bit_unsigned,
 		ADIS16240_SUPPLY_OUT);
-static IIO_DEV_ATTR_IN_RAW(0, adis16240_read_10bit_signed,
+static IIO_DEV_ATTR_IN_RAW(1, adis16240_read_10bit_signed,
 		ADIS16240_AUX_ADC);
-static IIO_CONST_ATTR_IN_NAMED_SCALE(supply, "0.00488");
+static IIO_CONST_ATTR_IN_NAMED_SCALE(0, supply, "0.00488");
 
 static IIO_CONST_ATTR_ACCEL_SCALE("0.50406181");
 static IIO_CONST_ATTR(accel_peak_scale, "6.6292954");
@@ -433,9 +433,9 @@ static struct attribute_group adis16240_event_attribute_group = {
 };
 
 static struct attribute *adis16240_attributes[] = {
-	&iio_dev_attr_in_supply_raw.dev_attr.attr,
-	&iio_const_attr_in_supply_scale.dev_attr.attr,
-	&iio_dev_attr_in0_raw.dev_attr.attr,
+	&iio_dev_attr_in0_supply_raw.dev_attr.attr,
+	&iio_const_attr_in0_supply_scale.dev_attr.attr,
+	&iio_dev_attr_in1_raw.dev_attr.attr,
 	&iio_const_attr_accel_scale.dev_attr.attr,
 	&iio_const_attr_accel_peak_scale.dev_attr.attr,
 	&iio_dev_attr_accel_x_raw.dev_attr.attr,
diff --git a/drivers/staging/iio/adc/adc.h b/drivers/staging/iio/adc/adc.h
index 4f13427..40c5949 100644
--- a/drivers/staging/iio/adc/adc.h
+++ b/drivers/staging/iio/adc/adc.h
@@ -16,8 +16,8 @@
 #define IIO_DEV_ATTR_IN_RAW(_num, _show, _addr)				\
 	IIO_DEVICE_ATTR(in##_num##_raw, S_IRUGO, _show, NULL, _addr)
 
-#define IIO_DEV_ATTR_IN_NAMED_RAW(_name, _show, _addr)			\
-	IIO_DEVICE_ATTR(in_##_name##_raw, S_IRUGO, _show, NULL, _addr)
+#define IIO_DEV_ATTR_IN_NAMED_RAW(_num, _name, _show, _addr)		\
+	IIO_DEVICE_ATTR(in##_num##_##_name##_raw, S_IRUGO, _show, NULL, _addr)
 
 #define IIO_DEV_ATTR_IN_DIFF_RAW(_nump, _numn, _show, _addr)		\
 	IIO_DEVICE_ATTR_NAMED(in##_nump##min##_numn##_raw,		\
@@ -28,11 +28,11 @@
 			      _addr)
 
 
-#define IIO_CONST_ATTR_IN_NAMED_OFFSET(_name, _string)			\
-	IIO_CONST_ATTR(in_##_name##_offset, _string)
+#define IIO_CONST_ATTR_IN_NAMED_OFFSET(_num, _name, _string)	\
+	IIO_CONST_ATTR(in##_num##_##_name##_offset, _string)
 
-#define IIO_CONST_ATTR_IN_NAMED_SCALE(_name, _string)			\
-	IIO_CONST_ATTR(in_##_name##_scale, _string)
+#define IIO_CONST_ATTR_IN_NAMED_SCALE(_num, _name, _string)	\
+	IIO_CONST_ATTR(in##_num##_##_name##_scale, _string)
 
 #define IIO_EVENT_CODE_IN_HIGH_THRESH(a)				\
 	IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_IN, a, IIO_EV_TYPE_THRESH,	\
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index c1ad0c8..7d7716e 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -442,10 +442,10 @@ err_ret:
 	return ret;
 }
 
-static IIO_DEV_ATTR_IN_NAMED_RAW(supply,
+static IIO_DEV_ATTR_IN_NAMED_RAW(0, supply,
 				adis16260_read_12bit_unsigned,
 				ADIS16260_SUPPLY_OUT);
-static IIO_CONST_ATTR_IN_NAMED_SCALE(supply, "0.0018315");
+static IIO_CONST_ATTR_IN_NAMED_SCALE(0, supply, "0.0018315");
 
 static IIO_DEV_ATTR_GYRO(adis16260_read_14bit_signed,
 		ADIS16260_GYRO_OUT);
@@ -463,9 +463,9 @@ static IIO_DEV_ATTR_TEMP_RAW(adis16260_read_12bit_unsigned);
 static IIO_CONST_ATTR_TEMP_OFFSET("25");
 static IIO_CONST_ATTR_TEMP_SCALE("0.1453");
 
-static IIO_DEV_ATTR_IN_RAW(0, adis16260_read_12bit_unsigned,
+static IIO_DEV_ATTR_IN_RAW(1, adis16260_read_12bit_unsigned,
 		ADIS16260_AUX_ADC);
-static IIO_CONST_ATTR(in0_scale, "0.0006105");
+static IIO_CONST_ATTR(in1_scale, "0.0006105");
 
 static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
 		adis16260_read_frequency,
@@ -488,8 +488,8 @@ static struct attribute_group adis16260_event_attribute_group = {
 };
 
 static struct attribute *adis16260_attributes[] = {
-	&iio_dev_attr_in_supply_raw.dev_attr.attr,
-	&iio_const_attr_in_supply_scale.dev_attr.attr,
+	&iio_dev_attr_in0_supply_raw.dev_attr.attr,
+	&iio_const_attr_in0_supply_scale.dev_attr.attr,
 	&iio_dev_attr_gyro_raw.dev_attr.attr,
 	&iio_const_attr_gyro_scale.dev_attr.attr,
 	&iio_dev_attr_gyro_calibscale.dev_attr.attr,
@@ -498,8 +498,8 @@ static struct attribute *adis16260_attributes[] = {
 	&iio_dev_attr_temp_raw.dev_attr.attr,
 	&iio_const_attr_temp_offset.dev_attr.attr,
 	&iio_const_attr_temp_scale.dev_attr.attr,
-	&iio_dev_attr_in0_raw.dev_attr.attr,
-	&iio_const_attr_in0_scale.dev_attr.attr,
+	&iio_dev_attr_in1_raw.dev_attr.attr,
+	&iio_const_attr_in1_scale.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
diff --git a/drivers/staging/iio/imu/adis16300_core.c b/drivers/staging/iio/imu/adis16300_core.c
index 3ed86cc..7ad13f4 100644
--- a/drivers/staging/iio/imu/adis16300_core.c
+++ b/drivers/staging/iio/imu/adis16300_core.c
@@ -523,9 +523,9 @@ static IIO_DEV_ATTR_ACCEL_Z_CALIBBIAS(S_IWUSR | S_IRUGO,
 		adis16300_write_16bit,
 		ADIS16300_ZACCL_OFF);
 
-static IIO_DEV_ATTR_IN_NAMED_RAW(supply, adis16300_read_14bit_unsigned,
+static IIO_DEV_ATTR_IN_NAMED_RAW(0, supply, adis16300_read_14bit_unsigned,
 			   ADIS16300_SUPPLY_OUT);
-static IIO_CONST_ATTR_IN_NAMED_SCALE(supply, "0.00242");
+static IIO_CONST_ATTR_IN_NAMED_SCALE(0, supply, "0.00242");
 
 static IIO_DEV_ATTR_GYRO_X(adis16300_read_14bit_signed,
 		ADIS16300_XGYRO_OUT);
@@ -549,9 +549,9 @@ static IIO_DEV_ATTR_TEMP_RAW(adis16300_read_12bit_unsigned);
 static IIO_CONST_ATTR_TEMP_OFFSET("198.16");
 static IIO_CONST_ATTR_TEMP_SCALE("0.14");
 
-static IIO_DEV_ATTR_IN_RAW(0, adis16300_read_12bit_unsigned,
+static IIO_DEV_ATTR_IN_RAW(1, adis16300_read_12bit_unsigned,
 		ADIS16300_AUX_ADC);
-static IIO_CONST_ATTR(in0_scale, "0.000806");
+static IIO_CONST_ATTR(in1_scale, "0.000806");
 
 static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
 		adis16300_read_frequency,
@@ -576,8 +576,8 @@ static struct attribute *adis16300_attributes[] = {
 	&iio_dev_attr_accel_x_calibbias.dev_attr.attr,
 	&iio_dev_attr_accel_y_calibbias.dev_attr.attr,
 	&iio_dev_attr_accel_z_calibbias.dev_attr.attr,
-	&iio_dev_attr_in_supply_raw.dev_attr.attr,
-	&iio_const_attr_in_supply_scale.dev_attr.attr,
+	&iio_dev_attr_in0_supply_raw.dev_attr.attr,
+	&iio_const_attr_in0_supply_scale.dev_attr.attr,
 	&iio_dev_attr_gyro_x_raw.dev_attr.attr,
 	&iio_const_attr_gyro_scale.dev_attr.attr,
 	&iio_dev_attr_accel_x_raw.dev_attr.attr,
@@ -590,8 +590,8 @@ static struct attribute *adis16300_attributes[] = {
 	&iio_dev_attr_temp_raw.dev_attr.attr,
 	&iio_const_attr_temp_offset.dev_attr.attr,
 	&iio_const_attr_temp_scale.dev_attr.attr,
-	&iio_dev_attr_in0_raw.dev_attr.attr,
-	&iio_const_attr_in0_scale.dev_attr.attr,
+	&iio_dev_attr_in1_raw.dev_attr.attr,
+	&iio_const_attr_in1_scale.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
diff --git a/drivers/staging/iio/imu/adis16300_ring.c b/drivers/staging/iio/imu/adis16300_ring.c
index 6af6ba5..114fdf4 100644
--- a/drivers/staging/iio/imu/adis16300_ring.c
+++ b/drivers/staging/iio/imu/adis16300_ring.c
@@ -17,9 +17,9 @@
 #include "../trigger.h"
 #include "adis16300.h"
 
-static IIO_SCAN_EL_C(in_supply, ADIS16300_SCAN_SUPPLY,
+static IIO_SCAN_EL_C(in0_supply, ADIS16300_SCAN_SUPPLY,
 		     ADIS16300_SUPPLY_OUT, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(in_supply, u, 12, 16);
+static IIO_CONST_ATTR_SCAN_EL_TYPE(in0_supply, u, 12, 16);
 static IIO_SCAN_EL_C(gyro_x, ADIS16300_SCAN_GYRO_X, ADIS16300_XGYRO_OUT, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(gyro, s, 14, 16);
 
@@ -31,8 +31,8 @@ static IIO_CONST_ATTR_SCAN_EL_TYPE(accel, s, 14, 16);
 static IIO_SCAN_EL_C(temp, ADIS16300_SCAN_TEMP, ADIS16300_TEMP_OUT, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(temp, s, 12, 16);
 
-static IIO_SCAN_EL_C(in0, ADIS16300_SCAN_ADC_0, ADIS16300_AUX_ADC, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(in0, u, 12, 16);
+static IIO_SCAN_EL_C(in1, ADIS16300_SCAN_ADC_0, ADIS16300_AUX_ADC, NULL);
+static IIO_CONST_ATTR_SCAN_EL_TYPE(in1, u, 12, 16);
 
 static IIO_SCAN_EL_C(incli_x, ADIS16300_SCAN_INCLI_X,
 		     ADIS16300_XINCLI_OUT, NULL);
@@ -44,9 +44,9 @@ static IIO_SCAN_EL_TIMESTAMP(9);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(timestamp, s, 64, 64);
 
 static struct attribute *adis16300_scan_el_attrs[] = {
-	&iio_scan_el_in_supply.dev_attr.attr,
-	&iio_const_attr_in_supply_index.dev_attr.attr,
-	&iio_const_attr_in_supply_type.dev_attr.attr,
+	&iio_scan_el_in0_supply.dev_attr.attr,
+	&iio_const_attr_in0_supply_index.dev_attr.attr,
+	&iio_const_attr_in0_supply_type.dev_attr.attr,
 	&iio_scan_el_gyro_x.dev_attr.attr,
 	&iio_const_attr_gyro_x_index.dev_attr.attr,
 	&iio_const_attr_gyro_type.dev_attr.attr,
@@ -65,9 +65,9 @@ static struct attribute *adis16300_scan_el_attrs[] = {
 	&iio_scan_el_incli_y.dev_attr.attr,
 	&iio_const_attr_incli_y_index.dev_attr.attr,
 	&iio_const_attr_incli_type.dev_attr.attr,
-	&iio_scan_el_in0.dev_attr.attr,
-	&iio_const_attr_in0_index.dev_attr.attr,
-	&iio_const_attr_in0_type.dev_attr.attr,
+	&iio_scan_el_in1.dev_attr.attr,
+	&iio_const_attr_in1_index.dev_attr.attr,
+	&iio_const_attr_in1_type.dev_attr.attr,
 	&iio_scan_el_timestamp.dev_attr.attr,
 	&iio_const_attr_timestamp_index.dev_attr.attr,
 	&iio_const_attr_timestamp_type.dev_attr.attr,
@@ -214,13 +214,13 @@ int adis16300_configure_ring(struct iio_dev *indio_dev)
 	ring->owner = THIS_MODULE;
 
 	/* Set default scan mode */
-	iio_scan_mask_set(ring, iio_scan_el_in_supply.number);
+	iio_scan_mask_set(ring, iio_scan_el_in0_supply.number);
 	iio_scan_mask_set(ring, iio_scan_el_gyro_x.number);
 	iio_scan_mask_set(ring, iio_scan_el_accel_x.number);
 	iio_scan_mask_set(ring, iio_scan_el_accel_y.number);
 	iio_scan_mask_set(ring, iio_scan_el_accel_z.number);
 	iio_scan_mask_set(ring, iio_scan_el_temp.number);
-	iio_scan_mask_set(ring, iio_scan_el_in0.number);
+	iio_scan_mask_set(ring, iio_scan_el_in1.number);
 	iio_scan_mask_set(ring, iio_scan_el_incli_x.number);
 	iio_scan_mask_set(ring, iio_scan_el_incli_y.number);
 
diff --git a/drivers/staging/iio/imu/adis16350_core.c b/drivers/staging/iio/imu/adis16350_core.c
index cc33843..97c1ec8 100644
--- a/drivers/staging/iio/imu/adis16350_core.c
+++ b/drivers/staging/iio/imu/adis16350_core.c
@@ -505,9 +505,9 @@ static IIO_DEV_ATTR_ACCEL_Z_CALIBBIAS(S_IWUSR | S_IRUGO,
 		adis16350_write_16bit,
 		ADIS16350_ZACCL_OFF);
 
-static IIO_DEV_ATTR_IN_NAMED_RAW(supply, adis16350_read_12bit_unsigned,
+static IIO_DEV_ATTR_IN_NAMED_RAW(0, supply, adis16350_read_12bit_unsigned,
 		ADIS16350_SUPPLY_OUT);
-static IIO_CONST_ATTR_IN_NAMED_SCALE(supply, "0.002418");
+static IIO_CONST_ATTR_IN_NAMED_SCALE(0, supply, "0.002418");
 
 static IIO_DEV_ATTR_GYRO_X(adis16350_read_14bit_signed,
 		ADIS16350_XGYRO_OUT);
@@ -534,9 +534,9 @@ static IIO_DEVICE_ATTR(temp_z_raw, S_IRUGO, adis16350_read_12bit_signed,
 static IIO_CONST_ATTR_TEMP_SCALE("0.14534");
 static IIO_CONST_ATTR_TEMP_OFFSET("198.16");
 
-static IIO_DEV_ATTR_IN_RAW(0, adis16350_read_12bit_unsigned,
+static IIO_DEV_ATTR_IN_RAW(1, adis16350_read_12bit_unsigned,
 		ADIS16350_AUX_ADC);
-static IIO_CONST_ATTR(in0_scale, "0.000806");
+static IIO_CONST_ATTR(in1_scale, "0.000806");
 
 static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
 		adis16350_read_frequency,
@@ -556,8 +556,8 @@ static struct attribute *adis16350_attributes[] = {
 	&iio_dev_attr_accel_x_calibbias.dev_attr.attr,
 	&iio_dev_attr_accel_y_calibbias.dev_attr.attr,
 	&iio_dev_attr_accel_z_calibbias.dev_attr.attr,
-	&iio_dev_attr_in_supply_raw.dev_attr.attr,
-	&iio_const_attr_in_supply_scale.dev_attr.attr,
+	&iio_dev_attr_in0_supply_raw.dev_attr.attr,
+	&iio_const_attr_in0_supply_scale.dev_attr.attr,
 	&iio_dev_attr_gyro_x_raw.dev_attr.attr,
 	&iio_dev_attr_gyro_y_raw.dev_attr.attr,
 	&iio_dev_attr_gyro_z_raw.dev_attr.attr,
@@ -570,8 +570,8 @@ static struct attribute *adis16350_attributes[] = {
 	&iio_dev_attr_temp_y_raw.dev_attr.attr,
 	&iio_dev_attr_temp_z_raw.dev_attr.attr,
 	&iio_const_attr_temp_scale.dev_attr.attr,
-	&iio_dev_attr_in0_raw.dev_attr.attr,
-	&iio_const_attr_in0_scale.dev_attr.attr,
+	&iio_dev_attr_in1_raw.dev_attr.attr,
+	&iio_const_attr_in1_scale.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
diff --git a/drivers/staging/iio/imu/adis16350_ring.c b/drivers/staging/iio/imu/adis16350_ring.c
index b2c8f43..56b70cf 100644
--- a/drivers/staging/iio/imu/adis16350_ring.c
+++ b/drivers/staging/iio/imu/adis16350_ring.c
@@ -17,9 +17,9 @@
 #include "../trigger.h"
 #include "adis16350.h"
 
-static IIO_SCAN_EL_C(in_supply, ADIS16350_SCAN_SUPPLY,
+static IIO_SCAN_EL_C(in0_supply, ADIS16350_SCAN_SUPPLY,
 		ADIS16350_SUPPLY_OUT, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(in_supply, u, 12, 16);
+static IIO_CONST_ATTR_SCAN_EL_TYPE(in0_supply, u, 12, 16);
 
 static IIO_SCAN_EL_C(gyro_x, ADIS16350_SCAN_GYRO_X, ADIS16350_XGYRO_OUT, NULL);
 static IIO_SCAN_EL_C(gyro_y, ADIS16350_SCAN_GYRO_Y, ADIS16350_YGYRO_OUT, NULL);
@@ -36,16 +36,16 @@ static IIO_SCAN_EL_C(temp_y, ADIS16350_SCAN_TEMP_Y, ADIS16350_YTEMP_OUT, NULL);
 static IIO_SCAN_EL_C(temp_z, ADIS16350_SCAN_TEMP_Z, ADIS16350_ZTEMP_OUT, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(temp, s, 12, 16);
 
-static IIO_SCAN_EL_C(in0, ADIS16350_SCAN_ADC_0, ADIS16350_AUX_ADC, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(in0, u, 12, 16);
+static IIO_SCAN_EL_C(in1, ADIS16350_SCAN_ADC_0, ADIS16350_AUX_ADC, NULL);
+static IIO_CONST_ATTR_SCAN_EL_TYPE(in1, u, 12, 16);
 
 static IIO_SCAN_EL_TIMESTAMP(11);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(timestamp, s, 64, 64);
 
 static struct attribute *adis16350_scan_el_attrs[] = {
-	&iio_scan_el_in_supply.dev_attr.attr,
-	&iio_const_attr_in_supply_index.dev_attr.attr,
-	&iio_const_attr_in_supply_type.dev_attr.attr,
+	&iio_scan_el_in0_supply.dev_attr.attr,
+	&iio_const_attr_in0_supply_index.dev_attr.attr,
+	&iio_const_attr_in0_supply_type.dev_attr.attr,
 	&iio_scan_el_gyro_x.dev_attr.attr,
 	&iio_const_attr_gyro_x_index.dev_attr.attr,
 	&iio_scan_el_gyro_y.dev_attr.attr,
@@ -67,9 +67,9 @@ static struct attribute *adis16350_scan_el_attrs[] = {
 	&iio_scan_el_temp_z.dev_attr.attr,
 	&iio_const_attr_temp_z_index.dev_attr.attr,
 	&iio_const_attr_temp_type.dev_attr.attr,
-	&iio_scan_el_in0.dev_attr.attr,
-	&iio_const_attr_in0_index.dev_attr.attr,
-	&iio_const_attr_in0_type.dev_attr.attr,
+	&iio_scan_el_in1.dev_attr.attr,
+	&iio_const_attr_in1_index.dev_attr.attr,
+	&iio_const_attr_in1_type.dev_attr.attr,
 	&iio_scan_el_timestamp.dev_attr.attr,
 	&iio_const_attr_timestamp_index.dev_attr.attr,
 	&iio_const_attr_timestamp_type.dev_attr.attr,
@@ -210,7 +210,7 @@ int adis16350_configure_ring(struct iio_dev *indio_dev)
 	ring->owner = THIS_MODULE;
 
 	/* Set default scan mode */
-	iio_scan_mask_set(ring, iio_scan_el_in_supply.number);
+	iio_scan_mask_set(ring, iio_scan_el_in0_supply.number);
 	iio_scan_mask_set(ring, iio_scan_el_gyro_x.number);
 	iio_scan_mask_set(ring, iio_scan_el_gyro_y.number);
 	iio_scan_mask_set(ring, iio_scan_el_gyro_z.number);
@@ -220,7 +220,7 @@ int adis16350_configure_ring(struct iio_dev *indio_dev)
 	iio_scan_mask_set(ring, iio_scan_el_temp_x.number);
 	iio_scan_mask_set(ring, iio_scan_el_temp_y.number);
 	iio_scan_mask_set(ring, iio_scan_el_temp_z.number);
-	iio_scan_mask_set(ring, iio_scan_el_in0.number);
+	iio_scan_mask_set(ring, iio_scan_el_in1.number);
 
 	ret = iio_alloc_pollfunc(indio_dev, NULL, &adis16350_poll_func_th);
 	if (ret)
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 5f1643a..cfb108a 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -505,9 +505,9 @@ static ADIS16400_DEV_ATTR_CALIBBIAS(ACCEL_Y, ADIS16400_XACCL_OFF);
 static ADIS16400_DEV_ATTR_CALIBBIAS(ACCEL_Z, ADIS16400_XACCL_OFF);
 
 
-static IIO_DEV_ATTR_IN_NAMED_RAW(supply, adis16400_read_14bit_signed,
+static IIO_DEV_ATTR_IN_NAMED_RAW(0, supply, adis16400_read_14bit_signed,
 		ADIS16400_SUPPLY_OUT);
-static IIO_CONST_ATTR_IN_NAMED_SCALE(supply, "0.002418 V");
+static IIO_CONST_ATTR_IN_NAMED_SCALE(0, supply, "0.002418 V");
 
 static IIO_DEV_ATTR_GYRO_X(adis16400_read_14bit_signed,
 		ADIS16400_XGYRO_OUT);
@@ -538,9 +538,9 @@ static IIO_DEV_ATTR_TEMP_RAW(adis16400_read_12bit_signed);
 static IIO_CONST_ATTR_TEMP_OFFSET("198.16 K");
 static IIO_CONST_ATTR_TEMP_SCALE("0.14 K");
 
-static IIO_DEV_ATTR_IN_RAW(0, adis16400_read_12bit_unsigned,
+static IIO_DEV_ATTR_IN_RAW(1, adis16400_read_12bit_unsigned,
 		ADIS16400_AUX_ADC);
-static IIO_CONST_ATTR(in0_scale, "0.000806 V");
+static IIO_CONST_ATTR(in1_scale, "0.000806 V");
 
 static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
 		adis16400_read_frequency,
@@ -567,8 +567,8 @@ static struct attribute *adis16400_attributes[] = {
 	&iio_dev_attr_accel_x_calibbias.dev_attr.attr,
 	&iio_dev_attr_accel_y_calibbias.dev_attr.attr,
 	&iio_dev_attr_accel_z_calibbias.dev_attr.attr,
-	&iio_dev_attr_in_supply_raw.dev_attr.attr,
-	&iio_const_attr_in_supply_scale.dev_attr.attr,
+	&iio_dev_attr_in0_supply_raw.dev_attr.attr,
+	&iio_const_attr_in0_supply_scale.dev_attr.attr,
 	&iio_dev_attr_gyro_x_raw.dev_attr.attr,
 	&iio_dev_attr_gyro_y_raw.dev_attr.attr,
 	&iio_dev_attr_gyro_z_raw.dev_attr.attr,
@@ -584,8 +584,8 @@ static struct attribute *adis16400_attributes[] = {
 	&iio_dev_attr_temp_raw.dev_attr.attr,
 	&iio_const_attr_temp_offset.dev_attr.attr,
 	&iio_const_attr_temp_scale.dev_attr.attr,
-	&iio_dev_attr_in0_raw.dev_attr.attr,
-	&iio_const_attr_in0_scale.dev_attr.attr,
+	&iio_dev_attr_in1_raw.dev_attr.attr,
+	&iio_const_attr_in1_scale.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index 1de858c..33293fb 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -17,9 +17,9 @@
 #include "../trigger.h"
 #include "adis16400.h"
 
-static IIO_SCAN_EL_C(in_supply, ADIS16400_SCAN_SUPPLY,
+static IIO_SCAN_EL_C(in0_supply, ADIS16400_SCAN_SUPPLY,
 		     ADIS16400_SUPPLY_OUT, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(in_supply, u, 14, 16);
+static IIO_CONST_ATTR_SCAN_EL_TYPE(in0_supply, u, 14, 16);
 
 static IIO_SCAN_EL_C(gyro_x, ADIS16400_SCAN_GYRO_X, ADIS16400_XGYRO_OUT, NULL);
 static IIO_SCAN_EL_C(gyro_y, ADIS16400_SCAN_GYRO_Y, ADIS16400_YGYRO_OUT, NULL);
@@ -39,16 +39,16 @@ static IIO_CONST_ATTR_SCAN_EL_TYPE(magn, s, 14, 16);
 static IIO_SCAN_EL_C(temp, ADIS16400_SCAN_TEMP, ADIS16400_TEMP_OUT, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(temp, s, 12, 16);
 
-static IIO_SCAN_EL_C(in0, ADIS16400_SCAN_ADC_0, ADIS16400_AUX_ADC, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(in0, u, 12, 16);
+static IIO_SCAN_EL_C(in1, ADIS16400_SCAN_ADC_0, ADIS16400_AUX_ADC, NULL);
+static IIO_CONST_ATTR_SCAN_EL_TYPE(in1, u, 12, 16);
 
 static IIO_SCAN_EL_TIMESTAMP(12);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(timestamp, s, 64, 64);
 
 static struct attribute *adis16400_scan_el_attrs[] = {
-	&iio_scan_el_in_supply.dev_attr.attr,
-	&iio_const_attr_in_supply_index.dev_attr.attr,
-	&iio_const_attr_in_supply_type.dev_attr.attr,
+	&iio_scan_el_in0_supply.dev_attr.attr,
+	&iio_const_attr_in0_supply_index.dev_attr.attr,
+	&iio_const_attr_in0_supply_type.dev_attr.attr,
 	&iio_scan_el_gyro_x.dev_attr.attr,
 	&iio_const_attr_gyro_x_index.dev_attr.attr,
 	&iio_scan_el_gyro_y.dev_attr.attr,
@@ -73,9 +73,9 @@ static struct attribute *adis16400_scan_el_attrs[] = {
 	&iio_scan_el_temp.dev_attr.attr,
 	&iio_const_attr_temp_index.dev_attr.attr,
 	&iio_const_attr_temp_type.dev_attr.attr,
-	&iio_scan_el_in0.dev_attr.attr,
-	&iio_const_attr_in0_index.dev_attr.attr,
-	&iio_const_attr_in0_type.dev_attr.attr,
+	&iio_scan_el_in1.dev_attr.attr,
+	&iio_const_attr_in1_index.dev_attr.attr,
+	&iio_const_attr_in1_type.dev_attr.attr,
 	&iio_scan_el_timestamp.dev_attr.attr,
 	&iio_const_attr_timestamp_index.dev_attr.attr,
 	&iio_const_attr_timestamp_type.dev_attr.attr,
@@ -222,7 +222,7 @@ int adis16400_configure_ring(struct iio_dev *indio_dev)
 	ring->owner = THIS_MODULE;
 
 	/* Set default scan mode */
-	iio_scan_mask_set(ring, iio_scan_el_in_supply.number);
+	iio_scan_mask_set(ring, iio_scan_el_in0_supply.number);
 	iio_scan_mask_set(ring, iio_scan_el_gyro_x.number);
 	iio_scan_mask_set(ring, iio_scan_el_gyro_y.number);
 	iio_scan_mask_set(ring, iio_scan_el_gyro_z.number);
@@ -233,7 +233,7 @@ int adis16400_configure_ring(struct iio_dev *indio_dev)
 	iio_scan_mask_set(ring, iio_scan_el_magn_y.number);
 	iio_scan_mask_set(ring, iio_scan_el_magn_z.number);
 	iio_scan_mask_set(ring, iio_scan_el_temp.number);
-	iio_scan_mask_set(ring, iio_scan_el_in0.number);
+	iio_scan_mask_set(ring, iio_scan_el_in1.number);
 
 	ret = iio_alloc_pollfunc(indio_dev, NULL, &adis16400_poll_func_th);
 	if (ret)
-- 
1.7.2.2

