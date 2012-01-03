Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@suse.de>
CC: Jonathan Cameron <jic23@kernel.org>, <devel@driverdev.osuosl.org>,
	<linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/6] staging:iio:events: Add poll support
Date: Tue, 3 Jan 2012 14:59:41 +0100
Message-ID: <1325599182-5376-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1325599182-5376-1-git-send-email-lars@metafoo.de>
References: <1325599182-5376-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Add poll support to the event queue. This will allow us to check for pending
events in a application's event loop using poll() or similar. Since we already
have support for blocking reads adding poll support as well is trivial.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/industrialio-event.c |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/industrialio-event.c b/drivers/staging/iio/industrialio-event.c
index f0c41f1..800f67d 100644
--- a/drivers/staging/iio/industrialio-event.c
+++ b/drivers/staging/iio/industrialio-event.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/kfifo.h>
 #include <linux/module.h>
+#include <linux/poll.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
@@ -57,7 +58,7 @@ int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp)
 
 		copied = kfifo_put(&ev_int->det_events, &ev);
 		if (copied != 0)
-			wake_up_locked(&ev_int->wait);
+			wake_up_locked_poll(&ev_int->wait, POLLIN);
 	}
 	spin_unlock(&ev_int->wait.lock);
 
@@ -65,6 +66,25 @@ int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp)
 }
 EXPORT_SYMBOL(iio_push_event);
 
+/**
+ * iio_event_poll() - poll the event queue to find out if it has data
+ */
+static unsigned int iio_event_poll(struct file *filep,
+			     struct poll_table_struct *wait)
+{
+	struct iio_event_interface *ev_int = filep->private_data;
+	unsigned int events = 0;
+
+	poll_wait(filep, &ev_int->wait, wait);
+
+	spin_lock(&ev_int->wait.lock);
+	if (!kfifo_is_empty(&ev_int->det_events))
+		events = POLLIN | POLLRDNORM;
+	spin_unlock(&ev_int->wait.lock);
+
+	return events;
+}
+
 static ssize_t iio_event_chrdev_read(struct file *filep,
 				     char __user *buf,
 				     size_t count,
@@ -118,6 +138,7 @@ static int iio_event_chrdev_release(struct inode *inode, struct file *filep)
 
 static const struct file_operations iio_event_chrdev_fileops = {
 	.read =  iio_event_chrdev_read,
+	.poll =  iio_event_poll,
 	.release = iio_event_chrdev_release,
 	.owner = THIS_MODULE,
 	.llseek = noop_llseek,
-- 
1.7.7.3
