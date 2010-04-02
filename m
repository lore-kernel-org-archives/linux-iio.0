Return-Path: <sonic.adi@gmail.com>
Subject: [PATCH] IIO: struct iio_dev_attr should be defined as static.
From: sonic zhang <sonic.adi@gmail.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 2 Apr 2010 10:55:48 +0800
Message-ID: <1270176948.3847.1.camel@eight.analog.com>
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>


Otherwise link errors "multiple definition of `iio_dev_attr_mode'"
are reported when compile multiple different iio drivers with the
same attribute name.

Signed-off-by: Sonic Zhang <sonic.adi@gmail.com>
---
 drivers/staging/iio/sysfs.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index e501e13..39d207e 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -95,16 +95,16 @@ struct iio_const_attr {
 			.val2 = _val2 }
 
 #define IIO_DEVICE_ATTR(_name, _mode, _show, _store, _addr)	\
-	struct iio_dev_attr iio_dev_attr_##_name		\
+	static struct iio_dev_attr iio_dev_attr_##_name		\
 	= IIO_ATTR(_name, _mode, _show, _store, _addr)
 
 
 #define IIO_DEVICE_ATTR_2(_name, _mode, _show, _store, _addr, _val2)	\
-	struct iio_dev_attr iio_dev_attr_##_name			\
+	static struct iio_dev_attr iio_dev_attr_##_name			\
 	= IIO_ATTR_2(_name, _mode, _show, _store, _addr, _val2)
 
 #define IIO_CONST_ATTR(_name, _string)					\
-	struct iio_const_attr iio_const_attr_##_name			\
+	static struct iio_const_attr iio_const_attr_##_name			\
 	= { .string = _string,						\
 	    .dev_attr = __ATTR(_name, S_IRUGO, iio_read_const_attr, NULL)}
 
-- 
1.6.0
