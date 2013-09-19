Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/24] iio:ad_sigma_delta: Use iio_push_to_buffers_with_timestamp()
Date: Thu, 19 Sep 2013 14:59:45 +0200
Message-Id: <1379595601-26448-8-git-send-email-lars@metafoo.de>
In-Reply-To: <1379595601-26448-1-git-send-email-lars@metafoo.de>
References: <1379595601-26448-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Makes the code a bit shorter and less ugly.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad_sigma_delta.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 78d276f..2b59112 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -368,10 +368,6 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 
 	memset(data, 0x00, 16);
 
-	/* Guaranteed to be aligned with 8 byte boundary */
-	if (indio_dev->scan_timestamp)
-		((s64 *)data)[1] = pf->timestamp;
-
 	reg_size = indio_dev->channels[0].scan_type.realbits +
 			indio_dev->channels[0].scan_type.shift;
 	reg_size = DIV_ROUND_UP(reg_size, 8);
@@ -391,7 +387,7 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 		break;
 	}
 
-	iio_push_to_buffers(indio_dev, data);
+	iio_push_to_buffers_with_timestamp(indio_dev, data, pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 	sigma_delta->irq_dis = false;
-- 
1.8.0
