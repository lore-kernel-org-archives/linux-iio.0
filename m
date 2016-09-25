Return-Path: <masneyb@onstation.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org
Subject: [PATCH 1/2] include: linux: iio: add IIO_DEVICE_ATTR_{RO,WO,RW} macros
Date: Sun, 25 Sep 2016 13:29:58 -0400
Message-Id: <1474824599-30205-1-git-send-email-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

Add three new macros: IIO_DEVICE_ATTR_RO, IIO_DEVICE_ATTR_WO and
IIO_DEVICE_ATTR_RW to reduce the amount of boiler plate code that
is needed for creating new attributes. This mimics the *_RO, *_WO,
and *_RW macros that are found in include/linux/device.h and
include/linux/sysfs.h.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 include/linux/iio/sysfs.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/iio/sysfs.h b/include/linux/iio/sysfs.h
index 9cd8f74..f7c6431 100644
--- a/include/linux/iio/sysfs.h
+++ b/include/linux/iio/sysfs.h
@@ -59,6 +59,19 @@ struct iio_const_attr {
 	struct iio_dev_attr iio_dev_attr_##_name		\
 	= IIO_ATTR(_name, _mode, _show, _store, _addr)
 
+#define IIO_DEVICE_ATTR_RO(_name, _addr)			\
+	struct iio_dev_attr iio_dev_attr_##_name		\
+	= IIO_ATTR(_name, S_IRUGO, _name##_show, NULL, _addr)
+
+#define IIO_DEVICE_ATTR_WO(_name, _addr)			\
+	struct iio_dev_attr iio_dev_attr_##_name		\
+	= IIO_ATTR(_name, S_IWUSR, NULL, _name##_store, _addr)
+
+#define IIO_DEVICE_ATTR_RW(_name, _addr)			            \
+	struct iio_dev_attr iio_dev_attr_##_name		            \
+	= IIO_ATTR(_name, (S_IWUSR | S_IRUGO), _name##_show, _name##_store, \
+		   _addr)
+
 #define IIO_DEVICE_ATTR_NAMED(_vname, _name, _mode, _show, _store, _addr) \
 	struct iio_dev_attr iio_dev_attr_##_vname			\
 	= IIO_ATTR(_name, _mode, _show, _store, _addr)
-- 
2.7.4
