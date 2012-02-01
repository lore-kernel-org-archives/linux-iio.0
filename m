Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@suse.de>
CC: Jonathan Cameron <jic23@kernel.org>, <devel@driverdev.osuosl.org>,
	<linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 3/6] staging:iio:events: Use kfifo for event queue
Date: Wed, 1 Feb 2012 19:45:53 +0100
Message-ID: <1328121956-29596-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1328121956-29596-1-git-send-email-lars@metafoo.de>
References: <1328121956-29596-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

The current IIO event code uses a list to emulate FIFO like behavior.
Just use a kfifo directly instead to implement the event queue. As part of this
patch the maximum of events in the queue is increased from 10 to 16 since kfifo
requires a power of two for the number of FIFO elements.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/industrialio-event.c |   85 +++++++----------------------
 1 files changed, 21 insertions(+), 64 deletions(-)

diff --git a/drivers/staging/iio/industrialio-event.c b/drivers/staging/iio/industrialio-event.c
index a7b345d..335b615 100644
--- a/drivers/staging/iio/industrialio-event.c
+++ b/drivers/staging/iio/industrialio-event.c
@@ -13,6 +13,7 @@
 #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/kernel.h>
+#include <linux/kfifo.h>
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
@@ -24,22 +25,10 @@
 #include "events.h"
 
 /**
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
  * struct iio_event_interface - chrdev interface for an event line
  * @wait:		wait queue to allow blocking reads of events
  * @event_list_lock:	mutex to protect the list of detected events
  * @det_events:		list of detected events
- * @max_events:		maximum number of events before new ones are dropped
- * @current_events:	number of events in detected list
  * @dev_attr_list:	list of event interface sysfs attribute
  * @flags:		file operations related flags including busy flag.
  * @group:		event interface sysfs attribute group
@@ -47,9 +36,8 @@ struct iio_detected_event_list {
 struct iio_event_interface {
 	wait_queue_head_t	wait;
 	struct mutex		event_list_lock;
-	struct list_head	det_events;
-	int			max_events;
-	int			current_events;
+	DECLARE_KFIFO(det_events, struct iio_event_data, 16);
+
 	struct list_head	dev_attr_list;
 	unsigned long		flags;
 	struct attribute_group	group;
@@ -58,34 +46,25 @@ struct iio_event_interface {
 int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp)
 {
 	struct iio_event_interface *ev_int = indio_dev->event_interface;
-	struct iio_detected_event_list *ev;
-	int ret = 0;
+	struct iio_event_data ev;
+	int copied;
 
 	/* Does anyone care? */
 	mutex_lock(&ev_int->event_list_lock);
 	if (test_bit(IIO_BUSY_BIT_POS, &ev_int->flags)) {
-		if (ev_int->current_events == ev_int->max_events) {
-			mutex_unlock(&ev_int->event_list_lock);
-			return 0;
-		}
-		ev = kmalloc(sizeof(*ev), GFP_KERNEL);
-		if (ev == NULL) {
-			ret = -ENOMEM;
-			mutex_unlock(&ev_int->event_list_lock);
-			goto error_ret;
-		}
-		ev->ev.id = ev_code;
-		ev->ev.timestamp = timestamp;
 
-		list_add_tail(&ev->list, &ev_int->det_events);
-		ev_int->current_events++;
+		ev.id = ev_code;
+		ev.timestamp = timestamp;
+
+		copied = kfifo_put(&ev_int->det_events, &ev);
+
 		mutex_unlock(&ev_int->event_list_lock);
-		wake_up_interruptible(&ev_int->wait);
+		if (copied != 0)
+			wake_up_interruptible(&ev_int->wait);
 	} else
 		mutex_unlock(&ev_int->event_list_lock);
 
-error_ret:
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL(iio_push_event);
 
@@ -95,15 +74,14 @@ static ssize_t iio_event_chrdev_read(struct file *filep,
 				     loff_t *f_ps)
 {
 	struct iio_event_interface *ev_int = filep->private_data;
-	struct iio_detected_event_list *el;
-	size_t len = sizeof(el->ev);
+	unsigned int copied;
 	int ret;
 
-	if (count < len)
+	if (count < sizeof(struct iio_event_data))
 		return -EINVAL;
 
 	mutex_lock(&ev_int->event_list_lock);
-	if (list_empty(&ev_int->det_events)) {
+	if (kfifo_is_empty(&ev_int->det_events)) {
 		if (filep->f_flags & O_NONBLOCK) {
 			ret = -EAGAIN;
 			goto error_mutex_unlock;
@@ -111,39 +89,25 @@ static ssize_t iio_event_chrdev_read(struct file *filep,
 		mutex_unlock(&ev_int->event_list_lock);
 		/* Blocking on device; waiting for something to be there */
 		ret = wait_event_interruptible(ev_int->wait,
-					       !list_empty(&ev_int
-							   ->det_events));
+					!kfifo_is_empty(&ev_int->det_events));
 		if (ret)
 			goto error_ret;
 		/* Single access device so no one else can get the data */
 		mutex_lock(&ev_int->event_list_lock);
 	}
 
-	el = list_first_entry(&ev_int->det_events,
-			      struct iio_detected_event_list,
-			      list);
-	if (copy_to_user(buf, &(el->ev), len)) {
-		ret = -EFAULT;
-		goto error_mutex_unlock;
-	}
-	list_del(&el->list);
-	ev_int->current_events--;
 	mutex_unlock(&ev_int->event_list_lock);
-	kfree(el);
-
-	return len;
+	ret = kfifo_to_user(&ev_int->det_events, buf, count, &copied);
 
 error_mutex_unlock:
 	mutex_unlock(&ev_int->event_list_lock);
 error_ret:
-
-	return ret;
+	return ret ? ret : copied;
 }
 
 static int iio_event_chrdev_release(struct inode *inode, struct file *filep)
 {
 	struct iio_event_interface *ev_int = filep->private_data;
-	struct iio_detected_event_list *el, *t;
 
 	mutex_lock(&ev_int->event_list_lock);
 	clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
@@ -152,11 +116,7 @@ static int iio_event_chrdev_release(struct inode *inode, struct file *filep)
 	 * clear out any awaiting events. The mask will prevent
 	 * any new __iio_push_event calls running.
 	 */
-	list_for_each_entry_safe(el, t, &ev_int->det_events, list) {
-		list_del(&el->list);
-		kfree(el);
-	}
-	ev_int->current_events = 0;
+	kfifo_reset_out(&ev_int->det_events);
 	mutex_unlock(&ev_int->event_list_lock);
 
 	return 0;
@@ -401,10 +361,7 @@ static bool iio_check_for_dynamic_events(struct iio_dev *indio_dev)
 static void iio_setup_ev_int(struct iio_event_interface *ev_int)
 {
 	mutex_init(&ev_int->event_list_lock);
-	/* discussion point - make this variable? */
-	ev_int->max_events = 10;
-	ev_int->current_events = 0;
-	INIT_LIST_HEAD(&ev_int->det_events);
+	INIT_KFIFO(ev_int->det_events);
 	init_waitqueue_head(&ev_int->wait);
 }
 
-- 
1.7.8.3
