Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:38382 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754745Ab1GMOF6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 13 Jul 2011 10:05:58 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com, linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 5/6] staging:iio:rename trigger_consumer.h to indicate it is core only.
Date: Wed, 13 Jul 2011 15:05:54 +0100
Message-Id: <1310565955-13469-6-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1310565955-13469-1-git-send-email-jic23@cam.ac.uk>
References: <1310565955-13469-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Need this out the way to create a trigger_consumer.h that actually is
for trigger consumers.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio_core_trigger.h     |   47 ++++++++++++++++++++++++++++
 drivers/staging/iio/industrialio-core.c    |    2 +-
 drivers/staging/iio/industrialio-trigger.c |    2 +-
 drivers/staging/iio/trigger_consumer.h     |   47 ----------------------------
 4 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/drivers/staging/iio/iio_core_trigger.h b/drivers/staging/iio/iio_core_trigger.h
new file mode 100644
index 0000000..9d52d96
--- /dev/null
+++ b/drivers/staging/iio/iio_core_trigger.h
@@ -0,0 +1,47 @@
+
+/* The industrial I/O core, trigger consumer handling functions
+ *
+ * Copyright (c) 2008 Jonathan Cameron
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#ifdef CONFIG_IIO_TRIGGER
+/**
+ * iio_device_register_trigger_consumer() - set up an iio_dev to use triggers
+ * @dev_info: iio_dev associated with the device that will consume the trigger
+ **/
+int iio_device_register_trigger_consumer(struct iio_dev *dev_info);
+
+/**
+ * iio_device_unregister_trigger_consumer() - reverse the registration process
+ * @dev_info: iio_dev associated with the device that consumed the trigger
+ **/
+int iio_device_unregister_trigger_consumer(struct iio_dev *dev_info);
+
+#else
+
+/**
+ * iio_device_register_trigger_consumer() - set up an iio_dev to use triggers
+ * @dev_info: iio_dev associated with the device that will consume the trigger
+ **/
+static int iio_device_register_trigger_consumer(struct iio_dev *dev_info)
+{
+	return 0;
+};
+
+/**
+ * iio_device_unregister_trigger_consumer() - reverse the registration process
+ * @dev_info: iio_dev associated with the device that consumed the trigger
+ **/
+static int iio_device_unregister_trigger_consumer(struct iio_dev *dev_info)
+{
+	return 0;
+};
+
+#endif /* CONFIG_TRIGGER_CONSUMER */
+
+
+
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 51115b4..a9628ed 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -22,7 +22,7 @@
 #include <linux/cdev.h>
 #include <linux/slab.h>
 #include "iio.h"
-#include "trigger_consumer.h"
+#include "iio_core_trigger.h"
 
 #define IIO_ID_PREFIX "device"
 #define IIO_ID_FORMAT IIO_ID_PREFIX "%d"
diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index 1bc3f14..27da975 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -17,7 +17,7 @@
 
 #include "iio.h"
 #include "trigger.h"
-#include "trigger_consumer.h"
+#include "iio_core_trigger.h"
 
 /* RFC - Question of approach
  * Make the common case (single sensor single trigger)
diff --git a/drivers/staging/iio/trigger_consumer.h b/drivers/staging/iio/trigger_consumer.h
deleted file mode 100644
index 9d52d96..0000000
--- a/drivers/staging/iio/trigger_consumer.h
+++ /dev/null
@@ -1,47 +0,0 @@
-
-/* The industrial I/O core, trigger consumer handling functions
- *
- * Copyright (c) 2008 Jonathan Cameron
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-
-#ifdef CONFIG_IIO_TRIGGER
-/**
- * iio_device_register_trigger_consumer() - set up an iio_dev to use triggers
- * @dev_info: iio_dev associated with the device that will consume the trigger
- **/
-int iio_device_register_trigger_consumer(struct iio_dev *dev_info);
-
-/**
- * iio_device_unregister_trigger_consumer() - reverse the registration process
- * @dev_info: iio_dev associated with the device that consumed the trigger
- **/
-int iio_device_unregister_trigger_consumer(struct iio_dev *dev_info);
-
-#else
-
-/**
- * iio_device_register_trigger_consumer() - set up an iio_dev to use triggers
- * @dev_info: iio_dev associated with the device that will consume the trigger
- **/
-static int iio_device_register_trigger_consumer(struct iio_dev *dev_info)
-{
-	return 0;
-};
-
-/**
- * iio_device_unregister_trigger_consumer() - reverse the registration process
- * @dev_info: iio_dev associated with the device that consumed the trigger
- **/
-static int iio_device_unregister_trigger_consumer(struct iio_dev *dev_info)
-{
-	return 0;
-};
-
-#endif /* CONFIG_TRIGGER_CONSUMER */
-
-
-
-- 
1.7.3.4

