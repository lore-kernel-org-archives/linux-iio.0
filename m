Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:35472 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753844AbcI0AUM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Sep 2016 20:20:12 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v3 1/5] include: linux: iio: add IIO_ATTR_{RO, WO, RW} and IIO_DEVICE_ATTR_{RO, WO, RW} macros
Date: Mon, 26 Sep 2016 20:20:16 -0400
Message-Id: <1474935620-13151-1-git-send-email-masneyb@onstation.org>
In-Reply-To: <20160926075935.GA25938@kroah.com>
References: <20160926075935.GA25938@kroah.com>
In-Reply-To: <20160926075935.GA25938@kroah.com>
References: <20160926075935.GA25938@kroah.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add new macros: IIO_ATTR_RO, IIO_ATTR_WO, IIO_ATTR_RW,
IIO_DEVICE_ATTR_RO, IIO_DEVICE_ATTR_WO and IIO_DEVICE_ATTR_RW to reduce
the amount of boiler plate code that is needed for creating new
attributes. This mimics the *_RO, *_WO, and *_RW macros that are found
in include/linux/device.h and include/linux/sysfs.h.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
This is the same version of this patch that I sent out on Sunday. I am
resending the patch set since my the second patch in that series would
not apply cleanly to iio.git/testing.

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

