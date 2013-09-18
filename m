Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-014.synserver.de ([212.40.185.14]:1098 "EHLO
	smtp-out-011.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753651Ab3IRUB1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2013 16:01:27 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/10] iio: Wakeup poll and blocking reads when the device is unregistered
Date: Wed, 18 Sep 2013 22:02:52 +0200
Message-Id: <1379534574-11213-8-git-send-email-lars@metafoo.de>
In-Reply-To: <1379534574-11213-1-git-send-email-lars@metafoo.de>
References: <1379534574-11213-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Once the device has been unregistered there won't be any new data no matter how
long a userspace application waits, so we might as well wake them up and let
them know.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/iio_core.h            |  3 +++
 drivers/iio/industrialio-buffer.c | 16 ++++++++++++++++
 drivers/iio/industrialio-core.c   |  4 ++++
 drivers/iio/industrialio-event.c  | 21 ++++++++++++++++++++-
 4 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
index 9209f47..7512cf7 100644
--- a/drivers/iio/iio_core.h
+++ b/drivers/iio/iio_core.h
@@ -50,6 +50,7 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
 #define iio_buffer_read_first_n_outer_addr (&iio_buffer_read_first_n_outer)
 
 void iio_disable_all_buffers(struct iio_dev *indio_dev);
+void iio_buffer_wakeup_poll(struct iio_dev *indio_dev);
 
 #else
 
@@ -57,11 +58,13 @@ void iio_disable_all_buffers(struct iio_dev *indio_dev);
 #define iio_buffer_read_first_n_outer_addr NULL
 
 static inline void iio_disable_all_buffers(struct iio_dev *indio_dev) {}
+static inline void iio_buffer_wakeup_poll(struct iio_dev *indio_dev) {}
 
 #endif
 
 int iio_device_register_eventset(struct iio_dev *indio_dev);
 void iio_device_unregister_eventset(struct iio_dev *indio_dev);
+void iio_device_wakeup_eventset(struct iio_dev *indio_dev);
 int iio_event_getfd(struct iio_dev *indio_dev);
 
 #endif
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index e9cbde3..c28625a 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -20,6 +20,7 @@
 #include <linux/cdev.h>
 #include <linux/slab.h>
 #include <linux/poll.h>
+#include <linux/sched.h>
 
 #include <linux/iio/iio.h>
 #include "iio_core.h"
@@ -75,6 +76,21 @@ unsigned int iio_buffer_poll(struct file *filp,
 	return 0;
 }
 
+/**
+ * iio_buffer_wakeup_poll - Wakes up the buffer waitqueue
+ * @indio_dev: The IIO device
+ *
+ * Wakes up the event waitqueue used for poll(). Should usually
+ * be called when the device is unregistered.
+ */
+void iio_buffer_wakeup_poll(struct iio_dev *indio_dev)
+{
+	if (!indio_dev->buffer)
+		return;
+
+	wake_up(&indio_dev->buffer->pollq);
+}
+
 void iio_buffer_init(struct iio_buffer *buffer)
 {
 	INIT_LIST_HEAD(&buffer->demux_list);
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index dd7b601..88a77d9 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1140,6 +1140,10 @@ void iio_device_unregister(struct iio_dev *indio_dev)
 	iio_disable_all_buffers(indio_dev);
 
 	indio_dev->info = NULL;
+
+	iio_device_wakeup_eventset(indio_dev);
+	iio_buffer_wakeup_poll(indio_dev);
+
 	mutex_unlock(&indio_dev->info_exist_lock);
 }
 EXPORT_SYMBOL(iio_device_unregister);
diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index 3843abf..6aace88 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -113,9 +113,14 @@ static ssize_t iio_event_chrdev_read(struct file *filep,
 		}
 		/* Blocking on device; waiting for something to be there */
 		ret = wait_event_interruptible_locked_irq(ev_int->wait,
-					!kfifo_is_empty(&ev_int->det_events));
+					!kfifo_is_empty(&ev_int->det_events) ||
+					indio_dev->info == NULL);
 		if (ret)
 			goto error_unlock;
+		if (indio_dev->info == NULL) {
+			ret = -ENODEV;
+			goto error_unlock;
+		}
 		/* Single access device so no one else can get the data */
 	}
 
@@ -455,6 +460,20 @@ error_ret:
 	return ret;
 }
 
+/**
+ * iio_device_wakeup_eventset - Wakes up the event waitqueue
+ * @indio_dev: The IIO device
+ *
+ * Wakes up the event waitqueue used for poll() and blocking read().
+ * Should usually be called when the device is unregistered.
+ */
+void iio_device_wakeup_eventset(struct iio_dev *indio_dev)
+{
+	if (indio_dev->event_interface == NULL)
+		return;
+	wake_up(&indio_dev->event_interface->wait);
+}
+
 void iio_device_unregister_eventset(struct iio_dev *indio_dev)
 {
 	if (indio_dev->event_interface == NULL)
-- 
1.8.0

