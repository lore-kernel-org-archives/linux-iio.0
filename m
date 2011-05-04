Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:57463 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754024Ab1EDL4u (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 May 2011 07:56:50 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de, Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 05/99] staging:iio: Add polling of events on the ring access chrdev.
Date: Wed,  4 May 2011 12:57:37 +0100
Message-Id: <1304510351-10922-6-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Staging one of combining the ring chrdevs.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/industrialio-ring.c |   29 ++++++++++++++++++++++++-----
 drivers/staging/iio/ring_generic.h      |    3 +++
 drivers/staging/iio/ring_sw.c           |    8 ++++++++
 3 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/industrialio-ring.c b/drivers/staging/iio/industrialio-ring.c
index 5d7cd0e..5c3f466 100644
--- a/drivers/staging/iio/industrialio-ring.c
+++ b/drivers/staging/iio/industrialio-ring.c
@@ -18,6 +18,7 @@
 #include <linux/fs.h>
 #include <linux/cdev.h>
 #include <linux/slab.h>
+#include <linux/poll.h>
 
 #include "iio.h"
 #include "ring_generic.h"
@@ -90,10 +91,27 @@ static ssize_t iio_ring_read_first_n_outer(struct file *filp, char __user *buf,
 	return ret;
 }
 
+/**
+ * iio_ring_poll() - poll the ring to find out if it has data
+ */
+static unsigned int iio_ring_poll(struct file *filp,
+				  struct poll_table_struct *wait)
+{
+	struct iio_ring_buffer *rb = filp->private_data;
+	int ret = 0;
+
+	poll_wait(filp, &rb->pollq, wait);
+	if (rb->stufftoread)
+		return POLLIN | POLLRDNORM;
+	/* need a way of knowing if there may be enough data... */
+	return ret;
+}
+
 static const struct file_operations iio_ring_fileops = {
 	.read = iio_ring_read_first_n_outer,
 	.release = iio_ring_release,
 	.open = iio_ring_open,
+	.poll = iio_ring_poll,
 	.owner = THIS_MODULE,
 	.llseek = noop_llseek,
 };
@@ -211,6 +229,7 @@ void iio_ring_buffer_init(struct iio_ring_buffer *ring,
 	ring->indio_dev = dev_info;
 	ring->ev_int.private = ring;
 	ring->access_handler.private = ring;
+	init_waitqueue_head(&ring->pollq);
 }
 EXPORT_SYMBOL(iio_ring_buffer_init);
 
@@ -392,7 +411,7 @@ int iio_ring_buffer_register_ex(struct iio_ring_buffer *ring, int id,
 						      ring->owner);
 
 	if (ret)
-		goto error_free_ring_buffer_event_chrdev;
+		goto error_ret;
 
 	if (ring->scan_el_attrs) {
 		ret = sysfs_create_group(&ring->dev.kobj,
@@ -400,13 +419,13 @@ int iio_ring_buffer_register_ex(struct iio_ring_buffer *ring, int id,
 		if (ret) {
 			dev_err(&ring->dev,
 				"Failed to add sysfs scan elements\n");
-			goto error_free_ring_buffer_event_chrdev;
+			goto error_free_ring_buffer_access_chrdev;
 		}
 	} else if (channels) {
 		ret = sysfs_create_group(&ring->dev.kobj,
 					 &iio_scan_el_dummy_group);
 		if (ret)
-			goto error_free_ring_buffer_event_chrdev;
+			goto error_free_ring_buffer_access_chrdev;
 	}
 
 
@@ -424,8 +443,8 @@ int iio_ring_buffer_register_ex(struct iio_ring_buffer *ring, int id,
 	return 0;
 error_cleanup_dynamic:
 	__iio_ring_attr_cleanup(ring);
-error_free_ring_buffer_event_chrdev:
-	__iio_free_ring_buffer_event_chrdev(ring);
+error_free_ring_buffer_access_chrdev:
+	__iio_free_ring_buffer_access_chrdev(ring);
 error_remove_device:
 	device_del(&ring->dev);
 error_ret:
diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio/ring_generic.h
index d51c21c..0640a8a 100644
--- a/drivers/staging/iio/ring_generic.h
+++ b/drivers/staging/iio/ring_generic.h
@@ -139,6 +139,9 @@ struct iio_ring_buffer {
 
 	struct list_head scan_el_dev_attr_list;
 	struct list_head scan_el_en_attr_list;
+
+	wait_queue_head_t pollq;
+	bool stufftoread;
 };
 
 /**
diff --git a/drivers/staging/iio/ring_sw.c b/drivers/staging/iio/ring_sw.c
index 0004814..53c6774 100644
--- a/drivers/staging/iio/ring_sw.c
+++ b/drivers/staging/iio/ring_sw.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/workqueue.h>
+#include <linux/sched.h>
 #include <linux/poll.h>
 #include "ring_sw.h"
 #include "trigger.h"
@@ -136,6 +137,8 @@ static int iio_store_to_sw_ring(struct iio_sw_ring_buffer *ring,
 		ret = __iio_push_event(&ring->buf.ev_int,
 				       code,
 				       timestamp);
+		ring->buf.stufftoread = true;
+		wake_up_interruptible(&ring->buf.pollq);
 	}
 	return ret;
 }
@@ -261,6 +264,10 @@ int iio_read_first_n_sw_rb(struct iio_ring_buffer *r,
 		ret =  -EFAULT;
 		goto error_free_data_cpy;
 	}
+
+	if (bytes_to_rip >= ring->buf.length*ring->buf.bytes_per_datum/2)
+		ring->buf.stufftoread = 0;
+
 error_free_data_cpy:
 	kfree(data);
 error_ret:
@@ -310,6 +317,7 @@ int iio_request_update_sw_rb(struct iio_ring_buffer *r)
 	int ret = 0;
 	struct iio_sw_ring_buffer *ring = iio_to_sw_ring(r);
 
+	r->stufftoread = false;
 	spin_lock(&ring->use_lock);
 	if (!ring->update_needed)
 		goto error_ret;
-- 
1.7.3.4

