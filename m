Return-Path: <slm9ab33xy531iis.fraunhofer.de@bounce.antispameurope.com>
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
To: greg@kroah.com
Cc: jic23@cam.ac.uk, linux-iio@vger.kernel.org,
        Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Subject: [PATCH 5/6] staging:iio sync drivers with current ABI
Date: Tue, 31 Aug 2010 11:32:54 +0200
Message-Id: <1283247175-12835-6-git-send-email-manuel.stahl@iis.fraunhofer.de>
In-Reply-To: <1283247175-12835-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
References: <1283247175-12835-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
List-ID: <linux-iio@vger.kernel.org>


Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/accel.h          |   42 +++++++++++++++++++++---
 drivers/staging/iio/accel/adis16209_core.c |   26 +++++----------
 drivers/staging/iio/accel/adis16209_ring.c |   12 +++---
 drivers/staging/iio/accel/adis16220_core.c |   12 +++---
 drivers/staging/iio/accel/adis16240_core.c |   22 ++++++------
 drivers/staging/iio/accel/adis16240_ring.c |   12 +++---
 drivers/staging/iio/accel/inclinometer.h   |    2 +
 drivers/staging/iio/accel/lis3l02dq_core.c |    2 +-
 drivers/staging/iio/accel/sca3000_core.c   |    4 +-
 drivers/staging/iio/adc/adc.h              |    7 ++++
 drivers/staging/iio/gyro/adis16260_core.c  |   20 ++++++------
 drivers/staging/iio/gyro/adis16260_ring.c  |   12 +++---
 drivers/staging/iio/gyro/gyro.h            |   46 ++++++++++++++++++++++-----
 drivers/staging/iio/imu/adis16300_core.c   |   36 ++++++++++++---------
 drivers/staging/iio/imu/adis16300_ring.c   |   12 +++---
 drivers/staging/iio/imu/adis16350_core.c   |   44 ++++++++++++++++++--------
 drivers/staging/iio/imu/adis16350_ring.c   |   12 +++---
 drivers/staging/iio/imu/adis16400_core.c   |   47 +++++++++++++++-------------
 drivers/staging/iio/imu/adis16400_ring.c   |   12 +++---
 drivers/staging/iio/sysfs.h                |   17 ++++++++--
 20 files changed, 247 insertions(+), 152 deletions(-)

diff --git a/drivers/staging/iio/accel/accel.h b/drivers/staging/iio/accel/accel.h
index 1b6e37f..01e9302 100644
--- a/drivers/staging/iio/accel/accel.h
+++ b/drivers/staging/iio/accel/accel.h
@@ -14,14 +14,44 @@
 #define IIO_DEV_ATTR_ACCEL_Z_OFFSET(_mode, _show, _store, _addr)	\
 	IIO_DEVICE_ATTR(accel_z_offset, _mode, _show, _store, _addr)
 
-#define IIO_DEV_ATTR_ACCEL_X_GAIN(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(accel_x_gain, _mode, _show, _store, _addr)
+#define IIO_CONST_ATTR_ACCEL_SCALE(_string)		\
+	IIO_CONST_ATTR(accel_scale, _string)
 
-#define IIO_DEV_ATTR_ACCEL_Y_GAIN(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(accel_y_gain, _mode, _show, _store, _addr)
+#define IIO_DEV_ATTR_ACCEL_SCALE(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(accel_scale, _mode, _show, _store, _addr)
 
-#define IIO_DEV_ATTR_ACCEL_Z_GAIN(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(accel_z_gain, _mode, _show, _store, _addr)
+#define IIO_DEV_ATTR_ACCEL_X_SCALE(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(accel_x_scale, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_ACCEL_Y_SCALE(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(accel_y_scale, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_ACCEL_Z_SCALE(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(accel_z_scale, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_ACCEL_CALIBBIAS(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(accel_calibbias, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_ACCEL_X_CALIBBIAS(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(accel_x_calibbias, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_ACCEL_Y_CALIBBIAS(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(accel_y_calibbias, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_ACCEL_Z_CALIBBIAS(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(accel_z_calibbias, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_ACCEL_CALIBSCALE(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(accel_calibscale, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_ACCEL_X_CALIBSCALE(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(accel_x_calibscale, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_ACCEL_Y_CALIBSCALE(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(accel_y_calibscale, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_ACCEL_Z_CALIBSCALE(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(accel_z_calibscale, _mode, _show, _store, _addr)
 
 #define IIO_DEV_ATTR_ACCEL(_show, _addr)			\
 	IIO_DEVICE_ATTR(accel_raw, S_IRUGO, _show, NULL, _addr)
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index 6c6923f..bda497a 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -393,7 +393,7 @@ err_ret:
 
 static IIO_DEV_ATTR_IN_NAMED_RAW(supply, adis16209_read_14bit_unsigned,
 		ADIS16209_SUPPLY_OUT);
-static IIO_CONST_ATTR(in_supply_scale, "0.30518");
+static IIO_CONST_ATTR_IN_NAMED_SCALE(supply, "0.30518");
 static IIO_DEV_ATTR_IN_RAW(0, adis16209_read_12bit_unsigned,
 		ADIS16209_AUX_ADC);
 static IIO_CONST_ATTR(in0_scale, "0.6105");
@@ -402,11 +402,11 @@ static IIO_DEV_ATTR_ACCEL_X(adis16209_read_14bit_signed,
 		ADIS16209_XACCL_OUT);
 static IIO_DEV_ATTR_ACCEL_Y(adis16209_read_14bit_signed,
 		ADIS16209_YACCL_OUT);
-static IIO_DEV_ATTR_ACCEL_X_OFFSET(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_ACCEL_X_CALIBBIAS(S_IWUSR | S_IRUGO,
 		adis16209_read_14bit_signed,
 		adis16209_write_16bit,
 		ADIS16209_XACCL_NULL);
-static IIO_DEV_ATTR_ACCEL_Y_OFFSET(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_ACCEL_Y_CALIBBIAS(S_IWUSR | S_IRUGO,
 		adis16209_read_14bit_signed,
 		adis16209_write_16bit,
 		ADIS16209_YACCL_NULL);
@@ -416,26 +416,18 @@ static IIO_DEV_ATTR_INCLI_X(adis16209_read_14bit_signed,
 		ADIS16209_XINCL_OUT);
 static IIO_DEV_ATTR_INCLI_Y(adis16209_read_14bit_signed,
 		ADIS16209_YINCL_OUT);
-static IIO_DEV_ATTR_INCLI_X_OFFSET(S_IWUSR | S_IRUGO,
-		adis16209_read_14bit_signed,
-		adis16209_write_16bit,
-		ADIS16209_XACCL_NULL);
-static IIO_DEV_ATTR_INCLI_Y_OFFSET(S_IWUSR | S_IRUGO,
-		adis16209_read_14bit_signed,
-		adis16209_write_16bit,
-		ADIS16209_YACCL_NULL);
 static IIO_CONST_ATTR(incli_scale, "0.025");
 
 static IIO_DEVICE_ATTR(rot_raw, S_IRUGO, adis16209_read_14bit_signed,
 		       NULL, ADIS16209_ROT_OUT);
 
 static IIO_DEV_ATTR_TEMP(adis16209_read_temp);
-static IIO_CONST_ATTR(temp_offset, "25");
-static IIO_CONST_ATTR(temp_scale, "-0.47");
+static IIO_CONST_ATTR_TEMP_OFFSET("25");
+static IIO_CONST_ATTR_TEMP_SCALE("-0.47");
 
 static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16209_write_reset, 0);
 
-static IIO_CONST_ATTR(name, "adis16209");
+static IIO_CONST_ATTR_NAME("adis16209");
 
 static struct attribute *adis16209_event_attributes[] = {
 	NULL
@@ -457,13 +449,11 @@ static struct attribute *adis16209_attributes[] = {
 	&iio_const_attr_in0_scale.dev_attr.attr,
 	&iio_dev_attr_accel_x_raw.dev_attr.attr,
 	&iio_dev_attr_accel_y_raw.dev_attr.attr,
-	&iio_dev_attr_accel_x_offset.dev_attr.attr,
-	&iio_dev_attr_accel_y_offset.dev_attr.attr,
+	&iio_dev_attr_accel_x_calibbias.dev_attr.attr,
+	&iio_dev_attr_accel_y_calibbias.dev_attr.attr,
 	&iio_const_attr_accel_scale.dev_attr.attr,
 	&iio_dev_attr_incli_x_raw.dev_attr.attr,
 	&iio_dev_attr_incli_y_raw.dev_attr.attr,
-	&iio_dev_attr_incli_x_offset.dev_attr.attr,
-	&iio_dev_attr_incli_y_offset.dev_attr.attr,
 	&iio_const_attr_incli_scale.dev_attr.attr,
 	&iio_dev_attr_rot_raw.dev_attr.attr,
 	NULL
diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index 120bf91..3eb1d55 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -17,13 +17,13 @@
 #include "../trigger.h"
 #include "adis16209.h"
 
-static IIO_SCAN_EL_C(supply, ADIS16209_SCAN_SUPPLY, IIO_UNSIGNED(14),
+static IIO_SCAN_EL_C(in_supply, ADIS16209_SCAN_SUPPLY, IIO_UNSIGNED(14),
 		     ADIS16209_SUPPLY_OUT, NULL);
 static IIO_SCAN_EL_C(accel_x, ADIS16209_SCAN_ACC_X, IIO_SIGNED(14),
 		     ADIS16209_XACCL_OUT, NULL);
 static IIO_SCAN_EL_C(accel_y, ADIS16209_SCAN_ACC_Y, IIO_SIGNED(14),
 		     ADIS16209_YACCL_OUT, NULL);
-static IIO_SCAN_EL_C(aux_adc, ADIS16209_SCAN_AUX_ADC, IIO_UNSIGNED(12),
+static IIO_SCAN_EL_C(in0, ADIS16209_SCAN_AUX_ADC, IIO_UNSIGNED(12),
 		     ADIS16209_AUX_ADC, NULL);
 static IIO_SCAN_EL_C(temp, ADIS16209_SCAN_TEMP, IIO_UNSIGNED(12),
 		     ADIS16209_TEMP_OUT, NULL);
@@ -37,10 +37,10 @@ static IIO_SCAN_EL_C(rot, ADIS16209_SCAN_ROT, IIO_SIGNED(14),
 static IIO_SCAN_EL_TIMESTAMP(8);
 
 static struct attribute *adis16209_scan_el_attrs[] = {
-	&iio_scan_el_supply.dev_attr.attr,
+	&iio_scan_el_in_supply.dev_attr.attr,
 	&iio_scan_el_accel_x.dev_attr.attr,
 	&iio_scan_el_accel_y.dev_attr.attr,
-	&iio_scan_el_aux_adc.dev_attr.attr,
+	&iio_scan_el_in0.dev_attr.attr,
 	&iio_scan_el_temp.dev_attr.attr,
 	&iio_scan_el_incli_x.dev_attr.attr,
 	&iio_scan_el_incli_y.dev_attr.attr,
@@ -177,12 +177,12 @@ int adis16209_configure_ring(struct iio_dev *indio_dev)
 	ring->owner = THIS_MODULE;
 
 	/* Set default scan mode */
-	iio_scan_mask_set(ring, iio_scan_el_supply.number);
+	iio_scan_mask_set(ring, iio_scan_el_in_supply.number);
 	iio_scan_mask_set(ring, iio_scan_el_rot.number);
 	iio_scan_mask_set(ring, iio_scan_el_accel_x.number);
 	iio_scan_mask_set(ring, iio_scan_el_accel_y.number);
 	iio_scan_mask_set(ring, iio_scan_el_temp.number);
-	iio_scan_mask_set(ring, iio_scan_el_aux_adc.number);
+	iio_scan_mask_set(ring, iio_scan_el_in0.number);
 	iio_scan_mask_set(ring, iio_scan_el_incli_x.number);
 	iio_scan_mask_set(ring, iio_scan_el_incli_y.number);
 
diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
index bb7d765..edcf57d 100644
--- a/drivers/staging/iio/accel/adis16220_core.c
+++ b/drivers/staging/iio/accel/adis16220_core.c
@@ -487,7 +487,7 @@ static struct bin_attribute adc2_bin = {
 
 static IIO_DEV_ATTR_IN_NAMED_RAW(supply, adis16220_read_12bit_unsigned,
 		ADIS16220_CAPT_SUPPLY);
-static IIO_CONST_ATTR(in_supply_scale, "0.0012207");
+static IIO_CONST_ATTR_IN_NAMED_SCALE(supply, "0.0012207");
 static IIO_DEV_ATTR_ACCEL(adis16220_read_16bit, ADIS16220_CAPT_BUFA);
 static IIO_DEVICE_ATTR(accel_peak_raw, S_IRUGO, adis16220_read_16bit,
 		NULL, ADIS16220_CAPT_PEAKA);
@@ -496,8 +496,8 @@ static IIO_DEV_ATTR_ACCEL_OFFSET(S_IWUSR | S_IRUGO,
 		adis16220_write_16bit,
 		ADIS16220_ACCL_NULL);
 static IIO_DEV_ATTR_TEMP_RAW(adis16220_read_12bit_unsigned);
-static IIO_CONST_ATTR(temp_offset, "25");
-static IIO_CONST_ATTR(temp_scale, "-0.47");
+static IIO_CONST_ATTR_TEMP_OFFSET("25");
+static IIO_CONST_ATTR_TEMP_SCALE("-0.47");
 
 static IIO_DEV_ATTR_IN_RAW(0, adis16220_read_16bit, ADIS16220_CAPT_BUF1);
 static IIO_DEV_ATTR_IN_RAW(1, adis16220_read_16bit, ADIS16220_CAPT_BUF2);
@@ -518,9 +518,9 @@ static IIO_DEV_ATTR_CAPTURE_COUNT(S_IWUSR | S_IRUGO,
 		adis16220_write_16bit,
 		ADIS16220_CAPT_PNTR);
 
-static IIO_CONST_ATTR_AVAIL_SAMP_FREQ("100200");
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("100200");
 
-static IIO_CONST_ATTR(name, "adis16220");
+static IIO_CONST_ATTR_NAME("adis16220");
 
 static struct attribute *adis16220_attributes[] = {
 	&iio_dev_attr_in_supply_raw.dev_attr.attr,
@@ -533,7 +533,7 @@ static struct attribute *adis16220_attributes[] = {
 	&iio_dev_attr_in1_raw.dev_attr.attr,
 	&iio_const_attr_temp_offset.dev_attr.attr,
 	&iio_const_attr_temp_scale.dev_attr.attr,
-	&iio_const_attr_available_sampling_frequency.dev_attr.attr,
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
 	&iio_dev_attr_capture.dev_attr.attr,
 	&iio_dev_attr_capture_count.dev_attr.attr,
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index 3e9531d..4583258 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -380,7 +380,7 @@ static IIO_DEV_ATTR_IN_NAMED_RAW(supply, adis16240_read_10bit_unsigned,
 		ADIS16240_SUPPLY_OUT);
 static IIO_DEV_ATTR_IN_RAW(0, adis16240_read_10bit_signed,
 		ADIS16240_AUX_ADC);
-static IIO_CONST_ATTR(in_supply_scale, "0.00488");
+static IIO_CONST_ATTR_IN_NAMED_SCALE(supply, "0.00488");
 static IIO_DEV_ATTR_ACCEL_X(adis16240_read_10bit_signed,
 		ADIS16240_XACCL_OUT);
 static IIO_DEVICE_ATTR(accel_x_peak_raw, S_IRUGO,
@@ -400,26 +400,26 @@ static IIO_DEVICE_ATTR(accel_z_peak_raw, S_IRUGO,
 static IIO_DEVICE_ATTR(accel_xyz_squared_peak_raw, S_IRUGO,
 		       adis16240_read_12bit_signed, NULL,
 		       ADIS16240_XYZPEAK_OUT);
-static IIO_DEV_ATTR_ACCEL_X_OFFSET(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_ACCEL_X_CALIBBIAS(S_IWUSR | S_IRUGO,
 		adis16240_read_10bit_signed,
 		adis16240_write_16bit,
 		ADIS16240_XACCL_OFF);
-static IIO_DEV_ATTR_ACCEL_Y_OFFSET(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_ACCEL_Y_CALIBBIAS(S_IWUSR | S_IRUGO,
 		adis16240_read_10bit_signed,
 		adis16240_write_16bit,
 		ADIS16240_YACCL_OFF);
-static IIO_DEV_ATTR_ACCEL_Z_OFFSET(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_ACCEL_Z_CALIBBIAS(S_IWUSR | S_IRUGO,
 		adis16240_read_10bit_signed,
 		adis16240_write_16bit,
 		ADIS16240_ZACCL_OFF);
 static IIO_DEV_ATTR_TEMP_RAW(adis16240_read_10bit_unsigned);
-static IIO_CONST_ATTR(temp_scale, "0.244");
+static IIO_CONST_ATTR_TEMP_SCALE("0.244");
 
 static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16240_write_reset, 0);
 
-static IIO_CONST_ATTR_AVAIL_SAMP_FREQ("4096");
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("4096");
 
-static IIO_CONST_ATTR(name, "adis16240");
+static IIO_CONST_ATTR_NAME("adis16240");
 
 static struct attribute *adis16240_event_attributes[] = {
 	NULL
@@ -434,18 +434,18 @@ static struct attribute *adis16240_attributes[] = {
 	&iio_const_attr_in_supply_scale.dev_attr.attr,
 	&iio_dev_attr_in0_raw.dev_attr.attr,
 	&iio_dev_attr_accel_x_raw.dev_attr.attr,
-	&iio_dev_attr_accel_x_offset.dev_attr.attr,
+	&iio_dev_attr_accel_x_calibbias.dev_attr.attr,
 	&iio_dev_attr_accel_x_peak_raw.dev_attr.attr,
 	&iio_dev_attr_accel_y_raw.dev_attr.attr,
-	&iio_dev_attr_accel_y_offset.dev_attr.attr,
+	&iio_dev_attr_accel_y_calibbias.dev_attr.attr,
 	&iio_dev_attr_accel_y_peak_raw.dev_attr.attr,
 	&iio_dev_attr_accel_z_raw.dev_attr.attr,
-	&iio_dev_attr_accel_z_offset.dev_attr.attr,
+	&iio_dev_attr_accel_z_calibbias.dev_attr.attr,
 	&iio_dev_attr_accel_z_peak_raw.dev_attr.attr,
 	&iio_dev_attr_accel_xyz_squared_peak_raw.dev_attr.attr,
 	&iio_dev_attr_temp_raw.dev_attr.attr,
 	&iio_const_attr_temp_scale.dev_attr.attr,
-	&iio_const_attr_available_sampling_frequency.dev_attr.attr,
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
 	&iio_const_attr_name.dev_attr.attr,
 	NULL
diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
index 581d0e5..9282372 100644
--- a/drivers/staging/iio/accel/adis16240_ring.c
+++ b/drivers/staging/iio/accel/adis16240_ring.c
@@ -17,7 +17,7 @@
 #include "../trigger.h"
 #include "adis16240.h"
 
-static IIO_SCAN_EL_C(supply, ADIS16240_SCAN_SUPPLY, IIO_UNSIGNED(10),
+static IIO_SCAN_EL_C(in_supply, ADIS16240_SCAN_SUPPLY, IIO_UNSIGNED(10),
 		ADIS16240_SUPPLY_OUT, NULL);
 static IIO_SCAN_EL_C(accel_x, ADIS16240_SCAN_ACC_X, IIO_SIGNED(10),
 		ADIS16240_XACCL_OUT, NULL);
@@ -25,7 +25,7 @@ static IIO_SCAN_EL_C(accel_y, ADIS16240_SCAN_ACC_Y, IIO_SIGNED(10),
 		ADIS16240_YACCL_OUT, NULL);
 static IIO_SCAN_EL_C(accel_z, ADIS16240_SCAN_ACC_Z, IIO_SIGNED(10),
 		ADIS16240_ZACCL_OUT, NULL);
-static IIO_SCAN_EL_C(aux_adc, ADIS16240_SCAN_AUX_ADC, IIO_UNSIGNED(10),
+static IIO_SCAN_EL_C(in0, ADIS16240_SCAN_AUX_ADC, IIO_UNSIGNED(10),
 		ADIS16240_AUX_ADC, NULL);
 static IIO_SCAN_EL_C(temp, ADIS16240_SCAN_TEMP, IIO_UNSIGNED(10),
 		ADIS16240_TEMP_OUT, NULL);
@@ -33,11 +33,11 @@ static IIO_SCAN_EL_C(temp, ADIS16240_SCAN_TEMP, IIO_UNSIGNED(10),
 static IIO_SCAN_EL_TIMESTAMP(6);
 
 static struct attribute *adis16240_scan_el_attrs[] = {
-	&iio_scan_el_supply.dev_attr.attr,
+	&iio_scan_el_in_supply.dev_attr.attr,
 	&iio_scan_el_accel_x.dev_attr.attr,
 	&iio_scan_el_accel_y.dev_attr.attr,
 	&iio_scan_el_accel_z.dev_attr.attr,
-	&iio_scan_el_aux_adc.dev_attr.attr,
+	&iio_scan_el_in0.dev_attr.attr,
 	&iio_scan_el_temp.dev_attr.attr,
 	&iio_scan_el_timestamp.dev_attr.attr,
 	NULL,
@@ -169,12 +169,12 @@ int adis16240_configure_ring(struct iio_dev *indio_dev)
 	ring->owner = THIS_MODULE;
 
 	/* Set default scan mode */
-	iio_scan_mask_set(ring, iio_scan_el_supply.number);
+	iio_scan_mask_set(ring, iio_scan_el_in_supply.number);
 	iio_scan_mask_set(ring, iio_scan_el_accel_x.number);
 	iio_scan_mask_set(ring, iio_scan_el_accel_y.number);
 	iio_scan_mask_set(ring, iio_scan_el_accel_z.number);
 	iio_scan_mask_set(ring, iio_scan_el_temp.number);
-	iio_scan_mask_set(ring, iio_scan_el_aux_adc.number);
+	iio_scan_mask_set(ring, iio_scan_el_in0.number);
 
 	ret = iio_alloc_pollfunc(indio_dev, NULL, &adis16240_poll_func_th);
 	if (ret)
diff --git a/drivers/staging/iio/accel/inclinometer.h b/drivers/staging/iio/accel/inclinometer.h
index 5b49f83..faf73d7 100644
--- a/drivers/staging/iio/accel/inclinometer.h
+++ b/drivers/staging/iio/accel/inclinometer.h
@@ -21,3 +21,5 @@
 #define IIO_DEV_ATTR_INCLI_Z_OFFSET(_mode, _show, _store, _addr) \
 	IIO_DEVICE_ATTR(incli_z_offset, _mode, _show, _store, _addr)
 
+#define IIO_CONST_ATTR_INCLI_SCALE(_string) \
+	IIO_CONST_ATTR(incli_scale, _string)
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index 0ee9337..655f2b7 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -731,7 +731,7 @@ static struct attribute_group lis3l02dq_event_attribute_group = {
 	.attrs = lis3l02dq_event_attributes,
 };
 
-static IIO_CONST_ATTR(name, "lis3l02dq");
+static IIO_CONST_ATTR_NAME("lis3l02dq");
 static IIO_CONST_ATTR(accel_scale, "0.00958");
 
 static struct attribute *lis3l02dq_attributes[] = {
diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index b78b6b6..0eb2c4c 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -721,8 +721,8 @@ error_ret:
 }
 static IIO_DEV_ATTR_TEMP_RAW(sca3000_read_temp);
 
-static IIO_CONST_ATTR(temp_scale, "0.555556");
-static IIO_CONST_ATTR(temp_offset, "-214.6");
+static IIO_CONST_ATTR_TEMP_SCALE("0.555556");
+static IIO_CONST_ATTR_TEMP_OFFSET("-214.6");
 
 /**
  * sca3000_show_thresh() sysfs query of a threshold
diff --git a/drivers/staging/iio/adc/adc.h b/drivers/staging/iio/adc/adc.h
index 7841e6a..953b5ce 100644
--- a/drivers/staging/iio/adc/adc.h
+++ b/drivers/staging/iio/adc/adc.h
@@ -27,5 +27,12 @@
 			      NULL,					\
 			      _addr)
 
+
+#define IIO_CONST_ATTR_IN_NAMED_OFFSET(_name, _string)			\
+	IIO_CONST_ATTR(in_##_name##_offset, _string)
+
+#define IIO_CONST_ATTR_IN_NAMED_SCALE(_name, _string)			\
+	IIO_CONST_ATTR(in_##_name##_scale, _string)
+
 #define IIO_EVENT_CODE_IN_HIGH_THRESH(a) (IIO_EVENT_CODE_ADC_BASE  + a)
 #define IIO_EVENT_CODE_IN_LOW_THRESH(a) (IIO_EVENT_CODE_ADC_BASE  + a + 32)
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index 134dfaa..ac5378b 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -445,22 +445,22 @@ err_ret:
 static IIO_DEV_ATTR_IN_NAMED_RAW(supply,
 				adis16260_read_12bit_unsigned,
 				ADIS16260_SUPPLY_OUT);
-static IIO_CONST_ATTR(in_supply_scale, "0.0018315");
+static IIO_CONST_ATTR_IN_NAMED_SCALE(supply, "0.0018315");
 
 static IIO_DEV_ATTR_GYRO(adis16260_read_14bit_signed,
 		ADIS16260_GYRO_OUT);
-static IIO_DEV_ATTR_GYRO_SCALE(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_GYRO_CALIBSCALE(S_IWUSR | S_IRUGO,
 		adis16260_read_14bit_signed,
 		adis16260_write_16bit,
 		ADIS16260_GYRO_SCALE);
-static IIO_DEV_ATTR_GYRO_OFFSET(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_GYRO_CALIBBIAS(S_IWUSR | S_IRUGO,
 		adis16260_read_12bit_signed,
 		adis16260_write_16bit,
 		ADIS16260_GYRO_OFF);
 
 static IIO_DEV_ATTR_TEMP_RAW(adis16260_read_12bit_unsigned);
-static IIO_CONST_ATTR(temp_offset, "25");
-static IIO_CONST_ATTR(temp_scale, "0.1453");
+static IIO_CONST_ATTR_TEMP_OFFSET("25");
+static IIO_CONST_ATTR_TEMP_SCALE("0.1453");
 
 static IIO_DEV_ATTR_IN_RAW(0, adis16260_read_12bit_unsigned,
 		ADIS16260_AUX_ADC);
@@ -474,9 +474,9 @@ static IIO_DEV_ATTR_ANGL(adis16260_read_14bit_signed,
 
 static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16260_write_reset, 0);
 
-static IIO_CONST_ATTR_AVAIL_SAMP_FREQ("256 2048");
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("256 2048");
 
-static IIO_CONST_ATTR(name, "adis16260");
+static IIO_CONST_ATTR_NAME("adis16260");
 
 static struct attribute *adis16260_event_attributes[] = {
 	NULL
@@ -490,8 +490,8 @@ static struct attribute *adis16260_attributes[] = {
 	&iio_dev_attr_in_supply_raw.dev_attr.attr,
 	&iio_const_attr_in_supply_scale.dev_attr.attr,
 	&iio_dev_attr_gyro_raw.dev_attr.attr,
-	&iio_dev_attr_gyro_scale.dev_attr.attr,
-	&iio_dev_attr_gyro_offset.dev_attr.attr,
+	&iio_dev_attr_gyro_calibscale.dev_attr.attr,
+	&iio_dev_attr_gyro_calibbias.dev_attr.attr,
 	&iio_dev_attr_angl_raw.dev_attr.attr,
 	&iio_dev_attr_temp_raw.dev_attr.attr,
 	&iio_const_attr_temp_offset.dev_attr.attr,
@@ -499,7 +499,7 @@ static struct attribute *adis16260_attributes[] = {
 	&iio_dev_attr_in0_raw.dev_attr.attr,
 	&iio_const_attr_in0_scale.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
-	&iio_const_attr_available_sampling_frequency.dev_attr.attr,
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
 	&iio_const_attr_name.dev_attr.attr,
 	NULL
diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
index 0334860..659a672 100644
--- a/drivers/staging/iio/gyro/adis16260_ring.c
+++ b/drivers/staging/iio/gyro/adis16260_ring.c
@@ -17,11 +17,11 @@
 #include "../trigger.h"
 #include "adis16260.h"
 
-static IIO_SCAN_EL_C(supply, ADIS16260_SCAN_SUPPLY, IIO_UNSIGNED(12),
+static IIO_SCAN_EL_C(in_supply, ADIS16260_SCAN_SUPPLY, IIO_UNSIGNED(12),
 		ADIS16260_SUPPLY_OUT, NULL);
 static IIO_SCAN_EL_C(gyro, ADIS16260_SCAN_GYRO, IIO_SIGNED(14),
 		ADIS16260_GYRO_OUT, NULL);
-static IIO_SCAN_EL_C(aux_adc, ADIS16260_SCAN_AUX_ADC, IIO_SIGNED(14),
+static IIO_SCAN_EL_C(in0, ADIS16260_SCAN_AUX_ADC, IIO_SIGNED(14),
 		ADIS16260_AUX_ADC, NULL);
 static IIO_SCAN_EL_C(temp, ADIS16260_SCAN_TEMP, IIO_UNSIGNED(12),
 		ADIS16260_TEMP_OUT, NULL);
@@ -31,9 +31,9 @@ static IIO_SCAN_EL_C(angl, ADIS16260_SCAN_ANGL, IIO_UNSIGNED(12),
 static IIO_SCAN_EL_TIMESTAMP(5);
 
 static struct attribute *adis16260_scan_el_attrs[] = {
-	&iio_scan_el_supply.dev_attr.attr,
+	&iio_scan_el_in_supply.dev_attr.attr,
 	&iio_scan_el_gyro.dev_attr.attr,
-	&iio_scan_el_aux_adc.dev_attr.attr,
+	&iio_scan_el_in0.dev_attr.attr,
 	&iio_scan_el_temp.dev_attr.attr,
 	&iio_scan_el_angl.dev_attr.attr,
 	&iio_scan_el_timestamp.dev_attr.attr,
@@ -172,9 +172,9 @@ int adis16260_configure_ring(struct iio_dev *indio_dev)
 	ring->owner = THIS_MODULE;
 
 	/* Set default scan mode */
-	iio_scan_mask_set(ring, iio_scan_el_supply.number);
+	iio_scan_mask_set(ring, iio_scan_el_in_supply.number);
 	iio_scan_mask_set(ring, iio_scan_el_gyro.number);
-	iio_scan_mask_set(ring, iio_scan_el_aux_adc.number);
+	iio_scan_mask_set(ring, iio_scan_el_in0.number);
 	iio_scan_mask_set(ring, iio_scan_el_temp.number);
 	iio_scan_mask_set(ring, iio_scan_el_angl.number);
 
diff --git a/drivers/staging/iio/gyro/gyro.h b/drivers/staging/iio/gyro/gyro.h
index f68edab..98b837b 100644
--- a/drivers/staging/iio/gyro/gyro.h
+++ b/drivers/staging/iio/gyro/gyro.h
@@ -3,6 +3,9 @@
 
 /* Gyroscope types of attribute */
 
+#define IIO_CONST_ATTR_GYRO_OFFSET(_string)	\
+	IIO_CONST_ATTR(gyro_offset, _string)
+
 #define IIO_DEV_ATTR_GYRO_OFFSET(_mode, _show, _store, _addr)	\
 	IIO_DEVICE_ATTR(gyro_offset, _mode, _show, _store, _addr)
 
@@ -15,18 +18,45 @@
 #define IIO_DEV_ATTR_GYRO_Z_OFFSET(_mode, _show, _store, _addr)	\
 	IIO_DEVICE_ATTR(gyro_z_offset, _mode, _show, _store, _addr)
 
-#define IIO_DEV_ATTR_GYRO_X_GAIN(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(gyro_x_gain, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_GYRO_Y_GAIN(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(gyro_y_gain, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_GYRO_Z_GAIN(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(gyro_z_gain, _mode, _show, _store, _addr)
+#define IIO_CONST_ATTR_GYRO_SCALE(_string)		\
+	IIO_CONST_ATTR(gyro_scale, _string)
 
 #define IIO_DEV_ATTR_GYRO_SCALE(_mode, _show, _store, _addr)		\
 	IIO_DEVICE_ATTR(gyro_scale, S_IRUGO, _show, _store, _addr)
 
+#define IIO_DEV_ATTR_GYRO_X_SCALE(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(gyro_x_scale, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_GYRO_Y_SCALE(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(gyro_y_scale, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_GYRO_Z_SCALE(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(gyro_z_scale, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_GYRO_CALIBBIAS(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(gyro_calibbias, S_IRUGO, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_GYRO_X_CALIBBIAS(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(gyro_x_calibbias, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_GYRO_Y_CALIBBIAS(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(gyro_y_calibbias, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_GYRO_Z_CALIBBIAS(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(gyro_z_calibbias, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_GYRO_CALIBSCALE(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(gyro_calibscale, S_IRUGO, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_GYRO_X_CALIBSCALE(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(gyro_x_calibscale, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_GYRO_Y_CALIBSCALE(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(gyro_y_calibscale, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_GYRO_Z_CALIBSCALE(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(gyro_z_calibscale, _mode, _show, _store, _addr)
+
 #define IIO_DEV_ATTR_GYRO(_show, _addr)			\
 	IIO_DEVICE_ATTR(gyro_raw, S_IRUGO, _show, NULL, _addr)
 
diff --git a/drivers/staging/iio/imu/adis16300_core.c b/drivers/staging/iio/imu/adis16300_core.c
index f1950d5..168e8b3 100644
--- a/drivers/staging/iio/imu/adis16300_core.c
+++ b/drivers/staging/iio/imu/adis16300_core.c
@@ -503,28 +503,33 @@ err_ret:
 	return ret;
 }
 
-static IIO_DEV_ATTR_ACCEL_X_OFFSET(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_GYRO_X_CALIBBIAS(S_IWUSR | S_IRUGO,
+		adis16300_read_12bit_signed,
+		adis16300_write_16bit,
+		ADIS16300_XGYRO_OFF);
+
+static IIO_DEV_ATTR_ACCEL_X_CALIBBIAS(S_IWUSR | S_IRUGO,
 		adis16300_read_12bit_signed,
 		adis16300_write_16bit,
 		ADIS16300_XACCL_OFF);
 
-static IIO_DEV_ATTR_ACCEL_Y_OFFSET(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_ACCEL_Y_CALIBBIAS(S_IWUSR | S_IRUGO,
 		adis16300_read_12bit_signed,
 		adis16300_write_16bit,
 		ADIS16300_YACCL_OFF);
 
-static IIO_DEV_ATTR_ACCEL_Z_OFFSET(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_ACCEL_Z_CALIBBIAS(S_IWUSR | S_IRUGO,
 		adis16300_read_12bit_signed,
 		adis16300_write_16bit,
 		ADIS16300_ZACCL_OFF);
 
 static IIO_DEV_ATTR_IN_NAMED_RAW(supply, adis16300_read_14bit_unsigned,
 			   ADIS16300_SUPPLY_OUT);
-static IIO_CONST_ATTR(in_supply_scale, "0.00242");
+static IIO_CONST_ATTR_IN_NAMED_SCALE(supply, "0.00242");
 
 static IIO_DEV_ATTR_GYRO_X(adis16300_read_14bit_signed,
 		ADIS16300_XGYRO_OUT);
-static IIO_CONST_ATTR(gyro_scale, "0.05 deg/s");
+static IIO_CONST_ATTR_GYRO_SCALE("0.05 deg/s");
 
 static IIO_DEV_ATTR_ACCEL_X(adis16300_read_14bit_signed,
 		ADIS16300_XACCL_OUT);
@@ -532,17 +537,17 @@ static IIO_DEV_ATTR_ACCEL_Y(adis16300_read_14bit_signed,
 		ADIS16300_YACCL_OUT);
 static IIO_DEV_ATTR_ACCEL_Z(adis16300_read_14bit_signed,
 		ADIS16300_ZACCL_OUT);
-static IIO_CONST_ATTR(accel_scale, "0.0006 g");
+static IIO_CONST_ATTR_ACCEL_SCALE("0.0006 g");
 
 static IIO_DEV_ATTR_INCLI_X(adis16300_read_13bit_signed,
 		ADIS16300_XINCLI_OUT);
 static IIO_DEV_ATTR_INCLI_Y(adis16300_read_13bit_signed,
 		ADIS16300_YINCLI_OUT);
-static IIO_CONST_ATTR(incli_scale, "0.044 d");
+static IIO_CONST_ATTR_INCLI_SCALE("0.044 deg");
 
 static IIO_DEV_ATTR_TEMP_RAW(adis16300_read_12bit_unsigned);
-static IIO_CONST_ATTR(temp_offset, "198.16 K");
-static IIO_CONST_ATTR(temp_scale, "0.14 K");
+static IIO_CONST_ATTR_TEMP_OFFSET("198.16 K");
+static IIO_CONST_ATTR_TEMP_SCALE("0.14 K");
 
 static IIO_DEV_ATTR_IN_RAW(0, adis16300_read_12bit_unsigned,
 		ADIS16300_AUX_ADC);
@@ -554,9 +559,9 @@ static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
 
 static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16300_write_reset, 0);
 
-static IIO_CONST_ATTR_AVAIL_SAMP_FREQ("409 546 819 1638");
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("409 546 819 1638");
 
-static IIO_CONST_ATTR(name, "adis16300");
+static IIO_CONST_ATTR_NAME("adis16300");
 
 static struct attribute *adis16300_event_attributes[] = {
 	NULL
@@ -567,9 +572,10 @@ static struct attribute_group adis16300_event_attribute_group = {
 };
 
 static struct attribute *adis16300_attributes[] = {
-	&iio_dev_attr_accel_x_offset.dev_attr.attr,
-	&iio_dev_attr_accel_y_offset.dev_attr.attr,
-	&iio_dev_attr_accel_z_offset.dev_attr.attr,
+	&iio_dev_attr_gyro_x_calibbias.dev_attr.attr,
+	&iio_dev_attr_accel_x_calibbias.dev_attr.attr,
+	&iio_dev_attr_accel_y_calibbias.dev_attr.attr,
+	&iio_dev_attr_accel_z_calibbias.dev_attr.attr,
 	&iio_dev_attr_in_supply_raw.dev_attr.attr,
 	&iio_const_attr_in_supply_scale.dev_attr.attr,
 	&iio_dev_attr_gyro_x_raw.dev_attr.attr,
@@ -587,7 +593,7 @@ static struct attribute *adis16300_attributes[] = {
 	&iio_dev_attr_in0_raw.dev_attr.attr,
 	&iio_const_attr_in0_scale.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
-	&iio_const_attr_available_sampling_frequency.dev_attr.attr,
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
 	&iio_const_attr_name.dev_attr.attr,
 	NULL
diff --git a/drivers/staging/iio/imu/adis16300_ring.c b/drivers/staging/iio/imu/adis16300_ring.c
index 742cad6..0e09051 100644
--- a/drivers/staging/iio/imu/adis16300_ring.c
+++ b/drivers/staging/iio/imu/adis16300_ring.c
@@ -17,7 +17,7 @@
 #include "../trigger.h"
 #include "adis16300.h"
 
-static IIO_SCAN_EL_C(supply, ADIS16300_SCAN_SUPPLY, IIO_UNSIGNED(14),
+static IIO_SCAN_EL_C(in_supply, ADIS16300_SCAN_SUPPLY, IIO_UNSIGNED(14),
 		     ADIS16300_SUPPLY_OUT, NULL);
 
 static IIO_SCAN_EL_C(gyro_x, ADIS16300_SCAN_GYRO_X, IIO_SIGNED(14),
@@ -32,7 +32,7 @@ static IIO_SCAN_EL_C(accel_z, ADIS16300_SCAN_ACC_Z, IIO_SIGNED(14),
 
 static IIO_SCAN_EL_C(temp, ADIS16300_SCAN_TEMP, IIO_UNSIGNED(12),
 		     ADIS16300_TEMP_OUT, NULL);
-static IIO_SCAN_EL_C(adc_0, ADIS16300_SCAN_ADC_0, IIO_UNSIGNED(12),
+static IIO_SCAN_EL_C(in0, ADIS16300_SCAN_ADC_0, IIO_UNSIGNED(12),
 		     ADIS16300_AUX_ADC, NULL);
 
 static IIO_SCAN_EL_C(incli_x, ADIS16300_SCAN_INCLI_X, IIO_SIGNED(12),
@@ -43,7 +43,7 @@ static IIO_SCAN_EL_C(incli_y, ADIS16300_SCAN_INCLI_Y, IIO_SIGNED(12),
 static IIO_SCAN_EL_TIMESTAMP(9);
 
 static struct attribute *adis16300_scan_el_attrs[] = {
-	&iio_scan_el_supply.dev_attr.attr,
+	&iio_scan_el_in_supply.dev_attr.attr,
 	&iio_scan_el_gyro_x.dev_attr.attr,
 	&iio_scan_el_temp.dev_attr.attr,
 	&iio_scan_el_accel_x.dev_attr.attr,
@@ -51,7 +51,7 @@ static struct attribute *adis16300_scan_el_attrs[] = {
 	&iio_scan_el_accel_z.dev_attr.attr,
 	&iio_scan_el_incli_x.dev_attr.attr,
 	&iio_scan_el_incli_y.dev_attr.attr,
-	&iio_scan_el_adc_0.dev_attr.attr,
+	&iio_scan_el_in0.dev_attr.attr,
 	&iio_scan_el_timestamp.dev_attr.attr,
 	NULL,
 };
@@ -196,13 +196,13 @@ int adis16300_configure_ring(struct iio_dev *indio_dev)
 	ring->owner = THIS_MODULE;
 
 	/* Set default scan mode */
-	iio_scan_mask_set(ring, iio_scan_el_supply.number);
+	iio_scan_mask_set(ring, iio_scan_el_in_supply.number);
 	iio_scan_mask_set(ring, iio_scan_el_gyro_x.number);
 	iio_scan_mask_set(ring, iio_scan_el_accel_x.number);
 	iio_scan_mask_set(ring, iio_scan_el_accel_y.number);
 	iio_scan_mask_set(ring, iio_scan_el_accel_z.number);
 	iio_scan_mask_set(ring, iio_scan_el_temp.number);
-	iio_scan_mask_set(ring, iio_scan_el_adc_0.number);
+	iio_scan_mask_set(ring, iio_scan_el_in0.number);
 	iio_scan_mask_set(ring, iio_scan_el_incli_x.number);
 	iio_scan_mask_set(ring, iio_scan_el_incli_y.number);
 
diff --git a/drivers/staging/iio/imu/adis16350_core.c b/drivers/staging/iio/imu/adis16350_core.c
index 1575b7b..d1f1015 100644
--- a/drivers/staging/iio/imu/adis16350_core.c
+++ b/drivers/staging/iio/imu/adis16350_core.c
@@ -475,24 +475,39 @@ err_ret:
 	return ret;
 }
 
-static IIO_DEV_ATTR_ACCEL_X_OFFSET(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_GYRO_X_CALIBBIAS(S_IWUSR | S_IRUGO,
+		adis16350_read_12bit_signed,
+		adis16350_write_16bit,
+		ADIS16350_XGYRO_OFF);
+
+static IIO_DEV_ATTR_GYRO_Y_CALIBBIAS(S_IWUSR | S_IRUGO,
+		adis16350_read_12bit_signed,
+		adis16350_write_16bit,
+		ADIS16350_YGYRO_OFF);
+
+static IIO_DEV_ATTR_GYRO_Z_CALIBBIAS(S_IWUSR | S_IRUGO,
+		adis16350_read_12bit_signed,
+		adis16350_write_16bit,
+		ADIS16350_ZGYRO_OFF);
+
+static IIO_DEV_ATTR_ACCEL_X_CALIBBIAS(S_IWUSR | S_IRUGO,
 		adis16350_read_12bit_signed,
 		adis16350_write_16bit,
 		ADIS16350_XACCL_OFF);
 
-static IIO_DEV_ATTR_ACCEL_Y_OFFSET(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_ACCEL_Y_CALIBBIAS(S_IWUSR | S_IRUGO,
 		adis16350_read_12bit_signed,
 		adis16350_write_16bit,
 		ADIS16350_YACCL_OFF);
 
-static IIO_DEV_ATTR_ACCEL_Z_OFFSET(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_ACCEL_Z_CALIBBIAS(S_IWUSR | S_IRUGO,
 		adis16350_read_12bit_signed,
 		adis16350_write_16bit,
 		ADIS16350_ZACCL_OFF);
 
 static IIO_DEV_ATTR_IN_NAMED_RAW(supply, adis16350_read_12bit_unsigned,
 		ADIS16350_SUPPLY_OUT);
-static IIO_CONST_ATTR(in_supply_scale, "0.002418");
+static IIO_CONST_ATTR_IN_NAMED_SCALE(supply, "0.002418");
 
 static IIO_DEV_ATTR_GYRO_X(adis16350_read_14bit_signed,
 		ADIS16350_XGYRO_OUT);
@@ -500,7 +515,7 @@ static IIO_DEV_ATTR_GYRO_Y(adis16350_read_14bit_signed,
 		ADIS16350_YGYRO_OUT);
 static IIO_DEV_ATTR_GYRO_Z(adis16350_read_14bit_signed,
 		ADIS16350_ZGYRO_OUT);
-static IIO_CONST_ATTR(gyro_scale, "0.05");
+static IIO_CONST_ATTR_GYRO_SCALE("0.05");
 
 static IIO_DEV_ATTR_ACCEL_X(adis16350_read_14bit_signed,
 		ADIS16350_XACCL_OUT);
@@ -508,7 +523,7 @@ static IIO_DEV_ATTR_ACCEL_Y(adis16350_read_14bit_signed,
 		ADIS16350_YACCL_OUT);
 static IIO_DEV_ATTR_ACCEL_Z(adis16350_read_14bit_signed,
 		ADIS16350_ZACCL_OUT);
-static IIO_CONST_ATTR(accel_scale, "0.00333");
+static IIO_CONST_ATTR_ACCEL_SCALE("0.00333");
 
 static IIO_DEVICE_ATTR(temp_x_raw, S_IRUGO, adis16350_read_12bit_signed,
 		NULL, ADIS16350_XTEMP_OUT);
@@ -516,7 +531,7 @@ static IIO_DEVICE_ATTR(temp_y_raw, S_IRUGO, adis16350_read_12bit_signed,
 		NULL, ADIS16350_YTEMP_OUT);
 static IIO_DEVICE_ATTR(temp_z_raw, S_IRUGO, adis16350_read_12bit_signed,
 		NULL, ADIS16350_ZTEMP_OUT);
-static IIO_CONST_ATTR(temp_scale, "0.0005");
+static IIO_CONST_ATTR_TEMP_SCALE("0.0005");
 
 static IIO_DEV_ATTR_IN_RAW(0, adis16350_read_12bit_unsigned,
 		ADIS16350_AUX_ADC);
@@ -529,14 +544,17 @@ static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
 static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL,
 		adis16350_write_reset, 0);
 
-static IIO_CONST_ATTR_AVAIL_SAMP_FREQ("409 546 819 1638");
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("409 546 819 1638");
 
-static IIO_CONST_ATTR(name, "adis16350");
+static IIO_CONST_ATTR_NAME("adis16350");
 
 static struct attribute *adis16350_attributes[] = {
-	&iio_dev_attr_accel_x_offset.dev_attr.attr,
-	&iio_dev_attr_accel_y_offset.dev_attr.attr,
-	&iio_dev_attr_accel_z_offset.dev_attr.attr,
+	&iio_dev_attr_gyro_x_calibbias.dev_attr.attr,
+	&iio_dev_attr_gyro_y_calibbias.dev_attr.attr,
+	&iio_dev_attr_gyro_z_calibbias.dev_attr.attr,
+	&iio_dev_attr_accel_x_calibbias.dev_attr.attr,
+	&iio_dev_attr_accel_y_calibbias.dev_attr.attr,
+	&iio_dev_attr_accel_z_calibbias.dev_attr.attr,
 	&iio_dev_attr_in_supply_raw.dev_attr.attr,
 	&iio_const_attr_in_supply_scale.dev_attr.attr,
 	&iio_dev_attr_gyro_x_raw.dev_attr.attr,
@@ -554,7 +572,7 @@ static struct attribute *adis16350_attributes[] = {
 	&iio_dev_attr_in0_raw.dev_attr.attr,
 	&iio_const_attr_in0_scale.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
-	&iio_const_attr_available_sampling_frequency.dev_attr.attr,
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
 	&iio_const_attr_name.dev_attr.attr,
 	NULL
diff --git a/drivers/staging/iio/imu/adis16350_ring.c b/drivers/staging/iio/imu/adis16350_ring.c
index a0b80e4..aefbae5 100644
--- a/drivers/staging/iio/imu/adis16350_ring.c
+++ b/drivers/staging/iio/imu/adis16350_ring.c
@@ -17,7 +17,7 @@
 #include "../trigger.h"
 #include "adis16350.h"
 
-static IIO_SCAN_EL_C(supply, ADIS16350_SCAN_SUPPLY, IIO_UNSIGNED(12),
+static IIO_SCAN_EL_C(in_supply, ADIS16350_SCAN_SUPPLY, IIO_UNSIGNED(12),
 		ADIS16350_SUPPLY_OUT, NULL);
 
 static IIO_SCAN_EL_C(gyro_x, ADIS16350_SCAN_GYRO_X, IIO_SIGNED(14),
@@ -41,13 +41,13 @@ static IIO_SCAN_EL_C(temp_y, ADIS16350_SCAN_TEMP_Y, IIO_SIGNED(12),
 static IIO_SCAN_EL_C(temp_z, ADIS16350_SCAN_TEMP_Z, IIO_SIGNED(12),
 		ADIS16350_ZTEMP_OUT, NULL);
 
-static IIO_SCAN_EL_C(adc_0, ADIS16350_SCAN_ADC_0, IIO_UNSIGNED(12),
+static IIO_SCAN_EL_C(in0, ADIS16350_SCAN_ADC_0, IIO_UNSIGNED(12),
 		ADIS16350_AUX_ADC, NULL);
 
 static IIO_SCAN_EL_TIMESTAMP(11);
 
 static struct attribute *adis16350_scan_el_attrs[] = {
-	&iio_scan_el_supply.dev_attr.attr,
+	&iio_scan_el_in_supply.dev_attr.attr,
 	&iio_scan_el_gyro_x.dev_attr.attr,
 	&iio_scan_el_gyro_y.dev_attr.attr,
 	&iio_scan_el_gyro_z.dev_attr.attr,
@@ -57,7 +57,7 @@ static struct attribute *adis16350_scan_el_attrs[] = {
 	&iio_scan_el_temp_x.dev_attr.attr,
 	&iio_scan_el_temp_y.dev_attr.attr,
 	&iio_scan_el_temp_z.dev_attr.attr,
-	&iio_scan_el_adc_0.dev_attr.attr,
+	&iio_scan_el_in0.dev_attr.attr,
 	&iio_scan_el_timestamp.dev_attr.attr,
 	NULL,
 };
@@ -196,7 +196,7 @@ int adis16350_configure_ring(struct iio_dev *indio_dev)
 	ring->owner = THIS_MODULE;
 
 	/* Set default scan mode */
-	iio_scan_mask_set(ring, iio_scan_el_supply.number);
+	iio_scan_mask_set(ring, iio_scan_el_in_supply.number);
 	iio_scan_mask_set(ring, iio_scan_el_gyro_x.number);
 	iio_scan_mask_set(ring, iio_scan_el_gyro_y.number);
 	iio_scan_mask_set(ring, iio_scan_el_gyro_z.number);
@@ -206,7 +206,7 @@ int adis16350_configure_ring(struct iio_dev *indio_dev)
 	iio_scan_mask_set(ring, iio_scan_el_temp_x.number);
 	iio_scan_mask_set(ring, iio_scan_el_temp_y.number);
 	iio_scan_mask_set(ring, iio_scan_el_temp_z.number);
-	iio_scan_mask_set(ring, iio_scan_el_adc_0.number);
+	iio_scan_mask_set(ring, iio_scan_el_in0.number);
 
 	ret = iio_alloc_pollfunc(indio_dev, NULL, &adis16350_poll_func_th);
 	if (ret)
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 6013fee..1765fef 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -490,24 +490,24 @@ err_ret:
 	return ret;
 }
 
-static IIO_DEV_ATTR_ACCEL_X_OFFSET(S_IWUSR | S_IRUGO,
-		adis16400_read_12bit_signed,
-		adis16400_write_16bit,
-		ADIS16400_XACCL_OFF);
+#define ADIS16400_DEV_ATTR_CALIBBIAS(_channel, _reg)		\
+	IIO_DEV_ATTR_##_channel##_CALIBBIAS(S_IWUSR | S_IRUGO,	\
+			adis16400_read_12bit_signed,		\
+			adis16400_write_16bit,			\
+			_reg)
 
-static IIO_DEV_ATTR_ACCEL_Y_OFFSET(S_IWUSR | S_IRUGO,
-		adis16400_read_12bit_signed,
-		adis16400_write_16bit,
-		ADIS16400_YACCL_OFF);
+static ADIS16400_DEV_ATTR_CALIBBIAS(GYRO_X, ADIS16400_XGYRO_OFF);
+static ADIS16400_DEV_ATTR_CALIBBIAS(GYRO_Y, ADIS16400_XGYRO_OFF);
+static ADIS16400_DEV_ATTR_CALIBBIAS(GYRO_Z, ADIS16400_XGYRO_OFF);
+
+static ADIS16400_DEV_ATTR_CALIBBIAS(ACCEL_X, ADIS16400_XACCL_OFF);
+static ADIS16400_DEV_ATTR_CALIBBIAS(ACCEL_Y, ADIS16400_XACCL_OFF);
+static ADIS16400_DEV_ATTR_CALIBBIAS(ACCEL_Z, ADIS16400_XACCL_OFF);
 
-static IIO_DEV_ATTR_ACCEL_Z_OFFSET(S_IWUSR | S_IRUGO,
-		adis16400_read_12bit_signed,
-		adis16400_write_16bit,
-		ADIS16400_ZACCL_OFF);
 
 static IIO_DEV_ATTR_IN_NAMED_RAW(supply, adis16400_read_14bit_signed,
 		ADIS16400_SUPPLY_OUT);
-static IIO_CONST_ATTR(in_supply_scale, "0.002418");
+static IIO_CONST_ATTR_IN_NAMED_SCALE(supply, "0.002418 V");
 
 static IIO_DEV_ATTR_GYRO_X(adis16400_read_14bit_signed,
 		ADIS16400_XGYRO_OUT);
@@ -535,12 +535,12 @@ static IIO_CONST_ATTR(magn_scale, "0.0005 Gs");
 
 
 static IIO_DEV_ATTR_TEMP_RAW(adis16400_read_12bit_signed);
-static IIO_CONST_ATTR(temp_offset, "198.16 K");
-static IIO_CONST_ATTR(temp_scale, "0.14 K");
+static IIO_CONST_ATTR_TEMP_OFFSET("198.16 K");
+static IIO_CONST_ATTR_TEMP_SCALE("0.14 K");
 
 static IIO_DEV_ATTR_IN_RAW(0, adis16400_read_12bit_unsigned,
 		ADIS16400_AUX_ADC);
-static IIO_CONST_ATTR(in0_scale, "0.000806");
+static IIO_CONST_ATTR(in0_scale, "0.000806 V");
 
 static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
 		adis16400_read_frequency,
@@ -548,9 +548,9 @@ static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
 
 static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16400_write_reset, 0);
 
-static IIO_CONST_ATTR_AVAIL_SAMP_FREQ("409 546 819 1638");
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("409 546 819 1638");
 
-static IIO_CONST_ATTR(name, "adis16400");
+static IIO_CONST_ATTR_NAME("adis16400");
 
 static struct attribute *adis16400_event_attributes[] = {
 	NULL
@@ -561,9 +561,12 @@ static struct attribute_group adis16400_event_attribute_group = {
 };
 
 static struct attribute *adis16400_attributes[] = {
-	&iio_dev_attr_accel_x_offset.dev_attr.attr,
-	&iio_dev_attr_accel_y_offset.dev_attr.attr,
-	&iio_dev_attr_accel_z_offset.dev_attr.attr,
+	&iio_dev_attr_gyro_x_calibbias.dev_attr.attr,
+	&iio_dev_attr_gyro_y_calibbias.dev_attr.attr,
+	&iio_dev_attr_gyro_z_calibbias.dev_attr.attr,
+	&iio_dev_attr_accel_x_calibbias.dev_attr.attr,
+	&iio_dev_attr_accel_y_calibbias.dev_attr.attr,
+	&iio_dev_attr_accel_z_calibbias.dev_attr.attr,
 	&iio_dev_attr_in_supply_raw.dev_attr.attr,
 	&iio_const_attr_in_supply_scale.dev_attr.attr,
 	&iio_dev_attr_gyro_x_raw.dev_attr.attr,
@@ -584,7 +587,7 @@ static struct attribute *adis16400_attributes[] = {
 	&iio_dev_attr_in0_raw.dev_attr.attr,
 	&iio_const_attr_in0_scale.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
-	&iio_const_attr_available_sampling_frequency.dev_attr.attr,
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
 	&iio_const_attr_name.dev_attr.attr,
 	NULL
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index 667f77b..de5ef5c 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -17,7 +17,7 @@
 #include "../trigger.h"
 #include "adis16400.h"
 
-static IIO_SCAN_EL_C(supply, ADIS16400_SCAN_SUPPLY, IIO_SIGNED(14),
+static IIO_SCAN_EL_C(in_supply, ADIS16400_SCAN_SUPPLY, IIO_SIGNED(14),
 		     ADIS16400_SUPPLY_OUT, NULL);
 
 static IIO_SCAN_EL_C(gyro_x, ADIS16400_SCAN_GYRO_X, IIO_SIGNED(14),
@@ -43,13 +43,13 @@ static IIO_SCAN_EL_C(magn_z, ADIS16400_SCAN_MAGN_Z, IIO_SIGNED(14),
 
 static IIO_SCAN_EL_C(temp, ADIS16400_SCAN_TEMP, IIO_SIGNED(12),
 		     ADIS16400_TEMP_OUT, NULL);
-static IIO_SCAN_EL_C(adc_0, ADIS16400_SCAN_ADC_0, IIO_SIGNED(12),
+static IIO_SCAN_EL_C(in0, ADIS16400_SCAN_ADC_0, IIO_SIGNED(12),
 		     ADIS16400_AUX_ADC, NULL);
 
 static IIO_SCAN_EL_TIMESTAMP(12);
 
 static struct attribute *adis16400_scan_el_attrs[] = {
-	&iio_scan_el_supply.dev_attr.attr,
+	&iio_scan_el_in_supply.dev_attr.attr,
 	&iio_scan_el_gyro_x.dev_attr.attr,
 	&iio_scan_el_gyro_y.dev_attr.attr,
 	&iio_scan_el_gyro_z.dev_attr.attr,
@@ -60,7 +60,7 @@ static struct attribute *adis16400_scan_el_attrs[] = {
 	&iio_scan_el_magn_y.dev_attr.attr,
 	&iio_scan_el_magn_z.dev_attr.attr,
 	&iio_scan_el_temp.dev_attr.attr,
-	&iio_scan_el_adc_0.dev_attr.attr,
+	&iio_scan_el_in0.dev_attr.attr,
 	&iio_scan_el_timestamp.dev_attr.attr,
 	NULL,
 };
@@ -205,7 +205,7 @@ int adis16400_configure_ring(struct iio_dev *indio_dev)
 	ring->owner = THIS_MODULE;
 
 	/* Set default scan mode */
-	iio_scan_mask_set(ring, iio_scan_el_supply.number);
+	iio_scan_mask_set(ring, iio_scan_el_in_supply.number);
 	iio_scan_mask_set(ring, iio_scan_el_gyro_x.number);
 	iio_scan_mask_set(ring, iio_scan_el_gyro_y.number);
 	iio_scan_mask_set(ring, iio_scan_el_gyro_z.number);
@@ -216,7 +216,7 @@ int adis16400_configure_ring(struct iio_dev *indio_dev)
 	iio_scan_mask_set(ring, iio_scan_el_magn_y.number);
 	iio_scan_mask_set(ring, iio_scan_el_magn_z.number);
 	iio_scan_mask_set(ring, iio_scan_el_temp.number);
-	iio_scan_mask_set(ring, iio_scan_el_adc_0.number);
+	iio_scan_mask_set(ring, iio_scan_el_in0.number);
 
 	ret = iio_alloc_pollfunc(indio_dev, NULL, &adis16400_poll_func_th);
 	if (ret)
diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index 6083416..a4d4bb6 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -130,6 +130,13 @@ struct iio_const_attr {
 	IIO_DEVICE_ATTR(name, S_IRUGO, _show, NULL, 0)
 
 /**
+ * IIO_CONST_ATTR_NAME - constant identifier
+ * @_string: the name
+ **/
+#define IIO_CONST_ATTR_NAME(_string)				\
+	IIO_CONST_ATTR(name, _string)
+
+/**
  * IIO_DEV_ATTR_SAMP_FREQ - sets any internal clock frequency
  * @_mode: sysfs file mode/permissions
  * @_show: output method for the attribute
@@ -156,10 +163,6 @@ struct iio_const_attr {
  *
  * Constant version
  **/
-/* Deprecated */
-#define IIO_CONST_ATTR_AVAIL_SAMP_FREQ(_string)			\
-	IIO_CONST_ATTR(available_sampling_frequency, _string)
-
 #define IIO_CONST_ATTR_SAMP_FREQ_AVAIL(_string)			\
 	IIO_CONST_ATTR(sampling_frequency_available, _string)
 
@@ -244,6 +247,12 @@ struct iio_const_attr {
 #define IIO_DEV_ATTR_TEMP_RAW(_show)			\
 	IIO_DEVICE_ATTR(temp_raw, S_IRUGO, _show, NULL, 0)
 
+#define IIO_CONST_ATTR_TEMP_OFFSET(_string)		\
+	IIO_CONST_ATTR(temp_offset, _string)
+
+#define IIO_CONST_ATTR_TEMP_SCALE(_string)		\
+	IIO_CONST_ATTR(temp_scale, _string)
+
 /**
  * IIO_EVENT_SH - generic shared event handler
  * @_name: event name
-- 
1.7.0.6
