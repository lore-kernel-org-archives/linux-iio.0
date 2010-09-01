Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/9] staging:iio: convert idr to ida as pointer never provided
Date: Wed,  1 Sep 2010 15:57:55 +0100
Message-Id: <1283353083-31313-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1283353083-31313-1-git-send-email-jic23@cam.ac.uk>
References: <1283353083-31313-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio.h               |    8 ++--
 drivers/staging/iio/industrialio-core.c |   63 +++++++++++++++----------------
 2 files changed, 35 insertions(+), 36 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 3072c45..248bdd2 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -135,7 +135,7 @@ void iio_device_unregister(struct iio_dev *dev_info);
  *			physical interrupt lines
  * @dev_info:		the iio device for which the is an interrupt line
  * @line_number:	associated line number
- * @id:			idr allocated unique id number
+ * @id:			ida allocated unique id number
  * @irq:		associate interrupt number
  * @ev_list:		event handler list for associated events
  * @ev_list_lock:	ensure only one access to list at a time
@@ -302,8 +302,8 @@ static inline bool iio_ring_enabled(struct iio_dev *dev_info)
 		   | INDIO_RING_HARDWARE_BUFFER);
 };
 
-struct idr;
+struct ida;
 
-int iio_get_new_idr_val(struct idr *this_idr);
-void iio_free_idr_val(struct idr *this_idr, int id);
+int iio_get_new_ida_val(struct ida *this_ida);
+void iio_free_ida_val(struct ida *this_ida, int id);
 #endif /* _INDUSTRIAL_IO_H_ */
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 5c0e56a..48a2884 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -29,11 +29,11 @@
 #define IIO_ID_FORMAT IIO_ID_PREFIX "%d"
 
 /* IDR to assign each registered device a unique id*/
-static DEFINE_IDR(iio_idr);
+static DEFINE_IDA(iio_ida);
 /* IDR to allocate character device minor numbers */
-static DEFINE_IDR(iio_chrdev_idr);
+static DEFINE_IDA(iio_chrdev_ida);
 /* Lock used to protect both of the above */
-static DEFINE_SPINLOCK(iio_idr_lock);
+static DEFINE_SPINLOCK(iio_ida_lock);
 
 dev_t iio_devt;
 EXPORT_SYMBOL(iio_devt);
@@ -367,14 +367,14 @@ int iio_device_get_chrdev_minor(void)
 {
 	int ret, val;
 
-idr_again:
-	if (unlikely(idr_pre_get(&iio_chrdev_idr, GFP_KERNEL) == 0))
+ida_again:
+	if (unlikely(ida_pre_get(&iio_chrdev_ida, GFP_KERNEL) == 0))
 		return -ENOMEM;
-	spin_lock(&iio_idr_lock);
-	ret = idr_get_new(&iio_chrdev_idr, NULL, &val);
-	spin_unlock(&iio_idr_lock);
+	spin_lock(&iio_ida_lock);
+	ret = ida_get_new(&iio_chrdev_ida, &val);
+	spin_unlock(&iio_ida_lock);
 	if (unlikely(ret == -EAGAIN))
-		goto idr_again;
+		goto ida_again;
 	else if (unlikely(ret))
 		return ret;
 	if (val > IIO_DEV_MAX)
@@ -384,9 +384,9 @@ idr_again:
 
 void iio_device_free_chrdev_minor(int val)
 {
-	spin_lock(&iio_idr_lock);
-	idr_remove(&iio_chrdev_idr, val);
-	spin_unlock(&iio_idr_lock);
+	spin_lock(&iio_ida_lock);
+	ida_remove(&iio_chrdev_ida, val);
+	spin_unlock(&iio_ida_lock);
 }
 
 int iio_setup_ev_int(struct iio_event_interface *ev_int,
@@ -517,40 +517,39 @@ static void iio_device_unregister_sysfs(struct iio_dev *dev_info)
 }
 
 /* Return a negative errno on failure */
-int iio_get_new_idr_val(struct idr *this_idr)
+int iio_get_new_ida_val(struct ida *this_ida)
 {
 	int ret;
 	int val;
 
-idr_again:
-	if (unlikely(idr_pre_get(this_idr, GFP_KERNEL) == 0))
+ida_again:
+	if (unlikely(ida_pre_get(this_ida, GFP_KERNEL) == 0))
 		return -ENOMEM;
 
-	spin_lock(&iio_idr_lock);
-	ret = idr_get_new(this_idr, NULL, &val);
-	spin_unlock(&iio_idr_lock);
+	spin_lock(&iio_ida_lock);
+	ret = ida_get_new(this_ida, &val);
+	spin_unlock(&iio_ida_lock);
 	if (unlikely(ret == -EAGAIN))
-		goto idr_again;
+		goto ida_again;
 	else if (unlikely(ret))
 		return ret;
 
 	return val;
 }
-EXPORT_SYMBOL(iio_get_new_idr_val);
+EXPORT_SYMBOL(iio_get_new_ida_val);
 
-void iio_free_idr_val(struct idr *this_idr, int id)
+void iio_free_ida_val(struct ida *this_ida, int id)
 {
-	spin_lock(&iio_idr_lock);
-	idr_remove(this_idr, id);
-	spin_unlock(&iio_idr_lock);
+	spin_lock(&iio_ida_lock);
+	ida_remove(this_ida, id);
+	spin_unlock(&iio_ida_lock);
 }
-EXPORT_SYMBOL(iio_free_idr_val);
+EXPORT_SYMBOL(iio_free_ida_val);
 
 static int iio_device_register_id(struct iio_dev *dev_info,
-				  struct idr *this_idr)
+				  struct ida *this_ida)
 {
-
-	dev_info->id = iio_get_new_idr_val(&iio_idr);
+	dev_info->id = iio_get_new_ida_val(&iio_ida);
 	if (dev_info->id < 0)
 		return dev_info->id;
 	return 0;
@@ -558,7 +557,7 @@ static int iio_device_register_id(struct iio_dev *dev_info,
 
 static void iio_device_unregister_id(struct iio_dev *dev_info)
 {
-	iio_free_idr_val(&iio_idr, dev_info->id);
+	iio_free_ida_val(&iio_ida, dev_info->id);
 }
 
 static inline int __iio_add_event_config_attrs(struct iio_dev *dev_info, int i)
@@ -757,7 +756,7 @@ int iio_device_register(struct iio_dev *dev_info)
 {
 	int ret;
 
-	ret = iio_device_register_id(dev_info, &iio_idr);
+	ret = iio_device_register_id(dev_info, &iio_ida);
 	if (ret) {
 		dev_err(&dev_info->dev, "Failed to get id\n");
 		goto error_ret;
@@ -766,7 +765,7 @@ int iio_device_register(struct iio_dev *dev_info)
 
 	ret = device_add(&dev_info->dev);
 	if (ret)
-		goto error_free_idr;
+		goto error_free_ida;
 	ret = iio_device_register_sysfs(dev_info);
 	if (ret) {
 		dev_err(dev_info->dev.parent,
@@ -788,7 +787,7 @@ error_free_sysfs:
 	iio_device_unregister_sysfs(dev_info);
 error_del_device:
 	device_del(&dev_info->dev);
-error_free_idr:
+error_free_ida:
 	iio_device_unregister_id(dev_info);
 error_ret:
 	return ret;
-- 
1.7.1
