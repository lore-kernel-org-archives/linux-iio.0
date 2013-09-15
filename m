Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-015.synserver.de ([212.40.185.15]:1052 "EHLO
	smtp-out-015.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757137Ab3IOQtz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2013 12:49:55 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 06/27] iio:ad7266: Use iio_push_to_buffers_with_timestamp()
Date: Sun, 15 Sep 2013 18:50:59 +0200
Message-Id: <1379263880-18405-6-git-send-email-lars@metafoo.de>
In-Reply-To: <1379263880-18405-1-git-send-email-lars@metafoo.de>
References: <1379263880-18405-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Makes the code a bit shorter and less ugly.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad7266.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 5bfed23..e94ea65 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -96,9 +96,8 @@ static irqreturn_t ad7266_trigger_handler(int irq, void *p)
 
 	ret = spi_read(st->spi, st->data, 4);
 	if (ret == 0) {
-		if (indio_dev->scan_timestamp)
-			((s64 *)st->data)[1] = pf->timestamp;
-		iio_push_to_buffers(indio_dev, st->data);
+		iio_push_to_buffers_with_timestamp(indio_dev, st->data,
+			    pf->timestamp);
 	}
 
 	iio_trigger_notify_done(indio_dev->trig);
-- 
1.8.0

