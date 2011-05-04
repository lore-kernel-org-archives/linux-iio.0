Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de,
	Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 97/99] staging:iio:core cleanup: squash tiny wrappers and use dev_set_name to handle creation of event interface name.
Date: Wed,  4 May 2011 12:59:09 +0100
Message-Id: <1304510351-10922-98-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/chrdev.h            |    3 --
 drivers/staging/iio/industrialio-core.c |   54 ++++++++++--------------------
 2 files changed, 18 insertions(+), 39 deletions(-)

diff --git a/drivers/staging/iio/chrdev.h b/drivers/staging/iio/chrdev.h
index 6523273..3e31ee6 100644
--- a/drivers/staging/iio/chrdev.h
+++ b/drivers/staging/iio/chrdev.h
@@ -60,8 +60,6 @@ struct iio_detected_event_list {
  * @det_events:		list of detected events
  * @max_events:		maximum number of events before new ones are dropped
  * @current_events:	number of events in detected list
- * @_name:		used internally to store the sysfs name for minor id
- *			attribute
  */
 struct iio_event_interface {
 	struct device				dev;
@@ -71,7 +69,6 @@ struct iio_event_interface {
 	struct list_head			det_events;
 	int					max_events;
 	int					current_events;
-	char					_name[35];
 	struct list_head dev_attr_list;
 };
 
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 4f2f9a4..faa34af 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -16,7 +16,6 @@
 #include <linux/err.h>
 #include <linux/device.h>
 #include <linux/fs.h>
-#include <linux/interrupt.h>
 #include <linux/poll.h>
 #include <linux/sched.h>
 #include <linux/wait.h>
@@ -268,9 +267,10 @@ void iio_device_free_chrdev_minor(int val)
 }
 
 static int iio_setup_ev_int(struct iio_event_interface *ev_int,
-		     const char *name,
-		     struct module *owner,
-		     struct device *dev)
+			    const char *dev_name,
+			    int index,
+			    struct module *owner,
+			    struct device *dev)
 {
 	int ret, minor;
 
@@ -285,7 +285,7 @@ static int iio_setup_ev_int(struct iio_event_interface *ev_int,
 		goto error_device_put;
 	}
 	ev_int->dev.devt = MKDEV(MAJOR(iio_devt), minor);
-	dev_set_name(&ev_int->dev, "%s", name);
+	dev_set_name(&ev_int->dev, "%s:event%d", dev_name, index);
 
 	ret = device_add(&ev_int->dev);
 	if (ret)
@@ -796,20 +796,6 @@ void iio_free_ida_val(struct ida *this_ida, int id)
 }
 EXPORT_SYMBOL(iio_free_ida_val);
 
-static int iio_device_register_id(struct iio_dev *dev_info,
-				  struct ida *this_ida)
-{
-	dev_info->id = iio_get_new_ida_val(&iio_ida);
-	if (dev_info->id < 0)
-		return dev_info->id;
-	return 0;
-}
-
-static void iio_device_unregister_id(struct iio_dev *dev_info)
-{
-	iio_free_ida_val(&iio_ida, dev_info->id);
-}
-
 static const char * const iio_ev_type_text[] = {
 	[IIO_EV_TYPE_THRESH] = "thresh",
 	[IIO_EV_TYPE_MAG] = "mag",
@@ -830,10 +816,11 @@ static ssize_t iio_ev_state_store(struct device *dev,
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int ret;
-	unsigned long val;
-	ret = strict_strtoul(buf, 10, &val);
-	if (ret || val < 0 || val > 1)
-		return -EINVAL;
+	bool val;
+
+	ret = strtobool(buf, &val);
+	if (ret < 0)
+		return ret;
 
 	ret = indio_dev->write_event_config(indio_dev, this_attr->address,
 					    val);
@@ -1039,13 +1026,9 @@ static int iio_device_register_eventset(struct iio_dev *dev_info)
 	}
 
 	for (i = 0; i < dev_info->num_interrupt_lines; i++) {
-		snprintf(dev_info->event_interfaces[i]._name, 20,
-			 "%s:event%d",
-			 dev_name(&dev_info->dev),
-			 i);
-
 		ret = iio_setup_ev_int(&dev_info->event_interfaces[i],
-				       dev_info->event_interfaces[i]._name,
+				       dev_name(&dev_info->dev),
+				       i,
 				       dev_info->driver_module,
 				       &dev_info->dev);
 		if (ret) {
@@ -1118,10 +1101,8 @@ static void iio_device_unregister_eventset(struct iio_dev *dev_info)
 
 static void iio_dev_release(struct device *device)
 {
-	struct iio_dev *dev = to_iio_dev(device);
-
 	iio_put();
-	kfree(dev);
+	kfree(to_iio_dev(device));
 }
 
 static struct device_type iio_dev_type = {
@@ -1168,8 +1149,9 @@ int iio_device_register(struct iio_dev *dev_info)
 {
 	int ret;
 
-	ret = iio_device_register_id(dev_info, &iio_ida);
-	if (ret) {
+	dev_info->id = iio_get_new_ida_val(&iio_ida);
+	if (dev_info->id < 0) {
+		ret = dev_info->id;
 		dev_err(&dev_info->dev, "Failed to get id\n");
 		goto error_ret;
 	}
@@ -1200,7 +1182,7 @@ error_free_sysfs:
 error_del_device:
 	device_del(&dev_info->dev);
 error_free_ida:
-	iio_device_unregister_id(dev_info);
+	iio_free_ida_val(&iio_ida, dev_info->id);
 error_ret:
 	return ret;
 }
@@ -1212,7 +1194,7 @@ void iio_device_unregister(struct iio_dev *dev_info)
 		iio_device_unregister_trigger_consumer(dev_info);
 	iio_device_unregister_eventset(dev_info);
 	iio_device_unregister_sysfs(dev_info);
-	iio_device_unregister_id(dev_info);
+	iio_free_ida_val(&iio_ida, dev_info->id);
 	device_unregister(&dev_info->dev);
 }
 EXPORT_SYMBOL(iio_device_unregister);
-- 
1.7.3.4
