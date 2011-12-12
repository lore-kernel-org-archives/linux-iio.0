Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:59775
	"EHLO VA3EHSOBE007.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750799Ab1LLIcs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 12 Dec 2011 03:32:48 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@suse.de>
CC: Jonathan Cameron <jic23@kernel.org>, <devel@driverdev.osuosl.org>,
	<linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] staging:iio:kfifo_buf: Fix potential buffer overflow in iio_read_first_n_kfifo
Date: Mon, 12 Dec 2011 09:33:14 +0100
Message-ID: <1323678794-6806-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

n is the number of bytes to read, not the number of samples. So if there is
enough data available we will write to the userspace buffer beyond its bounds.
Fix this by copying n bytes maximum. Also round n down to the next multiple of
the sample size, so we will only read complete samples. If the buffer is too
small to hold at least one sample return -EINVAL.

Also update the documentation of read_first_n to reflect the fact that 'n' is
supposed to be in bytes and not in samples.

Acked-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/buffer.h    |    2 +-
 drivers/staging/iio/kfifo_buf.c |    6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/buffer.h b/drivers/staging/iio/buffer.h
index c697099..44593b2 100644
--- a/drivers/staging/iio/buffer.h
+++ b/drivers/staging/iio/buffer.h
@@ -21,7 +21,7 @@ struct iio_buffer;
  * @mark_in_use:	reference counting, typically to prevent module removal
  * @unmark_in_use:	reduce reference count when no longer using buffer
  * @store_to:		actually store stuff to the buffer
- * @read_first_n:	try to get a specified number of elements (must exist)
+ * @read_first_n:	try to get a specified number of bytes (must exist)
  * @mark_param_change:	notify buffer that some relevant parameter has changed
  *			Often this means the underlying storage may need to
  *			change.
diff --git a/drivers/staging/iio/kfifo_buf.c b/drivers/staging/iio/kfifo_buf.c
index d8867ab..b69cca5 100644
--- a/drivers/staging/iio/kfifo_buf.c
+++ b/drivers/staging/iio/kfifo_buf.c
@@ -160,7 +160,11 @@ static int iio_read_first_n_kfifo(struct iio_buffer *r,
 	int ret, copied;
 	struct iio_kfifo *kf = iio_to_kfifo(r);
 
-	ret = kfifo_to_user(&kf->kf, buf, r->bytes_per_datum*n, &copied);
+	if (n < r->bytes_per_datum)
+		return -EINVAL;
+
+	n = rounddown(n, r->bytes_per_datum);
+	ret = kfifo_to_user(&kf->kf, buf, n, &copied);
 
 	return copied;
 }
-- 
1.7.7.3


