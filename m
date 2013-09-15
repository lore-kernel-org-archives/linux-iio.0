Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio:buffer_cb: Constify iio_cb_access
Date: Sun, 15 Sep 2013 18:09:55 +0200
Message-Id: <1379261395-16304-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The iio_cb_access struct is never modified so we can mark it as const.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/buffer_cb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/buffer_cb.c b/drivers/iio/buffer_cb.c
index 9d19ba7..f406889 100644
--- a/drivers/iio/buffer_cb.c
+++ b/drivers/iio/buffer_cb.c
@@ -21,7 +21,7 @@ static int iio_buffer_cb_store_to(struct iio_buffer *buffer, u8 *data)
 	return cb_buff->cb(data, cb_buff->private);
 }
 
-static struct iio_buffer_access_funcs iio_cb_access = {
+static const struct iio_buffer_access_funcs iio_cb_access = {
 	.store_to = &iio_buffer_cb_store_to,
 };
 
-- 
1.8.0
