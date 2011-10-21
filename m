Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:60195 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754414Ab1JULeV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 21 Oct 2011 07:34:21 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] staging:iio: core.  Allow for event chrdev obtaining ioctl if no buffer present.
Date: Fri, 21 Oct 2011 12:34:25 +0100
Message-Id: <1319196865-22766-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1319196865-22766-1-git-send-email-jic23@cam.ac.uk>
References: <1319196865-22766-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Logic bug meant the chrdev would fail to open if there was no buffer support
in a driver or in the core. This meant the ioctl to get the event chrdev
would fail and hence events were not available.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio_core.h            |    2 +-
 drivers/staging/iio/industrialio-buffer.c |    6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/iio_core.h b/drivers/staging/iio/iio_core.h
index 36159e0..ff27f13 100644
--- a/drivers/staging/iio/iio_core.h
+++ b/drivers/staging/iio/iio_core.h
@@ -49,7 +49,7 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
 
 static inline int iio_chrdev_buffer_open(struct iio_dev *indio_dev)
 {
-	return -EINVAL;
+	return 0;
 }
 
 static inline void iio_chrdev_buffer_release(struct iio_dev *indio_dev)
diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
index bac672d..1a71171 100644
--- a/drivers/staging/iio/industrialio-buffer.c
+++ b/drivers/staging/iio/industrialio-buffer.c
@@ -42,6 +42,8 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
 	struct iio_dev *indio_dev = filp->private_data;
 	struct iio_buffer *rb = indio_dev->buffer;
 
+	if (!rb)
+		return -ENODEV;
 	if (!rb->access->read_first_n)
 		return -EINVAL;
 	return rb->access->read_first_n(rb, n, buf);
@@ -67,7 +69,7 @@ int iio_chrdev_buffer_open(struct iio_dev *indio_dev)
 {
 	struct iio_buffer *rb = indio_dev->buffer;
 	if (!rb)
-		return -EINVAL;
+		return 0;
 	if (rb->access->mark_in_use)
 		rb->access->mark_in_use(rb);
 	return 0;
@@ -77,6 +79,8 @@ void iio_chrdev_buffer_release(struct iio_dev *indio_dev)
 {
 	struct iio_buffer *rb = indio_dev->buffer;
 
+	if (!rb)
+		return;
 	clear_bit(IIO_BUSY_BIT_POS, &rb->flags);
 	if (rb->access->unmark_in_use)
 		rb->access->unmark_in_use(rb);
-- 
1.7.7

