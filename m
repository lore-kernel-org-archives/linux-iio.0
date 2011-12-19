Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:53939 "EHLO
	TX2EHSOBE009.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752369Ab1LSOXf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 19 Dec 2011 09:23:35 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@suse.de>
CC: Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	<devel@driverdev.osuosl.org>, <linux-iio@vger.kernel.org>,
	<device-drivers-devel@blackfin.uclinux.org>, <drivers@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/8] staging:iio: Drop buffer busy flag
Date: Mon, 19 Dec 2011 15:23:46 +0100
Message-ID: <1324304629-24720-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1324304629-24720-1-git-send-email-lars@metafoo.de>
References: <1324304629-24720-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The flag is only cleared, never set or tested, so it is safe to remove it.

Acked-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/buffer.h              |    2 --
 drivers/staging/iio/industrialio-buffer.c |    1 -
 2 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/buffer.h b/drivers/staging/iio/buffer.h
index 44593b2..eb4938c 100644
--- a/drivers/staging/iio/buffer.h
+++ b/drivers/staging/iio/buffer.h
@@ -79,7 +79,6 @@ struct iio_buffer_access_funcs {
  *			created from the iio_chan_info array.
  * @pollq:		[INTERN] wait queue to allow for polling on the buffer.
  * @stufftoread:	[INTERN] flag to indicate new data.
- * @flags:		[INTERN] file ops related flags including busy flag.
  * @demux_list:		[INTERN] list of operations required to demux the scan.
  * @demux_bounce:	[INTERN] buffer for doing gather from incoming scan.
  **/
@@ -95,7 +94,6 @@ struct iio_buffer {
 	struct attribute_group			scan_el_group;
 	wait_queue_head_t			pollq;
 	bool					stufftoread;
-	unsigned long				flags;
 	const struct attribute_group *attrs;
 	struct list_head			demux_list;
 	unsigned char				*demux_bounce;
diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
index 5947289..4c6d183 100644
--- a/drivers/staging/iio/industrialio-buffer.c
+++ b/drivers/staging/iio/industrialio-buffer.c
@@ -80,7 +80,6 @@ void iio_chrdev_buffer_release(struct iio_dev *indio_dev)
 
 	if (!rb)
 		return;
-	clear_bit(IIO_BUSY_BIT_POS, &rb->flags);
 	if (rb->access->unmark_in_use)
 		rb->access->unmark_in_use(rb);
 }
-- 
1.7.7.3


