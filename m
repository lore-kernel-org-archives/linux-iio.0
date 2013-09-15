Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-015.synserver.de ([212.40.185.15]:1079 "EHLO
	smtp-out-015.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932344Ab3IOQuf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2013 12:50:35 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 24/27] staging:iio:ad799x: Use iio_push_to_buffers_with_timestamp()
Date: Sun, 15 Sep 2013 18:51:17 +0200
Message-Id: <1379263880-18405-24-git-send-email-lars@metafoo.de>
In-Reply-To: <1379263880-18405-1-git-send-email-lars@metafoo.de>
References: <1379263880-18405-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Makes the code a bit shorter and less ugly.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad799x_ring.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
index c2ebae1..0ff6c03 100644
--- a/drivers/staging/iio/adc/ad799x_ring.c
+++ b/drivers/staging/iio/adc/ad799x_ring.c
@@ -35,7 +35,6 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad799x_state *st = iio_priv(indio_dev);
-	s64 time_ns;
 	int b_sent;
 	u8 cmd;
 
@@ -65,13 +64,8 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 	if (b_sent < 0)
 		goto out;
 
-	time_ns = iio_get_time_ns();
-
-	if (indio_dev->scan_timestamp)
-		memcpy(st->rx_buf + indio_dev->scan_bytes - sizeof(s64),
-			&time_ns, sizeof(time_ns));
-
-	iio_push_to_buffers(indio_dev, st->rx_buf);
+	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_buf,
+			iio_get_time_ns());
 out:
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
1.8.0

