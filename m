Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] staging:iio: Prevent reading from buffer chrdev when device has no buffer.
Date: Mon, 19 Sep 2011 14:03:37 +0100
Message-Id: <1316437417-9962-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Silly bug introduced during the chrdev merge series.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
Fix is pretty trivial so I'll send this on to Greg shortly 
if no one shouts!

Jonathan

 drivers/staging/iio/industrialio-buffer.c |    8 +++++---
 drivers/staging/iio/industrialio-core.c   |    5 +++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
index c3f57e7..4ce101a 100644
--- a/drivers/staging/iio/industrialio-buffer.c
+++ b/drivers/staging/iio/industrialio-buffer.c
@@ -63,11 +63,14 @@ unsigned int iio_buffer_poll(struct file *filp,
 	return 0;
 }
 
-void iio_chrdev_buffer_open(struct iio_dev *indio_dev)
+int iio_chrdev_buffer_open(struct iio_dev *indio_dev)
 {
 	struct iio_buffer *rb = indio_dev->buffer;
-	if (rb && rb->access->mark_in_use)
+	if (!rb)
+		return -EINVAL;
+	if (rb->access->mark_in_use)
 		rb->access->mark_in_use(rb);
+	return 0;
 }
 
 void iio_chrdev_buffer_release(struct iio_dev *indio_dev)
@@ -77,7 +80,6 @@ void iio_chrdev_buffer_release(struct iio_dev *indio_dev)
 	clear_bit(IIO_BUSY_BIT_POS, &rb->flags);
 	if (rb->access->unmark_in_use)
 		rb->access->unmark_in_use(rb);
-
 }
 
 void iio_buffer_init(struct iio_buffer *buffer, struct iio_dev *dev_info)
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index b11c7f3..2f535b1 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -1062,11 +1062,12 @@ EXPORT_SYMBOL(iio_free_device);
  **/
 static int iio_chrdev_open(struct inode *inode, struct file *filp)
 {
+	int ret;
 	struct iio_dev *dev_info = container_of(inode->i_cdev,
 						struct iio_dev, chrdev);
 	filp->private_data = dev_info;
-	iio_chrdev_buffer_open(dev_info);
-	return 0;
+
+	return iio_chrdev_buffer_open(dev_info);
 }
 
 /**
-- 
1.7.3.4
