Return-Path: <Michael.Hennerich@analog.com>
From: Michael Hennerich <michael.hennerich@analog.com>
To: jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, drivers@analog.com
Subject: [PATCH] staging: iio: ring_generic: provide IIO_CONST_ATTR_SCAN_EL_TYPE_WITH_SHIFT
Date: Tue, 5 Oct 2010 15:00:06 +0200
Message-ID: <1286283606-6849-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>


Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/ring_generic.h |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio/ring_generic.h
index abd52ea..728aa41 100644
--- a/drivers/staging/iio/ring_generic.h
+++ b/drivers/staging/iio/ring_generic.h
@@ -292,6 +292,23 @@ ssize_t iio_scan_el_ts_show(struct device *dev, struct device_attribute *attr,
  **/
 #define IIO_CONST_ATTR_SCAN_EL_TYPE(_name, _sign, _bits, _storagebits) \
 	IIO_CONST_ATTR(_name##_type, #_sign#_bits"/"#_storagebits);
+
+/**
+ * IIO_CONST_ATTR_SCAN_EL_TYPE_WITH_SHIFT - attr to specify the data format of a scan el
+ * @name: the scan el name (may be more general and cover a set of scan elements
+ * @_sign: either s or u for signed or unsigned
+ * @_bits: number of actual bits occuplied by the value
+ * @_storagebits: number of bits _bits is padded to when read out of buffer
+ * @_shiftbits: number of bits _shiftbits the result must be shifted
+ **/
+#define IIO_CONST_ATTR_SCAN_EL_TYPE_WITH_SHIFT(_name, _sign, _bits, \
+					       _storagebits, _shiftbits) \
+	IIO_CONST_ATTR(_name##_type, #_sign#_bits"/"#_storagebits \
+		       ">>"#_shiftbits);
+
+#define IIO_SCAN_EL_TYPE_SIGNED         's'
+#define IIO_SCAN_EL_TYPE_UNSIGNED       'u'
+
 /*
  * These are mainly provided to allow for a change of implementation if a device
  * has a large number of scan elements
-- 
1.6.0.2
