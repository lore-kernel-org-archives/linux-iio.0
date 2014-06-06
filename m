Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:51530 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbaFFObd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 6 Jun 2014 10:31:33 -0400
Received: by mail-wi0-f173.google.com with SMTP id bs8so1103483wib.0
        for <linux-iio@vger.kernel.org>; Fri, 06 Jun 2014 07:31:31 -0700 (PDT)
From: Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
To: linux-iio@vger.kernel.org
Cc: Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
Subject: [PATCH] iio: make blocking read wait for data
Date: Fri,  6 Jun 2014 16:30:52 +0200
Message-Id: <1402065052-32161-1-git-send-email-josselin.costanzi@mobile-devices.fr>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Currently the IIO buffer blocking read only wait until at least one
data element is available.
This patch makes the reader sleep until enough data is collected
before returning to userspace.
This commit also fix a bug where data is lost if an error happens
after some data is already read.

Signed-off-by: Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
---
 drivers/iio/industrialio-buffer.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index e472cff..ce8a1df 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -56,6 +56,7 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
 {
 	struct iio_dev *indio_dev = filp->private_data;
 	struct iio_buffer *rb = indio_dev->buffer;
+	size_t count = 0;
 	int ret;
 
 	if (!indio_dev->info)
@@ -66,24 +67,31 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
 
 	do {
 		if (!iio_buffer_data_available(rb)) {
-			if (filp->f_flags & O_NONBLOCK)
-				return -EAGAIN;
+			if (filp->f_flags & O_NONBLOCK) {
+				ret = -EAGAIN;
+				break;
+			}
 
 			ret = wait_event_interruptible(rb->pollq,
 					iio_buffer_data_available(rb) ||
 					indio_dev->info == NULL);
 			if (ret)
-				return ret;
-			if (indio_dev->info == NULL)
-				return -ENODEV;
+				break;
+			if (indio_dev->info == NULL) {
+				ret = -ENODEV;
+				break;
+			}
 		}
 
-		ret = rb->access->read_first_n(rb, n, buf);
-		if (ret == 0 && (filp->f_flags & O_NONBLOCK))
-			ret = -EAGAIN;
-	 } while (ret == 0);
+		ret = rb->access->read_first_n(rb, n, buf + count);
+		if (ret < 0)
+			break;
 
-	return ret;
+		n -= ret;
+		count += ret;
+	 } while (n > 0);
+
+	return count ? count : ret;
 }
 
 /**
-- 
1.9.1

