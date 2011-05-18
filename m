Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:54128 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933254Ab1ERNkI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 May 2011 09:40:08 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 091/111] staging:iio: iio_event_interfaces - clean out unused elements
Date: Wed, 18 May 2011 14:42:21 +0100
Message-Id: <1305726161-5606-92-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Also removed const casting of _name that was unnecessary.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/chrdev.h            |    8 +-------
 drivers/staging/iio/industrialio-core.c |   18 +++++++-----------
 2 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/iio/chrdev.h b/drivers/staging/iio/chrdev.h
index 10491f0..6523273 100644
--- a/drivers/staging/iio/chrdev.h
+++ b/drivers/staging/iio/chrdev.h
@@ -60,24 +60,18 @@ struct iio_detected_event_list {
  * @det_events:		list of detected events
  * @max_events:		maximum number of events before new ones are dropped
  * @current_events:	number of events in detected list
- * @owner:		ensure the driver module owns the file, not iio
- * @private:		driver specific data
  * @_name:		used internally to store the sysfs name for minor id
  *			attribute
- * @_attrname:		the event interface's attribute name
  */
 struct iio_event_interface {
 	struct device				dev;
 	struct iio_handler			handler;
 	wait_queue_head_t			wait;
 	struct mutex				event_list_lock;
-	struct iio_detected_event_list		det_events;
+	struct list_head			det_events;
 	int					max_events;
 	int					current_events;
-	struct module				*owner;
-	void					*private;
 	char					_name[35];
-	char					_attrname[20];
 	struct list_head dev_attr_list;
 };
 
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 49560e4..b5b658c 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -112,7 +112,7 @@ int iio_push_event(struct iio_dev *dev_info,
 		ev->ev.id = ev_code;
 		ev->ev.timestamp = timestamp;
 
-		list_add_tail(&ev->list, &ev_int->det_events.list);
+		list_add_tail(&ev->list, &ev_int->det_events);
 		ev_int->current_events++;
 		mutex_unlock(&ev_int->event_list_lock);
 		wake_up_interruptible(&ev_int->wait);
@@ -146,7 +146,7 @@ static ssize_t iio_event_chrdev_read(struct file *filep,
 	size_t len;
 
 	mutex_lock(&ev_int->event_list_lock);
-	if (list_empty(&ev_int->det_events.list)) {
+	if (list_empty(&ev_int->det_events)) {
 		if (filep->f_flags & O_NONBLOCK) {
 			ret = -EAGAIN;
 			goto error_mutex_unlock;
@@ -155,14 +155,14 @@ static ssize_t iio_event_chrdev_read(struct file *filep,
 		/* Blocking on device; waiting for something to be there */
 		ret = wait_event_interruptible(ev_int->wait,
 					       !list_empty(&ev_int
-							   ->det_events.list));
+							   ->det_events));
 		if (ret)
 			goto error_ret;
 		/* Single access device so no one else can get the data */
 		mutex_lock(&ev_int->event_list_lock);
 	}
 
-	el = list_first_entry(&ev_int->det_events.list,
+	el = list_first_entry(&ev_int->det_events,
 			      struct iio_detected_event_list,
 			      list);
 	len = sizeof el->ev;
@@ -197,7 +197,7 @@ static int iio_event_chrdev_release(struct inode *inode, struct file *filep)
 	 * clear out any awaiting events. The mask will prevent
 	 * any new __iio_push_event calls running.
 	 */
-	list_for_each_entry_safe(el, t, &ev_int->det_events.list, list) {
+	list_for_each_entry_safe(el, t, &ev_int->det_events, list) {
 		list_del(&el->list);
 		kfree(el);
 	}
@@ -300,7 +300,7 @@ static int iio_setup_ev_int(struct iio_event_interface *ev_int,
 	/* discussion point - make this variable? */
 	ev_int->max_events = 10;
 	ev_int->current_events = 0;
-	INIT_LIST_HEAD(&ev_int->det_events.list);
+	INIT_LIST_HEAD(&ev_int->det_events);
 	init_waitqueue_head(&ev_int->wait);
 	ev_int->handler.private = ev_int;
 	ev_int->handler.flags = 0;
@@ -1041,17 +1041,13 @@ static int iio_device_register_eventset(struct iio_dev *dev_info)
 	}
 
 	for (i = 0; i < dev_info->num_interrupt_lines; i++) {
-		dev_info->event_interfaces[i].owner = dev_info->driver_module;
-
 		snprintf(dev_info->event_interfaces[i]._name, 20,
 			 "%s:event%d",
 			 dev_name(&dev_info->dev),
 			 i);
 
 		ret = iio_setup_ev_int(&dev_info->event_interfaces[i],
-				       (const char *)(dev_info
-						      ->event_interfaces[i]
-						      ._name),
+				       dev_info->event_interfaces[i]._name,
 				       dev_info->driver_module,
 				       &dev_info->dev);
 		if (ret) {
-- 
1.7.3.4

