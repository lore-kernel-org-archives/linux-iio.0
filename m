Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: gregkh@suse.de
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 07/20] staging:iio: Clean out unused IIO_SCAN_EL and add IIO_SCAN_NAMED_EL_C
Date: Tue,  4 May 2010 14:43:02 +0100
Message-Id: <1272980595-11033-8-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1272980595-11033-7-git-send-email-jic23@cam.ac.uk>
References: <1272980595-11033-1-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-2-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-3-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-4-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-5-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-6-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-7-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/ring_generic.h |   36 +++++++++++++++---------------------
 1 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio/ring_generic.h
index c482074..d74b5ae 100644
--- a/drivers/staging/iio/ring_generic.h
+++ b/drivers/staging/iio/ring_generic.h
@@ -196,25 +196,6 @@ ssize_t iio_scan_el_store(struct device *dev, struct device_attribute *attr,
  **/
 ssize_t iio_scan_el_show(struct device *dev, struct device_attribute *attr,
 			 char *buf);
-/**
- * IIO_SCAN_EL - declare and initialize a scan element without control func
- * @_name:	identifying name. Resulting struct is iio_scan_el_##_name,
- *		sysfs element, scan_en_##_name.
- * @_number:	unique id number for the scan element.
- * @_bits:	number of bits in the scan element result (used in mixed bit
- *		length devices).
- * @_label:	indentification variable used by drivers.  Often a reg address.
- **/
-#define IIO_SCAN_EL(_name, _number, _bits, _label)			\
-	struct iio_scan_el iio_scan_el_##_name = {			\
-		.dev_attr = __ATTR(scan_en_##_name,			\
-				   S_IRUGO | S_IWUSR,			\
-				   iio_scan_el_show,			\
-				   iio_scan_el_store),			\
-		.mask = (1 << _number),					\
-		.bit_count = _bits,					\
-		.label = _label,					\
-	}
 
 ssize_t iio_scan_el_ts_store(struct device *dev, struct device_attribute *attr,
 			     const char *buf, size_t len);
@@ -225,7 +206,7 @@ ssize_t iio_scan_el_ts_show(struct device *dev, struct device_attribute *attr,
  * IIO_SCAN_EL_C - declare and initialize a scan element with a control func
  *
  * @_name:	identifying name. Resulting struct is iio_scan_el_##_name,
- *		sysfs element, scan_en_##_name.
+ *		sysfs element, _name##_en.
  * @_number:	unique id number for the scan element.
  * @_bits:	number of bits in the scan element result (used in mixed bit
  *		length devices).
@@ -234,7 +215,7 @@ ssize_t iio_scan_el_ts_show(struct device *dev, struct device_attribute *attr,
  **/
 #define IIO_SCAN_EL_C(_name, _number, _bits, _label, _controlfunc)	\
 	struct iio_scan_el iio_scan_el_##_name = {			\
-		.dev_attr = __ATTR(scan_en_##_name,			\
+		.dev_attr = __ATTR(_number##_##_name##_en,		\
 				   S_IRUGO | S_IWUSR,			\
 				   iio_scan_el_show,			\
 				   iio_scan_el_store),			\
@@ -243,6 +224,19 @@ ssize_t iio_scan_el_ts_show(struct device *dev, struct device_attribute *attr,
 		.label = _label,					\
 		.set_state = _controlfunc,				\
 	}
+
+#define IIO_SCAN_NAMED_EL_C(_name, _string, _number, _bits, _label, _cf) \
+	struct iio_scan_el iio_scan_el_##_name = {			\
+		.dev_attr = __ATTR(_number##_##_string##_en,		\
+				   S_IRUGO | S_IWUSR,			\
+				   iio_scan_el_show,			\
+				   iio_scan_el_store),			\
+		.number =  _number,					\
+		.bit_count = _bits,					\
+		.label = _label,					\
+		.set_state = _cf,					\
+	}
+
 /**
  * IIO_SCAN_EL_TIMESTAMP - declare a special scan element for timestamps
  *
-- 
1.6.4.4
