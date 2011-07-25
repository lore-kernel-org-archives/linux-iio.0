Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/7] staging:iio:chrdev.h rationalization.
Date: Mon, 25 Jul 2011 14:18:35 +0100
Message-Id: <1311599921-15729-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1311599921-15729-1-git-send-email-jic23@cam.ac.uk>
References: <1311599921-15729-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Push some functions out of header and include this where it is needed
in other headers only.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/chrdev.h            |   32 -------------------------------
 drivers/staging/iio/iio.h               |    2 +-
 drivers/staging/iio/industrialio-core.c |   32 +++++++++++++++++++++++++++++++
 drivers/staging/iio/ring_generic.h      |    1 +
 4 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/iio/chrdev.h b/drivers/staging/iio/chrdev.h
index 3e31ee6..8a229e7 100644
--- a/drivers/staging/iio/chrdev.h
+++ b/drivers/staging/iio/chrdev.h
@@ -9,7 +9,6 @@
 
 #ifndef _IIO_CHRDEV_H_
 #define _IIO_CHRDEV_H_
-struct iio_dev;
 
 /**
  * struct iio_handler - Structure used to specify file operations
@@ -41,35 +40,4 @@ struct iio_event_data {
 	s64	timestamp;
 };
 
-/**
- * struct iio_detected_event_list - list element for events that have occurred
- * @list:		linked list header
- * @ev:			the event itself
- */
-struct iio_detected_event_list {
-	struct list_head		list;
-	struct iio_event_data		ev;
-};
-
-/**
- * struct iio_event_interface - chrdev interface for an event line
- * @dev:		device assocated with event interface
- * @handler:		fileoperations and related control for the chrdev
- * @wait:		wait queue to allow blocking reads of events
- * @event_list_lock:	mutex to protect the list of detected events
- * @det_events:		list of detected events
- * @max_events:		maximum number of events before new ones are dropped
- * @current_events:	number of events in detected list
- */
-struct iio_event_interface {
-	struct device				dev;
-	struct iio_handler			handler;
-	wait_queue_head_t			wait;
-	struct mutex				event_list_lock;
-	struct list_head			det_events;
-	int					max_events;
-	int					current_events;
-	struct list_head dev_attr_list;
-};
-
 #endif
diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 16abb37..e2c971f 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -15,7 +15,6 @@
 #include <linux/cdev.h>
 #include <linux/irq.h>
 #include "sysfs.h"
-#include "chrdev.h"
 
 /* IIO TODO LIST */
 /*
@@ -178,6 +177,7 @@ static inline s64 iio_get_time_ns(void)
 #define IIO_VAL_INT_PLUS_NANO 3
 
 struct iio_trigger; /* forward declaration */
+struct iio_dev;
 
 /**
  * struct iio_info - constant information about device
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 123841b..f9d1744 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -24,6 +24,7 @@
 #include "iio.h"
 #include "iio_core.h"
 #include "iio_core_trigger.h"
+#include "chrdev.h"
 
 #define IIO_ID_PREFIX "device"
 #define IIO_ID_FORMAT IIO_ID_PREFIX "%d"
@@ -117,6 +118,37 @@ static void iio_free_ida_val(struct ida *this_ida, int id)
 	spin_unlock(&iio_ida_lock);
 }
 
+/**
+ * struct iio_detected_event_list - list element for events that have occurred
+ * @list:		linked list header
+ * @ev:			the event itself
+ */
+struct iio_detected_event_list {
+	struct list_head		list;
+	struct iio_event_data		ev;
+};
+
+/**
+ * struct iio_event_interface - chrdev interface for an event line
+ * @dev:		device assocated with event interface
+ * @handler:		fileoperations and related control for the chrdev
+ * @wait:		wait queue to allow blocking reads of events
+ * @event_list_lock:	mutex to protect the list of detected events
+ * @det_events:		list of detected events
+ * @max_events:		maximum number of events before new ones are dropped
+ * @current_events:	number of events in detected list
+ */
+struct iio_event_interface {
+	struct device				dev;
+	struct iio_handler			handler;
+	wait_queue_head_t			wait;
+	struct mutex				event_list_lock;
+	struct list_head			det_events;
+	int					max_events;
+	int					current_events;
+	struct list_head dev_attr_list;
+};
+
 int iio_push_event(struct iio_dev *dev_info,
 		   int ev_line,
 		   int ev_code,
diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio/ring_generic.h
index 3f26f71..d103262 100644
--- a/drivers/staging/iio/ring_generic.h
+++ b/drivers/staging/iio/ring_generic.h
@@ -10,6 +10,7 @@
 #ifndef _IIO_RING_GENERIC_H_
 #define _IIO_RING_GENERIC_H_
 #include "iio.h"
+#include "chrdev.h"
 
 #ifdef CONFIG_IIO_RING_BUFFER
 
-- 
1.7.3.4
