Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 13/13] staging:iio: Remove naming via IDR's where no longer necessary under new abi.
Date: Sun, 28 Mar 2010 21:41:19 +0100
Message-Id: <1269808879-28838-14-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1269808879-28838-13-git-send-email-jic23@cam.ac.uk>
References: <1269808879-28838-1-git-send-email-jic23@cam.ac.uk>
 <1269808879-28838-2-git-send-email-jic23@cam.ac.uk>
 <1269808879-28838-3-git-send-email-jic23@cam.ac.uk>
 <1269808879-28838-4-git-send-email-jic23@cam.ac.uk>
 <1269808879-28838-5-git-send-email-jic23@cam.ac.uk>
 <1269808879-28838-6-git-send-email-jic23@cam.ac.uk>
 <1269808879-28838-7-git-send-email-jic23@cam.ac.uk>
 <1269808879-28838-8-git-send-email-jic23@cam.ac.uk>
 <1269808879-28838-9-git-send-email-jic23@cam.ac.uk>
 <1269808879-28838-10-git-send-email-jic23@cam.ac.uk>
 <1269808879-28838-11-git-send-email-jic23@cam.ac.uk>
 <1269808879-28838-12-git-send-email-jic23@cam.ac.uk>
 <1269808879-28838-13-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/lis3l02dq_ring.c |    2 +-
 drivers/staging/iio/accel/sca3000_core.c   |    2 +-
 drivers/staging/iio/adc/max1363_ring.c     |    2 +-
 drivers/staging/iio/industrialio-ring.c    |   48 +++++++---------------------
 drivers/staging/iio/ring_generic.h         |    2 +-
 5 files changed, 16 insertions(+), 40 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index bfd0cda..bc2a5ee 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -580,7 +580,7 @@ error_iio_sw_rb_free:
 
 int lis3l02dq_initialize_ring(struct iio_ring_buffer *ring)
 {
-	return iio_ring_buffer_register(ring);
+	return iio_ring_buffer_register(ring, 0);
 }
 
 void lis3l02dq_uninitialize_ring(struct iio_ring_buffer *ring)
diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index f0f7e80..942e05e 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -1337,7 +1337,7 @@ static int __devinit __sca3000_probe(struct spi_device *spi,
 	if (ret < 0)
 		goto error_free_dev;
 	regdone = 1;
-	ret = iio_ring_buffer_register(st->indio_dev->ring);
+	ret = iio_ring_buffer_register(st->indio_dev->ring, 0);
 	if (ret < 0)
 		goto error_unregister_dev;
 	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0) {
diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index 0de3e87..f4414b0 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -254,5 +254,5 @@ void max1363_uninitialize_ring(struct iio_ring_buffer *ring)
 
 int max1363_initialize_ring(struct iio_ring_buffer *ring)
 {
-	return iio_ring_buffer_register(ring);
+	return iio_ring_buffer_register(ring, 0);
 };
diff --git a/drivers/staging/iio/industrialio-ring.c b/drivers/staging/iio/industrialio-ring.c
index 3bbd57d..a720126 100644
--- a/drivers/staging/iio/industrialio-ring.c
+++ b/drivers/staging/iio/industrialio-ring.c
@@ -20,18 +20,10 @@
 #include <linux/poll.h>
 #include <linux/module.h>
 #include <linux/cdev.h>
-#include <linux/idr.h>
 
 #include "iio.h"
 #include "ring_generic.h"
 
-/* IDR for ring buffer identifier */
-static DEFINE_IDR(iio_ring_idr);
-/* IDR for ring event identifier */
-static DEFINE_IDR(iio_ring_event_idr);
-/* IDR for ring access identifier */
-static DEFINE_IDR(iio_ring_access_idr);
-
 int iio_push_ring_event(struct iio_ring_buffer *ring_buf,
 		       int event_code,
 		       s64 timestamp)
@@ -157,11 +149,8 @@ __iio_request_ring_buffer_event_chrdev(struct iio_ring_buffer *buf,
 				       struct device *dev)
 {
 	int ret;
-	ret = iio_get_new_idr_val(&iio_ring_event_idr);
-	if (ret < 0)
-		goto error_ret;
-	else
-		buf->ev_int.id = ret;
+
+	buf->ev_int.id = id;
 
 	snprintf(buf->ev_int._name, sizeof(buf->ev_int._name),
 		 "%s:event%d",
@@ -172,11 +161,9 @@ __iio_request_ring_buffer_event_chrdev(struct iio_ring_buffer *buf,
 			       owner,
 			       dev);
 	if (ret)
-		goto error_free_id;
+		goto error_ret;
 	return 0;
 
-error_free_id:
-	iio_free_idr_val(&iio_ring_event_idr, buf->ev_int.id);
 error_ret:
 	return ret;
 }
@@ -185,7 +172,6 @@ static inline void
 __iio_free_ring_buffer_event_chrdev(struct iio_ring_buffer *buf)
 {
 	iio_free_ev_int(&(buf->ev_int));
-	iio_free_idr_val(&iio_ring_event_idr, buf->ev_int.id);
 }
 
 static void iio_ring_access_release(struct device *dev)
@@ -221,18 +207,16 @@ __iio_request_ring_buffer_access_chrdev(struct iio_ring_buffer *buf,
 	}
 	buf->access_dev.devt = MKDEV(MAJOR(iio_devt), minor);
 
-	ret = iio_get_new_idr_val(&iio_ring_access_idr);
-	if (ret < 0)
-		goto error_device_put;
-	else
-		buf->access_id = ret;
+
+	buf->access_id = id;
+
 	dev_set_name(&buf->access_dev, "%s:access%d",
 		     dev_name(&buf->dev),
 		     buf->access_id);
 	ret = device_add(&buf->access_dev);
 	if (ret < 0) {
 		printk(KERN_ERR "failed to add the ring access dev\n");
-		goto error_free_idr;
+		goto error_device_put;
 	}
 
 	cdev_init(&buf->access_handler.chrdev, &iio_ring_fileops);
@@ -244,10 +228,9 @@ __iio_request_ring_buffer_access_chrdev(struct iio_ring_buffer *buf,
 		goto error_device_unregister;
 	}
 	return 0;
+
 error_device_unregister:
 	device_unregister(&buf->access_dev);
-error_free_idr:
-	iio_free_idr_val(&iio_ring_access_idr, buf->access_id);
 error_device_put:
 	put_device(&buf->access_dev);
 
@@ -256,7 +239,6 @@ error_device_put:
 
 static void __iio_free_ring_buffer_access_chrdev(struct iio_ring_buffer *buf)
 {
-	iio_free_idr_val(&iio_ring_access_idr, buf->access_id);
 	device_unregister(&buf->access_dev);
 }
 
@@ -271,21 +253,18 @@ void iio_ring_buffer_init(struct iio_ring_buffer *ring,
 }
 EXPORT_SYMBOL(iio_ring_buffer_init);
 
-int iio_ring_buffer_register(struct iio_ring_buffer *ring)
+int iio_ring_buffer_register(struct iio_ring_buffer *ring, int id)
 {
 	int ret;
-	ret = iio_get_new_idr_val(&iio_ring_idr);
-	if (ret < 0)
-		goto error_ret;
-	else
-		ring->id = ret;
+
+	ring->id = id;
 
 	dev_set_name(&ring->dev, "%s:buffer%d",
 		     dev_name(ring->dev.parent),
 		     ring->id);
 	ret = device_add(&ring->dev);
 	if (ret)
-		goto error_free_id;
+		goto error_ret;
 
 	ret = __iio_request_ring_buffer_event_chrdev(ring,
 						     0,
@@ -306,8 +285,6 @@ error_free_ring_buffer_event_chrdev:
 	__iio_free_ring_buffer_event_chrdev(ring);
 error_remove_device:
 	device_del(&ring->dev);
-error_free_id:
-	iio_free_idr_val(&iio_ring_idr, ring->id);
 error_ret:
 	return ret;
 }
@@ -318,7 +295,6 @@ void iio_ring_buffer_unregister(struct iio_ring_buffer *ring)
 	__iio_free_ring_buffer_access_chrdev(ring);
 	__iio_free_ring_buffer_event_chrdev(ring);
 	device_del(&ring->dev);
-	iio_free_idr_val(&iio_ring_idr, ring->id);
 }
 EXPORT_SYMBOL(iio_ring_buffer_unregister);
 
diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio/ring_generic.h
index c649b6d..ea5727a 100644
--- a/drivers/staging/iio/ring_generic.h
+++ b/drivers/staging/iio/ring_generic.h
@@ -261,7 +261,7 @@ static inline void iio_put_ring_buffer(struct iio_ring_buffer *ring)
 	container_of(d, struct iio_ring_buffer, dev)
 #define access_dev_to_iio_ring_buffer(d)			\
 	container_of(d, struct iio_ring_buffer, access_dev)
-int iio_ring_buffer_register(struct iio_ring_buffer *ring);
+int iio_ring_buffer_register(struct iio_ring_buffer *ring, int id);
 void iio_ring_buffer_unregister(struct iio_ring_buffer *ring);
 
 ssize_t iio_read_ring_length(struct device *dev,
-- 
1.6.4.4
