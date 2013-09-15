Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-015.synserver.de ([212.40.185.15]:1069 "EHLO
	smtp-out-015.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932379Ab3IOQuk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2013 12:50:40 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 26/27] staging:iio:dummy: Use iio_push_to_buffers_with_timestamp()
Date: Sun, 15 Sep 2013 18:51:19 +0200
Message-Id: <1379263880-18405-26-git-send-email-lars@metafoo.de>
In-Reply-To: <1379263880-18405-1-git-send-email-lars@metafoo.de>
References: <1379263880-18405-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Makes the code a bit shorter and less ugly.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/iio_simple_dummy_buffer.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
index 3921865..09c93ac 100644
--- a/drivers/staging/iio/iio_simple_dummy_buffer.c
+++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
@@ -82,11 +82,8 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 			len += 2;
 		}
 	}
-	/* Store the timestamp at an 8 byte aligned offset */
-	if (indio_dev->scan_timestamp)
-		*(s64 *)((u8 *)data + ALIGN(len, sizeof(s64)))
-			= iio_get_time_ns();
-	iio_push_to_buffers(indio_dev, data);
+
+	iio_push_to_buffers_with_timestamp(indio_dev, data, iio_get_time_ns());
 
 	kfree(data);
 
-- 
1.8.0

