Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: gregkh@suse.de
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 11/20] staging:iio: Directory name changes to match new ABI.
Date: Tue,  4 May 2010 14:43:06 +0100
Message-Id: <1272980595-11033-12-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1272980595-11033-11-git-send-email-jic23@cam.ac.uk>
References: <1272980595-11033-1-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-2-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-3-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-4-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-5-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-6-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-7-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-8-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-9-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-10-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-11-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/chrdev.h            |    2 +-
 drivers/staging/iio/industrialio-core.c |    5 +++--
 drivers/staging/iio/industrialio-ring.c |   13 +++++++++----
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/chrdev.h b/drivers/staging/iio/chrdev.h
index f42bafb..3f96f86 100644
--- a/drivers/staging/iio/chrdev.h
+++ b/drivers/staging/iio/chrdev.h
@@ -94,7 +94,7 @@ struct iio_event_interface {
 	struct iio_chrdev_minor_attr		attr;
 	struct module				*owner;
 	void					*private;
-	char					_name[20];
+	char					_name[35];
 	char					_attrname[20];
 };
 
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index a4ce221..c55d0f3 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -660,8 +660,9 @@ static int iio_device_register_eventset(struct iio_dev *dev_info)
 			dev_info->event_interfaces[i].id = ret;
 
 		snprintf(dev_info->event_interfaces[i]._name, 20,
-			 "event_line%d",
-			dev_info->event_interfaces[i].id);
+			 "%s:event%d",
+			 dev_name(&dev_info->dev),
+			 dev_info->event_interfaces[i].id);
 
 		ret = iio_setup_ev_int(&dev_info->event_interfaces[i],
 				       (const char *)(dev_info
diff --git a/drivers/staging/iio/industrialio-ring.c b/drivers/staging/iio/industrialio-ring.c
index 690df91..0f19bd1 100644
--- a/drivers/staging/iio/industrialio-ring.c
+++ b/drivers/staging/iio/industrialio-ring.c
@@ -164,8 +164,9 @@ __iio_request_ring_buffer_event_chrdev(struct iio_ring_buffer *buf,
 	else
 		buf->ev_int.id = ret;
 
-	snprintf(buf->ev_int._name, 20,
-		 "ring_event_line%d",
+	snprintf(buf->ev_int._name, sizeof(buf->ev_int._name),
+		 "%s:event%d",
+		 dev_name(&buf->dev),
 		 buf->ev_int.id);
 	ret = iio_setup_ev_int(&(buf->ev_int),
 			       buf->ev_int._name,
@@ -226,7 +227,9 @@ __iio_request_ring_buffer_access_chrdev(struct iio_ring_buffer *buf,
 		goto error_device_put;
 	else
 		buf->access_id = ret;
-	dev_set_name(&buf->access_dev, "ring_access%d", buf->access_id);
+	dev_set_name(&buf->access_dev, "%s:access%d",
+		     dev_name(&buf->dev),
+		     buf->access_id);
 	ret = device_add(&buf->access_dev);
 	if (ret < 0) {
 		printk(KERN_ERR "failed to add the ring access dev\n");
@@ -280,7 +283,9 @@ int iio_ring_buffer_register(struct iio_ring_buffer *ring)
 	else
 		ring->id = ret;
 
-	dev_set_name(&ring->dev, "ring_buffer%d", ring->id);
+	dev_set_name(&ring->dev, "%s:buffer%d",
+		     dev_name(ring->dev.parent),
+		     ring->id);
 	ret = device_add(&ring->dev);
 	if (ret)
 		goto error_free_id;
-- 
1.6.4.4
