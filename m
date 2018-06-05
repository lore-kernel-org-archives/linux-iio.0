Return-Path: <SRS0=bAd9=IX=electromag.com.au=preid@kernel.org>
From: Phil Reid <preid@electromag.com.au>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
  preid@electromag.com.au, linux-iio@vger.kernel.org
Subject: [PATCH 1/1] iio: buffer: fix the function signature to match implementation
Date: Tue,  5 Jun 2018 14:15:10 +0800
Message-Id: <1528179310-10753-1-git-send-email-preid@electromag.com.au>
List-ID: <linux-iio@vger.kernel.org>

linux/iio/buffer-dma.h was not updated to when length was changed to
unsigned int.

Fixes: c043ec1ca5ba ("iio:buffer: make length types match kfifo types")
Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 include/linux/iio/buffer-dma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
index 9182d4e..fbe053d 100644
--- a/include/linux/iio/buffer-dma.h
+++ b/include/linux/iio/buffer-dma.h
@@ -141,7 +141,7 @@ int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
 	char __user *user_buffer);
 size_t iio_dma_buffer_data_available(struct iio_buffer *buffer);
 int iio_dma_buffer_set_bytes_per_datum(struct iio_buffer *buffer, size_t bpd);
-int iio_dma_buffer_set_length(struct iio_buffer *buffer, int length);
+int iio_dma_buffer_set_length(struct iio_buffer *buffer, unsigned int length);
 int iio_dma_buffer_request_update(struct iio_buffer *buffer);
 
 int iio_dma_buffer_init(struct iio_dma_buffer_queue *queue,
-- 
1.8.3.1
