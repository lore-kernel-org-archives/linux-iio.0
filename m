Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:55799 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839Ab1GYNSl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jul 2011 09:18:41 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 4/7] staging:iio: squash chrdev handler remains into users.
Date: Mon, 25 Jul 2011 14:18:38 +0100
Message-Id: <1311599921-15729-5-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1311599921-15729-1-git-send-email-jic23@cam.ac.uk>
References: <1311599921-15729-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This no longer has any purpose given all chrdevs are pretty much the same
now the event interfaces are done via anon fds

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/chrdev.h            |   19 -------------------
 drivers/staging/iio/industrialio-core.c |   29 ++++++++++-------------------
 drivers/staging/iio/industrialio-ring.c |   28 +++++++++++++---------------
 drivers/staging/iio/ring_generic.h      |    5 +++--
 4 files changed, 26 insertions(+), 55 deletions(-)

diff --git a/drivers/staging/iio/chrdev.h b/drivers/staging/iio/chrdev.h
index c6bd04c..28cce12 100644
--- a/drivers/staging/iio/chrdev.h
+++ b/drivers/staging/iio/chrdev.h
@@ -11,25 +11,6 @@
 #define _IIO_CHRDEV_H_
 
 /**
- * struct iio_handler - Structure used to specify file operations
- *			for a particular chrdev
- * @chrdev:	character device structure
- * @id:		the location in the handler table - used for deallocation.
- * @flags:	file operations related flags including busy flag.
- * @private:	handler specific data used by the fileops registered with
- *		the chrdev.
- */
-struct iio_handler {
-	struct cdev	chrdev;
-	int		id;
-	unsigned long	flags;
-	void		*private;
-};
-
-#define iio_cdev_to_handler(cd)				\
-	container_of(cd, struct iio_handler, chrdev)
-
-/**
  * struct iio_event_data - The actual event being pushed to userspace
  * @id:		event identifier
  * @timestamp:	best estimate of time of event occurrence (often from
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index c6a55f0..d0470ed 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -129,25 +129,24 @@ struct iio_detected_event_list {
 	struct iio_event_data		ev;
 };
 
-
 /**
  * struct iio_event_interface - chrdev interface for an event line
  * @dev:		device assocated with event interface
- * @handler:		fileoperations and related control for the chrdev
  * @wait:		wait queue to allow blocking reads of events
  * @event_list_lock:	mutex to protect the list of detected events
  * @det_events:		list of detected events
  * @max_events:		maximum number of events before new ones are dropped
  * @current_events:	number of events in detected list
+ * @flags:		file operations related flags including busy flag.
  */
 struct iio_event_interface {
-	struct iio_handler			handler;
 	wait_queue_head_t			wait;
 	struct mutex				event_list_lock;
 	struct list_head			det_events;
 	int					max_events;
 	int					current_events;
 	struct list_head dev_attr_list;
+	unsigned long flags;
 };
 
 int iio_push_event(struct iio_dev *dev_info,
@@ -162,7 +161,7 @@ int iio_push_event(struct iio_dev *dev_info,
 
 	/* Does anyone care? */
 	mutex_lock(&ev_int->event_list_lock);
-	if (test_bit(IIO_BUSY_BIT_POS, &ev_int->handler.flags)) {
+	if (test_bit(IIO_BUSY_BIT_POS, &ev_int->flags)) {
 		if (ev_int->current_events == ev_int->max_events) {
 			mutex_unlock(&ev_int->event_list_lock);
 			return 0;
@@ -188,6 +187,7 @@ error_ret:
 }
 EXPORT_SYMBOL(iio_push_event);
 
+
 /* This turns up an awful lot */
 ssize_t iio_read_const_attr(struct device *dev,
 			    struct device_attribute *attr,
@@ -207,6 +207,7 @@ static ssize_t iio_event_chrdev_read(struct file *filep,
 	struct iio_detected_event_list *el;
 	int ret;
 	size_t len;
+
 	mutex_lock(&ev_int->event_list_lock);
 	if (list_empty(&ev_int->det_events)) {
 		if (filep->f_flags & O_NONBLOCK) {
@@ -250,8 +251,9 @@ static int iio_event_chrdev_release(struct inode *inode, struct file *filep)
 {
 	struct iio_event_interface *ev_int = filep->private_data;
 	struct iio_detected_event_list *el, *t;
+
 	mutex_lock(&ev_int->event_list_lock);
-	clear_bit(IIO_BUSY_BIT_POS, &ev_int->handler.flags);
+	clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
 	/*
 	 * In order to maintain a clean state for reopening,
 	 * clear out any awaiting events. The mask will prevent
@@ -297,7 +299,7 @@ int iio_event_getfd(struct iio_dev *indio_dev)
 
 	mutex_lock(&indio_dev->event_interfaces->event_list_lock);
 	if (test_and_set_bit(IIO_BUSY_BIT_POS,
-			     &indio_dev->event_interfaces->handler.flags)) {
+			     &indio_dev->event_interfaces->flags)) {
 		mutex_unlock(&indio_dev->event_interfaces->event_list_lock);
 		return -EBUSY;
 	}
@@ -307,11 +309,7 @@ int iio_event_getfd(struct iio_dev *indio_dev)
 				&indio_dev->event_interfaces[0], O_RDONLY);
 }
 
-static void iio_setup_ev_int(struct iio_event_interface *ev_int,
-			    const char *dev_name,
-			    int index,
-			    struct module *owner,
-			    struct device *dev)
+static void iio_setup_ev_int(struct iio_event_interface *ev_int)
 {
 	mutex_init(&ev_int->event_list_lock);
 	/* discussion point - make this variable? */
@@ -319,8 +317,6 @@ static void iio_setup_ev_int(struct iio_event_interface *ev_int,
 	ev_int->current_events = 0;
 	INIT_LIST_HEAD(&ev_int->det_events);
 	init_waitqueue_head(&ev_int->wait);
-	ev_int->handler.private = ev_int;
-	ev_int->handler.flags = 0;
 }
 
 static int __init iio_init(void)
@@ -1003,12 +999,7 @@ static int iio_device_register_eventset(struct iio_dev *dev_info)
 	}
 
 	for (i = 0; i < dev_info->info->num_interrupt_lines; i++) {
-		iio_setup_ev_int(&dev_info->event_interfaces[i],
-				 dev_name(&dev_info->dev),
-				 i,
-				 dev_info->info->driver_module,
-				 &dev_info->dev);
-
+		iio_setup_ev_int(&dev_info->event_interfaces[i]);
 		if (dev_info->info->event_attrs != NULL)
 			ret = sysfs_create_group(&dev_info->dev.kobj,
 						 &dev_info->info
diff --git a/drivers/staging/iio/industrialio-ring.c b/drivers/staging/iio/industrialio-ring.c
index e4554be..cce02244 100644
--- a/drivers/staging/iio/industrialio-ring.c
+++ b/drivers/staging/iio/industrialio-ring.c
@@ -32,11 +32,10 @@
  **/
 static int iio_ring_open(struct inode *inode, struct file *filp)
 {
-	struct iio_handler *hand
-		= container_of(inode->i_cdev, struct iio_handler, chrdev);
-	struct iio_ring_buffer *rb = hand->private;
-
-	filp->private_data = hand->private;
+	struct iio_ring_buffer *rb
+		= container_of(inode->i_cdev,
+			       struct iio_ring_buffer, chrdev);
+	filp->private_data = rb;
 	if (rb->access->mark_in_use)
 		rb->access->mark_in_use(rb);
 
@@ -51,11 +50,11 @@ static int iio_ring_open(struct inode *inode, struct file *filp)
  **/
 static int iio_ring_release(struct inode *inode, struct file *filp)
 {
-	struct cdev *cd = inode->i_cdev;
-	struct iio_handler *hand = iio_cdev_to_handler(cd);
-	struct iio_ring_buffer *rb = hand->private;
+	struct iio_ring_buffer *rb
+		= container_of(inode->i_cdev,
+			       struct iio_ring_buffer, chrdev);
 
-	clear_bit(IIO_BUSY_BIT_POS, &rb->access_handler.flags);
+	clear_bit(IIO_BUSY_BIT_POS, &rb->flags);
 	if (rb->access->unmark_in_use)
 		rb->access->unmark_in_use(rb);
 
@@ -127,7 +126,7 @@ void iio_ring_access_release(struct device *dev)
 {
 	struct iio_ring_buffer *buf
 		= container_of(dev, struct iio_ring_buffer, dev);
-	cdev_del(&buf->access_handler.chrdev);
+	cdev_del(&buf->chrdev);
 	iio_device_free_chrdev_minor(MINOR(dev->devt));
 }
 EXPORT_SYMBOL(iio_ring_access_release);
@@ -139,7 +138,7 @@ __iio_request_ring_buffer_chrdev(struct iio_ring_buffer *buf,
 {
 	int ret;
 
-	buf->access_handler.flags = 0;
+	buf->flags = 0;
 	buf->dev.bus = &iio_bus_type;
 	device_initialize(&buf->dev);
 
@@ -156,9 +155,9 @@ __iio_request_ring_buffer_chrdev(struct iio_ring_buffer *buf,
 		printk(KERN_ERR "failed to add the ring dev\n");
 		goto error_device_put;
 	}
-	cdev_init(&buf->access_handler.chrdev, &iio_ring_fileops);
-	buf->access_handler.chrdev.owner = owner;
-	ret = cdev_add(&buf->access_handler.chrdev, buf->dev.devt, 1);
+	cdev_init(&buf->chrdev, &iio_ring_fileops);
+	buf->chrdev.owner = owner;
+	ret = cdev_add(&buf->chrdev, buf->dev.devt, 1);
 	if (ret) {
 		printk(KERN_ERR "failed to allocate ring chrdev\n");
 		goto error_device_unregister;
@@ -182,7 +181,6 @@ void iio_ring_buffer_init(struct iio_ring_buffer *ring,
 			  struct iio_dev *dev_info)
 {
 	ring->indio_dev = dev_info;
-	ring->access_handler.private = ring;
 	init_waitqueue_head(&ring->pollq);
 }
 EXPORT_SYMBOL(iio_ring_buffer_init);
diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio/ring_generic.h
index d103262..81bbe39 100644
--- a/drivers/staging/iio/ring_generic.h
+++ b/drivers/staging/iio/ring_generic.h
@@ -85,13 +85,13 @@ struct iio_ring_setup_ops {
  * @scan_count:	[INTERN] the number of elements in the current scan mode
  * @scan_mask:		[INTERN] bitmask used in masking scan mode elements
  * @scan_timestamp:	[INTERN] does the scan mode include a timestamp
- * @access_handler:	[INTERN] chrdev access handling
  * @access:		[DRIVER] ring access functions associated with the
  *			implementation.
  * @preenable:		[DRIVER] function to run prior to marking ring enabled
  * @postenable:		[DRIVER] function to run after marking ring enabled
  * @predisable:		[DRIVER] function to run prior to marking ring disabled
  * @postdisable:	[DRIVER] function to run after marking ring disabled
+ * @flags:		[INTERN] file ops related flags including busy flag.
  **/
 struct iio_ring_buffer {
 	struct device				dev;
@@ -104,13 +104,14 @@ struct iio_ring_buffer {
 	int					scan_count;
 	unsigned long				scan_mask;
 	bool					scan_timestamp;
-	struct iio_handler			access_handler;
 	const struct iio_ring_access_funcs	*access;
 	const struct iio_ring_setup_ops		*setup_ops;
 	struct list_head			scan_el_dev_attr_list;
 
 	wait_queue_head_t			pollq;
 	bool					stufftoread;
+	unsigned long				flags;
+	struct cdev				chrdev;
 };
 
 /**
-- 
1.7.3.4

