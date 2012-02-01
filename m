Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from am1ehsobe002.messaging.microsoft.com ([213.199.154.205]:33727
	"EHLO AM1EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754590Ab2BASo4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 1 Feb 2012 13:44:56 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@suse.de>
CC: Jonathan Cameron <jic23@kernel.org>, <devel@driverdev.osuosl.org>,
	<linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 6/6] staging:iio:events: Add poll support
Date: Wed, 1 Feb 2012 19:45:56 +0100
Message-ID: <1328121956-29596-7-git-send-email-lars@metafoo.de>
In-Reply-To: <1328121956-29596-1-git-send-email-lars@metafoo.de>
References: <1328121956-29596-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add poll support to the event queue. This will allow us to check for pending
events in a application's event loop using poll() or similar. Since we already
have support for blocking reads adding poll support as well is trivial.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/industrialio-event.c |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/industrialio-event.c b/drivers/staging/iio/industrialio-event.c
index 14e505a..5fdf739 100644
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
@@ -56,7 +57,7 @@ int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp)
 
 		copied = kfifo_put(&ev_int->det_events, &ev);
 		if (copied != 0)
-			wake_up_locked(&ev_int->wait);
+			wake_up_locked_poll(&ev_int->wait, POLLIN);
 	}
 	spin_unlock(&ev_int->wait.lock);
 
@@ -64,6 +65,25 @@ int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp)
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
@@ -117,6 +137,7 @@ static int iio_event_chrdev_release(struct inode *inode, struct file *filep)
 
 static const struct file_operations iio_event_chrdev_fileops = {
 	.read =  iio_event_chrdev_read,
+	.poll =  iio_event_poll,
 	.release = iio_event_chrdev_release,
 	.owner = THIS_MODULE,
 	.llseek = noop_llseek,
-- 
1.7.8.3


