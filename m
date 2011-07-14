Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 3/7] staging:iio:core squash trivial wrappers and use ida allocation func.
Date: Thu, 14 Jul 2011 13:33:43 +0100
Message-Id: <1310646827-25690-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1310646827-25690-1-git-send-email-jic23@cam.ac.uk>
References: <1310646827-25690-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Reorder to remove need for definitions currently in header.
Remove ida related utility function defs from header.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio.h               |    4 -
 drivers/staging/iio/industrialio-core.c |  108 ++++++++++++-------------------
 2 files changed, 42 insertions(+), 70 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 2a8c8e2..07f88aa 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -424,8 +424,4 @@ static inline bool iio_ring_enabled(struct iio_dev *dev_info)
 		   | INDIO_RING_HARDWARE_BUFFER);
 };
 
-struct ida;
-
-int iio_get_new_ida_val(struct ida *this_ida);
-void iio_free_ida_val(struct ida *this_ida, int id);
 #endif /* _INDUSTRIAL_IO_H_ */
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index d0e039b..b131a58 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -89,6 +89,36 @@ static const char * const iio_chan_info_postfix[] = {
 	= "quadrature_correction_raw",
 };
 
+/* Return a negative errno on failure */
+int iio_get_new_ida_val(struct ida *this_ida)
+{
+	int ret;
+	int val;
+
+ida_again:
+	if (unlikely(ida_pre_get(this_ida, GFP_KERNEL) == 0))
+		return -ENOMEM;
+
+	spin_lock(&iio_ida_lock);
+	ret = ida_get_new(this_ida, &val);
+	spin_unlock(&iio_ida_lock);
+	if (unlikely(ret == -EAGAIN))
+		goto ida_again;
+	else if (unlikely(ret))
+		return ret;
+
+	return val;
+}
+EXPORT_SYMBOL(iio_get_new_ida_val);
+
+void iio_free_ida_val(struct ida *this_ida, int id)
+{
+	spin_lock(&iio_ida_lock);
+	ida_remove(this_ida, id);
+	spin_unlock(&iio_ida_lock);
+}
+EXPORT_SYMBOL(iio_free_ida_val);
+
 int iio_push_event(struct iio_dev *dev_info,
 		   int ev_line,
 		   int ev_code,
@@ -248,28 +278,18 @@ static struct device_type iio_event_type = {
 
 int iio_device_get_chrdev_minor(void)
 {
-	int ret, val;
+	int ret;
 
-ida_again:
-	if (unlikely(ida_pre_get(&iio_chrdev_ida, GFP_KERNEL) == 0))
-		return -ENOMEM;
-	spin_lock(&iio_ida_lock);
-	ret = ida_get_new(&iio_chrdev_ida, &val);
-	spin_unlock(&iio_ida_lock);
-	if (unlikely(ret == -EAGAIN))
-		goto ida_again;
-	else if (unlikely(ret))
+	ret = iio_get_new_ida_val(&iio_chrdev_ida);
+	if (ret < IIO_DEV_MAX) /* both errors and valid */
 		return ret;
-	if (val > IIO_DEV_MAX)
+	else
 		return -ENOMEM;
-	return val;
 }
 
 void iio_device_free_chrdev_minor(int val)
 {
-	spin_lock(&iio_ida_lock);
-	ida_remove(&iio_chrdev_ida, val);
-	spin_unlock(&iio_ida_lock);
+	iio_free_ida_val(&iio_chrdev_ida, val);
 }
 
 static int iio_setup_ev_int(struct iio_event_interface *ev_int,
@@ -331,24 +351,6 @@ static void iio_free_ev_int(struct iio_event_interface *ev_int)
 	put_device(&ev_int->dev);
 }
 
-static int __init iio_dev_init(void)
-{
-	int err;
-
-	err = alloc_chrdev_region(&iio_devt, 0, IIO_DEV_MAX, "iio");
-	if (err < 0)
-		printk(KERN_ERR "%s: failed to allocate char dev region\n",
-		       __FILE__);
-
-	return err;
-}
-
-static void __exit iio_dev_exit(void)
-{
-	if (iio_devt)
-		unregister_chrdev_region(iio_devt, IIO_DEV_MAX);
-}
-
 static int __init iio_init(void)
 {
 	int ret;
@@ -362,9 +364,12 @@ static int __init iio_init(void)
 		goto error_nothing;
 	}
 
-	ret = iio_dev_init();
-	if (ret < 0)
+	ret = alloc_chrdev_region(&iio_devt, 0, IIO_DEV_MAX, "iio");
+	if (ret < 0) {
+		printk(KERN_ERR "%s: failed to allocate char dev region\n",
+		       __FILE__);
 		goto error_unregister_bus_type;
+	}
 
 	return 0;
 
@@ -376,7 +381,8 @@ error_nothing:
 
 static void __exit iio_exit(void)
 {
-	iio_dev_exit();
+	if (iio_devt)
+		unregister_chrdev_region(iio_devt, IIO_DEV_MAX);
 	bus_unregister(&iio_bus_type);
 }
 
@@ -794,36 +800,6 @@ static void iio_device_unregister_sysfs(struct iio_dev *dev_info)
 		sysfs_remove_group(&dev_info->dev.kobj, dev_info->info->attrs);
 }
 
-/* Return a negative errno on failure */
-int iio_get_new_ida_val(struct ida *this_ida)
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
-EXPORT_SYMBOL(iio_get_new_ida_val);
-
-void iio_free_ida_val(struct ida *this_ida, int id)
-{
-	spin_lock(&iio_ida_lock);
-	ida_remove(this_ida, id);
-	spin_unlock(&iio_ida_lock);
-}
-EXPORT_SYMBOL(iio_free_ida_val);
-
 static const char * const iio_ev_type_text[] = {
 	[IIO_EV_TYPE_THRESH] = "thresh",
 	[IIO_EV_TYPE_MAG] = "mag",
-- 
1.7.3.4
