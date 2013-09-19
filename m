Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Josh Wu <josh.wu@atmel.com>
Subject: [PATCH 09/24] iio:at91_adc: Use iio_push_to_buffers_with_timestamp()
Date: Thu, 19 Sep 2013 14:59:46 +0200
Message-Id: <1379595601-26448-9-git-send-email-lars@metafoo.de>
In-Reply-To: <1379595601-26448-1-git-send-email-lars@metafoo.de>
References: <1379595601-26448-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Makes the code a bit shorter and less ugly.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Josh Wu <josh.wu@atmel.com>
---
 drivers/iio/adc/at91_adc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 6da5ebb..ee5f51ca 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -83,13 +83,7 @@ static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
 		j++;
 	}
 
-	if (idev->scan_timestamp) {
-		s64 *timestamp = (s64 *)((u8 *)st->buffer +
-					ALIGN(j, sizeof(s64)));
-		*timestamp = pf->timestamp;
-	}
-
-	iio_push_to_buffers(idev, st->buffer);
+	iio_push_to_buffers_with_timestamp(idev, st->buffer, pf->timestamp);
 
 	iio_trigger_notify_done(idev->trig);
 
-- 
1.8.0
