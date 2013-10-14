Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-149.synserver.de ([212.40.185.149]:1057 "EHLO
	smtp-out-149.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756423Ab3JNPHT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 14 Oct 2013 11:07:19 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] iio:kfifo: Set update_needed to false after allocating a new buffer
Date: Mon, 14 Oct 2013 17:09:10 +0200
Message-Id: <1381763350-8930-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1381763350-8930-1-git-send-email-lars@metafoo.de>
References: <1381763350-8930-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

update_needed is used to decide whether the kfifo buffer needs to be
re-allocated. It is set to true whenever the size of the buffer is changed. It
is never set to false though, causing the buffer to always be re-allocated.
Setting update_needed to false after the new buffer has been allocated fixes the
problem.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/kfifo_buf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
index a050b18..920e383 100644
--- a/drivers/iio/kfifo_buf.c
+++ b/drivers/iio/kfifo_buf.c
@@ -40,6 +40,7 @@ static int iio_request_update_kfifo(struct iio_buffer *r)
 		kfifo_free(&buf->kf);
 		ret = __iio_allocate_kfifo(buf, buf->buffer.bytes_per_datum,
 				   buf->buffer.length);
+		buf->update_needed = false;
 	}
 	r->stufftoread = false;
 	mutex_unlock(&buf->user_lock);
-- 
1.8.0

