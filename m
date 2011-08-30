Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:54659 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531Ab1H3LYi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 30 Aug 2011 07:24:38 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 6/7] staging:iio: remove now defunct header definitions and add some statics
Date: Tue, 30 Aug 2011 12:32:48 +0100
Message-Id: <1314703969-15275-7-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314703969-15275-1-git-send-email-jic23@cam.ac.uk>
References: <1314703969-15275-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Now we have combined all chrdevs into one, some bits and bobs are only
needed in industrialio-core.c and don't need to be in the core header.

Also remove some unused defines.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio_core.h          |    9 ---------
 drivers/staging/iio/industrialio-core.c |    9 +++------
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/iio/iio_core.h b/drivers/staging/iio/iio_core.h
index a27fa05..433952b 100644
--- a/drivers/staging/iio/iio_core.h
+++ b/drivers/staging/iio/iio_core.h
@@ -14,13 +14,6 @@
 #define _IIO_CORE_H_
 
 /**
- * iio_device_get_chrdev_minor() - get an unused minor number
- **/
-int iio_device_get_chrdev_minor(void);
-void iio_device_free_chrdev_minor(int val);
-
-
-/**
  * iio_put() - internal module reference count reduce
  **/
 void iio_put(void);
@@ -30,8 +23,6 @@ void iio_put(void);
  **/
 void iio_get(void);
 
-extern dev_t iio_devt;
-
 int __iio_add_chan_devattr(const char *postfix,
 			   const char *group,
 			   struct iio_chan_spec const *chan,
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index e55edfa..de91878 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -27,9 +27,6 @@
 #include "iio_core_trigger.h"
 #include "chrdev.h"
 
-#define IIO_ID_PREFIX "device"
-#define IIO_ID_FORMAT IIO_ID_PREFIX "%d"
-
 /* IDR to assign each registered device a unique id*/
 static DEFINE_IDA(iio_ida);
 /* IDR to allocate character device minor numbers */
@@ -37,7 +34,7 @@ static DEFINE_IDA(iio_chrdev_ida);
 /* Lock used to protect both of the above */
 static DEFINE_SPINLOCK(iio_ida_lock);
 
-dev_t iio_devt;
+static dev_t iio_devt;
 
 #define IIO_DEV_MAX 256
 struct bus_type iio_bus_type = {
@@ -276,7 +273,7 @@ static const struct file_operations iio_event_chrdev_fileops = {
 	.llseek = noop_llseek,
 };
 
-int iio_device_get_chrdev_minor(void)
+static int iio_device_get_chrdev_minor(void)
 {
 	int ret;
 
@@ -287,7 +284,7 @@ int iio_device_get_chrdev_minor(void)
 		return -ENOMEM;
 }
 
-void iio_device_free_chrdev_minor(int val)
+static void iio_device_free_chrdev_minor(int val)
 {
 	iio_free_ida_val(&iio_chrdev_ida, val);
 }
-- 
1.7.3.4

