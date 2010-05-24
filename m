Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 07/11] staging:iio: Code cleanups
Date: Mon, 24 May 2010 22:02:52 +0100
Message-Id: <1274734976-7941-8-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1274734976-7941-1-git-send-email-jic23@cam.ac.uk>
References: <1274734976-7941-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio.h                  |    8 ++++----
 drivers/staging/iio/industrialio-trigger.c |    3 +--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 6b9c752..9d0ca12 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -16,9 +16,7 @@
 #include "chrdev.h"
 
 /* IIO TODO LIST */
-/* Static device specific elements (conversion factors etc)
- * should be exported via sysfs
- *
+/*
  * Provide means of adjusting timer accuracy.
  * Currently assumes nano seconds.
  */
@@ -385,7 +383,9 @@ void iio_put(void);
  **/
 void iio_get(void);
 
-/* Ring buffer related */
+/**
+ * iio_device_get_chrdev_minor() - get an unused minor number
+ **/
 int iio_device_get_chrdev_minor(void);
 void iio_device_free_chrdev_minor(int val);
 
diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index 5682e61..ef088a4 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -31,7 +31,6 @@
  * Any other suggestions?
  */
 
-
 static DEFINE_IDR(iio_trigger_idr);
 static DEFINE_SPINLOCK(iio_trigger_idr_lock);
 
@@ -284,7 +283,7 @@ error_ret:
 EXPORT_SYMBOL(iio_trigger_dettach_poll_func);
 
 /**
- * iio_trigger_read_currrent() trigger consumer sysfs query which trigger
+ * iio_trigger_read_currrent() - trigger consumer sysfs query which trigger
  *
  * For trigger consumers the current_trigger interface allows the trigger
  * used by the device to be queried.
-- 
1.7.0.4
