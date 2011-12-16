Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:10199
	"EHLO VA3EHSOBE007.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753457Ab1LPRMD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 16 Dec 2011 12:12:03 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	<linux-iio@vger.kernel.org>,
	<device-drivers-devel@blackfin.uclinux.org>, <drivers@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/4] staging:iio:events: Use waitqueue lock to protect event queue
Date: Fri, 16 Dec 2011 18:12:21 +0100
Message-ID: <1324055542-31272-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1324055542-31272-1-git-send-email-lars@metafoo.de>
References: <1324055542-31272-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use the waitqueue lock to protect the event queue instead of a custom mutex.
This has the advantage that we can call the waitqueue operations with the lock
held, which simplifies the code flow a bit.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/industrialio-event.c |   43 ++++++++++++-----------------
 1 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/iio/industrialio-event.c b/drivers/staging/iio/industrialio-event.c
index 50d03bd..ef4943a 100644
--- a/drivers/staging/iio/industrialio-event.c
+++ b/drivers/staging/iio/industrialio-event.c
@@ -34,7 +34,6 @@
  */
 struct iio_event_interface {
 	wait_queue_head_t			wait;
-	struct mutex				event_list_lock;
 	DECLARE_KFIFO(det_events, struct iio_event_data, 16);
 
 	struct list_head dev_attr_list;
@@ -49,19 +48,17 @@ int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp)
 	int ret = 0;
 
 	/* Does anyone care? */
-	mutex_lock(&ev_int->event_list_lock);
+	spin_lock(&ev_int->wait.lock);
 	if (test_bit(IIO_BUSY_BIT_POS, &ev_int->flags)) {
 
 		ev.id = ev_code;
 		ev.timestamp = timestamp;
 
 		ret = kfifo_put(&ev_int->det_events, &ev);
-
-		mutex_unlock(&ev_int->event_list_lock);
 		if (ret != 0)
-			wake_up_interruptible(&ev_int->wait);
-	} else
-		mutex_unlock(&ev_int->event_list_lock);
+			wake_up_locked(&ev_int->wait);
+	}
+	spin_unlock(&ev_int->wait.lock);
 
 	return ret;
 }
@@ -79,28 +76,25 @@ static ssize_t iio_event_chrdev_read(struct file *filep,
 	if (count < sizeof(struct iio_event_data))
 		return -EINVAL;
 
-	mutex_lock(&ev_int->event_list_lock);
+	spin_lock(&ev_int->wait.lock);
 	if (kfifo_is_empty(&ev_int->det_events)) {
 		if (filep->f_flags & O_NONBLOCK) {
 			ret = -EAGAIN;
-			goto error_mutex_unlock;
+			goto error_unlock;
 		}
-		mutex_unlock(&ev_int->event_list_lock);
 		/* Blocking on device; waiting for something to be there */
-		ret = wait_event_interruptible(ev_int->wait,
+		ret = wait_event_interruptible_locked(ev_int->wait,
 					!kfifo_is_empty(&ev_int->det_events));
 		if (ret)
-			goto error_ret;
+			goto error_unlock;
 		/* Single access device so no one else can get the data */
-		mutex_lock(&ev_int->event_list_lock);
 	}
 
-	mutex_unlock(&ev_int->event_list_lock);
 	ret = kfifo_to_user(&ev_int->det_events, buf, count, &copied);
 
-error_mutex_unlock:
-	mutex_unlock(&ev_int->event_list_lock);
-error_ret:
+error_unlock:
+	spin_unlock(&ev_int->wait.lock);
+
 	return ret ? ret : copied;
 }
 
@@ -108,10 +102,10 @@ static int iio_event_chrdev_release(struct inode *inode, struct file *filep)
 {
 	struct iio_event_interface *ev_int = filep->private_data;
 
-	mutex_lock(&ev_int->event_list_lock);
+	spin_lock(&ev_int->wait.lock);
 	clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
 	kfifo_reset_out(&ev_int->det_events);
-	mutex_unlock(&ev_int->event_list_lock);
+	spin_unlock(&ev_int->wait.lock);
 
 	return 0;
 }
@@ -131,18 +125,18 @@ int iio_event_getfd(struct iio_dev *indio_dev)
 	if (ev_int == NULL)
 		return -ENODEV;
 
-	mutex_lock(&ev_int->event_list_lock);
+	spin_lock(&ev_int->wait.lock);
 	if (test_and_set_bit(IIO_BUSY_BIT_POS, &ev_int->flags)) {
-		mutex_unlock(&ev_int->event_list_lock);
+		spin_unlock(&ev_int->wait.lock);
 		return -EBUSY;
 	}
-	mutex_unlock(&ev_int->event_list_lock);
+	spin_unlock(&ev_int->wait.lock);
 	fd = anon_inode_getfd("iio:event",
 				&iio_event_chrdev_fileops, ev_int, O_RDONLY);
 	if (fd < 0) {
-		mutex_lock(&ev_int->event_list_lock);
+		spin_lock(&ev_int->wait.lock);
 		clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
-		mutex_unlock(&ev_int->event_list_lock);
+		spin_unlock(&ev_int->wait.lock);
 	}
 	return fd;
 }
@@ -351,7 +345,6 @@ static bool iio_check_for_dynamic_events(struct iio_dev *indio_dev)
 
 static void iio_setup_ev_int(struct iio_event_interface *ev_int)
 {
-	mutex_init(&ev_int->event_list_lock);
 	INIT_KFIFO(ev_int->det_events);
 	init_waitqueue_head(&ev_int->wait);
 }
-- 
1.7.7.3


