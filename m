Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: buffer-dmaengine: Use dmaengine_terminate_sync()
Date: Mon,  8 Feb 2016 18:51:58 +0100
Message-Id: <1454953918-1004-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The DMAengine framework gained support for synchronized transfer
termination. Use the new dmaengine_terminate_sync() function instead of
dmaengine_terminate_all(), this avoids a potential race condition when
disabling the buffer.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index ebdb838..9fabed4 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -93,12 +93,7 @@ static void iio_dmaengine_buffer_abort(struct iio_dma_buffer_queue *queue)
 	struct dmaengine_buffer *dmaengine_buffer =
 		iio_buffer_to_dmaengine_buffer(&queue->buffer);
 
-	dmaengine_terminate_all(dmaengine_buffer->chan);
-	/* FIXME: There is a slight chance of a race condition here.
-	 * dmaengine_terminate_all() does not guarantee that all transfer
-	 * callbacks have finished running. Need to introduce a
-	 * dmaengine_terminate_all_sync().
-	 */
+	dmaengine_terminate_sync(dmaengine_buffer->chan);
 	iio_dma_buffer_block_list_abort(queue, &dmaengine_buffer->active);
 }
 
-- 
2.1.4
