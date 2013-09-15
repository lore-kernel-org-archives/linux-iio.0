Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-015.synserver.de ([212.40.185.15]:1058 "EHLO
	smtp-out-015.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757129Ab3IOQuR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2013 12:50:17 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Josh Wu <josh.wu@atmel.com>
Subject: [PATCH 12/27] iio:at91_adc: Use iio_push_to_buffers_with_timestamp()
Date: Sun, 15 Sep 2013 18:51:05 +0200
Message-Id: <1379263880-18405-12-git-send-email-lars@metafoo.de>
In-Reply-To: <1379263880-18405-1-git-send-email-lars@metafoo.de>
References: <1379263880-18405-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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

