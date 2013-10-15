Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 4/4] iio:kfifo: Set update_needed to false after allocating a new buffer
Date: Tue, 15 Oct 2013 10:30:30 +0200
Message-Id: <1381825830-25581-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1381825830-25581-1-git-send-email-lars@metafoo.de>
References: <1381825830-25581-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

update_needed is used to decide whether the kfifo buffer needs to be
re-allocated. It is set to true whenever the size of the buffer is changed. It
is never set to false though, causing the buffer to always be re-allocated.
Setting update_needed to false after the new buffer has been allocated fixes the
problem.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
No changes in v2
---
 drivers/iio/kfifo_buf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
index d654f42..95c6fc8 100644
--- a/drivers/iio/kfifo_buf.c
+++ b/drivers/iio/kfifo_buf.c
@@ -38,6 +38,7 @@ static int iio_request_update_kfifo(struct iio_buffer *r)
 		kfifo_free(&buf->kf);
 		ret = __iio_allocate_kfifo(buf, buf->buffer.bytes_per_datum,
 				   buf->buffer.length);
+		buf->update_needed = false;
 	} else {
 		kfifo_reset_out(&buf->kf);
 	}
-- 
1.8.0
