Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/4] staging:iio: use ida_simple_get and ida_simple_remove + merge ids
Date: Mon, 25 Jul 2011 14:38:57 +0100
Message-Id: <1311601140-20660-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1311601140-20660-1-git-send-email-jic23@cam.ac.uk>
References: <1311601140-20660-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Use new simple ida allocation functions to remove some boilerplate
code.

Also, now we only have one chdev per device we don't need to maintain
a separate ida for minor numbers. Just use the devices id.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/industrialio-core.c    |   61 ++--------------------------
 drivers/staging/iio/industrialio-trigger.c |   48 +++-------------------
 2 files changed, 11 insertions(+), 98 deletions(-)

diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index e92e28d..61ad6a8 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -26,13 +26,8 @@
 #include "iio_core.h"
 #include "iio_core_trigger.h"
 #include "chrdev.h"
-
 /* IDR to assign each registered device a unique id*/
 static DEFINE_IDA(iio_ida);
-/* IDR to allocate character device minor numbers */
-static DEFINE_IDA(iio_chrdev_ida);
-/* Lock used to protect both of the above */
-static DEFINE_SPINLOCK(iio_ida_lock);
 
 static dev_t iio_devt;
 
@@ -89,34 +84,6 @@ static const char * const iio_chan_info_postfix[] = {
 	= "quadrature_correction_raw",
 };
 
-/* Return a negative errno on failure */
-static int iio_get_new_ida_val(struct ida *this_ida)
-{
-	int ret;
-	int val;
-
-ida_again:
-	if (unlikely(ida_pre_get(this_ida, GFP_KERNEL) == 0))
-		return -ENOMEM;
-
-	spin_lock(&iio_ida_lock);
-	ret = ida_get_new(this_ida, &val);
-	spin_unlock(&iio_ida_lock);
-	if (unlikely(ret == -EAGAIN))
-		goto ida_again;
-	else if (unlikely(ret))
-		return ret;
-
-	return val;
-}
-
-static void iio_free_ida_val(struct ida *this_ida, int id)
-{
-	spin_lock(&iio_ida_lock);
-	ida_remove(this_ida, id);
-	spin_unlock(&iio_ida_lock);
-}
-
 /**
  * struct iio_detected_event_list - list element for events that have occurred
  * @list:		linked list header
@@ -270,22 +237,6 @@ static const struct file_operations iio_event_chrdev_fileops = {
 	.llseek = noop_llseek,
 };
 
-static int iio_device_get_chrdev_minor(void)
-{
-	int ret;
-
-	ret = iio_get_new_ida_val(&iio_chrdev_ida);
-	if (ret < IIO_DEV_MAX) /* both errors and valid */
-		return ret;
-	else
-		return -ENOMEM;
-}
-
-static void iio_device_free_chrdev_minor(int val)
-{
-	iio_free_ida_val(&iio_chrdev_ida, val);
-}
-
 static int iio_event_getfd(struct iio_dev *indio_dev)
 {
 	if (indio_dev->event_interface == NULL)
@@ -1056,7 +1007,6 @@ static void iio_dev_release(struct device *device)
 {
 	struct iio_dev *dev_info = container_of(device, struct iio_dev, dev);
 	cdev_del(&dev_info->chrdev);
-	iio_device_free_chrdev_minor(MINOR(device->devt));
 	iio_put();
 	kfree(dev_info);
 }
@@ -1155,19 +1105,16 @@ int iio_device_register(struct iio_dev *dev_info)
 {
 	int ret;
 
-	dev_info->id = iio_get_new_ida_val(&iio_ida);
+	dev_info->id = ida_simple_get(&iio_ida, 0, 0, GFP_KERNEL);
 	if (dev_info->id < 0) {
 		ret = dev_info->id;
 		dev_err(&dev_info->dev, "Failed to get id\n");
 		goto error_ret;
 	}
 	dev_set_name(&dev_info->dev, "iio:device%d", dev_info->id);
-	ret = iio_device_get_chrdev_minor();
-	if (ret < 0)
-		goto error_free_ida;
 
 	/* configure elements for the chrdev */
-	dev_info->dev.devt = MKDEV(MAJOR(iio_devt), ret);
+	dev_info->dev.devt = MKDEV(MAJOR(iio_devt), dev_info->id);
 
 	ret = device_add(&dev_info->dev);
 	if (ret)
@@ -1197,7 +1144,7 @@ error_free_sysfs:
 error_del_device:
 	device_del(&dev_info->dev);
 error_free_ida:
-	iio_free_ida_val(&iio_ida, dev_info->id);
+	ida_simple_remove(&iio_ida, dev_info->id);
 error_ret:
 	return ret;
 }
@@ -1209,7 +1156,7 @@ void iio_device_unregister(struct iio_dev *dev_info)
 		iio_device_unregister_trigger_consumer(dev_info);
 	iio_device_unregister_eventset(dev_info);
 	iio_device_unregister_sysfs(dev_info);
-	iio_free_ida_val(&iio_ida, dev_info->id);
+	ida_simple_remove(&iio_ida, dev_info->id);
 	device_unregister(&dev_info->dev);
 }
 EXPORT_SYMBOL(iio_device_unregister);
diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index f1ece86..b99d14e 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -32,8 +32,7 @@
  * Any other suggestions?
  */
 
-static DEFINE_IDR(iio_trigger_idr);
-static DEFINE_SPINLOCK(iio_trigger_idr_lock);
+static DEFINE_IDA(iio_trigger_ida);
 
 /* Single list of all available triggers */
 static LIST_HEAD(iio_trigger_list);
@@ -72,48 +71,15 @@ static void iio_trigger_unregister_sysfs(struct iio_trigger *trig_info)
 					   NULL);
 }
 
-
-/**
- * iio_trigger_register_id() - get a unique id for this trigger
- * @trig_info:	the trigger
- **/
-static int iio_trigger_register_id(struct iio_trigger *trig_info)
-{
-	int ret = 0;
-
-idr_again:
-	if (unlikely(idr_pre_get(&iio_trigger_idr, GFP_KERNEL) == 0))
-		return -ENOMEM;
-
-	spin_lock(&iio_trigger_idr_lock);
-	ret = idr_get_new(&iio_trigger_idr, NULL, &trig_info->id);
-	spin_unlock(&iio_trigger_idr_lock);
-	if (unlikely(ret == -EAGAIN))
-		goto idr_again;
-	else if (likely(!ret))
-		trig_info->id = trig_info->id & MAX_ID_MASK;
-
-	return ret;
-}
-
-/**
- * iio_trigger_unregister_id() - free up unique id for use by another trigger
- * @trig_info: the trigger
- **/
-static void iio_trigger_unregister_id(struct iio_trigger *trig_info)
-{
-	spin_lock(&iio_trigger_idr_lock);
-	idr_remove(&iio_trigger_idr, trig_info->id);
-	spin_unlock(&iio_trigger_idr_lock);
-}
-
 int iio_trigger_register(struct iio_trigger *trig_info)
 {
 	int ret;
 
-	ret = iio_trigger_register_id(trig_info);
-	if (ret)
+	trig_info->id = ida_simple_get(&iio_trigger_ida, 0, 0, GFP_KERNEL);
+	if (trig_info->id < 0) {
+		ret = trig_info->id;
 		goto error_ret;
+	}
 	/* Set the name used for the sysfs directory etc */
 	dev_set_name(&trig_info->dev, "trigger%ld",
 		     (unsigned long) trig_info->id);
@@ -136,7 +102,7 @@ int iio_trigger_register(struct iio_trigger *trig_info)
 error_device_del:
 	device_del(&trig_info->dev);
 error_unregister_id:
-	iio_trigger_unregister_id(trig_info);
+	ida_simple_remove(&iio_trigger_ida, trig_info->id);
 error_ret:
 	return ret;
 }
@@ -149,7 +115,7 @@ void iio_trigger_unregister(struct iio_trigger *trig_info)
 	mutex_unlock(&iio_trigger_list_lock);
 
 	iio_trigger_unregister_sysfs(trig_info);
-	iio_trigger_unregister_id(trig_info);
+	ida_simple_remove(&iio_trigger_ida, trig_info->id);
 	/* Possible issue in here */
 	device_unregister(&trig_info->dev);
 }
-- 
1.7.3.4
