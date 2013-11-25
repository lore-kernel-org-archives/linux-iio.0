Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-048.synserver.de ([212.40.185.48]:1255 "EHLO
	smtp-out-025.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756896Ab3KYO4c (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Nov 2013 09:56:32 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] iio: Add support for blocking IO on buffers
Date: Mon, 25 Nov 2013 15:56:44 +0100
Message-Id: <1385391404-3112-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1385391404-3112-1-git-send-email-lars@metafoo.de>
References: <1385391404-3112-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Currently the IIO buffer interface only allows non-blocking reads. This patch
adds support for blocking IO. In blocking mode the thread will go to sleep if no
data is available and will wait for the buffer implementation to signal that new
data is available by waking up the buffers waitqueue.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-buffer.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 4dcc3a0..c67d83b 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -56,13 +56,34 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
 {
 	struct iio_dev *indio_dev = filp->private_data;
 	struct iio_buffer *rb = indio_dev->buffer;
+	int ret;
 
 	if (!indio_dev->info)
 		return -ENODEV;
 
 	if (!rb || !rb->access->read_first_n)
 		return -EINVAL;
-	return rb->access->read_first_n(rb, n, buf);
+
+	do {
+		if (!iio_buffer_data_available(rb)) {
+			if (filp->f_flags & O_NONBLOCK)
+				return -EAGAIN;
+
+			ret = wait_event_interruptible(rb->pollq,
+					iio_buffer_data_available(rb) ||
+					indio_dev->info == NULL);
+			if (ret)
+				return ret;
+			if (indio_dev->info == NULL)
+				return -ENODEV;
+		}
+
+		ret = rb->access->read_first_n(rb, n, buf);
+		if (ret == 0 && (filp->f_flags & O_NONBLOCK))
+			ret = -EAGAIN;
+	 } while (ret == 0);
+
+	return ret;
 }
 
 /**
-- 
1.8.0

