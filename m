Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: gregkh@suse.de
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 08/12] staging:iio: Fix scan_element naming issue
Date: Sun, 11 Jul 2010 16:39:15 +0100
Message-Id: <1278862759-19028-9-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1278862759-19028-1-git-send-email-jic23@cam.ac.uk>
References: <1278862759-19028-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

The addition of a number to the scan_element names caused
an issue in drivers that used either #define or an enum
to provide the number. Before this fix names like
ADIS16350_ACCEL_X_accel_x_en occur rather than 5_accel_x_en.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16209.h |   19 +++++++++----------
 drivers/staging/iio/accel/adis16240.h |   14 ++++++--------
 drivers/staging/iio/gyro/adis16260.h  |   12 +++++-------
 drivers/staging/iio/imu/adis16300.h   |   20 +++++++++-----------
 drivers/staging/iio/imu/adis16350.h   |   24 +++++++++++-------------
 drivers/staging/iio/imu/adis16400.h   |   26 ++++++++++++--------------
 drivers/staging/iio/ring_generic.h    |   10 +++++++---
 7 files changed, 59 insertions(+), 66 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209.h b/drivers/staging/iio/accel/adis16209.h
index 92daf6f..4e97596 100644
--- a/drivers/staging/iio/accel/adis16209.h
+++ b/drivers/staging/iio/accel/adis16209.h
@@ -126,16 +126,15 @@ struct adis16209_state {
 int adis16209_set_irq(struct device *dev, bool enable);
 
 #ifdef CONFIG_IIO_RING_BUFFER
-enum adis16209_scan {
-	ADIS16209_SCAN_SUPPLY,
-	ADIS16209_SCAN_ACC_X,
-	ADIS16209_SCAN_ACC_Y,
-	ADIS16209_SCAN_AUX_ADC,
-	ADIS16209_SCAN_TEMP,
-	ADIS16209_SCAN_INCLI_X,
-	ADIS16209_SCAN_INCLI_Y,
-	ADIS16209_SCAN_ROT,
-};
+
+#define ADIS16209_SCAN_SUPPLY	0
+#define ADIS16209_SCAN_ACC_X	1
+#define ADIS16209_SCAN_ACC_Y	2
+#define ADIS16209_SCAN_AUX_ADC	3
+#define ADIS16209_SCAN_TEMP	4
+#define ADIS16209_SCAN_INCLI_X	5
+#define ADIS16209_SCAN_INCLI_Y	6
+#define ADIS16209_SCAN_ROT	7
 
 void adis16209_remove_trigger(struct iio_dev *indio_dev);
 int adis16209_probe_trigger(struct iio_dev *indio_dev);
diff --git a/drivers/staging/iio/accel/adis16240.h b/drivers/staging/iio/accel/adis16240.h
index e45419a..51a807d 100644
--- a/drivers/staging/iio/accel/adis16240.h
+++ b/drivers/staging/iio/accel/adis16240.h
@@ -153,14 +153,12 @@ int adis16240_set_irq(struct device *dev, bool enable);
  * filling. This may change!
  */
 
-enum adis16240_scan {
-	ADIS16240_SCAN_SUPPLY,
-	ADIS16240_SCAN_ACC_X,
-	ADIS16240_SCAN_ACC_Y,
-	ADIS16240_SCAN_ACC_Z,
-	ADIS16240_SCAN_AUX_ADC,
-	ADIS16240_SCAN_TEMP,
-};
+#define ADIS16240_SCAN_SUPPLY	0
+#define ADIS16240_SCAN_ACC_X	1
+#define ADIS16240_SCAN_ACC_Y	2
+#define ADIS16240_SCAN_ACC_Z	3
+#define ADIS16240_SCAN_AUX_ADC	4
+#define ADIS16240_SCAN_TEMP	5
 
 void adis16240_remove_trigger(struct iio_dev *indio_dev);
 int adis16240_probe_trigger(struct iio_dev *indio_dev);
diff --git a/drivers/staging/iio/gyro/adis16260.h b/drivers/staging/iio/gyro/adis16260.h
index 9f868b5..812440a 100644
--- a/drivers/staging/iio/gyro/adis16260.h
+++ b/drivers/staging/iio/gyro/adis16260.h
@@ -111,13 +111,11 @@ int adis16260_set_irq(struct device *dev, bool enable);
  * filling. This may change!
  */
 
-enum adis16260_scan {
-	ADIS16260_SCAN_SUPPLY,
-	ADIS16260_SCAN_GYRO,
-	ADIS16260_SCAN_AUX_ADC,
-	ADIS16260_SCAN_TEMP,
-	ADIS16260_SCAN_ANGL,
-};
+#define ADIS16260_SCAN_SUPPLY	0
+#define ADIS16260_SCAN_GYRO	1
+#define ADIS16260_SCAN_AUX_ADC	2
+#define ADIS16260_SCAN_TEMP	3
+#define ADIS16260_SCAN_ANGL	4
 
 void adis16260_remove_trigger(struct iio_dev *indio_dev);
 int adis16260_probe_trigger(struct iio_dev *indio_dev);
diff --git a/drivers/staging/iio/imu/adis16300.h b/drivers/staging/iio/imu/adis16300.h
index 3f59d7e..1f25d68 100644
--- a/drivers/staging/iio/imu/adis16300.h
+++ b/drivers/staging/iio/imu/adis16300.h
@@ -120,17 +120,15 @@ int adis16300_set_irq(struct device *dev, bool enable);
  * filling. This may change!
  */
 
-enum adis16300_scan {
-	ADIS16300_SCAN_SUPPLY,
-	ADIS16300_SCAN_GYRO_X,
-	ADIS16300_SCAN_ACC_X,
-	ADIS16300_SCAN_ACC_Y,
-	ADIS16300_SCAN_ACC_Z,
-	ADIS16300_SCAN_TEMP,
-	ADIS16300_SCAN_ADC_0,
-	ADIS16300_SCAN_INCLI_X,
-	ADIS16300_SCAN_INCLI_Y,
-};
+#define ADIS16300_SCAN_SUPPLY	0
+#define ADIS16300_SCAN_GYRO_X	1
+#define ADIS16300_SCAN_ACC_X	2
+#define ADIS16300_SCAN_ACC_Y	3
+#define ADIS16300_SCAN_ACC_Z	4
+#define ADIS16300_SCAN_TEMP	5
+#define ADIS16300_SCAN_ADC_0	6
+#define ADIS16300_SCAN_INCLI_X	7
+#define ADIS16300_SCAN_INCLI_Y	8
 
 void adis16300_remove_trigger(struct iio_dev *indio_dev);
 int adis16300_probe_trigger(struct iio_dev *indio_dev);
diff --git a/drivers/staging/iio/imu/adis16350.h b/drivers/staging/iio/imu/adis16350.h
index d94f6ab..738deba 100644
--- a/drivers/staging/iio/imu/adis16350.h
+++ b/drivers/staging/iio/imu/adis16350.h
@@ -123,19 +123,17 @@ int adis16350_set_irq(struct device *dev, bool enable);
 
 #ifdef CONFIG_IIO_RING_BUFFER
 
-enum adis16350_scan {
-	ADIS16350_SCAN_SUPPLY,
-	ADIS16350_SCAN_GYRO_X,
-	ADIS16350_SCAN_GYRO_Y,
-	ADIS16350_SCAN_GYRO_Z,
-	ADIS16350_SCAN_ACC_X,
-	ADIS16350_SCAN_ACC_Y,
-	ADIS16350_SCAN_ACC_Z,
-	ADIS16350_SCAN_TEMP_X,
-	ADIS16350_SCAN_TEMP_Y,
-	ADIS16350_SCAN_TEMP_Z,
-	ADIS16350_SCAN_ADC_0
-};
+#define ADIS16350_SCAN_SUPPLY	0
+#define ADIS16350_SCAN_GYRO_X	1
+#define ADIS16350_SCAN_GYRO_Y	2
+#define ADIS16350_SCAN_GYRO_Z	3
+#define ADIS16350_SCAN_ACC_X	4
+#define ADIS16350_SCAN_ACC_Y	5
+#define ADIS16350_SCAN_ACC_Z	6
+#define ADIS16350_SCAN_TEMP_X	7
+#define ADIS16350_SCAN_TEMP_Y	8
+#define ADIS16350_SCAN_TEMP_Z	9
+#define ADIS16350_SCAN_ADC_0	10
 
 void adis16350_remove_trigger(struct iio_dev *indio_dev);
 int adis16350_probe_trigger(struct iio_dev *indio_dev);
diff --git a/drivers/staging/iio/imu/adis16400.h b/drivers/staging/iio/imu/adis16400.h
index 0685195..6ff33e1 100644
--- a/drivers/staging/iio/imu/adis16400.h
+++ b/drivers/staging/iio/imu/adis16400.h
@@ -152,20 +152,18 @@ int adis16400_set_irq(struct device *dev, bool enable);
  * filling. This may change!
  */
 
-enum adis16400_scan {
-	ADIS16400_SCAN_SUPPLY,
-	ADIS16400_SCAN_GYRO_X,
-	ADIS16400_SCAN_GYRO_Y,
-	ADIS16400_SCAN_GYRO_Z,
-	ADIS16400_SCAN_ACC_X,
-	ADIS16400_SCAN_ACC_Y,
-	ADIS16400_SCAN_ACC_Z,
-	ADIS16400_SCAN_MAGN_X,
-	ADIS16400_SCAN_MAGN_Y,
-	ADIS16400_SCAN_MAGN_Z,
-	ADIS16400_SCAN_TEMP,
-	ADIS16400_SCAN_ADC_0
-};
+#define ADIS16400_SCAN_SUPPLY	0
+#define ADIS16400_SCAN_GYRO_X	1
+#define ADIS16400_SCAN_GYRO_Y	2
+#define ADIS16400_SCAN_GYRO_Z	3
+#define ADIS16400_SCAN_ACC_X	4
+#define ADIS16400_SCAN_ACC_Y	5
+#define ADIS16400_SCAN_ACC_Z	6
+#define ADIS16400_SCAN_MAGN_X	7
+#define ADIS16400_SCAN_MAGN_Y	8
+#define ADIS16400_SCAN_MAGN_Z	9
+#define ADIS16400_SCAN_TEMP	10
+#define ADIS16400_SCAN_ADC_0	11
 
 void adis16400_remove_trigger(struct iio_dev *indio_dev);
 int adis16400_probe_trigger(struct iio_dev *indio_dev);
diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio/ring_generic.h
index dbf11e1..524a0b3 100644
--- a/drivers/staging/iio/ring_generic.h
+++ b/drivers/staging/iio/ring_generic.h
@@ -215,7 +215,7 @@ ssize_t iio_scan_el_ts_show(struct device *dev, struct device_attribute *attr,
  * @_label:	indentification variable used by drivers.  Often a reg address.
  * @_controlfunc: function used to notify hardware of whether state changes
  **/
-#define IIO_SCAN_EL_C(_name, _number, _bits, _label, _controlfunc)	\
+#define __IIO_SCAN_EL_C(_name, _number, _bits, _label, _controlfunc)	\
 	struct iio_scan_el iio_scan_el_##_name = {			\
 		.dev_attr = __ATTR(_number##_##_name##_en,		\
 				   S_IRUGO | S_IWUSR,			\
@@ -227,7 +227,10 @@ ssize_t iio_scan_el_ts_show(struct device *dev, struct device_attribute *attr,
 		.set_state = _controlfunc,				\
 	}
 
-#define IIO_SCAN_NAMED_EL_C(_name, _string, _number, _bits, _label, _cf) \
+#define IIO_SCAN_EL_C(_name, _number, _bits, _label, _controlfunc)	\
+	__IIO_SCAN_EL_C(_name, _number, _bits, _label, _controlfunc)
+
+#define __IIO_SCAN_NAMED_EL_C(_name, _string, _number, _bits, _label, _cf) \
 	struct iio_scan_el iio_scan_el_##_name = {			\
 		.dev_attr = __ATTR(_number##_##_string##_en,		\
 				   S_IRUGO | S_IWUSR,			\
@@ -238,7 +241,8 @@ ssize_t iio_scan_el_ts_show(struct device *dev, struct device_attribute *attr,
 		.label = _label,					\
 		.set_state = _cf,					\
 	}
-
+#define IIO_SCAN_NAMED_EL_C(_name, _string, _number, _bits, _label, _cf) \
+	__IIO_SCAN_NAMED_EL_C(_name, _string, _number, _bits, _label, _cf)
 /**
  * IIO_SCAN_EL_TIMESTAMP - declare a special scan element for timestamps
  *
-- 
1.7.0.4
