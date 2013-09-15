Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-015.synserver.de ([212.40.185.15]:1070 "EHLO
	smtp-out-015.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757183Ab3IOQub (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2013 12:50:31 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 22/27] staging:iio:lis3l02dq: Use iio_push_to_buffers_with_timestamp()
Date: Sun, 15 Sep 2013 18:51:15 +0200
Message-Id: <1379263880-18405-22-git-send-email-lars@metafoo.de>
In-Reply-To: <1379263880-18405-1-git-send-email-lars@metafoo.de>
References: <1379263880-18405-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Makes the code a bit shorter and less ugly.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/accel/lis3l02dq_ring.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 36dcc7e..aae86dd 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -146,11 +146,7 @@ static irqreturn_t lis3l02dq_trigger_handler(int irq, void *p)
 	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
 		len = lis3l02dq_get_buffer_element(indio_dev, data);
 
-	  /* Guaranteed to be aligned with 8 byte boundary */
-	if (indio_dev->scan_timestamp)
-		*(s64 *)((u8 *)data + ALIGN(len, sizeof(s64)))
-			= pf->timestamp;
-	iio_push_to_buffers(indio_dev, data);
+	iio_push_to_buffers_with_timestamp(indio_dev, data, pf->timestamp);
 
 	kfree(data);
 done:
-- 
1.8.0

