Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 16/24] iio:adjd_s311: Use iio_push_to_buffers_with_timestamp()
Date: Thu, 19 Sep 2013 14:59:53 +0200
Message-Id: <1379595601-26448-16-git-send-email-lars@metafoo.de>
In-Reply-To: <1379595601-26448-1-git-send-email-lars@metafoo.de>
References: <1379595601-26448-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

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
