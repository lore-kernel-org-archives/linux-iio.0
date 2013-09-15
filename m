Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-015.synserver.de ([212.40.185.15]:1098 "EHLO
	smtp-out-015.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932331Ab3IOQuX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2013 12:50:23 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 19/27] iio:adjd_s311: Use iio_push_to_buffers_with_timestamp()
Date: Sun, 15 Sep 2013 18:51:12 +0200
Message-Id: <1379263880-18405-19-git-send-email-lars@metafoo.de>
In-Reply-To: <1379263880-18405-1-git-send-email-lars@metafoo.de>
References: <1379263880-18405-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Makes the code a bit shorter and less ugly.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/light/adjd_s311.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
index c9c8b00..39f6392 100644
--- a/drivers/iio/light/adjd_s311.c
+++ b/drivers/iio/light/adjd_s311.c
@@ -138,10 +138,7 @@ static irqreturn_t adjd_s311_trigger_handler(int irq, void *p)
 		len += 2;
 	}
 
-	if (indio_dev->scan_timestamp)
-		*(s64 *)((u8 *)data->buffer + ALIGN(len, sizeof(s64)))
-			= time_ns;
-	iio_push_to_buffers(indio_dev, data->buffer);
+	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer, time_ns);
 
 done:
 	iio_trigger_notify_done(indio_dev->trig);
-- 
1.8.0

