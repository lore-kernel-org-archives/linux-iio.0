Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] staging:iio: Remove declaration for non existing function
Date: Tue, 21 Feb 2012 18:53:39 +0100
Message-Id: <1329846819-27261-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The declaration for iio_buffer_deinit has been around for quite some time, but
the function itself has never been added. So remove the declaration.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/buffer.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/buffer.h b/drivers/staging/iio/buffer.h
index 6fb6e64..df2046d 100644
--- a/drivers/staging/iio/buffer.h
+++ b/drivers/staging/iio/buffer.h
@@ -91,8 +91,6 @@ struct iio_buffer {
  **/
 void iio_buffer_init(struct iio_buffer *buffer);
 
-void iio_buffer_deinit(struct iio_buffer *buffer);
-
 /**
  * __iio_update_buffer() - update common elements of buffers
  * @buffer:		buffer that is the event source
-- 
1.7.9
