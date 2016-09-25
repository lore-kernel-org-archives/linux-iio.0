Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:34434 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755661AbcIYT1y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Sep 2016 15:27:54 -0400
From: Brian Masney <masneyb@onstation.org>
To: gregkh@linuxfoundation.org
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH v2 1/2] include: linux: iio: add IIO_ATTR_{RO,WO,RW} and IIO_DEVICE_ATTR_{RO,WO,RW} macros
Date: Sun, 25 Sep 2016 15:27:54 -0400
Message-Id: <1474831675-4201-1-git-send-email-masneyb@onstation.org>
In-Reply-To: <20160925175852.GB13088@kroah.com>
References: <20160925175852.GB13088@kroah.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add new macros: IIO_ATTR_RO, IIO_ATTR_WO, IIO_ATTR_RW,
IIO_DEVICE_ATTR_RO, IIO_DEVICE_ATTR_WO and IIO_DEVICE_ATTR_RW to reduce
the amount of boiler plate code that is needed for creating new
attributes. This mimics the *_RO, *_WO, and *_RW macros that are found
in include/linux/device.h and include/linux/sysfs.h.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 include/linux/iio/sysfs.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/iio/sysfs.h b/include/linux/iio/sysfs.h
index 9cd8f74..ce9426c 100644
--- a/include/linux/iio/sysfs.h
+++ b/include/linux/iio/sysfs.h
@@ -55,10 +55,34 @@ struct iio_const_attr {
 	{ .dev_attr = __ATTR(_name, _mode, _show, _store),	\
 	  .address = _addr }
 
+#define IIO_ATTR_RO(_name, _addr)       \
+	{ .dev_attr = __ATTR_RO(_name), \
+	  .address = _addr }
+
+#define IIO_ATTR_WO(_name, _addr)       \
+	{ .dev_attr = __ATTR_WO(_name), \
+	  .address = _addr }
+
+#define IIO_ATTR_RW(_name, _addr)       \
+	{ .dev_attr = __ATTR_RW(_name), \
+	  .address = _addr }
+
 #define IIO_DEVICE_ATTR(_name, _mode, _show, _store, _addr)	\
 	struct iio_dev_attr iio_dev_attr_##_name		\
 	= IIO_ATTR(_name, _mode, _show, _store, _addr)
 
+#define IIO_DEVICE_ATTR_RO(_name, _addr)                       \
+	struct iio_dev_attr iio_dev_attr_##_name                \
+	= IIO_ATTR_RO(_name, _addr)
+
+#define IIO_DEVICE_ATTR_WO(_name, _addr)                       \
+	struct iio_dev_attr iio_dev_attr_##_name                \
+	= IIO_ATTR_WO(_name, _addr)
+
+#define IIO_DEVICE_ATTR_RW(_name, _addr)                                   \
+	struct iio_dev_attr iio_dev_attr_##_name                            \
+	= IIO_ATTR_RW(_name, _addr)
+
 #define IIO_DEVICE_ATTR_NAMED(_vname, _name, _mode, _show, _store, _addr) \
 	struct iio_dev_attr iio_dev_attr_##_vname			\
 	= IIO_ATTR(_name, _mode, _show, _store, _addr)
-- 
2.7.4

