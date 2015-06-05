Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:47688 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932656AbbFEM4z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 5 Jun 2015 08:56:55 -0400
From: Octavian Purdila <octavian.purdila@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Octavian Purdila <octavian.purdila@intel.com>
Subject: [PATCH v2] iio: allow userspace to flush the hwfifo with non-blocking reads
Date: Fri,  5 Jun 2015 15:56:47 +0300
Message-Id: <1433509007-5095-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch changes the semantics of non-blocking reads so that a
hardware fifo flush is triggered if the available data in the device
buffer is less then the requested size.

This allows userspace to accurately generate hardware fifo flushes, by
doing a non-blocking read with a size greater then the sum of the
device buffer and hardware fifo size.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---

This is the second iteration of the patch that allows userspace to
accurately generate flush events. The first RFC patch set was
discussed here:

https://lkml.org/lkml/2015/4/29/202


 drivers/iio/industrialio-buffer.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index df919f4..24085db 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -71,8 +71,9 @@ static bool iio_buffer_ready(struct iio_dev *indio_dev, struct iio_buffer *buf,
 
 	if (avail >= to_wait) {
 		/* force a flush for non-blocking reads */
-		if (!to_wait && !avail && to_flush)
-			iio_buffer_flush_hwfifo(indio_dev, buf, to_flush);
+		if (!to_wait && avail < to_flush)
+			iio_buffer_flush_hwfifo(indio_dev, buf,
+						to_flush - avail);
 		return true;
 	}
 
@@ -100,8 +101,7 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
 	struct iio_dev *indio_dev = filp->private_data;
 	struct iio_buffer *rb = indio_dev->buffer;
 	size_t datum_size;
-	size_t to_wait = 0;
-	size_t to_read;
+	size_t to_wait;
 	int ret;
 
 	if (!indio_dev->info)
@@ -119,14 +119,14 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
 	if (!datum_size)
 		return 0;
 
-	to_read = min_t(size_t, n / datum_size, rb->watermark);
-
-	if (!(filp->f_flags & O_NONBLOCK))
-		to_wait = to_read;
+	if (filp->f_flags & O_NONBLOCK)
+		to_wait = 0;
+	else
+		to_wait = min_t(size_t, n / datum_size, rb->watermark);
 
 	do {
 		ret = wait_event_interruptible(rb->pollq,
-			iio_buffer_ready(indio_dev, rb, to_wait, to_read));
+		      iio_buffer_ready(indio_dev, rb, to_wait, n / datum_size));
 		if (ret)
 			return ret;
 
-- 
1.9.1

