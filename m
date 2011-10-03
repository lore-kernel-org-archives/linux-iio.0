Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:40236 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932195Ab1JCO7y (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 3 Oct 2011 10:59:54 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 3/6] staging:iio:core:naming: dev_info to indio_dev for consistency
Date: Mon,  3 Oct 2011 16:08:13 +0100
Message-Id: <1317654496-14484-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1317654496-14484-1-git-send-email-jic23@cam.ac.uk>
References: <1317654496-14484-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

We had a random missmatch of these two.  Lets pick the most common
and get rid of the other.  This patch covers the core.  Others
will clean up the drivers.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/buffer_generic.h       |    4 +-
 drivers/staging/iio/iio.h                  |   30 ++--
 drivers/staging/iio/iio_core_trigger.h     |   16 +-
 drivers/staging/iio/industrialio-buffer.c  |   78 +++++-----
 drivers/staging/iio/industrialio-core.c    |  218 ++++++++++++++--------------
 drivers/staging/iio/industrialio-trigger.c |   42 +++---
 6 files changed, 194 insertions(+), 194 deletions(-)

diff --git a/drivers/staging/iio/buffer_generic.h b/drivers/staging/iio/buffer_generic.h
index 548bb74..9e8f010 100644
--- a/drivers/staging/iio/buffer_generic.h
+++ b/drivers/staging/iio/buffer_generic.h
@@ -120,10 +120,10 @@ struct iio_buffer {
 /**
  * iio_buffer_init() - Initialize the buffer structure
  * @buffer: buffer to be initialized
- * @dev_info: the iio device the buffer is assocated with
+ * @indio_dev: the iio device the buffer is assocated with
  **/
 void iio_buffer_init(struct iio_buffer *buffer,
-			  struct iio_dev *dev_info);
+			  struct iio_dev *indio_dev);
 
 void iio_buffer_deinit(struct iio_buffer *buffer);
 
diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index a6aec66..1eedf2b 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -325,23 +325,23 @@ struct iio_dev {
 
 /**
  * iio_device_register() - register a device with the IIO subsystem
- * @dev_info:		Device structure filled by the device driver
+ * @indio_dev:		Device structure filled by the device driver
  **/
-int iio_device_register(struct iio_dev *dev_info);
+int iio_device_register(struct iio_dev *indio_dev);
 
 /**
  * iio_device_unregister() - unregister a device from the IIO subsystem
- * @dev_info:		Device structure representing the device.
+ * @indio_dev:		Device structure representing the device.
  **/
-void iio_device_unregister(struct iio_dev *dev_info);
+void iio_device_unregister(struct iio_dev *indio_dev);
 
 /**
  * iio_push_event() - try to add event to the list for userspace reading
- * @dev_info:		IIO device structure
+ * @indio_dev:		IIO device structure
  * @ev_code:		What event
  * @timestamp:		When the event occurred
  **/
-int iio_push_event(struct iio_dev *dev_info, u64 ev_code, s64 timestamp);
+int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
 
 extern struct bus_type iio_bus_type;
 
@@ -349,10 +349,10 @@ extern struct bus_type iio_bus_type;
  * iio_put_device() - reference counted deallocation of struct device
  * @dev: the iio_device containing the device
  **/
-static inline void iio_put_device(struct iio_dev *dev)
+static inline void iio_put_device(struct iio_dev *indio_dev)
 {
-	if (dev)
-		put_device(&dev->dev);
+	if (indio_dev)
+		put_device(&indio_dev->dev);
 };
 
 /* Can we make this smaller? */
@@ -363,9 +363,9 @@ static inline void iio_put_device(struct iio_dev *dev)
  **/
 struct iio_dev *iio_allocate_device(int sizeof_priv);
 
-static inline void *iio_priv(const struct iio_dev *dev)
+static inline void *iio_priv(const struct iio_dev *indio_dev)
 {
-	return (char *)dev + ALIGN(sizeof(struct iio_dev), IIO_ALIGN);
+	return (char *)indio_dev + ALIGN(sizeof(struct iio_dev), IIO_ALIGN);
 }
 
 static inline struct iio_dev *iio_priv_to_dev(void *priv)
@@ -378,15 +378,15 @@ static inline struct iio_dev *iio_priv_to_dev(void *priv)
  * iio_free_device() - free an iio_dev from a driver
  * @dev: the iio_dev associated with the device
  **/
-void iio_free_device(struct iio_dev *dev);
+void iio_free_device(struct iio_dev *indio_dev);
 
 /**
  * iio_buffer_enabled() - helper function to test if the buffer is enabled
- * @dev_info:		IIO device info structure for device
+ * @indio_dev:		IIO device info structure for device
  **/
-static inline bool iio_buffer_enabled(struct iio_dev *dev_info)
+static inline bool iio_buffer_enabled(struct iio_dev *indio_dev)
 {
-	return dev_info->currentmode
+	return indio_dev->currentmode
 		& (INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE);
 };
 
diff --git a/drivers/staging/iio/iio_core_trigger.h b/drivers/staging/iio/iio_core_trigger.h
index 7f1bdc7..6f7c56f 100644
--- a/drivers/staging/iio/iio_core_trigger.h
+++ b/drivers/staging/iio/iio_core_trigger.h
@@ -11,32 +11,32 @@
 #ifdef CONFIG_IIO_TRIGGER
 /**
  * iio_device_register_trigger_consumer() - set up an iio_dev to use triggers
- * @dev_info: iio_dev associated with the device that will consume the trigger
+ * @indio_dev: iio_dev associated with the device that will consume the trigger
  **/
-void iio_device_register_trigger_consumer(struct iio_dev *dev_info);
+void iio_device_register_trigger_consumer(struct iio_dev *indio_dev);
 
 /**
  * iio_device_unregister_trigger_consumer() - reverse the registration process
- * @dev_info: iio_dev associated with the device that consumed the trigger
+ * @indio_dev: iio_dev associated with the device that consumed the trigger
  **/
-void iio_device_unregister_trigger_consumer(struct iio_dev *dev_info);
+void iio_device_unregister_trigger_consumer(struct iio_dev *indio_dev);
 
 #else
 
 /**
  * iio_device_register_trigger_consumer() - set up an iio_dev to use triggers
- * @dev_info: iio_dev associated with the device that will consume the trigger
+ * @indio_dev: iio_dev associated with the device that will consume the trigger
  **/
-static int iio_device_register_trigger_consumer(struct iio_dev *dev_info)
+static int iio_device_register_trigger_consumer(struct iio_dev *indio_dev)
 {
 	return 0;
 };
 
 /**
  * iio_device_unregister_trigger_consumer() - reverse the registration process
- * @dev_info: iio_dev associated with the device that consumed the trigger
+ * @indio_dev: iio_dev associated with the device that consumed the trigger
  **/
-static void iio_device_unregister_trigger_consumer(struct iio_dev *dev_info)
+static void iio_device_unregister_trigger_consumer(struct iio_dev *indio_dev)
 {
 };
 
diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
index 4ce101a..d329949 100644
--- a/drivers/staging/iio/industrialio-buffer.c
+++ b/drivers/staging/iio/industrialio-buffer.c
@@ -82,9 +82,9 @@ void iio_chrdev_buffer_release(struct iio_dev *indio_dev)
 		rb->access->unmark_in_use(rb);
 }
 
-void iio_buffer_init(struct iio_buffer *buffer, struct iio_dev *dev_info)
+void iio_buffer_init(struct iio_buffer *buffer, struct iio_dev *indio_dev)
 {
-	buffer->indio_dev = dev_info;
+	buffer->indio_dev = indio_dev;
 	init_waitqueue_head(&buffer->pollq);
 }
 EXPORT_SYMBOL(iio_buffer_init);
@@ -122,9 +122,9 @@ static ssize_t iio_scan_el_show(struct device *dev,
 				char *buf)
 {
 	int ret;
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 
-	ret = iio_scan_mask_query(dev_info->buffer,
+	ret = iio_scan_mask_query(indio_dev->buffer,
 				  to_iio_dev_attr(attr)->address);
 	if (ret < 0)
 		return ret;
@@ -179,8 +179,8 @@ static ssize_t iio_scan_el_ts_show(struct device *dev,
 				   struct device_attribute *attr,
 				   char *buf)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	return sprintf(buf, "%d\n", dev_info->buffer->scan_timestamp);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	return sprintf(buf, "%d\n", indio_dev->buffer->scan_timestamp);
 }
 
 static ssize_t iio_scan_el_ts_store(struct device *dev,
@@ -426,11 +426,11 @@ ssize_t iio_buffer_store_enable(struct device *dev,
 	int ret;
 	bool requested_state, current_state;
 	int previous_mode;
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct iio_buffer *buffer = dev_info->buffer;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_buffer *buffer = indio_dev->buffer;
 
-	mutex_lock(&dev_info->mlock);
-	previous_mode = dev_info->currentmode;
+	mutex_lock(&indio_dev->mlock);
+	previous_mode = indio_dev->currentmode;
 	requested_state = !(buf[0] == '0');
 	current_state = !!(previous_mode & INDIO_ALL_BUFFER_MODES);
 	if (current_state == requested_state) {
@@ -439,7 +439,7 @@ ssize_t iio_buffer_store_enable(struct device *dev,
 	}
 	if (requested_state) {
 		if (buffer->setup_ops->preenable) {
-			ret = buffer->setup_ops->preenable(dev_info);
+			ret = buffer->setup_ops->preenable(indio_dev);
 			if (ret) {
 				printk(KERN_ERR
 				       "Buffer not started:"
@@ -459,8 +459,8 @@ ssize_t iio_buffer_store_enable(struct device *dev,
 		if (buffer->access->mark_in_use)
 			buffer->access->mark_in_use(buffer);
 		/* Definitely possible for devices to support both of these.*/
-		if (dev_info->modes & INDIO_BUFFER_TRIGGERED) {
-			if (!dev_info->trig) {
+		if (indio_dev->modes & INDIO_BUFFER_TRIGGERED) {
+			if (!indio_dev->trig) {
 				printk(KERN_INFO
 				       "Buffer not started: no trigger\n");
 				ret = -EINVAL;
@@ -468,50 +468,50 @@ ssize_t iio_buffer_store_enable(struct device *dev,
 					buffer->access->unmark_in_use(buffer);
 				goto error_ret;
 			}
-			dev_info->currentmode = INDIO_BUFFER_TRIGGERED;
-		} else if (dev_info->modes & INDIO_BUFFER_HARDWARE)
-			dev_info->currentmode = INDIO_BUFFER_HARDWARE;
+			indio_dev->currentmode = INDIO_BUFFER_TRIGGERED;
+		} else if (indio_dev->modes & INDIO_BUFFER_HARDWARE)
+			indio_dev->currentmode = INDIO_BUFFER_HARDWARE;
 		else { /* should never be reached */
 			ret = -EINVAL;
 			goto error_ret;
 		}
 
 		if (buffer->setup_ops->postenable) {
-			ret = buffer->setup_ops->postenable(dev_info);
+			ret = buffer->setup_ops->postenable(indio_dev);
 			if (ret) {
 				printk(KERN_INFO
 				       "Buffer not started:"
 				       "postenable failed\n");
 				if (buffer->access->unmark_in_use)
 					buffer->access->unmark_in_use(buffer);
-				dev_info->currentmode = previous_mode;
+				indio_dev->currentmode = previous_mode;
 				if (buffer->setup_ops->postdisable)
 					buffer->setup_ops->
-						postdisable(dev_info);
+						postdisable(indio_dev);
 				goto error_ret;
 			}
 		}
 	} else {
 		if (buffer->setup_ops->predisable) {
-			ret = buffer->setup_ops->predisable(dev_info);
+			ret = buffer->setup_ops->predisable(indio_dev);
 			if (ret)
 				goto error_ret;
 		}
 		if (buffer->access->unmark_in_use)
 			buffer->access->unmark_in_use(buffer);
-		dev_info->currentmode = INDIO_DIRECT_MODE;
+		indio_dev->currentmode = INDIO_DIRECT_MODE;
 		if (buffer->setup_ops->postdisable) {
-			ret = buffer->setup_ops->postdisable(dev_info);
+			ret = buffer->setup_ops->postdisable(indio_dev);
 			if (ret)
 				goto error_ret;
 		}
 	}
 done:
-	mutex_unlock(&dev_info->mlock);
+	mutex_unlock(&indio_dev->mlock);
 	return len;
 
 error_ret:
-	mutex_unlock(&dev_info->mlock);
+	mutex_unlock(&indio_dev->mlock);
 	return ret;
 }
 EXPORT_SYMBOL(iio_buffer_store_enable);
@@ -520,8 +520,8 @@ ssize_t iio_buffer_show_enable(struct device *dev,
 			       struct device_attribute *attr,
 			       char *buf)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	return sprintf(buf, "%d\n", !!(dev_info->currentmode
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	return sprintf(buf, "%d\n", !!(indio_dev->currentmode
 				       & INDIO_ALL_BUFFER_MODES));
 }
 EXPORT_SYMBOL(iio_buffer_show_enable);
@@ -574,34 +574,34 @@ static unsigned long *iio_scan_mask_match(unsigned long *av_masks,
  **/
 int iio_scan_mask_set(struct iio_buffer *buffer, int bit)
 {
-	struct iio_dev *dev_info = buffer->indio_dev;
+	struct iio_dev *indio_dev = buffer->indio_dev;
 	unsigned long *mask;
 	unsigned long *trialmask;
 
 	trialmask = kmalloc(sizeof(*trialmask)*
-			    BITS_TO_LONGS(dev_info->masklength),
+			    BITS_TO_LONGS(indio_dev->masklength),
 			    GFP_KERNEL);
 
 	if (trialmask == NULL)
 		return -ENOMEM;
-	if (!dev_info->masklength) {
+	if (!indio_dev->masklength) {
 		WARN_ON("trying to set scanmask prior to registering buffer\n");
 		kfree(trialmask);
 		return -EINVAL;
 	}
-	bitmap_copy(trialmask, buffer->scan_mask, dev_info->masklength);
+	bitmap_copy(trialmask, buffer->scan_mask, indio_dev->masklength);
 	set_bit(bit, trialmask);
 
-	if (dev_info->available_scan_masks) {
-		mask = iio_scan_mask_match(dev_info->available_scan_masks,
-					   dev_info->masklength,
+	if (indio_dev->available_scan_masks) {
+		mask = iio_scan_mask_match(indio_dev->available_scan_masks,
+					   indio_dev->masklength,
 					   trialmask);
 		if (!mask) {
 			kfree(trialmask);
 			return -EINVAL;
 		}
 	}
-	bitmap_copy(buffer->scan_mask, trialmask, dev_info->masklength);
+	bitmap_copy(buffer->scan_mask, trialmask, indio_dev->masklength);
 	buffer->scan_count++;
 
 	kfree(trialmask);
@@ -612,17 +612,17 @@ EXPORT_SYMBOL_GPL(iio_scan_mask_set);
 
 int iio_scan_mask_query(struct iio_buffer *buffer, int bit)
 {
-	struct iio_dev *dev_info = buffer->indio_dev;
+	struct iio_dev *indio_dev = buffer->indio_dev;
 	long *mask;
 
-	if (bit > dev_info->masklength)
+	if (bit > indio_dev->masklength)
 		return -EINVAL;
 
 	if (!buffer->scan_mask)
 		return 0;
-	if (dev_info->available_scan_masks)
-		mask = iio_scan_mask_match(dev_info->available_scan_masks,
-					   dev_info->masklength,
+	if (indio_dev->available_scan_masks)
+		mask = iio_scan_mask_match(indio_dev->available_scan_masks,
+					   indio_dev->masklength,
 					   buffer->scan_mask);
 	else
 		mask = buffer->scan_mask;
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index f776099..960aa7d 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -121,9 +121,9 @@ struct iio_event_interface {
 	struct attribute_group			group;
 };
 
-int iio_push_event(struct iio_dev *dev_info, u64 ev_code, s64 timestamp)
+int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp)
 {
-	struct iio_event_interface *ev_int = dev_info->event_interface;
+	struct iio_event_interface *ev_int = indio_dev->event_interface;
 	struct iio_detected_event_list *ev;
 	int ret = 0;
 
@@ -569,7 +569,7 @@ error_ret:
 	return ret;
 }
 
-static int iio_device_add_channel_sysfs(struct iio_dev *dev_info,
+static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 					struct iio_chan_spec const *chan)
 {
 	int ret, i, attrcount = 0;
@@ -584,8 +584,8 @@ static int iio_device_add_channel_sysfs(struct iio_dev *dev_info,
 				      &iio_write_channel_info : NULL),
 				     0,
 				     0,
-				     &dev_info->dev,
-				     &dev_info->channel_attr_list);
+				     &indio_dev->dev,
+				     &indio_dev->channel_attr_list);
 	if (ret)
 		goto error_ret;
 	attrcount++;
@@ -597,8 +597,8 @@ static int iio_device_add_channel_sysfs(struct iio_dev *dev_info,
 					     &iio_write_channel_info,
 					     (1 << i),
 					     !(i%2),
-					     &dev_info->dev,
-					     &dev_info->channel_attr_list);
+					     &indio_dev->dev,
+					     &indio_dev->channel_attr_list);
 		if (ret == -EBUSY && (i%2 == 0)) {
 			ret = 0;
 			continue;
@@ -612,7 +612,7 @@ error_ret:
 	return ret;
 }
 
-static void iio_device_remove_and_free_read_attr(struct iio_dev *dev_info,
+static void iio_device_remove_and_free_read_attr(struct iio_dev *indio_dev,
 						 struct iio_dev_attr *p)
 {
 	kfree(p->dev_attr.attr.name);
@@ -629,15 +629,15 @@ static ssize_t iio_show_dev_name(struct device *dev,
 
 static DEVICE_ATTR(name, S_IRUGO, iio_show_dev_name, NULL);
 
-static int iio_device_register_sysfs(struct iio_dev *dev_info)
+static int iio_device_register_sysfs(struct iio_dev *indio_dev)
 {
 	int i, ret = 0, attrcount, attrn, attrcount_orig = 0;
 	struct iio_dev_attr *p, *n;
 	struct attribute **attr;
 
 	/* First count elements in any existing group */
-	if (dev_info->info->attrs) {
-		attr = dev_info->info->attrs->attrs;
+	if (indio_dev->info->attrs) {
+		attr = indio_dev->info->attrs->attrs;
 		while (*attr++ != NULL)
 			attrcount_orig++;
 	}
@@ -646,66 +646,66 @@ static int iio_device_register_sysfs(struct iio_dev *dev_info)
 	 * New channel registration method - relies on the fact a group does
 	 *  not need to be initialized if it is name is NULL.
 	 */
-	INIT_LIST_HEAD(&dev_info->channel_attr_list);
-	if (dev_info->channels)
-		for (i = 0; i < dev_info->num_channels; i++) {
-			ret = iio_device_add_channel_sysfs(dev_info,
-							   &dev_info
+	INIT_LIST_HEAD(&indio_dev->channel_attr_list);
+	if (indio_dev->channels)
+		for (i = 0; i < indio_dev->num_channels; i++) {
+			ret = iio_device_add_channel_sysfs(indio_dev,
+							   &indio_dev
 							   ->channels[i]);
 			if (ret < 0)
 				goto error_clear_attrs;
 			attrcount += ret;
 		}
 
-	if (dev_info->name)
+	if (indio_dev->name)
 		attrcount++;
 
-	dev_info->chan_attr_group.attrs
-		= kzalloc(sizeof(dev_info->chan_attr_group.attrs[0])*
+	indio_dev->chan_attr_group.attrs
+		= kzalloc(sizeof(indio_dev->chan_attr_group.attrs[0])*
 			  (attrcount + 1),
 			  GFP_KERNEL);
-	if (dev_info->chan_attr_group.attrs == NULL) {
+	if (indio_dev->chan_attr_group.attrs == NULL) {
 		ret = -ENOMEM;
 		goto error_clear_attrs;
 	}
 	/* Copy across original attributes */
-	if (dev_info->info->attrs)
-		memcpy(dev_info->chan_attr_group.attrs,
-		       dev_info->info->attrs->attrs,
-		       sizeof(dev_info->chan_attr_group.attrs[0])
+	if (indio_dev->info->attrs)
+		memcpy(indio_dev->chan_attr_group.attrs,
+		       indio_dev->info->attrs->attrs,
+		       sizeof(indio_dev->chan_attr_group.attrs[0])
 		       *attrcount_orig);
 	attrn = attrcount_orig;
 	/* Add all elements from the list. */
-	list_for_each_entry(p, &dev_info->channel_attr_list, l)
-		dev_info->chan_attr_group.attrs[attrn++] = &p->dev_attr.attr;
-	if (dev_info->name)
-		dev_info->chan_attr_group.attrs[attrn++] = &dev_attr_name.attr;
+	list_for_each_entry(p, &indio_dev->channel_attr_list, l)
+		indio_dev->chan_attr_group.attrs[attrn++] = &p->dev_attr.attr;
+	if (indio_dev->name)
+		indio_dev->chan_attr_group.attrs[attrn++] = &dev_attr_name.attr;
 
-	dev_info->groups[dev_info->groupcounter++] =
-		&dev_info->chan_attr_group;
+	indio_dev->groups[indio_dev->groupcounter++] =
+		&indio_dev->chan_attr_group;
 
 	return 0;
 
 error_clear_attrs:
 	list_for_each_entry_safe(p, n,
-				 &dev_info->channel_attr_list, l) {
+				 &indio_dev->channel_attr_list, l) {
 		list_del(&p->l);
-		iio_device_remove_and_free_read_attr(dev_info, p);
+		iio_device_remove_and_free_read_attr(indio_dev, p);
 	}
 
 	return ret;
 }
 
-static void iio_device_unregister_sysfs(struct iio_dev *dev_info)
+static void iio_device_unregister_sysfs(struct iio_dev *indio_dev)
 {
 
 	struct iio_dev_attr *p, *n;
 
-	list_for_each_entry_safe(p, n, &dev_info->channel_attr_list, l) {
+	list_for_each_entry_safe(p, n, &indio_dev->channel_attr_list, l) {
 		list_del(&p->l);
-		iio_device_remove_and_free_read_attr(dev_info, p);
+		iio_device_remove_and_free_read_attr(indio_dev, p);
 	}
-	kfree(dev_info->chan_attr_group.attrs);
+	kfree(indio_dev->chan_attr_group.attrs);
 }
 
 static const char * const iio_ev_type_text[] = {
@@ -795,7 +795,7 @@ static ssize_t iio_ev_value_store(struct device *dev,
 	return len;
 }
 
-static int iio_device_add_event_sysfs(struct iio_dev *dev_info,
+static int iio_device_add_event_sysfs(struct iio_dev *indio_dev,
 				      struct iio_chan_spec const *chan)
 {
 	int ret = 0, i, attrcount = 0;
@@ -836,8 +836,8 @@ static int iio_device_add_event_sysfs(struct iio_dev *dev_info,
 					     iio_ev_state_store,
 					     mask,
 					     0,
-					     &dev_info->dev,
-					     &dev_info->event_interface->
+					     &indio_dev->dev,
+					     &indio_dev->event_interface->
 					     dev_attr_list);
 		kfree(postfix);
 		if (ret)
@@ -855,8 +855,8 @@ static int iio_device_add_event_sysfs(struct iio_dev *dev_info,
 					     iio_ev_value_store,
 					     mask,
 					     0,
-					     &dev_info->dev,
-					     &dev_info->event_interface->
+					     &indio_dev->dev,
+					     &indio_dev->event_interface->
 					     dev_attr_list);
 		kfree(postfix);
 		if (ret)
@@ -868,26 +868,26 @@ error_ret:
 	return ret;
 }
 
-static inline void __iio_remove_event_config_attrs(struct iio_dev *dev_info)
+static inline void __iio_remove_event_config_attrs(struct iio_dev *indio_dev)
 {
 	struct iio_dev_attr *p, *n;
 	list_for_each_entry_safe(p, n,
-				 &dev_info->event_interface->
+				 &indio_dev->event_interface->
 				 dev_attr_list, l) {
 		kfree(p->dev_attr.attr.name);
 		kfree(p);
 	}
 }
 
-static inline int __iio_add_event_config_attrs(struct iio_dev *dev_info)
+static inline int __iio_add_event_config_attrs(struct iio_dev *indio_dev)
 {
 	int j, ret, attrcount = 0;
 
-	INIT_LIST_HEAD(&dev_info->event_interface->dev_attr_list);
+	INIT_LIST_HEAD(&indio_dev->event_interface->dev_attr_list);
 	/* Dynically created from the channels array */
-	for (j = 0; j < dev_info->num_channels; j++) {
-		ret = iio_device_add_event_sysfs(dev_info,
-						 &dev_info->channels[j]);
+	for (j = 0; j < indio_dev->num_channels; j++) {
+		ret = iio_device_add_event_sysfs(indio_dev,
+						 &indio_dev->channels[j]);
 		if (ret < 0)
 			goto error_clear_attrs;
 		attrcount += ret;
@@ -895,17 +895,17 @@ static inline int __iio_add_event_config_attrs(struct iio_dev *dev_info)
 	return attrcount;
 
 error_clear_attrs:
-	__iio_remove_event_config_attrs(dev_info);
+	__iio_remove_event_config_attrs(indio_dev);
 
 	return ret;
 }
 
-static bool iio_check_for_dynamic_events(struct iio_dev *dev_info)
+static bool iio_check_for_dynamic_events(struct iio_dev *indio_dev)
 {
 	int j;
 
-	for (j = 0; j < dev_info->num_channels; j++)
-		if (dev_info->channels[j].event_mask != 0)
+	for (j = 0; j < indio_dev->num_channels; j++)
+		if (indio_dev->channels[j].event_mask != 0)
 			return true;
 	return false;
 }
@@ -921,91 +921,91 @@ static void iio_setup_ev_int(struct iio_event_interface *ev_int)
 }
 
 static const char *iio_event_group_name = "events";
-static int iio_device_register_eventset(struct iio_dev *dev_info)
+static int iio_device_register_eventset(struct iio_dev *indio_dev)
 {
 	struct iio_dev_attr *p;
 	int ret = 0, attrcount_orig = 0, attrcount, attrn;
 	struct attribute **attr;
 
-	if (!(dev_info->info->event_attrs ||
-	      iio_check_for_dynamic_events(dev_info)))
+	if (!(indio_dev->info->event_attrs ||
+	      iio_check_for_dynamic_events(indio_dev)))
 		return 0;
 
-	dev_info->event_interface =
+	indio_dev->event_interface =
 		kzalloc(sizeof(struct iio_event_interface), GFP_KERNEL);
-	if (dev_info->event_interface == NULL) {
+	if (indio_dev->event_interface == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
 
-	iio_setup_ev_int(dev_info->event_interface);
-	if (dev_info->info->event_attrs != NULL) {
-		attr = dev_info->info->event_attrs->attrs;
+	iio_setup_ev_int(indio_dev->event_interface);
+	if (indio_dev->info->event_attrs != NULL) {
+		attr = indio_dev->info->event_attrs->attrs;
 		while (*attr++ != NULL)
 			attrcount_orig++;
 	}
 	attrcount = attrcount_orig;
-	if (dev_info->channels) {
-		ret = __iio_add_event_config_attrs(dev_info);
+	if (indio_dev->channels) {
+		ret = __iio_add_event_config_attrs(indio_dev);
 		if (ret < 0)
 			goto error_free_setup_event_lines;
 		attrcount += ret;
 	}
 
-	dev_info->event_interface->group.name = iio_event_group_name;
-	dev_info->event_interface->group.attrs =
-		kzalloc(sizeof(dev_info->event_interface->group.attrs[0])
+	indio_dev->event_interface->group.name = iio_event_group_name;
+	indio_dev->event_interface->group.attrs =
+		kzalloc(sizeof(indio_dev->event_interface->group.attrs[0])
 			*(attrcount + 1),
 			GFP_KERNEL);
-	if (dev_info->event_interface->group.attrs == NULL) {
+	if (indio_dev->event_interface->group.attrs == NULL) {
 		ret = -ENOMEM;
 		goto error_free_setup_event_lines;
 	}
-	if (dev_info->info->event_attrs)
-		memcpy(dev_info->event_interface->group.attrs,
-		       dev_info->info->event_attrs->attrs,
-		       sizeof(dev_info->event_interface->group.attrs[0])
+	if (indio_dev->info->event_attrs)
+		memcpy(indio_dev->event_interface->group.attrs,
+		       indio_dev->info->event_attrs->attrs,
+		       sizeof(indio_dev->event_interface->group.attrs[0])
 		       *attrcount_orig);
 	attrn = attrcount_orig;
 	/* Add all elements from the list. */
 	list_for_each_entry(p,
-			    &dev_info->event_interface->dev_attr_list,
+			    &indio_dev->event_interface->dev_attr_list,
 			    l)
-		dev_info->event_interface->group.attrs[attrn++] =
+		indio_dev->event_interface->group.attrs[attrn++] =
 			&p->dev_attr.attr;
 
-	dev_info->groups[dev_info->groupcounter++] =
-		&dev_info->event_interface->group;
+	indio_dev->groups[indio_dev->groupcounter++] =
+		&indio_dev->event_interface->group;
 
 	return 0;
 
 error_free_setup_event_lines:
-	__iio_remove_event_config_attrs(dev_info);
-	kfree(dev_info->event_interface);
+	__iio_remove_event_config_attrs(indio_dev);
+	kfree(indio_dev->event_interface);
 error_ret:
 
 	return ret;
 }
 
-static void iio_device_unregister_eventset(struct iio_dev *dev_info)
+static void iio_device_unregister_eventset(struct iio_dev *indio_dev)
 {
-	if (dev_info->event_interface == NULL)
+	if (indio_dev->event_interface == NULL)
 		return;
-	__iio_remove_event_config_attrs(dev_info);
-	kfree(dev_info->event_interface->group.attrs);
-	kfree(dev_info->event_interface);
+	__iio_remove_event_config_attrs(indio_dev);
+	kfree(indio_dev->event_interface->group.attrs);
+	kfree(indio_dev->event_interface);
 }
 
 static void iio_dev_release(struct device *device)
 {
-	struct iio_dev *dev_info = container_of(device, struct iio_dev, dev);
-	cdev_del(&dev_info->chrdev);
-	if (dev_info->modes & INDIO_BUFFER_TRIGGERED)
-		iio_device_unregister_trigger_consumer(dev_info);
-	iio_device_unregister_eventset(dev_info);
-	iio_device_unregister_sysfs(dev_info);
-	ida_simple_remove(&iio_ida, dev_info->id);
-	kfree(dev_info);
+	struct iio_dev *indio_dev = container_of(device, struct iio_dev, dev);
+	cdev_del(&indio_dev->chrdev);
+	if (indio_dev->modes & INDIO_BUFFER_TRIGGERED)
+		iio_device_unregister_trigger_consumer(indio_dev);
+	iio_device_unregister_eventset(indio_dev);
+	iio_device_unregister_sysfs(indio_dev);
+	ida_simple_remove(&iio_ida, indio_dev->id);
+	kfree(indio_dev);
 }
 
 static struct device_type iio_dev_type = {
@@ -1064,11 +1064,11 @@ EXPORT_SYMBOL(iio_free_device);
  **/
 static int iio_chrdev_open(struct inode *inode, struct file *filp)
 {
-	struct iio_dev *dev_info = container_of(inode->i_cdev,
+	struct iio_dev *indio_dev = container_of(inode->i_cdev,
 						struct iio_dev, chrdev);
-	filp->private_data = dev_info;
+	filp->private_data = indio_dev;
 
-	return iio_chrdev_buffer_open(dev_info);
+	return iio_chrdev_buffer_open(indio_dev);
 }
 
 /**
@@ -1109,52 +1109,52 @@ static const struct file_operations iio_buffer_fileops = {
 	.compat_ioctl = iio_ioctl,
 };
 
-int iio_device_register(struct iio_dev *dev_info)
+int iio_device_register(struct iio_dev *indio_dev)
 {
 	int ret;
 
 	/* configure elements for the chrdev */
-	dev_info->dev.devt = MKDEV(MAJOR(iio_devt), dev_info->id);
+	indio_dev->dev.devt = MKDEV(MAJOR(iio_devt), indio_dev->id);
 
-	ret = iio_device_register_sysfs(dev_info);
+	ret = iio_device_register_sysfs(indio_dev);
 	if (ret) {
-		dev_err(dev_info->dev.parent,
+		dev_err(indio_dev->dev.parent,
 			"Failed to register sysfs interfaces\n");
 		goto error_ret;
 	}
-	ret = iio_device_register_eventset(dev_info);
+	ret = iio_device_register_eventset(indio_dev);
 	if (ret) {
-		dev_err(dev_info->dev.parent,
+		dev_err(indio_dev->dev.parent,
 			"Failed to register event set\n");
 		goto error_free_sysfs;
 	}
-	if (dev_info->modes & INDIO_BUFFER_TRIGGERED)
-		iio_device_register_trigger_consumer(dev_info);
+	if (indio_dev->modes & INDIO_BUFFER_TRIGGERED)
+		iio_device_register_trigger_consumer(indio_dev);
 
-	ret = device_add(&dev_info->dev);
+	ret = device_add(&indio_dev->dev);
 	if (ret < 0)
 		goto error_unreg_eventset;
-	cdev_init(&dev_info->chrdev, &iio_buffer_fileops);
-	dev_info->chrdev.owner = dev_info->info->driver_module;
-	ret = cdev_add(&dev_info->chrdev, dev_info->dev.devt, 1);
+	cdev_init(&indio_dev->chrdev, &iio_buffer_fileops);
+	indio_dev->chrdev.owner = indio_dev->info->driver_module;
+	ret = cdev_add(&indio_dev->chrdev, indio_dev->dev.devt, 1);
 	if (ret < 0)
 		goto error_del_device;
 	return 0;
 
 error_del_device:
-	device_del(&dev_info->dev);
+	device_del(&indio_dev->dev);
 error_unreg_eventset:
-	iio_device_unregister_eventset(dev_info);
+	iio_device_unregister_eventset(indio_dev);
 error_free_sysfs:
-	iio_device_unregister_sysfs(dev_info);
+	iio_device_unregister_sysfs(indio_dev);
 error_ret:
 	return ret;
 }
 EXPORT_SYMBOL(iio_device_register);
 
-void iio_device_unregister(struct iio_dev *dev_info)
+void iio_device_unregister(struct iio_dev *indio_dev)
 {
-	device_unregister(&dev_info->dev);
+	device_unregister(&indio_dev->dev);
 }
 EXPORT_SYMBOL(iio_device_unregister);
 subsys_initcall(iio_init);
diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index ae02264..9412013 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -302,10 +302,10 @@ static ssize_t iio_trigger_read_current(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 
-	if (dev_info->trig)
-		return sprintf(buf, "%s\n", dev_info->trig->name);
+	if (indio_dev->trig)
+		return sprintf(buf, "%s\n", indio_dev->trig->name);
 	return 0;
 }
 
@@ -321,38 +321,38 @@ static ssize_t iio_trigger_write_current(struct device *dev,
 					 const char *buf,
 					 size_t len)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct iio_trigger *oldtrig = dev_info->trig;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_trigger *oldtrig = indio_dev->trig;
 	struct iio_trigger *trig;
 	int ret;
 
-	mutex_lock(&dev_info->mlock);
-	if (dev_info->currentmode == INDIO_BUFFER_TRIGGERED) {
-		mutex_unlock(&dev_info->mlock);
+	mutex_lock(&indio_dev->mlock);
+	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
+		mutex_unlock(&indio_dev->mlock);
 		return -EBUSY;
 	}
-	mutex_unlock(&dev_info->mlock);
+	mutex_unlock(&indio_dev->mlock);
 
 	trig = iio_trigger_find_by_name(buf, len);
 
-	if (trig && dev_info->info->validate_trigger) {
-		ret = dev_info->info->validate_trigger(dev_info, trig);
+	if (trig && indio_dev->info->validate_trigger) {
+		ret = indio_dev->info->validate_trigger(indio_dev, trig);
 		if (ret)
 			return ret;
 	}
 
 	if (trig && trig->ops && trig->ops->validate_device) {
-		ret = trig->ops->validate_device(trig, dev_info);
+		ret = trig->ops->validate_device(trig, indio_dev);
 		if (ret)
 			return ret;
 	}
 
-	dev_info->trig = trig;
+	indio_dev->trig = trig;
 
-	if (oldtrig && dev_info->trig != oldtrig)
+	if (oldtrig && indio_dev->trig != oldtrig)
 		iio_put_trigger(oldtrig);
-	if (dev_info->trig)
-		iio_get_trigger(dev_info->trig);
+	if (indio_dev->trig)
+		iio_get_trigger(indio_dev->trig);
 
 	return len;
 }
@@ -471,17 +471,17 @@ void iio_free_trigger(struct iio_trigger *trig)
 }
 EXPORT_SYMBOL(iio_free_trigger);
 
-void iio_device_register_trigger_consumer(struct iio_dev *dev_info)
+void iio_device_register_trigger_consumer(struct iio_dev *indio_dev)
 {
-	dev_info->groups[dev_info->groupcounter++] =
+	indio_dev->groups[indio_dev->groupcounter++] =
 		&iio_trigger_consumer_attr_group;
 }
 
-void iio_device_unregister_trigger_consumer(struct iio_dev *dev_info)
+void iio_device_unregister_trigger_consumer(struct iio_dev *indio_dev)
 {
 	/* Clean up and associated but not attached triggers references */
-	if (dev_info->trig)
-		iio_put_trigger(dev_info->trig);
+	if (indio_dev->trig)
+		iio_put_trigger(indio_dev->trig);
 }
 
 int iio_triggered_buffer_postenable(struct iio_dev *indio_dev)
-- 
1.7.3.4

