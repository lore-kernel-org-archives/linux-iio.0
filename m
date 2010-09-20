Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: manuel.stahl@iis.fraunhofer.de,
	linux-iio@vger.kernel.org
Cc: drivers@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 11/22] staging:iio: amend macros for SCAN_EL creation to add separate index attr
Date: Mon, 20 Sep 2010 15:12:56 +0100
Message-Id: <1284991987-12407-12-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1284991987-12407-1-git-send-email-jic23@cam.ac.uk>
References: <1284991987-12407-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

As Manuel Stahl observed, putting data into the naming of an attribute
(beyond what it is for) breaks the one value per attribute rule (in spirit
at least).  Hence we introduce a separate _index attribute for each scan
element to tell userspace the ordering in output from the buffer.

This will generate a lot of sparse warnings as all drivers will have unused
iio_const_attrs created.  The rest of the set will clean these up.

The final patch will remove the old indexing method. It is not here so
as to maintain one or other interface for all devices as this set
progresses.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/ring_generic.h |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio/ring_generic.h
index 6be399a..1daeb01 100644
--- a/drivers/staging/iio/ring_generic.h
+++ b/drivers/staging/iio/ring_generic.h
@@ -243,12 +243,13 @@ ssize_t iio_scan_el_ts_show(struct device *dev, struct device_attribute *attr,
 		.number =  _number,					\
 		.label = _label,					\
 		.set_state = _controlfunc,				\
-	}	  
+	};								\
+	static IIO_CONST_ATTR(_name##_index, #_number)
 
 #define IIO_SCAN_EL_C(_name, _number, _label, _controlfunc)	\
 	__IIO_SCAN_EL_C(_name, _number, _label, _controlfunc)
 
-#define __IIO_SCAN_NAMED_EL_C(_name, _string, _number, _label, _cf) \
+#define __IIO_SCAN_NAMED_EL_C(_name, _string, _number, _label, _cf)	\
 	struct iio_scan_el iio_scan_el_##_name = {			\
 		.dev_attr = __ATTR(_number##_##_string##_en,		\
 				   S_IRUGO | S_IWUSR,			\
@@ -257,7 +258,14 @@ ssize_t iio_scan_el_ts_show(struct device *dev, struct device_attribute *attr,
 		.number =  _number,					\
 		.label = _label,					\
 		.set_state = _cf,					\
+	};								\
+	static struct iio_const_attr iio_const_attr_##_name##_index = {	\
+		.string = #_number,					\
+		.dev_attr = __ATTR(_string##_index,			\
+				   S_IRUGO, iio_read_const_attr, NULL)	\
 	}
+
+
 #define IIO_SCAN_NAMED_EL_C(_name, _string, _number, _label, _cf) \
 	__IIO_SCAN_NAMED_EL_C(_name, _string, _number, _label, _cf)
 /**
@@ -272,7 +280,8 @@ ssize_t iio_scan_el_ts_show(struct device *dev, struct device_attribute *attr,
 				   S_IRUGO | S_IWUSR,		\
 				   iio_scan_el_ts_show,		\
 				   iio_scan_el_ts_store),	\
-	}
+	};							\
+	static IIO_CONST_ATTR(timestamp_index, #number)
 
 /**
  * IIO_CONST_ATTR_SCAN_EL_TYPE - attr to specify the data format of a scan el
-- 
1.7.2.2
