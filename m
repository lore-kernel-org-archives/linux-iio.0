Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-by2nam01on0049.outbound.protection.outlook.com ([104.47.34.49]:64096
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751057AbeFVI7y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 22 Jun 2018 04:59:54 -0400
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To: <linux-iio@vger.kernel.org>
CC: <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio:buffer: fix iio_dma_buffer_set_length() prototype mismatch
Date: Fri, 22 Jun 2018 11:59:42 +0300
Message-ID: <20180622085942.24253-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fixes commit c043ec1ca5ba ("iio:buffer: make length types match kfifo
types").
When the length parameter's type was updated in the
`iio_dma_buffer_set_length()` function, the prototype was omitted in the
`include/linux/iio/buffer-dma.h` header.

This causes a build error when running certain CFLAGS configurations that
are a bit more pedantic.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 include/linux/iio/buffer-dma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
index 767467d886de..67c75372b691 100644
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
2.17.1

