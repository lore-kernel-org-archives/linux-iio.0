Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 17/24] iio:tcs3472: Use iio_push_to_buffers_with_timestamp()
Date: Thu, 19 Sep 2013 14:59:54 +0200
Message-Id: <1379595601-26448-17-git-send-email-lars@metafoo.de>
In-Reply-To: <1379595601-26448-1-git-send-email-lars@metafoo.de>
References: <1379595601-26448-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

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
