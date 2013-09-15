Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-015.synserver.de ([212.40.185.15]:1086 "EHLO
	smtp-out-015.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932132Ab3IOQuB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2013 12:50:01 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 09/27] iio:ad7887: Use iio_push_to_buffers_with_timestamp()
Date: Sun, 15 Sep 2013 18:51:02 +0200
Message-Id: <1379263880-18405-9-git-send-email-lars@metafoo.de>
In-Reply-To: <1379263880-18405-1-git-send-email-lars@metafoo.de>
References: <1379263880-18405-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Makes the code a bit shorter and less ugly.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad7887.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index 9dd077b..faedd0e 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -121,20 +121,14 @@ static irqreturn_t ad7887_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad7887_state *st = iio_priv(indio_dev);
-	s64 time_ns;
 	int b_sent;
 
 	b_sent = spi_sync(st->spi, st->ring_msg);
 	if (b_sent)
 		goto done;
 
-	time_ns = iio_get_time_ns();
-
-	if (indio_dev->scan_timestamp)
-		memcpy(st->data + indio_dev->scan_bytes - sizeof(s64),
-		       &time_ns, sizeof(time_ns));
-
-	iio_push_to_buffers(indio_dev, st->data);
+	iio_push_to_buffers_with_timestamp(indio_dev, st->data,
+		iio_get_time_ns());
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
1.8.0

