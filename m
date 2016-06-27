Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 203-59-230-133.perm.iinet.net.au ([203.59.230.133]:48482 "EHLO
	preid-centos7.electromag.com.au" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751601AbcF0D1Z (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2016 23:27:25 -0400
From: Phil Reid <preid@electromag.com.au>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Cc: Phil Reid <preid@electromag.com.au>
Subject: [PATCH 1/1] iio: buffer-dma: Use ARRAY_SIZE in for loop range
Date: Mon, 27 Jun 2016 11:17:56 +0800
Message-Id: <1466997476-36746-1-git-send-email-preid@electromag.com.au>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use the ARRAY_SIZE macro in the for loops that access queue->fileio.blocks.
Macro is already used in a couple of places where this access occurs,
but range was hardcoded in these locations.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/iio/buffer/industrialio-buffer-dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
index 212cbed..dd99d27 100644
--- a/drivers/iio/buffer/industrialio-buffer-dma.c
+++ b/drivers/iio/buffer/industrialio-buffer-dma.c
@@ -305,7 +305,7 @@ int iio_dma_buffer_request_update(struct iio_buffer *buffer)
 	queue->fileio.active_block = NULL;
 
 	spin_lock_irq(&queue->list_lock);
-	for (i = 0; i < 2; i++) {
+	for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
 		block = queue->fileio.blocks[i];
 
 		/* If we can't re-use it free it */
@@ -323,7 +323,7 @@ int iio_dma_buffer_request_update(struct iio_buffer *buffer)
 
 	INIT_LIST_HEAD(&queue->incoming);
 
-	for (i = 0; i < 2; i++) {
+	for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
 		if (queue->fileio.blocks[i]) {
 			block = queue->fileio.blocks[i];
 			if (block->state == IIO_BLOCK_STATE_DEAD) {
-- 
1.8.3.1

