Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 23/24] staging:iio:dummy: Use iio_push_to_buffers_with_timestamp()
Date: Thu, 19 Sep 2013 15:00:00 +0200
Message-Id: <1379595601-26448-23-git-send-email-lars@metafoo.de>
In-Reply-To: <1379595601-26448-1-git-send-email-lars@metafoo.de>
References: <1379595601-26448-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

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
