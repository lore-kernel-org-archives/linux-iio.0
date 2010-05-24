Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 06/11] staging:iio: Remove unnecessary event_idr and all references
Date: Mon, 24 May 2010 22:02:51 +0100
Message-Id: <1274734976-7941-7-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1274734976-7941-1-git-send-email-jic23@cam.ac.uk>
References: <1274734976-7941-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/chrdev.h            |    3 ---
 drivers/staging/iio/industrialio-core.c |   22 +++-------------------
 drivers/staging/iio/industrialio-ring.c |    4 +---
 3 files changed, 4 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/iio/chrdev.h b/drivers/staging/iio/chrdev.h
index 3f96f86..fd23bd1 100644
--- a/drivers/staging/iio/chrdev.h
+++ b/drivers/staging/iio/chrdev.h
@@ -73,8 +73,6 @@ struct iio_shared_ev_pointer {
  * @det_events:		list of detected events
  * @max_events:		maximum number of events before new ones are dropped
  * @current_events:	number of events in detected list
- * @id:			indentifier to allow the event interface to know which
- *			physical line it corresponds to
  * @attr:		this chrdev's minor number sysfs attribute
  * @owner:		ensure the driver module owns the file, not iio
  * @private:		driver specific data
@@ -90,7 +88,6 @@ struct iio_event_interface {
 	struct iio_detected_event_list		det_events;
 	int					max_events;
 	int					current_events;
-	int					id;
 	struct iio_chrdev_minor_attr		attr;
 	struct module				*owner;
 	void					*private;
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 0103068..dd4d87a 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -30,9 +30,6 @@
 
 /* IDR to assign each registered device a unique id*/
 static DEFINE_IDR(iio_idr);
-
-/* IDR for general event identifiers */
-static DEFINE_IDR(iio_event_idr);
 /* IDR to allocate character device minor numbers */
 static DEFINE_IDR(iio_chrdev_idr);
 /* Lock used to protect both of the above */
@@ -654,16 +651,11 @@ static int iio_device_register_eventset(struct iio_dev *dev_info)
 
 	for (i = 0; i < dev_info->num_interrupt_lines; i++) {
 		dev_info->event_interfaces[i].owner = dev_info->driver_module;
-		ret = iio_get_new_idr_val(&iio_event_idr);
-		if (ret < 0)
-			goto error_free_setup_ev_ints;
-		else
-			dev_info->event_interfaces[i].id = ret;
 
 		snprintf(dev_info->event_interfaces[i]._name, 20,
 			 "%s:event%d",
 			 dev_name(&dev_info->dev),
-			 dev_info->event_interfaces[i].id);
+			 i);
 
 		ret = iio_setup_ev_int(&dev_info->event_interfaces[i],
 				       (const char *)(dev_info
@@ -674,8 +666,6 @@ static int iio_device_register_eventset(struct iio_dev *dev_info)
 		if (ret) {
 			dev_err(&dev_info->dev,
 				"Could not get chrdev interface\n");
-			iio_free_idr_val(&iio_event_idr,
-					 dev_info->event_interfaces[i].id);
 			goto error_free_setup_ev_ints;
 		}
 
@@ -711,11 +701,8 @@ error_remove_sysfs_interfaces:
 				   ->event_interfaces[j].dev.kobj,
 				   &dev_info->event_attrs[j]);
 error_free_setup_ev_ints:
-	for (j = 0; j < i; j++) {
-		iio_free_idr_val(&iio_event_idr,
-				 dev_info->event_interfaces[j].id);
+	for (j = 0; j < i; j++)
 		iio_free_ev_int(&dev_info->event_interfaces[j]);
-	}
 	kfree(dev_info->interrupts);
 error_free_event_interfaces:
 	kfree(dev_info->event_interfaces);
@@ -735,11 +722,8 @@ static void iio_device_unregister_eventset(struct iio_dev *dev_info)
 				   ->event_interfaces[i].dev.kobj,
 				   &dev_info->event_attrs[i]);
 
-	for (i = 0; i < dev_info->num_interrupt_lines; i++) {
-		iio_free_idr_val(&iio_event_idr,
-				 dev_info->event_interfaces[i].id);
+	for (i = 0; i < dev_info->num_interrupt_lines; i++)
 		iio_free_ev_int(&dev_info->event_interfaces[i]);
-	}
 	kfree(dev_info->interrupts);
 	kfree(dev_info->event_interfaces);
 }
diff --git a/drivers/staging/iio/industrialio-ring.c b/drivers/staging/iio/industrialio-ring.c
index ada159b..6ab578e 100644
--- a/drivers/staging/iio/industrialio-ring.c
+++ b/drivers/staging/iio/industrialio-ring.c
@@ -149,12 +149,10 @@ __iio_request_ring_buffer_event_chrdev(struct iio_ring_buffer *buf,
 {
 	int ret;
 
-	buf->ev_int.id = id;
-
 	snprintf(buf->ev_int._name, sizeof(buf->ev_int._name),
 		 "%s:event%d",
 		 dev_name(&buf->dev),
-		 buf->ev_int.id);
+		 id);
 	ret = iio_setup_ev_int(&(buf->ev_int),
 			       buf->ev_int._name,
 			       owner,
-- 
1.7.0.4
