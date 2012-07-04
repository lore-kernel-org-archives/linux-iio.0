Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 06/11] staging:iio:ad7887: Do not return error code in interrupt handler
Date: Wed,  4 Jul 2012 18:09:28 +0200
Message-Id: <1341418173-3217-6-git-send-email-lars@metafoo.de>
In-Reply-To: <1341418173-3217-1-git-send-email-lars@metafoo.de>
References: <1341418173-3217-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The interrupt handler should only ever return one of the three irqreturn_t
constants and not an error code. Also make sure to always call
iio_trigger_notify_done before leaving the trigger handler.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7887_ring.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7887_ring.c b/drivers/staging/iio/adc/ad7887_ring.c
index 1c406da..c76fdb5 100644
--- a/drivers/staging/iio/adc/ad7887_ring.c
+++ b/drivers/staging/iio/adc/ad7887_ring.c
@@ -82,7 +82,7 @@ static irqreturn_t ad7887_trigger_handler(int irq, void *p)
 
 	buf = kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (buf == NULL)
-		return -ENOMEM;
+		goto done;
 
 	b_sent = spi_sync(st->spi, st->ring_msg);
 	if (b_sent)
-- 
1.7.10
