Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-015.synserver.de ([212.40.185.15]:1039 "EHLO
	smtp-out-015.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932188Ab3IOQuE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2013 12:50:04 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 11/27] iio:ad_sigma_delta: Use iio_push_to_buffers_with_timestamp()
Date: Sun, 15 Sep 2013 18:51:04 +0200
Message-Id: <1379263880-18405-11-git-send-email-lars@metafoo.de>
In-Reply-To: <1379263880-18405-1-git-send-email-lars@metafoo.de>
References: <1379263880-18405-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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

