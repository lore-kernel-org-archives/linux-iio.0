Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from va3ehsobe004.messaging.microsoft.com ([216.32.180.14]:39572
	"EHLO VA3EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751574Ab2ACN7m (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 3 Jan 2012 08:59:42 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@suse.de>
CC: Jonathan Cameron <jic23@kernel.org>, <devel@driverdev.osuosl.org>,
	<linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/6] staging:iio:events: Use non-atmoic bitops
Date: Tue, 3 Jan 2012 14:59:42 +0100
Message-ID: <1325599182-5376-6-git-send-email-lars@metafoo.de>
In-Reply-To: <1325599182-5376-1-git-send-email-lars@metafoo.de>
References: <1325599182-5376-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

We always hold the waitqueue lock when modifying the flags field. So it is safe
to use the non-atomic bitops here instead of the atomic versions.

The lock has to be held, because we need to clear the busy flag and flush the
event FIFO in one atomic operation when closing the event file descriptor.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/industrialio-event.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/industrialio-event.c b/drivers/staging/iio/industrialio-event.c
index 800f67d..66d320b 100644
--- a/drivers/staging/iio/industrialio-event.c
+++ b/drivers/staging/iio/industrialio-event.c
@@ -124,7 +124,7 @@ static int iio_event_chrdev_release(struct inode *inode, struct file *filep)
 	struct iio_event_interface *ev_int = filep->private_data;
 
 	spin_lock(&ev_int->wait.lock);
-	clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
+	__clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
 	/*
 	 * In order to maintain a clean state for reopening,
 	 * clear out any awaiting events. The mask will prevent
@@ -153,7 +153,7 @@ int iio_event_getfd(struct iio_dev *indio_dev)
 		return -ENODEV;
 
 	spin_lock(&ev_int->wait.lock);
-	if (test_and_set_bit(IIO_BUSY_BIT_POS, &ev_int->flags)) {
+	if (__test_and_set_bit(IIO_BUSY_BIT_POS, &ev_int->flags)) {
 		spin_unlock(&ev_int->wait.lock);
 		return -EBUSY;
 	}
@@ -162,7 +162,7 @@ int iio_event_getfd(struct iio_dev *indio_dev)
 				&iio_event_chrdev_fileops, ev_int, O_RDONLY);
 	if (fd < 0) {
 		spin_lock(&ev_int->wait.lock);
-		clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
+		__clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
 		spin_unlock(&ev_int->wait.lock);
 	}
 	return fd;
-- 
1.7.7.3


