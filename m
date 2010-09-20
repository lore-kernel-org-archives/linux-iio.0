Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-33.csi.cam.ac.uk ([131.111.8.133]:49438 "EHLO
	ppsw-33.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756491Ab0ITOHz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 20 Sep 2010 10:07:55 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: manuel.stahl@iis.fraunhofer.de, linux-iio@vger.kernel.org
Cc: drivers@analog.com, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 01/22] staging:iio:lis3l02dq add _type attributes for all scan elements
Date: Mon, 20 Sep 2010 15:12:46 +0100
Message-Id: <1284991987-12407-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1284991987-12407-1-git-send-email-jic23@cam.ac.uk>
References: <1284991987-12407-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Also, adds a macro to make defining such attributes simple.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/lis3l02dq_ring.c |    4 ++++
 drivers/staging/iio/ring_generic.h         |   11 ++++++++++-
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index f26c0fe..28a54f1 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -84,13 +84,17 @@ static IIO_SCAN_EL_C(accel_y, 1, IIO_SIGNED(16),
 static IIO_SCAN_EL_C(accel_z, 2, IIO_SIGNED(16),
 		     LIS3L02DQ_REG_OUT_Z_L_ADDR,
 		     &lis3l02dq_scan_el_set_state);
+static IIO_CONST_ATTR_SCAN_EL_TYPE(accel, s, 12, 16);
 static IIO_SCAN_EL_TIMESTAMP(3);
+static IIO_CONST_ATTR_SCAN_EL_TYPE(timestamp, s, 64, 64);
 
 static struct attribute *lis3l02dq_scan_el_attrs[] = {
 	&iio_scan_el_accel_x.dev_attr.attr,
 	&iio_scan_el_accel_y.dev_attr.attr,
 	&iio_scan_el_accel_z.dev_attr.attr,
+	&iio_const_attr_accel_type.dev_attr.attr,
 	&iio_scan_el_timestamp.dev_attr.attr,
+	&iio_const_attr_timestamp_type.dev_attr.attr,
 	NULL,
 };
 
diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio/ring_generic.h
index 7b29cd5..692b967 100644
--- a/drivers/staging/iio/ring_generic.h
+++ b/drivers/staging/iio/ring_generic.h
@@ -247,7 +247,7 @@ ssize_t iio_scan_el_ts_show(struct device *dev, struct device_attribute *attr,
 		.bit_count = _bits,					\
 		.label = _label,					\
 		.set_state = _controlfunc,				\
-	}
+	}	  
 
 #define IIO_SCAN_EL_C(_name, _number, _bits, _label, _controlfunc)	\
 	__IIO_SCAN_EL_C(_name, _number, _bits, _label, _controlfunc)
@@ -279,6 +279,15 @@ ssize_t iio_scan_el_ts_show(struct device *dev, struct device_attribute *attr,
 				   iio_scan_el_ts_store),	\
 	}
 
+/**
+ * IIO_CONST_ATTR_SCAN_EL_TYPE - attr to specify the data format of a scan el
+ * @name: the scan el name (may be more general and cover a set of scan elements
+ * @_sign: either s or u for signed or unsigned
+ * @_bits: number of actual bits occuplied by the value
+ * @_storagebits: number of bits _bits is padded to when read out of buffer
+ **/
+#define IIO_CONST_ATTR_SCAN_EL_TYPE(_name, _sign, _bits, _storagebits) \
+	IIO_CONST_ATTR(_name##_type, #_sign#_bits"/"#_storagebits);
 /*
  * These are mainly provided to allow for a change of implementation if a device
  * has a large number of scan elements
-- 
1.7.2.2

