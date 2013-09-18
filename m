Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-014.synserver.de ([212.40.185.14]:1044 "EHLO
	smtp-out-011.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753632Ab3IRUBZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2013 16:01:25 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 07/10] iio: Return -ENODEV for file operations if the device has been unregistered
Date: Wed, 18 Sep 2013 22:02:51 +0200
Message-Id: <1379534574-11213-7-git-send-email-lars@metafoo.de>
In-Reply-To: <1379534574-11213-1-git-send-email-lars@metafoo.de>
References: <1379534574-11213-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If the IIO device has been unregistered return -ENODEV for any further file
operations like read() and ioctl(). This avoids userspace being able to grab new
references to the device.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-buffer.c | 6 ++++++
 drivers/iio/industrialio-core.c   | 3 +++
 drivers/iio/industrialio-event.c  | 6 ++++++
 3 files changed, 15 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 54d3b9b..e9cbde3 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -48,6 +48,9 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
 	struct iio_dev *indio_dev = filp->private_data;
 	struct iio_buffer *rb = indio_dev->buffer;
 
+	if (!indio_dev->info)
+		return -ENODEV;
+
 	if (!rb || !rb->access->read_first_n)
 		return -EINVAL;
 	return rb->access->read_first_n(rb, n, buf);
@@ -62,6 +65,9 @@ unsigned int iio_buffer_poll(struct file *filp,
 	struct iio_dev *indio_dev = filp->private_data;
 	struct iio_buffer *rb = indio_dev->buffer;
 
+	if (!indio_dev->info)
+		return -ENODEV;
+
 	poll_wait(filp, &rb->pollq, wait);
 	if (rb->stufftoread)
 		return POLLIN | POLLRDNORM;
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 3e581a76..dd7b601 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1041,6 +1041,9 @@ static long iio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	int __user *ip = (int __user *)arg;
 	int fd;
 
+	if (!indio_dev->info)
+		return -ENODEV;
+
 	if (cmd == IIO_GET_EVENT_FD_IOCTL) {
 		fd = iio_event_getfd(indio_dev);
 		if (copy_to_user(ip, &fd, sizeof(fd)))
diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index f89843b..3843abf 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -76,6 +76,9 @@ static unsigned int iio_event_poll(struct file *filep,
 	struct iio_event_interface *ev_int = indio_dev->event_interface;
 	unsigned int events = 0;
 
+	if (!indio_dev->info)
+		return -ENODEV;
+
 	poll_wait(filep, &ev_int->wait, wait);
 
 	spin_lock_irq(&ev_int->wait.lock);
@@ -96,6 +99,9 @@ static ssize_t iio_event_chrdev_read(struct file *filep,
 	unsigned int copied;
 	int ret;
 
+	if (!indio_dev->info)
+		return -ENODEV;
+
 	if (count < sizeof(struct iio_event_data))
 		return -EINVAL;
 
-- 
1.8.0

