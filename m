Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-015.synserver.de ([212.40.185.15]:1062 "EHLO
	smtp-out-015.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757158Ab3IOQu0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2013 12:50:26 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 20/27] iio:tcs3472: Use iio_push_to_buffers_with_timestamp()
Date: Sun, 15 Sep 2013 18:51:13 +0200
Message-Id: <1379263880-18405-20-git-send-email-lars@metafoo.de>
In-Reply-To: <1379263880-18405-1-git-send-email-lars@metafoo.de>
References: <1379263880-18405-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Makes the code a bit shorter and less ugly.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/light/tcs3472.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index 7bf2969..0bc15cf 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -192,10 +192,8 @@ static irqreturn_t tcs3472_trigger_handler(int irq, void *p)
 		len += 2;
 	}
 
-	if (indio_dev->scan_timestamp)
-		*(s64 *)((u8 *)data->buffer + ALIGN(len, sizeof(s64)))
-			= iio_get_time_ns();
-	iio_push_to_buffers(indio_dev, data->buffer);
+	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
+		iio_get_time_ns());
 
 done:
 	iio_trigger_notify_done(indio_dev->trig);
-- 
1.8.0

