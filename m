Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio:kfifo_buf: Use wake_up_interruptible_poll()
Date: Sun, 15 Sep 2013 17:31:34 +0200
Message-Id: <1379259094-22577-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Use wake_up_interruptible_poll() instead of wake_up_interruptible() to only wake
up those threads that listen for input poll notifications.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/kfifo_buf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
index a923c78..1bea41b 100644
--- a/drivers/iio/kfifo_buf.c
+++ b/drivers/iio/kfifo_buf.c
@@ -7,6 +7,7 @@
 #include <linux/mutex.h>
 #include <linux/iio/kfifo_buf.h>
 #include <linux/sched.h>
+#include <linux/poll.h>
 
 struct iio_kfifo {
 	struct iio_buffer buffer;
@@ -102,7 +103,7 @@ static int iio_store_to_kfifo(struct iio_buffer *r,
 	if (ret != 1)
 		return -EBUSY;
 	r->stufftoread = true;
-	wake_up_interruptible(&r->pollq);
+	wake_up_interruptible_poll(&r->pollq, POLLIN | POLLRDNORM);
 
 	return 0;
 }
-- 
1.8.0
