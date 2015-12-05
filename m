Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: daniel.baluta@intel.com,
	lars@metafoo.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] iio:configfs: Introduce iio/configfs.h to provide a location for the configfs_subsystem
Date: Sat,  5 Dec 2015 16:29:55 +0000
Message-Id: <1449332995-21695-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

This exported element needs to be accesible to all drivers using configfs
within IIO.  Previously it was in the sw_trig.h file which only convered one
such usecase.  This also fixes a sparse warning as it is now in a header
that makes sense to include from industrialio-configfs.c

Signed-off-by: Jonathan Cameron < jic23@kernel.org>
---
 drivers/iio/industrialio-configfs.c   |  1 +
 drivers/iio/industrialio-sw-trigger.c |  1 +
 include/linux/iio/configfs.h          | 15 +++++++++++++++
 include/linux/iio/sw_trigger.h        |  1 -
 4 files changed, 17 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/iio/configfs.h

diff --git a/drivers/iio/industrialio-configfs.c b/drivers/iio/industrialio-configfs.c
index 83563dd7fcf4..45ce2bc47180 100644
--- a/drivers/iio/industrialio-configfs.c
+++ b/drivers/iio/industrialio-configfs.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 
 #include <linux/iio/iio.h>
+#include <linux/iio/configfs.h>
 
 static struct config_item_type iio_root_group_type = {
 	.ct_owner       = THIS_MODULE,
diff --git a/drivers/iio/industrialio-sw-trigger.c b/drivers/iio/industrialio-sw-trigger.c
index 4825cfd9c4ea..311f9fe5aa34 100644
--- a/drivers/iio/industrialio-sw-trigger.c
+++ b/drivers/iio/industrialio-sw-trigger.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 
 #include <linux/iio/sw_trigger.h>
+#include <linux/iio/configfs.h>
 #include <linux/configfs.h>
 
 static struct config_group *iio_triggers_group;
diff --git a/include/linux/iio/configfs.h b/include/linux/iio/configfs.h
new file mode 100644
index 000000000000..93befd67c15c
--- /dev/null
+++ b/include/linux/iio/configfs.h
@@ -0,0 +1,15 @@
+/*
+ * Industrial I/O configfs support
+ *
+ * Copyright (c) 2015 Intel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+#ifndef __IIO_CONFIGFS
+#define __IIO_CONFIGFS
+
+extern struct configfs_subsystem iio_configfs_subsys;
+
+#endif /* __IIO_CONFIGFS */
diff --git a/include/linux/iio/sw_trigger.h b/include/linux/iio/sw_trigger.h
index c2f33b2b35a5..5198f8ed08a4 100644
--- a/include/linux/iio/sw_trigger.h
+++ b/include/linux/iio/sw_trigger.h
@@ -20,7 +20,6 @@
 	module_driver(__iio_sw_trigger_type, iio_register_sw_trigger_type, \
 		      iio_unregister_sw_trigger_type)
 
-extern struct configfs_subsystem iio_configfs_subsys;
 struct iio_sw_trigger_ops;
 
 struct iio_sw_trigger_type {
-- 
2.6.3
