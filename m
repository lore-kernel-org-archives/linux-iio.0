Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-015.synserver.de ([212.40.185.15]:1073 "EHLO
	smtp-out-015.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932132Ab3IOQt7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2013 12:49:59 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/27] iio:ad7476: Use iio_push_to_buffers_with_timestamp()
Date: Sun, 15 Sep 2013 18:51:01 +0200
Message-Id: <1379263880-18405-8-git-send-email-lars@metafoo.de>
In-Reply-To: <1379263880-18405-1-git-send-email-lars@metafoo.de>
References: <1379263880-18405-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Makes the code a bit shorter and less ugly.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad7476.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 6d2b1d8..8d808b9 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -64,19 +64,14 @@ static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad7476_state *st = iio_priv(indio_dev);
-	s64 time_ns;
 	int b_sent;
 
 	b_sent = spi_sync(st->spi, &st->msg);
 	if (b_sent < 0)
 		goto done;
 
-	time_ns = iio_get_time_ns();
-
-	if (indio_dev->scan_timestamp)
-		((s64 *)st->data)[1] = time_ns;
-
-	iio_push_to_buffers(indio_dev, st->data);
+	iio_push_to_buffers_with_timestamp(indio_dev, st->data,
+		iio_get_time_ns());
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
1.8.0

