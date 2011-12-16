Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	<linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/4] staging:iio: Factor out event handling into its own file
Date: Fri, 16 Dec 2011 18:12:19 +0100
Message-ID: <1324055542-31272-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

The core iio file has gotten quite cluttered over time. This patch moves
the event handling code into its own file.

This has also the advantage that industrialio-core.c is now closer again to
its counterpart in the outofstaging branch.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/Makefile             |    2 +-
 drivers/staging/iio/iio_core.h           |    4 +
 drivers/staging/iio/industrialio-core.c  |  458 ----------------------------
 drivers/staging/iio/industrialio-event.c |  484 ++++++++++++++++++++++++++++++
 4 files changed, 489 insertions(+), 459 deletions(-)
 create mode 100644 drivers/staging/iio/industrialio-event.c

diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index 1340aea..657710b 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -3,7 +3,7 @@
 #
 
 obj-$(CONFIG_IIO) += industrialio.o
-industrialio-y := industrialio-core.o
+industrialio-y := industrialio-core.o industrialio-event.o
 industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
 industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
 
diff --git a/drivers/staging/iio/iio_core.h b/drivers/staging/iio/iio_core.h
index ff27f13..3b20de3 100644
--- a/drivers/staging/iio/iio_core.h
+++ b/drivers/staging/iio/iio_core.h
@@ -60,4 +60,8 @@ static inline void iio_chrdev_buffer_release(struct iio_dev *indio_dev)
 
 #endif
 
+int iio_device_register_eventset(struct iio_dev *indio_dev);
+void iio_device_unregister_eventset(struct iio_dev *indio_dev);
+int iio_event_getfd(struct iio_dev *indio_dev);
+
 #endif
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 2eef85f..3089307 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -100,71 +100,6 @@ const struct iio_chan_spec
 	return NULL;
 }
 
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
- * @wait:		wait queue to allow blocking reads of events
- * @event_list_lock:	mutex to protect the list of detected events
- * @det_events:		list of detected events
- * @max_events:		maximum number of events before new ones are dropped
- * @current_events:	number of events in detected list
- * @flags:		file operations related flags including busy flag.
- */
-struct iio_event_interface {
-	wait_queue_head_t			wait;
-	struct mutex				event_list_lock;
-	struct list_head			det_events;
-	int					max_events;
-	int					current_events;
-	struct list_head dev_attr_list;
-	unsigned long flags;
-	struct attribute_group			group;
-};
-
-int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp)
-{
-	struct iio_event_interface *ev_int = indio_dev->event_interface;
-	struct iio_detected_event_list *ev;
-	int ret = 0;
-
-	/* Does anyone care? */
-	mutex_lock(&ev_int->event_list_lock);
-	if (test_bit(IIO_BUSY_BIT_POS, &ev_int->flags)) {
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
-
-		list_add_tail(&ev->list, &ev_int->det_events);
-		ev_int->current_events++;
-		mutex_unlock(&ev_int->event_list_lock);
-		wake_up_interruptible(&ev_int->wait);
-	} else
-		mutex_unlock(&ev_int->event_list_lock);
-
-error_ret:
-	return ret;
-}
-EXPORT_SYMBOL(iio_push_event);
-
 /* This turns up an awful lot */
 ssize_t iio_read_const_attr(struct device *dev,
 			    struct device_attribute *attr,
@@ -174,110 +109,6 @@ ssize_t iio_read_const_attr(struct device *dev,
 }
 EXPORT_SYMBOL(iio_read_const_attr);
 
-static ssize_t iio_event_chrdev_read(struct file *filep,
-				     char __user *buf,
-				     size_t count,
-				     loff_t *f_ps)
-{
-	struct iio_event_interface *ev_int = filep->private_data;
-	struct iio_detected_event_list *el;
-	size_t len = sizeof(el->ev);
-	int ret;
-
-	if (count < len)
-		return -EINVAL;
-
-	mutex_lock(&ev_int->event_list_lock);
-	if (list_empty(&ev_int->det_events)) {
-		if (filep->f_flags & O_NONBLOCK) {
-			ret = -EAGAIN;
-			goto error_mutex_unlock;
-		}
-		mutex_unlock(&ev_int->event_list_lock);
-		/* Blocking on device; waiting for something to be there */
-		ret = wait_event_interruptible(ev_int->wait,
-					       !list_empty(&ev_int
-							   ->det_events));
-		if (ret)
-			goto error_ret;
-		/* Single access device so no one else can get the data */
-		mutex_lock(&ev_int->event_list_lock);
-	}
-
-	el = list_first_entry(&ev_int->det_events,
-			      struct iio_detected_event_list,
-			      list);
-	if (copy_to_user(buf, &(el->ev), len)) {
-		ret = -EFAULT;
-		goto error_mutex_unlock;
-	}
-	list_del(&el->list);
-	ev_int->current_events--;
-	mutex_unlock(&ev_int->event_list_lock);
-	kfree(el);
-
-	return len;
-
-error_mutex_unlock:
-	mutex_unlock(&ev_int->event_list_lock);
-error_ret:
-
-	return ret;
-}
-
-static int iio_event_chrdev_release(struct inode *inode, struct file *filep)
-{
-	struct iio_event_interface *ev_int = filep->private_data;
-	struct iio_detected_event_list *el, *t;
-
-	mutex_lock(&ev_int->event_list_lock);
-	clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
-	/*
-	 * In order to maintain a clean state for reopening,
-	 * clear out any awaiting events. The mask will prevent
-	 * any new __iio_push_event calls running.
-	 */
-	list_for_each_entry_safe(el, t, &ev_int->det_events, list) {
-		list_del(&el->list);
-		kfree(el);
-	}
-	ev_int->current_events = 0;
-	mutex_unlock(&ev_int->event_list_lock);
-
-	return 0;
-}
-
-static const struct file_operations iio_event_chrdev_fileops = {
-	.read =  iio_event_chrdev_read,
-	.release = iio_event_chrdev_release,
-	.owner = THIS_MODULE,
-	.llseek = noop_llseek,
-};
-
-static int iio_event_getfd(struct iio_dev *indio_dev)
-{
-	struct iio_event_interface *ev_int = indio_dev->event_interface;
-	int fd;
-
-	if (ev_int == NULL)
-		return -ENODEV;
-
-	mutex_lock(&ev_int->event_list_lock);
-	if (test_and_set_bit(IIO_BUSY_BIT_POS, &ev_int->flags)) {
-		mutex_unlock(&ev_int->event_list_lock);
-		return -EBUSY;
-	}
-	mutex_unlock(&ev_int->event_list_lock);
-	fd = anon_inode_getfd("iio:event",
-				&iio_event_chrdev_fileops, ev_int, O_RDONLY);
-	if (fd < 0) {
-		mutex_lock(&ev_int->event_list_lock);
-		clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
-		mutex_unlock(&ev_int->event_list_lock);
-	}
-	return fd;
-}
-
 static int __init iio_init(void)
 {
 	int ret;
@@ -726,295 +557,6 @@ static void iio_device_unregister_sysfs(struct iio_dev *indio_dev)
 	kfree(indio_dev->chan_attr_group.attrs);
 }
 
-static const char * const iio_ev_type_text[] = {
-	[IIO_EV_TYPE_THRESH] = "thresh",
-	[IIO_EV_TYPE_MAG] = "mag",
-	[IIO_EV_TYPE_ROC] = "roc",
-	[IIO_EV_TYPE_THRESH_ADAPTIVE] = "thresh_adaptive",
-	[IIO_EV_TYPE_MAG_ADAPTIVE] = "mag_adaptive",
-};
-
-static const char * const iio_ev_dir_text[] = {
-	[IIO_EV_DIR_EITHER] = "either",
-	[IIO_EV_DIR_RISING] = "rising",
-	[IIO_EV_DIR_FALLING] = "falling"
-};
-
-static ssize_t iio_ev_state_store(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf,
-				  size_t len)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	int ret;
-	bool val;
-
-	ret = strtobool(buf, &val);
-	if (ret < 0)
-		return ret;
-
-	ret = indio_dev->info->write_event_config(indio_dev,
-						  this_attr->address,
-						  val);
-	return (ret < 0) ? ret : len;
-}
-
-static ssize_t iio_ev_state_show(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	int val = indio_dev->info->read_event_config(indio_dev,
-						     this_attr->address);
-
-	if (val < 0)
-		return val;
-	else
-		return sprintf(buf, "%d\n", val);
-}
-
-static ssize_t iio_ev_value_show(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	int val, ret;
-
-	ret = indio_dev->info->read_event_value(indio_dev,
-						this_attr->address, &val);
-	if (ret < 0)
-		return ret;
-
-	return sprintf(buf, "%d\n", val);
-}
-
-static ssize_t iio_ev_value_store(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf,
-				  size_t len)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	unsigned long val;
-	int ret;
-
-	if (!indio_dev->info->write_event_value)
-		return -EINVAL;
-
-	ret = strict_strtoul(buf, 10, &val);
-	if (ret)
-		return ret;
-
-	ret = indio_dev->info->write_event_value(indio_dev, this_attr->address,
-						 val);
-	if (ret < 0)
-		return ret;
-
-	return len;
-}
-
-static int iio_device_add_event_sysfs(struct iio_dev *indio_dev,
-				      struct iio_chan_spec const *chan)
-{
-	int ret = 0, i, attrcount = 0;
-	u64 mask = 0;
-	char *postfix;
-	if (!chan->event_mask)
-		return 0;
-
-	for_each_set_bit(i, &chan->event_mask, sizeof(chan->event_mask)*8) {
-		postfix = kasprintf(GFP_KERNEL, "%s_%s_en",
-				    iio_ev_type_text[i/IIO_EV_DIR_MAX],
-				    iio_ev_dir_text[i%IIO_EV_DIR_MAX]);
-		if (postfix == NULL) {
-			ret = -ENOMEM;
-			goto error_ret;
-		}
-		if (chan->modified)
-			mask = IIO_MOD_EVENT_CODE(chan->type, 0, chan->channel,
-						  i/IIO_EV_DIR_MAX,
-						  i%IIO_EV_DIR_MAX);
-		else if (chan->differential)
-			mask = IIO_EVENT_CODE(chan->type,
-					      0, 0,
-					      i%IIO_EV_DIR_MAX,
-					      i/IIO_EV_DIR_MAX,
-					      0,
-					      chan->channel,
-					      chan->channel2);
-		else
-			mask = IIO_UNMOD_EVENT_CODE(chan->type,
-						    chan->channel,
-						    i/IIO_EV_DIR_MAX,
-						    i%IIO_EV_DIR_MAX);
-
-		ret = __iio_add_chan_devattr(postfix,
-					     chan,
-					     &iio_ev_state_show,
-					     iio_ev_state_store,
-					     mask,
-					     0,
-					     &indio_dev->dev,
-					     &indio_dev->event_interface->
-					     dev_attr_list);
-		kfree(postfix);
-		if (ret)
-			goto error_ret;
-		attrcount++;
-		postfix = kasprintf(GFP_KERNEL, "%s_%s_value",
-				    iio_ev_type_text[i/IIO_EV_DIR_MAX],
-				    iio_ev_dir_text[i%IIO_EV_DIR_MAX]);
-		if (postfix == NULL) {
-			ret = -ENOMEM;
-			goto error_ret;
-		}
-		ret = __iio_add_chan_devattr(postfix, chan,
-					     iio_ev_value_show,
-					     iio_ev_value_store,
-					     mask,
-					     0,
-					     &indio_dev->dev,
-					     &indio_dev->event_interface->
-					     dev_attr_list);
-		kfree(postfix);
-		if (ret)
-			goto error_ret;
-		attrcount++;
-	}
-	ret = attrcount;
-error_ret:
-	return ret;
-}
-
-static inline void __iio_remove_event_config_attrs(struct iio_dev *indio_dev)
-{
-	struct iio_dev_attr *p, *n;
-	list_for_each_entry_safe(p, n,
-				 &indio_dev->event_interface->
-				 dev_attr_list, l) {
-		kfree(p->dev_attr.attr.name);
-		kfree(p);
-	}
-}
-
-static inline int __iio_add_event_config_attrs(struct iio_dev *indio_dev)
-{
-	int j, ret, attrcount = 0;
-
-	INIT_LIST_HEAD(&indio_dev->event_interface->dev_attr_list);
-	/* Dynically created from the channels array */
-	for (j = 0; j < indio_dev->num_channels; j++) {
-		ret = iio_device_add_event_sysfs(indio_dev,
-						 &indio_dev->channels[j]);
-		if (ret < 0)
-			goto error_clear_attrs;
-		attrcount += ret;
-	}
-	return attrcount;
-
-error_clear_attrs:
-	__iio_remove_event_config_attrs(indio_dev);
-
-	return ret;
-}
-
-static bool iio_check_for_dynamic_events(struct iio_dev *indio_dev)
-{
-	int j;
-
-	for (j = 0; j < indio_dev->num_channels; j++)
-		if (indio_dev->channels[j].event_mask != 0)
-			return true;
-	return false;
-}
-
-static void iio_setup_ev_int(struct iio_event_interface *ev_int)
-{
-	mutex_init(&ev_int->event_list_lock);
-	/* discussion point - make this variable? */
-	ev_int->max_events = 10;
-	ev_int->current_events = 0;
-	INIT_LIST_HEAD(&ev_int->det_events);
-	init_waitqueue_head(&ev_int->wait);
-}
-
-static const char *iio_event_group_name = "events";
-static int iio_device_register_eventset(struct iio_dev *indio_dev)
-{
-	struct iio_dev_attr *p;
-	int ret = 0, attrcount_orig = 0, attrcount, attrn;
-	struct attribute **attr;
-
-	if (!(indio_dev->info->event_attrs ||
-	      iio_check_for_dynamic_events(indio_dev)))
-		return 0;
-
-	indio_dev->event_interface =
-		kzalloc(sizeof(struct iio_event_interface), GFP_KERNEL);
-	if (indio_dev->event_interface == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-
-	iio_setup_ev_int(indio_dev->event_interface);
-	if (indio_dev->info->event_attrs != NULL) {
-		attr = indio_dev->info->event_attrs->attrs;
-		while (*attr++ != NULL)
-			attrcount_orig++;
-	}
-	attrcount = attrcount_orig;
-	if (indio_dev->channels) {
-		ret = __iio_add_event_config_attrs(indio_dev);
-		if (ret < 0)
-			goto error_free_setup_event_lines;
-		attrcount += ret;
-	}
-
-	indio_dev->event_interface->group.name = iio_event_group_name;
-	indio_dev->event_interface->group.attrs = kcalloc(attrcount + 1,
-							  sizeof(indio_dev->event_interface->group.attrs[0]),
-							  GFP_KERNEL);
-	if (indio_dev->event_interface->group.attrs == NULL) {
-		ret = -ENOMEM;
-		goto error_free_setup_event_lines;
-	}
-	if (indio_dev->info->event_attrs)
-		memcpy(indio_dev->event_interface->group.attrs,
-		       indio_dev->info->event_attrs->attrs,
-		       sizeof(indio_dev->event_interface->group.attrs[0])
-		       *attrcount_orig);
-	attrn = attrcount_orig;
-	/* Add all elements from the list. */
-	list_for_each_entry(p,
-			    &indio_dev->event_interface->dev_attr_list,
-			    l)
-		indio_dev->event_interface->group.attrs[attrn++] =
-			&p->dev_attr.attr;
-	indio_dev->groups[indio_dev->groupcounter++] =
-		&indio_dev->event_interface->group;
-
-	return 0;
-
-error_free_setup_event_lines:
-	__iio_remove_event_config_attrs(indio_dev);
-	kfree(indio_dev->event_interface);
-error_ret:
-
-	return ret;
-}
-
-static void iio_device_unregister_eventset(struct iio_dev *indio_dev)
-{
-	if (indio_dev->event_interface == NULL)
-		return;
-	__iio_remove_event_config_attrs(indio_dev);
-	kfree(indio_dev->event_interface->group.attrs);
-	kfree(indio_dev->event_interface);
-}
-
 static void iio_dev_release(struct device *device)
 {
 	struct iio_dev *indio_dev = container_of(device, struct iio_dev, dev);
diff --git a/drivers/staging/iio/industrialio-event.c b/drivers/staging/iio/industrialio-event.c
new file mode 100644
index 0000000..17ed582
--- /dev/null
+++ b/drivers/staging/iio/industrialio-event.c
@@ -0,0 +1,484 @@
+/* The industrial I/O core
+ *
+ * Copyright (c) 2008 Jonathan Cameron
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * Based on elements of hwmon and input subsystems.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/poll.h>
+#include <linux/wait.h>
+#include <linux/cdev.h>
+#include <linux/slab.h>
+#include <linux/kfifo.h>
+#include <linux/anon_inodes.h>
+#include "iio.h"
+#include "iio_core.h"
+#include "sysfs.h"
+#include "events.h"
+
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
+ * @wait:		wait queue to allow blocking reads of events
+ * @event_list_lock:	mutex to protect the list of detected events
+ * @det_events:		list of detected events
+ * @max_events:		maximum number of events before new ones are dropped
+ * @current_events:	number of events in detected list
+ * @flags:		file operations related flags including busy flag.
+ */
+struct iio_event_interface {
+	wait_queue_head_t			wait;
+	struct mutex				event_list_lock;
+	struct list_head			det_events;
+	int					max_events;
+	int					current_events;
+	struct list_head dev_attr_list;
+	unsigned long flags;
+	struct attribute_group			group;
+};
+
+int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp)
+{
+	struct iio_event_interface *ev_int = indio_dev->event_interface;
+	struct iio_detected_event_list *ev;
+	int ret = 0;
+
+	/* Does anyone care? */
+	mutex_lock(&ev_int->event_list_lock);
+	if (test_bit(IIO_BUSY_BIT_POS, &ev_int->flags)) {
+		if (ev_int->current_events == ev_int->max_events) {
+			mutex_unlock(&ev_int->event_list_lock);
+			return 0;
+		}
+		ev = kmalloc(sizeof(*ev), GFP_KERNEL);
+		if (ev == NULL) {
+			ret = -ENOMEM;
+			mutex_unlock(&ev_int->event_list_lock);
+			goto error_ret;
+		}
+		ev->ev.id = ev_code;
+		ev->ev.timestamp = timestamp;
+
+		list_add_tail(&ev->list, &ev_int->det_events);
+		ev_int->current_events++;
+		mutex_unlock(&ev_int->event_list_lock);
+		wake_up_interruptible(&ev_int->wait);
+	} else
+		mutex_unlock(&ev_int->event_list_lock);
+
+error_ret:
+	return ret;
+}
+EXPORT_SYMBOL(iio_push_event);
+
+static ssize_t iio_event_chrdev_read(struct file *filep,
+				     char __user *buf,
+				     size_t count,
+				     loff_t *f_ps)
+{
+	struct iio_event_interface *ev_int = filep->private_data;
+	struct iio_detected_event_list *el;
+	size_t len = sizeof(el->ev);
+	int ret;
+
+	if (count < len)
+		return -EINVAL;
+
+	mutex_lock(&ev_int->event_list_lock);
+	if (list_empty(&ev_int->det_events)) {
+		if (filep->f_flags & O_NONBLOCK) {
+			ret = -EAGAIN;
+			goto error_mutex_unlock;
+		}
+		mutex_unlock(&ev_int->event_list_lock);
+		/* Blocking on device; waiting for something to be there */
+		ret = wait_event_interruptible(ev_int->wait,
+					       !list_empty(&ev_int
+							   ->det_events));
+		if (ret)
+			goto error_ret;
+		/* Single access device so no one else can get the data */
+		mutex_lock(&ev_int->event_list_lock);
+	}
+
+	el = list_first_entry(&ev_int->det_events,
+			      struct iio_detected_event_list,
+			      list);
+	if (copy_to_user(buf, &(el->ev), len)) {
+		ret = -EFAULT;
+		goto error_mutex_unlock;
+	}
+	list_del(&el->list);
+	ev_int->current_events--;
+	mutex_unlock(&ev_int->event_list_lock);
+	kfree(el);
+
+	return len;
+
+error_mutex_unlock:
+	mutex_unlock(&ev_int->event_list_lock);
+error_ret:
+
+	return ret;
+}
+
+static int iio_event_chrdev_release(struct inode *inode, struct file *filep)
+{
+	struct iio_event_interface *ev_int = filep->private_data;
+	struct iio_detected_event_list *el, *t;
+
+	mutex_lock(&ev_int->event_list_lock);
+	clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
+	/*
+	 * In order to maintain a clean state for reopening,
+	 * clear out any awaiting events. The mask will prevent
+	 * any new __iio_push_event calls running.
+	 */
+	list_for_each_entry_safe(el, t, &ev_int->det_events, list) {
+		list_del(&el->list);
+		kfree(el);
+	}
+	ev_int->current_events = 0;
+	mutex_unlock(&ev_int->event_list_lock);
+
+	return 0;
+}
+
+static const struct file_operations iio_event_chrdev_fileops = {
+	.read =  iio_event_chrdev_read,
+	.release = iio_event_chrdev_release,
+	.owner = THIS_MODULE,
+	.llseek = noop_llseek,
+};
+
+int iio_event_getfd(struct iio_dev *indio_dev)
+{
+	struct iio_event_interface *ev_int = indio_dev->event_interface;
+	int fd;
+
+	if (ev_int == NULL)
+		return -ENODEV;
+
+	mutex_lock(&ev_int->event_list_lock);
+	if (test_and_set_bit(IIO_BUSY_BIT_POS, &ev_int->flags)) {
+		mutex_unlock(&ev_int->event_list_lock);
+		return -EBUSY;
+	}
+	mutex_unlock(&ev_int->event_list_lock);
+	fd = anon_inode_getfd("iio:event",
+				&iio_event_chrdev_fileops, ev_int, O_RDONLY);
+	if (fd < 0) {
+		mutex_lock(&ev_int->event_list_lock);
+		clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
+		mutex_unlock(&ev_int->event_list_lock);
+	}
+	return fd;
+}
+
+static const char * const iio_ev_type_text[] = {
+	[IIO_EV_TYPE_THRESH] = "thresh",
+	[IIO_EV_TYPE_MAG] = "mag",
+	[IIO_EV_TYPE_ROC] = "roc",
+	[IIO_EV_TYPE_THRESH_ADAPTIVE] = "thresh_adaptive",
+	[IIO_EV_TYPE_MAG_ADAPTIVE] = "mag_adaptive",
+};
+
+static const char * const iio_ev_dir_text[] = {
+	[IIO_EV_DIR_EITHER] = "either",
+	[IIO_EV_DIR_RISING] = "rising",
+	[IIO_EV_DIR_FALLING] = "falling"
+};
+
+static ssize_t iio_ev_state_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf,
+				  size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	int ret;
+	bool val;
+
+	ret = strtobool(buf, &val);
+	if (ret < 0)
+		return ret;
+
+	ret = indio_dev->info->write_event_config(indio_dev,
+						  this_attr->address,
+						  val);
+	return (ret < 0) ? ret : len;
+}
+
+static ssize_t iio_ev_state_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	int val = indio_dev->info->read_event_config(indio_dev,
+						     this_attr->address);
+
+	if (val < 0)
+		return val;
+	else
+		return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t iio_ev_value_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	int val, ret;
+
+	ret = indio_dev->info->read_event_value(indio_dev,
+						this_attr->address, &val);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t iio_ev_value_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf,
+				  size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	unsigned long val;
+	int ret;
+
+	if (!indio_dev->info->write_event_value)
+		return -EINVAL;
+
+	ret = strict_strtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	ret = indio_dev->info->write_event_value(indio_dev, this_attr->address,
+						 val);
+	if (ret < 0)
+		return ret;
+
+	return len;
+}
+
+static int iio_device_add_event_sysfs(struct iio_dev *indio_dev,
+				      struct iio_chan_spec const *chan)
+{
+	int ret = 0, i, attrcount = 0;
+	u64 mask = 0;
+	char *postfix;
+	if (!chan->event_mask)
+		return 0;
+
+	for_each_set_bit(i, &chan->event_mask, sizeof(chan->event_mask)*8) {
+		postfix = kasprintf(GFP_KERNEL, "%s_%s_en",
+				    iio_ev_type_text[i/IIO_EV_DIR_MAX],
+				    iio_ev_dir_text[i%IIO_EV_DIR_MAX]);
+		if (postfix == NULL) {
+			ret = -ENOMEM;
+			goto error_ret;
+		}
+		if (chan->modified)
+			mask = IIO_MOD_EVENT_CODE(chan->type, 0, chan->channel,
+						  i/IIO_EV_DIR_MAX,
+						  i%IIO_EV_DIR_MAX);
+		else if (chan->differential)
+			mask = IIO_EVENT_CODE(chan->type,
+					      0, 0,
+					      i%IIO_EV_DIR_MAX,
+					      i/IIO_EV_DIR_MAX,
+					      0,
+					      chan->channel,
+					      chan->channel2);
+		else
+			mask = IIO_UNMOD_EVENT_CODE(chan->type,
+						    chan->channel,
+						    i/IIO_EV_DIR_MAX,
+						    i%IIO_EV_DIR_MAX);
+
+		ret = __iio_add_chan_devattr(postfix,
+					     chan,
+					     &iio_ev_state_show,
+					     iio_ev_state_store,
+					     mask,
+					     0,
+					     &indio_dev->dev,
+					     &indio_dev->event_interface->
+					     dev_attr_list);
+		kfree(postfix);
+		if (ret)
+			goto error_ret;
+		attrcount++;
+		postfix = kasprintf(GFP_KERNEL, "%s_%s_value",
+				    iio_ev_type_text[i/IIO_EV_DIR_MAX],
+				    iio_ev_dir_text[i%IIO_EV_DIR_MAX]);
+		if (postfix == NULL) {
+			ret = -ENOMEM;
+			goto error_ret;
+		}
+		ret = __iio_add_chan_devattr(postfix, chan,
+					     iio_ev_value_show,
+					     iio_ev_value_store,
+					     mask,
+					     0,
+					     &indio_dev->dev,
+					     &indio_dev->event_interface->
+					     dev_attr_list);
+		kfree(postfix);
+		if (ret)
+			goto error_ret;
+		attrcount++;
+	}
+	ret = attrcount;
+error_ret:
+	return ret;
+}
+
+static inline void __iio_remove_event_config_attrs(struct iio_dev *indio_dev)
+{
+	struct iio_dev_attr *p, *n;
+	list_for_each_entry_safe(p, n,
+				 &indio_dev->event_interface->
+				 dev_attr_list, l) {
+		kfree(p->dev_attr.attr.name);
+		kfree(p);
+	}
+}
+
+static inline int __iio_add_event_config_attrs(struct iio_dev *indio_dev)
+{
+	int j, ret, attrcount = 0;
+
+	INIT_LIST_HEAD(&indio_dev->event_interface->dev_attr_list);
+	/* Dynically created from the channels array */
+	for (j = 0; j < indio_dev->num_channels; j++) {
+		ret = iio_device_add_event_sysfs(indio_dev,
+						 &indio_dev->channels[j]);
+		if (ret < 0)
+			goto error_clear_attrs;
+		attrcount += ret;
+	}
+	return attrcount;
+
+error_clear_attrs:
+	__iio_remove_event_config_attrs(indio_dev);
+
+	return ret;
+}
+
+static bool iio_check_for_dynamic_events(struct iio_dev *indio_dev)
+{
+	int j;
+
+	for (j = 0; j < indio_dev->num_channels; j++)
+		if (indio_dev->channels[j].event_mask != 0)
+			return true;
+	return false;
+}
+
+static void iio_setup_ev_int(struct iio_event_interface *ev_int)
+{
+	mutex_init(&ev_int->event_list_lock);
+	/* discussion point - make this variable? */
+	ev_int->max_events = 10;
+	ev_int->current_events = 0;
+	INIT_LIST_HEAD(&ev_int->det_events);
+	init_waitqueue_head(&ev_int->wait);
+}
+
+static const char *iio_event_group_name = "events";
+int iio_device_register_eventset(struct iio_dev *indio_dev)
+{
+	struct iio_dev_attr *p;
+	int ret = 0, attrcount_orig = 0, attrcount, attrn;
+	struct attribute **attr;
+
+	if (!(indio_dev->info->event_attrs ||
+	      iio_check_for_dynamic_events(indio_dev)))
+		return 0;
+
+	indio_dev->event_interface =
+		kzalloc(sizeof(struct iio_event_interface), GFP_KERNEL);
+	if (indio_dev->event_interface == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+
+	iio_setup_ev_int(indio_dev->event_interface);
+	if (indio_dev->info->event_attrs != NULL) {
+		attr = indio_dev->info->event_attrs->attrs;
+		while (*attr++ != NULL)
+			attrcount_orig++;
+	}
+	attrcount = attrcount_orig;
+	if (indio_dev->channels) {
+		ret = __iio_add_event_config_attrs(indio_dev);
+		if (ret < 0)
+			goto error_free_setup_event_lines;
+		attrcount += ret;
+	}
+
+	indio_dev->event_interface->group.name = iio_event_group_name;
+	indio_dev->event_interface->group.attrs = kcalloc(attrcount + 1,
+							  sizeof(indio_dev->event_interface->group.attrs[0]),
+							  GFP_KERNEL);
+	if (indio_dev->event_interface->group.attrs == NULL) {
+		ret = -ENOMEM;
+		goto error_free_setup_event_lines;
+	}
+	if (indio_dev->info->event_attrs)
+		memcpy(indio_dev->event_interface->group.attrs,
+		       indio_dev->info->event_attrs->attrs,
+		       sizeof(indio_dev->event_interface->group.attrs[0])
+		       *attrcount_orig);
+	attrn = attrcount_orig;
+	/* Add all elements from the list. */
+	list_for_each_entry(p,
+			    &indio_dev->event_interface->dev_attr_list,
+			    l)
+		indio_dev->event_interface->group.attrs[attrn++] =
+			&p->dev_attr.attr;
+	indio_dev->groups[indio_dev->groupcounter++] =
+		&indio_dev->event_interface->group;
+
+	return 0;
+
+error_free_setup_event_lines:
+	__iio_remove_event_config_attrs(indio_dev);
+	kfree(indio_dev->event_interface);
+error_ret:
+
+	return ret;
+}
+
+void iio_device_unregister_eventset(struct iio_dev *indio_dev)
+{
+	if (indio_dev->event_interface == NULL)
+		return;
+	__iio_remove_event_config_attrs(indio_dev);
+	kfree(indio_dev->event_interface->group.attrs);
+	kfree(indio_dev->event_interface);
+}
-- 
1.7.7.3
