Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:49459 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754631Ab1GNMdu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 14 Jul 2011 08:33:50 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 5/7] staging:iio: Introduce iio_core.h and move all core only stuff out of iio.h.
Date: Thu, 14 Jul 2011 13:33:45 +0100
Message-Id: <1310646827-25690-6-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1310646827-25690-1-git-send-email-jic23@cam.ac.uk>
References: <1310646827-25690-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Also get rid of a few function defs where they are only now in one core file
anyway.
Whilst here add mask = 0 to get rid of warning.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio.h                  |   63 +---------------------------
 drivers/staging/iio/iio_core.h             |   48 +++++++++++++++++++++
 drivers/staging/iio/industrialio-core.c    |   16 ++++----
 drivers/staging/iio/industrialio-ring.c    |    1 +
 drivers/staging/iio/industrialio-trigger.c |    1 +
 5 files changed, 59 insertions(+), 70 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 07f88aa..61cfb26 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -23,9 +23,6 @@
  * Currently assumes nano seconds.
  */
 
-/* Event interface flags */
-#define IIO_BUSY_BIT_POS 1
-
 /* naughty temporary hack to match these against the event version
    - need to flattern these together */
 enum iio_chan_type {
@@ -131,19 +128,7 @@ struct iio_chan_spec {
 	unsigned		modified:1;
 	unsigned		indexed:1;
 };
-/* Meant for internal use only */
-void __iio_device_attr_deinit(struct device_attribute *dev_attr);
-int __iio_device_attr_init(struct device_attribute *dev_attr,
-			   const char *postfix,
-			   struct iio_chan_spec const *chan,
-			   ssize_t (*readfunc)(struct device *dev,
-					       struct device_attribute *attr,
-					       char *buf),
-			   ssize_t (*writefunc)(struct device *dev,
-						struct device_attribute *attr,
-						const char *buf,
-						size_t len),
-			   bool generic);
+
 #define IIO_ST(si, rb, sb, sh)						\
 	{ .sign = si, .realbits = rb, .storagebits = sb, .shift = sh }
 
@@ -166,20 +151,6 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
 	{ .type = IIO_TIMESTAMP, .channel = -1,				\
 			.scan_index = _si, .scan_type = IIO_ST('s', 64, 64, 0) }
 
-int __iio_add_chan_devattr(const char *postfix,
-			   const char *group,
-			   struct iio_chan_spec const *chan,
-			   ssize_t (*func)(struct device *dev,
-					   struct device_attribute *attr,
-					   char *buf),
-			   ssize_t (*writefunc)(struct device *dev,
-						struct device_attribute *attr,
-						const char *buf,
-						size_t len),
-			   int mask,
-			   bool generic,
-			   struct device *dev,
-			   struct list_head *attr_list);
 /**
  * iio_get_time_ns() - utility function to get a time stamp for events etc
  **/
@@ -344,13 +315,6 @@ int iio_push_event(struct iio_dev *dev_info,
 		  int ev_code,
 		  s64 timestamp);
 
-/* Used to distinguish between bipolar and unipolar scan elemenents.
- * Whilst this may seem obvious, we may well want to change the representation
- * in the future!*/
-#define IIO_SIGNED(a) -(a)
-#define IIO_UNSIGNED(a) (a)
-
-extern dev_t iio_devt;
 extern struct bus_type iio_bus_type;
 
 /**
@@ -363,15 +327,6 @@ static inline void iio_put_device(struct iio_dev *dev)
 		put_device(&dev->dev);
 };
 
-/**
- * to_iio_dev() - get iio_dev for which we have the struct device
- * @d: the struct device
- **/
-static inline struct iio_dev *to_iio_dev(struct device *d)
-{
-	return container_of(d, struct iio_dev, dev);
-};
-
 /* Can we make this smaller? */
 #define IIO_ALIGN L1_CACHE_BYTES
 /**
@@ -398,22 +353,6 @@ static inline struct iio_dev *iio_priv_to_dev(void *priv)
 void iio_free_device(struct iio_dev *dev);
 
 /**
- * iio_put() - internal module reference count reduce
- **/
-void iio_put(void);
-
-/**
- * iio_get() - internal module reference count increase
- **/
-void iio_get(void);
-
-/**
- * iio_device_get_chrdev_minor() - get an unused minor number
- **/
-int iio_device_get_chrdev_minor(void);
-void iio_device_free_chrdev_minor(int val);
-
-/**
  * iio_ring_enabled() - helper function to test if any form of ring is enabled
  * @dev_info:		IIO device info structure for device
  **/
diff --git a/drivers/staging/iio/iio_core.h b/drivers/staging/iio/iio_core.h
new file mode 100644
index 0000000..00e894d
--- /dev/null
+++ b/drivers/staging/iio/iio_core.h
@@ -0,0 +1,48 @@
+/* The industrial I/O core function defs.
+ *
+ * Copyright (c) 2008 Jonathan Cameron
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * These definitions are meant for use only within the IIO core, not indvidual
+ * drivers.
+ */
+
+/**
+ * iio_device_get_chrdev_minor() - get an unused minor number
+ **/
+int iio_device_get_chrdev_minor(void);
+void iio_device_free_chrdev_minor(int val);
+
+
+/**
+ * iio_put() - internal module reference count reduce
+ **/
+void iio_put(void);
+
+/**
+ * iio_get() - internal module reference count increase
+ **/
+void iio_get(void);
+
+extern dev_t iio_devt;
+
+int __iio_add_chan_devattr(const char *postfix,
+			   const char *group,
+			   struct iio_chan_spec const *chan,
+			   ssize_t (*func)(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf),
+			   ssize_t (*writefunc)(struct device *dev,
+						struct device_attribute *attr,
+						const char *buf,
+						size_t len),
+			   int mask,
+			   bool generic,
+			   struct device *dev,
+			   struct list_head *attr_list);
+
+/* Event interface flags */
+#define IIO_BUSY_BIT_POS 1
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index b131a58..123841b 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -22,6 +22,7 @@
 #include <linux/cdev.h>
 #include <linux/slab.h>
 #include "iio.h"
+#include "iio_core.h"
 #include "iio_core_trigger.h"
 
 #define IIO_ID_PREFIX "device"
@@ -35,7 +36,6 @@ static DEFINE_IDA(iio_chrdev_ida);
 static DEFINE_SPINLOCK(iio_ida_lock);
 
 dev_t iio_devt;
-EXPORT_SYMBOL(iio_devt);
 
 #define IIO_DEV_MAX 256
 struct bus_type iio_bus_type = {
@@ -90,7 +90,7 @@ static const char * const iio_chan_info_postfix[] = {
 };
 
 /* Return a negative errno on failure */
-int iio_get_new_ida_val(struct ida *this_ida)
+static int iio_get_new_ida_val(struct ida *this_ida)
 {
 	int ret;
 	int val;
@@ -109,15 +109,13 @@ ida_again:
 
 	return val;
 }
-EXPORT_SYMBOL(iio_get_new_ida_val);
 
-void iio_free_ida_val(struct ida *this_ida, int id)
+static void iio_free_ida_val(struct ida *this_ida, int id)
 {
 	spin_lock(&iio_ida_lock);
 	ida_remove(this_ida, id);
 	spin_unlock(&iio_ida_lock);
 }
-EXPORT_SYMBOL(iio_free_ida_val);
 
 int iio_push_event(struct iio_dev *dev_info,
 		   int ev_line,
@@ -532,6 +530,7 @@ static int __iio_build_postfix(struct iio_chan_spec const *chan,
 	return 0;
 }
 
+static
 int __iio_device_attr_init(struct device_attribute *dev_attr,
 			   const char *postfix,
 			   struct iio_chan_spec const *chan,
@@ -604,7 +603,7 @@ error_ret:
 	return ret;
 }
 
-void __iio_device_attr_deinit(struct device_attribute *dev_attr)
+static void __iio_device_attr_deinit(struct device_attribute *dev_attr)
 {
 	kfree(dev_attr->attr.name);
 }
@@ -889,7 +888,7 @@ static int iio_device_add_event_sysfs(struct iio_dev *dev_info,
 				      struct iio_chan_spec const *chan)
 {
 
-	int ret = 0, i, mask;
+	int ret = 0, i, mask = 0;
 	char *postfix;
 	if (!chan->event_mask)
 		return 0;
@@ -1099,8 +1098,9 @@ static void iio_device_unregister_eventset(struct iio_dev *dev_info)
 
 static void iio_dev_release(struct device *device)
 {
+	struct iio_dev *dev_info = container_of(device, struct iio_dev, dev);
 	iio_put();
-	kfree(to_iio_dev(device));
+	kfree(dev_info);
 }
 
 static struct device_type iio_dev_type = {
diff --git a/drivers/staging/iio/industrialio-ring.c b/drivers/staging/iio/industrialio-ring.c
index 843eb82..dce50b1 100644
--- a/drivers/staging/iio/industrialio-ring.c
+++ b/drivers/staging/iio/industrialio-ring.c
@@ -21,6 +21,7 @@
 #include <linux/poll.h>
 
 #include "iio.h"
+#include "iio_core.h"
 #include "ring_generic.h"
 
 /**
diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index 21a7dbb..72ea106 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -17,6 +17,7 @@
 
 #include "iio.h"
 #include "trigger.h"
+#include "iio_core.h"
 #include "iio_core_trigger.h"
 #include "trigger_consumer.h"
 
-- 
1.7.3.4

