Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 5/6] staging:iio:events: Use non-atomic bitops
Date: Wed,  1 Feb 2012 22:17:53 +0100
Message-Id: <1328131074-2739-6-git-send-email-lars@metafoo.de>
In-Reply-To: <1328131074-2739-1-git-send-email-lars@metafoo.de>
References: <1328131074-2739-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

We always hold the waitqueue lock when modifying the flags field. So it is safe
to use the non-atomic bitops here instead of the atomic versions.

The lock has to be held, because we need to clear the busy flag and flush the
event fifo in one atomic operation when closing the event file descriptor.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>

---
Changes since v1:
	* Fix typo in subject
---
 drivers/staging/iio/industrialio-event.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/industrialio-event.c b/drivers/staging/iio/industrialio-event.c
index 2e7cf88..14e505a 100644
--- a/drivers/staging/iio/industrialio-event.c
+++ b/drivers/staging/iio/industrialio-event.c
@@ -103,7 +103,7 @@ static int iio_event_chrdev_release(struct inode *inode, struct file *filep)
 	struct iio_event_interface *ev_int = filep->private_data;
 
 	spin_lock(&ev_int->wait.lock);
-	clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
+	__clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
 	/*
 	 * In order to maintain a clean state for reopening,
 	 * clear out any awaiting events. The mask will prevent
@@ -131,7 +131,7 @@ int iio_event_getfd(struct iio_dev *indio_dev)
 		return -ENODEV;
 
 	spin_lock(&ev_int->wait.lock);
-	if (test_and_set_bit(IIO_BUSY_BIT_POS, &ev_int->flags)) {
+	if (__test_and_set_bit(IIO_BUSY_BIT_POS, &ev_int->flags)) {
 		spin_unlock(&ev_int->wait.lock);
 		return -EBUSY;
 	}
@@ -140,7 +140,7 @@ int iio_event_getfd(struct iio_dev *indio_dev)
 				&iio_event_chrdev_fileops, ev_int, O_RDONLY);
 	if (fd < 0) {
 		spin_lock(&ev_int->wait.lock);
-		clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
+		__clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
 		spin_unlock(&ev_int->wait.lock);
 	}
 	return fd;
-- 
1.7.8.3
