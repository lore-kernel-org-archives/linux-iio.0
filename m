Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:47926 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405Ab1GRNuF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2011 09:50:05 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de, manuel.stahl@iis.fraunhofer.de,
	device-drivers-devel@blackfin.uclinux.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 4/7] staging:iio: remove specific chrdev for event reading. Get fd from ioctl on buffer.
Date: Mon, 18 Jul 2011 14:50:01 +0100
Message-Id: <1310997004-22728-5-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1310997004-22728-1-git-send-email-jic23@cam.ac.uk>
References: <1310997004-22728-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Change suggested by Arnd Bergmann.

No real reason to have two chrdevs per device. This step merges them into one.
Currently this means that events will only work on devices with buffers. THat will
be remedied shortly.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio.h               |    1 +
 drivers/staging/iio/industrialio-core.c |  174 ++++++++++--------------------
 drivers/staging/iio/industrialio-ring.c |   23 ++++-
 3 files changed, 81 insertions(+), 117 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index cf43e71..308b100 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -247,6 +247,7 @@ struct iio_info {
 
 };
 
+int iio_event_getfd(struct iio_dev *indio_dev);
 /**
  * struct iio_dev - industrial I/O device
  * @id:			[INTERN] used to identify device internally
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index f9d1744..31ebc3a 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -21,6 +21,7 @@
 #include <linux/wait.h>
 #include <linux/cdev.h>
 #include <linux/slab.h>
+#include <linux/anon_inodes.h>
 #include "iio.h"
 #include "iio_core.h"
 #include "iio_core_trigger.h"
@@ -128,6 +129,7 @@ struct iio_detected_event_list {
 	struct iio_event_data		ev;
 };
 
+
 /**
  * struct iio_event_interface - chrdev interface for an event line
  * @dev:		device assocated with event interface
@@ -139,7 +141,6 @@ struct iio_detected_event_list {
  * @current_events:	number of events in detected list
  */
 struct iio_event_interface {
-	struct device				dev;
 	struct iio_handler			handler;
 	wait_queue_head_t			wait;
 	struct mutex				event_list_lock;
@@ -187,7 +188,6 @@ error_ret:
 }
 EXPORT_SYMBOL(iio_push_event);
 
-
 /* This turns up an awful lot */
 ssize_t iio_read_const_attr(struct device *dev,
 			    struct device_attribute *attr,
@@ -207,7 +207,6 @@ static ssize_t iio_event_chrdev_read(struct file *filep,
 	struct iio_detected_event_list *el;
 	int ret;
 	size_t len;
-
 	mutex_lock(&ev_int->event_list_lock);
 	if (list_empty(&ev_int->det_events)) {
 		if (filep->f_flags & O_NONBLOCK) {
@@ -249,10 +248,8 @@ error_ret:
 
 static int iio_event_chrdev_release(struct inode *inode, struct file *filep)
 {
-	struct iio_handler *hand = iio_cdev_to_handler(inode->i_cdev);
-	struct iio_event_interface *ev_int = hand->private;
+	struct iio_event_interface *ev_int = filep->private_data;
 	struct iio_detected_event_list *el, *t;
-
 	mutex_lock(&ev_int->event_list_lock);
 	clear_bit(IIO_BUSY_BIT_POS, &ev_int->handler.flags);
 	/*
@@ -264,23 +261,7 @@ static int iio_event_chrdev_release(struct inode *inode, struct file *filep)
 		list_del(&el->list);
 		kfree(el);
 	}
-	mutex_unlock(&ev_int->event_list_lock);
-
-	return 0;
-}
-
-static int iio_event_chrdev_open(struct inode *inode, struct file *filep)
-{
-	struct iio_handler *hand = iio_cdev_to_handler(inode->i_cdev);
-	struct iio_event_interface *ev_int = hand->private;
-
-	mutex_lock(&ev_int->event_list_lock);
-	if (test_and_set_bit(IIO_BUSY_BIT_POS, &hand->flags)) {
-		fops_put(filep->f_op);
-		mutex_unlock(&ev_int->event_list_lock);
-		return -EBUSY;
-	}
-	filep->private_data = hand->private;
+	ev_int->current_events = 0;
 	mutex_unlock(&ev_int->event_list_lock);
 
 	return 0;
@@ -289,23 +270,10 @@ static int iio_event_chrdev_open(struct inode *inode, struct file *filep)
 static const struct file_operations iio_event_chrdev_fileops = {
 	.read =  iio_event_chrdev_read,
 	.release = iio_event_chrdev_release,
-	.open = iio_event_chrdev_open,
 	.owner = THIS_MODULE,
 	.llseek = noop_llseek,
 };
 
-static void iio_event_dev_release(struct device *dev)
-{
-	struct iio_event_interface *ev_int
-		= container_of(dev, struct iio_event_interface, dev);
-	cdev_del(&ev_int->handler.chrdev);
-	iio_device_free_chrdev_minor(MINOR(dev->devt));
-};
-
-static struct device_type iio_event_type = {
-	.release = iio_event_dev_release,
-};
-
 int iio_device_get_chrdev_minor(void)
 {
 	int ret;
@@ -322,34 +290,28 @@ void iio_device_free_chrdev_minor(int val)
 	iio_free_ida_val(&iio_chrdev_ida, val);
 }
 
-static int iio_setup_ev_int(struct iio_event_interface *ev_int,
+int iio_event_getfd(struct iio_dev *indio_dev) {
+	if (indio_dev->event_interfaces == NULL)
+		return -ENODEV;
+
+	mutex_lock(&indio_dev->event_interfaces->event_list_lock);
+	if (test_and_set_bit(IIO_BUSY_BIT_POS,
+			     &indio_dev->event_interfaces->handler.flags )) {
+		mutex_unlock(&indio_dev->event_interfaces->event_list_lock);
+		return -EBUSY;
+	}
+	mutex_unlock(&indio_dev->event_interfaces->event_list_lock);
+	return anon_inode_getfd("iio:event",
+				      &iio_event_chrdev_fileops,
+				      &indio_dev->event_interfaces[0], O_RDONLY);
+}
+
+static void iio_setup_ev_int(struct iio_event_interface *ev_int,
 			    const char *dev_name,
 			    int index,
 			    struct module *owner,
 			    struct device *dev)
 {
-	int ret, minor;
-
-	ev_int->dev.bus = &iio_bus_type;
-	ev_int->dev.parent = dev;
-	ev_int->dev.type = &iio_event_type;
-	device_initialize(&ev_int->dev);
-
-	minor = iio_device_get_chrdev_minor();
-	if (minor < 0) {
-		ret = minor;
-		goto error_device_put;
-	}
-	ev_int->dev.devt = MKDEV(MAJOR(iio_devt), minor);
-	dev_set_name(&ev_int->dev, "%s:event%d", dev_name, index);
-
-	ret = device_add(&ev_int->dev);
-	if (ret)
-		goto error_free_minor;
-
-	cdev_init(&ev_int->handler.chrdev, &iio_event_chrdev_fileops);
-	ev_int->handler.chrdev.owner = owner;
-
 	mutex_init(&ev_int->event_list_lock);
 	/* discussion point - make this variable? */
 	ev_int->max_events = 10;
@@ -358,27 +320,6 @@ static int iio_setup_ev_int(struct iio_event_interface *ev_int,
 	init_waitqueue_head(&ev_int->wait);
 	ev_int->handler.private = ev_int;
 	ev_int->handler.flags = 0;
-
-	ret = cdev_add(&ev_int->handler.chrdev, ev_int->dev.devt, 1);
-	if (ret)
-		goto error_unreg_device;
-
-	return 0;
-
-error_unreg_device:
-	device_unregister(&ev_int->dev);
-error_free_minor:
-	iio_device_free_chrdev_minor(minor);
-error_device_put:
-	put_device(&ev_int->dev);
-
-	return ret;
-}
-
-static void iio_free_ev_int(struct iio_event_interface *ev_int)
-{
-	device_unregister(&ev_int->dev);
-	put_device(&ev_int->dev);
 }
 
 static int __init iio_init(void)
@@ -955,7 +896,7 @@ static int iio_device_add_event_sysfs(struct iio_dev *dev_info,
 			printk(KERN_INFO "currently unhandled type of event\n");
 		}
 		ret = __iio_add_chan_devattr(postfix,
-					     NULL,
+					     "events",
 					     chan,
 					     &iio_ev_state_show,
 					     iio_ev_state_store,
@@ -965,7 +906,7 @@ static int iio_device_add_event_sysfs(struct iio_dev *dev_info,
 					       extending the bitmask - but
 					       how far*/
 					     0,
-					     &dev_info->event_interfaces[0].dev,
+					     &dev_info->dev,
 					     &dev_info->event_interfaces[0].
 					     dev_attr_list);
 		kfree(postfix);
@@ -979,13 +920,12 @@ static int iio_device_add_event_sysfs(struct iio_dev *dev_info,
 			ret = -ENOMEM;
 			goto error_ret;
 		}
-		ret = __iio_add_chan_devattr(postfix, NULL, chan,
+		ret = __iio_add_chan_devattr(postfix, "events", chan,
 					     iio_ev_value_show,
 					     iio_ev_value_store,
 					     mask,
 					     0,
-					     &dev_info->event_interfaces[0]
-					     .dev,
+					     &dev_info->dev,
 					     &dev_info->event_interfaces[0]
 					     .dev_attr_list);
 		kfree(postfix);
@@ -1005,8 +945,7 @@ static inline void __iio_remove_event_config_attrs(struct iio_dev *dev_info,
 	list_for_each_entry_safe(p, n,
 				 &dev_info->event_interfaces[i].
 				 dev_attr_list, l) {
-		sysfs_remove_file_from_group(&dev_info
-					     ->event_interfaces[i].dev.kobj,
+		sysfs_remove_file_from_group(&dev_info->dev.kobj,
 					     &p->dev_attr.attr,
 					     NULL);
 		kfree(p->dev_attr.attr.name);
@@ -1037,6 +976,15 @@ error_clear_attrs:
 	return ret;
 }
 
+static struct attribute *iio_events_dummy_attrs[] = {
+	NULL
+};
+
+static struct attribute_group iio_events_dummy_group = {
+	.name = "events",
+	.attrs = iio_events_dummy_attrs
+};
+
 static int iio_device_register_eventset(struct iio_dev *dev_info)
 {
 	int ret = 0, i, j;
@@ -1054,42 +1002,34 @@ static int iio_device_register_eventset(struct iio_dev *dev_info)
 	}
 
 	for (i = 0; i < dev_info->info->num_interrupt_lines; i++) {
-		ret = iio_setup_ev_int(&dev_info->event_interfaces[i],
-				       dev_name(&dev_info->dev),
-				       i,
-				       dev_info->info->driver_module,
-				       &dev_info->dev);
-		if (ret) {
-			dev_err(&dev_info->dev,
-				"Could not get chrdev interface\n");
-			goto error_free_setup_event_lines;
-		}
-
-		dev_set_drvdata(&dev_info->event_interfaces[i].dev,
-				(void *)dev_info);
+		//clean up parameters for this
+		iio_setup_ev_int(&dev_info->event_interfaces[i],
+				 dev_name(&dev_info->dev),
+				 i,
+				 dev_info->info->driver_module,
+				 &dev_info->dev);
 
 		if (dev_info->info->event_attrs != NULL)
-			ret = sysfs_create_group(&dev_info
-						 ->event_interfaces[i]
-						 .dev.kobj,
+			ret = sysfs_create_group(&dev_info->dev.kobj,
 						 &dev_info->info
 						 ->event_attrs[i]);
-
+		else
+			ret = sysfs_create_group(&dev_info->dev.kobj,
+						 &iio_events_dummy_group);
 		if (ret) {
 			dev_err(&dev_info->dev,
 				"Failed to register sysfs for event attrs");
-			iio_free_ev_int(&dev_info->event_interfaces[i]);
 			goto error_free_setup_event_lines;
 		}
 		ret = __iio_add_event_config_attrs(dev_info, i);
 		if (ret) {
 			if (dev_info->info->event_attrs != NULL)
-				sysfs_remove_group(&dev_info
-						   ->event_interfaces[i]
-						   .dev.kobj,
+				sysfs_remove_group(&dev_info->dev.kobj,
 						   &dev_info->info
 						   ->event_attrs[i]);
-			iio_free_ev_int(&dev_info->event_interfaces[i]);
+			else
+				sysfs_remove_group(&dev_info->dev.kobj,
+						   &iio_events_dummy_group);
 			goto error_free_setup_event_lines;
 		}
 	}
@@ -1099,11 +1039,12 @@ static int iio_device_register_eventset(struct iio_dev *dev_info)
 error_free_setup_event_lines:
 	for (j = 0; j < i; j++) {
 		__iio_remove_event_config_attrs(dev_info, j);
-		if (dev_info->info->event_attrs != NULL)
-			sysfs_remove_group(&dev_info
-					   ->event_interfaces[j].dev.kobj,
+		if (dev_info->info->event_attrs != NULL) {
+			sysfs_remove_group(&dev_info->dev.kobj,
 					   &dev_info->info->event_attrs[j]);
-		iio_free_ev_int(&dev_info->event_interfaces[j]);
+			sysfs_remove_group(&dev_info->dev.kobj,
+					   &iio_events_dummy_group);
+		}
 	}
 	kfree(dev_info->event_interfaces);
 error_ret:
@@ -1120,10 +1061,11 @@ static void iio_device_unregister_eventset(struct iio_dev *dev_info)
 	for (i = 0; i < dev_info->info->num_interrupt_lines; i++) {
 		__iio_remove_event_config_attrs(dev_info, i);
 		if (dev_info->info->event_attrs != NULL)
-			sysfs_remove_group(&dev_info
-					   ->event_interfaces[i].dev.kobj,
+			sysfs_remove_group(&dev_info->dev.kobj,
 					   &dev_info->info->event_attrs[i]);
-		iio_free_ev_int(&dev_info->event_interfaces[i]);
+		else
+			sysfs_remove_group(&dev_info->dev.kobj,
+					   &iio_events_dummy_group);
 	}
 	kfree(dev_info->event_interfaces);
 }
diff --git a/drivers/staging/iio/industrialio-ring.c b/drivers/staging/iio/industrialio-ring.c
index dce50b1..3c1b7f7 100644
--- a/drivers/staging/iio/industrialio-ring.c
+++ b/drivers/staging/iio/industrialio-ring.c
@@ -93,13 +93,34 @@ static unsigned int iio_ring_poll(struct file *filp,
 	return 0;
 }
 
-static const struct file_operations iio_ring_fileops = {
+/* Somewhat of a cross file organization violation - ioctls here are actually
+ * event related */
+static long iio_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
+{
+
+	struct iio_ring_buffer *rb = f->private_data;
+	struct iio_dev *indio_dev = rb->indio_dev;
+	int __user *ip = (int __user *)arg;
+
+	
+	if (cmd == 0) { //cleanup
+		int fd;
+		fd = iio_event_getfd(indio_dev);
+		if (copy_to_user(ip, &fd, sizeof(fd)))
+			return -EFAULT;
+		return 0;
+	}
+	return -EINVAL;
+}
+
+ const struct file_operations iio_ring_fileops = {
 	.read = iio_ring_read_first_n_outer,
 	.release = iio_ring_release,
 	.open = iio_ring_open,
 	.poll = iio_ring_poll,
 	.owner = THIS_MODULE,
 	.llseek = noop_llseek,
+	.unlocked_ioctl = iio_ioctl,
 };
 
 void iio_ring_access_release(struct device *dev)
-- 
1.7.3.4

