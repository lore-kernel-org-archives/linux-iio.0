Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-015.synserver.de ([212.40.185.15]:1072 "EHLO
	smtp-out-015.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757130Ab3IOQuS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2013 12:50:18 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 13/27] iio:max1363: Use iio_push_to_buffers_with_timestamp()
Date: Sun, 15 Sep 2013 18:51:06 +0200
Message-Id: <1379263880-18405-13-git-send-email-lars@metafoo.de>
In-Reply-To: <1379263880-18405-1-git-send-email-lars@metafoo.de>
References: <1379263880-18405-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Makes the code a bit shorter and less ugly.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/max1363.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 4fb35d1..531a57b 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -1436,7 +1436,6 @@ static irqreturn_t max1363_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct max1363_state *st = iio_priv(indio_dev);
-	s64 time_ns;
 	__u8 *rxbuf;
 	int b_sent;
 	size_t d_size;
@@ -1470,11 +1469,7 @@ static irqreturn_t max1363_trigger_handler(int irq, void *p)
 	if (b_sent < 0)
 		goto done_free;
 
-	time_ns = iio_get_time_ns();
-
-	if (indio_dev->scan_timestamp)
-		memcpy(rxbuf + d_size - sizeof(s64), &time_ns, sizeof(time_ns));
-	iio_push_to_buffers(indio_dev, rxbuf);
+	iio_push_to_buffers_with_timestamp(indio_dev, rxbuf, iio_get_time_ns());
 
 done_free:
 	kfree(rxbuf);
-- 
1.8.0

