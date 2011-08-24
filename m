Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 6/9] staging:iio:rename trigger_consumer.h to indicate it is core only.
Date: Wed, 24 Aug 2011 17:28:38 +0100
Message-Id: <1314203321-21926-7-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314203321-21926-1-git-send-email-jic23@cam.ac.uk>
References: <1314203321-21926-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

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
index cf268bc..ed8a6df 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -22,8 +22,8 @@
 #include <linux/cdev.h>
 #include <linux/slab.h>
 #include "iio.h"
-#include "trigger_consumer.h"
 #include "iio_core.h"
+#include "iio_core_trigger.h"
 
 #define IIO_ID_PREFIX "device"
 #define IIO_ID_FORMAT IIO_ID_PREFIX "%d"
diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index 7012f8c..8fafeb8 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -18,7 +18,7 @@
 #include "iio.h"
 #include "trigger.h"
 #include "iio_core.h"
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
